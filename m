Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3B7F790D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjKXQfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjKXQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:35:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E71733;
        Fri, 24 Nov 2023 08:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=2wxrylrSD098+RrYmJNUHBHYAaD0hX9xrQiFrNIZx9A=; t=1700843716; x=1702053316; 
        b=hLHEoSCOoqHqbVNYWJbpWQgyM9C6WSpdkLsif/4f3IbHjmyLNSo3HJIYe3nySZHnrV7abODJJ9S
        7mbadmcw+Pod1wlfEB9emf8ACmzWj/dXAofD8Fslmzy74JQ+Lvm3Q/qg6dJkfoWcr4O7JS84dSPR5
        yDRIPKGzx9lFMRGIcF9G6kzy70IG+EtC3AO7S91fgsjrz0uKwmpH2XKd0+2o7tjh6UA9q8orE+1Be
        igHeq6DqB9HN0rQmC7GAUB8WeD27nPEw2VGbjcbAtiRjF8SoE4G9r62TVwKTqtbZLaWzr32NZKCNv
        VImtt+mJ6vZzGandzS3sYkeHlIlGi/LtRWNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r6Z98-00000002fA8-2pL6;
        Fri, 24 Nov 2023 17:35:14 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 0/6] fixes for debugfs/wireless locking issue
Date:   Fri, 24 Nov 2023 17:25:23 +0100
Message-ID: <20231124162522.16344-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a locking issue in wireless where it takes a lock inside
a debugfs file handler that's also taken around the removal of
the debugfs file, and this causes a deadlock due to the proxy
object use. Fixing the debugfs removal is tricky because some
of the objects represented there fundamentally are deleted with
the lock held. Not taking the lock in the debugfs file is also
not really the right thing to do. Therefore, right now, the only
way to fix this would be to not have the debugfs files entirely,
but that isn't really helpful either.

Thus, here's a way to fix it that doesn't just remove the files.

The first patch is just a consistency thing in debugfs, right now
directory dentries don't have d_fsdata, normal file use the proxy
fops object, and automount uses the original autmount (function)
pointer, no proxy object. This is an issue if an automount dentry
were ever removed, which right now it isn't as far as I can tell,
but it still makes little sense, so fix it here by also allocating
an object for it, just not with real_fops making it a proxy, but
with the automount pointer inside.

The second patch annotates debugfs with lockdep to actually find
deadlock scenarios such as the one in wireless, indeed with that
and accessing one of the affected debugfs files, lockdep detects
the situation.

The third patch introduces a concept of 'cancellation', whereby a
debugfs file handler that is "long-running" may enter (and later
leave, of course) a cancellation section, where a function call
is made when the file is removed while the handler is running, and
the cancellation function can then abort the handling. This is
pretty generic so far.

The later patches (and I assume those would go through the wireless
tree) then fix the locking issue by declaring that the work that's
going to happen under lock is "long-running" per the above, and
setting up a cancellation. The way it works is that it actually
defers the real handling to a workqueue but then waits for it, but
that waiting can be aborted (and the work stopped) if the file is
removed before the work was able to run, thus fixing the deadlock.

I hope this is an acceptable compromise in terms of functionality
in debugfs vs. the user. It'd be possible to set up something of
the same sort in debugfs, but I feel the cancellation API is more
generic and thus more useful, and the actual details of what's in
the actual file handlers don't matter then.

johannes


