Return-Path: <linux-kernel+bounces-165976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9837C8B9420
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83B31C21465
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764231F95A;
	Thu,  2 May 2024 05:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PAwC3HGz"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54451CD2D;
	Thu,  2 May 2024 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714626460; cv=none; b=t4XmXykYh1fdk64f9sqksl4SEqJwSOJauhMwIcfFMOtqZO3PIpWjMVDRM2ZM2pNIZ96umh+zPpSNHz071XM3sMtYuyMnz1YTkWGHpBJIxwQ4rRvQ8zsll7Kiin/ca962FWaHcXeJA2amkysOU+eI+qcABqwxuFS8jqINkyGPonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714626460; c=relaxed/simple;
	bh=5amkvJXIOOx9Ih8Muv99+02q4fS2kw8BvMZGGjfEC+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDtOc49hCopIN17HIhpENpSjJckt06YrTg3ywnzdlXaQx/aVZkJL1pVwrK4Y/axIwsGO5mFrwNMlS7FxlpnU13w5dC/cDD3ATTnFsVsD0hJuDD0pgwXV/dYDLQgqH3/vCb/UspuJhWASC+meET5p92ydyb6sth0h0bH+iv9WsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PAwC3HGz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5amkvJXIOOx9Ih8Muv99+02q4fS2kw8BvMZGGjfEC+g=; b=PAwC3HGzIePWCQ0yHyz8Bb+PhF
	FqB2JAjzpMjOl51lbRLUYcHVwT+HzhbkR5zgW7jgdslvznS6S/gC1rnNBbMP6OTIjDXrFJmYYImtA
	FU9OhWDPruICJEBrU008uW+W5j0mhCVn6O2XxRULjN1pn7+wPyQt2eenzsiSTZZ8CW4jDJhMORiwQ
	Izq/NNYzoXIjkwU6Ut0yDfTr/n+kpFw07YmATMN4qcD+18wOkiQ8dyeams8en1F9ElCFTR8k4Tvef
	T2umHYKSjWnHTSnHFTgQHJLNWmCWsjrpY49PeFyd36XgkJa4pfIQY+xMhRtQvzVU9zGhvpB14zvpV
	BH6dDqXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2OfP-0000000BUUU-36bi;
	Thu, 02 May 2024 05:07:35 +0000
Date: Wed, 1 May 2024 22:07:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "T.J. Mercier" <tjmercier@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	isaacmanjarres@google.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/dma: Respect SWIOTLB force_bounce
Message-ID: <ZjMfl2G377qexhi-@infradead.org>
References: <20240501201319.586289-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501201319.586289-1-tjmercier@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 01, 2024 at 08:13:18PM +0000, T.J. Mercier wrote:
> iommu_dma_map_page and iommu_dma_map_sg conditionally use SWIOTLB, but
> checking if force_bounce is set for the device is not part of that
> condition. Check if devices have requested to force SWIOTLB use as part
> of deciding to take the existing SWIOTLB paths.

This fails to explain why you'd want this somewhat surprising behavior,
and why you consider it a bug fix.


