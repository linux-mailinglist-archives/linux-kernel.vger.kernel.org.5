Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D167F1FE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjKTWAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjKTWA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:00:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EC9E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700517619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ndwg8yWgO7u2AWRVzzWdZxowrMw7/s/C0lAlAam8dBc=;
        b=GB1G6wtb6ZItvbaIlDMaJVJy8ByymrIQtEBkGjbUs9oz7SgfkjKw0Vlew7NwrGlrZPJfuO
        IHqG6degxDz961OboMpskyVdjCEQcCN7yfCYXdbOnxkqZw8cJQ1AItuyyqAK5relaI3nDb
        2zVwIa28qG87TKJIj4zlH4FS4L4iexo=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-39_In3q7N4Skqt8NdPZ_fg-1; Mon, 20 Nov 2023 17:00:16 -0500
X-MC-Unique: 39_In3q7N4Skqt8NdPZ_fg-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-daf165b2a14so954137276.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700517616; x=1701122416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndwg8yWgO7u2AWRVzzWdZxowrMw7/s/C0lAlAam8dBc=;
        b=agBglMT84rG2Qu644ES8dMz7GyPBGEG7azUcPlGOn8Jm9tfhqdSGTYGnLd2USWUdhm
         dB/n78PO2LmkgWZFXghobQOrWgTbQ/AgcS/FrQ7x3JdeDDRW6mN2BhkDuQCKwFKOyU+Z
         lswhverBBZr9ObxvVvrAxeVXFwLrzgrDPW/0d/WPbR6wMtWM6QocLfR/Df42VUxoezvJ
         4FLk75hgJboq6rUxPHOacp2L8mMt6+lRCrPz8WT3fhlCcvE+MsAQUPccBSkQFMKTt34J
         LpZaDsycoWujtKvN7w+fU1dGa3VygrD6PIUAaHCTM3s70U5KN4sbqmViMup0AZhJYtDk
         Qf4w==
X-Gm-Message-State: AOJu0YwBLP/e/bDlIzCjwCJjwd3NgYFmMjXEWDcmGx/A7TOqAJrskJxf
        ZtARJkklYduvOhRJc4Uk2Dx/H/mmPQ0nta/R9xImHFTI+q0KCLpMNtxIl4MXuP+Xlw24LAxk8Yy
        bDm7AgejZE4RTdHHoSkCXBcyD
X-Received: by 2002:a25:6c83:0:b0:daf:f963:6c4 with SMTP id h125-20020a256c83000000b00daff96306c4mr4919298ybc.2.1700517615873;
        Mon, 20 Nov 2023 14:00:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0vWNj+eR1Wv/K+VOG8kWN8G67fBWam7JvcGLJqk0PG33fUfN5Ukx03xmSFA5ck07GyFZpUg==
X-Received: by 2002:a25:6c83:0:b0:daf:f963:6c4 with SMTP id h125-20020a256c83000000b00daff96306c4mr4919198ybc.2.1700517614976;
        Mon, 20 Nov 2023 14:00:14 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32dd:2700:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id 3-20020ad45ba3000000b00677fb918337sm2762398qvq.53.2023.11.20.14.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:00:14 -0800 (PST)
From:   Philipp Stanner <pstanner@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Eric Auger <eric.auger@redhat.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        NeilBrown <neilb@suse.de>, Philipp Stanner <pstanner@redhat.com>,
        John Sanpe <sanpeqf@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        David Gow <davidgow@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "wuqiang.matt" <wuqiang.matt@bytedance.com>,
        Jason Baron <jbaron@akamai.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Danilo Krummrich <dakr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 3/4] pci: move devres code from pci.c to devres.c
Date:   Mon, 20 Nov 2023 22:59:45 +0100
Message-ID: <20231120215945.52027-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120215945.52027-2-pstanner@redhat.com>
References: <20231120215945.52027-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file pci.c is very large and contains a number of devres-functions.
These functions should now reside in devres.c

There are a few callers left in pci.c that do devres operations. These
should be ported in the future. Corresponding TODOs are added by this
commit.

The reason they are not moved right now in this commit is that pci's
devres currently implements a sort of "hybrid-mode":
pci_request_region(), for instance, does not have a corresponding pcim_
equivalent, yet. Instead, the function can be made managed by previously
calling pcim_enable_device() (instead of pci_enable_device()). This
makes it unreasonable to move pci_request_region() to devres.c
Moving the functions would require changes to pci's API and is,
therefore, left for future work.

Move as much devres-specific code from pci.c to devres.c as possible.

Suggested-by: Danilo Krummrich <dakr@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/pci/devres.c | 243 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c    | 249 -------------------------------------------
 drivers/pci/pci.h    |  24 +++++
 3 files changed, 267 insertions(+), 249 deletions(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index a3fd0d65cef1..55f76a2c3748 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
 #include <linux/pci.h>
 #include "pci.h"
 
@@ -11,6 +12,248 @@ struct pcim_iomap_devres {
 	void __iomem *table[PCIM_IOMAP_MAX];
 };
 
+
+static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
+{
+	struct resource **res = ptr;
+
+	pci_unmap_iospace(*res);
+}
+
+/**
+ * devm_pci_remap_iospace - Managed pci_remap_iospace()
+ * @dev: Generic device to remap IO address for
+ * @res: Resource describing the I/O space
+ * @phys_addr: physical address of range to be mapped
+ *
+ * Managed pci_remap_iospace().  Map is automatically unmapped on driver
+ * detach.
+ */
+int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
+			   phys_addr_t phys_addr)
+{
+	const struct resource **ptr;
+	int error;
+
+	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	error = pci_remap_iospace(res, phys_addr);
+	if (error) {
+		devres_free(ptr);
+	} else	{
+		*ptr = res;
+		devres_add(dev, ptr);
+	}
+
+	return error;
+}
+EXPORT_SYMBOL(devm_pci_remap_iospace);
+
+/**
+ * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
+ * @dev: Generic device to remap IO address for
+ * @offset: Resource address to map
+ * @size: Size of map
+ *
+ * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
+ * detach.
+ */
+void __iomem *devm_pci_remap_cfgspace(struct device *dev,
+				      resource_size_t offset,
+				      resource_size_t size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = pci_remap_cfgspace(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfgspace);
+
+/**
+ * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
+ * @dev: generic device to handle the resource for
+ * @res: configuration space resource to be handled
+ *
+ * Checks that a resource is a valid memory region, requests the memory
+ * region and ioremaps with pci_remap_cfgspace() API that ensures the
+ * proper PCI configuration space memory attributes are guaranteed.
+ *
+ * All operations are managed and will be undone on driver detach.
+ *
+ * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
+ * on failure. Usage example::
+ *
+ *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+ *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
+ *	if (IS_ERR(base))
+ *		return PTR_ERR(base);
+ */
+void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
+					  struct resource *res)
+{
+	resource_size_t size;
+	const char *name;
+	void __iomem *dest_ptr;
+
+	BUG_ON(!dev);
+
+	if (!res || resource_type(res) != IORESOURCE_MEM) {
+		dev_err(dev, "invalid resource\n");
+		return IOMEM_ERR_PTR(-EINVAL);
+	}
+
+	size = resource_size(res);
+
+	if (res->name)
+		name = devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
+				      res->name);
+	else
+		name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
+	if (!name)
+		return IOMEM_ERR_PTR(-ENOMEM);
+
+	if (!devm_request_mem_region(dev, res->start, size, name)) {
+		dev_err(dev, "can't request region for resource %pR\n", res);
+		return IOMEM_ERR_PTR(-EBUSY);
+	}
+
+	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
+	if (!dest_ptr) {
+		dev_err(dev, "ioremap failed for resource %pR\n", res);
+		devm_release_mem_region(dev, res->start, size);
+		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
+	}
+
+	return dest_ptr;
+}
+EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
+
+/**
+ * pcim_set_mwi - a device-managed pci_set_mwi()
+ * @dev: the PCI device for which MWI is enabled
+ *
+ * Managed pci_set_mwi().
+ *
+ * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
+ */
+int pcim_set_mwi(struct pci_dev *dev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(dev);
+	if (!dr)
+		return -ENOMEM;
+
+	dr->mwi = 1;
+	return pci_set_mwi(dev);
+}
+EXPORT_SYMBOL(pcim_set_mwi);
+
+
+static void pcim_release(struct device *gendev, void *res)
+{
+	struct pci_dev *dev = to_pci_dev(gendev);
+	struct pci_devres *this = res;
+	int i;
+
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
+		if (this->region_mask & (1 << i))
+			pci_release_region(dev, i);
+
+	if (this->mwi)
+		pci_clear_mwi(dev);
+
+	if (this->restore_intx)
+		pci_intx(dev, this->orig_intx);
+
+	if (this->enabled && !this->pinned)
+		pci_disable_device(dev);
+}
+
+/*
+ * TODO:
+ * Once the last four callers in pci.c are ported, this function here needs to
+ * be made static again.
+ */
+struct pci_devres *find_pci_dr(struct pci_dev *pdev)
+{
+	if (pci_is_managed(pdev))
+		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	return NULL;
+}
+EXPORT_SYMBOL(find_pci_dr); // TODO do we need this?
+
+static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
+{
+	struct pci_devres *dr, *new_dr;
+
+	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
+	if (dr)
+		return dr;
+
+	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
+	if (!new_dr)
+		return NULL;
+	return devres_get(&pdev->dev, new_dr, NULL, NULL);
+}
+
+/**
+ * pcim_enable_device - Managed pci_enable_device()
+ * @pdev: PCI device to be initialized
+ *
+ * Managed pci_enable_device().
+ */
+int pcim_enable_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+	int rc;
+
+	dr = get_pci_dr(pdev);
+	if (unlikely(!dr))
+		return -ENOMEM;
+	if (dr->enabled)
+		return 0;
+
+	rc = pci_enable_device(pdev);
+	if (!rc) {
+		pdev->is_managed = 1;
+		dr->enabled = 1;
+	}
+	return rc;
+}
+EXPORT_SYMBOL(pcim_enable_device);
+
+/**
+ * pcim_pin_device - Pin managed PCI device
+ * @pdev: PCI device to pin
+ *
+ * Pin managed PCI device @pdev.  Pinned device won't be disabled on
+ * driver detach.  @pdev must have been enabled with
+ * pcim_enable_device().
+ */
+void pcim_pin_device(struct pci_dev *pdev)
+{
+	struct pci_devres *dr;
+
+	dr = find_pci_dr(pdev);
+	WARN_ON(!dr || !dr->enabled);
+	if (dr)
+		dr->pinned = 1;
+}
+EXPORT_SYMBOL(pcim_pin_device);
+
 static void pcim_iomap_release(struct device *gendev, void *res)
 {
 	struct pci_dev *dev = to_pci_dev(gendev);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 55bc3576a985..742b0a6545b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2088,107 +2088,6 @@ int pci_enable_device(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_enable_device);
 
-/*
- * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
- * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
- * there's no need to track it separately.  pci_devres is initialized
- * when a device is enabled using managed PCI device enable interface.
- */
-struct pci_devres {
-	unsigned int enabled:1;
-	unsigned int pinned:1;
-	unsigned int orig_intx:1;
-	unsigned int restore_intx:1;
-	unsigned int mwi:1;
-	u32 region_mask;
-};
-
-static void pcim_release(struct device *gendev, void *res)
-{
-	struct pci_dev *dev = to_pci_dev(gendev);
-	struct pci_devres *this = res;
-	int i;
-
-	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++)
-		if (this->region_mask & (1 << i))
-			pci_release_region(dev, i);
-
-	if (this->mwi)
-		pci_clear_mwi(dev);
-
-	if (this->restore_intx)
-		pci_intx(dev, this->orig_intx);
-
-	if (this->enabled && !this->pinned)
-		pci_disable_device(dev);
-}
-
-static struct pci_devres *get_pci_dr(struct pci_dev *pdev)
-{
-	struct pci_devres *dr, *new_dr;
-
-	dr = devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	if (dr)
-		return dr;
-
-	new_dr = devres_alloc(pcim_release, sizeof(*new_dr), GFP_KERNEL);
-	if (!new_dr)
-		return NULL;
-	return devres_get(&pdev->dev, new_dr, NULL, NULL);
-}
-
-static struct pci_devres *find_pci_dr(struct pci_dev *pdev)
-{
-	if (pci_is_managed(pdev))
-		return devres_find(&pdev->dev, pcim_release, NULL, NULL);
-	return NULL;
-}
-
-/**
- * pcim_enable_device - Managed pci_enable_device()
- * @pdev: PCI device to be initialized
- *
- * Managed pci_enable_device().
- */
-int pcim_enable_device(struct pci_dev *pdev)
-{
-	struct pci_devres *dr;
-	int rc;
-
-	dr = get_pci_dr(pdev);
-	if (unlikely(!dr))
-		return -ENOMEM;
-	if (dr->enabled)
-		return 0;
-
-	rc = pci_enable_device(pdev);
-	if (!rc) {
-		pdev->is_managed = 1;
-		dr->enabled = 1;
-	}
-	return rc;
-}
-EXPORT_SYMBOL(pcim_enable_device);
-
-/**
- * pcim_pin_device - Pin managed PCI device
- * @pdev: PCI device to pin
- *
- * Pin managed PCI device @pdev.  Pinned device won't be disabled on
- * driver detach.  @pdev must have been enabled with
- * pcim_enable_device().
- */
-void pcim_pin_device(struct pci_dev *pdev)
-{
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(pdev);
-	WARN_ON(!dr || !dr->enabled);
-	if (dr)
-		dr->pinned = 1;
-}
-EXPORT_SYMBOL(pcim_pin_device);
-
 /*
  * pcibios_device_add - provide arch specific hooks when adding device dev
  * @dev: the PCI device being added
@@ -4281,133 +4180,6 @@ void pci_unmap_iospace(struct resource *res)
 }
 EXPORT_SYMBOL(pci_unmap_iospace);
 
-static void devm_pci_unmap_iospace(struct device *dev, void *ptr)
-{
-	struct resource **res = ptr;
-
-	pci_unmap_iospace(*res);
-}
-
-/**
- * devm_pci_remap_iospace - Managed pci_remap_iospace()
- * @dev: Generic device to remap IO address for
- * @res: Resource describing the I/O space
- * @phys_addr: physical address of range to be mapped
- *
- * Managed pci_remap_iospace().  Map is automatically unmapped on driver
- * detach.
- */
-int devm_pci_remap_iospace(struct device *dev, const struct resource *res,
-			   phys_addr_t phys_addr)
-{
-	const struct resource **ptr;
-	int error;
-
-	ptr = devres_alloc(devm_pci_unmap_iospace, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	error = pci_remap_iospace(res, phys_addr);
-	if (error) {
-		devres_free(ptr);
-	} else	{
-		*ptr = res;
-		devres_add(dev, ptr);
-	}
-
-	return error;
-}
-EXPORT_SYMBOL(devm_pci_remap_iospace);
-
-/**
- * devm_pci_remap_cfgspace - Managed pci_remap_cfgspace()
- * @dev: Generic device to remap IO address for
- * @offset: Resource address to map
- * @size: Size of map
- *
- * Managed pci_remap_cfgspace().  Map is automatically unmapped on driver
- * detach.
- */
-void __iomem *devm_pci_remap_cfgspace(struct device *dev,
-				      resource_size_t offset,
-				      resource_size_t size)
-{
-	void __iomem **ptr, *addr;
-
-	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
-
-	addr = pci_remap_cfgspace(offset, size);
-	if (addr) {
-		*ptr = addr;
-		devres_add(dev, ptr);
-	} else
-		devres_free(ptr);
-
-	return addr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfgspace);
-
-/**
- * devm_pci_remap_cfg_resource - check, request region and ioremap cfg resource
- * @dev: generic device to handle the resource for
- * @res: configuration space resource to be handled
- *
- * Checks that a resource is a valid memory region, requests the memory
- * region and ioremaps with pci_remap_cfgspace() API that ensures the
- * proper PCI configuration space memory attributes are guaranteed.
- *
- * All operations are managed and will be undone on driver detach.
- *
- * Returns a pointer to the remapped memory or an ERR_PTR() encoded error code
- * on failure. Usage example::
- *
- *	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
- *	base = devm_pci_remap_cfg_resource(&pdev->dev, res);
- *	if (IS_ERR(base))
- *		return PTR_ERR(base);
- */
-void __iomem *devm_pci_remap_cfg_resource(struct device *dev,
-					  struct resource *res)
-{
-	resource_size_t size;
-	const char *name;
-	void __iomem *dest_ptr;
-
-	BUG_ON(!dev);
-
-	if (!res || resource_type(res) != IORESOURCE_MEM) {
-		dev_err(dev, "invalid resource\n");
-		return IOMEM_ERR_PTR(-EINVAL);
-	}
-
-	size = resource_size(res);
-
-	if (res->name)
-		name = devm_kasprintf(dev, GFP_KERNEL, "%s %s", dev_name(dev),
-				      res->name);
-	else
-		name = devm_kstrdup(dev, dev_name(dev), GFP_KERNEL);
-	if (!name)
-		return IOMEM_ERR_PTR(-ENOMEM);
-
-	if (!devm_request_mem_region(dev, res->start, size, name)) {
-		dev_err(dev, "can't request region for resource %pR\n", res);
-		return IOMEM_ERR_PTR(-EBUSY);
-	}
-
-	dest_ptr = devm_pci_remap_cfgspace(dev, res->start, size);
-	if (!dest_ptr) {
-		dev_err(dev, "ioremap failed for resource %pR\n", res);
-		devm_release_mem_region(dev, res->start, size);
-		dest_ptr = IOMEM_ERR_PTR(-ENOMEM);
-	}
-
-	return dest_ptr;
-}
-EXPORT_SYMBOL(devm_pci_remap_cfg_resource);
-
 static void __pci_set_master(struct pci_dev *dev, bool enable)
 {
 	u16 old_cmd, cmd;
@@ -4557,27 +4329,6 @@ int pci_set_mwi(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_set_mwi);
 
-/**
- * pcim_set_mwi - a device-managed pci_set_mwi()
- * @dev: the PCI device for which MWI is enabled
- *
- * Managed pci_set_mwi().
- *
- * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
- */
-int pcim_set_mwi(struct pci_dev *dev)
-{
-	struct pci_devres *dr;
-
-	dr = find_pci_dr(dev);
-	if (!dr)
-		return -ENOMEM;
-
-	dr->mwi = 1;
-	return pci_set_mwi(dev);
-}
-EXPORT_SYMBOL(pcim_set_mwi);
-
 /**
  * pci_try_set_mwi - enables memory-write-invalidate PCI transaction
  * @dev: the PCI device for which MWI is enabled
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 5ecbcf041179..69052059dbd2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -793,6 +793,30 @@ static inline pci_power_t mid_pci_get_power_state(struct pci_dev *pdev)
 }
 #endif
 
+/*
+ * TODO:
+ * The following two components wouldn't need to be here if they weren't used at
+ * four last places in pci.c
+ * Port or move these functions to devres.c and then remove the
+ * pci_devres-components from this header file here.
+ */
+/*
+ * Managed PCI resources.  This manages device on/off, INTx/MSI/MSI-X
+ * on/off and BAR regions.  pci_dev itself records MSI/MSI-X status, so
+ * there's no need to track it separately.  pci_devres is initialized
+ * when a device is enabled using managed PCI device enable interface.
+ */
+struct pci_devres {
+	unsigned int enabled:1;
+	unsigned int pinned:1;
+	unsigned int orig_intx:1;
+	unsigned int restore_intx:1;
+	unsigned int mwi:1;
+	u32 region_mask;
+};
+
+struct pci_devres *find_pci_dr(struct pci_dev *pdev);
+
 /*
  * Config Address for PCI Configuration Mechanism #1
  *
-- 
2.41.0

