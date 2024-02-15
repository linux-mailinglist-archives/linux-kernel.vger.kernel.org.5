Return-Path: <linux-kernel+bounces-66230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6BF8558CE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A471C2256C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C3B1866;
	Thu, 15 Feb 2024 01:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIYWwiOS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320617C9;
	Thu, 15 Feb 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707961003; cv=none; b=JvYuBFAQhBS9/DUVM23XKGzPzkwaVjOe0a5UCDrtWwwv4wH2J3vjvnwL+3cxtYA+KLqoA6Sfle2hk30hDDDlZ4ijaX8m9gfCcc3pSDNShY954a5QHM2C70lXmFx2sy1EVqyaWhE6mK+msJ4W++Dsxtwxt6kArJvRuhXWrhgk/NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707961003; c=relaxed/simple;
	bh=pPliZncdA3i95L/mjXLvn7u/pxryzDw1zgs434SpmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkpSjjND2QuPVLbVuoFc3omdne1E6b81N98lfiWi+tJZw0heFd+cY5sn++08hh6XKRoJ8oj/okmH/usRTJU5Ja0cJexPIz3K+dHvpMdrt3PSqby+sDPkTzfjtnEyySMgriVt1Gk8KeskWE3ucAzlu7p/I6vde2OXu6BIuLVQQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIYWwiOS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874ECC433C7;
	Thu, 15 Feb 2024 01:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707961002;
	bh=pPliZncdA3i95L/mjXLvn7u/pxryzDw1zgs434SpmLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aIYWwiOSIjt8sT6wPq0tPs6lzJB8PGB3UrjsTwGEdZ462ubWUs53385RoWRztfpKY
	 XG0JoA3wLh4Wc2H4zDw+7lcU17Icm139JzEIuZeTUeHsi9EQ7By5RIaGxqsnfuOztl
	 sdFmFEDfoyWQDH3HoINL7MREAW/vdjH9EpNuoWPf2ik97lqwP5/+tScSXTY71AG9RL
	 XJNeTL/JM5u3doGRsGqGJeh25Ng2ltElGKFffdfrPxqdN0+R9yGkwPZ7INbI/CnrO4
	 2iltwab2NtxLSevGVysR/HLmtk8yWHBW2JrAKu7v0m3cQFn74pLaQmyF8UONu7dPj5
	 LiseI3mLMtenw==
Date: Wed, 14 Feb 2024 18:36:38 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 2/2] nvme-pci: Fix iommu map (via swiotlb) failures
 when PAGE_SIZE=64KB
Message-ID: <Zc1qpr4zCy1N0OND@kbusch-mbp>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <60bdcc29a2bcf12c6ab95cf0ea480d67c41c51e7.1707851466.git.nicolinc@nvidia.com>
 <Zcv7uI6VrMc2EuGT@kbusch-mbp>
 <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcxZD2GXmR5+vC/k@Asurada-Nvidia>

On Tue, Feb 13, 2024 at 10:09:19PM -0800, Nicolin Chen wrote:
> On Tue, Feb 13, 2024 at 04:31:04PM -0700, Keith Busch wrote:
> > On Tue, Feb 13, 2024 at 01:53:57PM -0800, Nicolin Chen wrote:
> > > @@ -2967,7 +2967,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
> > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
> > >       else
> > >               dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> > > -     dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
> > > +     dma_set_min_align_mask(&pdev->dev, PAGE_SIZE - 1);
> > >       dma_set_max_seg_size(&pdev->dev, 0xffffffff);
> > 
> > I recall we had to do this for POWER because they have 64k pages, but
> > page aligned addresses IOMMU map to 4k, so we needed to allow the lower
> > dma alignment to efficiently use it.
> 
> Thanks for the input!
> 
> In that case, we might have to rely on iovad->granule from the
> attached iommu_domain:

I explored a bit more, and there is some PPC weirdness that lead to
NVME_CTRL_PAGE_SIZE, I don't find the dma min align mask used in that
path. It looks like swiotlb is the only user for this, so your original
patch may be just fine.

