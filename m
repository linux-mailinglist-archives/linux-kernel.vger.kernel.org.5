Return-Path: <linux-kernel+bounces-150048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79C8A999E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39A321F22519
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE00C15FD01;
	Thu, 18 Apr 2024 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="edwjgr6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9215FA76;
	Thu, 18 Apr 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442416; cv=none; b=ni8+qd2W3oU1vCcKxoTaNLFEcU4fPkW8Opys+RHzoyONj+j65NEeRckQw8AEd3S6wuZegithRQe/Z2NQ9gb3pH1ZkaSVOQ3/pUEmT4Jvf9YkBdsAYNs/a++qvNELAAI8Wa8Wip1hRcw6J/2pm7zwPKpcOriwI1/3KjWjO08PaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442416; c=relaxed/simple;
	bh=VQUJGeeRWUloAWWB1Hyejv1PGZzE7T5/iKqrDFVIZDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D56dhTwmbySM8wMF2qOLkmFdxUL/FS83wGAYs8ynkTZFdmNgcYVml7jo24ckJmzABvrcwO45gJam1B0pgAJL7f1JjEPgKUk5oL+JB1AerXctqGDK+KmYGgDOdctqKAE8I5+GLCEuOreA5hcNtlbeEJVNgSS0rZ7LJ+D/gtFHmgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=edwjgr6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BE6C2BD11;
	Thu, 18 Apr 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="edwjgr6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713442413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aq6JxSnWT2dRtETeeOa/f63j90uhZ8kS0pFZ3RGL2y8=;
	b=edwjgr6EnEXfAJpSfhxKoISY47u6S9LNTNfxb7wqGAHku9KcROKgQty+HaL2+s5GqU7R5j
	OwO7vmerWfA+m5BQAX/n7leXDYH4JdcHWUAB9jj5blEJNGF/KfG3S4qsbcjvuP6jTVN1Tg
	Ok1fW9K6R/BZmkDK199QbBwZv00h+HE=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81429b10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:33 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: tytso@mit.edu,
	robh@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sudanl@amazon.com,
	graf@amazon.com,
	dwmw@amazon.co.uk,
	krzysztof.kozlowski@linaro.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7 3/3] virt: vmgenid: add support for devicetree bindings
Date: Thu, 18 Apr 2024 14:12:32 +0200
Message-ID: <20240418121249.42380-4-Jason@zx2c4.com>
In-Reply-To: <20240418121249.42380-1-Jason@zx2c4.com>
References: <20240418121249.42380-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudan Landge <sudanl@amazon.com>

Extend the vmgenid platform driver to support devicetree bindings. With
this support, hypervisors can send vmgenid notifications to the virtual
machine without the need to enable ACPI. The bindings are located at:
Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml

Since this makes the driver work for both ACPI and devicetree, adjust
the Kconfig to include `|| OF`, which in turn means accounting for
!CONFIG_ACPI in the code with a short ifdef.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
[Jason: - Small style cleanups and refactoring.
        - Fold in Kconfig OF dependency and ACPI conditionalization. ]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/Kconfig   |  2 +-
 drivers/virt/vmgenid.c | 53 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..017d6c38c3ba 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -16,7 +16,7 @@ if VIRT_DRIVERS
 config VMGENID
 	tristate "Virtual Machine Generation ID driver"
 	default y
-	depends on ACPI
+	depends on ACPI || OF
 	help
 	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
 	  to reseed the RNG when the VM is cloned. This is highly recommended if
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index aebbd24512c9..7f2d1e5656df 100644
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
@@ -41,6 +42,7 @@ static void setup_vmgenid_state(struct vmgenid_state *state, void *virt_addr)
 	add_device_randomness(state->this_id, sizeof(state->this_id));
 }
 
+#ifdef CONFIG_ACPI
 static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
 				 u32 __always_unused event, void *dev)
 {
@@ -92,6 +94,43 @@ static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
 	ACPI_FREE(parsed.pointer);
 	return ret;
 }
+#else
+static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
+{
+	return -EINVAL;
+}
+#endif
+
+static irqreturn_t vmgenid_of_irq_handler(int __always_unused irq, void *dev)
+{
+	vmgenid_notify(dev);
+	return IRQ_HANDLED;
+}
+
+static int vmgenid_add_of(struct platform_device *pdev,
+			  struct vmgenid_state *state)
+{
+	void *virt_addr;
+	int ret;
+
+	virt_addr = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
+	if (IS_ERR(virt_addr))
+		return PTR_ERR(virt_addr);
+
+	setup_vmgenid_state(state, virt_addr);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, ret, vmgenid_of_irq_handler,
+			       IRQF_SHARED, "vmgenid", &pdev->dev);
+	if (ret)
+		return ret;
+
+	pdev->dev.driver_data = state;
+	return 0;
+}
 
 static int vmgenid_add(struct platform_device *pdev)
 {
@@ -103,13 +142,22 @@ static int vmgenid_add(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	ret = vmgenid_add_acpi(dev, state);
+	if (dev->of_node)
+		ret = vmgenid_add_of(pdev, state);
+	else
+		ret = vmgenid_add_acpi(dev, state);
 
 	if (ret)
 		devm_kfree(dev, state);
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
@@ -122,6 +170,7 @@ static struct platform_driver vmgenid_plaform_driver = {
 	.driver     = {
 		.name   = "vmgenid",
 		.acpi_match_table = vmgenid_acpi_ids,
+		.of_match_table = vmgenid_of_ids,
 	},
 };
 
-- 
2.44.0


