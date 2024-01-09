Return-Path: <linux-kernel+bounces-20368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80A827DC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75FF6285828
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602206138;
	Tue,  9 Jan 2024 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="iRNzNeBd"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D5567E;
	Tue,  9 Jan 2024 04:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0B9B43F1F8;
	Tue,  9 Jan 2024 04:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704773546;
	bh=mkzCDhuur4nw3vJi1sNPki2ia8X8CMEeigRIEazS7gI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=iRNzNeBdsesEXzRUQUs3tat0ggOIur6n2AMxka6CasTq80lMsGe7cxqsaCLTJO/pX
	 J+hnhb7gqZ8V2OTrvkohkyAqU+FNG5zZo+4asq/huuiSC2h7tNEopaRaHBRoxQ8zVX
	 stygorc/5r9XrWjIfCl819wwdcCzKMnxLFc5lwcVZVieJm3/a4ev8VKh1LfTsaskuH
	 m20vFfL7AL0AQCCP/YQtC1KDas8NyCAygt0Mki3P21hocDgtmjlWAKEx5Sz/k8edRs
	 fwWYFpFSORqHNKboCDkd4HJwc05uJizmdZcX2kHL/9V6Mj6B1bRmQyY3htov3Aln7A
	 m4kmzBWNBTMbg==
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
Subject: [PATCH v4 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
Date: Tue,  9 Jan 2024 12:12:16 +0800
Message-Id: <20240109041218.980674-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Dell servers, many APCI methods of acpi_power_meter module evaluate
variables inside IPMI region, so the region handler needs to be
installed. In addition to that, the handler needs to be fully
functional, and that depends on SMI being selected.

So add a helper to let acpi_power_meter know when the handler is
installed and ready to be used.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 - Wording.
 - Define and comment on timeout value.
 - Move the completion to driver_data.
 - Remove the tenary operator.

v3:
 - New patch.

 drivers/acpi/acpi_ipmi.c | 23 ++++++++++++++++++++++-
 include/acpi/acpi_bus.h  |  5 +++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
index 0555f68c2dfd..5fba4dab5d08 100644
--- a/drivers/acpi/acpi_ipmi.c
+++ b/drivers/acpi/acpi_ipmi.c
@@ -22,6 +22,8 @@ MODULE_LICENSE("GPL");
 /* the IPMI timeout is 5s */
 #define IPMI_TIMEOUT			(5000)
 #define ACPI_IPMI_MAX_MSG_LENGTH	64
+/* 2s should be suffient for SMI being selected */
+#define ACPI_IPMI_SMI_SELECTION_TIMEOUT	(2 * HZ)
 
 struct acpi_ipmi_device {
 	/* the device list attached to driver_data.ipmi_devices */
@@ -54,6 +56,7 @@ struct ipmi_driver_data {
 	 * to this selected global IPMI system interface.
 	 */
 	struct acpi_ipmi_device *selected_smi;
+	struct completion smi_selection_done;
 };
 
 struct acpi_ipmi_msg {
@@ -463,8 +466,10 @@ static void ipmi_register_bmc(int iface, struct device *dev)
 		if (temp->handle == handle)
 			goto err_lock;
 	}
-	if (!driver_data.selected_smi)
+	if (!driver_data.selected_smi) {
 		driver_data.selected_smi = ipmi_device;
+		complete(&driver_data.smi_selection_done);
+	}
 	list_add_tail(&ipmi_device->head, &driver_data.ipmi_devices);
 	mutex_unlock(&driver_data.ipmi_lock);
 
@@ -578,6 +583,20 @@ acpi_ipmi_space_handler(u32 function, acpi_physical_address address,
 	return status;
 }
 
+int acpi_wait_for_acpi_ipmi(void)
+{
+	long ret;
+
+	ret = wait_for_completion_interruptible_timeout(&driver_data.smi_selection_done,
+							ACPI_IPMI_SMI_SELECTION_TIMEOUT);
+
+	if (ret <= 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_wait_for_acpi_ipmi);
+
 static int __init acpi_ipmi_init(void)
 {
 	int result;
@@ -586,6 +605,8 @@ static int __init acpi_ipmi_init(void)
 	if (acpi_disabled)
 		return 0;
 
+	init_completion(&driver_data.smi_selection_done);
+
 	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
 						    ACPI_ADR_SPACE_IPMI,
 						    &acpi_ipmi_space_handler,
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


