Return-Path: <linux-kernel+bounces-47624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB454845068
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037BD1C252DB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF93BB4E;
	Thu,  1 Feb 2024 04:44:22 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866E3B789;
	Thu,  1 Feb 2024 04:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762662; cv=none; b=Lb5tSApQbav0rlbtPtvqWt5S0VitFH3/uxapqTImNdZX2FycXRvxLUtK+txOnN5uWVNaQZC8yEPJB39TVZ+VzJtK+Aad9Ri0dhKAmMDwBkJfqyCxZZqk/H1v+H0tm6k6nRgriqV2wO6RDXQkX+LxG9iedMVd8xMb0TeMTF43wGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762662; c=relaxed/simple;
	bh=/QsB7GMFRLD9SZxmAVzdpodDx52e5lS3sgzFEmbp++Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/xXCfZ/wH3EAZl+2VWnUxeqX5waB2xJSeH6z9ruhv0umAGPGNHicessEUqgbhq+MxlUHxE+sAraQhUlaPKBjXWmvhI1E73xZbcTwji1x57JbBKVYnr7hiUec/UUWtz75Kr+S8XweEmXAYxfHhYvGfN2pHAUnhD0jiEgG5Nep4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 518D968AFE; Thu,  1 Feb 2024 05:44:16 +0100 (CET)
Date: Thu, 1 Feb 2024 05:44:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chris Leech <cleech@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <20240201044416.GA14176@lst.de>
References: <20240131191732.3247996-1-cleech@redhat.com> <20240131191732.3247996-2-cleech@redhat.com> <2024013110-greasily-juvenile-73fc@gregkh> <CAPnfmX+c_TECfVgbAgphFgkCOr-=tKEvHmcxPg_vSY-qJRqaQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnfmX+c_TECfVgbAgphFgkCOr-=tKEvHmcxPg_vSY-qJRqaQQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 31, 2024 at 01:44:50PM -0800, Chris Leech wrote:
> On Wed, Jan 31, 2024 at 1:29 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jan 31, 2024 at 11:17:31AM -0800, Chris Leech wrote:
> > > Add a UIO memtype specifically for sharing dma_alloc_coherent
> > > memory with userspace, backed by dma_mmap_coherent.
> > >
> > > This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> > > are a few other uio drivers which map dma_alloc_coherent memory and
> > > could be converted to use dma_mmap_coherent as well.
> >
> > What other drivers could use this?  Patches doing the conversion would
> > be welcome, otherwise, again, I am very loath to take this
> > one-off-change for just a single driver that shouldn't be doing this in
> > the first place :)
> 
> uio_pruss and uio_dmem_genirq both appear to mmap dma_alloc_coherent
> memory as UIO_MEM_PHYS.  It might not be an issue on that platforms
> where those are used, but I'd be happy to include untested patches to
> convert them for better adherence to the DMA APIs.

Yes, they do need fixing.

