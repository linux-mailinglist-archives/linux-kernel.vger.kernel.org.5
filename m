Return-Path: <linux-kernel+bounces-148343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7808A8134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 417B6B22A27
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24D013C69C;
	Wed, 17 Apr 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="qecQsEqq"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9E13C679;
	Wed, 17 Apr 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350538; cv=none; b=RM8HqHhp7ddGI+IjMRJNe8XnvERRJlgDX6GYg5dlJ/W0JlilYqWQG4bdIesw8Y+7dTdx36K3ny36wW8fjr/pKKZfDGnEuVzM/80+iHvT9SSFGzv6aPzYEC52atZUlR1DZifioknLFYkpOQksqULCvnTJUILUaQQ3AkT8VMvF+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350538; c=relaxed/simple;
	bh=w6juo0MjmFUn9ztBY4kfUx8g9rHFcR0V1lypBjU9/dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdazL4HmGKHFqZd5JouxR710BKKXnpSnNQvYuDSmPl6Nd8WoItOtywt0gR9qAc2zYWdIijoQ5x1qmVK8eI93OnA/Wk02D+qajwmkTmcMqCNlBeUrc15eqjMiAPTify5uNIjawJG/wGaLpKZx/zWPo3Wi3LJZlkrUM+MelhegbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=qecQsEqq; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713350537; x=1744886537;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=me+iH+3ZKIOFJvRC7r+x77iYDHFJHkAOYcVbZdp3q/g=;
  b=qecQsEqqzWrJdPdhRik9HYsX7rlPy3KfGPcbq/8Ce7L5WutHetI2gU1t
   V+GSYyizTllYvQ2v88YZqkkVJJIDhDkfcPgAwLakpdUOAGiugjflF1HZh
   uQlGeiYFKwKwL9YzyflZoZ9W38z6vVR4MrODTwWn7JGinUZ6l7AE7OU3a
   s=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="81958131"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:42:14 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:37894]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.5.68:2525] with esmtp (Farcaster)
 id 68181eed-a4a4-48e3-a5e7-993b8cc1a4e1; Wed, 17 Apr 2024 10:42:13 +0000 (UTC)
X-Farcaster-Flow-ID: 68181eed-a4a4-48e3-a5e7-993b8cc1a4e1
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:42:13 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.106.83.20) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:42:07 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>, Alexander Graf
	<graf@amazon.com>
Subject: [PATCH v6 2/5] virt: vmgenid: change implementation to use a platform driver
Date: Wed, 17 Apr 2024 12:40:43 +0200
Message-ID: <20240417104046.27253-3-bchalios@amazon.es>
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

Re-implement vmgenid as a platform driver in preparation
for adding devicetree bindings support in next commits.

Co-authored-by: Sudan Landge <sudanl@amazon.com>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/vmgenid.c | 97 +++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index a167ccfad299..c028e2064fdd 100644
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
@@ -21,9 +22,9 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
+static void vmgenid_notify(struct device *device)
 {
-	struct vmgenid_state *state = acpi_driver_data(device);
+	struct vmgenid_state *state = device->driver_data;
 	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
@@ -32,21 +33,36 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
-	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
+	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
+}
+
+static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
+				 u32 __always_unused event, void *dev)
+{
+	vmgenid_notify(dev);
+}
+
+static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
+{
+	if (IS_ERR(next_id))
+		return PTR_ERR(next_id);
+
+	state->next_id = next_id;
+	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
+	add_device_randomness(state->this_id, sizeof(state->this_id));
+	return 0;
 }
 
-static int vmgenid_add(struct acpi_device *device)
+static int vmgenid_add_acpi(struct device *dev,
+			    struct vmgenid_state *state)
 {
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
-	struct vmgenid_state *state;
 	union acpi_object *obj;
 	phys_addr_t phys_addr;
 	acpi_status status;
 	int ret = 0;
-
-	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
+	u8 *virt_addr;
 
 	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
@@ -63,40 +79,61 @@ static int vmgenid_add(struct acpi_device *device)
 
 	phys_addr = (obj->package.elements[0].integer.value << 0) |
 		    (obj->package.elements[1].integer.value << 32);
-	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
-	if (IS_ERR(state->next_id)) {
-		ret = PTR_ERR(state->next_id);
+
+	virt_addr = (u8 *)devm_memremap(&device->dev, phys_addr,
+					VMGENID_SIZE, MEMREMAP_WB);
+	ret = setup_vmgenid_state(state, virt_addr);
+	if (ret)
+		goto out;
+
+	dev->driver_data = state;
+	status = acpi_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+					     vmgenid_acpi_handler, dev);
+	if (ACPI_FAILURE(status)) {
+		dev_err(dev, "Failed to install acpi notify handler");
+		ret = -ENODEV;
+		dev->driver_data = NULL;
 		goto out;
 	}
+out:
+	ACPI_FREE(parsed.pointer);
+	return ret;
+}
 
-	memcpy(state->this_id, state->next_id, sizeof(state->this_id));
-	add_device_randomness(state->this_id, sizeof(state->this_id));
+static int vmgenid_add(struct platform_device *pdev)
+{
+	struct vmgenid_state *state;
+	struct device *dev = &pdev->dev;
+	int ret = 0;
 
-	device->driver_data = state;
+	state = devm_kmalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	ret = vmgenid_add_acpi(dev, state);
+
+	if (ret)
+		devm_kfree(dev, state);
 
-out:
-	ACPI_FREE(parsed.pointer);
 	return ret;
 }
 
-static const struct acpi_device_id vmgenid_ids[] = {
+static const struct acpi_device_id vmgenid_acpi_ids[] = {
 	{ "VMGENCTR", 0 },
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
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
 
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
 MODULE_LICENSE("GPL v2");
-- 
2.40.1


