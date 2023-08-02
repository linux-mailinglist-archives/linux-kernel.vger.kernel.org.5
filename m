Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C176D95F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjHBVTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjHBVT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:19:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488F273E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691011166; x=1722547166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IAy6A7NS03AEt05WSArM30aBL6tZTgg14+BUrwets8=;
  b=DEYQdNO/KsU7k5K5K2kPHOtf3NmCZJquWcfN0Ujt8PMt95DqbnmrwzLi
   Yz4Hwe+5NAkgByqFg7aJvs7GDKWRFGMFrGDPNZ2AdSch9WyGfdCpc3Zn7
   AdtJoyVCHVsBgJ/K9k50OB9NMWUwDmJCkVUYZUoYW9ozpnS89EnGohbWg
   GV9r1pr19oV6PZcgzAZ8TWqd8AIqCfky3yaWcmUT+8EOtO4oe8SaTAzTS
   8rfAw07Ff4iH46JK5hOFtqSP9LLM3oto4PcMkF5tlgFENaPyKAiAuxIXT
   FJ0Cn+Hn/AqSZ+5Xrcs6F74L4WWaWRByXVJpJZ+OmFNhdrckh9TJR4IVv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372436186"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372436186"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="729290808"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="729290808"
Received: from srinivas-otcpl-7600.jf.intel.com (HELO jacob-builder.jf.intel.com) ([10.54.97.184])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2023 14:19:22 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, "Will Deacon" <will@kernel.org>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tony Zhu <tony.zhu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v12 8/8] dmaengine/idxd: Re-enable kernel workqueue under DMA API
Date:   Wed,  2 Aug 2023 14:24:27 -0700
Message-Id: <20230802212427.1497170-9-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
References: <20230802212427.1497170-1-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel workqueues were disabled due to flawed use of kernel VA and SVA
API. Now that we have the support for attaching PASID to the device's
default domain and the ability to reserve global PASIDs from SVA APIs,
we can re-enable the kernel work queues and use them under DMA API.

We also use non-privileged access for in-kernel DMA to be consistent
with the IOMMU settings. Consequently, interrupt for user privilege is
enabled for work completion IRQs.

Link:https://lore.kernel.org/linux-iommu/20210511194726.GP1002214@nvidia.com/
Tested-by: Tony Zhu <tony.zhu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
v9: Set user IRQ enable when device is enabled for system PASID
---
 drivers/dma/idxd/device.c | 39 ++++++++++------------------
 drivers/dma/idxd/dma.c    |  5 ++--
 drivers/dma/idxd/idxd.h   |  9 +++++++
 drivers/dma/idxd/init.c   | 54 ++++++++++++++++++++++++++++++++++++---
 drivers/dma/idxd/sysfs.c  |  7 -----
 5 files changed, 76 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..169b7ade8919 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -299,21 +299,6 @@ void idxd_wqs_unmap_portal(struct idxd_device *idxd)
 	}
 }
 
-static void __idxd_wq_set_priv_locked(struct idxd_wq *wq, int priv)
-{
-	struct idxd_device *idxd = wq->idxd;
-	union wqcfg wqcfg;
-	unsigned int offset;
-
-	offset = WQCFG_OFFSET(idxd, wq->id, WQCFG_PRIVL_IDX);
-	spin_lock(&idxd->dev_lock);
-	wqcfg.bits[WQCFG_PRIVL_IDX] = ioread32(idxd->reg_base + offset);
-	wqcfg.priv = priv;
-	wq->wqcfg->bits[WQCFG_PRIVL_IDX] = wqcfg.bits[WQCFG_PRIVL_IDX];
-	iowrite32(wqcfg.bits[WQCFG_PRIVL_IDX], idxd->reg_base + offset);
-	spin_unlock(&idxd->dev_lock);
-}
-
 static void __idxd_wq_set_pasid_locked(struct idxd_wq *wq, int pasid)
 {
 	struct idxd_device *idxd = wq->idxd;
@@ -1423,15 +1408,14 @@ int drv_enable_wq(struct idxd_wq *wq)
 	}
 
 	/*
-	 * In the event that the WQ is configurable for pasid and priv bits.
-	 * For kernel wq, the driver should setup the pasid, pasid_en, and priv bit.
-	 * However, for non-kernel wq, the driver should only set the pasid_en bit for
-	 * shared wq. A dedicated wq that is not 'kernel' type will configure pasid and
+	 * In the event that the WQ is configurable for pasid, the driver
+	 * should setup the pasid, pasid_en bit. This is true for both kernel
+	 * and user shared workqueues. There is no need to setup priv bit in
+	 * that in-kernel DMA will also do user privileged requests.
+	 * A dedicated wq that is not 'kernel' type will configure pasid and
 	 * pasid_en later on so there is no need to setup.
 	 */
 	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		int priv = 0;
-
 		if (wq_pasid_enabled(wq)) {
 			if (is_idxd_wq_kernel(wq) || wq_shared(wq)) {
 				u32 pasid = wq_dedicated(wq) ? idxd->pasid : 0;
@@ -1439,10 +1423,6 @@ int drv_enable_wq(struct idxd_wq *wq)
 				__idxd_wq_set_pasid_locked(wq, pasid);
 			}
 		}
-
-		if (is_idxd_wq_kernel(wq))
-			priv = 1;
-		__idxd_wq_set_priv_locked(wq, priv);
 	}
 
 	rc = 0;
@@ -1550,6 +1530,15 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	if (rc < 0)
 		return -ENXIO;
 
+	/*
+	 * System PASID is preserved across device disable/enable cycle, but
+	 * genconfig register content gets cleared during device reset. We
+	 * need to re-enable user interrupts for kernel work queue completion
+	 * IRQ to function.
+	 */
+	if (idxd->pasid != IOMMU_PASID_INVALID)
+		idxd_set_user_intr(idxd, 1);
+
 	rc = idxd_device_evl_setup(idxd);
 	if (rc < 0) {
 		idxd->cmd_status = IDXD_SCMD_DEV_EVL_ERR;
diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index eb35ca313684..07623fb0f52f 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -75,9 +75,10 @@ static inline void idxd_prep_desc_common(struct idxd_wq *wq,
 	hw->xfer_size = len;
 	/*
 	 * For dedicated WQ, this field is ignored and HW will use the WQCFG.priv
-	 * field instead. This field should be set to 1 for kernel descriptors.
+	 * field instead. This field should be set to 0 for kernel descriptors
+	 * since kernel DMA on VT-d supports "user" privilege only.
 	 */
-	hw->priv = 1;
+	hw->priv = 0;
 	hw->completion_addr = compl;
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 5428a2e1b1ec..502be9db63f4 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -473,6 +473,15 @@ static inline struct idxd_device *ie_to_idxd(struct idxd_irq_entry *ie)
 	return container_of(ie, struct idxd_device, ie);
 }
 
+static inline void idxd_set_user_intr(struct idxd_device *idxd, bool enable)
+{
+	union gencfg_reg reg;
+
+	reg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
+	reg.user_int_en = enable;
+	iowrite32(reg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);
+}
+
 extern struct bus_type dsa_bus_type;
 
 extern bool support_enqcmd;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1aa823974cda..0eb1c827a215 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -550,14 +550,59 @@ static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_d
 
 static int idxd_enable_system_pasid(struct idxd_device *idxd)
 {
-	return -EOPNOTSUPP;
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iommu_domain *domain;
+	ioasid_t pasid;
+	int ret;
+
+	/*
+	 * Attach a global PASID to the DMA domain so that we can use ENQCMDS
+	 * to submit work on buffers mapped by DMA API.
+	 */
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return -EPERM;
+
+	pasid = iommu_alloc_global_pasid(dev);
+	if (pasid == IOMMU_PASID_INVALID)
+		return -ENOSPC;
+
+	/*
+	 * DMA domain is owned by the driver, it should support all valid
+	 * types such as DMA-FQ, identity, etc.
+	 */
+	ret = iommu_attach_device_pasid(domain, dev, pasid);
+	if (ret) {
+		dev_err(dev, "failed to attach device pasid %d, domain type %d",
+			pasid, domain->type);
+		iommu_free_global_pasid(pasid);
+		return ret;
+	}
+
+	/* Since we set user privilege for kernel DMA, enable completion IRQ */
+	idxd_set_user_intr(idxd, 1);
+	idxd->pasid = pasid;
+
+	return ret;
 }
 
 static void idxd_disable_system_pasid(struct idxd_device *idxd)
 {
+	struct pci_dev *pdev = idxd->pdev;
+	struct device *dev = &pdev->dev;
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return;
+
+	iommu_detach_device_pasid(domain, dev, idxd->pasid);
+	iommu_free_global_pasid(idxd->pasid);
 
-	iommu_sva_unbind_device(idxd->sva);
+	idxd_set_user_intr(idxd, 0);
 	idxd->sva = NULL;
+	idxd->pasid = IOMMU_PASID_INVALID;
 }
 
 static int idxd_enable_sva(struct pci_dev *pdev)
@@ -600,8 +645,9 @@ static int idxd_probe(struct idxd_device *idxd)
 		} else {
 			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-			if (idxd_enable_system_pasid(idxd))
-				dev_warn(dev, "No in-kernel DMA with PASID.\n");
+			rc = idxd_enable_system_pasid(idxd);
+			if (rc)
+				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
 			else
 				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 		}
diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 293739ac5596..63f6966c51aa 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -948,13 +948,6 @@ static ssize_t wq_name_store(struct device *dev,
 	if (strlen(buf) > WQ_NAME_SIZE || strlen(buf) == 0)
 		return -EINVAL;
 
-	/*
-	 * This is temporarily placed here until we have SVM support for
-	 * dmaengine.
-	 */
-	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
-		return -EOPNOTSUPP;
-
 	input = kstrndup(buf, count, GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
-- 
2.25.1

