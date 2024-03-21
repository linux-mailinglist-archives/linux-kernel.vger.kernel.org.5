Return-Path: <linux-kernel+bounces-109605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF28881B52
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF95B223A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC33F79C8;
	Thu, 21 Mar 2024 02:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kaowWn/i"
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D897462;
	Thu, 21 Mar 2024 02:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989507; cv=none; b=sWDFxshraz8PJC72DkI5/863GnDmMVPPxoJaqnkCUq8bXXnuHiQ/YraYmRRgsbSHWYQJhKG+vY6fz2WTLgC5lRbmP5BKRxKjzmutrMfYIN5uRtHUQZ+CF3cmeS2LzErW0u6en4Yd38/9CawJdxVzpVgcAJVTHyyi8aCgrytRhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989507; c=relaxed/simple;
	bh=Ne9uSAiMJaLyo2UxKCXKDjH6mIO6I4ya4u4Kl+S6IOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9huebblMhub1Hg2inry5hZ/ROJTGc/9CJiJvzSMlWpggP0JqSUJH6OrLxI0nY57ReE+Gw5HLzDiOxhHBDoQk5ukklgIqGeDwgX0HeKMlj87NPPSdl2zdAc7gT7piLiBm62RAh6gEuzfDtYmYSy54FvQri2Gfg8Se2g9JYxeInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kaowWn/i; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710989507; x=1742525507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7lsFF7Jt7Wx4QuN10hvG9q2YtU3jwzHcLdTM8DXudE=;
  b=kaowWn/iq2QpxcsuPiuvOBwjlB1KO28ODAnz+3jOlhgoGnZFd1esyOa3
   6fzZDvVrCAKuyMB+KFwK0q4kltOBh23I+FCQQFVbwjFJVbpg3Z5cxe5vs
   JvcZVrrZwLQZeMpQ2fe+ZOwE/5dPvkBUCBkrVRhpF0i+yzQUc+oB76xMF
   w=;
X-IronPort-AV: E=Sophos;i="6.07,141,1708387200"; 
   d="scan'208";a="334143291"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 02:51:39 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:18408]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.123:2525] with esmtp (Farcaster)
 id 927bfbc6-a8a5-4bb7-a8da-9035a6125689; Thu, 21 Mar 2024 02:51:37 +0000 (UTC)
X-Farcaster-Flow-ID: 927bfbc6-a8a5-4bb7-a8da-9035a6125689
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:37 +0000
Received: from bcd074994f7f.amazon.com (10.106.82.23) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:32 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v2 4/4] virt: vmgenid: add support for devicetree bindings
Date: Thu, 21 Mar 2024 02:51:05 +0000
Message-ID: <20240321025105.53210-5-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240321025105.53210-1-sudanl@amazon.com>
References: <20240321025105.53210-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

- Extend the vmgenid platform driver to support devicetree bindings.
  With this support, hypervisors can send vmgenid notifications to
  the virtual machine without the need to enable ACPI. The bindings
  are located at: Documentation/devicetree/bindings/rng/vmgenid.yaml

- Use proper FLAGS to compile with and without ACPI and/or devicetree.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/Kconfig   |   2 +-
 drivers/virt/vmgenid.c | 106 ++++++++++++++++++++++++++++++++++++++---
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..4f33ee2f0372 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -16,7 +16,7 @@ if VIRT_DRIVERS
 config VMGENID
 	tristate "Virtual Machine Generation ID driver"
 	default y
-	depends on ACPI
+	depends on (ACPI || OF)
 	help
 	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
 	  to reseed the RNG when the VM is cloned. This is highly recommended if
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index d5394c706bd9..ec378c37a2a2 100644
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
@@ -13,14 +13,27 @@
 #include <linux/random.h>
 #include <acpi/actypes.h>
 #include <linux/platform_device.h>
-
+#ifdef CONFIG_OF
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#endif
+
+#ifdef CONFIG_ACPI
 ACPI_MODULE_NAME("vmgenid");
+#endif
 
 enum { VMGENID_SIZE = 16 };
 
 struct vmgenid_state {
 	u8 *next_id;
 	u8 this_id[VMGENID_SIZE];
+#ifdef CONFIG_OF
+	unsigned int irq;
+#endif
 };
 
 static void vmgenid_notify(struct device *device)
@@ -37,10 +50,24 @@ static void vmgenid_notify(struct device *device)
 	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
 }
 
+#ifdef	CONFIG_ACPI
 static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
 {
+	(void)handle;
+	(void)event;
 	vmgenid_notify(dev);
 }
+#endif
+
+#ifdef	CONFIG_OF
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
@@ -55,6 +82,7 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 
 static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 {
+#ifdef	CONFIG_ACPI
 	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
 	union acpi_object *obj;
@@ -96,6 +124,54 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
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
+static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
+{
+#ifdef	CONFIG_OF
+	struct resource res;
+	int ret = 0;
+
+	if (of_address_to_resource(dev->of_node, 0, &res)) {
+		dev_err(dev, "Failed to get resources from device tree");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (!__request_mem_region(res.start, resource_size(&res),
+				  "vmgenid", IORESOURCE_EXCLUSIVE)) {
+		dev_err(dev, "Failed to request mem region");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = setup_vmgenid_state(state, (u8 *)of_iomap(dev->of_node, 0));
+	if (ret)
+		goto out;
+
+	state->irq = irq_of_parse_and_map(dev->of_node, 0);
+	dev->driver_data = state;
+
+	if (request_irq(state->irq, vmgenid_of_irq_handler,
+			IRQF_SHARED, "vmgenid", dev) < 0) {
+		dev_err(dev, "request_irq failed");
+		dev->driver_data = NULL;
+		ret = -EINVAL;
+		goto out;
+	}
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
@@ -108,7 +184,10 @@ static int vmgenid_add(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	ret = vmgenid_add_acpi(dev, state);
+	if (dev->of_node)
+		ret = vmgenid_add_of(dev, state);
+	else
+		ret = vmgenid_add_acpi(dev, state);
 
 	if (ret)
 		devm_kfree(dev, state);
@@ -116,18 +195,33 @@ static int vmgenid_add(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct acpi_device_id vmgenid_ids[] = {
+#ifdef	CONFIG_OF
+static const struct of_device_id vmgenid_of_ids[] = {
+	{ .compatible = "linux,vmgenctr", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
+#endif
+
+#ifdef	CONFIG_ACPI
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
+#ifdef	CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
+#endif
+#ifdef	CONFIG_OF
+		.of_match_table = vmgenid_of_ids,
+#endif
 		.owner = THIS_MODULE,
 	},
 };
-- 
2.40.1



