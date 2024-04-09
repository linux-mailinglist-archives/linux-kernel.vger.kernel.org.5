Return-Path: <linux-kernel+bounces-137355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3989E11C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF4D9B29032
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0AE154C10;
	Tue,  9 Apr 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NmbT8Gbz"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57CB15383B;
	Tue,  9 Apr 2024 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682131; cv=none; b=iEWC2ETpPaU+s5blOJ+amOYyECN7vZEBvsdlrqXnAZ3FBcd+8aTz0Cb0ilr1fHI7JYhjZr9zhDGKm3MKAP2D4V0DWFZ//c7djrC7eDdF+mMWr9UUyE2v8uJTdgUqxKMAfg5wvKBCgl5WtJ6ApznE1cmwCvD+mfHPMrrJm9TCKrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682131; c=relaxed/simple;
	bh=os22hnONWugy2tpOAKxDCjc6v65N851yUDHEbBVCfUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9L2gXVBEzp+cQcLHV/kHgAL+Iz9ujl4TUD7e5plPrbmnJ9YdvaQRvd2GMkwCc8Oxws4qXKYjTI/wtaJckz5pgL+ntwoX3k6u6dRl5WdmzdWtzhO2YnFRH/TMMcvDl9po6VC0PzmKhJ2izhuSr+WjBYWBd7YSyYiwy0BO16pNnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NmbT8Gbz; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712682129; x=1744218129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9WK4Ks0kdU/PfCY29WwFv1CSYBPCLT37R4CWQ0Ev6+c=;
  b=NmbT8GbzQmD2OOKaaRq7PmL2rVOuHC9ge6fh5VL+2OBClNV5hg+99Xzw
   S+lRjsjua/SFITmzc2DIP2WPgD8NOQyADAHF8Kvs1yw8Xp25g363/Ew2e
   vI8omWUo3QCqu9T6yLrneMfitzQvFday+R0oi/hlMCzCneHo7wYhR8ETP
   8=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="79935446"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 17:02:06 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:18359]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.204:2525] with esmtp (Farcaster)
 id fc26ebea-5f91-4ded-a0bc-1ef0894944bc; Tue, 9 Apr 2024 17:02:06 +0000 (UTC)
X-Farcaster-Flow-ID: fc26ebea-5f91-4ded-a0bc-1ef0894944bc
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:02:05 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 17:02:01 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 2/5] virt: vmgenid: change implementation to use a platform driver
Date: Tue, 9 Apr 2024 18:01:34 +0100
Message-ID: <20240409170137.79197-3-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240409170137.79197-1-sudanl@amazon.com>
References: <20240409170137.79197-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

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
2.34.1


