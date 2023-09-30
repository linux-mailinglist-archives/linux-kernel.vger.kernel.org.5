Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B267B3EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 09:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjI3HKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 03:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjI3HKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 03:10:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE1C5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 00:10:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BB4C433C8;
        Sat, 30 Sep 2023 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696057813;
        bh=uvGD1csA5JWxarCHp9AYsOjN6Mf9w1sy7vN59u16vz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UO+RYsCedPI73JzxykVPefAXh/+ASlxwiOA9qJ27HKndAAIOP1hfuMNm7lXMXrSNO
         X0+VdhabYsih7Wq6zJOmoRsag9sO+DkhnAP5Oz9S2Ricf6PBQBWN32oRUCVGWAgzGi
         didA5lSJoGzH8SKrt/U2Xmgrd/2+VPxi9GkcPFvA=
Date:   Sat, 30 Sep 2023 09:10:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Leech <cleech@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Rasesh Mody <rmody@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Lee Duncan <lduncan@suse.com>,
        Mike Christie <michael.christie@oracle.com>,
        Hannes Reinecke <hare@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] uio: introduce UIO_DMA_COHERENT type
Message-ID: <2023093037-onion-backroom-b4ef@gregkh>
References: <20230929170023.1020032-1-cleech@redhat.com>
 <20230929170023.1020032-2-cleech@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929170023.1020032-2-cleech@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 10:00:21AM -0700, Chris Leech wrote:
> Add a UIO memtype specificially for sharing dma_alloc_coherent
> memory with userspace, backed by dma_mmap_coherent.

Are you sure that you can share this type of memory with userspace
safely?  And you are saying what you are doing here, but not why you
want to do it and who will use it.

What are the userspace implications for accessing this type of memory?

> 
> Signed-off-by: Chris Leech <cleech@redhat.com>
> ---
>  drivers/uio/uio.c          | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/uio_driver.h | 12 ++++++++++--
>  2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
> index 62082d64ece0..f8f1f7ba6378 100644
> --- a/drivers/uio/uio.c
> +++ b/drivers/uio/uio.c
> @@ -24,6 +24,7 @@
>  #include <linux/kobject.h>
>  #include <linux/cdev.h>
>  #include <linux/uio_driver.h>
> +#include <linux/dma-mapping.h>
>  
>  #define UIO_MAX_DEVICES		(1U << MINORBITS)
>  
> @@ -759,6 +760,36 @@ static int uio_mmap_physical(struct vm_area_struct *vma)
>  			       vma->vm_page_prot);
>  }
>  
> +static int uio_mmap_dma_coherent(struct vm_area_struct *vma)
> +{
> +	struct uio_device *idev = vma->vm_private_data;
> +	int mi = uio_find_mem_index(vma);
> +	struct uio_mem *mem;
> +	int rc;
> +
> +	if (mi < 0)
> +		return -EINVAL;
> +	mem = idev->info->mem + mi;
> +
> +	if (mem->dma_addr & ~PAGE_MASK)
> +		return -ENODEV;
> +	if (vma->vm_end - vma->vm_start > mem->size)
> +		return -EINVAL;
> +
> +	/*
> +	 * UIO uses offset to index into the maps for a device.
> +	 * We need to clear vm_pgoff for dma_mmap_coherent.
> +	 */
> +	vma->vm_pgoff = 0;
> +	rc = dma_mmap_coherent(mem->dma_device,
> +				vma,
> +				mem->virtual_addr,
> +				mem->dma_addr,
> +				vma->vm_end - vma->vm_start);
> +	vma->vm_pgoff = mi;
> +	return rc;
> +}
> +
>  static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>  {
>  	struct uio_listener *listener = filep->private_data;
> @@ -806,6 +837,9 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
>  	case UIO_MEM_VIRTUAL:
>  		ret = uio_mmap_logical(vma);
>  		break;
> +	case UIO_MEM_DMA_COHERENT:
> +		ret = uio_mmap_dma_coherent(vma);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> diff --git a/include/linux/uio_driver.h b/include/linux/uio_driver.h
> index 47c5962b876b..ede58e984658 100644
> --- a/include/linux/uio_driver.h
> +++ b/include/linux/uio_driver.h
> @@ -36,11 +36,18 @@ struct uio_map;
>   */
>  struct uio_mem {
>  	const char		*name;
> -	phys_addr_t		addr;
> +	union {
> +		phys_addr_t	addr;
> +		dma_addr_t	dma_addr;
> +	};
>  	unsigned long		offs;
>  	resource_size_t		size;
>  	int			memtype;
> -	void __iomem		*internal_addr;
> +	union {
> +		void __iomem	*internal_addr;
> +		void 		*virtual_addr;
> +	};
> +	struct device		*dma_device;

Why are you adding a new struct device here?

And why the unions?  How are you going to verify that they are being
used correctly?  What space savings are you attempting to do here and
why?

thanks,

greg k-h
