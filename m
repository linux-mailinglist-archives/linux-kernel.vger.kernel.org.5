Return-Path: <linux-kernel+bounces-47168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B0844A11
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865FF1C237FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAA39AF6;
	Wed, 31 Jan 2024 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YOiz0P0j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF82539843;
	Wed, 31 Jan 2024 21:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736534; cv=none; b=VbTsfb8H2TUXhPe8eE7wx5E5Bow2KQ/Vexki0QrVsFwYTBzc9cVkZ2JNpXLQg2ERZEmFyxU3ILVWyfBpDwpu+PQOl25AWN1jRthghut67W1WLbDTDGiVhQ9IxTkeW7c0xny0DP6rCPQpZvGLpxl3GYUDjRhMeeSnttv8aDJyeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736534; c=relaxed/simple;
	bh=wuWxeCOodCyEvRLOOFJJptfo/uX+q6W7Z6Zj+MRADO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9l9ZIL8em6cLHKOE1BygKozfWhpPwf50pA3BMOIXM/iDTXX1dY1e4azG5wexJbP4EsGTjF3S2fmYcUq7maCIpsI+LA9RI+jGcjOJB6RYehkb0bKrBAQPuKuM207msPBqRLCN+sM8C4Kp2xto2HmRGkv4JNQ7g77TYGsyn7Ogug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YOiz0P0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8D8C433F1;
	Wed, 31 Jan 2024 21:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706736533;
	bh=wuWxeCOodCyEvRLOOFJJptfo/uX+q6W7Z6Zj+MRADO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOiz0P0jCd9M3sT8Cad6kK0UQgMSOkgPCJxB3lLHQ96OTe5rVfa0Xv7uVDGHAYUS3
	 pxF09V64Mm37vzfzvManF8AANRNtw82zoniaS0cU9f7Q3DviZ+vmh8Cv0gxexoMCC5
	 g/hKKFTZpZDLfVTqn2XodgEeBsts2AIXM1I4dbfw=
Date: Wed, 31 Jan 2024 13:28:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Leech <cleech@redhat.com>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 1/2] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <2024013110-greasily-juvenile-73fc@gregkh>
References: <20240131191732.3247996-1-cleech@redhat.com>
 <20240131191732.3247996-2-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131191732.3247996-2-cleech@redhat.com>

On Wed, Jan 31, 2024 at 11:17:31AM -0800, Chris Leech wrote:
> Add a UIO memtype specifically for sharing dma_alloc_coherent
> memory with userspace, backed by dma_mmap_coherent.
> 
> This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> are a few other uio drivers which map dma_alloc_coherent memory and
> could be converted to use dma_mmap_coherent as well.

What other drivers could use this?  Patches doing the conversion would
be welcome, otherwise, again, I am very loath to take this
one-off-change for just a single driver that shouldn't be doing this in
the first place :)

thanks,

greg k-h

