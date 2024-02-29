Return-Path: <linux-kernel+bounces-86757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3265386CA52
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0C02845AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0857E76F;
	Thu, 29 Feb 2024 13:33:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F497CF20
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213632; cv=none; b=smpx7TPvo2F+jG+Mig8Il7qFb5arvp5+btiir6K/JF0ExMDp7h4hRpl+NWaJ/Hbzfp7odQKTEwyaM79yP6nl+76VCsp9pNXMyHrEfjRnvKxDybtP/sI9gGqa2w9eTAjLBlO8SeaeFJ38rLUsVvO7CCMhViVABtUeumTU2Rx6XsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213632; c=relaxed/simple;
	bh=LThZZNkAXsa+89NZS8uyFLOdu2ejwU5VZEYspmYPWDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOn90iUeArr1XQqUBeDxSGpRxqWYyhBsDDPEIRDUYkObIuqJIKwIl47q5h24KZqL9PSDN+1ZJPF3i9FPEQ+fIGn/is9ZGnfm31jML49OVKOubmKyl1+fxbzs/B3POH84wSCILZtjIVeHoOHpaKUfelT8tk2TiZ5WGq9uHtUxC1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61F8168BEB; Thu, 29 Feb 2024 14:33:46 +0100 (CET)
Date: Thu, 29 Feb 2024 14:33:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	"kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Message-ID: <20240229133346.GA7177@lst.de>
References: <20240228133930.15400-1-will@kernel.org> <20240228133930.15400-7-will@kernel.org> <SN6PR02MB4157A62353559DA8DB8BC4ADD45F2@SN6PR02MB4157.namprd02.prod.outlook.com> <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577D09E97B1D9645369D58D45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Feb 29, 2024 at 07:36:05AM +0000, Michael Kelley wrote:
> If there *is* a requirement for page alignment of page-size-or-greater
> requests, even when alloc_align_mask and min_align_mask are zero,
> we need to think about how to do that correctly, as that requirement
> is no longer met after Patch 1 of this series.

It has been historical behavior that all dma allocations are page
aligned (including in fact smaller than page sized ones that get
rounded up to a page size).  The documentation actually (incorretly)
states an even stronger guarantee:

"The CPU virtual address and the DMA address are both
guaranteed to be aligned to the smallest PAGE_SIZE order which
is greater than or equal to the requested size.  This invariant
exists (for example) to guarantee that if you allocate a chunk
which is smaller than or equal to 64 kilobytes, the extent of the
buffer you receive will not cross a 64K boundary."


