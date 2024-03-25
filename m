Return-Path: <linux-kernel+bounces-117856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFD88B085
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5B11FA2F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B2045025;
	Mon, 25 Mar 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="inRixaMv"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862554085A;
	Mon, 25 Mar 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396420; cv=none; b=YIdFlypr7iwVCKb99+Ixf1J+p2CdR9T3rG6l+ShMQxW8AB8KRSu4BMQNwucmgzbINcSTgDVotwXCrhZGlPxcCrQRv9i52WGCY6ONMl2CQ4PTpRZYUlcyrh7QuNEH8BNyXViSgi7bzE3M7ds7tSWvQXuPReXuS0R/AEe80SrpPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396420; c=relaxed/simple;
	bh=ZaV+ev/jI/fqWFZttEUarlNcX/sXAziMRGH2RquOLcA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOAdwv11I0a+AivsGHy9QFPCciZE0pk9tCEQaG3J3VTufyEUFmqiAZlMBlrBzZGZVdORuTXSXrcUe6+QmN+Giud83DjyPi82uJ/gPZEyQHh9oE6tM5r/ULQ0njiF6f36Tfl6lbaYBJISGLYyD0rqef1L1OUFFikeybkhw3S5T2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=inRixaMv; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711396419; x=1742932419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eYEegrjH0qqz5TwkXTvElujjd0LDRDev29SImBbbI6Q=;
  b=inRixaMvdy1m2w2kdU7JFIjfhqloWfm8MrJp/wBqYqhoi7ijMRFhn37u
   OGAaXRlA+NzYj8qqO0/BC/jPjIg9ofwUCup21D/wDtF2VJVICrNfDiFOq
   WKQMofDwNQrSGbYPF0lSs8KPDpJhCN91vxy5oDsr3N4gQrXrhmyUM/ruv
   0=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="282762815"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:53:37 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:29969]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.231:2525] with esmtp (Farcaster)
 id d573997d-a1bd-45e8-9e81-72d826ed55fa; Mon, 25 Mar 2024 19:53:35 +0000 (UTC)
X-Farcaster-Flow-ID: d573997d-a1bd-45e8-9e81-72d826ed55fa
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:35 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:30 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v3 2/4] virt: vmgenid: change implementation to use a platform driver
Date: Mon, 25 Mar 2024 19:53:04 +0000
Message-ID: <20240325195306.13133-3-sudanl@amazon.com>
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

Re-implement vmgenid as a platform driver in preparation
for adding devicetree bindings support in next commits.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/vmgenid.c | 101 ++++++++++++++++++++++++++++++-----------
 1 file changed, 74 insertions(+), 27 deletions(-)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index ea956df02874..d5394c706bd9 100644
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
+				  (u8 *)devm_memremap(&device->dev, phys_addr,
+						      VMGENID_SIZE, MEMREMAP_WB));
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
 
@@ -84,20 +121,30 @@ static const struct acpi_device_id vmgenid_ids[] = {
 	{ "VM_GEN_COUNTER", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 
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
 
-MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
 MODULE_DESCRIPTION("Virtual Machine Generation ID");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.40.1



