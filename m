Return-Path: <linux-kernel+bounces-137462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 143FD89E276
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BB50B23EE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA5A156C50;
	Tue,  9 Apr 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qWLNTnOS"
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDE4C85;
	Tue,  9 Apr 2024 18:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687065; cv=none; b=l+1rcCCCAuicuPeh/zhShtdSGO69QvC2cYo2Mr1Sswg+Uvfh1JpVaKQrIg4209e9Ro6RcvqzqzaCa1ARU+VQbV0IR6ANBXoYs7qJZ+/PvNdcSnbAubvnC6puzqEJi2dti1nbnD+BSlUSwYHkDASOjq5BhXJblmpDLnUFE48yVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687065; c=relaxed/simple;
	bh=jW2XOtO9vH3fyORTD0njVKSTagn7WFaKPY/etiNC/h4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxKHWbxQ5WLXtT+XnK1bDX8vboSJ74TnJPVOGZuYBFR6jcSXGiw5+ez5vq6I5CKuuLhtbHHfvzKOfi5muEZVnl7CyvLsJ4c+skDUUvG5PBJI/Uj1Ekl1SRWTn3QZqxp7ews3Fvvtu8N8AIwFmiWRob7XgJ8AUBtzmc0KyDUYgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qWLNTnOS; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712687064; x=1744223064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6UmcuCQ72fp6Cahtrj1U+7eJO6P8w7duBJ8wqAOb/u0=;
  b=qWLNTnOSCUj3nb9ZIXaXZfm8XXhMQQsc5IJ8Q+ITs1CQ92S+dzXnPgAd
   GD3SEKPj9mO8RqhcdxjDkWEUex8DiaN/1HSnZylJS7swpvVR2W6u2ng5q
   ap1Wepp1cLH0LTMq0Hz3aNXuttv0SRS0YH8HttZUDVv2Nn/tTTMG/55Sx
   k=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="197485460"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:14:15 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.10.100:64023]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.25.48:2525] with esmtp (Farcaster)
 id 916869e4-5faf-4241-98ad-4ec9d41da4dc; Tue, 9 Apr 2024 18:14:13 +0000 (UTC)
X-Farcaster-Flow-ID: 916869e4-5faf-4241-98ad-4ec9d41da4dc
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:14:13 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:14:08 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 5/5] virt: vmgenid: add support for devicetree bindings
Date: Tue, 9 Apr 2024 19:11:54 +0100
Message-ID: <20240409181154.9962-6-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240409181154.9962-1-sudanl@amazon.com>
References: <20240409181154.9962-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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


