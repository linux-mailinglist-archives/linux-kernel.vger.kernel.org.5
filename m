Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137517FF803
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345576AbjK3RS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3RS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:18:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B1DE6;
        Thu, 30 Nov 2023 09:18:33 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 98BF41FCFC;
        Thu, 30 Nov 2023 17:18:31 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C19C138E5;
        Thu, 30 Nov 2023 17:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id XF0JHufDaGW4HwAAn2gu4w
        (envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 17:18:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 50FF1A07E0; Thu, 30 Nov 2023 18:18:30 +0100 (CET)
Date:   Thu, 30 Nov 2023 18:18:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, djwong@kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
        stable@kernel.org
Subject: Re: [PATCH] ext4: prevent the normalized size from exceeding
 EXT_MAX_BLOCKS
Message-ID: <20231130171830.2s2bl3p34conwoln@quack3>
References: <20231127063313.3734294-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127063313.3734294-1-libaokun1@huawei.com>
X-Spamd-Bar: ++++++++++++
X-Spam-Score: 12.23
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz;
        dmarc=none
X-Rspamd-Queue-Id: 98BF41FCFC
X-Spamd-Result: default: False [12.23 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_SPF_SOFTFAIL(4.60)[~all];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(1.20)[suse.cz];
         NEURAL_SPAM_SHORT(1.84)[0.613];
         NEURAL_SPAM_LONG(3.50)[1.000];
         RCPT_COUNT_TWELVE(0.00)[12];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         MID_RHS_NOT_FQDN(0.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,kernel.org,huawei.com];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 27-11-23 14:33:13, Baokun Li wrote:
> For files with logical blocks close to EXT_MAX_BLOCKS, the file size
> predicted in ext4_mb_normalize_request() may exceed EXT_MAX_BLOCKS.
> This can cause some blocks to be preallocated that will not be used.
> And after [Fixes], the following issue may be triggered:
> 
> =========================================================
>  kernel BUG at fs/ext4/mballoc.c:4653!
>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>  CPU: 1 PID: 2357 Comm: xfs_io 6.7.0-rc2-00195-g0f5cc96c367f
>  Hardware name: linux,dummy-virt (DT)
>  pc : ext4_mb_use_inode_pa+0x148/0x208
>  lr : ext4_mb_use_inode_pa+0x98/0x208
>  Call trace:
>   ext4_mb_use_inode_pa+0x148/0x208
>   ext4_mb_new_inode_pa+0x240/0x4a8
>   ext4_mb_use_best_found+0x1d4/0x208
>   ext4_mb_try_best_found+0xc8/0x110
>   ext4_mb_regular_allocator+0x11c/0xf48
>   ext4_mb_new_blocks+0x790/0xaa8
>   ext4_ext_map_blocks+0x7cc/0xd20
>   ext4_map_blocks+0x170/0x600
>   ext4_iomap_begin+0x1c0/0x348
> =========================================================
> 
> Here is a calculation when adjusting ac_b_ex in ext4_mb_new_inode_pa():
> 
> 	ex.fe_logical = orig_goal_end - EXT4_C2B(sbi, ex.fe_len);
> 	if (ac->ac_o_ex.fe_logical >= ex.fe_logical)
> 		goto adjust_bex;
> 
> The problem is that when orig_goal_end is subtracted from ac_b_ex.fe_len
> it is still greater than EXT_MAX_BLOCKS, which causes ex.fe_logical to
> overflow to a very small value, which ultimately triggers a BUG_ON in
> ext4_mb_new_inode_pa() because pa->pa_free < len.
> 
> The last logical block of an actual write request does not exceed
> EXT_MAX_BLOCKS, so in ext4_mb_normalize_request() also avoids normalizing
> the last logical block to exceed EXT_MAX_BLOCKS to avoid the above issue.
> 
> The test case in [Link] can reproduce the above issue with 64k block size.
> 
> Link: https://patchwork.kernel.org/project/fstests/list/?series=804003
> Cc: stable@kernel.org # 6.4
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Yeah, good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 454d5612641e..d72b5e3c92ec 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4478,6 +4478,10 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	start = max(start, rounddown(ac->ac_o_ex.fe_logical,
>  			(ext4_lblk_t)EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
>  
> +	/* avoid unnecessary preallocation that may trigger assertions */
> +	if (start + size > EXT_MAX_BLOCKS)
> +		size = EXT_MAX_BLOCKS - start;
> +
>  	/* don't cover already allocated blocks in selected range */
>  	if (ar->pleft && start <= ar->lleft) {
>  		size -= ar->lleft + 1 - start;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
