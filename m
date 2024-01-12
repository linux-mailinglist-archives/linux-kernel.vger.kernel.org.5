Return-Path: <linux-kernel+bounces-24220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 115BE82B93F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFAF1C24FCF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898B54A27;
	Fri, 12 Jan 2024 01:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTKpz+tz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AED4A10;
	Fri, 12 Jan 2024 01:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705024491; x=1736560491;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=FwKaBh70qWbjuPirs19qbToC0mDvJw0dkUB7bx+F+is=;
  b=GTKpz+tz1ubGudneBaKAuqeRWSnAO2qWD8izohrAjSCMl25pMgoOMnXN
   F6/MqPobXX6fA/fwvwdlJUPsnvugCblndd71YBjSiSDCVGItF1XXwCj8P
   AE5whB81xvjWSAAkjp9uGXTyUZRDa9VuW8Qmaj68FjFiv5wzmHhzDRi17
   ould+IEfvDAlLhviSg5mG4c9yS9biAWkn1VaN4k0LLtI9dW6VmW+IA9bQ
   15GpkFublok3YXVRekde76wf3SHw2ZTQEI+RIOVr2QlIAE9bkV877Z30f
   WFSA/v253VVPYHlLSZlOLDvDXlVDc4sAULkGm/gcu5qQQfAu7qr/XYzj0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="6140958"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="6140958"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 17:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="853145257"
X-IronPort-AV: E=Sophos;i="6.04,188,1695711600"; 
   d="scan'208";a="853145257"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.125.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 17:54:49 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Thu, 11 Jan 2024 17:54:45 -0800
Subject: [PATCH] cxl/pci: Skip irq features if MSI/MSI-X are not supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240111-dont-fail-irq-v1-1-802c22a79ecb@intel.com>
X-B4-Tracking: v=1; b=H4sIAOSboGUC/3XMQQ6CMBCF4auQWTumUwiiK+9hWFQ6lUmwxbYhG
 sLdrexd/i953wqJo3CCS7VC5EWSBF+CDhUMo/EPRrGlQSvdKFId2uAzOiMTSnyhObc1qbrtnHJ
 QPnNkJ+/du/WlR0k5xM/OL/Rb/0kLIWHTqJPWneW71VfxmafjEJ7Qb9v2BSWdLmKqAAAA
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705024489; l=4847;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=FwKaBh70qWbjuPirs19qbToC0mDvJw0dkUB7bx+F+is=;
 b=TPrHYderiYPCBjIAPWa3WlyGfnuWk6Uf2Ua072gqo5g3dwGpo1CtXvum/CVBM7Jy1LYWi9NXZ
 S+xzLPpQo2/Bq5xyr6Mhk831Rk42Nt8QLHcqKNspofmTDBQ0d0rny/P
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

CXL 3.1 Section 3.1.1 states:

	"A Function on a CXL device must not generate INTx messages if
	that Function participates in CXL.cache protocol or CXL.mem
	protocols."

The generic CXL memory driver only supports devices which use the
CXL.mem protocol.  The current driver attempts to allocate MSI/MSI-X
vectors in anticipation of their need for mailbox interrupts or event
processing.  However, the above requirement does not require a device to
support interrupts, only that they use MSI/MSI-X.  For example, a device
may disable mailbox interrupts and be configured for firmware first
event processing and function well with the driver.

Rather than fail device probe if interrupts are not supported; flag that
irqs are not enabled and avoid features which require interrupts.
Emit messages appropriate for the situation to aid in debugging should
device behavior be unexpected due to a failure to allocate vectors.

Note that it is possible for a device to have host based event
processing through polling.  However, the driver does not support
polling and it is not anticipated to be required.  Leave that case to
the future if such a device comes along.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v1:
- [djbw: remove persistent irq boolean]
- [djbw: Simplify error messages]
- [Alison: spell check]
- [iweiny: test]
- Link to RFC: https://lore.kernel.org/r/20240108-dont-fail-irq-v1-1-4407228debd2@intel.com
---
 drivers/cxl/pci.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..bd12b97bb38e 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -381,7 +381,7 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
+static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
@@ -443,6 +443,11 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
 		return 0;
 
+	if (!irq_avail) {
+		dev_err(cxlds->dev, "Mailbox irq enabled but no interrupt vectors.\n");
+		return 0;
+	}
+
 	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
 	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
 	if (irq < 0)
@@ -587,7 +592,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
 	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
 }
 
-static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
+static bool cxl_alloc_irq_vectors(struct pci_dev *pdev)
 {
 	int nvecs;
 
@@ -604,9 +609,9 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nvecs < 1) {
 		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
-		return -ENXIO;
+		return false;
 	}
-	return 0;
+	return true;
 }
 
 static irqreturn_t cxl_event_thread(int irq, void *id)
@@ -742,7 +747,7 @@ static bool cxl_event_int_is_fw(u8 setting)
 }
 
 static int cxl_event_config(struct pci_host_bridge *host_bridge,
-			    struct cxl_memdev_state *mds)
+			    struct cxl_memdev_state *mds, bool irq_avail)
 {
 	struct cxl_event_interrupt_policy policy;
 	int rc;
@@ -754,6 +759,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (!host_bridge->native_cxl_error)
 		return 0;
 
+	if (!irq_avail) {
+		dev_info(mds->cxlds.dev, "No interrupt vectors, no polling, skip event processing.\n");
+		return 0;
+	}
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
@@ -788,6 +798,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	int i, rc, pmu_count;
+	bool irq_avail;
 
 	/*
 	 * Double check the anonymous union trickery in struct cxl_regs
@@ -845,11 +856,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
+	irq_avail = cxl_alloc_irq_vectors(pdev);
 
-	rc = cxl_pci_setup_mailbox(mds);
+	rc = cxl_pci_setup_mailbox(mds, irq_avail);
 	if (rc)
 		return rc;
 
@@ -908,7 +917,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		}
 	}
 
-	rc = cxl_event_config(host_bridge, mds);
+	rc = cxl_event_config(host_bridge, mds, irq_avail);
 	if (rc)
 		return rc;
 

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240108-dont-fail-irq-a96310368f0f

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


