Return-Path: <linux-kernel+bounces-11691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9654281EA13
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 22:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CCB1F21764
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192C4C90;
	Tue, 26 Dec 2023 21:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpqBw1eZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D0D4C6F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 21:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA36C433C7;
	Tue, 26 Dec 2023 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703624524;
	bh=K0bo8nLzMp9puoOTzcakLFzOMnpwS+Kk1wV1MTjYTZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpqBw1eZLSLnPCK7wTiVCaR+Of43NUVzd53hfhc4vgi477XgWpYMe1EFRNTug3ilx
	 c/kf4fFjhhgquE7lztqo2TfdE9paBXnmWMguJRISHys/TeyBNFR2RptTB4pPN8LFbH
	 /67aVhtG4mWWz4YvLqIp+CJYvSW7pJ/zMGu29WJk5KdGm57wnsh6hP/aYE4VwOcLFL
	 A7hBdHIUcGViC8S/GuoE4gRWQHMIZzjZiedEo/4THULWAJnxAGLUIaP1kfX2iHz25K
	 Cgcw3hphoh+kQirXlnXC9tvZMHZiaaz6co2meOFajqRWccLOEni0Kvu1Ug81ceR++L
	 CvNX/DM5y8Jcw==
Date: Tue, 26 Dec 2023 13:02:03 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] f2fs: compress: fix to guarantee persisting
 compressed blocks by CP
Message-ID: <ZYs_S0VLFFnV1g-3@google.com>
References: <20231220135934.3471407-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220135934.3471407-1-chao@kernel.org>

On 12/20, Chao Yu wrote:
> If data block in compressed cluster is not persisted with metadata
> during checkpoint, after SPOR, the data may be corrupted, let's
> guarantee to write compressed page by checkpoint.
> 
> Fixes: 4c8ff7095bef ("f2fs: support data compression")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c |  3 ++-
>  fs/f2fs/data.c     | 12 +++++++++---
>  fs/f2fs/f2fs.h     |  3 ++-
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 5b076329e9bf..1122db8cc0b0 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1442,6 +1442,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
>  	struct f2fs_sb_info *sbi = bio->bi_private;
>  	struct compress_io_ctx *cic =
>  			(struct compress_io_ctx *)page_private(page);
> +	enum count_type type = WB_DATA_TYPE(page);
>  	int i;
>  
>  	if (unlikely(bio->bi_status))
> @@ -1449,7 +1450,7 @@ void f2fs_compress_write_end_io(struct bio *bio, struct page *page)
>  
>  	f2fs_compress_free_page(page);
>  
> -	dec_page_count(sbi, F2FS_WB_DATA);
> +	dec_page_count(sbi, type);
>  
>  	if (atomic_dec_return(&cic->pending_pages))
>  		return;
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d28c97282e68..6c72a6e86ba8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -48,7 +48,7 @@ void f2fs_destroy_bioset(void)
>  	bioset_exit(&f2fs_bioset);
>  }
>  
> -static bool __is_cp_guaranteed(struct page *page)
> +bool f2fs_is_cp_guaranteed(struct page *page)
>  {
>  	struct address_space *mapping = page->mapping;
>  	struct inode *inode;
> @@ -66,7 +66,7 @@ static bool __is_cp_guaranteed(struct page *page)
>  		return true;
>  
>  	if (f2fs_is_compressed_page(page))
> -		return false;
> +		return true;
>  	if ((S_ISREG(inode->i_mode) && IS_NOQUOTA(inode)) ||
>  			page_private_gcing(page))
>  		return true;
> @@ -1007,6 +1007,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
>  	struct f2fs_bio_info *io = sbi->write_io[btype] + fio->temp;
>  	struct page *bio_page;
> +	enum count_type type;
>  
>  	f2fs_bug_on(sbi, is_read_io(fio->op));
>  
> @@ -1046,7 +1047,12 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	/* set submitted = true as a return value */
>  	fio->submitted = 1;
>  
> -	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> +	type = WB_DATA_TYPE(bio_page);
> +	/* override count type if page is compressed one */
> +	if (fio->compressed_page)
> +		type = WB_DATA_TYPE(fio->compressed_page);

Doesn't bio_page already point fio->compressed_page?

> +
> +	inc_page_count(sbi, type);
>  
>  	if (io->bio &&
>  	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 76e9a8682e38..bcb3940ab5ba 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1092,7 +1092,7 @@ struct f2fs_sm_info {
>   * f2fs monitors the number of several block types such as on-writeback,
>   * dirty dentry blocks, dirty node blocks, and dirty meta blocks.
>   */
> -#define WB_DATA_TYPE(p)	(__is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
> +#define WB_DATA_TYPE(p)	(f2fs_is_cp_guaranteed(p) ? F2FS_WB_CP_DATA : F2FS_WB_DATA)
>  enum count_type {
>  	F2FS_DIRTY_DENTS,
>  	F2FS_DIRTY_DATA,
> @@ -3824,6 +3824,7 @@ void f2fs_init_ckpt_req_control(struct f2fs_sb_info *sbi);
>   */
>  int __init f2fs_init_bioset(void);
>  void f2fs_destroy_bioset(void);
> +bool f2fs_is_cp_guaranteed(struct page *page);
>  int f2fs_init_bio_entry_cache(void);
>  void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, struct bio *bio,
> -- 
> 2.40.1

