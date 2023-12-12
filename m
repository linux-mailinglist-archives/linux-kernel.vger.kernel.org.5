Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA2F80E0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 02:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345675AbjLLBci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 20:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjLLBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 20:32:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C8D0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 17:32:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E94C433C8;
        Tue, 12 Dec 2023 01:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702344762;
        bh=tfmnfIzqfd8K9pO4T3k+FXSDPI48YQdPajaOc4mZYOM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pi/RE/IAREhYnD7gXka+dyEpLxeQxX+q43VxjFaNNsRun0J565DUGN5bldf5WRXVk
         mhgsoTlIjYBfsjwm9y0h3xn5XnBUpPyoJdfFAMPsDWcu8GeX1XQQ81PjN7I2hh1yXw
         Vb6wE6MYy4xSLDq0cy/xSCxtDFaQD4eRBtcErySv895vpu/xz2ld7J7D2p+ngdTxmT
         u4i+bFTsSaZKhFooUXzk2QWtk6h6oN5e7onOdSEJf9pRv6TwzNnnKrKWWHDzSvtS2Y
         6d2+t08fkY9dK1e2ZdHIfbIxzyTx9Qcjh86Ra47ViRNfJIDNlDqwU8az4Cig4Mqo4B
         09CcfdUXM0ZTA==
Message-ID: <91160032-704c-480f-8a09-c61ac7be46bd@kernel.org>
Date:   Tue, 12 Dec 2023 09:32:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: unify the error handling of f2fs_is_valid_blkaddr
Content-Language: en-US
To:     Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
        ke.wang@unisoc.com
References: <1701409331-1519-1-git-send-email-zhiguo.niu@unisoc.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <1701409331-1519-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/1 13:42, Zhiguo Niu wrote:
> unify the error handling of f2fs_is_valid_blkaddr and remove some
> redundant codes in f2fs_cache_compressed_page.

What about moving f2fs_handle_error(ERROR_INVALID_BLKADDR) into
f2fs_is_valid_blkaddr() for cleanup?

Thanks,

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>   fs/f2fs/checkpoint.c   |  6 +++++-
>   fs/f2fs/compress.c     |  8 +++-----
>   fs/f2fs/data.c         |  3 ++-
>   fs/f2fs/extent_cache.c |  7 ++++---
>   fs/f2fs/f2fs.h         |  6 ++++--
>   fs/f2fs/file.c         | 10 +++++++---
>   fs/f2fs/node.c         |  7 +++++--
>   fs/f2fs/recovery.c     | 15 +++++++++++----
>   8 files changed, 41 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b0597a5..47a1335 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -158,6 +158,7 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>   		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
>   			 blkaddr, exist);
>   		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		dump_stack();
>   		return exist;
>   	}
>   
> @@ -256,8 +257,11 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
>   	blk_start_plug(&plug);
>   	for (; nrpages-- > 0; blkno++) {
>   
> -		if (!f2fs_is_valid_blkaddr(sbi, blkno, type))
> +		if (!f2fs_is_valid_blkaddr(sbi, blkno, type)) {
> +			err = -EFSCORRUPTED;
> +			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto out;
> +		}
>   
>   		switch (type) {
>   		case META_NAT:
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 36e5dab..15d5035 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1853,8 +1853,10 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>   	if (!test_opt(sbi, COMPRESS_CACHE))
>   		return;
>   
> -	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
> +	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ)) {
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   		return;
> +	}
>   
>   	if (!f2fs_available_free_memory(sbi, COMPRESS_PAGE))
>   		return;
> @@ -1878,12 +1880,8 @@ void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi, struct page *page,
>   
>   	set_page_private_data(cpage, ino);
>   
> -	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE_READ))
> -		goto out;
> -
>   	memcpy(page_address(cpage), page_address(page), PAGE_SIZE);
>   	SetPageUptodate(cpage);
> -out:
>   	f2fs_put_page(cpage, 1);
>   }
>   
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 4e42b5f..e1a37ea 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2309,7 +2309,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>   			break;
>   
>   		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
> -			ret = -EFAULT;
> +			ret = -EFSCORRUPTED;
> +			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto out_put_dnode;
>   		}
>   		cc->nr_cpages++;
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index ad8dfac7..33e5632 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -43,7 +43,7 @@ bool sanity_check_extent_cache(struct inode *inode)
>   	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>   	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>   					DATA_GENERIC_ENHANCE)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>   			  __func__, inode->i_ino,
>   			  ei->blk, ei->fofs, ei->len);
> @@ -857,8 +857,9 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>   
>   	if (__is_valid_data_blkaddr(blkaddr) &&
>   	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> -		f2fs_bug_on(sbi, 1);
> -		return -EINVAL;
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +		return -EFSCORRUPTED;
> +
>   	}
>   out:
>   	/*
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9043ced..a4b8d86 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3454,13 +3454,16 @@ static inline int get_inline_xattr_addrs(struct inode *inode)
>   
>   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   					block_t blkaddr, int type);
> +void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
> +
>   static inline void verify_blkaddr(struct f2fs_sb_info *sbi,
>   					block_t blkaddr, int type)
>   {
>   	if (!f2fs_is_valid_blkaddr(sbi, blkaddr, type)) {
>   		f2fs_err(sbi, "invalid blkaddr: %u, type: %d, run fsck to fix.",
>   			 blkaddr, type);
> -		f2fs_bug_on(sbi, 1);
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +
>   	}
>   }
>   
> @@ -3587,7 +3590,6 @@ static inline int f2fs_add_link(struct dentry *dentry, struct inode *inode)
>   void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag);
>   void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
>   							bool irq_context);
> -void f2fs_handle_error(struct f2fs_sb_info *sbi, unsigned char error);
>   void f2fs_handle_error_async(struct f2fs_sb_info *sbi, unsigned char error);
>   int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover);
>   int f2fs_sync_fs(struct super_block *sb, int sync);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e503635..5a7dd87 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -416,7 +416,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>   	pgoff_t pgofs, end_offset;
>   	loff_t data_ofs = offset;
>   	loff_t isize;
> -	int err = 0;
> +	int err = -ENXIO;
>   
>   	inode_lock(inode);
>   
> @@ -466,6 +466,8 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>   				!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
>   					blkaddr, DATA_GENERIC_ENHANCE)) {
>   				f2fs_put_dnode(&dn);
> +				err = -EFSCORRUPTED;
> +				f2fs_handle_error(F2FS_I_SB(inode), ERROR_INVALID_BLKADDR);
>   				goto fail;
>   			}
>   
> @@ -487,7 +489,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
>   	return vfs_setpos(file, data_ofs, maxbytes);
>   fail:
>   	inode_unlock(inode);
> -	return -ENXIO;
> +	return err;
>   }
>   
>   static loff_t f2fs_llseek(struct file *file, loff_t offset, int whence)
> @@ -593,8 +595,10 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>   
>   		if (__is_valid_data_blkaddr(blkaddr)) {
>   			if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))
> +					DATA_GENERIC_ENHANCE)) {
> +				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   				continue;
> +			}
>   			if (compressed_cluster)
>   				valid_blocks++;
>   		}
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 6c7f6a6..e50a093 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -611,8 +611,10 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   cache:
>   	blkaddr = le32_to_cpu(ne.block_addr);
>   	if (__is_valid_data_blkaddr(blkaddr) &&
> -		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> -		return -EFAULT;
> +		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +		return -EFSCORRUPTED;
> +	}
>   
>   	/* cache nat entry */
>   	cache_nat_entry(sbi, nid, &ne);
> @@ -1652,6 +1654,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>   	if (__is_valid_data_blkaddr(ni.blk_addr) &&
>   		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr,
>   					DATA_GENERIC_ENHANCE)) {
> +		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   		f2fs_up_read(&sbi->node_write);
>   		goto redirty_out;
>   	}
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index b56d0f1..1244b8e 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -374,7 +374,8 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
>   	for (i = 0; i < 2; i++) {
>   		if (!f2fs_is_valid_blkaddr(sbi, *blkaddr_fast, META_POR)) {
>   			*is_detecting = false;
> -			return 0;
> +			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +			return -EFSCORRUPTED;
>   		}
>   
>   		page = f2fs_get_tmp_page(sbi, *blkaddr_fast);
> @@ -399,6 +400,7 @@ static int sanity_check_node_chain(struct f2fs_sb_info *sbi, block_t blkaddr,
>   	if (*blkaddr_fast == blkaddr) {
>   		f2fs_notice(sbi, "%s: Detect looped node chain on blkaddr:%u."
>   				" Run fsck to fix it.", __func__, blkaddr);
> +		set_sbi_flag(sbi, SBI_NEED_FSCK);
>   		return -EINVAL;
>   	}
>   	return 0;
> @@ -421,8 +423,10 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
>   	while (1) {
>   		struct fsync_inode_entry *entry;
>   
> -		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> -			return 0;
> +		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR)) {
> +			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +			return -EFSCORRUPTED;
> +		}
>   
>   		page = f2fs_get_tmp_page(sbi, blkaddr);
>   		if (IS_ERR(page)) {
> @@ -786,8 +790,11 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
>   	while (1) {
>   		struct fsync_inode_entry *entry;
>   
> -		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> +		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR)) {
> +			err = -EFSCORRUPTED;
> +			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			break;
> +		}
>   
>   		page = f2fs_get_tmp_page(sbi, blkaddr);
>   		if (IS_ERR(page)) {
