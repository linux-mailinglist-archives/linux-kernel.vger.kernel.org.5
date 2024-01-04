Return-Path: <linux-kernel+bounces-16211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 937DB823AD7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A201F2517A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723044C67;
	Thu,  4 Jan 2024 02:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PHZgtxPd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BCE1FBB;
	Thu,  4 Jan 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id A8B123F722;
	Thu,  4 Jan 2024 02:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704336511;
	bh=qJZEPxVyP2sE0E3LLTPNVpWVMnWfCSJTXOSyhRDwibE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=PHZgtxPdoqTnO98HMsw4+UrL6nE121jBQPBCtOT99H61V8UGfRussxW8hXnZvP+T+
	 x53XaYBR1hJAxqcSpTNlSwgqxFx1jxX1rOO5x/YvKm7vsKJIUU6Jh61E1zbMsggHOz
	 rzNPVKwOWT+LLmZsxr2LYzBkbBlMEShFF8+uu9teXt87TvmBHS7uomjB0yyx02VVIq
	 w2mT7ZtJGDAY9EZ9mexN9UZagH0wARM6coGHE5BkdQvaSGl59FdUsrj2XWW2JdTuy3
	 8bsPfci6L7smeta59ma/s1YVFaN7Wg0mmwonrxHDVT78YOcQ099SqBvFi1zDsXyeKA
	 nCpYg7bNzQ7AQ==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v3 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
Date: Thu,  4 Jan 2024 10:48:18 +0800
Message-Id: <20240104024819.848979-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function of acpi_power_meter module on Dell system requires IPMI
handler is installed and SMI is selected.

So add a helper to let acpi_power_meter know when IPMI handler and SMI
are ready.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v3:
 - New patch.

 drivers/acpi/acpi_ipmi.c | 17 ++++++++++++++++-
 include/acpi/acpi_bus.h  |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 0555f68c2dfd..54862cab7171 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -23,6 +23,8 @@ MODULE_LICENSE("GPL");
 #define IPMI_TIMEOUT			(5000)
 #define ACPI_IPMI_MAX_MSG_LENGTH	64
 
+static struct completion smi_selected;
+
 struct acpi_ipmi_device {
 	/* the device list attached to driver_data.ipmi_devices */
 	struct list_head head;
@@ -463,8 +465,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 		if (temp->handle == handle)
 			goto err_lock;
 	}
-	if (!driver_data.selected_smi)
+	if (!driver_data.selected_smi) {
 		driver_data.selected_smi = ipmi_device;
+		complete(&smi_selected);
+	}
 	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
 	mutex_unlock(&driver_data.ipmi_lock);
 
@@ -578,10 +582,21 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	return status;
 }
 
+int acpi_wait_for_acpi_ipmi(void)
+{
+	long ret;
+
+	ret = wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
+
+	return ret > 0 ? 0 : -ETIMEDOUT;
+}
+EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
+
 static int __init acpi_ipmi_init(void)
 {
 	int result;
 	acpi_status status;
+	init_completion(&smi_selected);
 
 	if (acpi_disabled)
 		return 0;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1216d72c650f..afa6e4d4bf46 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -821,11 +821,16 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
 {
 	acpi_dev_put(adev);
 }
+
+int acpi_wait_for_acpi_ipmi(void);
+
 #else	/* CONFIG_ACPI */
 
 static inline int register_acpi_bus_type(void *bus) { return 0; }
 static inline int unregister_acpi_bus_type(void *bus) { return 0; }
 
+static inline int acpi_wait_for_acpi_ipmi(void) { return 0; }
+
 #endif				/* CONFIG_ACPI */
 
 #endif /*__ACPI_BUS_H__*/
-- 
2.34.1


