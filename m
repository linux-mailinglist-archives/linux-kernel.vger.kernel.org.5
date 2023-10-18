Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69C07CD3A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjJRFrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJRFrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:47:36 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0BABA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FkiSUrg196eepvGRcalTonWsRuwcgK8K0n5y8Lz03F4=;
  b=cuHFXmUSG6mVcZ7oDjkBEDJddlnzYX3ZVsGL7ys/TCSSy1vn4PiK6Snn
   Nm0dA4ewXyksE0x/RJJ4R5eWhhV8h6QDKemj8l9E/PD7SqWaEW77BYifF
   6Z5BXgSesv7f77qfJqyZivii/5SqRCWVci1hgutnJ3uRisefwwSgjEIu3
   M=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,234,1694728800"; 
   d="scan'208";a="69015274"
Received: from unknown (HELO hadrien) ([87.129.180.234])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 07:47:30 +0200
Date:   Wed, 18 Oct 2023 07:47:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Soumya Negi <soumya.negi97@gmail.com>
cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 1/2] staging: vme_user: Replace printk() with
 pr_*(),dev_*()
In-Reply-To: <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
Message-ID: <19637f96-40bc-a46b-8e7a-fa59e5e9e16@inria.fr>
References: <cover.1697601942.git.soumya.negi97@gmail.com> <a0579eeda5ce70f69b6bfdcbe534b9d37138096c.1697601942.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2023, Soumya Negi wrote:

> vme.c uses printk() to log messages. To improve and standardize message
> formatting, use logging mechanisms pr_err()/pr_warn() and
> dev_err()/dev_warn() instead. Retain the printk log levels of the
> messages during replacement.

It's not possible to use the dev_ functions more often?  The pr_functions
don't give context information, and the message don't seem to give much
context information either.

julia


>
> Issue found by checkpatch.pl
>
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 175 ++++++++++++++++++---------------
>  1 file changed, 94 insertions(+), 81 deletions(-)
>
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index 6519a7c994a0..e8c2c1e77b7d 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -9,6 +9,8 @@
>   * Copyright 2004 Motorola Inc.
>   */
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/init.h>
>  #include <linux/export.h>
>  #include <linux/mm.h>
> @@ -62,7 +64,7 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
>  		return list_entry(resource->entry, struct vme_lm_resource,
>  			list)->parent;
>  	default:
> -		printk(KERN_ERR "Unknown resource type\n");
> +		pr_err("Unknown resource type\n");
>  		return NULL;
>  	}
>  }
> @@ -84,24 +86,25 @@ void *vme_alloc_consistent(struct vme_resource *resource, size_t size,
>  	struct vme_bridge *bridge;
>
>  	if (!resource) {
> -		printk(KERN_ERR "No resource\n");
> +		pr_err("No resource\n");
>  		return NULL;
>  	}
>
>  	bridge = find_bridge(resource);
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find bridge\n");
> +		pr_err("Can't find bridge\n");
>  		return NULL;
>  	}
>
>  	if (!bridge->parent) {
> -		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
> +		pr_err("Dev entry NULL for bridge %s\n", bridge->name);
>  		return NULL;
>  	}
>
>  	if (!bridge->alloc_consistent) {
> -		printk(KERN_ERR "alloc_consistent not supported by bridge %s\n",
> -		       bridge->name);
> +		dev_err(bridge->parent,
> +			"alloc_consistent not supported by bridge %s\n",
> +			bridge->name);
>  		return NULL;
>  	}
>
> @@ -124,24 +127,25 @@ void vme_free_consistent(struct vme_resource *resource, size_t size,
>  	struct vme_bridge *bridge;
>
>  	if (!resource) {
> -		printk(KERN_ERR "No resource\n");
> +		pr_err("No resource\n");
>  		return;
>  	}
>
>  	bridge = find_bridge(resource);
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find bridge\n");
> +		pr_err("Can't find bridge\n");
>  		return;
>  	}
>
>  	if (!bridge->parent) {
> -		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
> +		pr_err("Dev entry NULL for bridge %s\n", bridge->name);
>  		return;
>  	}
>
>  	if (!bridge->free_consistent) {
> -		printk(KERN_ERR "free_consistent not supported by bridge %s\n",
> -		       bridge->name);
> +		dev_err(bridge->parent,
> +			"free_consistent not supported by bridge %s\n",
> +			bridge->name);
>  		return;
>  	}
>
> @@ -184,7 +188,7 @@ size_t vme_get_size(struct vme_resource *resource)
>  	case VME_DMA:
>  		return 0;
>  	default:
> -		printk(KERN_ERR "Unknown resource type\n");
> +		pr_err("Unknown resource type\n");
>  		return 0;
>  	}
>  }
> @@ -225,7 +229,7 @@ int vme_check_window(u32 aspace, unsigned long long vme_base,
>  		/* User Defined */
>  		break;
>  	default:
> -		printk(KERN_ERR "Invalid address space\n");
> +		pr_err("Invalid address space\n");
>  		retval = -EINVAL;
>  		break;
>  	}
> @@ -288,14 +292,14 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		goto err_bus;
>  	}
>
>  	/* Loop through slave resources */
>  	list_for_each_entry(slave_image, &bridge->slave_resources, list) {
>  		if (!slave_image) {
> -			printk(KERN_ERR "Registered NULL Slave resource\n");
> +			dev_err(bridge->parent, "Registered NULL Slave resource\n");
>  			continue;
>  		}
>
> @@ -362,20 +366,20 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
>  	int retval;
>
>  	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		pr_err("Not a slave resource\n");
>  		return -EINVAL;
>  	}
>
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>
>  	if (!bridge->slave_set) {
> -		printk(KERN_ERR "Function not supported\n");
> +		dev_err(bridge->parent, "Function not supported\n");
>  		return -ENOSYS;
>  	}
>
>  	if (!(((image->address_attr & aspace) == aspace) &&
>  	      ((image->cycle_attr & cycle) == cycle))) {
> -		printk(KERN_ERR "Invalid attributes\n");
> +		pr_err("Invalid attributes\n");
>  		return -EINVAL;
>  	}
>
> @@ -411,14 +415,14 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>  	struct vme_slave_resource *image;
>
>  	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		pr_err("Not a slave resource\n");
>  		return -EINVAL;
>  	}
>
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>
>  	if (!bridge->slave_get) {
> -		printk(KERN_ERR "vme_slave_get not supported\n");
> +		dev_err(bridge->parent, "vme_slave_get not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -438,21 +442,21 @@ void vme_slave_free(struct vme_resource *resource)
>  	struct vme_slave_resource *slave_image;
>
>  	if (resource->type != VME_SLAVE) {
> -		printk(KERN_ERR "Not a slave resource\n");
> +		pr_err("Not a slave resource\n");
>  		return;
>  	}
>
>  	slave_image = list_entry(resource->entry, struct vme_slave_resource,
>  				 list);
>  	if (!slave_image) {
> -		printk(KERN_ERR "Can't find slave resource\n");
> +		pr_err("Can't find slave resource\n");
>  		return;
>  	}
>
>  	/* Unlock image */
>  	mutex_lock(&slave_image->mtx);
>  	if (slave_image->locked == 0)
> -		printk(KERN_ERR "Image is already free\n");
> +		pr_err("Image is already free\n");
>
>  	slave_image->locked = 0;
>  	mutex_unlock(&slave_image->mtx);
> @@ -484,14 +488,14 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		goto err_bus;
>  	}
>
>  	/* Loop through master resources */
>  	list_for_each_entry(master_image, &bridge->master_resources, list) {
>  		if (!master_image) {
> -			printk(KERN_WARNING "Registered NULL master resource\n");
> +			dev_warn(bridge->parent, "Registered NULL master resource\n");
>  			continue;
>  		}
>
> @@ -511,7 +515,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
>
>  	/* Check to see if we found a resource */
>  	if (!allocated_image) {
> -		printk(KERN_ERR "Can't find a suitable resource\n");
> +		dev_err(&vdev->dev, "Can't find a suitable resource\n");
>  		goto err_image;
>  	}
>
> @@ -561,21 +565,21 @@ int vme_master_set(struct vme_resource *resource, int enabled,
>  	int retval;
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return -EINVAL;
>  	}
>
>  	image = list_entry(resource->entry, struct vme_master_resource, list);
>
>  	if (!bridge->master_set) {
> -		printk(KERN_WARNING "vme_master_set not supported\n");
> +		dev_warn(bridge->parent, "vme_master_set not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (!(((image->address_attr & aspace) == aspace) &&
>  	      ((image->cycle_attr & cycle) == cycle) &&
>  	      ((image->width_attr & dwidth) == dwidth))) {
> -		printk(KERN_WARNING "Invalid attributes\n");
> +		pr_warn("Invalid attributes\n");
>  		return -EINVAL;
>  	}
>
> @@ -611,14 +615,14 @@ int vme_master_get(struct vme_resource *resource, int *enabled,
>  	struct vme_master_resource *image;
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return -EINVAL;
>  	}
>
>  	image = list_entry(resource->entry, struct vme_master_resource, list);
>
>  	if (!bridge->master_get) {
> -		printk(KERN_WARNING "%s not supported\n", __func__);
> +		dev_warn(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>
> @@ -650,12 +654,12 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>  	size_t length;
>
>  	if (!bridge->master_read) {
> -		printk(KERN_WARNING "Reading from resource not supported\n");
> +		dev_warn(bridge->parent, "Reading from resource not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return -EINVAL;
>  	}
>
> @@ -664,7 +668,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
>  	length = vme_get_size(resource);
>
>  	if (offset > length) {
> -		printk(KERN_WARNING "Invalid Offset\n");
> +		pr_warn("Invalid Offset\n");
>  		return -EFAULT;
>  	}
>
> @@ -698,12 +702,12 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
>  	size_t length;
>
>  	if (!bridge->master_write) {
> -		printk(KERN_WARNING "Writing to resource not supported\n");
> +		dev_warn(bridge->parent, "Writing to resource not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return -EINVAL;
>  	}
>
> @@ -712,7 +716,7 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
>  	length = vme_get_size(resource);
>
>  	if (offset > length) {
> -		printk(KERN_WARNING "Invalid Offset\n");
> +		pr_warn("Invalid Offset\n");
>  		return -EFAULT;
>  	}
>
> @@ -749,12 +753,12 @@ unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int mask,
>  	struct vme_master_resource *image;
>
>  	if (!bridge->master_rmw) {
> -		printk(KERN_WARNING "Writing to resource not supported\n");
> +		dev_warn(bridge->parent, "Writing to resource not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return -EINVAL;
>  	}
>
> @@ -812,21 +816,21 @@ void vme_master_free(struct vme_resource *resource)
>  	struct vme_master_resource *master_image;
>
>  	if (resource->type != VME_MASTER) {
> -		printk(KERN_ERR "Not a master resource\n");
> +		pr_err("Not a master resource\n");
>  		return;
>  	}
>
>  	master_image = list_entry(resource->entry, struct vme_master_resource,
>  				  list);
>  	if (!master_image) {
> -		printk(KERN_ERR "Can't find master resource\n");
> +		pr_err("Can't find master resource\n");
>  		return;
>  	}
>
>  	/* Unlock image */
>  	spin_lock(&master_image->lock);
>  	if (master_image->locked == 0)
> -		printk(KERN_ERR "Image is already free\n");
> +		pr_err("Image is already free\n");
>
>  	master_image->locked = 0;
>  	spin_unlock(&master_image->lock);
> @@ -854,18 +858,19 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
>  	struct vme_resource *resource = NULL;
>
>  	/* XXX Not checking resource attributes */
> -	printk(KERN_ERR "No VME resource Attribute tests done\n");
> +	pr_err("No VME resource Attribute tests done\n");
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		goto err_bus;
>  	}
>
>  	/* Loop through DMA resources */
>  	list_for_each_entry(dma_ctrlr, &bridge->dma_resources, list) {
>  		if (!dma_ctrlr) {
> -			printk(KERN_ERR "Registered NULL DMA resource\n");
> +			dev_err(bridge->parent,
> +				"Registered NULL DMA resource\n");
>  			continue;
>  		}
>
> @@ -920,7 +925,7 @@ struct vme_dma_list *vme_new_dma_list(struct vme_resource *resource)
>  	struct vme_dma_list *dma_list;
>
>  	if (resource->type != VME_DMA) {
> -		printk(KERN_ERR "Not a DMA resource\n");
> +		pr_err("Not a DMA resource\n");
>  		return NULL;
>  	}
>
> @@ -1098,12 +1103,13 @@ int vme_dma_list_add(struct vme_dma_list *list, struct vme_dma_attr *src,
>  	int retval;
>
>  	if (!bridge->dma_list_add) {
> -		printk(KERN_WARNING "Link List DMA generation not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Link List DMA generation not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (!mutex_trylock(&list->mtx)) {
> -		printk(KERN_ERR "Link List already submitted\n");
> +		pr_err("Link List already submitted\n");
>  		return -EINVAL;
>  	}
>
> @@ -1131,7 +1137,8 @@ int vme_dma_list_exec(struct vme_dma_list *list)
>  	int retval;
>
>  	if (!bridge->dma_list_exec) {
> -		printk(KERN_ERR "Link List DMA execution not supported\n");
> +		dev_err(bridge->parent,
> +			"Link List DMA execution not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1160,12 +1167,13 @@ int vme_dma_list_free(struct vme_dma_list *list)
>  	int retval;
>
>  	if (!bridge->dma_list_empty) {
> -		printk(KERN_WARNING "Emptying of Link Lists not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Emptying of Link Lists not supported\n");
>  		return -EINVAL;
>  	}
>
>  	if (!mutex_trylock(&list->mtx)) {
> -		printk(KERN_ERR "Link List in use\n");
> +		pr_err("Link List in use\n");
>  		return -EBUSY;
>  	}
>
> @@ -1175,7 +1183,7 @@ int vme_dma_list_free(struct vme_dma_list *list)
>  	 */
>  	retval = bridge->dma_list_empty(list);
>  	if (retval) {
> -		printk(KERN_ERR "Unable to empty link-list entries\n");
> +		pr_err("Unable to empty link-list entries\n");
>  		mutex_unlock(&list->mtx);
>  		return retval;
>  	}
> @@ -1200,19 +1208,19 @@ int vme_dma_free(struct vme_resource *resource)
>  	struct vme_dma_resource *ctrlr;
>
>  	if (resource->type != VME_DMA) {
> -		printk(KERN_ERR "Not a DMA resource\n");
> +		pr_err("Not a DMA resource\n");
>  		return -EINVAL;
>  	}
>
>  	ctrlr = list_entry(resource->entry, struct vme_dma_resource, list);
>
>  	if (!mutex_trylock(&ctrlr->mtx)) {
> -		printk(KERN_ERR "Resource busy, can't free\n");
> +		pr_err("Resource busy, can't free\n");
>  		return -EBUSY;
>  	}
>
>  	if (!(list_empty(&ctrlr->pending) && list_empty(&ctrlr->running))) {
> -		printk(KERN_WARNING "Resource still processing transfers\n");
> +		pr_warn("Resource still processing transfers\n");
>  		mutex_unlock(&ctrlr->mtx);
>  		return -EBUSY;
>  	}
> @@ -1290,8 +1298,9 @@ void vme_irq_handler(struct vme_bridge *bridge, int level, int statid)
>  	if (call)
>  		call(level, statid, priv_data);
>  	else
> -		printk(KERN_WARNING "Spurious VME interrupt, level:%x, vector:%x\n",
> -		       level, statid);
> +		dev_warn(bridge->parent,
> +			 "Spurious VME interrupt, level:%x, vector:%x\n", level,
> +			 statid);
>  }
>  EXPORT_SYMBOL(vme_irq_handler);
>
> @@ -1319,17 +1328,18 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		return -EINVAL;
>  	}
>
>  	if ((level < 1) || (level > 7)) {
> -		printk(KERN_ERR "Invalid interrupt level\n");
> +		pr_err("Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
>
>  	if (!bridge->irq_set) {
> -		printk(KERN_ERR "Configuring interrupts not supported\n");
> +		dev_err(bridge->parent,
> +			"Configuring interrupts not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1337,7 +1347,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
>
>  	if (bridge->irq[level - 1].callback[statid].func) {
>  		mutex_unlock(&bridge->irq_mtx);
> -		printk(KERN_WARNING "VME Interrupt already taken\n");
> +		dev_warn(bridge->parent, "VME Interrupt already taken\n");
>  		return -EBUSY;
>  	}
>
> @@ -1368,17 +1378,18 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		return;
>  	}
>
>  	if ((level < 1) || (level > 7)) {
> -		printk(KERN_ERR "Invalid interrupt level\n");
> +		pr_err("Invalid interrupt level\n");
>  		return;
>  	}
>
>  	if (!bridge->irq_set) {
> -		printk(KERN_ERR "Configuring interrupts not supported\n");
> +		dev_err(bridge->parent,
> +			"Configuring interrupts not supported\n");
>  		return;
>  	}
>
> @@ -1415,17 +1426,18 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		return -EINVAL;
>  	}
>
>  	if ((level < 1) || (level > 7)) {
> -		printk(KERN_WARNING "Invalid interrupt level\n");
> +		pr_warn("Invalid interrupt level\n");
>  		return -EINVAL;
>  	}
>
>  	if (!bridge->irq_generate) {
> -		printk(KERN_WARNING "Interrupt generation not supported\n");
> +		dev_warn(bridge->parent,
> +			 "Interrupt generation not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1452,14 +1464,15 @@ struct vme_resource *vme_lm_request(struct vme_dev *vdev)
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		goto err_bus;
>  	}
>
>  	/* Loop through LM resources */
>  	list_for_each_entry(lm, &bridge->lm_resources, list) {
>  		if (!lm) {
> -			printk(KERN_ERR "Registered NULL Location Monitor resource\n");
> +			dev_err(bridge->parent,
> +				"Registered NULL Location Monitor resource\n");
>  			continue;
>  		}
>
> @@ -1514,7 +1527,7 @@ int vme_lm_count(struct vme_resource *resource)
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return -EINVAL;
>  	}
>
> @@ -1545,14 +1558,14 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return -EINVAL;
>  	}
>
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>
>  	if (!bridge->lm_set) {
> -		printk(KERN_ERR "vme_lm_set not supported\n");
> +		dev_err(bridge->parent, "vme_lm_set not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1581,14 +1594,14 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return -EINVAL;
>  	}
>
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>
>  	if (!bridge->lm_get) {
> -		printk(KERN_ERR "vme_lm_get not supported\n");
> +		dev_err(bridge->parent, "vme_lm_get not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1618,14 +1631,14 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return -EINVAL;
>  	}
>
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>
>  	if (!bridge->lm_attach) {
> -		printk(KERN_ERR "vme_lm_attach not supported\n");
> +		dev_err(bridge->parent, "vme_lm_attach not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1651,14 +1664,14 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return -EINVAL;
>  	}
>
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>
>  	if (!bridge->lm_detach) {
> -		printk(KERN_ERR "vme_lm_detach not supported\n");
> +		dev_err(bridge->parent, "vme_lm_detach not supported\n");
>  		return -EINVAL;
>  	}
>
> @@ -1683,7 +1696,7 @@ void vme_lm_free(struct vme_resource *resource)
>  	struct vme_lm_resource *lm;
>
>  	if (resource->type != VME_LM) {
> -		printk(KERN_ERR "Not a Location Monitor resource\n");
> +		pr_err("Not a Location Monitor resource\n");
>  		return;
>  	}
>
> @@ -1720,12 +1733,12 @@ int vme_slot_num(struct vme_dev *vdev)
>
>  	bridge = vdev->bridge;
>  	if (!bridge) {
> -		printk(KERN_ERR "Can't find VME bus\n");
> +		pr_err("Can't find VME bus\n");
>  		return -EINVAL;
>  	}
>
>  	if (!bridge->slot_get) {
> -		printk(KERN_WARNING "vme_slot_num not supported\n");
> +		dev_warn(bridge->parent, "vme_slot_num not supported\n");
>  		return -EINVAL;
>  	}
>
> --
> 2.42.0
>
>
>
