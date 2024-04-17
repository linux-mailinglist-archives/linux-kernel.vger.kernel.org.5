Return-Path: <linux-kernel+bounces-148114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 384938A7DE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A7D283D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3471B7D412;
	Wed, 17 Apr 2024 08:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="H8AGONsh"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6547D08D;
	Wed, 17 Apr 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341676; cv=none; b=r9yaUGf05yxygwL2UKaN1FY3mcCGMq83VCk81Kw08pDH8wl6YA4Eje3N1b39oTsOup3bLlyHKNDA14peLWo/N+EJe71wfglsHcEK8gN3cwiklDhU7g3B2hZx18fFesAqAahI+5aI1TIuu3qYR+SnoqbaqU9awW5IYBzfZwQOj38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341676; c=relaxed/simple;
	bh=RFVneludFe2+XpZNeCT2h0o45mdVjvhm/vgG6KqTxBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/VKWQTdTwsa5o1RAd2Tmskk8PZMUQkX9NE81751vCa4Ubr8iTCNLo07pDW91nPAfaANCwYHwyU/ELyVOFFmGsX+DHAKD5RzDyRGg16a9iUcKlb5kmJ0tL8zSYYZsZxh7knswbOmgGGTSS+2yhsdpbdlwSyA9VIkJ9ciq9ZsFoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=H8AGONsh; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713341676; x=1744877676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDgtpC4FCgvL30shNxDeWu8nTK8GNg2wg+736xsm1ao=;
  b=H8AGONshGmkPtu0G136fHGTMqSBQcHm9m7MoB/A4YoWCT74niD1AIIRM
   T+t4Tbm+PPoKxK9lgTW0Kkbw00D0xxSYsEf398Y78AO8zynlj9bcVCbwu
   6N9eqUeNt9M1rkShosi+lwGj/pK8Y3Oof3LzK38qewuuO8SgzMhFViwf3
   0=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="339280674"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:14:27 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.10.100:22007]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.2.180:2525] with esmtp (Farcaster)
 id 944d4460-6106-433e-96cb-d9d5f678fd46; Wed, 17 Apr 2024 08:14:25 +0000 (UTC)
X-Farcaster-Flow-ID: 944d4460-6106-433e-96cb-d9d5f678fd46
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:14:25 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:14:19 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v5 5/5] virt: vmgenid: add support for devicetree bindings
Date: Wed, 17 Apr 2024 10:12:12 +0200
Message-ID: <20240417081212.99657-6-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417081212.99657-1-bchalios@amazon.es>
References: <20240417081212.99657-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

From: Sudan Landge <sudanl@amazon.com>

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


