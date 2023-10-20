Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACBC7D064D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346847AbjJTBzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbjJTBzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:33 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB2111B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:30 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-581e5a9413bso194489eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766930; x=1698371730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK4VRLVP527Wk0wpmDeExKtEeRPAXb3C2H0so+dEMnk=;
        b=f/hFK7g4tbc2/Uzrs216wzIoZ+3fvQTV32NmLfZOltOT14+roOosRJKKIPKDAyEjpd
         P4VFV03f/9p15YD5cg8dQL6nZy+z3CCsf/jTXapYAPQ0F1xMWACikAcuxV55jEFwUfqQ
         Ey77MOhBy7jC3OJjFK1x6BOsX/y5n0ZGANKxG7GnC7PUUJq9IQkUKmlu+kPC6WaH60QT
         yA4Hl/GMCU3WAW4mC3OrmoDYSyBCt7lbfPQz7uh7ltx3bERQyTxiPeS2X4ll4SfrGmGS
         iZoJU9vkztfLcOA6Yl8eiCuJIxc4sSd4AdoL4go7pL4JgpzHNubnaIs490TuzxtwbLyC
         PbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766930; x=1698371730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gK4VRLVP527Wk0wpmDeExKtEeRPAXb3C2H0so+dEMnk=;
        b=Rpu37zowZ1hXhnnajSgPd+KhwQIzmFFw6x754Qr4aGtE4eVxePqaPhwgh4P4FC/5fq
         iVcROesabQDTDFagtFSm8Mqfo4pI3PpIDZXcff4BmX+f4DbPEwffY81DT3XbhDLDASB+
         42jwfFwguHedMnGY6fBHNkjxuCVJa28lFMbNxCcswbacofAnSJQLU3tObNcaLZdKtRyM
         r3lyODmwNkcmrQHK/8N7/eIZsUhf9z45CGybz6WoMxB/k1BtLoRlclJ/BqSA8hEf6SbT
         Gt/cU59/+y3so4sQ/eJUHY+5Thdg0xor5XHLJ+bw5Rb6YoUUHK96hnqV/tT3pQfvKZY2
         EEyA==
X-Gm-Message-State: AOJu0YwaEgaI/35WZKqGQjgCG9ikmpVzmx4AO8QkcSVm6HLsQI7evcBV
        SvE/PeaS7ESQ3AEsfbv7wbk=
X-Google-Smtp-Source: AGHT+IG7sdgVeroBy837E0BU6P5gj4+ZwkTbZEhu2S2KRHiDElKNoOWFF2k1XnovOi695QYHCXfHLA==
X-Received: by 2002:a05:6358:9147:b0:166:e779:7ce7 with SMTP id r7-20020a056358914700b00166e7797ce7mr547975rwr.32.1697766929705;
        Thu, 19 Oct 2023 18:55:29 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id k17-20020aa79d11000000b006933866f49dsm431389pfp.19.2023.10.19.18.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:29 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>,
        Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v3 1/5] staging: vme_user: Replace printk() with dev_*()
Date:   Thu, 19 Oct 2023 18:55:19 -0700
Message-ID: <a36a0b839f9c21efe1f2df6f9272ae882fd04fb8.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697763267.git.soumya.negi97@gmail.com>
References: <cover.1697763267.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vme.c uses printk() to log messages. To improve and standardize message
formatting, use logging mechanisms dev_err()/dev_warn() instead. Retain
the printk log levels of the messages during replacement.

Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
Acked-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/staging/vme_user/vme.c | 175 +++++++++++++++++++--------------
 1 file changed, 99 insertions(+), 76 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 6519a7c994a0..25f3cac641ed 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -100,8 +100,9 @@ void *vme_alloc_consistent(struct vme_resource *resource, size_t size,
 	}
 
 	if (!bridge->alloc_consistent) {
-		printk(KERN_ERR "alloc_consistent not supported by bridge %s\n",
-		       bridge->name);
+		dev_err(bridge->parent,
+			"alloc_consistent not supported by bridge %s\n",
+			bridge->name);
 		return NULL;
 	}
 
@@ -140,8 +141,9 @@ void vme_free_consistent(struct vme_resource *resource, size_t size,
 	}
 
 	if (!bridge->free_consistent) {
-		printk(KERN_ERR "free_consistent not supported by bridge %s\n",
-		       bridge->name);
+		dev_err(bridge->parent,
+			"free_consistent not supported by bridge %s\n",
+			bridge->name);
 		return;
 	}
 
@@ -161,6 +163,7 @@ EXPORT_SYMBOL(vme_free_consistent);
  */
 size_t vme_get_size(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	int enabled, retval;
 	unsigned long long base, size;
 	dma_addr_t buf_base;
@@ -184,7 +187,7 @@ size_t vme_get_size(struct vme_resource *resource)
 	case VME_DMA:
 		return 0;
 	default:
-		printk(KERN_ERR "Unknown resource type\n");
+		dev_err(bridge->parent, "Unknown resource type\n");
 		return 0;
 	}
 }
@@ -288,14 +291,15 @@ struct vme_resource *vme_slave_request(struct vme_dev *vdev, u32 address,
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		goto err_bus;
 	}
 
 	/* Loop through slave resources */
 	list_for_each_entry(slave_image, &bridge->slave_resources, list) {
 		if (!slave_image) {
-			printk(KERN_ERR "Registered NULL Slave resource\n");
+			dev_err(bridge->parent,
+				"Registered NULL Slave resource\n");
 			continue;
 		}
 
@@ -362,20 +366,20 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 	int retval;
 
 	if (resource->type != VME_SLAVE) {
-		printk(KERN_ERR "Not a slave resource\n");
+		dev_err(bridge->parent, "Not a slave resource\n");
 		return -EINVAL;
 	}
 
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_set) {
-		printk(KERN_ERR "Function not supported\n");
+		dev_err(bridge->parent, "Function not supported\n");
 		return -ENOSYS;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
 	      ((image->cycle_attr & cycle) == cycle))) {
-		printk(KERN_ERR "Invalid attributes\n");
+		dev_err(bridge->parent, "Invalid attributes\n");
 		return -EINVAL;
 	}
 
@@ -411,14 +415,14 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	struct vme_slave_resource *image;
 
 	if (resource->type != VME_SLAVE) {
-		printk(KERN_ERR "Not a slave resource\n");
+		dev_err(bridge->parent, "Not a slave resource\n");
 		return -EINVAL;
 	}
 
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		printk(KERN_ERR "vme_slave_get not supported\n");
+		dev_err(bridge->parent, "vme_slave_get not supported\n");
 		return -EINVAL;
 	}
 
@@ -435,24 +439,25 @@ EXPORT_SYMBOL(vme_slave_get);
  */
 void vme_slave_free(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_slave_resource *slave_image;
 
 	if (resource->type != VME_SLAVE) {
-		printk(KERN_ERR "Not a slave resource\n");
+		dev_err(bridge->parent, "Not a slave resource\n");
 		return;
 	}
 
 	slave_image = list_entry(resource->entry, struct vme_slave_resource,
 				 list);
 	if (!slave_image) {
-		printk(KERN_ERR "Can't find slave resource\n");
+		dev_err(bridge->parent, "Can't find slave resource\n");
 		return;
 	}
 
 	/* Unlock image */
 	mutex_lock(&slave_image->mtx);
 	if (slave_image->locked == 0)
-		printk(KERN_ERR "Image is already free\n");
+		dev_err(bridge->parent, "Image is already free\n");
 
 	slave_image->locked = 0;
 	mutex_unlock(&slave_image->mtx);
@@ -484,14 +489,15 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		goto err_bus;
 	}
 
 	/* Loop through master resources */
 	list_for_each_entry(master_image, &bridge->master_resources, list) {
 		if (!master_image) {
-			printk(KERN_WARNING "Registered NULL master resource\n");
+			dev_warn(bridge->parent,
+				 "Registered NULL master resource\n");
 			continue;
 		}
 
@@ -511,7 +517,7 @@ struct vme_resource *vme_master_request(struct vme_dev *vdev, u32 address,
 
 	/* Check to see if we found a resource */
 	if (!allocated_image) {
-		printk(KERN_ERR "Can't find a suitable resource\n");
+		dev_err(&vdev->dev, "Can't find a suitable resource\n");
 		goto err_image;
 	}
 
@@ -561,21 +567,21 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	int retval;
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		printk(KERN_WARNING "vme_master_set not supported\n");
+		dev_warn(bridge->parent, "vme_master_set not supported\n");
 		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
 	      ((image->cycle_attr & cycle) == cycle) &&
 	      ((image->width_attr & dwidth) == dwidth))) {
-		printk(KERN_WARNING "Invalid attributes\n");
+		dev_warn(bridge->parent, "Invalid attributes\n");
 		return -EINVAL;
 	}
 
@@ -611,14 +617,14 @@ int vme_master_get(struct vme_resource *resource, int *enabled,
 	struct vme_master_resource *image;
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_get) {
-		printk(KERN_WARNING "%s not supported\n", __func__);
+		dev_warn(bridge->parent, "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -650,12 +656,13 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
 	size_t length;
 
 	if (!bridge->master_read) {
-		printk(KERN_WARNING "Reading from resource not supported\n");
+		dev_warn(bridge->parent,
+			 "Reading from resource not supported\n");
 		return -EINVAL;
 	}
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
@@ -664,7 +671,7 @@ ssize_t vme_master_read(struct vme_resource *resource, void *buf, size_t count,
 	length = vme_get_size(resource);
 
 	if (offset > length) {
-		printk(KERN_WARNING "Invalid Offset\n");
+		dev_warn(bridge->parent, "Invalid Offset\n");
 		return -EFAULT;
 	}
 
@@ -698,12 +705,12 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
 	size_t length;
 
 	if (!bridge->master_write) {
-		printk(KERN_WARNING "Writing to resource not supported\n");
+		dev_warn(bridge->parent, "Writing to resource not supported\n");
 		return -EINVAL;
 	}
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
@@ -712,7 +719,7 @@ ssize_t vme_master_write(struct vme_resource *resource, void *buf,
 	length = vme_get_size(resource);
 
 	if (offset > length) {
-		printk(KERN_WARNING "Invalid Offset\n");
+		dev_warn(bridge->parent, "Invalid Offset\n");
 		return -EFAULT;
 	}
 
@@ -749,12 +756,12 @@ unsigned int vme_master_rmw(struct vme_resource *resource, unsigned int mask,
 	struct vme_master_resource *image;
 
 	if (!bridge->master_rmw) {
-		printk(KERN_WARNING "Writing to resource not supported\n");
+		dev_warn(bridge->parent, "Writing to resource not supported\n");
 		return -EINVAL;
 	}
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
@@ -777,12 +784,13 @@ EXPORT_SYMBOL(vme_master_rmw);
  */
 int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_master_resource *image;
 	phys_addr_t phys_addr;
 	unsigned long vma_size;
 
 	if (resource->type != VME_MASTER) {
-		pr_err("Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return -EINVAL;
 	}
 
@@ -791,7 +799,7 @@ int vme_master_mmap(struct vme_resource *resource, struct vm_area_struct *vma)
 	vma_size = vma->vm_end - vma->vm_start;
 
 	if (phys_addr + vma_size > image->bus_resource.end + 1) {
-		pr_err("Map size cannot exceed the window size\n");
+		dev_err(bridge->parent, "Map size cannot exceed the window size\n");
 		return -EFAULT;
 	}
 
@@ -809,24 +817,25 @@ EXPORT_SYMBOL(vme_master_mmap);
  */
 void vme_master_free(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_master_resource *master_image;
 
 	if (resource->type != VME_MASTER) {
-		printk(KERN_ERR "Not a master resource\n");
+		dev_err(bridge->parent, "Not a master resource\n");
 		return;
 	}
 
 	master_image = list_entry(resource->entry, struct vme_master_resource,
 				  list);
 	if (!master_image) {
-		printk(KERN_ERR "Can't find master resource\n");
+		dev_err(bridge->parent, "Can't find master resource\n");
 		return;
 	}
 
 	/* Unlock image */
 	spin_lock(&master_image->lock);
 	if (master_image->locked == 0)
-		printk(KERN_ERR "Image is already free\n");
+		dev_err(bridge->parent, "Image is already free\n");
 
 	master_image->locked = 0;
 	spin_unlock(&master_image->lock);
@@ -854,18 +863,19 @@ struct vme_resource *vme_dma_request(struct vme_dev *vdev, u32 route)
 	struct vme_resource *resource = NULL;
 
 	/* XXX Not checking resource attributes */
-	printk(KERN_ERR "No VME resource Attribute tests done\n");
+	dev_err(&vdev->dev, "No VME resource Attribute tests done\n");
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		goto err_bus;
 	}
 
 	/* Loop through DMA resources */
 	list_for_each_entry(dma_ctrlr, &bridge->dma_resources, list) {
 		if (!dma_ctrlr) {
-			printk(KERN_ERR "Registered NULL DMA resource\n");
+			dev_err(bridge->parent,
+				"Registered NULL DMA resource\n");
 			continue;
 		}
 
@@ -917,10 +927,11 @@ EXPORT_SYMBOL(vme_dma_request);
  */
 struct vme_dma_list *vme_new_dma_list(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_dma_list *dma_list;
 
 	if (resource->type != VME_DMA) {
-		printk(KERN_ERR "Not a DMA resource\n");
+		dev_err(bridge->parent, "Not a DMA resource\n");
 		return NULL;
 	}
 
@@ -1098,12 +1109,13 @@ int vme_dma_list_add(struct vme_dma_list *list, struct vme_dma_attr *src,
 	int retval;
 
 	if (!bridge->dma_list_add) {
-		printk(KERN_WARNING "Link List DMA generation not supported\n");
+		dev_warn(bridge->parent,
+			 "Link List DMA generation not supported\n");
 		return -EINVAL;
 	}
 
 	if (!mutex_trylock(&list->mtx)) {
-		printk(KERN_ERR "Link List already submitted\n");
+		dev_err(bridge->parent, "Link List already submitted\n");
 		return -EINVAL;
 	}
 
@@ -1131,7 +1143,8 @@ int vme_dma_list_exec(struct vme_dma_list *list)
 	int retval;
 
 	if (!bridge->dma_list_exec) {
-		printk(KERN_ERR "Link List DMA execution not supported\n");
+		dev_err(bridge->parent,
+			"Link List DMA execution not supported\n");
 		return -EINVAL;
 	}
 
@@ -1160,12 +1173,13 @@ int vme_dma_list_free(struct vme_dma_list *list)
 	int retval;
 
 	if (!bridge->dma_list_empty) {
-		printk(KERN_WARNING "Emptying of Link Lists not supported\n");
+		dev_warn(bridge->parent,
+			 "Emptying of Link Lists not supported\n");
 		return -EINVAL;
 	}
 
 	if (!mutex_trylock(&list->mtx)) {
-		printk(KERN_ERR "Link List in use\n");
+		dev_err(bridge->parent, "Link List in use\n");
 		return -EBUSY;
 	}
 
@@ -1175,7 +1189,7 @@ int vme_dma_list_free(struct vme_dma_list *list)
 	 */
 	retval = bridge->dma_list_empty(list);
 	if (retval) {
-		printk(KERN_ERR "Unable to empty link-list entries\n");
+		dev_err(bridge->parent, "Unable to empty link-list entries\n");
 		mutex_unlock(&list->mtx);
 		return retval;
 	}
@@ -1197,22 +1211,24 @@ EXPORT_SYMBOL(vme_dma_list_free);
  */
 int vme_dma_free(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_dma_resource *ctrlr;
 
 	if (resource->type != VME_DMA) {
-		printk(KERN_ERR "Not a DMA resource\n");
+		dev_err(bridge->parent, "Not a DMA resource\n");
 		return -EINVAL;
 	}
 
 	ctrlr = list_entry(resource->entry, struct vme_dma_resource, list);
 
 	if (!mutex_trylock(&ctrlr->mtx)) {
-		printk(KERN_ERR "Resource busy, can't free\n");
+		dev_err(bridge->parent, "Resource busy, can't free\n");
 		return -EBUSY;
 	}
 
 	if (!(list_empty(&ctrlr->pending) && list_empty(&ctrlr->running))) {
-		printk(KERN_WARNING "Resource still processing transfers\n");
+		dev_warn(bridge->parent,
+			 "Resource still processing transfers\n");
 		mutex_unlock(&ctrlr->mtx);
 		return -EBUSY;
 	}
@@ -1290,8 +1306,9 @@ void vme_irq_handler(struct vme_bridge *bridge, int level, int statid)
 	if (call)
 		call(level, statid, priv_data);
 	else
-		printk(KERN_WARNING "Spurious VME interrupt, level:%x, vector:%x\n",
-		       level, statid);
+		dev_warn(bridge->parent,
+			 "Spurious VME interrupt, level:%x, vector:%x\n", level,
+			 statid);
 }
 EXPORT_SYMBOL(vme_irq_handler);
 
@@ -1319,17 +1336,18 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		return -EINVAL;
 	}
 
 	if ((level < 1) || (level > 7)) {
-		printk(KERN_ERR "Invalid interrupt level\n");
+		dev_err(bridge->parent, "Invalid interrupt level\n");
 		return -EINVAL;
 	}
 
 	if (!bridge->irq_set) {
-		printk(KERN_ERR "Configuring interrupts not supported\n");
+		dev_err(bridge->parent,
+			"Configuring interrupts not supported\n");
 		return -EINVAL;
 	}
 
@@ -1337,7 +1355,7 @@ int vme_irq_request(struct vme_dev *vdev, int level, int statid,
 
 	if (bridge->irq[level - 1].callback[statid].func) {
 		mutex_unlock(&bridge->irq_mtx);
-		printk(KERN_WARNING "VME Interrupt already taken\n");
+		dev_warn(bridge->parent, "VME Interrupt already taken\n");
 		return -EBUSY;
 	}
 
@@ -1368,17 +1386,18 @@ void vme_irq_free(struct vme_dev *vdev, int level, int statid)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		return;
 	}
 
 	if ((level < 1) || (level > 7)) {
-		printk(KERN_ERR "Invalid interrupt level\n");
+		dev_err(bridge->parent, "Invalid interrupt level\n");
 		return;
 	}
 
 	if (!bridge->irq_set) {
-		printk(KERN_ERR "Configuring interrupts not supported\n");
+		dev_err(bridge->parent,
+			"Configuring interrupts not supported\n");
 		return;
 	}
 
@@ -1415,17 +1434,18 @@ int vme_irq_generate(struct vme_dev *vdev, int level, int statid)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		return -EINVAL;
 	}
 
 	if ((level < 1) || (level > 7)) {
-		printk(KERN_WARNING "Invalid interrupt level\n");
+		dev_warn(bridge->parent, "Invalid interrupt level\n");
 		return -EINVAL;
 	}
 
 	if (!bridge->irq_generate) {
-		printk(KERN_WARNING "Interrupt generation not supported\n");
+		dev_warn(bridge->parent,
+			 "Interrupt generation not supported\n");
 		return -EINVAL;
 	}
 
@@ -1452,14 +1472,15 @@ struct vme_resource *vme_lm_request(struct vme_dev *vdev)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		goto err_bus;
 	}
 
 	/* Loop through LM resources */
 	list_for_each_entry(lm, &bridge->lm_resources, list) {
 		if (!lm) {
-			printk(KERN_ERR "Registered NULL Location Monitor resource\n");
+			dev_err(bridge->parent,
+				"Registered NULL Location Monitor resource\n");
 			continue;
 		}
 
@@ -1511,10 +1532,11 @@ EXPORT_SYMBOL(vme_lm_request);
  */
 int vme_lm_count(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return -EINVAL;
 	}
 
@@ -1545,14 +1567,14 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return -EINVAL;
 	}
 
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		printk(KERN_ERR "vme_lm_set not supported\n");
+		dev_err(bridge->parent, "vme_lm_set not supported\n");
 		return -EINVAL;
 	}
 
@@ -1581,14 +1603,14 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return -EINVAL;
 	}
 
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		printk(KERN_ERR "vme_lm_get not supported\n");
+		dev_err(bridge->parent, "vme_lm_get not supported\n");
 		return -EINVAL;
 	}
 
@@ -1618,14 +1640,14 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return -EINVAL;
 	}
 
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		printk(KERN_ERR "vme_lm_attach not supported\n");
+		dev_err(bridge->parent, "vme_lm_attach not supported\n");
 		return -EINVAL;
 	}
 
@@ -1651,14 +1673,14 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return -EINVAL;
 	}
 
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		printk(KERN_ERR "vme_lm_detach not supported\n");
+		dev_err(bridge->parent, "vme_lm_detach not supported\n");
 		return -EINVAL;
 	}
 
@@ -1680,10 +1702,11 @@ EXPORT_SYMBOL(vme_lm_detach);
  */
 void vme_lm_free(struct vme_resource *resource)
 {
+	struct vme_bridge *bridge = find_bridge(resource);
 	struct vme_lm_resource *lm;
 
 	if (resource->type != VME_LM) {
-		printk(KERN_ERR "Not a Location Monitor resource\n");
+		dev_err(bridge->parent, "Not a Location Monitor resource\n");
 		return;
 	}
 
@@ -1720,12 +1743,12 @@ int vme_slot_num(struct vme_dev *vdev)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		printk(KERN_ERR "Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		return -EINVAL;
 	}
 
 	if (!bridge->slot_get) {
-		printk(KERN_WARNING "vme_slot_num not supported\n");
+		dev_warn(bridge->parent, "vme_slot_num not supported\n");
 		return -EINVAL;
 	}
 
@@ -1748,7 +1771,7 @@ int vme_bus_num(struct vme_dev *vdev)
 
 	bridge = vdev->bridge;
 	if (!bridge) {
-		pr_err("Can't find VME bus\n");
+		dev_err(&vdev->dev, "Can't find VME bus\n");
 		return -EINVAL;
 	}
 
-- 
2.42.0

