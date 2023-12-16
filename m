Return-Path: <linux-kernel+bounces-1819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FE281547B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116B01F23040
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692355F84F;
	Fri, 15 Dec 2023 23:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2cpGR1R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBB1DDC5;
	Fri, 15 Dec 2023 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682796; x=1734218796;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=DD6N71R3qKQlz49ZtACQag992QryJS22HAi48yx/CF4=;
  b=n2cpGR1RExjXxvtqF7Q+K3iphtJXveu39Gx3mb4TU/30cfE5XtO7Qlr6
   ARKVnRhKuSm9i758VrfJP2CAUHY1FaK4b2E/LiH1hvMeRa+GfDO1bWvaO
   kZt2IK2b6Bp2Omxt6d+TtXFyM515PKu2jdqfJ7SneQ7AL5bXcZ/Z24f3B
   9jaaK+GOVQpQpcKEjbffYoU55xwefilt1CwGPTVjVgUrwzj/TYpbsvJCf
   UYITsGkSK1bnfrd5PJnziz5aKAxcA+i1TNVAFHTy4w6VEjGEgrG9703el
   fpsyhZek+uIREaLV9ZZEGOmsmoLPCK1UfVMUpy+44gO45XvaBhl86FFoQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="426468806"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="426468806"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778439284"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="778439284"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.213.164.93])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:26:33 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 15 Dec 2023 15:26:33 -0800
Subject: [PATCH v4 7/7] cxl/memdev: Register for and process CPER events
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231215-cxl-cper-v4-7-01b6dab44fcd@intel.com>
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
In-Reply-To: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
X-Mailer: b4 0.13-dev-2539e
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702682786; l=7006;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=DD6N71R3qKQlz49ZtACQag992QryJS22HAi48yx/CF4=;
 b=i0XmI6WsUPqfkno55G6aHZLgWAJ+ozIAOoBx41WNaX1gaWCIwlURvIAeL/xcEEi5y/ZObrOu6
 uwVATW+MS1jBt0BXkV4+x1mMVMGLiDUOltLeIRljZhEvmweZsmsc57Q
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

If the firmware has configured CXL event support to be firmware first
the OS can process those events through CPER records.  The CXL layer has
unique DPA to HPA knowledge and standard event trace parsing in place.

CPER records contain Bus, Device, Function information which can be used
to identify the PCI device which is sending the event.

Change pci driver registration to include registration for a CXL CPER
notifier to process the events through the trace subsystem.

Define and use scoped based management to simplify the handling of the
pci device object.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE this patch depends on Dan's addition of a device guard[1].

[1] https://lore.kernel.org/all/170250854466.1522182.17555361077409628655.stgit@dwillia2-xfh.jf.intel.com/

Changes for v3/v4:
[djbw: define a __free(pci_dev_put) to release the device automatically]
[djbw: use device guard from Vishal]
[iweiny: delete old notifier block structure]
[iweiny: adjust for new notifier interface]
---
 drivers/cxl/core/mbox.c | 31 +++++++++++++++++++++++-----
 drivers/cxl/cxlmem.h    |  4 ++++
 drivers/cxl/pci.c       | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/pci.h     |  2 ++
 4 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index b7efa058a100..c9aa723e3391 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -840,9 +840,30 @@ static const uuid_t gen_media_event_uuid = CXL_EVENT_GEN_MEDIA_UUID;
 static const uuid_t dram_event_uuid = CXL_EVENT_DRAM_UUID;
 static const uuid_t mem_mod_event_uuid = CXL_EVENT_MEM_MODULE_UUID;
 
-static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
-				   enum cxl_event_log_type type,
-				   struct cxl_event_record_raw *record)
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    union cxl_event *event)
+{
+	switch (event_type) {
+	case CXL_CPER_EVENT_GEN_MEDIA:
+		trace_cxl_general_media(cxlmd, type, &gen_media_event_uuid,
+					&event->gen_media);
+		break;
+	case CXL_CPER_EVENT_DRAM:
+		trace_cxl_dram(cxlmd, type, &dram_event_uuid, &event->dram);
+		break;
+	case CXL_CPER_EVENT_MEM_MODULE:
+		trace_cxl_memory_module(cxlmd, type, &mem_mod_event_uuid,
+					&event->mem_module);
+		break;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_event_trace_record, CXL);
+
+static void __cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+				     enum cxl_event_log_type type,
+				     struct cxl_event_record_raw *record)
 {
 	union cxl_event *evt = &record->event;
 	uuid_t *id = &record->id;
@@ -965,8 +986,8 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 			break;
 
 		for (i = 0; i < nr_rec; i++)
-			cxl_event_trace_record(cxlmd, type,
-					       &payload->records[i]);
+			__cxl_event_trace_record(cxlmd, type,
+						 &payload->records[i]);
 
 		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
 			trace_cxl_overflow(cxlmd, type, payload);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e5d770e26e02..e7e9508fecac 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -802,6 +802,10 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
 void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
+			    enum cxl_event_log_type type,
+			    enum cxl_event_type event_type,
+			    union cxl_event *event);
 int cxl_set_timestamp(struct cxl_memdev_state *mds);
 int cxl_poison_state_init(struct cxl_memdev_state *mds);
 int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..638275569d63 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <asm-generic/unaligned.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/moduleparam.h>
 #include <linux/module.h>
@@ -969,6 +970,58 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
+static void cxl_cper_event_call(enum cxl_event_type ev_type,
+				struct cxl_cper_event_rec *rec)
+{
+	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
+	struct pci_dev *pdev __free(pci_dev_put) = NULL;
+	struct cxl_dev_state *cxlds = NULL;
+	enum cxl_event_log_type log_type;
+	unsigned int devfn;
+	u32 hdr_flags;
+
+	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
+	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
+					   device_id->bus_num, devfn);
+	if (!pdev)
+		return;
+
+	guard(device)(&pdev->dev);
+	if (pdev->driver == &cxl_pci_driver)
+		cxlds = pci_get_drvdata(pdev);
+	if (!cxlds)
+		return;
+
+	/* Fabricate a log type */
+	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
+	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
+
+	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type, &rec->event);
+}
+
+static int __init cxl_pci_driver_init(void)
+{
+	int rc;
+
+	rc = pci_register_driver(&cxl_pci_driver);
+	if (rc)
+		return rc;
+
+	rc = cxl_cper_register_notifier(cxl_cper_event_call);
+	if (rc)
+		pci_unregister_driver(&cxl_pci_driver);
+
+	return rc;
+}
+
+static void __exit cxl_pci_driver_exit(void)
+{
+	cxl_cper_unregister_notifier(cxl_cper_event_call);
+	pci_unregister_driver(&cxl_pci_driver);
+}
+
+module_init(cxl_pci_driver_init);
+module_exit(cxl_pci_driver_exit);
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..290d0a2651b2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1170,6 +1170,7 @@ int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
 struct pci_dev *pci_dev_get(struct pci_dev *dev);
 void pci_dev_put(struct pci_dev *dev);
+DEFINE_FREE(pci_dev_put, struct pci_dev *, if (_T) pci_dev_put(_T))
 void pci_remove_bus(struct pci_bus *b);
 void pci_stop_and_remove_bus_device(struct pci_dev *dev);
 void pci_stop_and_remove_bus_device_locked(struct pci_dev *dev);
@@ -1871,6 +1872,7 @@ void pci_cfg_access_unlock(struct pci_dev *dev);
 void pci_dev_lock(struct pci_dev *dev);
 int pci_dev_trylock(struct pci_dev *dev);
 void pci_dev_unlock(struct pci_dev *dev);
+DEFINE_GUARD(pci_dev, struct pci_dev *, pci_dev_lock(_T), pci_dev_unlock(_T))
 
 /*
  * PCI domain support.  Sometimes called PCI segment (eg by ACPI),

-- 
2.43.0


