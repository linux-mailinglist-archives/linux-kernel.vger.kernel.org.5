Return-Path: <linux-kernel+bounces-84994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9941086AEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5000A285D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C623BBCA;
	Wed, 28 Feb 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pi2YBY6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28373501;
	Wed, 28 Feb 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121930; cv=none; b=mFGZE5puAl36xFns5ley+Xah+7c1BYo3tIHbz18r3QklUxjT5kMba2thPtmK7CurhxL39o5IDuXVzR52MaHNwFPXtuJ9M69fqP/IEYpG5nl6cn87qPUweZ5iRvRBw/VCyy+Lc5SENaVA2zmGS+HG1H6tv6+20EUOt6FTxKzRD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121930; c=relaxed/simple;
	bh=SU9EilANUxXGjBEPo0K/zUkP5ytJW6h7olNyIK9TmFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUx3DB2srBQDHMWZ/xdg+dDrcA3C8xSyMBtxsJKNKA9F74pjR8m3ey9gICa7lI383wVZWVPQyGhDZWdOsEMX2pK43fYKJekkXAOa50LpAE1hSB9e4D2v7IQV5M55i+KETUFKeECGKR4lMID74MnxVKo9ac9KPSEcD2ERE9IrST4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pi2YBY6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80324C433F1;
	Wed, 28 Feb 2024 12:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709121929;
	bh=SU9EilANUxXGjBEPo0K/zUkP5ytJW6h7olNyIK9TmFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pi2YBY6daQjrwS2RlLYQDvKF110QllmzVuDJBm0iiG4NU+5kvOFBKcXs1NQsocdty
	 op7bv2UvR80xWR9wIelLL8PLk1TYBUJC9Q/Ptte66JNOoMsEdGZ2TBULNfSxtuUAe9
	 sT8UdLi56LGCwFXNARDXCP3noKvhtXmNzQuOmshEvABbFstGte87DKbLLeljh+MVhC
	 GszhgCQkWJ3QITLL0qo++/OE9yh1H1vmrKPYwYL9zpvok8Xw4zy+5LvvNRyDpFEknA
	 4w/H+bdehwnzcTN0YeRiJJ0yQyfzzd+3+z78SzRBz0iOmuBg4aWncKu3qD1Fm2faOA
	 5K/cmbD3psHbg==
Date: Wed, 28 Feb 2024 12:05:23 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, iommu@lists.linux.dev,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Message-ID: <20240228120523.GA15054@willie-the-truck>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <Zd4CcL3Nnvybw2xF@infradead.org>
 <57c928e6-14a4-4724-8c07-e985a2bce522@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c928e6-14a4-4724-8c07-e985a2bce522@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 27, 2024 at 03:53:05PM +0000, Robin Murphy wrote:
> On 27/02/2024 3:40 pm, Christoph Hellwig wrote:
> > On Wed, Feb 21, 2024 at 11:35:04AM +0000, Will Deacon wrote:
> > > +static size_t iommu_dma_max_mapping_size(struct device *dev)
> > > +{
> > > +	if (is_swiotlb_active(dev) && dev_is_untrusted(dev))
> > > +		return swiotlb_max_mapping_size(dev);
> > 
> > Curious: do we really need both checks here?  If swiotlb is active
> > for a device (for whatever reason), aren't we then always bound
> > by the max size?  If not please add a comment explaining it.
> > 
> 
> Oh, good point - if we have an untrusted device but SWIOTLB isn't
> initialised for whatever reason, then it doesn't matter what
> max_mapping_size returns because iommu_dma_map_page() is going to bail out
> regardless.

Makes sense. Since this is all internal to the IOMMU DMA code, I can just
drop the first part of the check.

I'll get a v5 out shortly.

Will

