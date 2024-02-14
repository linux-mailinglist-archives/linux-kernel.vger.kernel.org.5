Return-Path: <linux-kernel+bounces-65569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2F8854ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04DE1C29662
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA3560279;
	Wed, 14 Feb 2024 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP/9iHXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07E5D49C;
	Wed, 14 Feb 2024 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928905; cv=none; b=MGvp0+/UjriwVqs+LwEpkwIYBAayqOUMLBgKQDhuWQreCA50H1udcSNgfOY+GqDOtk0vs8gjuTfMWR/O1XcVU5KE/rlEkfs5ovZtAYKga6s5d6Dnkqaw6dv9b74BXVZ+hHWUpsQREtK9vG/pBV64BedqcRFpWOb+k7LbpWs6RIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928905; c=relaxed/simple;
	bh=rtzaQewjWyFqgXvX8Cpq/QwLjOpb1280iFp5zLTTWx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvngrQ0FvQ97ZLUoDE3506VHDXeinLbxC0HZniH1IEC65CLr1BOWXLbowHWdXopZJj08GW3aDdf94WFaiFC7SmL9scwwvOK0NPnhgQg3IeeO1Iey3XB2iTKPvLxC86HCmWijKsl915NjpcTMVJjr4JQfhzcGSjRsIvE0Gs3iK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP/9iHXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B19C433F1;
	Wed, 14 Feb 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707928904;
	bh=rtzaQewjWyFqgXvX8Cpq/QwLjOpb1280iFp5zLTTWx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oP/9iHXzZ4W3ZkEIKY9irpzbod0eFARuDjHbe93lj1nSEHbUYvXg3uHTnMtH9Jkmt
	 SuqEPiKzPsRKrc5m74cY32AfDw/qAVaFGETVY32JqsFWgRSR5RvlcF0t1HdI+GtK3f
	 x7Ye1fDwGN5Zfei+HU++QCasgmImmcKpwQHy6MC660hAUJZxnILvlV4RFM0QLgt23B
	 7/MSUOriFsS4NiTahlVGWkpfjqfgxTAnimulbm1unYOY2l/Zum4l+1qVgQG/9qVV6w
	 y1Iu8twIAaK4onCIbUsBWRJCER2TwLsWCJSJCFsh8Bk0OtJHI7HhALtsWjs3Dx7xQN
	 XKys4GJgd5Tmw==
Date: Wed, 14 Feb 2024 16:41:38 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240214164138.GA31927@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707851466.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Nicolin,

On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> It's observed that an NVME device is causing timeouts when Ubuntu boots
> with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
>     systemd[1]: Started Journal Service.
>  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
>     note: journal-offline[392] exited with irqs disabled
>     note: journal-offline[392] exited with preempt_count 1
> 
> An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
> going through dma-iommu might be also redirected to swiotlb allocations.
> Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
> dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.
> 
> Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
> issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
> default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
> while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
> when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
> this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
> in a similar failure, though its signature has a fixed size "256KB":
>     systemd[1]: Started Journal Service.
>  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
>     note: journal-offline[392] exited with irqs disabled
>     note: journal-offline[392] exited with preempt_count 1
> 
> Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
> were likely introduced for the security feature by:
> commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),
> 
> So, this series bundles two fixes together against that. They should be
> taken at the same time to entirely fix the mapping failures.

It's a bit of a shot in the dark, but I've got a pending fix to some of
the alignment handling in swiotlb. It would be interesting to know if
patch 1 has any impact at all on your NVME allocations:

https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org

Cheers,

Will

