Return-Path: <linux-kernel+bounces-161731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4408B5042
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3574FB20C50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7BA6FD0;
	Mon, 29 Apr 2024 04:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sZ7HLoOs"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE973372;
	Mon, 29 Apr 2024 04:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714365399; cv=none; b=MdCRPJzMuC2sDxJrzWE1jMIOc1Tl+ZG02OuM89RHmgQ8bkQYG7dmAXfGv5GDqlujWEEp63349r984Hy2ey8bdN7j/6f87XHlTt0aIG3Y3kXcj8O8jfmiHLa3pxbJrLPXieqzzWGUBJtXHr9gZvQ1Ts3x2npp6KujsXFDwuNtlmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714365399; c=relaxed/simple;
	bh=0TEbWLRVmx0NrCEqsbCKI72JXdFePC8Jatm2nCWzw6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4/oDtkF5kvItehweHlJxRMiEt+CsD8/SSMEyqFOPmpVDhJiSmIss+yKgl+tEuGo/f7IDB850KozdXjqGIBug3IRuDAChqVSJj2weElAcjWJ8fKewvRrQDJUru4S3le5vD32nIMu4hXCCr1K4PBI91VL2gOQ5JiJx/C0Pk2mibo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sZ7HLoOs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=04scR3eROCXqOCzcxjuahB7wfjxGYZ3R+aBj3XOaRvI=; b=sZ7HLoOsUy+JxLelKGvZxj3Mbo
	2vlWc5r82gmbmCriO9GK+RMAy6G0il/e03OAvSoY8xaLsH0HnF5yLi1anUOJePCVldZg4dCT+lxH+
	ASDpY/PoMFV+F6KhT4HPbP9bCWkrMwQzo3Z2eAGPQ3YO2zWTU5tq3hbPrWKFFch3WE5E2534j0+/Z
	kD4dgrMdoGPA32mWL7XmUlobRS0J4KOFoLEG+/Fzi2wokB3uXHyID4r0+FdMW1ScJxXL+G1n9TUbl
	y+/f+zdVjc7iexyxIiWAxl17nQAAHS3zgThlQko8oXMqfpJJ0EYRBJ9BYKXKBAekjy3ZrQl4WKShg
	8car23NQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Iki-00000001QX3-1fYF;
	Mon, 29 Apr 2024 04:36:32 +0000
Date: Sun, 28 Apr 2024 21:36:32 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
	airlied@gmail.com, daniel@ffwll.ch, krzk@kernel.org,
	alim.akhtar@samsung.com, m.szyprowski@samsung.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/exynos: Add check for dma_set_max_seg_size
Message-ID: <Zi8j0J9PoOiMrA6H@infradead.org>
References: <20240429023833.1869154-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429023833.1869154-1-nichen@iscas.ac.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 29, 2024 at 10:38:33AM +0800, Chen Ni wrote:
> Add check for the return value of dma_set_max_seg_size() and return
> the error if it fails in order to catch the error.
> 
> Fixes: ddfd4ab6bb08 ("drm/exynos: Fix dma_parms allocation")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

With my dma-mapping hat maintainer on I think we should remove the
return value from it.  It can only return -EIO or 0, and the first
only if the bus has not set up a dma_params structure for the device.
I'd much rather WARN_ON() on that, as it is is a grave error to either
call dma_set_max_seg_size on a device that is on a bus that doesn't
support DMA at all, or for the bus maintainer to accidentlaly drop it.

Feel free to add the patch if exynos has a strict error checking policy,
but it's rather pointless and I'll add removing the return value to my
ever growing TODO list.


