Return-Path: <linux-kernel+bounces-117859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84488B08E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B531FA3D64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2ED54E1AD;
	Mon, 25 Mar 2024 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IsrbFAkm"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573B4AEEF;
	Mon, 25 Mar 2024 19:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396436; cv=none; b=uTkBMmy3ObVMfhtLeC/4+3s1m0cVJYNeXHcdwDVnHC4cGlwb2iWz9Q6UbfKA98HuuqjTgtmdE32orneTdbkDZa2/4qwrPg+dlRSOo8cSfgQdbuYO2OoLNMNpG/c2j4R1JpKzki06Ktek0T16NGVKv5I1YFOfLSSYJieRgJuzpBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396436; c=relaxed/simple;
	bh=++m9N0MCieE6cSYPHOMl1yqT3JI/VESso5nM1BQnBe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5K0OytHh4/nL7Sckk8CfMiS1HfKVI9+W9sHmQ7mJLBJ5LOj2EPDB4Lvf4KboTG3PoVN+DD1E7MEOu4MKOY2pu+odQFwaZAYI3fNk6evRyQCfoqsm/FmeRqNJ7ZmLrbond4SUl7Ixd/YYU6nri+d7yA5L/uZE1kcZugokIKf5MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IsrbFAkm; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711396435; x=1742932435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9tccM5MnneqoFu3JC/qRsGHXetyTwu2/OTI1HpvUe7k=;
  b=IsrbFAkmNZEyvt/oJJQV/qpt68SwRdptgJ9qf52BWnJu3hjAFmn+yYvM
   yMIlI/9d+VcLc0KA6eS5MX+H7p0RGi3xQ4Nl/UT2mi61VD05uOTTGLZ+D
   JAp+Oa09VlWEHe7fmsOFKp4dI6NQelBmiag9Cda9PWAHhr/R3so3KAK5H
   0=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="335105095"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:53:48 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:36564]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.33.239:2525] with esmtp (Farcaster)
 id 76e9f19c-adbd-4c42-aecc-51f4614478ad; Mon, 25 Mar 2024 19:53:46 +0000 (UTC)
X-Farcaster-Flow-ID: 76e9f19c-adbd-4c42-aecc-51f4614478ad
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:45 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:40 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v3 4/4] virt: vmgenid: add support for devicetree bindings
Date: Mon, 25 Mar 2024 19:53:06 +0000
Message-ID: <20240325195306.13133-5-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240325195306.13133-1-sudanl@amazon.com>
References: <20240325195306.13133-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

- Extend the vmgenid platform driver to support devicetree bindings.
  With this support, hypervisors can send vmgenid notifications to
  the virtual machine without the need to enable ACPI. The bindings
  are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml

- Use proper FLAGS to compile with and without ACPI and/or devicetree.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/Kconfig   |  1 -
 drivers/virt/vmgenid.c | 85 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 80 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..d8c848cf09a6 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -16,7 +16,6 @@ if VIRT_DRIVERS
 config VMGENID
 	tristate "Virtual Machine Generation ID driver"
 	default y
-	depends on ACPI
 	help
 	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
 	  to reseed the RNG when the VM is cloned. This is highly recommended if
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index d5394c706bd9..a648465bea43 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  *
- * The "Virtual Machine Generation ID" is exposed via ACPI and changes when a
+ * The "Virtual Machine Generation ID" is exposed via ACPI or DT and changes when a
  * virtual machine forks or is cloned. This driver exists for shepherding that
  * information to random.c.
  */
@@ -21,6 +21,7 @@ enum { VMGENID_SIZE = 16 };
 struct vmgenid_state {
 	u8 *next_id;
 	u8 this_id[VMGENID_SIZE];
+	unsigned int irq;
 };
 
 static void vmgenid_notify(struct device *device)
@@ -37,10 +38,24 @@ static void vmgenid_notify(struct device *device)
 	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
 }
 
+#if IS_ENABLED(CONFIG_ACPI)
 static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
 {
+	(void)handle;
+	(void)event;
 	vmgenid_notify(dev);
 }
+#endif
+
+#if IS_ENABLED(CONFIG_OF)
+static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
+{
+	(void)irq;
+	vmgenid_notify(dev);
+
+	return IRQ_HANDLED;
+}
+#endif
 
 static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 {
@@ -55,6 +70,7 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 
 static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 {
+#if IS_ENABLED(CONFIG_ACPI)
 	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
 	union acpi_object *obj;
@@ -96,6 +112,49 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
+#else
+	(void)dev;
+	(void)state;
+	return -EINVAL;
+#endif
+}
+
+static int vmgenid_add_of(struct platform_device *pdev, struct vmgenid_state *state)
+{
+#if IS_ENABLED(CONFIG_OF)
+	void __iomem *remapped_ptr;
+	int ret = 0;
+
+	remapped_ptr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(remapped_ptr)) {
+		ret = PTR_ERR(remapped_ptr);
+		goto out;
+	}
+
+	ret = setup_vmgenid_state(state, remapped_ptr);
+	if (ret)
+		goto out;
+
+	state->irq = platform_get_irq(pdev, 0);
+	if (state->irq < 0) {
+		ret = state->irq;
+		goto out;
+	}
+	pdev->dev.driver_data = state;
+
+	ret =  devm_request_irq(&pdev->dev, state->irq,
+				vmgenid_of_irq_handler,
+				IRQF_SHARED, "vmgenid", &pdev->dev);
+	if (ret)
+		pdev->dev.driver_data = NULL;
+
+out:
+	return ret;
+#else
+	(void)dev;
+	(void)state;
+	return -EINVAL;
+#endif
 }
 
 static int vmgenid_add(struct platform_device *pdev)
@@ -108,7 +167,10 @@ static int vmgenid_add(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	ret = vmgenid_add_acpi(dev, state);
+	if (dev->of_node)
+		ret = vmgenid_add_of(pdev, state);
+	else
+		ret = vmgenid_add_acpi(dev, state);
 
 	if (ret)
 		devm_kfree(dev, state);
@@ -116,18 +178,31 @@ static int vmgenid_add(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct acpi_device_id vmgenid_ids[] = {
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id vmgenid_of_ids[] = {
+	{ .compatible = "linux,vmgenctr", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
+#endif
+
+#if IS_ENABLED(CONFIG_ACPI)
+static const struct acpi_device_id vmgenid_acpi_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
+MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
+#endif
 
 static struct platform_driver vmgenid_plaform_driver = {
 	.probe      = vmgenid_add,
 	.driver     = {
 		.name   = "vmgenid",
-		.acpi_match_table = ACPI_PTR(vmgenid_ids),
+		.acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
+#if IS_ENABLED(CONFIG_OF)
+		.of_match_table = vmgenid_of_ids,
+#endif
 		.owner = THIS_MODULE,
 	},
 };
-- 
2.40.1



