Return-Path: <linux-kernel+bounces-162764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E48B603B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFD2B203A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA41126F03;
	Mon, 29 Apr 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LuVzY315"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCC8627D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412245; cv=none; b=CXTM3S1X5x/W4U/8td4aoUR9ewS/ZFNSkl5PU8lF8KmFBkOkm4gGEP4hXzBW5PWyR09oANADPaVQaokDwOI5bdD2AlkpdrVbahwqOQlQcWfdFutG6zDVznYGkgpNUiqAteaCE4T7IebciG5kNRMuxPrcwG5l8tLMr0Is27XK4Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412245; c=relaxed/simple;
	bh=CmTPcX7OUPyQ3Hu3X55BRSo5T1RVAsPgJMLD9lcSEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it8F++Dn9OT9a3dL/wytz8dBwmzmmEcYkAF7Y8rNemhQ421ck0FZWdMqUDOoFIwTb1FBafBq4I3fGfSATqKjNwOJEHKbywMNG4AndxfNmJZQSEajdbr4E+9hmOzZL41QEDiAVFolbeHG6fyd4o7+45HxmCu3+E/X1oKJ/CQoh5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LuVzY315; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5194C113CD;
	Mon, 29 Apr 2024 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714412245;
	bh=CmTPcX7OUPyQ3Hu3X55BRSo5T1RVAsPgJMLD9lcSEow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LuVzY315Qe6YQjT1RqPxGUFNH25uTyzjfgK0PmywwzC6G31QqPVrU/YIR/RBMizkj
	 1KAMudmN+EdonfHxGzFk68ciz3h9Aj+KfGOU3Z0CT5WA5Km2yWugWmLutUwhq03qvi
	 f7+1xArapIraRHp4+NxHA72jPsFQ9uD8yJh1Yn8FEz63T/tRC7cZqt+YXlgRjQxTh+
	 x489L02XpNfhVvu1zE+HmxqgKxKn/XLcA/0/E/Rk/7+AZd9i40VJEnRwuKXLjZo97Q
	 AKwHn5XHOpIDYEgHo2OGSck96vcq1CymDyIX6VcoqXoSso99i+KnzX+2dBpEujbIrI
	 hbEpLoSayrqAw==
Date: Mon, 29 Apr 2024 17:37:23 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] f2fs: fix block migration when section is not aligned to
 pow2
Message-ID: <Zi_a0wEZpCNW8jHL@google.com>
References: <20240426104156.321701-1-bo.wu@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426104156.321701-1-bo.wu@vivo.com>

On 04/26, Wu Bo wrote:
> As for zoned-UFS, f2fs section size is forced to zone size. And zone
> size may not aligned to pow2.
> 
> Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/data.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5fc7c1..7ff5ad3fd5dc 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3904,7 +3904,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
>  	int nr_extents = 0;
>  	unsigned long nr_pblocks;
>  	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
> -	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
>  	unsigned int not_aligned = 0;
>  	int ret = 0;
>  
> @@ -3942,8 +3941,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
>  		pblock = map.m_pblk;
>  		nr_pblocks = map.m_len;
>  
> -		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
> -				nr_pblocks & sec_blks_mask ||
> +		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
> +				nr_pblocks % blks_per_sec ||

Modified a bit to address udiv issue like below. Let's see.

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3923,8 +3923,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
        sector_t highest_pblock = 0;
        int nr_extents = 0;
        unsigned long nr_pblocks;
+       u32 align;
        unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
-       unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
        unsigned int not_aligned = 0;
        int ret = 0;

@@ -3961,10 +3961,10 @@ static int check_swap_activate(struct swap_info_struct *sis,

                pblock = map.m_pblk;
                nr_pblocks = map.m_len;
+               div_u64_rem(nr_pblocks, blks_per_sec, &align);

-               if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-                               nr_pblocks & sec_blks_mask ||
-                               !f2fs_valid_pinned_area(sbi, pblock)) {
+               if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+                               align || !f2fs_valid_pinned_area(sbi, pblock)) {
                        bool last_extent = false;

                        not_aligned++;

>  				!f2fs_valid_pinned_area(sbi, pblock)) {
>  			bool last_extent = false;
>  
> -- 
> 2.25.1

