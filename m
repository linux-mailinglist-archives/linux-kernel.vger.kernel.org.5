Return-Path: <linux-kernel+bounces-164929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E596B8B8518
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66ABD1F234AF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3103F8D1;
	Wed,  1 May 2024 04:49:18 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C63D0A9;
	Wed,  1 May 2024 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714538958; cv=none; b=IgopjYGljnU5GxO8Gs2tt43zr960E0KRMkWpMYg+jc4O7dM+ZQGZI5MEpThBx2UWXD8spn0ys+hpNQdMU9tVnk/3cVG5iRGJ7kfLbmPCOQ4xLO4a01o4QMJnVBA4L+kTQvA5Ahh6CzEckg9fesyvsIh43benAyv7vKRR3zi//oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714538958; c=relaxed/simple;
	bh=he/kUeqK0dNeAWJhFxJc2221VUgxwuPvsqDXRRJ2wgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBq7BVtosrYqNYpcH/7G+3mTAyx13VHnbzRJVYBMhowOmBwUjFgM1p+mj0sZOLrFTaf73WOF5ATBm4M6756VhB4XVCjiQQ1kOKpxiLBb7Cw2eK9laxVjuev/EoZaeYDpXlShKpYX6ZsO8v3bgHuNYTy6XBCfb7HMjaAtVlZKo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F6AA67373; Wed,  1 May 2024 06:49:11 +0200 (CEST)
Date: Wed, 1 May 2024 06:49:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: mhkelley58@gmail.com, mhklinux@outlook.com, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, hch@lst.de,
	m.szyprowski@samsung.com, corbet@lwn.net, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v3 1/1] Documentation/core-api: Add swiotlb
 documentation
Message-ID: <20240501044910.GD31252@lst.de>
References: <20240429151337.1069470-1-mhklinux@outlook.com> <20240430132413.69797af1@mordecai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430132413.69797af1@mordecai>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Apr 30, 2024 at 01:24:13PM +0200, Petr Tesařík wrote:
> > +swiotlb was originally created to handle DMA for devices with addressing
> > +limitations. As physical memory sizes grew beyond 4 GiB, some devices could
> > +only provide 32-bit DMA addresses. By allocating bounce buffer memory below
> > +the 4 GiB line, these devices with addressing limitations could still work and
> > +do DMA.
> 
> IIRC the origins are even older and bounce buffers were used to
> overcome the design flaws inherited all the way from the original IBM
> PC.

[correct, but for swiotlb largely irrelevant PC addressing bits snipped]

swiotlb was added with the merge of the ia64 port to address 32-bit
addressing limitations.  The 1MB addressing limitations of the PC did
and still do of course exist, but weren't dealt with in any coherent
fashion, and still aren't.  Swiotlb isn't related to them.

> > +data to/from the original target memory buffer. The CPU copying bridges between
> > +the unencrypted and the encrypted memory. This use of bounce buffers allows
> > +existing device drivers to "just work" in a CoCo VM, with no modifications
> > +needed to handle the memory encryption complexity.
> 
> This part might be misleading. It sounds as if SWIOTLB would not be
> needed if drivers were smarter. But IIUC that's not the case. SWIOTLB
> is used for streaming DMA, where device drivers have little control
> over the physical placement of a DMA buffer. For example, when a
> process allocates some memory, the kernel cannot know that this memory
> will be later passed to a write(2) syscall to do direct I/O of a
> properly aligned buffer that can go all the way down to the NVMe driver
> with zero copy.

I think the statement in the text is fine and easy to understand.  CoCo
drivers could instead always map the memory unencrypted (which would have
no so nice security and performance properties) or use fixed ringbuffers
in shared unencrypted memory (which would require a different driver
architecture).

> > +block. Hence the default memory pool for swiotlb allocations must be
> > +pre-allocated at boot time (but see Dynamic swiotlb below). Because swiotlb
> > +allocations must be physically contiguous, the entire default memory pool is
> > +allocated as a single contiguous block.
> 
> Allocations must be contiguous in target device's DMA address space. In
> practice this is achieved by being contiguous in CPU physical address
> space (aka "physically contiguous"), but there might be subtle
> differences, e.g. in a virtualized environment.
> 
> Now that I'm thinking about it, leave the paragraph as is, and I'll
> update it if I write the code for it.

Heh.  The only think making cpu non-contiguous address space contiguous
for a device is an iommu.  And when we have that we only use swiotlb
for unaligned iommu pages, so I'm not sure how we'd ever get there.


