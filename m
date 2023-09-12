Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E1A79D1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbjILNN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbjILNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:13:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AA710D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694524401; x=1726060401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I849JyADgwOcl+HG+SklpbtTKTR89WyZMLdhnLssDt8=;
  b=mowDhGkm/pfKQgjzR7wT7CfwZi8vwjy+zAiL9d8/vy+fjQXi+jH05pK0
   2tmxwMeMPKsVS3PZkFajaxmblLvnz0sB09gOGxfEIjTMKqqVh9hWFFPbb
   Tg1eOGtoAXrcJFQaSmmDIt8iHmqg7gsVszELpCshGgjENxXQ5jkuwf9pJ
   FBrQddTB37NfrNZck4+51FkjopAq4vHUyleP/b5ClUKX+I87Whmx9mMLm
   A3O56iwQasLhZpYDqpIjDdyjq+4pJTXBvb8wPRWbs5sUbAaf8PTIF/FH2
   4app9RrzY30F9U7I0lE8yA6mbUignY00KFEb+zQPBFMhMAd+Vcl74Gdgr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="464740128"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="464740128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="737116353"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="737116353"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 06:13:18 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/xe/gsc: add gsc device support
Date:   Tue, 12 Sep 2023 16:08:34 +0300
Message-Id: <20230912130835.2488728-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912130835.2488728-1-alexander.usyskin@intel.com>
References: <20230912130835.2488728-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Create mei-gscfi auxiliary device and configure interrupts
to be consumed by mei-gsc device driver.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/Kconfig       |   1 +
 drivers/gpu/drm/xe/Makefile      |   1 +
 drivers/gpu/drm/xe/xe_gt.c       |   4 +
 drivers/gpu/drm/xe/xe_gt_gsc.c   | 218 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_gt_gsc.h   |  36 +++++
 drivers/gpu/drm/xe/xe_gt_types.h |   4 +
 drivers/gpu/drm/xe/xe_irq.c      |  11 +-
 7 files changed, 273 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.c
 create mode 100644 drivers/gpu/drm/xe/xe_gt_gsc.h

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 0a4ea965645b..9d396ca7708a 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -36,6 +36,7 @@ config DRM_XE
 	select DRM_SCHED
 	select MMU_NOTIFIER
 	select WANT_DEV_COREDUMP
+	select AUXILIARY_BUS
 	help
 	  Experimental driver for Intel Xe series GPUs
 
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 9a2245ffede2..9ba9389a2cfd 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -65,6 +65,7 @@ xe-y += xe_bb.o \
 	xe_gt_sysfs.o \
 	xe_gt_tlb_invalidation.o \
 	xe_gt_topology.o \
+	xe_gt_gsc.o \
 	xe_guc.o \
 	xe_guc_ads.o \
 	xe_guc_ct.o \
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 4c7f66647a04..f373c139e1a1 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -76,6 +76,8 @@ static void gt_fini(struct drm_device *drm, void *arg)
 
 	destroy_workqueue(gt->ordered_wq);
 
+	xe_gsc_fini(&gt->gsc);
+
 	for (i = 0; i < XE_ENGINE_CLASS_MAX; ++i)
 		xe_hw_fence_irq_finish(&gt->fence_irq[i]);
 }
@@ -460,6 +462,8 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	xe_gsc_init(&gt->gsc, gt_to_xe(gt));
+
 	err = drmm_add_action_or_reset(&gt_to_xe(gt)->drm, gt_fini, gt);
 	if (err)
 		return err;
diff --git a/drivers/gpu/drm/xe/xe_gt_gsc.c b/drivers/gpu/drm/xe/xe_gt_gsc.c
new file mode 100644
index 000000000000..ed825c883da7
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_gt_gsc.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2023, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/irq.h>
+#include <linux/mei_aux.h>
+#include <linux/pci.h>
+#include <linux/sizes.h>
+
+#include "regs/xe_regs.h"
+#include "xe_drv.h"
+#include "xe_gt_gsc.h"
+#include "xe_gt_types.h"
+#include "xe_device_types.h"
+#include "xe_platform_types.h"
+
+#define GSC_BAR_LENGTH  0x00000FFC
+
+static void gsc_irq_mask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static void gsc_irq_unmask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static struct irq_chip gsc_irq_chip = {
+	.name = "gsc_irq_chip",
+	.irq_mask = gsc_irq_mask,
+	.irq_unmask = gsc_irq_unmask,
+};
+
+static inline struct xe_gt *gsc_to_gt(struct xe_gsc *gsc)
+{
+	return container_of(gsc, struct xe_gt, gsc);
+}
+
+static int gsc_irq_init(int irq)
+{
+	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
+				      handle_simple_irq, "gsc_irq_handler");
+
+	return irq_set_chip_data(irq, NULL);
+}
+
+/**
+ * struct gsc_def - graphics security controller heci interface definistions
+ *
+ * @name: name of the heci device
+ * @bar: address of the mmio bar
+ * @bar_size: size of the mmio bar
+ * @use_polling: indication of using polling mode for the device
+ * @slow_firmware: indication of whether the device is slow (needs longer timeouts)
+ */
+struct gsc_def {
+	const char *name;
+	unsigned long bar;
+	size_t bar_size;
+	bool use_polling;
+	bool slow_firmware;
+};
+
+/* gsc resources and definitions */
+static const struct gsc_def gsc_def_dg1 = {
+	.name = "mei-gscfi",
+	.bar = DG1_GSC_HECI2_BASE,
+	.bar_size = GSC_BAR_LENGTH,
+};
+
+static const struct gsc_def gsc_def_dg2 = {
+	.name = "mei-gscfi",
+	.bar = DG2_GSC_HECI2_BASE,
+	.bar_size = GSC_BAR_LENGTH,
+};
+
+static void gsc_release_dev(struct device *dev)
+{
+	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
+	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+
+	kfree(adev);
+}
+
+void xe_gsc_fini(struct xe_gsc *gsc)
+{
+	struct xe_gt *gt = gsc_to_gt(gsc);
+
+	if (!HAS_HECI_GSCFI(gt_to_xe(gt)))
+		return;
+
+	if (gsc->adev) {
+		struct auxiliary_device *aux_dev = &gsc->adev->aux_dev;
+
+		auxiliary_device_delete(aux_dev);
+		auxiliary_device_uninit(aux_dev);
+		gsc->adev = NULL;
+	}
+
+	if (gsc->irq >= 0)
+		irq_free_desc(gsc->irq);
+	gsc->irq = -1;
+}
+
+void xe_gsc_init(struct xe_gsc *gsc, struct xe_device *xe)
+{
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct mei_aux_device *adev;
+	struct auxiliary_device *aux_dev;
+	const struct gsc_def *def;
+	int ret;
+
+	if (!HAS_HECI_GSCFI(xe))
+		return;
+
+	gsc->irq = -1;
+
+	/*
+	 * On the multi-tile setups the GSC is functional on the first tile only
+	 */
+	if (gsc_to_gt(gsc)->info.id != 0) {
+		drm_dbg(&xe->drm, "Not initializing gsc for remote tiles\n");
+		return;
+	}
+
+	if (xe->info.platform == XE_DG1) {
+		def = &gsc_def_dg1;
+	} else if (xe->info.platform == XE_DG2) {
+		def = &gsc_def_dg2;
+	} else {
+		drm_warn_once(&xe->drm, "Unknown platform\n");
+		return;
+	}
+
+	if (!def->name) {
+		drm_warn_once(&xe->drm, "HECI is not implemented!\n");
+		return;
+	}
+
+	/* skip irq initialization */
+	if (def->use_polling)
+		goto add_device;
+
+	gsc->irq = irq_alloc_desc(0);
+	if (gsc->irq < 0) {
+		drm_err(&xe->drm, "gsc irq error %d\n", gsc->irq);
+		goto fail;
+	}
+
+	ret = gsc_irq_init(gsc->irq);
+	if (ret < 0) {
+		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
+		goto fail;
+	}
+
+add_device:
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		goto fail;
+	adev->irq = gsc->irq;
+	adev->bar.parent = &pdev->resource[0];
+	adev->bar.start = def->bar + pdev->resource[0].start;
+	adev->bar.end = adev->bar.start + def->bar_size - 1;
+	adev->bar.flags = IORESOURCE_MEM;
+	adev->bar.desc = IORES_DESC_NONE;
+	adev->slow_firmware = def->slow_firmware;
+
+	aux_dev = &adev->aux_dev;
+	aux_dev->name = def->name;
+	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
+		      PCI_DEVID(pdev->bus->number, pdev->devfn);
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = gsc_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret < 0) {
+		drm_err(&xe->drm, "gsc aux init failed %d\n", ret);
+		kfree(adev);
+		goto fail;
+	}
+
+	gsc->adev = adev; /* needed by the notifier */
+	ret = auxiliary_device_add(aux_dev);
+	if (ret < 0) {
+		drm_err(&xe->drm, "gsc aux add failed %d\n", ret);
+		gsc->adev = NULL;
+
+		/* adev will be freed with the put_device() and .release sequence */
+		auxiliary_device_uninit(aux_dev);
+		goto fail;
+	}
+
+	return;
+fail:
+	xe_gsc_fini(gsc);
+}
+
+void xe_gsc_irq_handler(struct xe_gt *gt, u32 iir)
+{
+	int ret;
+
+	if ((iir & GSC_IRQ_INTF(1)) == 0)
+		return;
+
+	if (!HAS_HECI_GSCFI(gt_to_xe(gt))) {
+		drm_warn_once(&gt_to_xe(gt)->drm, "GSC irq: not supported");
+		return;
+	}
+
+	if (gt->gsc.irq < 0)
+		return;
+
+	ret = generic_handle_irq(gt->gsc.irq);
+	if (ret)
+		drm_err_ratelimited(&gt_to_xe(gt)->drm, "error handling GSC irq: %d\n", ret);
+}
diff --git a/drivers/gpu/drm/xe/xe_gt_gsc.h b/drivers/gpu/drm/xe/xe_gt_gsc.h
new file mode 100644
index 000000000000..91dba19e47c1
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_gt_gsc.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2023, Intel Corporation. All rights reserved.
+ */
+#ifndef __XE_GSC_DEV_H__
+#define __XE_GSC_DEV_H__
+
+#include <linux/types.h>
+
+struct xe_device;
+struct xe_gt;
+struct mei_aux_device;
+
+/*
+ * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
+ * The reason for this is to allow growth for more interfaces in the future.
+ */
+#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
+
+/**
+ * struct xe_gsc - graphics security controller for xe
+ *
+ * @adev : pointer to mei auxiliary device structure
+ * @irq : irq number
+ *
+ */
+struct xe_gsc {
+	struct mei_aux_device *adev;
+	int irq;
+};
+
+void xe_gsc_init(struct xe_gsc *gsc, struct xe_device *xe);
+void xe_gsc_fini(struct xe_gsc *gsc);
+void xe_gsc_irq_handler(struct xe_gt *gt, u32 iir);
+
+#endif /* __XE_GSC_DEV_H__ */
diff --git a/drivers/gpu/drm/xe/xe_gt_types.h b/drivers/gpu/drm/xe/xe_gt_types.h
index f11da12d3146..1b8ab32b488d 100644
--- a/drivers/gpu/drm/xe/xe_gt_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_types.h
@@ -13,6 +13,7 @@
 #include "xe_reg_sr_types.h"
 #include "xe_sa_types.h"
 #include "xe_uc_types.h"
+#include "xe_gt_gsc.h"
 
 struct xe_exec_queue_ops;
 struct xe_migrate;
@@ -267,6 +268,9 @@ struct xe_gt {
 	/** @uc: micro controllers on the GT */
 	struct xe_uc uc;
 
+	/** @gsc: graphics security controller */
+	struct xe_gsc gsc;
+
 	/** @gtidle: idle properties of GT */
 	struct xe_gt_idle gtidle;
 
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index 1dee3e832eb5..1ae4cc9f1522 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -128,6 +128,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
 	struct xe_device *xe = gt_to_xe(gt);
 	u32 ccs_mask, bcs_mask;
 	u32 irqs, dmask, smask;
+	u32 gsc_mask = GSC_IRQ_INTF(1);
 
 	if (xe_device_guc_submission_enabled(xe)) {
 		irqs = GT_RENDER_USER_INTERRUPT |
@@ -180,6 +181,9 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
 		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER)) {
 			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, irqs);
 			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~irqs);
+		} else if (HAS_HECI_GSCFI(xe)) {
+			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, gsc_mask);
+			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~gsc_mask);
 		}
 	}
 }
@@ -227,6 +231,8 @@ gt_other_irq_handler(struct xe_gt *gt, const u8 instance, const u16 iir)
 		return xe_guc_irq_handler(&gt->uc.guc, iir);
 	if (instance == OTHER_MEDIA_GUC_INSTANCE && xe_gt_is_media_type(gt))
 		return xe_guc_irq_handler(&gt->uc.guc, iir);
+	if (instance == OTHER_GSC_INSTANCE)
+		return xe_gsc_irq_handler(gt, iir);
 
 	if (instance != OTHER_GUC_INSTANCE &&
 	    instance != OTHER_MEDIA_GUC_INSTANCE) {
@@ -470,8 +476,9 @@ static void gt_irq_reset(struct xe_tile *tile)
 	if (ccs_mask & (BIT(2)|BIT(3)))
 		xe_mmio_write32(mmio,  CCS2_CCS3_INTR_MASK, ~0);
 
-	if (tile->media_gt &&
-	    xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) {
+	if ((tile->media_gt &&
+	     xe_hw_engine_mask_per_class(tile->media_gt, XE_ENGINE_CLASS_OTHER)) ||
+	    HAS_HECI_GSCFI(tile_to_xe(tile))) {
 		xe_mmio_write32(mmio, GUNIT_GSC_INTR_ENABLE, 0);
 		xe_mmio_write32(mmio, GUNIT_GSC_INTR_MASK, ~0);
 	}
-- 
2.34.1

