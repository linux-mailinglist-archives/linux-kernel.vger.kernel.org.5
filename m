Return-Path: <linux-kernel+bounces-151836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FA58AB48B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 19:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C626CB20F26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D334A13AD26;
	Fri, 19 Apr 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaZYhUEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AE130A5B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549191; cv=none; b=Qd6FwCMu6QSIu4p1WC+ex8iUIetSFGwejs4x1PYHc8E+kkRIOQGCOhEkoTyZp5iDAUO27t6ueTGRr3mu45HxbHAXG8Jn6OSavcsU1NU/BQ3dBON4nb+v+gtkBYhHhVkGg+VR2zfv22ydA8dmDwVJOMhpr29C3InGZICKIgOxlVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549191; c=relaxed/simple;
	bh=P2h7NW9QjUk3cE2jlrJqRMYAHHbhKGmJ+CTFhzN817A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGaUvxYo1G40rj2/Rf11sO/62rv1H5QsVDGSjmsA08kHm1Ey+TrnLnGURRnEmMbt5eW2yyBWspU7eGyJvVUVuyNVKrGH/u5mfZdgNT0elPcQgwFOS6PSkKKK08J5gQ+612hZasInWclQ9hDesFUF0HfROpVtL1Hi4OVSKUkvxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaZYhUEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699EDC072AA;
	Fri, 19 Apr 2024 17:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713549189;
	bh=P2h7NW9QjUk3cE2jlrJqRMYAHHbhKGmJ+CTFhzN817A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gaZYhUEnU3VfSParrHl6KKiepB3fFueoOM2hwOqHE5yedqk7QNk6qsad/mih2kHer
	 qpT7SlQloK3U3PZynESBbDoPC87KTIRgWj8RwFzeKDSYR1TjDaXt+5zQSR7VjKLhcf
	 te90Bace9VO/WlK1qD18cdy5YrN8E/Xfg2bxC8GFGxIFYl3dklI8j0nZuLFMEri/1u
	 6GhvolJ+B7D3eVi4KMzuyl9HOAq5Gk3/jRX8ddtOlCX41TSEU4vnrZ4Ojt4/FxeBP0
	 jamxV1WsCFd1xI4p1FTgPX4s+EEaqUxESlnNcALK0HAgzFP8zL3/1qt33XzmOWHdxl
	 QymKuu3UkBPuA==
Date: Fri, 19 Apr 2024 17:53:07 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Hyunchul Lee <cheol.lee@lge.com>
Subject: Re: [PATCH] f2fs: assign write hint in direct write IO path
Message-ID: <ZiKvg81HxG088cwm@google.com>
References: <20240418033334.861570-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418033334.861570-1-chao@kernel.org>

Thanks, Chao,

If you don't mind, can I merge this into my patch. Ok?

On 04/18, Chao Yu wrote:
> f2fs has its own write_hint policy, let's assign write hint for
> direct write bio.
> 
> Cc: Hyunchul Lee <cheol.lee@lge.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/file.c    | 15 ++++++++++++++-
>  fs/f2fs/segment.c | 17 +++++++++++------
>  3 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b3b878acc86b..3f7196122574 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3722,6 +3722,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
>  			block_t old_addr, block_t new_addr,
>  			unsigned char version, bool recover_curseg,
>  			bool recover_newaddr);
> +int f2fs_get_segment_temp(int seg_type);
>  int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  			block_t old_blkaddr, block_t *new_blkaddr,
>  			struct f2fs_summary *sum, int type,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ac1ae85f3cc3..d382f8bc2fbe 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4685,8 +4685,21 @@ static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
>  	return 0;
>  }
>  
> +static void f2fs_dio_write_submit_io(const struct iomap_iter *iter,
> +					struct bio *bio, loff_t file_offset)
> +{
> +	struct inode *inode = iter->inode;
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	int seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
> +	enum temp_type temp = f2fs_get_segment_temp(seg_type);
> +
> +	bio->bi_write_hint = f2fs_io_type_to_rw_hint(sbi, DATA, temp);
> +	submit_bio(bio);
> +}
> +
>  static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
> -	.end_io = f2fs_dio_write_end_io,
> +	.end_io		= f2fs_dio_write_end_io,
> +	.submit_io	= f2fs_dio_write_submit_io,
>  };
>  
>  static void f2fs_flush_buffered_write(struct address_space *mapping,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index daa94669f7ee..2206199e8099 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3502,6 +3502,15 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
>  	}
>  }
>  
> +int f2fs_get_segment_temp(int seg_type)
> +{
> +	if (IS_HOT(seg_type))
> +		return HOT;
> +	else if (IS_WARM(seg_type))
> +		return WARM;
> +	return COLD;
> +}
> +
>  static int __get_segment_type(struct f2fs_io_info *fio)
>  {
>  	int type = 0;
> @@ -3520,12 +3529,8 @@ static int __get_segment_type(struct f2fs_io_info *fio)
>  		f2fs_bug_on(fio->sbi, true);
>  	}
>  
> -	if (IS_HOT(type))
> -		fio->temp = HOT;
> -	else if (IS_WARM(type))
> -		fio->temp = WARM;
> -	else
> -		fio->temp = COLD;
> +	fio->temp = f2fs_get_segment_temp(type);
> +
>  	return type;
>  }
>  
> -- 
> 2.40.1

