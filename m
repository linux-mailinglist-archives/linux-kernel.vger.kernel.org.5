Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE880DA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjLKTLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjLKTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:11:19 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB17BD;
        Mon, 11 Dec 2023 11:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/Rtkzcsv8kzgc8T4PwLaUwempDK+53xq2O37eAIju6o=; b=Jks55oU7rWGh8Gjb3z9pm/ASZV
        splnAzk8Kuua7BffcEhEnk1XNim2qW0j/aVpBCtraGU1+XKNhizBpMcqNWeTn/Akv+rRO0aILl3fV
        jqkaBuffi3yv4Xe27LgcVPgofKyt0Pl8g7ztVmt1AJ2BJa7mKz0HsMWb4XRVZItxQIHvJvCcB5nge
        qMqx6XP2dL5d8X8scShWKyAucys69reFq7/J7AU+2r5vrcoWWxzL4LrdOF/P1l43Gux8eHuEQMEmh
        04BjRqlSyevf9neK5+yeJckBIMUAODRpq52kHQKjicaKU8fx9bTgiEQq23zfz4Q+6J5/ucGEW1Lvh
        6/phlXkA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rClgT-00AzWG-0e;
        Mon, 11 Dec 2023 19:11:17 +0000
Date:   Mon, 11 Dec 2023 19:11:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Message-ID: <20231211191117.GD1674809@ZenIV>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170224845504.12910.16483736613606611138@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 09:47:35AM +1100, NeilBrown wrote:

> Similarly would could wrap __fput_sync() is a more friendly name, but
> that would be better if we actually renamed the function.
> 
>   void fput_now(struct file *f)
>   {
>       __fput_sync(f);
>   }

It is unfriendly *precisely* because it should not be used without
a very good reason.

It may be the last opened file keeping a lazy-umounted mount alive.
It may be taking pretty much any locks, or eating a lot of stack
space.

It really isn't a general-purpose API; any "more friendly name"
is going to be NAKed for that reason alone.

Al, very much tempted to send a patch renaming that sucker to
__fput_dont_use_that_unless_you_really_know_what_you_are_doing().
