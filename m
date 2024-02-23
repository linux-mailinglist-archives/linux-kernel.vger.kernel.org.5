Return-Path: <linux-kernel+bounces-79145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FDC861E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8B21F23CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB81482E7;
	Fri, 23 Feb 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMzxHdcl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C3BD2E6
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721566; cv=none; b=ZuWshVlz9o08eugevB+dSSsnOA7fAEBdx7/b0EDly8diEARELEDZ68xvJ9sebQoveBAOurx7bN/EkY4AFcDoiRn+UM+IWWvJiJ+/fpyIFGGVgTHECKvMrzEdIaafR5Z8sJGq6YxYXizy7hcJafKJ3QBRgQgb0d0wHsxgBFntiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721566; c=relaxed/simple;
	bh=q7R6IgPxIsCPMj1t4tCxec6CBo+3s7llxTM3no8YXIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3kfrOEcHsv5PJIGUKqbGMUW/mvDe2Wen/+SBk0hIxjJ/mlCPuQ94GVzYv8WmLvzBpsMpjKhaCnuoYABT6FxvHpZ6y/uXeAl6l/bKKFNIdH3AUSmDS2uSZNxcwJw0DimvVKEbRfPSkeJ0nfK08g9rDtPEKrxwh0l0Vc+sQ0pnOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMzxHdcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF4FC433C7;
	Fri, 23 Feb 2024 20:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708721565;
	bh=q7R6IgPxIsCPMj1t4tCxec6CBo+3s7llxTM3no8YXIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMzxHdcl+hB2M5VyoTwKgnxDrAxFH6ZYh9bZSaw1usySdggmS6VNgqi0JGXtBBx4A
	 Fm7B+DaDx/Hewu+nBTgYy1iewHDuhy88fenANA/j/adwft+L4hQJfxdMm+yzY4Of1N
	 k9v5OaDY7jjLWHTdTBWKsZgY4IpvGSXTmSOxzMc6MTbcssm3HDEMAGWuuQE6mVlPXm
	 AzkpP8m1VIpkYpl6Bd1XkH1NPdyxycNoztFMGA14PVX6Xe3/+5ZIvHzckbQECR4eS8
	 +RXvVwBfoS/UmvpUhPJZnHH+R0JWJ/0+ifPrI2kTULjqpUTdZlNgRbijiAbNdwpOfP
	 IckR3cOZA8Nkw==
Date: Fri, 23 Feb 2024 12:52:44 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to use correct segment type in
 f2fs_allocate_data_block()
Message-ID: <ZdkFnLirvxRdenX0@google.com>
References: <20240223025403.1180558-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223025403.1180558-1-chao@kernel.org>

On 02/23, Chao Yu wrote:
> @type in f2fs_allocate_data_block() indicates log header's type, it
> can be CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC, rather than
> type of data/node, however IS_DATASEG()/IS_NODESEG() only accept later
> one, fix it.
> 
> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/segment.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index d0209ea77dd2..76422f50e6cc 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3505,12 +3505,12 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
>  	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
>  
> -	if (IS_DATASEG(type))
> +	if (IS_DATASEG(se->type))

We have se only when type is CURSEG_ALL_DATA_ATGC. We may need to change
IS_DATASEG()?

>  		atomic64_inc(&sbi->allocated_data_blocks);
>  
>  	up_write(&sit_i->sentry_lock);
>  
> -	if (page && IS_NODESEG(type)) {
> +	if (page && IS_NODESEG(se->type)) {
>  		fill_node_footer_blkaddr(page, NEXT_FREE_BLKADDR(sbi, curseg));
>  
>  		f2fs_inode_chksum_set(sbi, page);
> -- 
> 2.40.1

