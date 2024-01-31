Return-Path: <linux-kernel+bounces-47158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A48108449FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FC2858DB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D7039AFC;
	Wed, 31 Jan 2024 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRrQi1l0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633539876;
	Wed, 31 Jan 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736425; cv=none; b=blhWwu1+g3Hs1sx2LbjMvQsNtjJHH9Qyfh5pu7km2ppCSPoC41GL60pqtcjXOQ9CqhsIfNbqEG5kVdmIRkgHc+Z78IxUkhQlu2RryYuRZz7dcUI3lbpAG6wMI2qDQboyvxwQa9YMQp+gtcmuvPeTXYD9edo87YHpYlImxeTsJDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736425; c=relaxed/simple;
	bh=W9PyDFDm6db+wY56jckOPsaPr9KPRsFX9rqfQqV1gzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHe6rV6xuCIaqfN9mDmXSPa7ojnxTK5heOhm/vVSAMcqu3xZSiG3h2PpkXN6YiaQ4KGCTdsnEQTObqBwx+PidyuTiwvp1v3HdybA1LDYvLTUy5nCa5TZHGjtnEnwBp+WWs/heWB5hkmbU32GDRehpvtJCBir1RaGQvI+++GhxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRrQi1l0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5850C433F1;
	Wed, 31 Jan 2024 21:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706736424;
	bh=W9PyDFDm6db+wY56jckOPsaPr9KPRsFX9rqfQqV1gzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lRrQi1l03Zl7CRmx/XVUgrMjdmBqPJR+e39jYW/Yf7erVn3NUY7RkSyctWLWh0rAy
	 h94FQtxcOv+D30DLHgdSGAu20JrzttlVz5mtVyMs03TglDV9dfqFrwq1zJcGm3hZSk
	 jbThPTY36ZiyVC0xvQ4yY02id0RO/CIQFtJDz7ko=
Date: Wed, 31 Jan 2024 13:27:03 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Leech <cleech@redhat.com>
Cc: Nilesh Javali <njavali@marvell.com>, Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/2] UIO_MEM_DMA_COHERENT for cnic/bnx2/bnx2x
Message-ID: <2024013123-subway-shrapnel-98f4@gregkh>
References: <20240131191732.3247996-1-cleech@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131191732.3247996-1-cleech@redhat.com>

On Wed, Jan 31, 2024 at 11:17:30AM -0800, Chris Leech wrote:
> During bnx2i iSCSI testing we ran into page refcounting issues in the
> uio mmaps exported from cnic to the iscsiuio process, and bisected back
> to the removal of the __GFP_COMP flag from dma_alloc_coherent calls.
> 
> The cnic uio interface also has issues running with an iommu enabled,
> which these changes correct.
> 
> In order to fix these drivers to be able to mmap dma coherent memory via
> a uio device, introduce a new uio mmap type backed by dma_mmap_coherent.
> 
> While I understand some complaints about how these drivers have been
> structured, I also don't like letting support bitrot when there's a
> reasonable alternative to re-architecting an existing driver. I believe
> this to be the most sane way to restore these drivers to functioning
> properly.
> 
> There are two other uio drivers which are mmaping dma_alloc_coherent
> memory as UIO_MEM_PHYS, uio_dmem_genirq and uio_pruss. While a
> conversion to use dma_mmap_coherent might be more correct for these as
> well, I have no way of testing them and assume that this just hasn't
> been an issue for the platforms in question.
> 
> v4:
> - re-introduce the dma_device member to uio_map,
>   it needs to be passed to dma_mmap_coherent somehow
> - drop patch 3 to focus only on the uio interface,
>   explicit page alignment isn't needed
> - re-add the v1 mail recipients,
>   this isn't something to be handled through linux-scsi
> v3 (Nilesh Javali <njavali@marvell.com>):
> - fix warnings reported by kernel test robot
>   and added base commit
> v2 (Nilesh Javali <njavali@marvell.com>):
> - expose only the dma_addr within uio and cnic.
> - Cleanup newly added unions comprising virtual_addr
>   and struct device
> 
> previous threads:
> v1: https://lore.kernel.org/all/20230929170023.1020032-1-cleech@redhat.com/
> attempt at an alternative change: https://lore.kernel.org/all/20231219055514.12324-1-njavali@marvell.com/
> v2: https://lore.kernel.org/all/20240103091137.27142-1-njavali@marvell.com/
> v3: https://lore.kernel.org/all/20240109121458.26475-1-njavali@marvell.com/
> 
> Chris Leech (2):
>   uio: introduce UIO_MEM_DMA_COHERENT type
>   cnic,bnx2,bnx2x: use UIO_MEM_DMA_COHERENT
> 
>  drivers/net/ethernet/broadcom/bnx2.c          |  1 +
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +
>  drivers/net/ethernet/broadcom/cnic.c          | 15 +++++--
>  drivers/net/ethernet/broadcom/cnic.h          |  1 +
>  drivers/net/ethernet/broadcom/cnic_if.h       |  1 +
>  drivers/uio/uio.c                             | 40 +++++++++++++++++++
>  include/linux/uio_driver.h                    |  3 ++
>  7 files changed, 60 insertions(+), 3 deletions(-)
> 
> 
> base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
> -- 
> 2.43.0
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but the
  version is not listed in the subject line.  Please read the section
  entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

