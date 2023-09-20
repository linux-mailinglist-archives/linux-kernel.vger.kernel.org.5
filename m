Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38837A77E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjITJqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjITJq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:46:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023F3AB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695203180; x=1726739180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kb/MqG+8hGs7sJxn6q18Pz8fc9ZzXNKF2rq4JnktHB4=;
  b=oAeluAgryQIi/gTPCBKlPGKwQiSVw7cJqIPTTzIc4SJ+fhSITeUuiVGc
   zu0V0HORfnSTr8C3tvq+2ghFUrhuEm9J5+Ntv93wgHo6lqbMsZBhQ9MlK
   BiTyLtoAvns8r2IowSBL6WQNQBeJyO09UWkuELQj1UE6QTOWRhurNfmu9
   AdleJEPh+Y5ZKuoCy0U90Fp/fIi+/3RP6luzzz8vCgEl5GxGbj6MnvadU
   +DpO03wh5Gj4reFk6r+GX4jJxHyTIXHHkXVm8tFPvjHqm5WiD9v/CFdgs
   gJy4tFyZlpZe1FeocjYsukUByJhU+zwcUY6tEtTBQpZYJBJ/B7vAnbO16
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370491742"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="370491742"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:46:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="861911793"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="861911793"
Received: from sannilnx-dsk.jer.intel.com ([10.12.231.107])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 02:46:16 -0700
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] drm/xe/gsc: add gsc device support
Date:   Wed, 20 Sep 2023 12:41:50 +0300
Message-Id: <20230920094151.1593505-4-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920094151.1593505-1-alexander.usyskin@intel.com>
References: <20230920094151.1593505-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Lubart <vitaly.lubart@intel.com>

Create mei-gscfi auxiliary device and configure interrupts
to be consumed by mei-gsc device driver.

Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/Kconfig           |   1 +
 drivers/gpu/drm/xe/Makefile          |   1 +
 drivers/gpu/drm/xe/xe_device.c       |   4 +
 drivers/gpu/drm/xe/xe_device_types.h |   4 +
 drivers/gpu/drm/xe/xe_heci_gsc.c     | 222 +++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_heci_gsc.h     |  35 +++++
 drivers/gpu/drm/xe/xe_irq.c          |  21 ++-
 7 files changed, 283 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.c
 create mode 100644 drivers/gpu/drm/xe/xe_heci_gsc.h

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index d57181ff47e6..7df49b12a724 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -37,6 +37,7 @@ config DRM_XE
 	select DRM_SCHED
 	select MMU_NOTIFIER
 	select WANT_DEV_COREDUMP
+	select AUXILIARY_BUS
 	help
 	  Experimental driver for Intel Xe series GPUs
 
diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index cc95a46b5e4d..379bd977a0a6 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -73,6 +73,7 @@ xe-y += xe_bb.o \
 	xe_guc_log.o \
 	xe_guc_pc.o \
 	xe_guc_submit.o \
+	xe_heci_gsc.o \
 	xe_hw_engine.o \
 	xe_hw_engine_class_sysfs.o \
 	xe_hw_fence.o \
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index b6bcb6c3482e..5c32da629baf 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -292,6 +292,8 @@ int xe_device_probe(struct xe_device *xe)
 			goto err_irq_shutdown;
 	}
 
+	xe_heci_gsc_init(xe);
+
 	err = xe_mmio_probe_vram(xe);
 	if (err)
 		goto err_irq_shutdown;
@@ -367,6 +369,8 @@ void xe_device_remove(struct xe_device *xe)
 
 	xe_display_fini(xe);
 
+	xe_heci_gsc_fini(xe);
+
 	xe_irq_shutdown(xe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 696416afa7d1..3c2315c80ac2 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -13,6 +13,7 @@
 #include <drm/ttm/ttm_device.h>
 
 #include "xe_devcoredump_types.h"
+#include "xe_heci_gsc.h"
 #include "xe_gt_types.h"
 #include "xe_platform_types.h"
 #include "xe_pmu.h"
@@ -368,6 +369,9 @@ struct xe_device {
 	/** @pmu: performance monitoring unit */
 	struct xe_pmu pmu;
 
+	/** @heci_gsc: graphics security controller */
+	struct xe_heci_gsc heci_gsc;
+
 	/* private: */
 
 #if IS_ENABLED(CONFIG_DRM_XE_DISPLAY)
diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.c b/drivers/gpu/drm/xe/xe_heci_gsc.c
new file mode 100644
index 000000000000..3328ddca42d0
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.c
@@ -0,0 +1,222 @@
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
+#include "xe_device_types.h"
+#include "xe_drv.h"
+#include "xe_heci_gsc.h"
+#include "xe_platform_types.h"
+
+#define GSC_BAR_LENGTH  0x00000FFC
+
+static void heci_gsc_irq_mask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static void heci_gsc_irq_unmask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static struct irq_chip heci_gsc_irq_chip = {
+	.name = "gsc_irq_chip",
+	.irq_mask = heci_gsc_irq_mask,
+	.irq_unmask = heci_gsc_irq_unmask,
+};
+
+static int heci_gsc_irq_init(int irq)
+{
+	irq_set_chip_and_handler_name(irq, &heci_gsc_irq_chip,
+				      handle_simple_irq, "heci_gsc_irq_handler");
+
+	return irq_set_chip_data(irq, NULL);
+}
+
+/**
+ * struct heci_gsc_def - graphics security controller heci interface definitions
+ *
+ * @name: name of the heci device
+ * @bar: address of the mmio bar
+ * @bar_size: size of the mmio bar
+ * @use_polling: indication of using polling mode for the device
+ * @slow_firmware: indication of whether the device is slow (needs longer timeouts)
+ */
+struct heci_gsc_def {
+	const char *name;
+	unsigned long bar;
+	size_t bar_size;
+	bool use_polling;
+	bool slow_firmware;
+};
+
+/* gsc resources and definitions */
+static const struct heci_gsc_def heci_gsc_def_dg1 = {
+	.name = "mei-gscfi",
+	.bar = DG1_GSC_HECI2_BASE,
+	.bar_size = GSC_BAR_LENGTH,
+};
+
+static const struct heci_gsc_def heci_gsc_def_dg2 = {
+	.name = "mei-gscfi",
+	.bar = DG2_GSC_HECI2_BASE,
+	.bar_size = GSC_BAR_LENGTH,
+};
+
+static void heci_gsc_release_dev(struct device *dev)
+{
+	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
+	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+
+	kfree(adev);
+}
+
+void xe_heci_gsc_fini(struct xe_device *xe)
+{
+	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
+
+	if (!HAS_HECI_GSCFI(xe))
+		return;
+
+	if (heci_gsc->adev) {
+		struct auxiliary_device *aux_dev = &heci_gsc->adev->aux_dev;
+
+		auxiliary_device_delete(aux_dev);
+		auxiliary_device_uninit(aux_dev);
+		heci_gsc->adev = NULL;
+	}
+
+	if (heci_gsc->irq >= 0)
+		irq_free_desc(heci_gsc->irq);
+	heci_gsc->irq = -1;
+}
+
+static int heci_gsc_irq_setup(struct xe_device *xe)
+{
+	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
+	int ret;
+
+	heci_gsc->irq = irq_alloc_desc(0);
+	if (heci_gsc->irq < 0) {
+		drm_err(&xe->drm, "gsc irq error %d\n", heci_gsc->irq);
+		return heci_gsc->irq;
+	}
+
+	ret = heci_gsc_irq_init(heci_gsc->irq);
+	if (ret < 0)
+		drm_err(&xe->drm, "gsc irq init failed %d\n", ret);
+
+	return ret;
+}
+
+static int heci_gsc_add_device(struct xe_device *xe, const struct heci_gsc_def *def)
+{
+	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
+	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
+	struct auxiliary_device *aux_dev;
+	struct mei_aux_device *adev;
+	int ret;
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+	adev->irq = heci_gsc->irq;
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
+	aux_dev->dev.release = heci_gsc_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret < 0) {
+		drm_err(&xe->drm, "gsc aux init failed %d\n", ret);
+		kfree(adev);
+		return ret;
+	}
+
+	heci_gsc->adev = adev; /* needed by the notifier */
+	ret = auxiliary_device_add(aux_dev);
+	if (ret < 0) {
+		drm_err(&xe->drm, "gsc aux add failed %d\n", ret);
+		heci_gsc->adev = NULL;
+
+		/* adev will be freed with the put_device() and .release sequence */
+		auxiliary_device_uninit(aux_dev);
+	}
+	return ret;
+}
+
+void xe_heci_gsc_init(struct xe_device *xe)
+{
+	struct xe_heci_gsc *heci_gsc = &xe->heci_gsc;
+	const struct heci_gsc_def *def;
+	int ret;
+
+	if (!HAS_HECI_GSCFI(xe))
+		return;
+
+	heci_gsc->irq = -1;
+
+	if (xe->info.platform == XE_DG2) {
+		def = &heci_gsc_def_dg2;
+	} else if (xe->info.platform == XE_DG1) {
+		def = &heci_gsc_def_dg1;
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
+	if (!def->use_polling) {
+		ret = heci_gsc_irq_setup(xe);
+		if (ret)
+			goto fail;
+	}
+
+	ret = heci_gsc_add_device(xe, def);
+	if (ret)
+		goto fail;
+
+	return;
+fail:
+	xe_heci_gsc_fini(xe);
+}
+
+void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir)
+{
+	int ret;
+
+	if ((iir & GSC_IRQ_INTF(1)) == 0)
+		return;
+
+	if (!HAS_HECI_GSCFI(xe)) {
+		drm_warn_once(&xe->drm, "GSC irq: not supported");
+		return;
+	}
+
+	if (xe->heci_gsc.irq < 0)
+		return;
+
+	ret = generic_handle_irq(xe->heci_gsc.irq);
+	if (ret)
+		drm_err_ratelimited(&xe->drm, "error handling GSC irq: %d\n", ret);
+}
diff --git a/drivers/gpu/drm/xe/xe_heci_gsc.h b/drivers/gpu/drm/xe/xe_heci_gsc.h
new file mode 100644
index 000000000000..9db454478fae
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_heci_gsc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2023, Intel Corporation. All rights reserved.
+ */
+#ifndef __XE_HECI_GSC_DEV_H__
+#define __XE_HECI_GSC_DEV_H__
+
+#include <linux/types.h>
+
+struct xe_device;
+struct mei_aux_device;
+
+/*
+ * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
+ * The reason for this is to allow growth for more interfaces in the future.
+ */
+#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
+
+/**
+ * struct xe_heci_gsc - graphics security controller for xe, HECI interface
+ *
+ * @adev : pointer to mei auxiliary device structure
+ * @irq : irq number
+ *
+ */
+struct xe_heci_gsc {
+	struct mei_aux_device *adev;
+	int irq;
+};
+
+void xe_heci_gsc_init(struct xe_device *xe);
+void xe_heci_gsc_fini(struct xe_device *xe);
+void xe_heci_gsc_irq_handler(struct xe_device *xe, u32 iir);
+
+#endif /* __XE_HECI_GSC_DEV_H__ */
diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index ccb934f8fa34..ea53d34fd745 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -142,6 +142,7 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
 	struct xe_device *xe = gt_to_xe(gt);
 	u32 ccs_mask, bcs_mask;
 	u32 irqs, dmask, smask;
+	u32 gsc_mask;
 
 	if (xe_device_uc_enabled(xe)) {
 		irqs = GT_RENDER_USER_INTERRUPT |
@@ -191,9 +192,13 @@ void xe_irq_enable_hwe(struct xe_gt *gt)
 		xe_mmio_write32(gt, VCS2_VCS3_INTR_MASK, ~dmask);
 		xe_mmio_write32(gt, VECS0_VECS1_INTR_MASK, ~dmask);
 
-		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER)) {
-			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, irqs);
-			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~irqs);
+		if (xe_hw_engine_mask_per_class(gt, XE_ENGINE_CLASS_OTHER))
+			gsc_mask = irqs;
+		else if (HAS_HECI_GSCFI(xe))
+			gsc_mask = GSC_IRQ_INTF(1);
+		if (gsc_mask) {
+			xe_mmio_write32(gt, GUNIT_GSC_INTR_ENABLE, gsc_mask);
+			xe_mmio_write32(gt, GUNIT_GSC_INTR_MASK, ~gsc_mask);
 		}
 	}
 }
@@ -298,6 +303,11 @@ static void gt_irq_handler(struct xe_tile *tile,
 			instance = INTR_ENGINE_INSTANCE(identity[bit]);
 			intr_vec = INTR_ENGINE_INTR(identity[bit]);
 
+			if (class == XE_ENGINE_CLASS_OTHER && instance == OTHER_GSC_INSTANCE) {
+				xe_heci_gsc_irq_handler(xe, intr_vec);
+				continue;
+			}
+
 			engine_gt = pick_engine_gt(tile, class, instance);
 
 			hwe = xe_gt_hw_engine(engine_gt, class, instance, false);
@@ -488,8 +498,9 @@ static void gt_irq_reset(struct xe_tile *tile)
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

