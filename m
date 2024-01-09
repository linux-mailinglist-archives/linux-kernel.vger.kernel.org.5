Return-Path: <linux-kernel+bounces-20496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD9827FC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D566A287A91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5640FB664;
	Tue,  9 Jan 2024 07:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEX41hyz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDD2323B;
	Tue,  9 Jan 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704786675; x=1736322675;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=/8cXBE0ANMEPC30DF6NkL2jkocpdAmGBbhoJhEZvCIo=;
  b=CEX41hyzvRm6yVqLx6MYSHxon+qDqwcvuEyi8UAoDnNLYgDdz24Q7Bje
   A2GmbLtbVU01+1eUPOQ1/CQRyZ4fhWr+yAmqi6XgI/lLjIsJdWQrLdtG3
   SmHPIpkOAwWQid5V48oILWce6+aH5MHCVc27CA7iTWi7/8aOSfVyignI2
   QSEjLHJwgeKTpwKZztifinSRRMPasvlP77If/5GCGzXmphab5R1zKtykZ
   sf4+2ta5OsoWDiwXmE/xSZmlUWOLZ4NoWcvgFqeFvCDw38ybybxbeAtR6
   TPgj0hkCiCfOTYPEqXlZhtv11sIBwh+MCQkXvR400XO8kCcIEaYUrF1CN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5471396"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="5471396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 23:51:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="815873915"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="815873915"
Received: from dyoung1-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.107.150])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 23:51:14 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 08 Jan 2024 23:51:13 -0800
Subject: [PATCH RFC] cxl/pci: Skip irq features if irq's are not supported
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
X-B4-Tracking: v=1; b=H4sIAPD6nGUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQwML3ZT8vBLdtMTMHN3MokLdREszY0MDYzOLNIM0JaCegqLUtMwKsHn
 RSkFuzkqxtbUA1/bbpGQAAAA=
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704786673; l=4358;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=/8cXBE0ANMEPC30DF6NkL2jkocpdAmGBbhoJhEZvCIo=;
 b=wiXmXRt6ybSPB2JUTVBiPxKDYdIRvdH2tGFtENyitZfJdZvBVC2X6QyhaNBiXw81ID13XV8RF
 qqRYYGbQIW3Dd0DlYfR4z5Smu9fwYQIL0uAl8beJ1IW03GtMjkR8oji
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
support interrupts at all.  A device may not use mailbox interrupts and
may be configured for firmware first event processing.

Rather than fail device probe if interrupts are not supported; flag such
that irqs are not supported and do not enable features which require
interrupts.  dev_warn() in those cases which require interrupts but they
were not supported.

It is possible for a device to have host based event processing through
polling but this patch does not support the addition of such polling.
Leave that to the future if such a device comes along.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Compile tested only.

This is an RFC based on errors seen by Dave Larson and reported on
discord.  Dan requested that the driver not fail if irqs are not
required.
---
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a2fcbca253f3..422bc9657e5c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -410,6 +410,7 @@ enum cxl_devtype {
  * @ram_res: Active Volatile memory capacity configuration
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
+ * @irq_supported: Flag if irqs are supported by the device
  */
 struct cxl_dev_state {
 	struct device *dev;
@@ -424,6 +425,7 @@ struct cxl_dev_state {
 	struct resource ram_res;
 	u64 serial;
 	enum cxl_devtype type;
+	bool irq_supported;
 };
 
 /**
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0155fb66b580..bb90ac011290 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -443,6 +443,12 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
 		return 0;
 
+	if (!cxlds->irq_supported) {
+		dev_err(cxlds->dev, "Mailbox interrupts enabled but device indicates no interrupt vectors supported.\n");
+		dev_err(cxlds->dev, "Skip mailbox iterrupt configuration.\n");
+		return 0;
+	}
+
 	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
 	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
 	if (irq < 0)
@@ -587,7 +593,8 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
 	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
 }
 
-static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
+static void cxl_alloc_irq_vectors(struct pci_dev *pdev,
+				  struct cxl_dev_state *cxlds)
 {
 	int nvecs;
 
@@ -604,9 +611,10 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
 	if (nvecs < 1) {
 		dev_dbg(&pdev->dev, "Failed to alloc irq vectors: %d\n", nvecs);
-		return -ENXIO;
+		return;
 	}
-	return 0;
+
+	cxlds->irq_supported = true;
 }
 
 static irqreturn_t cxl_event_thread(int irq, void *id)
@@ -754,6 +762,13 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (!host_bridge->native_cxl_error)
 		return 0;
 
+	/* Polling not supported */
+	if (!mds->cxlds.irq_supported) {
+		dev_err(mds->cxlds.dev, "Host events enabled but device indicates no interrupt vectors supported.\n");
+		dev_err(mds->cxlds.dev, "Event polling is not supported, skip event processing.\n");
+		return 0;
+	}
+
 	rc = cxl_mem_alloc_event_buf(mds);
 	if (rc)
 		return rc;
@@ -845,9 +860,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	else
 		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
 
-	rc = cxl_alloc_irq_vectors(pdev);
-	if (rc)
-		return rc;
+	cxl_alloc_irq_vectors(pdev, cxlds);
 
 	rc = cxl_pci_setup_mailbox(mds);
 	if (rc)

---
base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
change-id: 20240108-dont-fail-irq-a96310368f0f

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


