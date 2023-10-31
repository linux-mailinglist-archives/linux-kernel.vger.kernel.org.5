Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8667DCBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343801AbjJaLiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343737AbjJaLh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:37:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8766991
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:37:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44BF921AAA;
        Tue, 31 Oct 2023 11:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698752275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfLI2Ea9iwLsMXt5JTOZAb47Iwb3cS2viegGU7EDkxA=;
        b=JML1AAISJiwqSEdEjAJQK85JfR2XnaXwtKeUUIpOL7nPOqCuW36VAmUdbhpZDwH1dxvcDO
        +1k7juVlFAbGwQwVEu928dpL2wdOJt2ZWplhf9AbUM8VUoSEJPU/uRV6ULZDMNq+EYUM63
        t9tWi1dXKaesC+fgHxodEYA7BI508K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698752275;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wfLI2Ea9iwLsMXt5JTOZAb47Iwb3cS2viegGU7EDkxA=;
        b=9nGafFpcugoAKbVTFtCANC7aGAp6LfVUC/404Ya4zSToFFvBUBJoRQblmcJ6KyiUdJ+otu
        HUaNFQuytPZFYKDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C875138EF;
        Tue, 31 Oct 2023 11:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fBgYChPnQGWZLwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 31 Oct 2023 11:37:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A6A25A06E5; Tue, 31 Oct 2023 12:37:54 +0100 (CET)
Date:   Tue, 31 Oct 2023 12:37:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org, kernel@collabora.com,
        groeck@google.com, zsm@google.com,
        syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs: udf: super.c: Fix a use-after-free issue in
 udf_finalize_lvid
Message-ID: <20231031113754.vwrj3pubynb6bnef@quack3>
References: <20231030202418.847494-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030202418.847494-1-shreeya.patel@collabora.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31-10-23 01:54:18, Shreeya Patel wrote:
> Add some error handling cases in udf_sb_lvidiu() and redefine
> the descCRCLength in order to avoid use-after-free issue in
> udf_finalize_lvid.
> 
> Following use-after-free issue was reported by syzbot :-
> 
> https://syzkaller.appspot.com/bug?extid=46073c22edd7f242c028
> 
> BUG: KASAN: use-after-free in crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
> Read of size 1 at addr ffff88816fba0000 by task syz-executor.0/32133
> 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
> print_address_description mm/kasan/report.c:284 [inline]
> print_report+0x13c/0x462 mm/kasan/report.c:395
> kasan_report+0xa9/0xd5 mm/kasan/report.c:495
> crc_itu_t+0x97/0xc8 lib/crc-itu-t.c:60
> udf_finalize_lvid+0x111/0x23b fs/udf/super.c:2022
> udf_sync_fs+0xba/0x123 fs/udf/super.c:2378
> sync_filesystem+0xe8/0x216 fs/sync.c:56
> generic_shutdown_super+0x6b/0x334 fs/super.c:474
> kill_block_super+0x79/0xd6 fs/super.c:1459
> deactivate_locked_super+0xa0/0x101 fs/super.c:332
> cleanup_mnt+0x2de/0x361 fs/namespace.c:1192
> task_work_run+0x22b/0x2d4 kernel/task_work.c:179
> resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
> exit_to_user_mode_loop+0xc4/0xd3 kernel/entry/common.c:171
> exit_to_user_mode_prepare+0xb4/0x115 kernel/entry/common.c:204
> __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
> syscall_exit_to_user_mode+0xae/0x278 kernel/entry/common.c:297
> do_syscall_64+0x5d/0x93 arch/x86/entry/common.c:99
> entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7e8195fb6e17
> 
> Fixes: ebbd5e99f60a ("udf: factor out LVID finalization for reuse")
> Reported-by: syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>

Thanks for the patch but not every syzbot report is actually a bug. In this
case you can notice that udf_load_logicalvolint() is actually checking
validity of the Logical Volume Integrity Descriptor. The fact that later
udf_sb_lvidiu() call overflows the buffer size is caused by the fact that
syzbot overwrites the UDF filesystem while it is mounted and so the values
we checked are not the same as the value we later use. That is not a
problem we try to protect against (it is equivalent to corrupting memory). 
I'm working on patches to so that syzbot can reasonably easily avoid
creating such invalid scenarios but so far they did not land. So I'm sorry
but I will not apply your fix.

								Honza


> ---
>  fs/udf/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 928a04d9d9e0..ca8f10eaa748 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -114,6 +114,10 @@ struct logicalVolIntegrityDescImpUse *udf_sb_lvidiu(struct super_block *sb)
>  	partnum = le32_to_cpu(lvid->numOfPartitions);
>  	/* The offset is to skip freeSpaceTable and sizeTable arrays */
>  	offset = partnum * 2 * sizeof(uint32_t);
> +	if (sb->s_blocksize < sizeof(*lvid) || (sb->s_blocksize - sizeof(*lvid)) <
> +	    (offset + sizeof(struct logicalVolIntegrityDescImpUse)))
> +		return NULL;
> +
>  	return (struct logicalVolIntegrityDescImpUse *)
>  					(((uint8_t *)(lvid + 1)) + offset);
>  }
> @@ -2337,6 +2341,8 @@ static int udf_sync_fs(struct super_block *sb, int wait)
>  		struct logicalVolIntegrityDesc *lvid;
>  
>  		lvid = (struct logicalVolIntegrityDesc *)bh->b_data;
> +		if ((le16_to_cpu(lvid->descTag.descCRCLength) + sizeof(struct tag)) > sb->s_blocksize)
> +			lvid->descTag.descCRCLength = cpu_to_le16(sb->s_blocksize - sizeof(struct tag));
>  		udf_finalize_lvid(lvid);
>  
>  		/*
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
