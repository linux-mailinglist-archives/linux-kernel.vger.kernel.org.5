Return-Path: <linux-kernel+bounces-107656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F2987FFAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F7F2B21C70
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470765BAA;
	Tue, 19 Mar 2024 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ch96fTbI"
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCCF26AE4;
	Tue, 19 Mar 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858814; cv=none; b=GZmnIjQn9dSs6I/JaoXcvbOOb9c06kvHL2/kKKJU/0AW3txUeU2WKGjTPURz9JEkzn0jeid0GE6cRZYh7mZCpfQ4RymXuLNzvhib407recQJUEb8+hLsViA5bPATvjiL9SRVSINDeMLPMam9PxJszJTPpBG2bP8Alg68Nw2eB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858814; c=relaxed/simple;
	bh=N7UI4zhlk6TZ7w4PYAIRYUE3isb2Sqb8ySQ7KSf3r74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOnC9lPykxfFPwU68v9BmcL8xJWosvDH815miY6KHOTt1/rgVP7mINHsguCZfmZm1RqmI+XeHoL4G3oPu8Hm5EkfwgTH50snR4Oo6y51Sdg5hshhwoevBOYDRwWGwCJJHntrx7mBGATrrJZTmPPxT8ygQxZRfXp1ujBw2kJXCso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ch96fTbI; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710858812; x=1742394812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3PKGxBWhjhu5SQFumdItpK7yL651FBVQmfMVf/J3HOQ=;
  b=ch96fTbIo+IsF9cO//VJB/KqZRUZQTmDQUjspu4EHZKLfUtI3gpa/hW2
   DtgmqHOX7y4qiMzqcaxlyJJuKoPXGzNHZn6NsgmVEt4SpzXKCf3BS+g8q
   e2ucNlhL5a2HCJJaoJCPbT7OzgKgkhaCBwNmhag/WaWJ/VY2xhSGbkYKc
   U=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="645831400"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:33:30 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:61740]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.27.165:2525] with esmtp (Farcaster)
 id bcba8cb4-9acf-49d4-8b36-e70ba6ccbf47; Tue, 19 Mar 2024 14:33:29 +0000 (UTC)
X-Farcaster-Flow-ID: bcba8cb4-9acf-49d4-8b36-e70ba6ccbf47
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:28 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:23 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v1 4/4] virt: vmgenid: add support for devicetree bindings
Date: Tue, 19 Mar 2024 14:32:53 +0000
Message-ID: <20240319143253.22317-5-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240319143253.22317-1-sudanl@amazon.com>
References: <20240319143253.22317-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Extend the vmgenid platform driver to support devicetree bindings.
With this support, hypervisors can send vmgenid notifications to
the virtual machine without the need to enable ACPI.

The bindings are located at:
- Documentation/devicetree/bindings/vmgenid/vmgenid.yaml

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/Kconfig   |  2 +-
 drivers/virt/vmgenid.c | 90 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 86 insertions(+), 6 deletions(-)

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
index e82b344a9d61..96a3ff8ec05a 100644
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
@@ -12,6 +12,12 @@
 #include <linux/acpi.h>
 #include <linux/random.h>
 #include <acpi/actypes.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 
 ACPI_MODULE_NAME("vmgenid");
@@ -21,6 +27,7 @@ enum { VMGENID_SIZE = 16 };
 struct vmgenid_state {
 	u8 *next_id;
 	u8 this_id[VMGENID_SIZE];
+	unsigned int irq;
 };
 
 static void vmgenid_notify(struct device *device)
@@ -42,6 +49,13 @@ static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
 	vmgenid_notify(dev);
 }
 
+static irqreturn_t vmgenid_of_irq_handler(int irq, void *dev)
+{
+	vmgenid_notify(dev);
+
+	return IRQ_HANDLED;
+}
+
 static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 {
 	if (IS_ERR(next_id))
@@ -98,6 +112,43 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 	return ret;
 }
 
+static int vmgenid_add_of(struct device *dev, struct vmgenid_state *state)
+{
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
+	ret = setup_vmgenid_state(state, of_iomap(dev->of_node, 0));
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
+}
+
 static int vmgenid_add(struct platform_device *pdev)
 {
 	struct vmgenid_state *state;
@@ -108,7 +159,10 @@ static int vmgenid_add(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	ret = vmgenid_add_acpi(dev, state);
+	if (dev->of_node)
+		ret = vmgenid_add_of(dev, state);
+	else
+		ret = vmgenid_add_acpi(dev, state);
 
 	if (ret)
 		devm_kfree(dev, state);
@@ -116,7 +170,30 @@ static int vmgenid_add(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct acpi_device_id vmgenid_ids[] = {
+static int vmgenid_remove(struct platform_device *pdev)
+{
+	struct vmgenid_state *state = NULL;
+
+	if (!pdev)
+		return -EINVAL;
+
+	state = pdev->dev.driver_data;
+
+	if (state && pdev->dev.of_node)
+		free_irq(state->irq, &pdev->dev);
+
+	if (state)
+		devm_kfree(&pdev->dev, state);
+
+	return 0;
+}
+
+static const struct of_device_id vmgenid_of_ids[] = {
+	{ .compatible = "linux,vmgenctr", },
+	{},
+};
+
+static const struct acpi_device_id vmgenid_acpi_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
@@ -124,9 +201,11 @@ static const struct acpi_device_id vmgenid_ids[] = {
 
 static struct platform_driver vmgenid_plaform_driver = {
 	.probe      = vmgenid_add,
+	.remove     = vmgenid_remove,
 	.driver     = {
 		.name   = "vmgenid",
-		.acpi_match_table = ACPI_PTR(vmgenid_ids),
+		.acpi_match_table = ACPI_PTR(vmgenid_acpi_ids),
+		.of_match_table = vmgenid_of_ids,
 		.owner = THIS_MODULE,
 	},
 };
@@ -144,7 +223,8 @@ static void vmgenid_platform_device_exit(void)
 module_init(vmgenid_platform_device_init)
 module_exit(vmgenid_platform_device_exit)
 
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
+MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
+MODULE_DEVICE_TABLE(of, vmgenid_of_ids);
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.40.1



