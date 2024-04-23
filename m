Return-Path: <linux-kernel+bounces-154413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8638ADBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17D951C21127
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF218E28;
	Tue, 23 Apr 2024 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE+Vik3o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26B318AEA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838076; cv=none; b=QrqJ4SIJ4CMzj7LgaAOTh+MnYUC8Negvhysf27PvdQZYxfy7uGsaI2nRYLZap+pCLTIIGQOJIzximCXgoVtXzyp8wwOdv3F4+4vsIS2CdNqRtUqr5tceImIBchhLe98/VJ9V8ggqeOjEvz990EpQmgcPFBy1M2BRUKdXAkLcVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838076; c=relaxed/simple;
	bh=9ZrYYhHo31/mbMcmlkNl/YC9fkL7yN42Gjse/Jn35WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a6xKuirWTeHj7OBHIPMCqsPlqCbPzAmpbVg1kiQ4ysYzSyarNJ6dy0hAbyPd3dyWUX4U6a//L9rnDkBiJY1jKJUw/LHnx1Pi5oJY9s+/bZTgVPSbkwdOJrcKmNsP13hvqZBwf0IFQZotGmIFqSOK185g1fqd1QPNDUDeqC2ON0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE+Vik3o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC5AC113CC;
	Tue, 23 Apr 2024 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713838075;
	bh=9ZrYYhHo31/mbMcmlkNl/YC9fkL7yN42Gjse/Jn35WQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pE+Vik3oiiMeIHNlxxtcPyG7/G8T38eNZtpg+A8LXg82eDw+dFbD/dpr8n+D4TLOC
	 o8xu+x5SwYAtmI0pfmyExpeYiEJzNaBQdYqcQlzA3nn/I66KYY6MvW1XyV3Vg1iEYH
	 wNil0i75gyyxednIclBFmYQceQOab3kkXfx4Q67/l/Mv9oCYZ8cFHaixxqxiBkbaNY
	 mMfGyA9Ru1Mco5q5HWluEyrXJU2gicB7UoCC0N7Tcl1uNl/v98Yc/PUgaVnugPEOuH
	 Sk3tQs0+S4gDHSy+TtSwSNMJpANDBDGZ68JzeJO6/mkEBnY3tHDps5H/ROMVOFSDh9
	 70xl98xdJoGEg==
Message-ID: <11d5d736-bae5-4a71-b400-087b8722893c@kernel.org>
Date: Tue, 23 Apr 2024 10:07:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] f2fs: use per-log target_bitmap to improve lookup
 performace of ssr allocation
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20240411082354.1691820-1-chao@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240411082354.1691820-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Jaegeuk, any comments for this serials?

On 2024/4/11 16:23, Chao Yu wrote:
> After commit 899fee36fac0 ("f2fs: fix to avoid data corruption by
> forbidding SSR overwrite"), valid block bitmap of current openned
> segment is fixed, let's introduce a per-log bitmap instead of temp
> bitmap to avoid unnecessary calculation overhead whenever allocating
> free slot w/ SSR allocator.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - rebase to last dev-test branch.
>   fs/f2fs/segment.c | 30 ++++++++++++++++++++++--------
>   fs/f2fs/segment.h |  1 +
>   2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6474b7338e81..af716925db19 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2840,31 +2840,39 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>   	return 0;
>   }
>   
> -static int __next_free_blkoff(struct f2fs_sb_info *sbi,
> -					int segno, block_t start)
> +static void __get_segment_bitmap(struct f2fs_sb_info *sbi,
> +					unsigned long *target_map,
> +					int segno)
>   {
>   	struct seg_entry *se = get_seg_entry(sbi, segno);
>   	int entries = SIT_VBLOCK_MAP_SIZE / sizeof(unsigned long);
> -	unsigned long *target_map = SIT_I(sbi)->tmp_map;
>   	unsigned long *ckpt_map = (unsigned long *)se->ckpt_valid_map;
>   	unsigned long *cur_map = (unsigned long *)se->cur_valid_map;
>   	int i;
>   
>   	for (i = 0; i < entries; i++)
>   		target_map[i] = ckpt_map[i] | cur_map[i];
> +}
> +
> +static int __next_free_blkoff(struct f2fs_sb_info *sbi, unsigned long *bitmap,
> +					int segno, block_t start)
> +{
> +	__get_segment_bitmap(sbi, bitmap, segno);
>   
> -	return __find_rev_next_zero_bit(target_map, BLKS_PER_SEG(sbi), start);
> +	return __find_rev_next_zero_bit(bitmap, BLKS_PER_SEG(sbi), start);
>   }
>   
>   static int f2fs_find_next_ssr_block(struct f2fs_sb_info *sbi,
> -		struct curseg_info *seg)
> +					struct curseg_info *seg)
>   {
> -	return __next_free_blkoff(sbi, seg->segno, seg->next_blkoff + 1);
> +	return __find_rev_next_zero_bit(seg->target_map,
> +				BLKS_PER_SEG(sbi), seg->next_blkoff + 1);
>   }
>   
>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
>   {
> -	return __next_free_blkoff(sbi, segno, 0) < BLKS_PER_SEG(sbi);
> +	return __next_free_blkoff(sbi, SIT_I(sbi)->tmp_map, segno, 0) <
> +							BLKS_PER_SEG(sbi);
>   }
>   
>   /*
> @@ -2890,7 +2898,8 @@ static int change_curseg(struct f2fs_sb_info *sbi, int type)
>   
>   	reset_curseg(sbi, type, 1);
>   	curseg->alloc_type = SSR;
> -	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->segno, 0);
> +	curseg->next_blkoff = __next_free_blkoff(sbi, curseg->target_map,
> +							curseg->segno, 0);
>   
>   	sum_page = f2fs_get_sum_page(sbi, new_segno);
>   	if (IS_ERR(sum_page)) {
> @@ -4635,6 +4644,10 @@ static int build_curseg(struct f2fs_sb_info *sbi)
>   				sizeof(struct f2fs_journal), GFP_KERNEL);
>   		if (!array[i].journal)
>   			return -ENOMEM;
> +		array[i].target_map = f2fs_kzalloc(sbi, SIT_VBLOCK_MAP_SIZE,
> +								GFP_KERNEL);
> +		if (!array[i].target_map)
> +			return -ENOMEM;
>   		if (i < NR_PERSISTENT_LOG)
>   			array[i].seg_type = CURSEG_HOT_DATA + i;
>   		else if (i == CURSEG_COLD_DATA_PINNED)
> @@ -5453,6 +5466,7 @@ static void destroy_curseg(struct f2fs_sb_info *sbi)
>   	for (i = 0; i < NR_CURSEG_TYPE; i++) {
>   		kfree(array[i].sum_blk);
>   		kfree(array[i].journal);
> +		kfree(array[i].target_map);
>   	}
>   	kfree(array);
>   }
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index e1c0f418aa11..10f3e44f036f 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -292,6 +292,7 @@ struct curseg_info {
>   	struct f2fs_summary_block *sum_blk;	/* cached summary block */
>   	struct rw_semaphore journal_rwsem;	/* protect journal area */
>   	struct f2fs_journal *journal;		/* cached journal info */
> +	unsigned long *target_map;		/* bitmap for SSR allocator */
>   	unsigned char alloc_type;		/* current allocation type */
>   	unsigned short seg_type;		/* segment type like CURSEG_XXX_TYPE */
>   	unsigned int segno;			/* current segment number */

