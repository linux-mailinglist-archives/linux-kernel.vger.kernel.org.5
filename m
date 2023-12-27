Return-Path: <linux-kernel+bounces-11814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCA81EBFF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C1F4B21964
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6103C24;
	Wed, 27 Dec 2023 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IPDsRAUh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61981522C;
	Wed, 27 Dec 2023 04:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id ABE2F3F722;
	Wed, 27 Dec 2023 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703649848;
	bh=m76mF9xbAsx2/TveqoahDVkZj7zH+GFIW9wWNEteV4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=IPDsRAUh3WjnCMbM4WW6k5e7qtHi7XoquVsYApwl6XZ5TtlWlqkfEZx20tKvrk562
	 KRuKIC0MjiPDpFtVv2RinBs1WYcIA8Td8GzepHpYkMbHGbBVN5uVyK1sr39HptFrWF
	 aErdL3vq6R0+kZrraazNcadCg4eLa5TqwXWHZyhuIq7Ol6s/yZP+XJudoGPQMFUdtw
	 MWaUFzW9FgICMoEqQ0OFzzsY3a90Wuu2HhCf8MenJVQWkJiKO50ErKF2N50j/lgUBf
	 819FCss6DqjBNimwT/KmgC8MuEuovfbHM4OPVh2Zd5yjYXYUXRr5/yAO/ea/mkzKUj
	 2ZRDvAwqkoAfw==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v2] hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems
Date: Wed, 27 Dec 2023 12:04:00 +0800
Message-Id: <20231227040401.548977-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following error can be observed at boot:
[    3.717920] ACPI Error: No handler for Region [SYSI] (00000000ab9e62c5) [IPMI] (20230628/evregion-130)
[    3.717928] ACPI Error: Region IPMI (ID=7) has no handler (20230628/exfldio-261)

[    3.717936] No Local Variables are initialized for Method [_GHL]

[    3.717938] No Arguments are initialized for method [_GHL]

[    3.717940] ACPI Error: Aborting method \_SB.PMI0._GHL due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[    3.717949] ACPI Error: Aborting method \_SB.PMI0._PMC due to previous error (AE_NOT_EXIST) (20230628/psparse-529)
[    3.717957] ACPI: \_SB_.PMI0: _PMC evaluation failed: AE_NOT_EXIST

On Dell systems several methods of acpi_power_meter access variables in
IPMI region [0], so wait until IPMI space handler is installed by
acpi_ipmi and also wait until SMI is selected to make the space handler
fully functional.

[0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use completion instead of request_module().

 drivers/acpi/acpi_ipmi.c         | 13 ++++++++++++-
 drivers/hwmon/acpi_power_meter.c |  4 ++++
 include/acpi/acpi_bus.h          |  4 ++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 0555f68c2dfd..2ea8b7e6cebf 100644
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
 
@@ -578,10 +582,17 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	return status;
 }
 
+void wait_for_acpi_ipmi(void)
+{
+	wait_for_completion_interruptible_timeout(&smi_selected, 2 * HZ);
+}
+EXPORT_SYMBOL_GPL(wait_for_acpi_ipmi);
+
 static int __init acpi_ipmi_init(void)
 {
 	int result;
 	acpi_status status;
+	init_completion(&smi_selected);
 
 	if (acpi_disabled)
 		return 0;
diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 703666b95bf4..acaf1ae68dc8 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -883,6 +883,10 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
 	device->driver_data = resource;
 
+	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
+	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1))
+		wait_for_acpi_ipmi();
+
 	res = read_capabilities(resource);
 	if (res)
 		goto exit_free;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1216d72c650f..ed59fb89721e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -655,6 +655,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
 bool acpi_quirk_skip_acpi_ac_and_battery(void);
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle);
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle);
+void wait_for_acpi_ipmi(void);
 #else
 static inline bool acpi_device_override_status(struct acpi_device *adev,
 					       unsigned long long *status)
@@ -672,6 +673,9 @@ static inline int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 static inline void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
 }
+static inline void wait_for_acpi_ipmi(void)
+{
+}
 #endif
 
 #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
-- 
2.34.1


