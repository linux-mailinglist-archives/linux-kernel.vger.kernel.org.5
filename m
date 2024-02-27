Return-Path: <linux-kernel+bounces-83766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A99A3869E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D642291422
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB17C54F8D;
	Tue, 27 Feb 2024 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egfoxRi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84024F5E6
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056055; cv=none; b=Z/DJNjjj0F2Y9f0gM3/CSY+jd+Dwo6O5KgK02ThU9ir1FLWhEkunTVED2/6/AbdTuMnAwAkst34PyFAe31xJM3gikbzkwYoBGjGrL4u45gy/jVX4stkZtW43pLXGaRQCXPTpvetkYGfNfaanITJLlYD9wOw2Czl+lwNJrYBmQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056055; c=relaxed/simple;
	bh=hzDXgC3lFahaUPDxUx7HXgG+xz+ttx/VSD8YYSrAuEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfNN3WH3vcLZlrv+2bQX+r8IhASpmAIQbRuKnyjKZlK25IukjmgUDGUVZK2wuHy8zcnoL2dVzge7gjagynfMXsA4VgN6+517ovw5odKRWCYD0+SzRf40ODbbUFXPz4pdO3wTzHQZKuyGLHxc/KQnCTXcObWyLiACuNVopZHYbJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egfoxRi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71267C433F1;
	Tue, 27 Feb 2024 17:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056055;
	bh=hzDXgC3lFahaUPDxUx7HXgG+xz+ttx/VSD8YYSrAuEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=egfoxRi6QISjpLyTIIax+C7Aq6bNcOWjG+PgQdGKw263QxeUauFGQUM73zkJtkGet
	 IMCE8wT308IC5K0gvVKPoNS3+pQeO1X0oCd3ZtdkRRLXoStk0CkyP521dat4Fac1kj
	 vxUpSyAgLxikvnwb0wzzpw4INHO0/2yP40XOfBRNuCPrhoo9clcYv3ZH2ZOADKjeHb
	 S7E6f2vNQ8okwlWt7BQGpfbUaPYrSZ5dWC4RxE5SFY+eKdc4aZEI8gE6miy0+mqfX+
	 /Cgf2nBs1Vc6w6wta/LYhvmST+XdQGk8I9ozICPj8Y8Q1RsJVk7D/aOcKVbhfHPMyk
	 Tg8llpA85xaEw==
Date: Tue, 27 Feb 2024 09:47:33 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: introduce SEGS_TO_BLKS/BLKS_TO_SEGS for cleanup
Message-ID: <Zd4gNUyZkxemSMIS@google.com>
References: <20240221092040.403629-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092040.403629-1-chao@kernel.org>

On 02/21, Chao Yu wrote:
> Just cleanup, no functional change.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/debug.c   |  7 +++----
>  fs/f2fs/f2fs.h    | 14 ++++++++------
>  fs/f2fs/gc.c      | 10 +++++-----
>  fs/f2fs/gc.h      |  4 ++--
>  fs/f2fs/segment.c | 12 ++++++------
>  fs/f2fs/segment.h |  8 ++++----
>  fs/f2fs/super.c   | 16 ++++++++--------
>  fs/f2fs/sysfs.c   |  4 ++--
>  8 files changed, 38 insertions(+), 37 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index 6617195bd27e..12893477f2e4 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -134,7 +134,7 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->cur_ckpt_time = sbi->cprc_info.cur_time;
>  	si->peak_ckpt_time = sbi->cprc_info.peak_time;
>  	spin_unlock(&sbi->cprc_info.stat_lock);
> -	si->total_count = (int)sbi->user_block_count / BLKS_PER_SEG(sbi);
> +	si->total_count = BLKS_TO_SEGS(sbi, (int)sbi->user_block_count);
>  	si->rsvd_segs = reserved_segments(sbi);
>  	si->overp_segs = overprovision_segments(sbi);
>  	si->valid_count = valid_user_blocks(sbi);
> @@ -175,11 +175,10 @@ static void update_general_status(struct f2fs_sb_info *sbi)
>  	si->alloc_nids = NM_I(sbi)->nid_cnt[PREALLOC_NID];
>  	si->io_skip_bggc = sbi->io_skip_bggc;
>  	si->other_skip_bggc = sbi->other_skip_bggc;
> -	si->util_free = (int)(free_user_blocks(sbi) >> sbi->log_blocks_per_seg)
> +	si->util_free = (int)(BLKS_TO_SEGS(sbi, free_user_blocks(sbi)))
>  		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
>  		/ 2;
> -	si->util_valid = (int)(written_block_count(sbi) >>
> -						sbi->log_blocks_per_seg)
> +	si->util_valid = (int)(BLKS_TO_SEGS(sbi, written_block_count(sbi)))
>  		* 100 / (int)(sbi->user_block_count >> sbi->log_blocks_per_seg)
>  		/ 2;
>  	si->util_invalid = 50 - si->util_free - si->util_valid;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index dad2774ca72f..8a6fd4352a0e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1813,12 +1813,14 @@ struct f2fs_sb_info {
>  };
>  
>  /* Definitions to access f2fs_sb_info */
> -#define BLKS_PER_SEG(sbi)					\
> -	((sbi)->blocks_per_seg)
> -#define BLKS_PER_SEC(sbi)					\
> -	((sbi)->segs_per_sec << (sbi)->log_blocks_per_seg)
> -#define SEGS_PER_SEC(sbi)					\
> -	((sbi)->segs_per_sec)
> +#define SEGS_TO_BLKS(sbi, segs)					\
> +		((segs) << (sbi)->log_blocks_per_seg)


I also applied this.

 /* Definitions to access f2fs_sb_info */
 #define SEGS_TO_BLKS(sbi, segs)                                        \
-               ((segs) << (sbi)->log_blocks_per_seg)
+               (((long long)segs) << (sbi)->log_blocks_per_seg)
 #define BLKS_TO_SEGS(sbi, blks)                                        \
                ((blks) >> (sbi)->log_blocks_per_seg)

> +#define BLKS_TO_SEGS(sbi, blks)					\
> +		((blks) >> (sbi)->log_blocks_per_seg)
> +
> +#define BLKS_PER_SEG(sbi)	((sbi)->blocks_per_seg)
> +#define BLKS_PER_SEC(sbi)	(SEGS_TO_BLKS(sbi, (sbi)->segs_per_sec))
> +#define SEGS_PER_SEC(sbi)	((sbi)->segs_per_sec)
>  
>  __printf(3, 4)
>  void f2fs_printk(struct f2fs_sb_info *sbi, bool limit_rate, const char *fmt, ...);
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 3ff126316d42..6d160d50e14e 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -301,7 +301,7 @@ static unsigned int get_max_cost(struct f2fs_sb_info *sbi,
>  
>  	/* LFS */
>  	if (p->gc_mode == GC_GREEDY)
> -		return 2 * BLKS_PER_SEG(sbi) * p->ofs_unit;
> +		return SEGS_TO_BLKS(sbi, 2 * p->ofs_unit);
>  	else if (p->gc_mode == GC_CB)
>  		return UINT_MAX;
>  	else if (p->gc_mode == GC_AT)
> @@ -347,7 +347,7 @@ static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned int segno)
>  	mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
>  	vblocks = div_u64(vblocks, SEGS_PER_SEC(sbi));
>  
> -	u = (vblocks * 100) >> sbi->log_blocks_per_seg;
> +	u = BLKS_TO_SEGS(sbi, vblocks * 100);
>  
>  	/* Handle if the system time has changed by the user */
>  	if (mtime < sit_i->min_mtime)
> @@ -2060,7 +2060,7 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
>  	raw_sb->segment_count = cpu_to_le32(segment_count + segs);
>  	raw_sb->segment_count_main = cpu_to_le32(segment_count_main + segs);
>  	raw_sb->block_count = cpu_to_le64(block_count +
> -			(long long)(segs << sbi->log_blocks_per_seg));
> +			(long long)SEGS_TO_BLKS(sbi, segs));
>  	if (f2fs_is_multi_device(sbi)) {
>  		int last_dev = sbi->s_ndevs - 1;
>  		int dev_segs =
> @@ -2076,7 +2076,7 @@ static void update_sb_metadata(struct f2fs_sb_info *sbi, int secs)
>  static void update_fs_metadata(struct f2fs_sb_info *sbi, int secs)
>  {
>  	int segs = secs * SEGS_PER_SEC(sbi);
> -	long long blks = (long long)(segs << sbi->log_blocks_per_seg);
> +	long long blks = (long long)SEGS_TO_BLKS(sbi, segs);
>  	long long user_block_count =
>  				le64_to_cpu(F2FS_CKPT(sbi)->user_block_count);
>  
> @@ -2118,7 +2118,7 @@ int f2fs_resize_fs(struct file *filp, __u64 block_count)
>  		int last_dev = sbi->s_ndevs - 1;
>  		__u64 last_segs = FDEV(last_dev).total_segments;
>  
> -		if (block_count + (last_segs << sbi->log_blocks_per_seg) <=
> +		if (block_count + SEGS_TO_BLKS(sbi, last_segs) <=
>  								old_block_count)
>  			return -EINVAL;
>  	}
> diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> index e4a75aa4160f..6a2419ddc7c6 100644
> --- a/fs/f2fs/gc.h
> +++ b/fs/f2fs/gc.h
> @@ -70,7 +70,7 @@ struct victim_entry {
>  
>  static inline block_t free_segs_blk_count(struct f2fs_sb_info *sbi)
>  {
> -	return free_segments(sbi) << sbi->log_blocks_per_seg;
> +	return SEGS_TO_BLKS(sbi, free_segments(sbi));
>  }
>  
>  static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
> @@ -78,7 +78,7 @@ static inline block_t free_user_blocks(struct f2fs_sb_info *sbi)
>  	block_t free_blks, ovp_blks;
>  
>  	free_blks = free_segs_blk_count(sbi);
> -	ovp_blks = overprovision_segments(sbi) << sbi->log_blocks_per_seg;
> +	ovp_blks = SEGS_TO_BLKS(sbi, overprovision_segments(sbi));
>  
>  	if (free_blks < ovp_blks)
>  		return 0;
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 56927b097e30..d0209ea77dd2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -448,8 +448,8 @@ static inline bool excess_dirty_threshold(struct f2fs_sb_info *sbi)
>  	unsigned int nodes = get_pages(sbi, F2FS_DIRTY_NODES);
>  	unsigned int meta = get_pages(sbi, F2FS_DIRTY_META);
>  	unsigned int imeta = get_pages(sbi, F2FS_DIRTY_IMETA);
> -	unsigned int threshold = (factor * DEFAULT_DIRTY_THRESHOLD) <<
> -				sbi->log_blocks_per_seg;
> +	unsigned int threshold =
> +		SEGS_TO_BLKS(sbi, (factor * DEFAULT_DIRTY_THRESHOLD));
>  	unsigned int global_threshold = threshold * 3 / 2;
>  
>  	if (dents >= threshold || qdata >= threshold ||
> @@ -870,7 +870,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_info *sbi)
>  {
>  	int ovp_hole_segs =
>  		(overprovision_segments(sbi) - reserved_segments(sbi));
> -	block_t ovp_holes = ovp_hole_segs << sbi->log_blocks_per_seg;
> +	block_t ovp_holes = SEGS_TO_BLKS(sbi, ovp_hole_segs);
>  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
>  	block_t holes[2] = {0, 0};	/* DATA and NODE */
>  	block_t unusable;
> @@ -2178,7 +2178,7 @@ void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
>  		if (!f2fs_sb_has_blkzoned(sbi) &&
>  		    (!f2fs_lfs_mode(sbi) || !__is_large_section(sbi))) {
>  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
> -				(end - start) << sbi->log_blocks_per_seg);
> +				SEGS_TO_BLKS(sbi, end - start));
>  			continue;
>  		}
>  next:
> @@ -2289,7 +2289,7 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
>  	atomic_set(&dcc->queued_discard, 0);
>  	atomic_set(&dcc->discard_cmd_cnt, 0);
>  	dcc->nr_discards = 0;
> -	dcc->max_discards = MAIN_SEGS(sbi) << sbi->log_blocks_per_seg;
> +	dcc->max_discards = SEGS_TO_BLKS(sbi, MAIN_SEGS(sbi));
>  	dcc->max_discard_request = DEF_MAX_DISCARD_REQUEST;
>  	dcc->min_discard_issue_time = DEF_MIN_DISCARD_ISSUE_TIME;
>  	dcc->mid_discard_issue_time = DEF_MID_DISCARD_ISSUE_TIME;
> @@ -4469,7 +4469,7 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
>  #endif
>  
>  	sit_i->sit_base_addr = le32_to_cpu(raw_super->sit_blkaddr);
> -	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
> +	sit_i->sit_blocks = SEGS_TO_BLKS(sbi, sit_segs);
>  	sit_i->written_valid_blocks = 0;
>  	sit_i->bitmap_size = sit_bitmap_size;
>  	sit_i->dirty_sentries = 0;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 9fe5ec619456..e72b02b67087 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -77,21 +77,21 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>  #define TOTAL_SEGS(sbi)							\
>  	(SM_I(sbi) ? SM_I(sbi)->segment_count : 				\
>  		le32_to_cpu(F2FS_RAW_SUPER(sbi)->segment_count))
> -#define TOTAL_BLKS(sbi)	(TOTAL_SEGS(sbi) << (sbi)->log_blocks_per_seg)
> +#define TOTAL_BLKS(sbi)	(SEGS_TO_BLKS(sbi, TOTAL_SEGS(sbi)))
>  
>  #define MAX_BLKADDR(sbi)	(SEG0_BLKADDR(sbi) + TOTAL_BLKS(sbi))
>  #define SEGMENT_SIZE(sbi)	(1ULL << ((sbi)->log_blocksize +	\
>  					(sbi)->log_blocks_per_seg))
>  
>  #define START_BLOCK(sbi, segno)	(SEG0_BLKADDR(sbi) +			\
> -	 (GET_R2L_SEGNO(FREE_I(sbi), segno) << (sbi)->log_blocks_per_seg))
> +	 (SEGS_TO_BLKS(sbi, GET_R2L_SEGNO(FREE_I(sbi), segno))))
>  
>  #define NEXT_FREE_BLKADDR(sbi, curseg)					\
>  	(START_BLOCK(sbi, (curseg)->segno) + (curseg)->next_blkoff)
>  
>  #define GET_SEGOFF_FROM_SEG0(sbi, blk_addr)	((blk_addr) - SEG0_BLKADDR(sbi))
>  #define GET_SEGNO_FROM_SEG0(sbi, blk_addr)				\
> -	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) >> (sbi)->log_blocks_per_seg)
> +	(BLKS_TO_SEGS(sbi, GET_SEGOFF_FROM_SEG0(sbi, blk_addr)))
>  #define GET_BLKOFF_FROM_SEG0(sbi, blk_addr)				\
>  	(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
>  
> @@ -891,7 +891,7 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
>  	if (type == DATA)
>  		return BLKS_PER_SEG(sbi);
>  	else if (type == NODE)
> -		return 8 * BLKS_PER_SEG(sbi);
> +		return SEGS_TO_BLKS(sbi, 8);
>  	else if (type == META)
>  		return 8 * BIO_MAX_VECS;
>  	else
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9976f2b0393c..bb056700b459 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3763,9 +3763,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>  	sbi->segs_per_sec = le32_to_cpu(raw_super->segs_per_sec);
>  	sbi->secs_per_zone = le32_to_cpu(raw_super->secs_per_zone);
>  	sbi->total_sections = le32_to_cpu(raw_super->section_count);
> -	sbi->total_node_count =
> -		((le32_to_cpu(raw_super->segment_count_nat) / 2) *
> -		NAT_ENTRY_PER_BLOCK) << sbi->log_blocks_per_seg;
> +	sbi->total_node_count = SEGS_TO_BLKS(sbi,
> +			((le32_to_cpu(raw_super->segment_count_nat) / 2) *
> +			NAT_ENTRY_PER_BLOCK));
>  	F2FS_ROOT_INO(sbi) = le32_to_cpu(raw_super->root_ino);
>  	F2FS_NODE_INO(sbi) = le32_to_cpu(raw_super->node_ino);
>  	F2FS_META_INO(sbi) = le32_to_cpu(raw_super->meta_ino);
> @@ -4199,14 +4199,14 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  			if (i == 0) {
>  				FDEV(i).start_blk = 0;
>  				FDEV(i).end_blk = FDEV(i).start_blk +
> -				    (FDEV(i).total_segments <<
> -				    sbi->log_blocks_per_seg) - 1 +
> -				    le32_to_cpu(raw_super->segment0_blkaddr);
> +					SEGS_TO_BLKS(sbi,
> +					FDEV(i).total_segments) - 1 +
> +					le32_to_cpu(raw_super->segment0_blkaddr);
>  			} else {
>  				FDEV(i).start_blk = FDEV(i - 1).end_blk + 1;
>  				FDEV(i).end_blk = FDEV(i).start_blk +
> -					(FDEV(i).total_segments <<
> -					sbi->log_blocks_per_seg) - 1;
> +						SEGS_TO_BLKS(sbi,
> +						FDEV(i).total_segments) - 1;
>  				FDEV(i).bdev_handle = bdev_open_by_path(
>  					FDEV(i).path, mode, sbi->sb, NULL);
>  			}
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 2689cc9c3bf8..ceac3bfc5e2c 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -493,8 +493,8 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		spin_lock(&sbi->stat_lock);
>  		if (t > (unsigned long)(sbi->user_block_count -
>  				F2FS_OPTION(sbi).root_reserved_blocks -
> -				(SM_I(sbi)->additional_reserved_segments <<
> -					sbi->log_blocks_per_seg))) {
> +				SEGS_TO_BLKS(sbi,
> +				SM_I(sbi)->additional_reserved_segments))) {
>  			spin_unlock(&sbi->stat_lock);
>  			return -EINVAL;
>  		}
> -- 
> 2.40.1

