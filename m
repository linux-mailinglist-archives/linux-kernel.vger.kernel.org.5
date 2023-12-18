Return-Path: <linux-kernel+bounces-4239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83C817986
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6342B2214D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6615D73F;
	Mon, 18 Dec 2023 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gWY4ak9p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A122088
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E415C433C7;
	Mon, 18 Dec 2023 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1702923678;
	bh=9bcgPOv6UmU1GeS75GFbmWga4l75E2/oRtMHdcoeT9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gWY4ak9pO1B63mLNVWNRJeCKrRUrTZ0qx0UHVCp47Y8QqXG9dcGnZIf5db3rQftdI
	 Sp3kacllTpr5yRica6q9UyB6ntXw73TgxJlNLfeTCsCnG+3yu7t9k5K5saUyOFza70
	 M9+/UJO1tcuvMdDMOV8vgg5vcAlDtftZ2NYkBb0M=
Date: Mon, 18 Dec 2023 10:21:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: shr@devkernel.io, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] mm: fix arithmetic for bdi min_ratio and max_ratio
Message-Id: <20231218102117.c91ab02353ff76b952f3ec9e@linux-foundation.org>
In-Reply-To: <20231218031640.77983-1-jefflexu@linux.alibaba.com>
References: <20231218031640.77983-1-jefflexu@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Dec 2023 11:16:40 +0800 Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> bdi->[min|max]_ratio are both part per million.  Fix the wrong
> arithmetic when setting bdi's min_ratio and max_ratio.
> 
> Fixes: efc3e6ad53ea ("mm: split off __bdi_set_max_ratio() function")
> Fixes: 8021fb3232f2 ("mm: split off __bdi_set_min_ratio() function")

As we have two Fixes:, it would be better to have two patches please.

> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -692,7 +692,6 @@ static int __bdi_set_min_ratio(struct backing_dev_info *bdi, unsigned int min_ra
>  
>  	if (min_ratio > 100 * BDI_RATIO_SCALE)
>  		return -EINVAL;
> -	min_ratio *= BDI_RATIO_SCALE;
>  
>  	spin_lock_bh(&bdi_lock);
>  	if (min_ratio > bdi->max_ratio) {
> @@ -729,7 +728,8 @@ static int __bdi_set_max_ratio(struct backing_dev_info *bdi, unsigned int max_ra
>  		ret = -EINVAL;
>  	} else {
>  		bdi->max_ratio = max_ratio;
> -		bdi->max_prop_frac = (FPROP_FRAC_BASE * max_ratio) / 100;
> +		bdi->max_prop_frac = div64_u64(FPROP_FRAC_BASE * max_ratio,
> +					       100UL * BDI_RATIO_SCALE);
>  	}
>  	spin_unlock_bh(&bdi_lock);

Does this change have any observable runtime effects?  If so, what are they?

