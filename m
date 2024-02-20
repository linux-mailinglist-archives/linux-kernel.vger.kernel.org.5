Return-Path: <linux-kernel+bounces-73680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B04385C5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCEBDB2226E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703D2137C41;
	Tue, 20 Feb 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlMXRWvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35FC1FDB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708461188; cv=none; b=JAqkh4FjMh4PpgLtYHJdSpUo31fKZxKa1175vJ/Mu6IsbWMXdczRyc1NW3PreaCNRrwIh4WdDgwEWiUr2lp+vpr+3RI4Ft9glVUyh8Tpm/LC1ffvBbDEXVpW/YvQPt9eoNa+XoNCQMUr4h1BPT4M82pelSZccl4Zg/nVdK4a2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708461188; c=relaxed/simple;
	bh=y24+8HryhdCnfgDslVi16sdwdT9XrKwEew71ZsPTtTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=os61nlqwbF55bPTTRvZ4tzGJPZJTsBF+XqwUhmUVTN71UTNbOJHmyJVHA1/s7IBVIZr0qUiHNUz+JlSyHNVmHyr0NrBZSTg0e1NWTolAtGjZGvejNa/tU89m6YXrBfkPQIWJ5o0WtsaQUuahymMiKGr9IcHyIPV5xoUK0swaG+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlMXRWvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD92C433F1;
	Tue, 20 Feb 2024 20:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708461188;
	bh=y24+8HryhdCnfgDslVi16sdwdT9XrKwEew71ZsPTtTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlMXRWvQRj946i/YjgBAJYQOjssUYZfeurFaHCZ/uvJjzum7JJBhXh3o7xZW//z5M
	 hyMXtM0+o/F3ObMtQuwL7A00kv0ZCCfZZVZ7SAQqupwd2OSzLCv7VqUv+447mAUYNr
	 z61NZH5ChdwzqQhxM4E+qa4JL82C+fDrhFlbMwRPI0DlPdB909bSCd4q3eP7IdjWUq
	 lhNKA2q3VqsIQFelDi+vP0rE9I9iKk5E2dwDKyldOgS5mRYOHjfhjJQCzYTuNBYsB4
	 /T3mGWhx3dOUj6/CIHTxEDGs/IJM7fxidFrBZCM2ELjD8q4ZsnTYIqresFZDWHqf1z
	 kxP5aQFXwwq6w==
Date: Tue, 20 Feb 2024 12:33:06 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/3 v2] f2fs: use BLKS_PER_SEG, BLKS_PER_SEC,
 and SEGS_PER_SEC
Message-ID: <ZdUMgrzpVHob6KvQ@google.com>
References: <20240207005105.3744811-1-jaegeuk@kernel.org>
 <20240207005105.3744811-2-jaegeuk@kernel.org>
 <ZcpfF9UJz8bNW6ge@google.com>
 <bded9fde-9541-465d-86f8-292249226cc9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bded9fde-9541-465d-86f8-292249226cc9@kernel.org>

Hi Chao,

I applied more tho, some are new and some are missing in your patch.
Please see v2.

Thanks,

On 02/20, Chao Yu wrote:
> On 2024/2/13 2:10, Jaegeuk Kim wrote:
> 
> How do you think of appending below diff which cleans up missing
> parts?
> 
> ---
>  fs/f2fs/f2fs.h    |  2 +-
>  fs/f2fs/file.c    |  4 ++--
>  fs/f2fs/segment.c |  4 ++--
>  fs/f2fs/segment.h | 22 +++++++++++-----------
>  fs/f2fs/super.c   |  2 +-
>  5 files changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c4488e12c56e..fc9328655de8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3491,7 +3491,7 @@ static inline __le32 *get_dnode_addr(struct inode *inode,
>  		sizeof((f2fs_inode)->field))			\
>  		<= (F2FS_OLD_ATTRIBUTE_SIZE + (extra_isize)))	\
> 
> -#define __is_large_section(sbi)		((sbi)->segs_per_sec > 1)
> +#define __is_large_section(sbi)		(SEGS_PER_SEC(sbi) > 1)
> 
>  #define __is_meta_io(fio) (PAGE_TYPE_OF_BIO((fio)->type) == META)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 20a26bb5b889..ef43d33278ea 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2997,8 +2997,8 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
> 
>  	if (!f2fs_is_multi_device(sbi) || sbi->s_ndevs - 1 <= range.dev_num ||
>  			__is_large_section(sbi)) {
> -		f2fs_warn(sbi, "Can't flush %u in %d for segs_per_sec %u != 1",
> -			  range.dev_num, sbi->s_ndevs, sbi->segs_per_sec);
> +		f2fs_warn(sbi, "Can't flush %u in %d for SEGS_PER_SEC %u != 1",
> +			  range.dev_num, sbi->s_ndevs, SEGS_PER_SEC(sbi));
>  		return -EINVAL;
>  	}
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 97ac733ceffe..b59e29608ae7 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2750,7 +2750,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>  	if (f2fs_need_rand_seg(sbi))
>  		return get_random_u32_below(MAIN_SECS(sbi) * SEGS_PER_SEC(sbi));
> 
> -	/* if segs_per_sec is large than 1, we need to keep original policy. */
> +	/* if SEGS_PER_SEC() is large than 1, we need to keep original policy. */
>  	if (__is_large_section(sbi))
>  		return curseg->segno;
> 
> @@ -3498,7 +3498,7 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	 */
>  	if (segment_full) {
>  		if (type == CURSEG_COLD_DATA_PINNED &&
> -		    !((curseg->segno + 1) % sbi->segs_per_sec))
> +		    !((curseg->segno + 1) % SEGS_PER_SEC(sbi)))
>  			goto skip_new_segment;
> 
>  		if (from_gc) {
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index cb982af765c3..63f278210654 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -48,21 +48,21 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
> 
>  #define IS_CURSEC(sbi, secno)						\
>  	(((secno) == CURSEG_I(sbi, CURSEG_HOT_DATA)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_WARM_DATA)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_DATA)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_HOT_NODE)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_WARM_NODE)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_NODE)->segno /		\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_COLD_DATA_PINNED)->segno /	\
> -	  (sbi)->segs_per_sec) ||	\
> +	  SEGS_PER_SEC(sbi)) ||	\
>  	 ((secno) == CURSEG_I(sbi, CURSEG_ALL_DATA_ATGC)->segno /	\
> -	  (sbi)->segs_per_sec))
> +	  SEGS_PER_SEC(sbi)))
> 
>  #define MAIN_BLKADDR(sbi)						\
>  	(SM_I(sbi) ? SM_I(sbi)->main_blkaddr : 				\
> @@ -93,7 +93,7 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  #define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
>  	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> (sbi)->log_blocks_per_seg)
>  #define GET_BLKOFF_FROM_SEG0(sbi, blk_addr)				\
> -	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & ((sbi)->blocks_per_seg - 1))
> +	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
> 
>  #define GET_SEGNO(sbi, blk_addr)					\
>  	((!__is_valid_data_blkaddr(blk_addr) ||			\
> @@ -101,9 +101,9 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  	NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),			\
>  		GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
>  #define GET_SEC_FROM_SEG(sbi, segno)				\
> -	(((segno) == -1) ? -1 : (segno) / (sbi)->segs_per_sec)
> +	(((segno) == -1) ? -1 : (segno) / SEGS_PER_SEC(sbi))
>  #define GET_SEG_FROM_SEC(sbi, secno)				\
> -	((secno) * (sbi)->segs_per_sec)
> +	((secno) * SEGS_PER_SEC(sbi))
>  #define GET_ZONE_FROM_SEC(sbi, secno)				\
>  	(((secno) == -1) ? -1 : (secno) / (sbi)->secs_per_zone)
>  #define GET_ZONE_FROM_SEG(sbi, segno)				\
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2a8b6cfaf683..9d2c680a61f5 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -4723,7 +4723,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  			.reason = CP_DISCARD,
>  			.trim_start = 0,
>  			.trim_end = MAIN_SEGS(sbi) - 1,
> -			.trim_minlen = sbi->blocks_per_seg,
> +			.trim_minlen = BLKS_PER_SEG(sbi),

We don't have this.

>  		};
>  		f2fs_write_checkpoint(sbi, &cpc);
>  	}
> -- 
> 2.40.1

