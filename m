Return-Path: <linux-kernel+bounces-111963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB6887354
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9021C21413
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55A6CDB8;
	Fri, 22 Mar 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K7rdjqQl"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DE36BFB4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133014; cv=none; b=cakostOGsgsCdWHqNEFQ4eh7u8NAm87V25mlM83KcM0xsshCFsKSBECrg1w+4uRveYPm+fjUQAkDBPRseX81u8T4aeP3kxvImQfmmm8spvt37OGFa+cZI628Lmwyf9SvH41UVQNSxvSfomH64n8llBOgL81dWULcvRprwW0XzOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133014; c=relaxed/simple;
	bh=GvQkjDWyqo+rghsqOlGEglCNlFD0oHAv/CYM8uzWhmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Emp1VffkcPxZcrWlq/rIvxZjLjUlz53lbfY/Ivs1iP3wWNCw5uZ7FHY3E7Gu8UfrXvaDrZtYDyUFm2x3i+SQY5nIo3NhkZG1js8LmWsIcmzLW45zQlqQlx5WRtn7Nl47EzXZG3LYUIa2Z2wcIYxs2dlk5LijmHo4345V1riu8Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=K7rdjqQl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6963cf14771so22003836d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711133012; x=1711737812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07q//JdJmCCvVOn8q/irpx1t9tAUng9qf5/QnHEsi64=;
        b=K7rdjqQliWI1TNqJz8KGw71PRrpl8qkRcqLOkRH8/6709xbL0qE4wJ0HaoCqRmIoWX
         wAPgxZ1XoIn5zlaKvmi6RhSv0rJXioRdrI+8jjqBfZ3s7nMJ+ZFLNH77QiaeyXIEl8iP
         pFKbmTgihrXr367Isdswg9geTJmOC178pnmyU/Fd5I7in7PPJDcHP7bubht99eioh85P
         FamcMzVbG5p2smLx+7/gk8P50jdl924WQK43uF4rFCMRpZ00CaB2DrOo/PJ21Y9jM0Pb
         LDWBs7rVMF+6qiqSHK3gcb6yytbIhCDcWLAzYpXOSWA3TVUzxDHf7vJq8+RHeXvRGLnx
         LGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711133012; x=1711737812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07q//JdJmCCvVOn8q/irpx1t9tAUng9qf5/QnHEsi64=;
        b=CZJUldETXlrAvJK3yEkrYRMBg3Bzzu3bRbHeGmGyCHNBBK+pwTmvSMQiL3aLnkcIrp
         NdwmuDHF8aMeXNHrscYWDchaID063QWl2gCFej5chnutVxG0gYqbc3RH7hpvsIhvJuxL
         ExQplCvEwaIkAQUEuO0cOChxW1Og3yZrgnmFEwIBJWbwBLzGs89mrS2lakpHjZIb+Cg1
         qn/NuFYAsNjs5UwOuFMe0vib+6w0ChtADTxILBQWRhWjGxkZbvaBG+JGUyKDXLVC0koh
         tMdPuOv9WaTlY5U4CFilg+Ne8NwIvIaY8BdWkvOGWnWUW5x36hUpZtq4mfGDw+ra7PSh
         7pjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMGWcBdNUqQxaY8lpciMii+1LtuJtoGQfTlz65mHBV36cUijPn9/WSUTc3o7MaBSQ600VeZqsfltf9ct7Uq2exT3zWif3CAPyGh3ec
X-Gm-Message-State: AOJu0Yx6ZQJ/oHT85NS0XrB1SJxSY89XUssu0nCQfPqq+H5f+ZkZVkgC
	oaTqG5Ax3RXjmnYHKoSBG9u2FcXutklwxL2XiYM4v4AWRE2fyDy0HvCqG/PBSZM=
X-Google-Smtp-Source: AGHT+IGXOk5dcQgdVkv6EYgSp4tZ+XXQ52Ta863vabfcwug61wLkQ0Ayg5iISSk/K2qeTKcn+PXm/w==
X-Received: by 2002:a05:6214:21ab:b0:690:3ca2:1858 with SMTP id t11-20020a05621421ab00b006903ca21858mr295314qvc.4.1711133011811;
        Fri, 22 Mar 2024 11:43:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id n13-20020a0cfbcd000000b00696731ceef6sm435222qvp.2.2024.03.22.11.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 11:43:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rnjrW-00Cg1F-Pb;
	Fri, 22 Mar 2024 15:43:30 -0300
Date: Fri, 22 Mar 2024 15:43:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240322184330.GL66976@ziepe.ca>
References: <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
 <20240307000036.GP9225@ziepe.ca>
 <20240307150505.GA28978@lst.de>
 <20240307210116.GQ9225@ziepe.ca>
 <20240308164920.GA17991@lst.de>
 <20240308202342.GZ9225@ziepe.ca>
 <20240309161418.GA27113@lst.de>
 <20240319153620.GB66976@ziepe.ca>
 <20240321223910.GA22663@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321223910.GA22663@lst.de>

On Thu, Mar 21, 2024 at 11:39:10PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 19, 2024 at 12:36:20PM -0300, Jason Gunthorpe wrote:
> > I kind of understand your thinking on the DMA side, but I don't see
> > how this is good for users of the API beyond BIO.
> > 
> > How will this make RDMA better? We have one MR, the MR has pages, the
> > HW doesn't care about the SW distinction of p2p, swiotlb, direct,
> > encrypted, iommu, etc. It needs to create one HW page list for
> > whatever user VA range was given.
> 
> Well, the hardware (as in the PCIe card) never cares.  But the setup
> path for the IOMMU does, and something in the OS needs to know about
> it.  So unless we want to stash away a 'is this P2P' flag in every
> page / SG entry / bvec, or a do a lookup to find that out for each
> of them we need to manage chunks at these boundaries.  And that's
> what I'm proposing.

Okay, if we look at the struct-page-less world (which we want for
DMABUF) then we need to keep track for sure. What I had drafted was to
keep track in the new "per-SG entry" because that seemed easiest to
migrate existing code into.

Though the datastructure could also be written to be a list of uniform
memory types and then a list of SG entries. (more like how bio is
organized)

No idea right now which is better, and I'm happy make it go either
way.

But Leon's series is not quite getting to this, it it still struct
page based and struct page itself has all the metadata - though as you
say it is a bit expensive to access.

> > Or worse, whatever thing is inside a DMABUF from a DRM
> > driver. DMABUF's can have a (dynamic!) mixture of P2P and regular
> > AFAIK based on the GPU's migration behavior.
> 
> And that's fine.  We just need to track it efficiently.

Right, DMABUF/etc will return a something that has a list of physical
addresses and some meta-data to indicate the "p2p memory provider" for
the P2P part.

Perhaps it could be as simple as 1 bit in the physical address/length
and a global "P2P memory provider" pointer for the entire DMA
BUF. Unclear to me right now, but sure.

> > Or triple worse, ODP can dynamically change on a page by page basis
> > the type depending on what hmm_range_fault() returns.
> 
> Same.  If this changes all the time you need to track it.  And we
> should find a way to shared the code if we have multiple users for it.

ODP (for at least the forseeable furture) is simpler because it is
always struct page based so we don't need more metadata if we pay the
cost to reach into the struct page. I suspect that is the right trade
off for hmm_range_fault users.

> But most DMA API consumers will never see P2P, and when they see it
> it will be static.  So don't build the DMA API to automically do
> the (not exactly super cheap) checks and add complexity for it.

Okay, I think I get what you'd like to see.

If we are going to make caller provided uniformity a requirement, lets
imagine a formal memory type idea to help keep this a little
abstracted?

 DMA_MEMORY_TYPE_NORMAL
 DMA_MEMORY_TYPE_P2P_NOT_ACS
 DMA_MEMORY_TYPE_ENCRYPTED
 DMA_MEMORY_TYPE_BOUNCE_BUFFER  // ??

Then maybe the driver flow looks like:

	if (transaction.memory_type == DMA_MEMORY_TYPE_NORMAL && dma_api_has_iommu(dev)) {
		struct dma_api_iommu_state state;

		dma_api_iommu_start(&state, transaction.num_pages);
		for_each_range(transaction, range)
			dma_api_iommu_map_range(&state, range.start_page, range.length);
		num_hwsgls = 1;
		hwsgl.addr = state.iova;
		hwsgl.length = transaction.length
		dma_api_iommu_batch_done(&state);
	} else if (transaction.memory_type == DMA_MEMORY_TYPE_P2P_NOT_ACS) {
		num_hwsgls = transcation.num_sgls;
		for_each_range(transaction, range) {
			hwsgl[i].addr = dma_api_p2p_not_acs_map(range.start_physical, range.length, p2p_memory_provider);
			hwsgl[i].len = range.size;
		}
	} else {
		/* Must be DMA_MEMORY_TYPE_NORMAL, DMA_MEMORY_TYPE_ENCRYPTED, DMA_MEMORY_TYPE_BOUNCE_BUFFER? */
		num_hwsgls = transcation.num_sgls;
		for_each_range(transaction, range) {
			hwsgl[i].addr = dma_api_map_cpu_page(range.start_page, range.length);
			hwsgl[i].len = range.size;
		}
	}

And the hmm_range_fault case is sort of like:

		struct dma_api_iommu_state state;
		dma_api_iommu_start(&state, mr.num_pages);

		[..]
		hmm_range_fault(...)
		if (present)
			dma_link_page(&state, faulting_address_offset, page);
		else
			dma_unlink_page(&state, faulting_address_offset, page);

Is this looking closer?

> > So I take it as a requirement that RDMA MUST make single MR's out of a
> > hodgepodge of page types. RDMA MRs cannot be split. Multiple MR's are
> > not a functional replacement for a single MR.
> 
> But MRs consolidate multiple dma addresses anyway.

I'm not sure I understand this?
 
> > Go back to the start of what are we trying to do here:
> >  1) Make a DMA API that can support hmm_range_fault() users in a
> >     sensible and performant way
> >  2) Make a DMA API that can support RDMA MR's backed by DMABUF's, and
> >     user VA's without restriction
> >  3) Allow to remove scatterlist from BIO paths
> >  4) Provide a DMABUF API that is not scatterlist that can feed into
> >     the new DMA API - again supporting DMABUF's hodgepodge of types.
> > 
> > I'd like to do all of these things. I know 3 is your highest priority,
> > but it is my lowest :)
> 
> Well, 3 an 4.  And 3 is not just limited to bio, but all the other
> pointless scatterlist uses.

Well, I didn't write a '5) remove all the other pointless scatterlist
case' :)

Anyhow, I think we all agree on the high level objective, we just need
to get to an API that fuses all of these goals together.

To go back to my main thesis - I would like a high performance low
level DMA API that is capable enough that it could implement
scatterlist dma_map_sg() and thus also implement any future
scatterlist_v2, bio, hmm_range_fault or any other thing we come up
with on top of it. This is broadly what I thought we agreed to at LSF
last year.

Jason

