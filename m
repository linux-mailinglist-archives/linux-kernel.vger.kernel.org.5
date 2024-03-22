Return-Path: <linux-kernel+bounces-111615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6E1886E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AECD1F23740
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668B4AEF0;
	Fri, 22 Mar 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F0ZEsdOm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A431481D0;
	Fri, 22 Mar 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117842; cv=none; b=O74AiG/nNJSOJrd7ryfYhWz8V4o2He8QH9Ti31nfj+xbtIAu3pgCZbz1MNwxzNlgwTnRiG60Il9lkMp9j9d7Pfi+q6N0qTm0UwEhin8OAuY4eoVG3Hvakz53Vr32zsCMelI+DeA3ZHcrHn3znuQEhBQ/JOP2XLAoTTIB7DJ5lG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117842; c=relaxed/simple;
	bh=T/jKj4/iW9yfrA6kGZOg1yFTxBhpOhojURXvqMGy8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo71IMW3fnY2ofuvFOM1MgauP/SHgZ9QAHpn7Oh9q6S+G1LXQxKPyFeKFe5qVLKiWw+4uMYpFVy489yjnXnbORU0P43s32cjgYRs/92B5WAIGbjEYtw07eUd9Xywgm8Wx7jHA4E2udRCRjadNvfyF4Wkong+EPboMhjjtk+ybTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F0ZEsdOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC57C43394;
	Fri, 22 Mar 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711117840;
	bh=T/jKj4/iW9yfrA6kGZOg1yFTxBhpOhojURXvqMGy8G8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F0ZEsdOm1JYUMZqeYJCE3EC0AqqMsFWIxQlVCZSY7N3Sz+NIlaceCz/FL7RMbHsF1
	 K1hxFhrj1aFF5dzMmZawvCKTkGWNzYeCxdfDR4Pj5Ge18QboRFf7Oxum1G8M8uvleA
	 8eyNN8JcSOma2IRKCrnpd5ToWxjRUzMV0/7UlJpg=
Date: Fri, 22 Mar 2024 15:30:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Leech <cleech@redhat.com>, Nilesh Javali <njavali@marvell.com>,
	Christoph Hellwig <hch@lst.de>,
	John Meneghini <jmeneghi@redhat.com>, Lee Duncan <lduncan@suse.com>,
	Mike Christie <michael.christie@oracle.com>,
	Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
	GR-QLogic-Storage-Upstream@marvell.com,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v6 1/4] uio: introduce UIO_MEM_DMA_COHERENT type
Message-ID: <2024032203-dawn-crestless-4199@gregkh>
References: <20240201233400.3394996-2-cleech@redhat.com>
 <20240205200137.138302-1-cleech@redhat.com>
 <4f606e50-865c-46f2-b89e-6c1dfe02f527@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f606e50-865c-46f2-b89e-6c1dfe02f527@roeck-us.net>

On Fri, Mar 22, 2024 at 07:16:19AM -0700, Guenter Roeck wrote:
> On Mon, Feb 05, 2024 at 12:01:37PM -0800, Chris Leech wrote:
> > Add a UIO memtype specifically for sharing dma_alloc_coherent
> > memory with userspace, backed by dma_mmap_coherent.
> > 
> > This is mainly for the bnx2/bnx2x/bnx2i "cnic" interface, although there
> > are a few other uio drivers which map dma_alloc_coherent memory and will
> > be converted to use dma_mmap_coherent as well.
> > 
> > Signed-off-by: Nilesh Javali <njavali@marvell.com>
> > Signed-off-by: Chris Leech <cleech@redhat.com>
> > ---
> 
> Building i386:allyesconfig ... failed
> --------------
> Error log:
> drivers/uio/uio.c: In function 'uio_mmap_dma_coherent':
> drivers/uio/uio.c:795:16: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   795 |         addr = (void *)mem->addr;
>       |                ^

So on 32bit systems phys_addr_t != the same size as (void *)?  How is
that possible?  We also are doing an explicit cast here, how does this
not work?

Ah, do you have CONFIG_X86_PAE enabled?  That would cause that mess,
ick.


> cc1: all warnings being treated as errors
> make[5]: [scripts/Makefile.build:244: drivers/uio/uio.o] Error 1 (ignored)
> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_open':
> drivers/uio/uio_dmem_genirq.c:63:39: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>    63 |                 uiomem->addr = addr ? (phys_addr_t) addr : DMEM_MAP_ERROR;
>       |                                       ^
> drivers/uio/uio_dmem_genirq.c: In function 'uio_dmem_genirq_release':
> drivers/uio/uio_dmem_genirq.c:92:43: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>    92 |                                           (void *) uiomem->addr,
>       |                                           ^
> cc1: all warnings being treated as errors
> make[5]: [scripts/Makefile.build:244: drivers/uio/uio_dmem_genirq.o] Error 1 (ignored)
> drivers/uio/uio_pruss.c: In function 'pruss_probe':
> drivers/uio/uio_pruss.c:194:34: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
>   194 |                 p->mem[2].addr = (phys_addr_t) gdev->ddr_vaddr;
>       |                                  ^
> cc1: all warnings being treated as errors
> 
> Caused by this patch and "uio_dmem_genirq: UIO_MEM_DMA_COHERENT conversion" as well
> as "uio_pruss: UIO_MEM_DMA_COHERENT conversion".
> 
> I'd suggest to make uio dependent on 64 bit if 32 bit is no longer supported
> to prevent waste of test builds resources.

Perhaps disable it if PHYS_ADDR_T_64BIT is not enabled?

Chris, can you make up a patch?  Odd that this didn't show up in 0-day
before this, does it not test 32bit builds anymore?

thanks,

greg k-h

