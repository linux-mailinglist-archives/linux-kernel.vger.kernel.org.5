Return-Path: <linux-kernel+bounces-80689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC69866B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16364B22048
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628871BF24;
	Mon, 26 Feb 2024 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHuQJWf8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DE1BDCB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933617; cv=none; b=IPLpp/5N5pzPdH1qbfO3wJ+TvgY5u3VKhvonxLS4rFe7VwmNEpJ8mK3Ybi6tDa+AKsrLaiFh0mDsrixUHwT3k143PmkmqU+rZ1N71F2BFA4QUGD7pR54OZFrpPRDRDxUpJqFN56liXCXA4eH7htHYkDgU/Wulb88xmG8X3R+760=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933617; c=relaxed/simple;
	bh=ll8/sE0ujmmsvGfDVHHhSa0z4hjoynpDUiku1IY80Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHBz8goP4laU6icFKOvv6YY8Iulj9afn+BWud5gBpxmMBAcuVzeG8BE1DI5KJ9MrtUb8DOoqHvlrJeBJBoLcFblldqDGR+DaFPkhWDoxI25ZJKeAxFk0vUVI6DpE/oigl3tAhfI1SZB14w3U0q/DgGmxtAh9pLvW6cNFweQJN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHuQJWf8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9067AC433C7;
	Mon, 26 Feb 2024 07:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708933617;
	bh=ll8/sE0ujmmsvGfDVHHhSa0z4hjoynpDUiku1IY80Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fHuQJWf8ZUhqbHcXkHy/nhNEOkrh6EH1dRrrv691s1Jb2eowmhT/RDRLUZURInqwZ
	 bFlBuSGJGe42uorpMW5TnIBpCpS50ImONcAY7lN9wpIpZXjYzRcbrC4hop89johpqd
	 b8Bb67W4+G27jt1NcEXDcdMkJiuEmUysdpZtYFAWMkZ2e5Lr/eHWsdUd0rOep0irBW
	 e4nxFBpCTTCK2g4O7+wPVF+WE/bK/C96rvjQr8MIBAfmrMRp91f1wW0w+THQWsAhmj
	 LZvdUT4v0oYovmlPZTi2cqq4glWa8Q25M+Zkc7kyawdqqaxL/r3i/DPUdolODYeZ71
	 ju2XijZqx032Q==
Message-ID: <873304dc-112d-4c34-b966-e0905ee748fb@kernel.org>
Date: Mon, 26 Feb 2024 15:46:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] f2fs: fix to handle segment allocation failure
 correctly
Content-Language: en-US
To: Zhiguo Niu <niuzhiguo84@gmail.com>, Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 jaegeuk@kernel.org
References: <20240222121851.883141-1-chao@kernel.org>
 <20240222121851.883141-3-chao@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240222121851.883141-3-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Loop to Zhiguo,

On 2024/2/22 20:18, Chao Yu wrote:
> If CONFIG_F2FS_CHECK_FS is off, and for very rare corner case that
> we run out of free segment, we should not panic kernel, instead,
> let's handle such error correctly in its caller.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>   fs/f2fs/data.c    |  7 +++++--
>   fs/f2fs/f2fs.h    |  2 +-
>   fs/f2fs/file.c    |  7 ++++++-
>   fs/f2fs/gc.c      |  7 ++++++-
>   fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++++++++++++++-------
>   5 files changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0c9aa3082fcf..c21b92f18463 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1416,8 +1416,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>   
>   	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
>   	old_blkaddr = dn->data_blkaddr;
> -	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
> -				&sum, seg_type, NULL);
> +	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
> +				&dn->data_blkaddr, &sum, seg_type, NULL);
> +	if (err)
> +		return err;
> +
>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
>   		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
>   
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index fbbe9a0a4221..6390c3d551cb 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3726,7 +3726,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>   			block_t old_addr, block_t new_addr,
>   			unsigned char version, bool recover_curseg,
>   			bool recover_newaddr);
> -void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> +int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>   			block_t old_blkaddr, block_t *new_blkaddr,
>   			struct f2fs_summary *sum, int type,
>   			struct f2fs_io_info *fio);
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 088d0e79fbbc..d6ec744f1545 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2262,8 +2262,11 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>   	case F2FS_GOING_DOWN_METASYNC:
>   		/* do checkpoint only */
>   		ret = f2fs_sync_fs(sb, 1);
> -		if (ret)
> +		if (ret) {
> +			if (ret == -EIO)
> +				ret = 0;
>   			goto out;
> +		}
>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
>   		break;
>   	case F2FS_GOING_DOWN_NOSYNC:
> @@ -2279,6 +2282,8 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>   		set_sbi_flag(sbi, SBI_IS_DIRTY);
>   		/* do checkpoint only */
>   		ret = f2fs_sync_fs(sb, 1);
> +		if (ret == -EIO)
> +			ret = 0;
>   		goto out;
>   	default:
>   		ret = -EINVAL;
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6d160d50e14e..42e75e9b8b6b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1358,8 +1358,13 @@ static int move_data_block(struct inode *inode, block_t bidx,
>   	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
>   
>   	/* allocate block address */
> -	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
> +	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
>   				&sum, type, NULL);
> +	if (err) {
> +		f2fs_put_page(mpage, 1);
> +		/* filesystem should shutdown, no need to recovery block */
> +		goto up_out;
> +	}
>   
>   	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
>   				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 8edc42071e6f..71f523431e87 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -400,6 +400,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
>    */
>   void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
>   {
> +	if (f2fs_cp_error(sbi))
> +		return;
> +
>   	if (time_to_inject(sbi, FAULT_CHECKPOINT))
>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
>   
> @@ -2636,7 +2639,7 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
>    * Find a new segment from the free segments bitmap to right order
>    * This function should be returned with success, otherwise BUG
>    */
> -static void get_new_segment(struct f2fs_sb_info *sbi,
> +static int get_new_segment(struct f2fs_sb_info *sbi,
>   			unsigned int *newseg, bool new_sec, bool pinning)
>   {
>   	struct free_segmap_info *free_i = FREE_I(sbi);
> @@ -2711,6 +2714,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>   		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
>   		f2fs_bug_on(sbi, 1);
>   	}
> +	return ret;
>   }
>   
>   static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
> @@ -2719,6 +2723,10 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
>   	struct summary_footer *sum_footer;
>   	unsigned short seg_type = curseg->seg_type;
>   
> +	/* only happen when get_new_segment() fails */
> +	if (curseg->next_segno == NULL_SEGNO)
> +		return;
> +
>   	curseg->inited = true;
>   	curseg->segno = curseg->next_segno;
>   	curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);
> @@ -2783,7 +2791,10 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
>   		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
>   
>   	segno = __get_next_segno(sbi, type);
> -	get_new_segment(sbi, &segno, new_sec, pinning);
> +	if (get_new_segment(sbi, &segno, new_sec, pinning)) {
> +		curseg->segno = NULL_SEGNO;
> +		return -ENOSPC;
> +	}
>   	if (new_sec && pinning &&
>   	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
>   		__set_free(sbi, segno);
> @@ -3425,7 +3436,7 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
>   		get_random_u32_inclusive(1, sbi->max_fragment_hole);
>   }
>   
> -void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> +int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>   		block_t old_blkaddr, block_t *new_blkaddr,
>   		struct f2fs_summary *sum, int type,
>   		struct f2fs_io_info *fio)
> @@ -3442,6 +3453,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>   	mutex_lock(&curseg->curseg_mutex);
>   	down_write(&sit_i->sentry_lock);
>   
> +	if (curseg->segno == NULL_SEGNO)
> +		goto out_err;
> +
>   	if (from_gc) {
>   		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
>   		se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
> @@ -3500,6 +3514,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>   				change_curseg(sbi, type);
>   			stat_inc_seg_type(sbi, curseg);
>   		}
> +
> +		if (curseg->segno == NULL_SEGNO)
> +			goto out_err;
>   	}
>   
>   skip_new_segment:
> @@ -3534,8 +3551,15 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>   	}
>   
>   	mutex_unlock(&curseg->curseg_mutex);
> -
>   	f2fs_up_read(&SM_I(sbi)->curseg_lock);
> +	return 0;
> +out_err:
> +	*new_blkaddr = NULL_ADDR;
> +	up_write(&sit_i->sentry_lock);
> +	mutex_unlock(&curseg->curseg_mutex);
> +	f2fs_up_read(&SM_I(sbi)->curseg_lock);
> +	return -ENOSPC;
> +
>   }
>   
>   void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
> @@ -3573,8 +3597,16 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>   	if (keep_order)
>   		f2fs_down_read(&fio->sbi->io_order_lock);
>   
> -	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> -			&fio->new_blkaddr, sum, type, fio);
> +	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> +			&fio->new_blkaddr, sum, type, fio)) {
> +		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
> +			fscrypt_finalize_bounce_page(&fio->encrypted_page);
> +		if (PageWriteback(fio->page))
> +			end_page_writeback(fio->page);
> +		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
> +			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
> +		goto out;
> +	}
>   	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
>   		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
>   
> @@ -3582,7 +3614,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>   	f2fs_submit_page_write(fio);
>   
>   	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
> -
> +out:
>   	if (keep_order)
>   		f2fs_up_read(&fio->sbi->io_order_lock);
>   }

