Return-Path: <linux-kernel+bounces-107654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5487FFAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9788EB220DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19E651BE;
	Tue, 19 Mar 2024 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="oTl0tlJT"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876C46BF;
	Tue, 19 Mar 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858804; cv=none; b=M95tsLSzQJhmDxQsaPpFVgRZxyEj/2tQkIOB80RrRPYw+hQeH3DOilL7WUFdVc+85GvoFIpUNusePuAqE8u85E3Ko326IPn9lxvu01tZzAa2oTMyQTVBfJ6Vwlun89+pjWze8W+CQXjtgy7xj7La0hLODz1JtXQ9+4WVQqnGNiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858804; c=relaxed/simple;
	bh=m2GJUmJaHzkYsItjh54bfA5LBnAhX4P2f5TonsIozxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsRKREy1zZY7PxeyR0Ucce0AZuWBOdqcmNXUj57k2BtLAyAK3jpW5jQAdU8pL2SHzhY2Dkw9OCSJDSlA1j/kDYOQA2O/Z6In52GdkBOQVlNKrj/s+UBxLZ9z7Zba66J9OK6MsOayt6ZsQAyI8vPpb8+dQ4qVqd4TVQ9d4aRtZYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=oTl0tlJT; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710858802; x=1742394802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fu+KVRO7pbwl42g5Q5J3eMOQhD0GGMxcCy1IWDkBFVY=;
  b=oTl0tlJTb3J/n6v4XImU4/8GSWF1J3lHm2Bssny5KBshT9Df/DBfoZNl
   8lZqEMLwUykpLWBUAe6g6zcujOKbJv1okBWY15XGWNb00D1CiYgcNBcTx
   iwfmwNi5w22TGz5SPoVnSGcjT6gmyaXp2EHhDEZOylWDW+NywrGaUHB7s
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="394339018"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:33:19 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:14711]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.34.80:2525] with esmtp (Farcaster)
 id 27cdb139-13d1-4e5a-81b2-cb2ce885ec0c; Tue, 19 Mar 2024 14:33:19 +0000 (UTC)
X-Farcaster-Flow-ID: 27cdb139-13d1-4e5a-81b2-cb2ce885ec0c
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:18 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:13 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v1 2/4] virt: vmgenid: change implementation to use a platform driver
Date: Tue, 19 Mar 2024 14:32:51 +0000
Message-ID: <20240319143253.22317-3-sudanl@amazon.com>
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

Re-implement vmgenid as a platform driver in preparation
for adding devicetree bindings support in next commits.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/vmgenid.c | 99 +++++++++++++++++++++++++++++++-----------
 1 file changed, 73 insertions(+), 26 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index ea956df02874..e82b344a9d61 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/acpi.h>
 #include <linux/random.h>
+#include <acpi/actypes.h>
+#include <linux/platform_device.h>
 
 ACPI_MODULE_NAME("vmgenid");
 
@@ -21,9 +23,9 @@ struct vmgenid_state {
 	u8 this_id[VMGENID_SIZE];
 };
 
-static void vmgenid_notify(struct acpi_device *device, u32 event)
+static void vmgenid_notify(struct device *device)
 {
-	struct vmgenid_state *state = acpi_driver_data(device);
+	struct vmgenid_state *state = device->driver_data;
 	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
@@ -32,22 +34,34 @@ static void vmgenid_notify(struct acpi_device *device, u32 event)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
-	kobject_uevent_env(&device->dev.kobj, KOBJ_CHANGE, envp);
+	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
 }
 
-static int vmgenid_add(struct acpi_device *device)
+static void vmgenid_acpi_handler(acpi_handle handle, u32 event, void *dev)
 {
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
 	int ret = 0;
 
-	state = devm_kmalloc(&device->dev, sizeof(*state), GFP_KERNEL);
-	if (!state)
-		return -ENOMEM;
-
 	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &parsed);
 	if (ACPI_FAILURE(status)) {
 		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
@@ -63,19 +77,42 @@ static int vmgenid_add(struct acpi_device *device)
 
 	phys_addr = (obj->package.elements[0].integer.value << 0) |
 		    (obj->package.elements[1].integer.value << 32);
-	state->next_id = devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB);
-	if (IS_ERR(state->next_id)) {
-		ret = PTR_ERR(state->next_id);
+
+	ret = setup_vmgenid_state(state,
+				  devm_memremap(&device->dev, phys_addr, VMGENID_SIZE, MEMREMAP_WB)
+				 );
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
 
@@ -85,17 +122,27 @@ static const struct acpi_device_id vmgenid_ids[] = {
 	{ }
 };
 
-static struct acpi_driver vmgenid_driver = {
-	.name = "vmgenid",
-	.ids = vmgenid_ids,
-	.owner = THIS_MODULE,
-	.ops = {
-		.add = vmgenid_add,
-		.notify = vmgenid_notify
-	}
+static struct platform_driver vmgenid_plaform_driver = {
+	.probe      = vmgenid_add,
+	.driver     = {
+		.name   = "vmgenid",
+		.acpi_match_table = ACPI_PTR(vmgenid_ids),
+		.owner = THIS_MODULE,
+	},
 };
 
-module_acpi_driver(vmgenid_driver);
+static int vmgenid_platform_device_init(void)
+{
+	return platform_driver_register(&vmgenid_plaform_driver);
+}
+
+static void vmgenid_platform_device_exit(void)
+{
+	platform_driver_unregister(&vmgenid_plaform_driver);
+}
+
+module_init(vmgenid_platform_device_init)
+module_exit(vmgenid_platform_device_exit)
 
 MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
-- 
2.40.1



