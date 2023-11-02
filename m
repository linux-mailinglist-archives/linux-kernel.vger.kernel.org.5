Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657C37DF0D8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 12:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347204AbjKBLFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 07:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346098AbjKBLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 07:05:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960DE130
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 04:05:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F50A21883;
        Thu,  2 Nov 2023 11:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698923111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HqfrYEfpnvk3lKMsQO5FTlr9/VTsNu0YPoHtk30ddA=;
        b=io1rDEHwf1VpUjj2icgM3aqLmZYLaSd37qRIrCNMVPLPp58wvJUmh9kdgAhyIuOi7cUacd
        0knuhR+dTjmKhNJmFaKSQwCXhhfrGnBYfKovXqw65r+kNQWcar5+lTzJgedV95iY+fcxGI
        WIakC16fqDWfFxNNaBDWaN9vWPjCbMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698923111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HqfrYEfpnvk3lKMsQO5FTlr9/VTsNu0YPoHtk30ddA=;
        b=U+VKwuZsxXqIYQ/6iefpyvimnAWpF9XqtcM21FO/3uPiqlAez06GvwWGMAST5sNaHXKEnR
        KdDyXIzcwG09YDBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40F4613584;
        Thu,  2 Nov 2023 11:05:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pPjSD2eCQ2XCHQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 02 Nov 2023 11:05:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C33C8A06E3; Thu,  2 Nov 2023 12:05:10 +0100 (CET)
Date:   Thu, 2 Nov 2023 12:05:10 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jan Kara <jack@suse.cz>, jack@suse.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@google.com, zsm@google.com,
        syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: udf: super.c: Fix a use-after-free issue in
 udf_finalize_lvid
Message-ID: <20231102110510.m4niipobiu7j3rup@quack3>
References: <20231030202418.847494-1-shreeya.patel@collabora.com>
 <20231031113754.vwrj3pubynb6bnef@quack3>
 <30b49da5-fc1a-3a18-7eeb-d5bbb08b3e9c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30b49da5-fc1a-3a18-7eeb-d5bbb08b3e9c@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02-11-23 15:34:52, Shreeya Patel wrote:
> On 31/10/23 17:07, Jan Kara wrote:
> > On Tue 31-10-23 01:54:18, Shreeya Patel wrote:
> > > Add some error handling cases in udf_sb_lvidiu() and redefine
> > > the descCRCLength in order to avoid use-after-free issue in
> > > udf_finalize_lvid.
> > > 
> > > Following use-after-free issue was reported by syzbot :-
> > > 
> > > https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
> > > 
> > > BUG: KASAN: use-after-free in crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
> > > Read of size 1 at addr ffff88816fba0000 by task syz-executor.0/32133
> > > 
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> > > Call Trace:
> > > <TASK>
> > > __dump_stack lib/dump_stack.c:88 [inline]
> > > dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
> > > print_address_description mm/kasan/report.c:284 [inline]
> > > print_report+0x13c/0x462 mm/kasan/report.c:395
> > > kasan_report+0xa9/0xd5 mm/kasan/report.c:495
> > > crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
> > > udf_finalize_lvid+0x111/0x23b fs/udf/super.c:2022
> > > udf_sync_fs+0xba/0x123 fs/udf/super.c:2378
> > > sync_filesystem+0xe8/0x216 fs/sync.c:56
> > > generic_shutdown_super+0x6b/0x334 fs/super.c:474
> > > kill_block_super+0x79/0xd6 fs/super.c:1459
> > > deactivate_locked_super+0xa0/0x101 fs/super.c:332
> > > cleanup_mnt+0x2de/0x361 fs/namespace.c:1192
> > > task_work_run+0x22b/0x2d4 kernel/task_work.c:179
> > > resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> > > exit_to_user_mode_loop+0xc4/0xd3 kernel/entry/common.c:171
> > > exit_to_user_mode_prepare+0xb4/0x115 kernel/entry/common.c:204
> > > __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> > > syscall_exit_to_user_mode+0xae/0x278 kernel/entry/common.c:297
> > > do_syscall_64+0x5d/0x93 arch/x86/entry/common.c:99
> > > entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > > RIP: 0033:0x7e8195fb6e17
> > > 
> > > Fixes: ebbd5e99f60a ("udf: factor out LVID finalization for reuse")
> > > Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
> > > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > Thanks for the patch but not every syzbot report is actually a bug. In this
> > case you can notice that udf_load_logicalvolint() is actually checking
> > validity of the Logical Volume Integrity Descriptor. The fact that later
> > udf_sb_lvidiu() call overflows the buffer size is caused by the fact that
> > syzbot overwrites the UDF filesystem while it is mounted and so the values
> > we checked are not the same as the value we later use. That is not a
> > problem we try to protect against (it is equivalent to corrupting memory).
> > I'm working on patches to so that syzbot can reasonably easily avoid
> > creating such invalid scenarios but so far they did not land. So I'm sorry
> > but I will not apply your fix.
> 
> Thanks for the information and it definitely makes sense to not let
> syzbot create such invalid scenarios. Maybe we can add some kind of
> filtering in syzbot for these kind of issues in future but I wonder how
> to even identify these reports from syzbot which is purposely trying to
> do some memory corruption. It seems hard to identify them without
> understanding what the reproducer is doing.  Maybe this is a question for
> the syzbot team.

I have discussed this with the syzbot team and as you noticed the problem
is it is very hard to detect the corruption scenario in an automated way.
What we plan to do (next round of patches submitted yesterday [1])

[1]

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
