Return-Path: <linux-kernel+bounces-40803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25083E63F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07EE71C20CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F756775;
	Fri, 26 Jan 2024 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXelBLKM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9767D55E57
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310496; cv=none; b=tG/pJzn9eQjc8Fh3vS7UgGHNYskTyGDOBe4qzSpIZT8qkDP18gDIBpaDGKXJ6Q3pM3BFi1JKNkW5JAzk0/ILKl2pv036KAFm5+vevVH+qUJg2Iv/rjMdMDrEzf2sNq1A71sWhKQ7TryCS+rGXjhDW6eTrqG/0eEUT9TNvWeRnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310496; c=relaxed/simple;
	bh=gtDQI+hKL0TQ2S0fIwbLd2/StC1wd1X9UG/XGhPc+u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IRD3iAthW34cl56YMpt050S7mshbOss4tNgCJzG3Fe8xqKVyc5OIgejXXplnpf65+emOhf7kJn5XvaiQfwMM2xwIWP2S6UZUoExMPasKzNY12aXHhaHG7BHorhP0TXetz+CTa8gb99OTFkN8iYypu2j8DYdE2tiIMUx2tpoI+Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXelBLKM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE71C433F1;
	Fri, 26 Jan 2024 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706310496;
	bh=gtDQI+hKL0TQ2S0fIwbLd2/StC1wd1X9UG/XGhPc+u0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXelBLKMoeU91iMzptcxcM+mQaJSEpgO+jrwD6fwJBA2GkYx+erSHvnEqaEecJ7ys
	 L9UR+moDECJyZTNAQStBJ1gqSu5Jo3jJb361fwbSboiVHV/p0YUsN9tkSs+y6gLuMd
	 RM4TB7dkNB+Sq2ezTxik+577gPYickgUpAX0Pl2B1ezh1CV1XENFR1r4dA2nhp9qJ/
	 0haeFt1yoLgoBcVaL0dkDQoPqPRIihKVZA//P8H+bBkf0INz8Fq1lEqopVaqZRfjpy
	 Hz6QN8dXokICkd7xEjTGsy5qLKgFWycDOoof+b/7THMJ43wRjTyrsiamf/DlywMiWR
	 YFNnxDfWK+faA==
Date: Fri, 26 Jan 2024 15:08:14 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wenjie <qwjhust@gmail.com>
Cc: chao@kernel.org, guoweichao@oppo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, hustqwj@hust.edu.cn
Subject: Re: [PATCH v2] f2fs: fix max open zone constraints
Message-ID: <ZbQ7XmFpAMSXslkU@google.com>
References: <20240109035804.642-1-qwjhust@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109035804.642-1-qwjhust@gmail.com>

On 01/09, Wenjie wrote:
> From: Wenjie Qi <qwjhust@gmail.com>
> 
> 1. If the max active zones of zoned devices are less than
> the active logs of F2FS, the device may error due to
> insufficient zone resources when multiple active logs are
> being written at the same time.
> 
> 2. We can get the number of remaining available zone
> resources by subtracting the number of active logs from
> the number of max active zones of zoned devices.  We can
> use these available zone resources to reduce the number
> of pending bio when switching zones.
> 
> 3. The original code for determining zone end was
> after "out":, which would have missed some fio's
> where is_end_zone_blkaddr(sbi, fio->new_blkaddr)
> was true. I've moved this code before "skip:" to
> make sure it's done for each fio.

Could you please keep #3 as a separate patch?

> 
> Signed-off-by: Wenjie Qi <qwjhust@gmail.com>
> ---
>  fs/f2fs/data.c  | 38 ++++++++++++++++++++++++++++----------
>  fs/f2fs/f2fs.h  |  2 ++
>  fs/f2fs/super.c |  9 +++++++++
>  3 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index dce8defdf4c7..6b11364e94b8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,6 +392,19 @@ static void f2fs_zone_write_end_io(struct bio *bio)
>  	complete(&io->zone_wait);
>  	f2fs_write_end_io(bio);
>  }
> +
> +static void f2fs_zone_write_end_io_nowait(struct bio *bio)
> +{
> +#ifdef CONFIG_F2FS_IOSTAT
> +	struct bio_iostat_ctx *iostat_ctx = bio->bi_private;
> +	struct f2fs_sb_info *sbi = iostat_ctx->sbi;
> +#else
> +	struct f2fs_sb_info *sbi = (struct f2fs_sb_info *)bio->bi_private;
> +#endif
> +
> +	atomic_inc(&sbi->available_active_zones);
> +	f2fs_write_end_io(bio);
> +}
>  #endif
>  
>  struct block_device *f2fs_target_device(struct f2fs_sb_info *sbi,
> @@ -1080,22 +1093,27 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	io->last_block_in_bio = fio->new_blkaddr;
>  
>  	trace_f2fs_submit_page_write(fio->page, fio);
> -skip:
> -	if (fio->in_list)
> -		goto next;
> -out:
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	if (f2fs_sb_has_blkzoned(sbi) && btype < META &&
>  			is_end_zone_blkaddr(sbi, fio->new_blkaddr)) {
> -		bio_get(io->bio);
> -		reinit_completion(&io->zone_wait);
> -		io->bi_private = io->bio->bi_private;
> -		io->bio->bi_private = io;
> -		io->bio->bi_end_io = f2fs_zone_write_end_io;
> -		io->zone_pending_bio = io->bio;
> +		if (!atomic_add_negative(-1, &sbi->available_active_zones)) {
> +			io->bio->bi_end_io = f2fs_zone_write_end_io_nowait;
> +		} else {
> +			atomic_inc(&sbi->available_active_zones);
> +			bio_get(io->bio);
> +			reinit_completion(&io->zone_wait);
> +			io->bi_private = io->bio->bi_private;
> +			io->bio->bi_private = io;
> +			io->bio->bi_end_io = f2fs_zone_write_end_io;
> +			io->zone_pending_bio = io->bio;
> +		}
>  		__submit_merged_bio(io);
>  	}
>  #endif
> +skip:
> +	if (fio->in_list)
> +		goto next;
> +out:
>  	if (is_sbi_flag_set(sbi, SBI_IS_SHUTDOWN) ||
>  				!f2fs_is_checkpoint_ready(sbi))
>  		__submit_merged_bio(io);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..1b1833e1d10e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1551,6 +1551,8 @@ struct f2fs_sb_info {
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	unsigned int blocks_per_blkz;		/* F2FS blocks per zone */
> +	unsigned int max_active_zones;		/* max zone resources of the zoned device */
> +	atomic_t available_active_zones;		/* remaining zone resources */
>  #endif
>  
>  	/* for node-related operations */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 206d03c82d96..c79919425d63 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3932,6 +3932,15 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>  	if (!f2fs_sb_has_blkzoned(sbi))
>  		return 0;
>  
> +	sbi->max_active_zones = bdev_max_active_zones(bdev);
> +	if (sbi->max_active_zones && (sbi->max_active_zones < F2FS_OPTION(sbi).active_logs)) {
> +		f2fs_err(sbi,
> +			"zoned: max active zones %u is too small, need at least %u active zones",
> +				 sbi->max_active_zones, F2FS_OPTION(sbi).active_logs);
> +		return -EINVAL;
> +	}
> +	atomic_set(&sbi->available_active_zones, sbi->max_active_zones - F2FS_OPTION(sbi).active_logs);
> +
>  	zone_sectors = bdev_zone_sectors(bdev);
>  	if (!is_power_of_2(zone_sectors)) {
>  		f2fs_err(sbi, "F2FS does not support non power of 2 zone sizes\n");
> -- 
> 2.34.1

