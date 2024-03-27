Return-Path: <linux-kernel+bounces-121919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1588EF70
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCBFD1C2EBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554B152514;
	Wed, 27 Mar 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b748I/Rb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966A14F9DD;
	Wed, 27 Mar 2024 19:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711568526; cv=none; b=QFbR9X37yBnbNXYhb4D1VxyDKqTF3a7dmCzhp8VEz/JKWOW5uIIMm7Z1rXKU0wcK2dYRFWtrCJjZyqs1l0aS1fAlv042GiN0AQIKt65rkD3/82M0pwy67Vhh+TbgJY8058zmob9d5zjiBBOHHnndquU8YlAf5IGyqYWIWToJL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711568526; c=relaxed/simple;
	bh=PsoqOSc/ZsnGjVOPPElixDYOJ7dkP9VdeqNpiyZI00A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aqwab01CMfDtWbjsrk2IcfQC+xEsasfQygGu/gfABESlXReBQh80jtQIrHaR7JdiP/HQDGBasNj7RSw1kkR4GjZzC/BeT8DKowjsHF574yNh7MRPWYdEKnDF7qK829x56u9pq9Sv0ajAWal+uvtwrrFb/gU0VLPzTVQQ4ety7/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b748I/Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F6BC433C7;
	Wed, 27 Mar 2024 19:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711568526;
	bh=PsoqOSc/ZsnGjVOPPElixDYOJ7dkP9VdeqNpiyZI00A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b748I/RbWhZJV3AxMeOrTcHuMLbzL1ocVl7qHn/xvp9P/MwKhxWQeq5FuIcBP5JHn
	 DcpEe64QIsTLiAoIE1xxp5ZybwxHIgAKXRHRJ/V0CTwVE7TO6f3gIrZy9wULp1SpBd
	 7ukVgrHzkzmLeju6LdhgAZH9XVYgkf86tShw0luVvX/WeNsFVsR5m3uhSaZzjl1lAA
	 GXDN491AnrTvWyuuvN1z7X72VSe9iMDZpc3kCjKIv/eaKn/U3pXkxtM6t8Eu8Kfxs/
	 GGLiRyz1f/DvsuzoxdOmSy0IhmuBFbYpmz5Ub6Vljnq/WVErAl5UT6stRjWpsBPsVD
	 B7UKb7ga6Cj8Q==
Date: Wed, 27 Mar 2024 19:42:01 +0000
From: Will Deacon <will@kernel.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>,
	Michael Kelley <mhklinux@outlook.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH v3 0/2] swiotlb: allocate padding slots if necessary
Message-ID: <20240327194200.GA12000@willie-the-truck>
References: <20240321171902.85-1-petrtesarik@huaweicloud.com>
 <20240322150941.GA5634@willie-the-truck>
 <20240322185138.1af83c61@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322185138.1af83c61@meshulam.tesarici.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Mar 22, 2024 at 06:51:38PM +0100, Petr Tesařík wrote:
> On Fri, 22 Mar 2024 15:09:41 +0000
> Will Deacon <will@kernel.org> wrote:
> 
> > Hi Petr,
> > 
> > On Thu, Mar 21, 2024 at 06:19:00PM +0100, Petr Tesarik wrote:
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > > 
> > > If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
> > > covers some bits in the original address between IO_TLB_SIZE and
> > > alloc_align_mask, preserve these bits by allocating additional padding
> > > slots before the actual swiotlb buffer.  
> > 
> > Thanks for fixing this! I was out at a conference last week, so I didn't
> > get very far with it myself, but I ended up in a pickle trying to avoid
> > extending 'struct io_tlb_slot'. Your solution is much better than the
> > crazy avenue I started going down...
> > 
> > With your changes, can we now simplify swiotlb_align_offset() to ignore
> > dma_get_min_align_mask() altogether and just:
> > 
> > 	return addr & (IO_TLB_SIZE - 1);
> 
> I have also thought about this but I don't think it's right. If we
> removed dma_get_min_align_mask() from swiotlb_align_offset(), we would
> always ask to preserve the lowest IO_TLB_SHIFT bits. This may cause
> less efficient use of the SWIOTLB.
> 
> For example, if a device does not specify any min_align_mask, it is
> presumably happy with any buffer alignment, so SWIOTLB may allocate at
> the beginning of a slot, like here:
> 
> orig_addr   |      ++|++      |
> tlb_addr    |++++    |        |
> 
> Without dma_get_min_align_mask() in swiotlb_align_offset(), it would
> have to allocate two mostly-empty slots:
> 
> tlb_addr    |      ++|++      |
> 
> where:
>   | mark a multiple of IO_TLB_SIZE (in physical address space)
>   + used memory
>     free memory

Thanks for the patient explanation. I'd got so caught up with the DMA
alignment mask that I forgot the usual case where it's not specified at
all!

Will

