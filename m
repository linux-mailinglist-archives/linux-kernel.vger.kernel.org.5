Return-Path: <linux-kernel+bounces-42213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223D883FDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFFB1C21994
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EA745BF0;
	Mon, 29 Jan 2024 06:09:01 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870984C618
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508541; cv=none; b=isj7wsY36ASKaRPaFqTxTx6KlWFaHz+OY/RzZ8dOW/fITr51x4t2EdYpib7sy6LliDANJ1tyn/kdjjq/qOmJKhnk+cCYF/aGIF9X3TCv1xHlYP/AVjvhik88Soq5lGLrhZCkvCy+iqbKmaAjl+Pv6tol+JhuiKlRtynMKVskbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508541; c=relaxed/simple;
	bh=jAALexVfdB8CH5+NUTWXDLvoHfK5Y5gEBA7XS2daLRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5ohcnCZpGL6d/sggYF46BmUUDL+WQ3CySyhzpf36wS1QGDZzGJKwqUEyEOHMVEnPLjw8xYflILvhr1KnZJ5FBXyJ6HpHLDavbqxq7PwEp+R/Mp3WlBbU1U9PyGAUFRMorhdH1AqkGdZZ4tHKyJ9C+HxJiFpsDAjG8nSm0/487A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50B8C68B05; Mon, 29 Jan 2024 07:08:54 +0100 (CET)
Date: Mon, 29 Jan 2024 07:08:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
	iommu@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/2] swiotlb: Enforce page alignment in swiotlb_alloc()
Message-ID: <20240129060853.GB19258@lst.de>
References: <20240126151956.10014-1-will@kernel.org> <20240126151956.10014-3-will@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126151956.10014-3-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 26, 2024 at 03:19:56PM +0000, Will Deacon wrote:
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 25febb9e670c..92433ea9f2d2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1647,6 +1647,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
>  		return NULL;
>  
>  	tlb_addr = slot_addr(pool->start, index);
> +	if (!PAGE_ALIGNED(tlb_addr)) {
> +		dev_WARN_ONCE(dev, 1, "Cannot return 'struct page *' for non page-aligned swiotlb addr 0x%pa.\n",
> +			      &tlb_addr);
> +		swiotlb_release_slots(dev, tlb_addr);
> +		return NULL;
> +	}
>  
>  	return pfn_to_page(PFN_DOWN(tlb_addr));

So PFN_DOWN aligns the address and thus per se converting the unaligned
address isn't a problem.  That being said swiotlb obviously should never
allocate unaligned addresses, but the placement of this check feels
odd to me.  Also because it only catches swiotlb_alloc and not the
map side.

Maybe just throw a WARN_ON_ONCE into slot_addr() ?

>  }
> -- 
> 2.43.0.429.g432eaa2c6b-goog
---end quoted text---

