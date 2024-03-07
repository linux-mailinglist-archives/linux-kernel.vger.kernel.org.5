Return-Path: <linux-kernel+bounces-96023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40128875630
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242331C20E14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E58713473E;
	Thu,  7 Mar 2024 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ri7vNUT6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D5134CDB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836653; cv=none; b=tJ/WNnqu547e6ciI9rRxdJTpGHYHdgnHViDlkz0pyjvevqmqhd1P5UwmJJG7HNv4VtBuS1UZyOA22I1gqQ2ApvVHN2ae+rUZcVAblN3OBRXb4SqJwaP9cxEOl59XBELjbRG/o2p2WWrUM/QFKO8x30o9XUgOGsPF45h/e3TkhMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836653; c=relaxed/simple;
	bh=Xc4eMaeP9TxUHMhYQ28rw5FYDBXjNUTmMl4vW5n4qjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ol6o75m+dOF027bKEEBCYh/V6IPpDIYpfh3Zsp5bShKgTyo+D06TAY6Jwr7OkhMMLfGVbHILkGXKlaj2TBSPbi+xD5cIDyQQ6YjCH4PHpUl/qIw49M93R9d5MTsOuPlskSnla/Gjur85UvODZ1OT5Z0PzI/XaRN0o0JeTbwAGbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ri7vNUT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00116C433C7;
	Thu,  7 Mar 2024 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709836653;
	bh=Xc4eMaeP9TxUHMhYQ28rw5FYDBXjNUTmMl4vW5n4qjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ri7vNUT6uTbG/zFJOvAI2CaaWyIyglBRNdUZm0SRmIvRJ2UMLKCPuqjZqAF9t/3zT
	 TQLFYQKhJaDx2cb90MsUTdtf9yHlzXvM1cNfYuHR9rEiGUBwMOhXpxn9HMZOTJAfab
	 dl0pB32g8DEF0xcYa0Qj2R7tkIUnPgOacTP4DMo8IQD8RCgt0WpQyFYZHeUqUloat1
	 vH4md5RKqkPEvc0NmxHO0nMgdiBPWp0QoScGINSJwbWpQ8e6VhQlJhwwUGrO2uYQJt
	 0sfVvkpJmzipJpxyBYgfJsVmyK4HLP9kvlgcZOtGBhNoxyWf6PXcWKH+NymeTOyYW4
	 xpMZAvTYOFshw==
Date: Thu, 7 Mar 2024 10:37:31 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to truncate meta inode pages forcely
Message-ID: <ZeoJa705xDrPRNQY@google.com>
References: <20240307151235.3864725-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307151235.3864725-1-chao@kernel.org>

On 03/07, Chao Yu wrote:
> Below race case can cause data corruption:
> 
> Thread A				GC thread
> - f2fs_inplace_write_data
> 					- gc_data_segment
> 					 - ra_data_block
> 					  - locked meta_inode page
>  - invalidate_mapping_pages
>  : fail to invalidate meta_inode page
>    due to lock failure or dirty|writeback
>    status

Wasn't the original data page locked in both cases?

>  - f2fs_submit_page_bio
>  : write last dirty data to old blkaddr
> 					 - move_data_block
> 					  - load old data from meta_inode page
> 					  - f2fs_submit_page_write
> 					  : write old data to new blkaddr
> 
> Because invalidate_mapping_pages() will skip invalidating page when the
> page has unclear status including locked, dirty, writeback and so on, so
> we need to use truncate_inode_pages_range() instead of
> invalidate_mapping_pages() to make sure meta_inode page will be dropped.
> 
> Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
> Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/checkpoint.c    |  5 +++--
>  fs/f2fs/f2fs.h          | 28 +++++++++++++++++++++++++++-
>  fs/f2fs/segment.c       |  5 ++---
>  include/linux/f2fs_fs.h |  1 +
>  4 files changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index a09a9609e228..55b7d2cf030f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1598,8 +1598,9 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	 */
>  	if (f2fs_sb_has_encrypt(sbi) || f2fs_sb_has_verity(sbi) ||
>  		f2fs_sb_has_compression(sbi))
> -		invalidate_mapping_pages(META_MAPPING(sbi),
> -				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1);
> +		f2fs_bug_on(sbi,
> +			invalidate_inode_pages2_range(META_MAPPING(sbi),
> +				MAIN_BLKADDR(sbi), MAX_BLKADDR(sbi) - 1));
>  
>  	f2fs_release_ino_entry(sbi, false);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4836e7cb0efe..9814e5981a6a 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4655,10 +4655,36 @@ static inline bool f2fs_is_readonly(struct f2fs_sb_info *sbi)
>  	return f2fs_sb_has_readonly(sbi) || f2fs_readonly(sbi->sb);
>  }
>  
> +static inline void f2fs_truncate_meta_inode_pages(struct f2fs_sb_info *sbi,
> +					block_t blkaddr, unsigned int cnt)
> +{
> +	bool need_submit = false;
> +	int i = 0;
> +
> +	do {
> +		struct page *page;
> +
> +		page = find_get_page(META_MAPPING(sbi), blkaddr + i);
> +		if (page) {
> +			if (PageWriteback(page))
> +				need_submit = true;
> +			f2fs_put_page(page, 0);
> +		}
> +	} while (++i < cnt && !need_submit);
> +
> +	if (need_submit)
> +		f2fs_submit_merged_write_cond(sbi, sbi->meta_inode,
> +							NULL, 0, DATA);
> +
> +	truncate_inode_pages_range(META_MAPPING(sbi),
> +			F2FS_BLK_TO_BYTES((loff_t)blkaddr),
> +			F2FS_BLK_END_BYTES((loff_t)(blkaddr + cnt - 1)));
> +}
> +
>  static inline void f2fs_invalidate_internal_cache(struct f2fs_sb_info *sbi,
>  								block_t blkaddr)
>  {
> -	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr);
> +	f2fs_truncate_meta_inode_pages(sbi, blkaddr, 1);
>  	f2fs_invalidate_compress_page(sbi, blkaddr);
>  }
>  
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 4ff3b2d14ddf..20af48d7f784 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3741,8 +3741,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>  	}
>  
>  	if (fio->post_read)
> -		invalidate_mapping_pages(META_MAPPING(sbi),
> -				fio->new_blkaddr, fio->new_blkaddr);
> +		f2fs_truncate_meta_inode_pages(sbi, fio->new_blkaddr, 1);
>  
>  	stat_inc_inplace_blocks(fio->sbi);
>  
> @@ -3932,7 +3931,7 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
>  	for (i = 0; i < len; i++)
>  		f2fs_wait_on_block_writeback(inode, blkaddr + i);
>  
> -	invalidate_mapping_pages(META_MAPPING(sbi), blkaddr, blkaddr + len - 1);
> +	f2fs_truncate_meta_inode_pages(sbi, blkaddr, len);
>  }
>  
>  static int read_compacted_summaries(struct f2fs_sb_info *sbi)
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 755e9a41b196..a357287eac1e 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -27,6 +27,7 @@
>  
>  #define F2FS_BYTES_TO_BLK(bytes)	((bytes) >> F2FS_BLKSIZE_BITS)
>  #define F2FS_BLK_TO_BYTES(blk)		((blk) << F2FS_BLKSIZE_BITS)
> +#define F2FS_BLK_END_BYTES(blk)		(F2FS_BLK_TO_BYTES(blk + 1) - 1)
>  
>  /* 0, 1(node nid), 2(meta nid) are reserved node id */
>  #define F2FS_RESERVED_NODE_NUM		3
> -- 
> 2.40.1

