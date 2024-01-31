Return-Path: <linux-kernel+bounces-47171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5F844A17
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF5D2866FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF93A278;
	Wed, 31 Jan 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AI3vnwwT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017139ACE;
	Wed, 31 Jan 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736596; cv=none; b=MdKbFTS7jhLhZq7x1Z/LokxI6hNgrWBzX/mMrqKQgg06enEnYPtSzBRu2RBRh7G8DeqY02EU5N3hVvgo8gq/6rCnnQxT0XUu7koN+Zqlgw4KSo44AA/6eK4xWQlMzKHlxcZKh/UV9TQXpQ3SLYQXSC3PLLHolhSVe8nAd5Ykc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736596; c=relaxed/simple;
	bh=6fj/DX2RBc3mm1fSA9gkesW+xuAGsYbPXv5YOo3ZBf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFiahCazhwRFPd99t1p5rxVmU4uTtJpZuOIKDfakyQRSr2aQMYbftK6hq1peRETnxCqwNbS07GBI3RRTR0INHCmsA0KfhkfPjfYmw1yDoATlWw6bQ8bDl1hZOE4C4DwZSdFLWnlCUaQv1jAKFg/vPsNcFiAU8Gs3ZvACwds5+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AI3vnwwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21762C433F1;
	Wed, 31 Jan 2024 21:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706736596;
	bh=6fj/DX2RBc3mm1fSA9gkesW+xuAGsYbPXv5YOo3ZBf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AI3vnwwTrvTu/QmK0+wair/yqTNxuvY3lHDtxhEJsUHHEdbIgVtl/EEh5Bp8psqwm
	 iOERzdMsjw2BfNEmJNqTAtyyeZv5WqKX0HKBR6Ny3xbF4O8NGXIrDZNlkX59mP91f4
	 YYcd60X77bb0TPxulFrcoGTJNmwkr8vI+TL+g0ko=
Date: Wed, 31 Jan 2024 13:29:56 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Leech <cleech@redhat.com>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 2/2] cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
Message-ID: <2024013125-unraveled-definite-7fc6@gregkh>
References: <20240131191732.3247996-1-cleech@redhat.com>
 <20240131191732.3247996-3-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131191732.3247996-3-cleech@redhat.com>

On Wed, Jan 31, 2024 at 11:17:32AM -0800, Chris Leech wrote:
> Use the UIO_MEM_DMA_COHERENT type to properly handle mmap for
> dma_alloc_coherent buffers.
> 
> The cnic l2_ring and l2_buf mmaps have caused page refcount issues as
> the dma_alloc_coherent no longer provide __GFP_COMP allocation as per
> commit "dma-mapping: reject __GFP_COMP in dma_alloc_attrs".
> 
> Fix this by having the uio device use dma_mmap_coherent.
> 
> The bnx2 and bnx2x status block allocations are also dma_alloc_coherent,
> and should use dma_mmap_coherent. They don't allocate multiple pages,
> but this interface does not work correctly with an iommu enabled unless
> dma_mmap_coherent is used.
> 
> Fixes: bb73955c0b1d ("cnic: don't pass bogus GFP_ flags to dma_alloc_coherent")

This is really the commit that broke things?  By adding this, are you
expecting anyone to backport this change to older kernels?

thanks,

greg k-h

