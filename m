Return-Path: <linux-kernel+bounces-148110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AC08A7DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9069B2387B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6C17F7F1;
	Wed, 17 Apr 2024 08:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="EGBC7aY4"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92357F483;
	Wed, 17 Apr 2024 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341608; cv=none; b=K7r/BsixFDO5rs3Z1khJqwwd3IcwDenI3YJDezxRtcBYexfmcv366H0bEe56ZEKbypwJ+kX3OvcHgVUDH6I3PVjZZYclPxOZQZDBOCPXIbfBQ/p1OPVAJpF9HnXkTKxMmKMi3oQi4QN51VonUoG37SaPi9eYn0XgphJhq8FYPMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341608; c=relaxed/simple;
	bh=aeQsoJiA5Zhl5sE46uiqvd0MCMMuDd5EP5m4v77YYUM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uPDyXHTfwiyAqnfDsGzrbGzelsovBalFvK7vFQsueFiqLVTo4nD4aHR6X1zdCPa/VefU5UtYAySVLjDp4WF7+XNXp6CmSp7PAp22rgOqIyWNcymtaJtX90Tca2/ARb1f3P7jGnX+YFRMc233fDxOOmb0R8/Lvc/cSfvR10LqxVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=EGBC7aY4; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713341608; x=1744877608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Is0SqiPdgnSdKxAQ4CAcD1EdGItBNL2qVHfHGxen8hA=;
  b=EGBC7aY43D0n2GW1/jtDYLHyPryFl2vnVowuRZbySgYgBAPwUJ+UyEnx
   HtSDZ+4fkf+htkA/nJ6s4uR2QbGHV0rUz04igBuGMKukjTWm4t29z3ij8
   Sm8tN9x+sQYVf3ZqJGiI2Z1SfhA1iVpTaP8pFyEwz6oyVSr30/MUgs4Va
   w=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="390310006"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:13:24 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:7038]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.183:2525] with esmtp (Farcaster)
 id e5e6d236-ee61-447e-9e25-fffe8bdfcd1f; Wed, 17 Apr 2024 08:13:22 +0000 (UTC)
X-Farcaster-Flow-ID: e5e6d236-ee61-447e-9e25-fffe8bdfcd1f
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:22 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:17 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v5 2/5] virt: vmgenid: change implementation to use a platform driver
Date: Wed, 17 Apr 2024 10:12:09 +0200
Message-ID: <20240417081212.99657-3-bchalios@amazon.es>
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

Re-implement vmgenid as a platform driver in preparation
for adding devicetree bindings support in next commits.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
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


