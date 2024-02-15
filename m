Return-Path: <linux-kernel+bounces-67315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8BE8569A7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7A61F22F77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688E135A69;
	Thu, 15 Feb 2024 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tENlyL1U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ADB1754B;
	Thu, 15 Feb 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014952; cv=none; b=MjW30Qi63k/VH9UlJ5fmeguZZWtRwhSGoJ15fXz1YWSzEXr5iBiJyzZr0sRyyxlUeDdvT1OvhC1ysoaeb2em0KT5g1DvPmJ9YFRRacuzKIlDBbD0f2G8b0ZTKY3pXiAB8PTU0FG9wLKcg2nfWk/OC0E62oDiVE3zAV4peJmYcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014952; c=relaxed/simple;
	bh=+zLAj2dv1mxs8pQKcOIXqeYT4laZWT/mVwhK3HGd0EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuLL3ghJ3W/n6MApfcxI7nrNkdBMR4UtPORJ4/nOKdVlrYE1rXP0rRPRVQHI3Kv22DMKi7yPrgVEcoDPnThIhfd0Gn5BlVRZJH4XErpFHgeMtdH/hNKRsZwFkjKCHl3+JOP1QVFRSqGNPrYcGuMlNp182VsuEojTgdHyCHtpvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tENlyL1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BCFC433C7;
	Thu, 15 Feb 2024 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708014951;
	bh=+zLAj2dv1mxs8pQKcOIXqeYT4laZWT/mVwhK3HGd0EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tENlyL1UhctC1ji35rmACH436KEsEf4wY7vf0fttSzkY8KreDcVR/jZml77spbPUH
	 rgub6XHTDa0aqSrzK8aUSw4xUBinSCzAt4NlclazOXyL0V2PqC/+MiYDKxwr5H9bnt
	 OEm6HW4sobAE76phqUDf7Pj2GXYUE07BiLTzEXozU9MkEYMilt4jW6ZZuW4p6toTud
	 W7d98aimoio4WX+HHTuI4obLTqDf1T+46JUITse0X/YyCk+GBWaMy2+L9MhyJZ4X+f
	 OPcIx3ZE6DyFSiE7a9CB64Ne5Z29MHA2w0FjcArhgyWeQB9KmbTCJImnIAgkgj0ZEe
	 8uL9RNKVccbqQ==
Date: Thu, 15 Feb 2024 16:35:45 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240215163544.GA821@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215142208.GA753@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:
> On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> > On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > And it seems to get worse, as even a 64KB mapping is failing:
> > [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> > 
> > With a printk, I found the iotlb_align_mask isn't correct:
> >    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> > 
> > But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> > mapping..
> 
> Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
> are 2KiB aligned. I'll try plugging in some of the constants you have
> here, as something definitely isn't right...

Sorry, another ask: please can you print 'orig_addr' in the case of the
failing allocation?

Thanks!

Will

