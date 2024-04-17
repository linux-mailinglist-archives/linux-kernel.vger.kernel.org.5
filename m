Return-Path: <linux-kernel+bounces-148347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0848A813F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6609828205D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C8213C689;
	Wed, 17 Apr 2024 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="MgxsYVQJ"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FA128807;
	Wed, 17 Apr 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350617; cv=none; b=Hw0YZTtlFhRQneh7F5hIVqeGbWes0/8NdcShNx65oUEM/51ytKuJ3iTtMhnMgXSBO95fv7PFm2zPEpzMCcdMi+Y1jpxntZRKeN8y5L8X/fh0YqxrD5vKdO1NB7Rf3V4qR/ro7mhxTapEp+6/G9JegchizeKzDMlvxYd+BuNbpcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350617; c=relaxed/simple;
	bh=mJml5qWfZ8nlSFywTk/ONcwzQZz8heZFKS7gzIVI5lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCWZIc8Xm0TxEdsyMAIgAyxsVGezr3JhB2GAUO1kzWup4xt/VlNkhdMEo6vi6fCBQRYvL7gQX0d+NtE6IP8vvEAnJDLqtUUFnqDOLVggGc91ekJwyJH2Aq0wALouJJ/FqsF5OtP/DCTJNwWOgKi5dTgtjdRVj+YB0Ph0ziVWlgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=MgxsYVQJ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713350616; x=1744886616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pB206NtwaUbEhMjjil9wyDcA6enkKxcWAv9suS66OrY=;
  b=MgxsYVQJQ/J/ePGhIM3bOs6VCPFgrYCtsk/vDjGmUbq19fWFtEfNrGaY
   z8nB34vLkj0L9f0vTyuj/NBu7R7b7OkpS+O4l8Bl0kHiy1JZZI98mlk3G
   iLTnCk3/gpttygJm6QIXhapUZXimp8sSfszMIGy44g0VP1JUwp1M09msE
   o=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="652567382"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:43:32 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:48862]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.183:2525] with esmtp (Farcaster)
 id 9ad80e1d-3dc3-45c1-bbdc-8f35e4f070b7; Wed, 17 Apr 2024 10:43:30 +0000 (UTC)
X-Farcaster-Flow-ID: 9ad80e1d-3dc3-45c1-bbdc-8f35e4f070b7
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:43:30 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.106.83.20) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:43:25 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>, Alexander Graf
	<graf@amazon.com>
Subject: [PATCH v6 5/5] virt: vmgenid: add support for devicetree bindings
Date: Wed, 17 Apr 2024 12:40:46 +0200
Message-ID: <20240417104046.27253-6-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417104046.27253-1-bchalios@amazon.es>
References: <20240417104046.27253-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

Extend the vmgenid platform driver to support devicetree bindings.
With this support, hypervisors can send vmgenid notifications to
the virtual machine without the need to enable ACPI.
The bindings are located at:
Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

Co-authored-by: Sudan Landge <sudanl@amazon.com>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 3d93e3fb94c4..9a3c12e5dd6e 100644
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
 
+static irqreturn_t
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
2.40.1


