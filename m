Return-Path: <linux-kernel+bounces-25163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16C482C8D8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F45D2831FA
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF7718E01;
	Sat, 13 Jan 2024 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KC+e+Nqh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C71018AF1
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA4AC433F1;
	Sat, 13 Jan 2024 01:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705109988;
	bh=pzmGx/Cqn9yoKWW1PX3E2wDCNFvPFHwZ66zWLOpzMMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KC+e+NqhvI7SWl9nfNtjScBcJoQKv3cTdJpYGp/GVQ4wf+NA1IhaNcQlVFk9jtUeO
	 bPJ80Poq8zwahqWg/TjhdKkOlnpDrh/8WTfiM8K0L/mcfy1VTeJ/TFpquWzkzE5yaT
	 EYkmPiz48dmUhdAbuCeDSfXTtbalVr3UTwKfSyB0CM7Zv+QGhizshSoww5ooDWc/Go
	 OI7cjSAUlC+kb0RYowCNDhBJc5zgiLxgtkDBMZNyphg/GHXub0XXrMhYjNH0kOucC7
	 TRS6DwbanrQ5cKBJ3ZCANyEz6kCxs+f/BPAsrEJugudMk9J1Rnm9aWLMs04ePTg6sd
	 bza1i4GrXJ4cQ==
Date: Fri, 12 Jan 2024 17:39:46 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] f2fs: compress: fix to cover normal cluster write
 with cp_rwsem
Message-ID: <ZaHp4to18RtGShWS@google.com>
References: <20240111064208.2969599-1-chao@kernel.org>
 <20240111064208.2969599-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111064208.2969599-2-chao@kernel.org>

Cleaned up a bit:

--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1443,13 +1443,14 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
 }

 static int f2fs_write_raw_pages(struct compress_ctx *cc,
-                                       int *submitted,
+                                       int *submitted_p,
                                        struct writeback_control *wbc,
                                        enum iostat_type io_type)
 {
        struct address_space *mapping = cc->inode->i_mapping;
        struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
-       int _submitted, compr_blocks, ret = 0, i;
+       int submitted, compr_blocks, i;
+       int ret = 0;

        compr_blocks = f2fs_compressed_blocks(cc);

@@ -1492,7 +1493,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
                if (!clear_page_dirty_for_io(cc->rpages[i]))
                        goto continue_unlock;

-               ret = f2fs_write_single_data_page(cc->rpages[i], &_submitted,
+               ret = f2fs_write_single_data_page(cc->rpages[i], &submitted,
                                                NULL, NULL, wbc, io_type,
                                                compr_blocks, false);
                if (ret) {
@@ -1514,7 +1515,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
                        goto out;
                }

-               *submitted += _submitted;
+               *submitted_p += submitted;
        }

 out:

On 01/11, Chao Yu wrote:
> When we overwrite compressed cluster w/ normal cluster, we should
> not unlock cp_rwsem during f2fs_write_raw_pages(), otherwise data
> will be corrupted if partial blocks were persisted before CP & SPOR,
> due to cluster metadata wasn't updated atomically.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 20 ++++++++++++++------
>  fs/f2fs/data.c     |  3 ++-
>  2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 9940b7886e5d..bf4cfab67aec 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1448,7 +1448,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  					enum iostat_type io_type)
>  {
>  	struct address_space *mapping = cc->inode->i_mapping;
> -	int _submitted, compr_blocks, ret, i;
> +	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
> +	int _submitted, compr_blocks, ret = 0, i;
>  
>  	compr_blocks = f2fs_compressed_blocks(cc);
>  
> @@ -1463,6 +1464,10 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  	if (compr_blocks < 0)
>  		return compr_blocks;
>  
> +	/* overwrite compressed cluster w/ normal cluster */
> +	if (compr_blocks > 0)
> +		f2fs_lock_op(sbi);
> +
>  	for (i = 0; i < cc->cluster_size; i++) {
>  		if (!cc->rpages[i])
>  			continue;
> @@ -1495,26 +1500,29 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>  				unlock_page(cc->rpages[i]);
>  				ret = 0;
>  			} else if (ret == -EAGAIN) {
> +				ret = 0;
>  				/*
>  				 * for quota file, just redirty left pages to
>  				 * avoid deadlock caused by cluster update race
>  				 * from foreground operation.
>  				 */
>  				if (IS_NOQUOTA(cc->inode))
> -					return 0;
> -				ret = 0;
> +					goto out;
>  				f2fs_io_schedule_timeout(DEFAULT_IO_TIMEOUT);
>  				goto retry_write;
>  			}
> -			return ret;
> +			goto out;
>  		}
>  
>  		*submitted += _submitted;
>  	}
>  
> -	f2fs_balance_fs(F2FS_M_SB(mapping), true);
> +out:
> +	if (compr_blocks > 0)
> +		f2fs_unlock_op(sbi);
>  
> -	return 0;
> +	f2fs_balance_fs(sbi, true);
> +	return ret;
>  }
>  
>  int f2fs_write_multi_pages(struct compress_ctx *cc,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 81f9e2cc49e2..b171a9980f6a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2839,7 +2839,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  		.encrypted_page = NULL,
>  		.submitted = 0,
>  		.compr_blocks = compr_blocks,
> -		.need_lock = LOCK_RETRY,
> +		.need_lock = compr_blocks ? LOCK_DONE : LOCK_RETRY,
>  		.post_read = f2fs_post_read_required(inode) ? 1 : 0,
>  		.io_type = io_type,
>  		.io_wbc = wbc,
> @@ -2920,6 +2920,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
>  	if (err == -EAGAIN) {
>  		err = f2fs_do_write_data_page(&fio);
>  		if (err == -EAGAIN) {
> +			f2fs_bug_on(sbi, compr_blocks);
>  			fio.need_lock = LOCK_REQ;
>  			err = f2fs_do_write_data_page(&fio);
>  		}
> -- 
> 2.40.1

