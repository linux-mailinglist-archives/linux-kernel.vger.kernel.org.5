Return-Path: <linux-kernel+bounces-67075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 777038565D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACAB1C22316
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56D131E43;
	Thu, 15 Feb 2024 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JER++TAe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ADA131E38;
	Thu, 15 Feb 2024 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006935; cv=none; b=WSnN8YAZG+EqteOCIxFRtpplP+UwcpmD8j5opdsxfpQhGB3GnWWlUJs3ZYbJzg0IWWx72rM/D4UjlcDMbbfH0j5rHdRqddC4i5BXJlp2mMnnRMcaYz5Lc9+h5Wn2uOnxsHBMvcnF4tLQvOu0GBCucqLuTxWZlXrsMeDQDrW65gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006935; c=relaxed/simple;
	bh=ECMr//ZIck/Tif42+N9tnk+eC4TmXipGsgU9IFIbA/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM38xzSDYdoXJP+9dIczpP30jyKNrq5tDsUHM+wpFmGMm9Cha65VN2bF+Ji/giUAi7/ls30l+mokLAfgw8lUlgnxw0kNNl9mmBIsLGYH9tSz+hKx0J07d1acULJR/jqhaiK5zOAlmHYlHGtewBbmGU5WgIplW2cfaFPulNDfV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JER++TAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FF7C433F1;
	Thu, 15 Feb 2024 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006935;
	bh=ECMr//ZIck/Tif42+N9tnk+eC4TmXipGsgU9IFIbA/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JER++TAe+qybmy9TeGC3CbZVTBJu3mnF3b1XXqc8gR3Y9k0QHLEYWJm5RJaTlrJVR
	 pZRK+KwTU/cVQWws6A5Ho+jU5yQjjWj8q4GwlzCDybj3eroe3yJRL3X0GElb3+qaj3
	 Wx09/kzw8JI2PE6BsYq6Cc4waRRh5ywH33JtGarmTTbcz3HLjC3IgbmBZkREiUQkGL
	 jkhEjiNjKw+S4kv2raEIecGvl3VHH3r4h81ct8YLX/JlIQgczJTDSBQkF4pZFLXphy
	 Zab0FuPaTRxUfe7qB0jPQOxIqAF/Bu+8BLFhaSpI2kogq5Y5pw7F36YnhG1iWbUcK6
	 2vUp2qYP2Fw7g==
Date: Thu, 15 Feb 2024 14:22:09 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240215142208.GA753@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > > It's observed that an NVME device is causing timeouts when Ubuntu boots
> > > with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
> > >     systemd[1]: Started Journal Service.
> > >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
> > >     note: journal-offline[392] exited with irqs disabled
> > >     note: journal-offline[392] exited with preempt_count 1
> > >
> > > An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
> > > going through dma-iommu might be also redirected to swiotlb allocations.
> > > Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
> > > dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.
> > >
> > > Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
> > > issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
> > > default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
> > > while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
> > > when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
> > > this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
> > > in a similar failure, though its signature has a fixed size "256KB":
> > >     systemd[1]: Started Journal Service.
> > >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
> > >     note: journal-offline[392] exited with irqs disabled
> > >     note: journal-offline[392] exited with preempt_count 1
> > >
> > > Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
> > > were likely introduced for the security feature by:
> > > commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),
> > >
> > > So, this series bundles two fixes together against that. They should be
> > > taken at the same time to entirely fix the mapping failures.
> > 
> > It's a bit of a shot in the dark, but I've got a pending fix to some of
> > the alignment handling in swiotlb. It would be interesting to know if
> > patch 1 has any impact at all on your NVME allocations:
> > 
> > https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
> 
> I applied these three patches locally for a test.

Thank you!

> Though I am building with a v6.6 kernel, I see some warnings:
>                  from kernel/dma/swiotlb.c:26:
> kernel/dma/swiotlb.c: In function ‘swiotlb_area_find_slots’:
> ./include/linux/minmax.h:21:35: warning: comparison of distinct pointer types lacks a cast
>    21 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:27:18: note: in expansion of macro ‘__typecheck’
>    27 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:37:31: note: in expansion of macro ‘__safe_cmp’
>    37 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:75:25: note: in expansion of macro ‘__careful_cmp’
>    75 | #define max(x, y)       __careful_cmp(x, y, >)
>       |                         ^~~~~~~~~~~~~
> kernel/dma/swiotlb.c:1007:26: note: in expansion of macro ‘max’
>  1007 |                 stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>       |                          ^~~
> 
> Replacing with a max_t() can fix these.

Weird, I haven't seen that. I can fix it as you suggest, but please can
you also share your .config so I can look into it further?

> And it seems to get worse, as even a 64KB mapping is failing:
> [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> 
> With a printk, I found the iotlb_align_mask isn't correct:
>    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> 
> But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> mapping..

Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
are 2KiB aligned. I'll try plugging in some of the constants you have
here, as something definitely isn't right...

Will

