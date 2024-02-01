Return-Path: <linux-kernel+bounces-47932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EAE8454C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06E1B283A9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C296115B0F9;
	Thu,  1 Feb 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKfyh0PC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994674DA19
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781879; cv=none; b=XZuPGFj/TeMexMD+LExjsha7NRIer3TXci3xQpebLXRN3Av7PEYlGy7z+DcNbsBZccuEzv7b8hPPyLxH5GfHNECANIvHbcoS2ZtYXu33nkJZWf9WcXeJ2QaZSgWdyAnMLkuy11nsNdIJgJGn8WmvQKQbCunkrh8kmw2NIOqQ18c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781879; c=relaxed/simple;
	bh=2Y4THrW7AllqSowHG4eQ1MMYnUa2uz9wMqjt7IWXLEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjFNAVK22ERuUU8IJ6yGSk/gpaOF/Xj3S0lJTw4Hr9rKLjILfiN2MmIockrLlY4YUQC6dqVothVgVwdKScZIn1gtu91deq73j0bkxxdk5oRsue3Y3/N3JhYumhEnQmWPutnnYba+R5+HaGEU5Aw37W6R8tzO4lGiLQ3ZUtRzseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKfyh0PC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B9EC433C7;
	Thu,  1 Feb 2024 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781879;
	bh=2Y4THrW7AllqSowHG4eQ1MMYnUa2uz9wMqjt7IWXLEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JKfyh0PCv6mlj0cNPwcFqVsMcZMhk/e6N+l0dEtYPRPZrVKedyMBcRMSOcQnnawhf
	 0DnZKAVgbmowKWBX1JdRsQWTYcUXNC0ifqnNuo7ZbevayFpcTmt6S91sKArSWpO9En
	 DpHQRP5xtc56QcnS6Gkk3cQPVdA1O0/tlaE57Spv2OzudCLdTpPn/ifG36FUVX4pQ1
	 ydkeGyiJqix23jubnHUVyNDAC6tSeNkrlB3hXw29kJZ9z0CbQuWzrkTN9RwIlMC+ge
	 7w/WA04gZiwH6chmwEjRrS92dyhOLWoVtGa4x4NKN3tiRM341L+1vs2n9HsaQuRmiE
	 Z3d17AA8Th4Pw==
Message-ID: <cc9d1f72-681e-48d7-9ce8-bd0ee9f31e4a@kernel.org>
Date: Thu, 1 Feb 2024 18:04:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] f2fs: unify the error handling of
 f2fs_is_valid_blkaddr
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, hongyu.jin@unisoc.com
References: <1706668994-7384-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1706668994-7384-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 10:43, Zhiguo Niu wrote:
> There are some cases of f2fs_is_valid_blkaddr not handled as
> ERROR_INVALID_BLKADDR,so unify the error handling about all of
> f2fs_is_valid_blkaddr.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> changes of v2: improve patch according Chao's suggestions.
> changes of v3:
>    -rebase patch to dev-test
>    -correct return value for some f2fs_is_valid_blkaddr error case
> changes of v4: update according to the latest code
> changes of v5: improve patch according Jaegeuk's suggestiongs
>    -restore return value of some f2fs_is_valid_blkaddr error case to original
>    -remove cp_err checking in __is_bitmap_valid becasue it has done in
>     if case
>    -return true directly for case (type=DATA_GENERIC_ENHANCE_READ) in
>     __is_bitmap_valid to avoid meaningless flow
>    -rename __is_bitmap_valid to __is_bitmap_check_valid for avoiding ambiguity
>     and handling its return value in the caller uniformly, also cooperate
>     switch checking true to false in do_recover_data for error case of
>     f2fs_is_valid_blkaddr(type=DATA_GENERIC_ENHANCE_UPDATE) for more readable
> ---
> ---
>   fs/f2fs/checkpoint.c   | 53 +++++++++++++++++++++++---------------------------
>   fs/f2fs/data.c         | 22 +++------------------
>   fs/f2fs/extent_cache.c |  5 +----
>   fs/f2fs/file.c         | 16 +++------------
>   fs/f2fs/gc.c           |  2 --
>   fs/f2fs/recovery.c     |  6 +-----
>   fs/f2fs/segment.c      |  2 --
>   7 files changed, 32 insertions(+), 74 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b85820e..e90fa46 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -134,14 +134,15 @@ struct page *f2fs_get_tmp_page(struct f2fs_sb_info *sbi, pgoff_t index)
>   	return __get_meta_page(sbi, index, false);
>   }
>   
> -static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
> +static bool __is_bitmap_check_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>   							int type)
>   {
>   	struct seg_entry *se;
>   	unsigned int segno, offset;
>   	bool exist;
>   
> -	if (type == DATA_GENERIC)
> +	if (type == DATA_GENERIC ||
> +		type == DATA_GENERIC_ENHANCE_READ)
>   		return true;
>   
>   	segno = GET_SEGNO(sbi, blkaddr);
> @@ -149,25 +150,16 @@ static bool __is_bitmap_valid(struct f2fs_sb_info *sbi, block_t blkaddr,
>   	se = get_seg_entry(sbi, segno);
>   
>   	exist = f2fs_test_bit(offset, se->cur_valid_map);
> +	if ((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
> +			(!exist && type == DATA_GENERIC_ENHANCE))
> +		goto err;
>   
> -	/* skip data, if we already have an error in checkpoint. */
> -	if (unlikely(f2fs_cp_error(sbi)))
> -		return exist;
> -
> -	if (exist && type == DATA_GENERIC_ENHANCE_UPDATE) {
> -		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> -			 blkaddr, exist);
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		return exist;
> -	}
> -
> -	if (!exist && type == DATA_GENERIC_ENHANCE) {
> -		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> -			 blkaddr, exist);
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
> -		dump_stack();
> -	}
> -	return exist;
> +	return true;
> +err:
> +	f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
> +		blkaddr, exist);
> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> +	return false;

	if (unlikely((exist && type == DATA_GENERIC_ENHANCE_UPDATE) ||
			(!exist && type == DATA_GENERIC_ENHANCE))) {
		f2fs_err(sbi, "Inconsistent error blkaddr:%u, sit bitmap:%d",
			blkaddr, exist);
		set_sbi_flag(sbi, SBI_NEED_FSCK);
		dump_stack();
		return false;
	}
	return exist;

>   }
>   
>   static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> @@ -178,22 +170,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   		break;
>   	case META_SIT:
>   		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
> -			return false;
> +			goto err;
>   		break;
>   	case META_SSA:
>   		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
>   			blkaddr < SM_I(sbi)->ssa_blkaddr))
> -			return false;
> +			goto err;
>   		break;
>   	case META_CP:
>   		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
>   			blkaddr < __start_cp_addr(sbi)))
> -			return false;
> +			goto err;
>   		break;
>   	case META_POR:
>   		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>   			blkaddr < MAIN_BLKADDR(sbi)))
> -			return false;
> +			goto err;
>   		break;
>   	case DATA_GENERIC:
>   	case DATA_GENERIC_ENHANCE:
> @@ -209,22 +201,25 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>   			f2fs_warn(sbi, "access invalid blkaddr:%u",
>   				  blkaddr);
>   			set_sbi_flag(sbi, SBI_NEED_FSCK);
> -			dump_stack();
> -			return false;
> -		} else {
> -			return __is_bitmap_valid(sbi, blkaddr, type);
> +			goto err;
> +		} else if (!__is_bitmap_check_valid(sbi, blkaddr, type)) {
> +			goto err;
>   		}
>   		break;
>   	case META_GENERIC:
>   		if (unlikely(blkaddr < SEG0_BLKADDR(sbi) ||
>   			blkaddr >= MAIN_BLKADDR(sbi)))
> -			return false;
> +			goto err;
>   		break;
>   	default:
>   		BUG();
>   	}
>   
>   	return true;
> +err:
> +	dump_stack();

I don't think we need to call dump_stack() for all cases.

Thanks,

> +	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +	return false;
>   }
>   
>   bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 05158f8..300f9ae 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -738,10 +738,8 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>   
>   	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
>   			fio->is_por ? META_POR : (__is_meta_io(fio) ?
> -			META_GENERIC : DATA_GENERIC_ENHANCE))) {
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +			META_GENERIC : DATA_GENERIC_ENHANCE)))
>   		return -EFSCORRUPTED;
> -	}
>   
>   	trace_f2fs_submit_page_bio(page, fio);
>   
> @@ -946,10 +944,8 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   			fio->encrypted_page : fio->page;
>   
>   	if (!f2fs_is_valid_blkaddr(fio->sbi, fio->new_blkaddr,
> -			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC)) {
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
> +			__is_meta_io(fio) ? META_GENERIC : DATA_GENERIC))
>   		return -EFSCORRUPTED;
> -	}
>   
>   	trace_f2fs_submit_page_bio(page, fio);
>   
> @@ -1286,8 +1282,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>   		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), dn.data_blkaddr,
>   						DATA_GENERIC_ENHANCE_READ)) {
>   			err = -EFSCORRUPTED;
> -			f2fs_handle_error(F2FS_I_SB(inode),
> -						ERROR_INVALID_BLKADDR);
>   			goto put_err;
>   		}
>   		goto got_it;
> @@ -1313,8 +1307,6 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
>   						dn.data_blkaddr,
>   						DATA_GENERIC_ENHANCE)) {
>   		err = -EFSCORRUPTED;
> -		f2fs_handle_error(F2FS_I_SB(inode),
> -					ERROR_INVALID_BLKADDR);
>   		goto put_err;
>   	}
>   got_it:
> @@ -1642,7 +1634,6 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
>   	if (!is_hole &&
>   	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
>   		err = -EFSCORRUPTED;
> -		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   		goto sync_out;
>   	}
>   
> @@ -2166,8 +2157,6 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
>   		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
>   						DATA_GENERIC_ENHANCE_READ)) {
>   			ret = -EFSCORRUPTED;
> -			f2fs_handle_error(F2FS_I_SB(inode),
> -						ERROR_INVALID_BLKADDR);
>   			goto out;
>   		}
>   	} else {
> @@ -2707,11 +2696,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>   	    f2fs_lookup_read_extent_cache_block(inode, page->index,
>   						&fio->old_blkaddr)) {
>   		if (!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
> -						DATA_GENERIC_ENHANCE)) {
> -			f2fs_handle_error(fio->sbi,
> -						ERROR_INVALID_BLKADDR);
> +						DATA_GENERIC_ENHANCE))
>   			return -EFSCORRUPTED;
> -		}
>   
>   		ipu_force = true;
>   		fio->need_lock = LOCK_DONE;
> @@ -2739,7 +2725,6 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
>   		!f2fs_is_valid_blkaddr(fio->sbi, fio->old_blkaddr,
>   						DATA_GENERIC_ENHANCE)) {
>   		err = -EFSCORRUPTED;
> -		f2fs_handle_error(fio->sbi, ERROR_INVALID_BLKADDR);
>   		goto out_writepage;
>   	}
>   
> @@ -3706,7 +3691,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
>   				DATA_GENERIC_ENHANCE_READ)) {
>   			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto fail;
>   		}
>   		err = f2fs_submit_page_read(use_cow ?
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index ad8dfac7..48048fa 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -43,7 +43,6 @@ bool sanity_check_extent_cache(struct inode *inode)
>   	if (!f2fs_is_valid_blkaddr(sbi, ei->blk, DATA_GENERIC_ENHANCE) ||
>   	    !f2fs_is_valid_blkaddr(sbi, ei->blk + ei->len - 1,
>   					DATA_GENERIC_ENHANCE)) {
> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
>   		f2fs_warn(sbi, "%s: inode (ino=%lx) extent info [%u, %u, %u] is incorrect, run fsck to fix",
>   			  __func__, inode->i_ino,
>   			  ei->blk, ei->fofs, ei->len);
> @@ -856,10 +855,8 @@ static int __get_new_block_age(struct inode *inode, struct extent_info *ei,
>   		goto out;
>   
>   	if (__is_valid_data_blkaddr(blkaddr) &&
> -	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE)) {
> -		f2fs_bug_on(sbi, 1);
> +	    !f2fs_is_valid_blkaddr(sbi, blkaddr, DATA_GENERIC_ENHANCE))
>   		return -EINVAL;
> -	}
>   out:
>   	/*
>   	 * init block age with zero, this can happen when the block age extent
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 25b119cf..23cd6a1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -593,10 +593,8 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
>   			if (time_to_inject(sbi, FAULT_BLKADDR_CONSISTENCE))
>   				continue;
>   			if (!f2fs_is_valid_blkaddr_raw(sbi, blkaddr,
> -						DATA_GENERIC_ENHANCE)) {
> -				f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +						DATA_GENERIC_ENHANCE))
>   				continue;
> -			}
>   			if (compressed_cluster)
>   				valid_blocks++;
>   		}
> @@ -1196,7 +1194,6 @@ static int __read_out_blkaddrs(struct inode *inode, block_t *blkaddr,
>   			!f2fs_is_valid_blkaddr(sbi, *blkaddr,
>   					DATA_GENERIC_ENHANCE)) {
>   			f2fs_put_dnode(&dn);
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			return -EFSCORRUPTED;
>   		}
>   
> @@ -1482,7 +1479,6 @@ static int f2fs_do_zero_range(struct dnode_of_data *dn, pgoff_t start,
>   		if (!f2fs_is_valid_blkaddr(sbi, dn->data_blkaddr,
>   					DATA_GENERIC_ENHANCE)) {
>   			ret = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			break;
>   		}
>   
> @@ -3442,10 +3438,8 @@ static int release_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   		if (!__is_valid_data_blkaddr(blkaddr))
>   			continue;
>   		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +					DATA_GENERIC_ENHANCE)))
>   			return -EFSCORRUPTED;
> -		}
>   	}
>   
>   	while (count) {
> @@ -3607,10 +3601,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count)
>   		if (!__is_valid_data_blkaddr(blkaddr))
>   			continue;
>   		if (unlikely(!f2fs_is_valid_blkaddr(sbi, blkaddr,
> -					DATA_GENERIC_ENHANCE))) {
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> +					DATA_GENERIC_ENHANCE)))
>   			return -EFSCORRUPTED;
> -		}
>   	}
>   
>   	while (count) {
> @@ -3894,8 +3886,6 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
>   						DATA_GENERIC_ENHANCE)) {
>   				ret = -EFSCORRUPTED;
>   				f2fs_put_dnode(&dn);
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>   				goto out;
>   			}
>   
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a079eeb..30e93d8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1197,7 +1197,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>   		if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>   						DATA_GENERIC_ENHANCE_READ))) {
>   			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto put_page;
>   		}
>   		goto got_it;
> @@ -1216,7 +1215,6 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>   	if (unlikely(!f2fs_is_valid_blkaddr(sbi, dn.data_blkaddr,
>   						DATA_GENERIC_ENHANCE))) {
>   		err = -EFSCORRUPTED;
> -		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   		goto put_page;
>   	}
>   got_it:
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index aad1d1a..73d81e0 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -693,14 +693,12 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>   		if (__is_valid_data_blkaddr(src) &&
>   			!f2fs_is_valid_blkaddr(sbi, src, META_POR)) {
>   			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto err;
>   		}
>   
>   		if (__is_valid_data_blkaddr(dest) &&
>   			!f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
>   			err = -EFSCORRUPTED;
> -			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>   			goto err;
>   		}
>   
> @@ -750,13 +748,11 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>   				goto err;
>   			}
>   
> -			if (f2fs_is_valid_blkaddr(sbi, dest,
> +			if (!f2fs_is_valid_blkaddr(sbi, dest,
>   					DATA_GENERIC_ENHANCE_UPDATE)) {
>   				f2fs_err(sbi, "Inconsistent dest blkaddr:%u, ino:%lu, ofs:%u",
>   					dest, inode->i_ino, dn.ofs_in_node);
>   				err = -EFSCORRUPTED;
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>   				goto err;
>   			}
>   
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7901ede..ad6511f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -334,8 +334,6 @@ static int __f2fs_commit_atomic_write(struct inode *inode)
>   					DATA_GENERIC_ENHANCE)) {
>   				f2fs_put_dnode(&dn);
>   				ret = -EFSCORRUPTED;
> -				f2fs_handle_error(sbi,
> -						ERROR_INVALID_BLKADDR);
>   				goto out;
>   			}
>   

