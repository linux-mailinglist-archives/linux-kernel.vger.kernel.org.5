Return-Path: <linux-kernel+bounces-141355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB86A8A1E5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3768B32E00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328261CB32E;
	Thu, 11 Apr 2024 16:51:23 +0000 (UTC)
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D771CB31E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712854282; cv=none; b=KjtRqwHWGbGfDkc1ii/nYj+hnl4h8DA4ziExTddNUnkVSlXQYLKf27MoY3Idj5TpOP1EC+mn7LhNWA+EjLV+jBjmXLVsSe9nSY5gM0LzVUTwUzYs9NnAS7YHt2hZaGCUyG3eE54Q7G1HFn6CX0SmjglnFmOk2TIPAf8O73BOyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712854282; c=relaxed/simple;
	bh=Os98TDCvVSWZkblSP4h3+hUapsolTLDw4CY/UVEaWYg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d4dZbpFZlifIGdPw9PfgLrZTcQfFQPjFNM93Pi5mGnwR5w6wDplxTguhoXTyC/GwwfBkIOUmA/5dscnEsZYBD6eCRHXN9+vUZFBCVUUiQsFPYtBwUwnU5/y/+pbyEZ/HwhcVLk2MfuOm9qE+hcvtg5Uq14m0+Twn4r8lg4Y/+yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=fail smtp.mailfrom=linux.com; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.com
Received: by gentwo.org (Postfix, from userid 1003)
	id DF1AF40AFA; Thu, 11 Apr 2024 09:51:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id DE85240A90;
	Thu, 11 Apr 2024 09:51:13 -0700 (PDT)
Date: Thu, 11 Apr 2024 09:51:13 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@linux.com>
To: Haifeng Xu <haifeng.xu@shopee.com>
cc: vbabka@suse.cz, penberg@kernel.org, rientjes@google.com, 
    iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, 
    roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slub: Clear __GFP_COMP flag when allocating 0 order
 page
In-Reply-To: <20240411091832.608280-1-haifeng.xu@shopee.com>
Message-ID: <5482360c-0a0b-e5f5-b88e-4a6ec4d43f7d@linux.com>
References: <20240411091832.608280-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 11 Apr 2024, Haifeng Xu wrote:

> @@ -1875,6 +1875,13 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
> 	struct slab *slab;
> 	unsigned int order = oo_order(oo);
>
> +	/*
> +	 * If fallback to the minimum order allocation and the order is 0,
> +	 * clear the __GFP_COMP flag.
> +	 */
> +	if (order == 0)
> +		flags = flags & ~__GFP_COMP;


This would be better placed in allocate_slab() when the need for a
fallback to a lower order is detected after the first call to alloc_slab_page().

