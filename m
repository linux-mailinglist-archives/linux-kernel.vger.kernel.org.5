Return-Path: <linux-kernel+bounces-43435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D648413D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC85A1C23817
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6086157E88;
	Mon, 29 Jan 2024 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEM2rPBR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DB16F08E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558039; cv=none; b=uAFBJ11VSW2TuckF2BtSej75FiY+QGauIx9CRzoNXwUVSz3IQCJ8mdfVhmusu016vD01UIMSx9GXtKMcloAXoWptCbdAHmvlxpL4LOw1XDrG/dAkCxfP0IBhZm8wo6Vu0bG80o9KmE5MBS7Ri2Yk+iORiAihsAdkddo2+qav6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558039; c=relaxed/simple;
	bh=npHC4i+lAx+mIv8vQ7YRcagptNHb6liBAAHMk099ZFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3eh3EsfHHEU5ZYScABV1yHDRIHRNlOsj1jam79gTPrkzbgdVdWDveFf54tbA5ZBf1abyc75cOAl/ZVfxP+8k8VdcdFM58/1T2kntpVecZTDdMWbBHAX10ccpEjUutTcCpurl49MCbHwAq9sgs68VfK6Wd3nIytYWuenxDGRzwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEM2rPBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C0AC43394;
	Mon, 29 Jan 2024 19:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558039;
	bh=npHC4i+lAx+mIv8vQ7YRcagptNHb6liBAAHMk099ZFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kEM2rPBRMHlp6yQv/h/ByzQBRDRU8Fm3i+n01lo6aJAhLBLzgQ5kiYEu+ZVa8eYMt
	 uzxZMKN7n4xAYCrDWom/OuuiNeTEIvm7FsgdsqfUDMHPWiEY/AYd78fOjWsvW9X5vO
	 mC/Nk1xkNd2yiVKq4oqarsiI8ywRLzOoUrbXQYWK4MycgJsxsiWFEXMpXs1TmM2evl
	 vwnnF6s090x4y79zk+DiUXYclwMai2MET0FDGNtPLIIIEvoWXPJ9jNHv1ZJvevO67o
	 rABOsy71fVMduHk8bWaWk7jO8NbXxOoEAvRR//Zjri6mHFc1fD5ZVLCMW1l8O1bZ7Y
	 gqCfztdRurJkQ==
Date: Mon, 29 Jan 2024 11:53:57 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com,
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Subject: Re: [PATCH v4] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
Message-ID: <ZbgCVfZfl7s14dM7@google.com>
References: <1706011734-1617-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706011734-1617-1-git-send-email-zhiguo.niu@unisoc.com>

On 01/23, Zhiguo Niu wrote:
> There are some cases of f2fs_is_valid_blkaddr not handled as
> ERROR_INVALID_BLKADDR,so unify the error handling about all of
> f2fs_is_valid_blkaddr.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: improve patch according Chao's suggestions.
> changes of v3:
> 	-rebase patch to dev-test
> 	-correct return value for some f2fs_is_valid_blkaddr error case
> changes of v4: update according to the latest code
> ---
> ---
>  fs/f2fs/checkpoint.c   | 37 +++++++++++++++++++------------------
>  fs/f2fs/data.c         | 24 ++++--------------------
>  fs/f2fs/extent_cache.c |  7 ++-----
>  fs/f2fs/file.c         | 16 +++-------------
>  fs/f2fs/gc.c           |  2 --
>  fs/f2fs/node.c         |  2 +-
>  fs/f2fs/recovery.c     |  4 ----
>  fs/f2fs/segment.c      |  2 --
>  8 files changed, 29 insertions(+), 65 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b85820e..b9bafd7 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -154,19 +154,17 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return exist;
> -	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
> -		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> -			 blkaddr, exist);
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		return exist;
> -	}
> +	if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
> +			(!exist && type == DATA_GENERIC_ENHANCE))
> +		goto err;

	if (unlikely((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
			(!exist && type == DATA_GENERIC_ENHANCE))) {
		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
			blkaddr, exist);
		set_sbi_flag(sbi, SBI_NEED_FSCK);
		dump_stack();

		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
		 ^-- remove and done by caller below.
	}
	return exist;

>  
> -	if (!exist && type == DATA_GENERIC_ENHANCE) {
> -		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> -			 blkaddr, exist);
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		dump_stack();
> -	}
> +	return exist;
> +err:
> +	f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> +		blkaddr, exist);
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +	dump_stack();
> +	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  	return exist;
>  }
>  
> @@ -178,22 +176,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  		break;
>  	case META_SIT:
>  		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> -			return false;
> +			goto err;
>  		break;
>  	case META_SSA:
>  		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
>  			blkaddr < SM_I(sbi)->ssa_blkaddr))
> -			return false;
> +			goto err;
>  		break;
>  	case META_CP:
>  		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
>  			blkaddr < __start_cp_addr(sbi)))
> -			return false;
> +			goto err;
>  		break;
>  	case META_POR:
>  		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>  			blkaddr < MAIN_BLKADDR(sbi)))
> -			return false;
> +			goto err;
>  		break;
>  	case DATA_GENERIC:
>  	case DATA_GENERIC_ENHANCE:
> @@ -210,7 +208,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  				  blkaddr);
>  			set_sbi_flag(sbi, SBI_NEED_FSCK);
>  			dump_stack();
> -			return false;
> +			goto err;
>  		} else {
>  			return __is_bitmap_valid(sbi, blkaddr, type);

			if (!__is_bitmap_valid())
				goto err;

>  		}
> @@ -218,13 +216,16 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>  	case META_GENERIC:
>  		if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
>  			blkaddr >= MAIN_BLKADDR(sbi)))
> -			return false;
> +			goto err;
>  		break;
>  	default:
>  		BUG();
>  	}
>  
>  	return true;
> +err:
> +	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +	return false;
>  }
>  
>  bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 65fe48b..0f9a657 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  
>  	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>  			fio->is_por ? META_POR : (__is_meta_io(fio) ?
> -			META_GENERIC : DATA_GENERIC_ENHANCE))) {
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +			META_GENERIC : DATA_GENERIC_ENHANCE)))
>  		return -EFSCORRUPTED;
> -	}
>  
>  	trace_f2fs_submit_page_bio(page, fio);
>  
> @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>  			fio->encrypted_page : fio->page;
>  
>  	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> -			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)) {
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>  		return -EFSCORRUPTED;
> -	}
>  
>  	trace_f2fs_submit_page_bio(page, fio);
>  
> @@ -1287,8 +1283,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>  		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE_READ)) {
>  			err = -EFSCORRUPTED;
> -			f2fs_handle_error(F2FS_I_SB(inode),
> -						ERROR_INVALID_BLKADDR);
>  			goto put_err;
>  		}
>  		goto got_it;
> @@ -1314,8 +1308,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>  						dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE)) {
>  		err = -EFSCORRUPTED;
> -		f2fs_handle_error(F2FS_I_SB(inode),
> -					ERROR_INVALID_BLKADDR);
>  		goto put_err;
>  	}
>  got_it:
> @@ -1643,7 +1635,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>  	if (!is_hole &&
>  	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
>  		err = -EFSCORRUPTED;
> -		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  		goto sync_out;
>  	}
>  
> @@ -2167,8 +2158,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
>  		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
>  						DATA_GENERIC_ENHANCE_READ)) {
>  			ret = -EFSCORRUPTED;
> -			f2fs_handle_error(F2FS_I_SB(inode),
> -						ERROR_INVALID_BLKADDR);
>  			goto out;
>  		}
>  	} else {
> @@ -2301,7 +2290,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
>  			break;
>  
>  		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC)) {
> -			ret = -EFAULT;
> +			ret = -EFSCORRUPTED;

I'd prefer not to change anything.

>  			goto out_put_dnode;
>  		}
>  		cc->nr_cpages++;
> @@ -2708,11 +2697,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  	    f2fs_lookup_read_extent_cache_block(inode, page->index,
>  						&fio->old_blkaddr)) {
>  		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> -						DATA_GENERIC_ENHANCE)) {
> -			f2fs_handle_error(fio->sbi,
> -						ERROR_INVALID_BLKADDR);
> +						DATA_GENERIC_ENHANCE))
>  			return -EFSCORRUPTED;
> -		}
>  
>  		ipu_force = true;
>  		fio->need_lock = LOCK_DONE;
> @@ -2740,7 +2726,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>  		!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>  						DATA_GENERIC_ENHANCE)) {
>  		err = -EFSCORRUPTED;
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>  		goto out_writepage;
>  	}
>  
> @@ -3707,7 +3692,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>  		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>  				DATA_GENERIC_ENHANCE_READ)) {
>  			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			goto fail;
>  		}
>  		err = f2fs_submit_page_read(use_cow ?
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index ad8dfac7..99d0442 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
>  	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>  	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>  					DATA_GENERIC_ENHANCE)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);

Why do you remove this?

>  		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>  			  __func__, inode->i_ino,
>  			  ei->blk, ei->fofs, ei->len);
> @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>  		goto out;
>  
>  	if (__is_valid_data_blkaddr(blkaddr) &&
> -	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> -		f2fs_bug_on(sbi, 1);
> -		return -EINVAL;
> -	}
> +	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> +		return -EFSCORRUPTED;

Let's keep EINVAL first.

>  out:
>  	/*
>  	 * init block age with zero, this can happen when the block age extent
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 25b119cf..23cd6a1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>  			if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
>  				continue;
>  			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> -						DATA_GENERIC_ENHANCE)) {
> -				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +						DATA_GENERIC_ENHANCE))
>  				continue;
> -			}
>  			if (compressed_cluster)
>  				valid_blocks++;
>  		}
> @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
>  			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
>  					DATA_GENERIC_ENHANCE)) {
>  			f2fs_put_dnode(&dn);
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			return -EFSCORRUPTED;
>  		}
>  
> @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
>  		if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
>  					DATA_GENERIC_ENHANCE)) {
>  			ret = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			break;
>  		}
>  
> @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>  		if (!__is_valid_data_blkaddr(blkaddr))
>  			continue;
>  		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +					DATA_GENERIC_ENHANCE)))
>  			return -EFSCORRUPTED;
> -		}
>  	}
>  
>  	while (count) {
> @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>  		if (!__is_valid_data_blkaddr(blkaddr))
>  			continue;
>  		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +					DATA_GENERIC_ENHANCE)))
>  			return -EFSCORRUPTED;
> -		}
>  	}
>  
>  	while (count) {
> @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>  						DATA_GENERIC_ENHANCE)) {
>  				ret = -EFSCORRUPTED;
>  				f2fs_put_dnode(&dn);
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>  				goto out;
>  			}
>  
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a079eeb..30e93d8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  		if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE_READ))) {
>  			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			goto put_page;
>  		}
>  		goto got_it;
> @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>  						DATA_GENERIC_ENHANCE))) {
>  		err = -EFSCORRUPTED;
> -		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  		goto put_page;
>  	}
>  got_it:
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 9b546fd..541c4ad 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -612,7 +612,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>  	blkaddr = le32_to_cpu(ne.block_addr);
>  	if (__is_valid_data_blkaddr(blkaddr) &&
>  		!f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
> -		return -EFAULT;
> +		return -EFSCORRUPTED;

Ditto.

>  
>  	/* cache nat entry */
>  	cache_nat_entry(sbi, nid, &ne);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index d0f24cc..21381b7 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -680,14 +680,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  		if (__is_valid_data_blkaddr(src) &&
>  			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
>  			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			goto err;
>  		}
>  
>  		if (__is_valid_data_blkaddr(dest) &&
>  			!f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>  			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>  			goto err;
>  		}
>  
> @@ -756,8 +754,6 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
>  					dest, inode->i_ino, dn.ofs_in_node);
>  				err = -EFSCORRUPTED;
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>  				goto err;
>  			}
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7901ede..ad6511f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>  					DATA_GENERIC_ENHANCE)) {
>  				f2fs_put_dnode(&dn);
>  				ret = -EFSCORRUPTED;
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>  				goto out;
>  			}
>  
> -- 
> 1.9.1

