Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D39E7CA46B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJPJmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJPJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:41:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942397
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 02:41:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A7AD921C3A;
        Mon, 16 Oct 2023 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697449315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PC+bRfevWstN79Ckr6XHfHWqzbxvNBajFVpvRSDWr9c=;
        b=j0RLa4+/w2ZgVfhXnwD7fTBtct1H4ZUSAPtTS8Un7hSY/EMO4h/oUv7+RGekTdx88X2uDJ
        uCemOsz1lOiiEkJ8wtmQlnCjIUhcH4Tn5uzFdMX9GRqZpZ3RlrlABSWe2CPSyov/kG/85j
        vi3SvZIXzYJLaX57C18dBdlmw9FAry0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697449315;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PC+bRfevWstN79Ckr6XHfHWqzbxvNBajFVpvRSDWr9c=;
        b=mO+QcBdSMZDvYeMxRQrFctX3qX7gJBULmS7Xm60iLsAA5tlweOGCqdw0ncPMlzu6sO0Vgb
        fPU28jIc2SM28mAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AC8D133B7;
        Mon, 16 Oct 2023 09:41:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0tW+JWMFLWXXOgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 16 Oct 2023 09:41:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2DDC7A0657; Mon, 16 Oct 2023 11:41:55 +0200 (CEST)
Date:   Mon, 16 Oct 2023 11:41:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Osama Muhammad <osmtendev@gmail.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com
Subject: Re: [PATCH] UBSAN: array-index-out-of-bounds in udf_process_sequence
Message-ID: <20231016094155.lacz5rps5ztdcudd@quack3>
References: <20231013190929.17246-1-osmtendev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013190929.17246-1-osmtendev@gmail.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[abb7222a58e4ebc930ad];
         MIME_GOOD(-0.10)[text/plain];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         NEURAL_SPAM_LONG(3.00)[1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-10-23 00:09:29, Osama Muhammad wrote:
> Syzkaller reported the following issue:
> 
> UBSAN: array-index-out-of-bounds in fs/udf/super.c:1365:9
> index 4 is out of range for type '__le32[4]' (aka 'unsigned int[4]')
> CPU: 0 PID: 6060 Comm: syz-executor319 Not tainted 6.5.0-rc6-syzkaller-00253-g9e6c269de404 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
>  udf_load_sparable_map fs/udf/super.c:1365 [inline]
>  udf_load_logicalvol fs/udf/super.c:1457 [inline]
>  udf_process_sequence+0x300d/0x4e70 fs/udf/super.c:1773
>  udf_load_sequence fs/udf/super.c:1820 [inline]
>  udf_check_anchor_block+0x2a6/0x550 fs/udf/super.c:1855
>  udf_scan_anchors fs/udf/super.c:1888 [inline]
>  udf_load_vrs+0x5ca/0x1100 fs/udf/super.c:1969
>  udf_fill_super+0x95d/0x23a0 fs/udf/super.c:2147
>  mount_bdev+0x276/0x3b0 fs/super.c:1391
>  legacy_get_tree+0xef/0x190 fs/fs_context.c:611
>  vfs_get_tree+0x8c/0x270 fs/super.c:1519
>  do_new_mount+0x28f/0xae0 fs/namespace.c:3335
>  do_mount fs/namespace.c:3675 [inline]
>  __do_sys_mount fs/namespace.c:3884 [inline]
>  __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3861
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f363cae1c8a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 3e 07 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe6eac67a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f363cae1c8a
> RDX: 0000000020000100 RSI: 0000000020000340 RDI: 00007ffe6eac6800
> RBP: 00007ffe6eac6840 R08: 00007ffe6eac6840 R09: 0000000000000c35
> R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020000340
> R13: 0000000020000100 R14: 0000000000000c3b R15: 0000000020020500
>  </TASK>
> 
> The issue is caused when the value of i becomes equal or more than 4 which is
> the size of array. In the code the condition checks the value of
> spm->numSparingTables. syzbot was able to make spm->numSparingTables
> value 4 which is cauing this error. The patch adds one more condition
> to check the value of i should be less than 4.
> 
> Reported-and-tested-by: syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
> Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

But as you can see we test:

        if (spm->numSparingTables > 4) {

just before the loop. So this error means that syzbot has been modifying
the filesystem image while is was in use. That is invalid syzbot program as
there is no way how we could fix all such bugs (effectively it is
equivalent to corrupting memory). So I'm not going to apply your patch,
sorry. I already have patches that forbid writing to filesystem image that
is mounted but it will take a while to get them merged...

								Honza

> ---
>  fs/udf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 928a04d9d9e0..8c8731c3f8d9 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -1361,7 +1361,7 @@ static int udf_load_sparable_map(struct super_block *sb,
>  		return -EIO;
>  	}
>  
> -	for (i = 0; i < spm->numSparingTables; i++) {
> +	for (i = 0; i < spm->numSparingTables && i < 4; i++) {
>  		loc = le32_to_cpu(spm->locSparingTable[i]);
>  		bh = udf_read_tagged(sb, loc, loc, &ident);
>  		if (!bh)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
