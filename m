Return-Path: <linux-kernel+bounces-150046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AC8A999A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944AA1F2255C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB2015FA89;
	Thu, 18 Apr 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JXgOeqo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD715CD6D;
	Thu, 18 Apr 2024 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713442403; cv=none; b=DjLKcdbXYsnXO5gFfMr4SNoD5MEDLEZQnMit69ehylzxq3nuyGmlp2joVfmrFJDs/vDFqScE3sOVSP33EmT6KYcByyj4CHBO+Xe5x2DKObJcxFvtY3x5Iba5QCjKU2j3TsK78PKynTo17YMV+cuPGs5rx0OsNv7i+EPBSLcqo0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713442403; c=relaxed/simple;
	bh=t/3x9YvwBgeGmtfyzNrlEkhf5PPJrI/KNYc7npUqxro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/a/0b6dlTrSUHbCSRiQCFg6YvBCtWBBnZnvySTDDmlrzpPKyet5Sk67WYWdWRBz4E+LTPQ7P4+T1sUbGaask2qW+pyqvjKEKqKLbzLsmhsERvjk1hkpPEPFWK2e5sdUGtB6XI0fnflFu8P+lxFve1A++emYTNHX+iYmXmWKJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=JXgOeqo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC7BC2BD11;
	Thu, 18 Apr 2024 12:13:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JXgOeqo1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1713442400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYdtdVBdKQeCcimrRJ83g62GTKmsxlDxFsEgHkC3E4w=;
	b=JXgOeqo1SOQWKX4vu30f/hU75KMK1tYGpPcJqrF7XwKKIhJ3UcW+WbskoOS3A2u6/xjmZW
	I8BVN9q72bEbghS5GsjHBUKNfTqrBYf48P22KL2tNSgUkrCtMoOpvQVyCvf4EJoPOTkuSb
	XWU4R3E2qcMuq3pH5N7v9ebMvWfiFGA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f0ba801 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Apr 2024 12:13:19 +0000 (UTC)
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
Subject: [PATCH v7 1/3] virt: vmgenid: change implementation to use a platform driver
Date: Thu, 18 Apr 2024 14:12:30 +0200
Message-ID: <20240418121249.42380-2-Jason@zx2c4.com>
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

Re-implement vmgenid as a platform driver in preparation for adding
devicetree bindings support in next commits.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
[Jason: - Small style cleanups and refactoring.]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/vmgenid.c | 99 +++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a1c467a0e9f7..aebbd24512c9 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -7,9 +7,10 @@
  * information to random.c.
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <linux/random.h>
 
 ACPI_MODULE_NAME("vmgenid");
@@ -21,19 +22,41 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
-static int vmgenid_add(struct acpi_device *device)
+static void vmgenid_notify(struct device *device)
+{
+	struct vmgenid_state *state = device->driver_data;
+	u8 old_id[VMGENID_SIZE];
+
+	memcpy(old_id, state->this_id, sizeof(old_id));
+	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
+	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
+		return;
+	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+}
+
+static void setup_vmgenid_state(struct vmgenid_state *state, void *virt_addr)
 {
+	state->next_id = virt_addr;
+	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
+	add_device_randomness(state->this_id, sizeof(state->this_id));
+}
+
+static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
+				 u32 __always_unused event, void *dev)
+{
+	vmgenid_notify(dev);
+}
+
+static int vmgenid_add_acpi(struct device *dev, struct vmgenid_state *state)
+{
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
-	struct vmgenid_state *state;
 	union acpi_object *obj;
 	phys_addr_t phys_addr;
 	acpi_status status;
+	void *virt_addr;
 	int ret = 0;
 
-	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
 	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
@@ -49,53 +72,61 @@ static int vmgenid_add(struct acpi_device *device)
 
 	phys_addr = (obj->package.elements[0].integer.value << 0) |
 		    (obj->package.elements[1].integer.value << 32);
-	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
-	if (IS_ERR(state->next_id)) {
-		ret = PTR_ERR(state->next_id);
+
+	virt_addr = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
+	if (IS_ERR(virt_addr)) {
+		ret = PTR_ERR(virt_addr);
 		goto out;
 	}
+	setup_vmgenid_state(state, virt_addr);
 
-	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
-	add_device_randomness(state->this_id, sizeof(state->this_id));
-
-	device->driver_data = state;
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					     vmgenid_acpi_handler, dev);
+	if (ACPI_FAILURE(status)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
+	dev->driver_data = state;
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
 }
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
+static int vmgenid_add(struct platform_device *pdev)
 {
-	struct vmgenid_state *state = acpi_driver_data(device);
-	u8 old_id[VMGENID_SIZE];
+	struct vmgenid_state *state;
+	struct device *dev = &pdev->dev;
+	int ret = 0;
 
-	memcpy(old_id, state->this_id, sizeof(old_id));
-	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
-	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
-		return;
-	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	ret = vmgenid_add_acpi(dev, state);
+
+	if (ret)
+		devm_kfree(dev, state);
+	return ret;
 }
 
-static const struct acpi_device_id vmgenid_ids[] = {
+static const struct acpi_device_id vmgenid_acpi_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
 };
-
-static struct acpi_driver vmgenid_driver = {
-	.name = "vmgenid",
-	.ids = vmgenid_ids,
-	.owner = THIS_MODULE,
-	.ops = {
-		.add = vmgenid_add,
-		.notify = vmgenid_notify
-	}
+MODULE_DEVICE_TABLE(acpi, vmgenid_acpi_ids);
+
+static struct platform_driver vmgenid_plaform_driver = {
+	.probe      = vmgenid_add,
+	.driver     = {
+		.name   = "vmgenid",
+		.acpi_match_table = vmgenid_acpi_ids,
+	},
 };
 
-module_acpi_driver(vmgenid_driver);
+module_platform_driver(vmgenid_plaform_driver)
 
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.44.0


