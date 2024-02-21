Return-Path: <linux-kernel+bounces-73898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92F85CD42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DEE1F2308B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4A20E4;
	Wed, 21 Feb 2024 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtE/yrmn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF7517D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478223; cv=none; b=opb2a3UKmn4/TfkLA4LKz1bq4uCEIEZMuxCNTGLwDa+9kiS1wlNXJ6W/OrIeUBwSstERBZlCZahvDhsIZPy8M2whT3xQnkdYrxoN2ksT2oHeuov8mLmHRGop4nxpdWw0O+T9cwdEBi0lmSAKa7+YfjDxGAzyurDcG6n2QqNbxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478223; c=relaxed/simple;
	bh=ZssCYSdcPvwYcsgLG+bxFQkUAPS70WrmqGVwNZl6i9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f050bNIN8weJxGwYmlMeo7/i3E+8wOwnE0vz0yk8wiFQniAN8glqRIDk94cggYZSOwn3KK0yC8gZoyCJeBEgAEvmBUe2JKoSCByBZ57hhui5jscOUdd37P2S3UQjtbKwbJcHjHnOTo2xbSoRz2JnioSbn+39aMMjEKFfjLwurUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtE/yrmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1064C433C7;
	Wed, 21 Feb 2024 01:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708478222;
	bh=ZssCYSdcPvwYcsgLG+bxFQkUAPS70WrmqGVwNZl6i9Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=TtE/yrmnUSkhLIFj+clbTq0XT/iD9WUsBSQGxxF99eXp8c1gLp/DWwZorUi930J6x
	 3eh+wjOL8HF9nGbMS+zebq771O6lZj4vpcF3pWK8pA5P3EDjJq7Q5B9JX1ZYKQBZQt
	 CQMw7PN+/cY8wIeIf5LZ5xYj49FtvgsfElOprDmzd0Joxu7MngfXPQsRl5heySvNQ3
	 bbloy3JDqzQdNfQ+7OE95igDXlYy8+LbOSTc2Pe9mv9hwTujvOqatEpSuK+vbBxv9j
	 xk4DeIWux2nkt9P+Zllhr2W+uHWIUsY9nMCSAmwO4rlvhrqDN2rVd7+b+4TkJVDUn1
	 E9qikaVzVl1JQ==
Message-ID: <1a9d9c59-dbba-4d9e-8804-2fb92c56b5b3@kernel.org>
Date: Wed, 21 Feb 2024 09:16:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: kill heap-based allocation
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240207164620.1536038-1-jaegeuk@kernel.org>
 <ZdUQ6uKYyfzn5Fhv@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZdUQ6uKYyfzn5Fhv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 4:51, Jaegeuk Kim wrote:
> No one uses this feature. Let's kill it.
> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   Change log from v1:
>    - keep mount options but give warnings instead
> 
>   Documentation/filesystems/f2fs.rst |  4 +--
>   fs/f2fs/gc.c                       |  5 ++-
>   fs/f2fs/segment.c                  | 54 ++++--------------------------
>   fs/f2fs/segment.h                  | 10 ------
>   fs/f2fs/super.c                    |  9 +----
>   5 files changed, 11 insertions(+), 71 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 9ac5083dae8e..c30a800604fd 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -126,9 +126,7 @@ norecovery		 Disable the roll-forward recovery routine, mounted read-
>   discard/nodiscard	 Enable/disable real-time discard in f2fs, if discard is
>   			 enabled, f2fs will issue discard/TRIM commands when a
>   			 segment is cleaned.
> -no_heap			 Disable heap-style segment allocation which finds free
> -			 segments for data from the beginning of main area, while
> -			 for node from the end of main area.
> +no_heap			 Deprecated.

heap/no_heap			Deprecated

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

BTW, do we need to kill heap-based allocation in mkfs.f2fs as well?

Thanks,

>   nouser_xattr		 Disable Extended User Attributes. Note: xattr is enabled
>   			 by default if CONFIG_F2FS_FS_XATTR is selected.
>   noacl			 Disable POSIX Access Control List. Note: acl is enabled
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 501b93b45b6c..a089a938355b 100644
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
> index 94c4f7b16c19..09af17af4e7a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2634,16 +2634,14 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
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
> @@ -2657,30 +2655,10 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
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
> @@ -2691,21 +2669,13 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
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
> @@ -2763,8 +2733,7 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>   		return 0;
>   
> -	if (test_opt(sbi, NOHEAP) &&
> -		(seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type)))
> +	if (seg_type == CURSEG_HOT_DATA || IS_NODESEG(seg_type))
>   		return 0;
>   
>   	if (SIT_I(sbi)->last_victim[ALLOC_NEXT])
> @@ -2784,21 +2753,12 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
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
> index 6fadfb634aac..0f1a5210c163 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -131,16 +131,6 @@ static inline void sanity_check_seg_type(struct f2fs_sb_info *sbi,
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
> index 5aaf44c4698b..916e82e9c307 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -733,10 +733,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			clear_opt(sbi, DISCARD);
>   			break;
>   		case Opt_noheap:
> -			set_opt(sbi, NOHEAP);
> -			break;
>   		case Opt_heap:
> -			clear_opt(sbi, NOHEAP);
> +			f2fs_warn(sbi, "heap/no_heap options were deprecated");
>   			break;
>   #ifdef CONFIG_F2FS_FS_XATTR
>   		case Opt_user_xattr:
> @@ -1962,10 +1960,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
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
> @@ -2142,7 +2136,6 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
>   	set_opt(sbi, INLINE_XATTR);
>   	set_opt(sbi, INLINE_DATA);
>   	set_opt(sbi, INLINE_DENTRY);
> -	set_opt(sbi, NOHEAP);
>   	set_opt(sbi, MERGE_CHECKPOINT);
>   	F2FS_OPTION(sbi).unusable_cap = 0;
>   	sbi->sb->s_flags |= SB_LAZYTIME;

