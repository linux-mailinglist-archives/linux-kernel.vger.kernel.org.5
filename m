Return-Path: <linux-kernel+bounces-47626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC59B84506E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB101C25358
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF213C064;
	Thu,  1 Feb 2024 04:45:26 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014DA33CC6;
	Thu,  1 Feb 2024 04:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762726; cv=none; b=Uib4kjKvFZF+7STbcT/G8I/QRm+5X3t9qn5yPfy6V/IOYcvED4uErivB8Yyd0ho5GYknG+SvLkc/B7ioo8bkiFSwzOvIODiGXIH/IX3cpyhUHVOCTls8KnmOqniLabKiOlQQBDdYsydh7L7wK5iZUmvjJQ1ePFYlw0l15QqjRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762726; c=relaxed/simple;
	bh=/uEIaX0EFZlt3rhgTjhZlC75KcpuGmzm/ZLfFTjsxe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ker63R92g7RSqW+ussWIMYPJE4iX9Pth6lXwiiVA9iksV84JKR19i7GsZCbfGvAaHxfikyVIiGbS5Kilze4SwzhmOA6HUgdUR8rHwKxULmkvfG052IG/ag85z8qWTB14GjubdRPZFcY4fzXujEZ8JJGFRwq1MaON2t/CCVZ819s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 73CEF68AFE; Thu,  1 Feb 2024 05:45:21 +0100 (CET)
Date: Thu, 1 Feb 2024 05:45:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 2/2] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <20240201044521.GB14176@lst.de>
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-3-cleech@redhat.com> <2024013125-unraveled-definite-7fc6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024013125-unraveled-definite-7fc6@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 01:29:56PM -0800, Greg Kroah-Hartman wrote:
> On Wed, Jan 31, 2024 at 11:17:32AM -0800, Chris Leech wrote:
> > Use the UIO_MEM_DMA_COHERENT type to properly handle mmap for
> > dma_alloc_coherent buffers.
> > 
> > The cnic l2_ring and l2_buf mmaps have caused page refcount issues as
> > the dma_alloc_coherent no longer provide __GFP_COMP allocation as per
> > commit "dma-mapping: reject __GFP_COMP in dma_alloc_attrs".
> > 
> > Fix this by having the uio device use dma_mmap_coherent.
> > 
> > The bnx2 and bnx2x status block allocations are also dma_alloc_coherent,
> > and should use dma_mmap_coherent. They don't allocate multiple pages,
> > but this interface does not work correctly with an iommu enabled unless
> > dma_mmap_coherent is used.
> > 
> > Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_coherent")
> 
> This is really the commit that broke things?  By adding this, are you
> expecting anyone to backport this change to older kernels?

Well, the driver has literally been broken since day 1.  The above
commit is what made people finally care as it also broke on more
common setups.  So I'm not sure the fixes tag is correct.

