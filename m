Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2FC809A59
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573087AbjLHDa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbjLHDaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:30:25 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7E1716;
        Thu,  7 Dec 2023 19:30:30 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD241FD97;
        Fri,  8 Dec 2023 03:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702006229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G65Y4qEgiFs5r1auMT4tyTQhiN2SiYTb+GC96Qccm+g=;
        b=QqJJjPVi8L132GZQCf9Mjg4qHmcrXYlzYlU0DUuZ/CNjEeG/g/4jCnoDTq0VPA4h42/djF
        WA4ez4vqERGV49PtRqCLw1ob0Oc4JoAyuOgA6mvx/jTIRRvE6VQGb7blpiovuLYSRRVbRM
        /dXYFTepmmr13rL3so9HLP/GCV/557s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702006229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G65Y4qEgiFs5r1auMT4tyTQhiN2SiYTb+GC96Qccm+g=;
        b=NuiDxDxaPzIHywKsjWJ7egknyJgVFHbzTDAMaKPhLbLzE0V4XEebt5Rn6wlcw/fDbhoW4M
        UZVCk9lYJgtoGBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702006229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G65Y4qEgiFs5r1auMT4tyTQhiN2SiYTb+GC96Qccm+g=;
        b=QqJJjPVi8L132GZQCf9Mjg4qHmcrXYlzYlU0DUuZ/CNjEeG/g/4jCnoDTq0VPA4h42/djF
        WA4ez4vqERGV49PtRqCLw1ob0Oc4JoAyuOgA6mvx/jTIRRvE6VQGb7blpiovuLYSRRVbRM
        /dXYFTepmmr13rL3so9HLP/GCV/557s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702006229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G65Y4qEgiFs5r1auMT4tyTQhiN2SiYTb+GC96Qccm+g=;
        b=NuiDxDxaPzIHywKsjWJ7egknyJgVFHbzTDAMaKPhLbLzE0V4XEebt5Rn6wlcw/fDbhoW4M
        UZVCk9lYJgtoGBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A88E13725;
        Fri,  8 Dec 2023 03:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 9ogpN9CNcmXwMAAAD6G6ig
        (envelope-from <neilb@suse.de>); Fri, 08 Dec 2023 03:30:24 +0000
From:   NeilBrown <neilb@suse.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH 0/3] nfsd: fully close all files in the nfsd threads
Date:   Fri,  8 Dec 2023 14:27:25 +1100
Message-ID: <20231208033006.5546-1-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.70
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.983];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[40.26%]
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version of my patches to address a rare problem with nfsd
closing files faster than __fput() can complete the close in a different
thread.

This time I'm simply switching to __fput_sync().  I cannot see any
reason that this would be a problem, but if any else does and can show
me what I'm missing, I'd appreciate it.

Thanks,
NeilBrown


 [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 [PATCH 2/3] nfsd: Don't leave work of closing files to a work queue.
 [PATCH 3/3] VFS: don't export flush_delayed_fput().
