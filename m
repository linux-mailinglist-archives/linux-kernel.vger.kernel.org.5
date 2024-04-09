Return-Path: <linux-kernel+bounces-137367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 263CD89E115
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF80B28668D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27CD155391;
	Tue,  9 Apr 2024 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jFz0y9Eq"
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEF1552FC;
	Tue,  9 Apr 2024 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682480; cv=none; b=akrZc2NxXHSQ6NHPBicLZhH7iBUCoGSK65mwZJb4dl8v7DG+egleUlezbeScvbv/bV4S5RfSQGqvE3wLEFtyEoMtzKVKumZWqzoS2iL6UW2LD31/cfjSaEqhEySOorc8fWnPX8TMSKZeESB0XovZu2gVL98wL+ju5E/8I2lQWsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682480; c=relaxed/simple;
	bh=jW2XOtO9vH3fyORTD0njVKSTagn7WFaKPY/etiNC/h4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QznnVqc//6kQJDf65BzsdX/cDzS6OMl35XnowAWvDZsjdRJGl8Y+Pi66UafwB7XMF4OOu0n8GeGaBrlZkhpwDIAOzm8fsmuWj76DBaKYTFdVDgpMOubpxLokLnWqzz9yFFu9LiMlzfP2PuMKYWxk/fHu9OtaomqVRAntGjW6xnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jFz0y9Eq; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712682479; x=1744218479;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6UmcuCQ72fp6Cahtrj1U+7eJO6P8w7duBJ8wqAOb/u0=;
  b=jFz0y9EqCYW8G5JEI6Qz87iYfppnltnWkj7U+3gYE7mWPICa/nqDbTla
   mwaUckxE/MJZxoJ0XkpC+n1s0Fk3yzbssB+nQepEcnQWLYT6Iwnvk3M6u
   4teRYEdcO4NbZaod8alCkH7xgXqzBjF8C8/m0Nam1CFnZ2XfdLCJ+DQAC
   E=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="717254626"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:07:48 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:47808]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.47.234:2525] with esmtp (Farcaster)
 id 96f2432d-69c8-47ed-9200-5e5da5c63474; Tue, 9 Apr 2024 17:07:46 +0000 (UTC)
X-Farcaster-Flow-ID: 96f2432d-69c8-47ed-9200-5e5da5c63474
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:07:42 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:07:37 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 5/5] virt: vmgenid: add support for devicetree bindings
Date: Tue, 9 Apr 2024 18:07:22 +0100
Message-ID: <20240409170722.81738-1-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Extend the vmgenid platform driver to support devicetree bindings.
With this support, hypervisors can send vmgenid notifications to
the virtual machine without the need to enable ACPI.
The bindings are located at:
Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 3d93e3fb94c4..e1ad74116c0c 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -2,12 +2,13 @@
 /*
  * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
- * The "Virtual Machine Generation ID" is exposed via ACPI and changes when a
+ * The "Virtual Machine Generation ID" is exposed via ACPI or DT and changes when a
  * virtual machine forks or is cloned. This driver exists for shepherding that
  * information to random.c.
  */
 
 #include <linux/acpi.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
@@ -20,6 +21,7 @@ enum { VMGENID_SIZE = 16 };
 struct vmgenid_state {
 	u8 *next_id;
 	u8 this_id[VMGENID_SIZE];
+	int irq;
 };
 
 static void vmgenid_notify(struct device *device)
@@ -43,6 +45,14 @@ vmgenid_acpi_handler(acpi_handle __always_unused handle,
 	vmgenid_notify(dev);
 }
 
+static __maybe_unused irqreturn_t
+vmgenid_of_irq_handler(int __always_unused irq, void *dev)
+{
+	vmgenid_notify(dev);
+
+	return IRQ_HANDLED;
+}
+
 static int __maybe_unused
 setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 {
@@ -106,6 +116,35 @@ static int vmgenid_add_acpi(struct device __maybe_unused *dev,
 #endif
 }
 
+static int vmgenid_add_of(struct platform_device *pdev,
+			  struct vmgenid_state *state)
+{
+	u8 *virt_addr;
+	int ret = 0;
+
+	virt_addr = (u8 *)devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(virt_addr))
+		return PTR_ERR(virt_addr);
+
+	ret = setup_vmgenid_state(state, virt_addr);
+	if (ret)
+		return ret;
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
+	state->irq = ret;
+	pdev->dev.driver_data = state;
+
+	ret = devm_request_irq(&pdev->dev, state->irq, vmgenid_of_irq_handler,
+			       IRQF_SHARED, "vmgenid", &pdev->dev);
+	if (ret)
+		pdev->dev.driver_data = NULL;
+
+	return ret;
+}
+
 static int vmgenid_add(struct platform_device *pdev)
 {
 	struct vmgenid_state *state;
@@ -116,7 +155,10 @@ static int vmgenid_add(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	ret = vmgenid_add_acpi(dev, state);
+	if (dev->of_node)
+		ret = vmgenid_add_of(pdev, state);
+	else
+		ret = vmgenid_add_acpi(dev, state);
 
 	if (ret)
 		devm_kfree(dev, state);
@@ -124,6 +166,12 @@ static int vmgenid_add(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id vmgenid_of_ids[] = {
+	{ .compatible = "microsoft,vmgenid", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
+
 static const struct acpi_device_id vmgenid_acpi_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
@@ -136,6 +184,7 @@ static struct platform_driver vmgenid_plaform_driver = {
 	.driver     = {
 		.name   = "vmgenid",
 		.acpi_match_table = vmgenid_acpi_ids,
+		.of_match_table = vmgenid_of_ids,
 	},
 };
 
-- 
2.34.1


