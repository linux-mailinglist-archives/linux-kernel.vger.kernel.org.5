Return-Path: <linux-kernel+bounces-72539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37EE85B4F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365EBB21412
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1755D462;
	Tue, 20 Feb 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0LR7SU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798065CDF5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708417376; cv=none; b=HsCmH6cBmm6GA1o+z5kkV0LWZbyt6SLqp7YtfmctzOROLor8tYG1MJg5R3PQ8ci7kL31PXRDO2UaxHl2jnMujXH/YAPuvt+WR/gRGaIZyXZg/WSUy1I74GFfPQQyF5mar24mRSrBwbcs4oiIgs+td3FWnQ4lqGPvPQEle63QsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708417376; c=relaxed/simple;
	bh=cbBt1Zx55IXBolkw/HlTrP/xOyoIH0kdFe2GN/BcuZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AW8u3FStkjxc8jn6jtv+TCbWkG5ms6WkF+Qb3fWdM/oWfiycxYJX7vhlDmhdFzocVo8psup7Q+Zn1tWW/eMzQ4Tm+XWe/D17+39saS726sUBJQU689PLTp6Eh5UlhlW+YNKbBu7el1/O/YX8yj/7jPPwDZYTgKrNnVsiEvh5XqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0LR7SU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13061C43394;
	Tue, 20 Feb 2024 08:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708417375;
	bh=cbBt1Zx55IXBolkw/HlTrP/xOyoIH0kdFe2GN/BcuZE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=k0LR7SU5Xeb4PBRPeZAQtvFdprp+LjRXu1V6iaD6ly4A5UVjWH87jQtAQpCFUS3JC
	 0HIuLrVGtAWZTp/jFBYsrhPfVI0sBChkU+3gaSF62cYxwxRIw9L6eKxQLV7VDqN6Ho
	 m2UCgDYD9WSlw8/0YPofgQZ7tFH3s8kJwISGltr6IIwWTp2FSdr5xNLBc3xOO0knyp
	 shmjPaULquTmkfvbgu/W9u98EDtwCzebAVP7KIYntWdLHCqaYjtDwRBmr7qKHlMZZB
	 x/No5fnhxwcBYJeGlQKNru1TcshSUw1fxZ4C4cZddSkDA4mI0aAx/rraMk8hbxOSvZ
	 dWtpteDalRsMw==
Message-ID: <752d7de6-e013-4eed-ac3b-5058de1aa53c@kernel.org>
Date: Tue, 20 Feb 2024 16:22:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs: kill heap-based allocation
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240207164620.1536038-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240207164620.1536038-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 0:46, Jaegeuk Kim wrote:
> No one uses this feature. Let's kill it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   Documentation/filesystems/f2fs.rst |  3 --
>   fs/f2fs/f2fs.h                     | 51 ++++++++++++++--------------
>   fs/f2fs/gc.c                       |  5 ++-
>   fs/f2fs/segment.c                  | 54 ++++--------------------------
>   fs/f2fs/segment.h                  | 10 ------
>   fs/f2fs/super.c                    | 15 ---------
>   6 files changed, 34 insertions(+), 104 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 9ac5083dae8e..1ff751009c43 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -126,9 +126,6 @@ norecovery		 Disable the roll-forward recovery routine, mounted read-
>   discard/nodiscard	 Enable/disable real-time discard in f2fs, if discard is
>   			 enabled, f2fs will issue discard/TRIM commands when a
>   			 segment is cleaned.
> -no_heap			 Disable heap-style segment allocation which finds free
> -			 segments for data from the beginning of main area, while
> -			 for node from the end of main area.
>   nouser_xattr		 Disable Extended User Attributes. Note: xattr is enabled
>   			 by default if CONFIG_F2FS_FS_XATTR is selected.
>   noacl			 Disable POSIX Access Control List. Note: acl is enabled
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 34d718301392..40eb590ed646 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -88,32 +88,31 @@ extern const char *f2fs_fault_name[FAULT_MAX];
>    */
>   #define F2FS_MOUNT_DISABLE_ROLL_FORWARD	0x00000001
>   #define F2FS_MOUNT_DISCARD		0x00000002
> -#define F2FS_MOUNT_NOHEAP		0x00000004
> -#define F2FS_MOUNT_XATTR_USER		0x00000008
> -#define F2FS_MOUNT_POSIX_ACL		0x00000010
> -#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000020
> -#define F2FS_MOUNT_INLINE_XATTR		0x00000040
> -#define F2FS_MOUNT_INLINE_DATA		0x00000080
> -#define F2FS_MOUNT_INLINE_DENTRY	0x00000100
> -#define F2FS_MOUNT_FLUSH_MERGE		0x00000200
> -#define F2FS_MOUNT_NOBARRIER		0x00000400
> -#define F2FS_MOUNT_FASTBOOT		0x00000800
> -#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00001000
> -#define F2FS_MOUNT_DATA_FLUSH		0x00002000
> -#define F2FS_MOUNT_FAULT_INJECTION	0x00004000
> -#define F2FS_MOUNT_USRQUOTA		0x00008000
> -#define F2FS_MOUNT_GRPQUOTA		0x00010000
> -#define F2FS_MOUNT_PRJQUOTA		0x00020000
> -#define F2FS_MOUNT_QUOTA		0x00040000
> -#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00080000
> -#define F2FS_MOUNT_RESERVE_ROOT		0x00100000
> -#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x00200000
> -#define F2FS_MOUNT_NORECOVERY		0x00400000
> -#define F2FS_MOUNT_ATGC			0x00800000
> -#define F2FS_MOUNT_MERGE_CHECKPOINT	0x01000000
> -#define	F2FS_MOUNT_GC_MERGE		0x02000000
> -#define F2FS_MOUNT_COMPRESS_CACHE	0x04000000
> -#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x08000000
> +#define F2FS_MOUNT_XATTR_USER		0x00000004
> +#define F2FS_MOUNT_POSIX_ACL		0x00000008
> +#define F2FS_MOUNT_DISABLE_EXT_IDENTIFY	0x00000010
> +#define F2FS_MOUNT_INLINE_XATTR		0x00000020
> +#define F2FS_MOUNT_INLINE_DATA		0x00000040
> +#define F2FS_MOUNT_INLINE_DENTRY	0x00000080
> +#define F2FS_MOUNT_FLUSH_MERGE		0x00000100
> +#define F2FS_MOUNT_NOBARRIER		0x00000200
> +#define F2FS_MOUNT_FASTBOOT		0x00000400
> +#define F2FS_MOUNT_READ_EXTENT_CACHE	0x00000800
> +#define F2FS_MOUNT_DATA_FLUSH		0x00001000
> +#define F2FS_MOUNT_FAULT_INJECTION	0x00002000
> +#define F2FS_MOUNT_USRQUOTA		0x00004000
> +#define F2FS_MOUNT_GRPQUOTA		0x00008000
> +#define F2FS_MOUNT_PRJQUOTA		0x00010000
> +#define F2FS_MOUNT_QUOTA		0x00020000
> +#define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00040000
> +#define F2FS_MOUNT_RESERVE_ROOT		0x00080000
> +#define F2FS_MOUNT_DISABLE_CHECKPOINT	0x00100000
> +#define F2FS_MOUNT_NORECOVERY		0x00200000
> +#define F2FS_MOUNT_ATGC			0x00400000
> +#define F2FS_MOUNT_MERGE_CHECKPOINT	0x00800000
> +#define	F2FS_MOUNT_GC_MERGE		0x01000000
> +#define F2FS_MOUNT_COMPRESS_CACHE	0x02000000
> +#define F2FS_MOUNT_AGE_EXTENT_CACHE	0x04000000
>   
>   #define F2FS_OPTION(sbi)	((sbi)->mount_opt)
>   #define clear_opt(sbi, option)	(F2FS_OPTION(sbi).opt &= ~F2FS_MOUNT_##option)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0a1a50b68df8..8a9cdc5a72c5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -280,12 +280,11 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>   			p->max_search > sbi->max_victim_search)
>   		p->max_search = sbi->max_victim_search;
>   
> -	/* let's select beginning hot/small space first in no_heap mode*/
> +	/* let's select beginning hot/small space first. */
>   	if (f2fs_need_rand_seg(sbi))
>   		p->offset = get_random_u32_below(MAIN_SECS(sbi) *
>   						SEGS_PER_SEC(sbi));
> -	else if (test_opt(sbi, NOHEAP) &&
> -		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
> +	else if (type == CURSEG_HOT_DATA || IS_NODESEG(type))
>   		p->offset = 0;
>   	else
>   		p->offset = SIT_I(sbi)->last_victim[p->gc_mode];
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 1013276ad12a..4e985750c938 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2632,16 +2632,14 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
>    * This function should be returned with success, otherwise BUG
>    */
>   static void get_new_segment(struct f2fs_sb_info *sbi,
> -			unsigned int *newseg, bool new_sec, int dir)
> +			unsigned int *newseg, bool new_sec)
>   {
>   	struct free_segmap_info *free_i = FREE_I(sbi);
>   	unsigned int segno, secno, zoneno;
>   	unsigned int total_zones = MAIN_SECS(sbi) / sbi->secs_per_zone;
>   	unsigned int hint = GET_SEC_FROM_SEG(sbi, *newseg);
>   	unsigned int old_zoneno = GET_ZONE_FROM_SEG(sbi, *newseg);
> -	unsigned int left_start = hint;
>   	bool init = true;
> -	int go_left = 0;
>   	int i;
>   
>   	spin_lock(&free_i->segmap_lock);
> @@ -2655,30 +2653,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>   find_other_zone:
>   	secno = find_next_zero_bit(free_i->free_secmap, MAIN_SECS(sbi), hint);
>   	if (secno >= MAIN_SECS(sbi)) {
> -		if (dir == ALLOC_RIGHT) {
> -			secno = find_first_zero_bit(free_i->free_secmap,
> +		secno = find_first_zero_bit(free_i->free_secmap,
>   							MAIN_SECS(sbi));
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> -		} else {
> -			go_left = 1;
> -			left_start = hint - 1;
> -		}
> -	}
> -	if (go_left == 0)
> -		goto skip_left;
> -
> -	while (test_bit(left_start, free_i->free_secmap)) {
> -		if (left_start > 0) {
> -			left_start--;
> -			continue;
> -		}
> -		left_start = find_first_zero_bit(free_i->free_secmap,
> -							MAIN_SECS(sbi));
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> -		break;
> +		f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>   	}
> -	secno = left_start;
> -skip_left:
>   	segno = GET_SEG_FROM_SEC(sbi, secno);
>   	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
>   
> @@ -2689,21 +2667,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>   		goto got_it;
>   	if (zoneno == old_zoneno)
>   		goto got_it;
> -	if (dir == ALLOC_LEFT) {
> -		if (!go_left && zoneno + 1 >= total_zones)
> -			goto got_it;
> -		if (go_left && zoneno == 0)
> -			goto got_it;
> -	}
>   	for (i = 0; i < NR_CURSEG_TYPE; i++)
>   		if (CURSEG_I(sbi, i)->zone == zoneno)
>   			break;
>   
>   	if (i < NR_CURSEG_TYPE) {
>   		/* zone is in user, try another */
> -		if (go_left)
> -			hint = zoneno * sbi->secs_per_zone - 1;
> -		else if (zoneno + 1 >= total_zones)
> +		if (zoneno + 1 >= total_zones)
>   			hint = 0;
>   		else
>   			hint = (zoneno + 1) * sbi->secs_per_zone;
> @@ -2762,8 +2732,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>   		return 0;
>   
> -	if (test_opt(sbi, NOHEAP) &&
> -		(seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type)))
> +	if (seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type))
>   		return 0;
>   
>   	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
> @@ -2783,21 +2752,12 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>   static void new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>   {
>   	struct curseg_info *curseg = CURSEG_I(sbi, type);
> -	unsigned short seg_type = curseg->seg_type;
>   	unsigned int segno = curseg->segno;
> -	int dir = ALLOC_LEFT;
>   
>   	if (curseg->inited)
> -		write_sum_page(sbi, curseg->sum_blk,
> -				GET_SUM_BLOCK(sbi, segno));
> -	if (seg_type == CURSEG_WARM_DATA || seg_type == CURSEG_COLD_DATA)
> -		dir = ALLOC_RIGHT;
> -
> -	if (test_opt(sbi, NOHEAP))
> -		dir = ALLOC_RIGHT;
> -
> +		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
>   	segno = __get_next_segno(sbi, type);
> -	get_new_segment(sbi, &segno, new_sec, dir);
> +	get_new_segment(sbi, &segno, new_sec);
>   	curseg->next_segno = segno;
>   	reset_curseg(sbi, type, 1);
>   	curseg->alloc_type = LFS;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index b725ae1a7043..60d93a16f2ac 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -130,16 +130,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
>   #define SECTOR_TO_BLOCK(sectors)					\
>   	((sectors) >> F2FS_LOG_SECTORS_PER_BLOCK)
>   
> -/*
> - * indicate a block allocation direction: RIGHT and LEFT.
> - * RIGHT means allocating new sections towards the end of volume.
> - * LEFT means the opposite direction.
> - */
> -enum {
> -	ALLOC_RIGHT = 0,
> -	ALLOC_LEFT
> -};
> -
>   /*
>    * In the victim_sel_policy->alloc_mode, there are three block allocation modes.
>    * LFS writes data sequentially with cleaning operations.
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 3fb44afd0cd1..c04c0d21705f 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -111,8 +111,6 @@ enum {
>   	Opt_norecovery,
>   	Opt_discard,
>   	Opt_nodiscard,
> -	Opt_noheap,
> -	Opt_heap,
>   	Opt_user_xattr,
>   	Opt_nouser_xattr,
>   	Opt_acl,
> @@ -189,8 +187,6 @@ static match_table_t f2fs_tokens = {
>   	{Opt_norecovery, "norecovery"},
>   	{Opt_discard, "discard"},
>   	{Opt_nodiscard, "nodiscard"},
> -	{Opt_noheap, "no_heap"},
> -	{Opt_heap, "heap"},
>   	{Opt_user_xattr, "user_xattr"},
>   	{Opt_nouser_xattr, "nouser_xattr"},
>   	{Opt_acl, "acl"},
> @@ -726,12 +722,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			}
>   			clear_opt(sbi, DISCARD);
>   			break;
> -		case Opt_noheap:
> -			set_opt(sbi, NOHEAP);
> -			break;
> -		case Opt_heap:
> -			clear_opt(sbi, NOHEAP);
> -			break;

If user uses noheap/heap mount option, this may cause mount failure
due to below handling:

	default:
		f2fs_err(sbi, "Unrecognized mount option \"%s\" or missing value",
			 p);
		return -EINVAL;

Can we keep forward compatibility by continuing to handle noheap/heap
mount option, and leave kernel message as notification for such cases?

Thanks,

>   #ifdef CONFIG_F2FS_FS_XATTR
>   		case Opt_user_xattr:
>   			set_opt(sbi, XATTR_USER);
> @@ -1956,10 +1946,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   	} else {
>   		seq_puts(seq, ",nodiscard");
>   	}
> -	if (test_opt(sbi, NOHEAP))
> -		seq_puts(seq, ",no_heap");
> -	else
> -		seq_puts(seq, ",heap");
>   #ifdef CONFIG_F2FS_FS_XATTR
>   	if (test_opt(sbi, XATTR_USER))
>   		seq_puts(seq, ",user_xattr");
> @@ -2136,7 +2122,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>   	set_opt(sbi, INLINE_XATTR);
>   	set_opt(sbi, INLINE_DATA);
>   	set_opt(sbi, INLINE_DENTRY);
> -	set_opt(sbi, NOHEAP);
>   	set_opt(sbi, MERGE_CHECKPOINT);
>   	F2FS_OPTION(sbi).unusable_cap = 0;
>   	sbi->sb->s_flags |= SB_LAZYTIME;

