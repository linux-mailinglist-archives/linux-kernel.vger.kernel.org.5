Return-Path: <linux-kernel+bounces-162771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57438B604F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4782832C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4751272A7;
	Mon, 29 Apr 2024 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hStxyTpT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584DD126F1E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412523; cv=none; b=bSujPgWIGXnc8oGK95gVIP0jj3yos5XBgLjsGNOkeixYoc/D7kn3ZnAS1P/9HI38Joda2Q5lHafn8QgIQxqT700JQvhpHk7jQ8iz4Ro3x7RwoHYjBoqKITxmtBOg4wIXRFug5YYbrobYNbv7cyJf2cAug1thSuUYhUw5HFtJ1b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412523; c=relaxed/simple;
	bh=yakMz0hoQgUZe2Te30CXUQdBv3i+eTPVugrRBpkhO2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO6o3uoKYc9w3cPMaeqUsW5CFtKsLUT2AOsqZp5fa9lfKctfrDcEl8p0DSCovO0bO3aAtwmKql1fUadtuHB6hh5+KcWt/9uvtVpXCNbXygnqpZWEl32GkgAbLY84bkOJNhEWZsB/2McITIRhqd4VHtlZyNt68z1mC9yo4WY4+E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hStxyTpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87AC113CD;
	Mon, 29 Apr 2024 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714412522;
	bh=yakMz0hoQgUZe2Te30CXUQdBv3i+eTPVugrRBpkhO2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hStxyTpTfnLBwdqXiQlRLFW8Gl4zI5C6dALu44IQL4xttAJBcsC0KeMCg64+Z5sE+
	 tuI3LnRRLRjzcKrrpkoZLah4tCBrUMBIAHmHc1qsw4hTQiY6eKfZQLzf5eJmX/kEIR
	 lJOXCx1PWz2LAqI/xLrs6NkArYbrGPygrxThyBEpZkEZZ/JlKLjily3ZqfT0Q3IGqj
	 aMMxG9u6JcNWQE9372Cc2ZFWqrmHRX288M4QrkKLQjCbqT7r4HXIwEHnoF5nMDweGW
	 yWa1hm85jn1rsQAnbXD1QsKVtkz7TnxkHTiy6FPIqs0FPijcGLJ/BzUvg9HKqQwDrX
	 de+oih0b1BRRw==
Date: Mon, 29 Apr 2024 17:42:01 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Wu Bo <bo.wu@vivo.com>
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Wu Bo <wubo.oduw@gmail.com>,
	Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: Re: [PATCH] f2fs: fix block migration when section is not aligned to
 pow2
Message-ID: <Zi_b6alGIb2wAkb5@google.com>
References: <20240426104156.321701-1-bo.wu@vivo.com>
 <Zi_a0wEZpCNW8jHL@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi_a0wEZpCNW8jHL@google.com>

On 04/29, Jaegeuk Kim wrote:
> On 04/26, Wu Bo wrote:
> > As for zoned-UFS, f2fs section size is forced to zone size. And zone
> > size may not aligned to pow2.
> > 
> > Fixes: 859fca6b706e ("f2fs: swap: support migrating swapfile in aligned write mode")
> > Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > ---
> >  fs/f2fs/data.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index d9494b5fc7c1..7ff5ad3fd5dc 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3904,7 +3904,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
> >  	int nr_extents = 0;
> >  	unsigned long nr_pblocks;
> >  	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
> > -	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
> >  	unsigned int not_aligned = 0;
> >  	int ret = 0;
> >  
> > @@ -3942,8 +3941,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
> >  		pblock = map.m_pblk;
> >  		nr_pblocks = map.m_len;
> >  
> > -		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
> > -				nr_pblocks & sec_blks_mask ||
> > +		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
> > +				nr_pblocks % blks_per_sec ||
> 
> Modified a bit to address udiv issue like below. Let's see.

Ok, I took v2 instead of this.

> 
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3923,8 +3923,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
>         sector_t highest_pblock = 0;
>         int nr_extents = 0;
>         unsigned long nr_pblocks;
> +       u32 align;
>         unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
> -       unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
>         unsigned int not_aligned = 0;
>         int ret = 0;
> 
> @@ -3961,10 +3961,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
> 
>                 pblock = map.m_pblk;
>                 nr_pblocks = map.m_len;
> +               div_u64_rem(nr_pblocks, blks_per_sec, &align);
> 
> -               if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
> -                               nr_pblocks & sec_blks_mask ||
> -                               !f2fs_valid_pinned_area(sbi, pblock)) {
> +               if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
> +                               align || !f2fs_valid_pinned_area(sbi, pblock)) {
>                         bool last_extent = false;
> 
>                         not_aligned++;
> 
> >  				!f2fs_valid_pinned_area(sbi, pblock)) {
> >  			bool last_extent = false;
> >  
> > -- 
> > 2.25.1

