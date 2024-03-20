Return-Path: <linux-kernel+bounces-108646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DDA880DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB45281F11
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751DC3EA8A;
	Wed, 20 Mar 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="LP11FVl/"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F6B39FEF;
	Wed, 20 Mar 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924605; cv=none; b=SPrt9w+RB3F6VuTADSM0QbROmhs7vbThaZUxJVXYfsPDlUZNslE3fH8BocpIbxf7Rbp1/LZnwrwsqPSvcd+EDBoPlq/DZXznSkd6zzkEdUQVxy8SdwjZncc58s7ZpH4+y2JU6TK7in3wlcHcX44PJ1CHO28xaO9LkL6+RnTihPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924605; c=relaxed/simple;
	bh=xGb4RhUYDWPElHint+HXBjgURCNEhZssnpEzWgr9f5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xm7tD5oNSIdR410vNbRMMCPPOzVAvH/aCMJrc+Aao114KPqDKL/jHkWtjwyJBFypNFGjxArTMKE+ZIXCS+JqQFexniy3iAEAIIAkwssSYRmc/mm0lG+6WP5bTzvx7q3SArDQzg89FliVAc4raMNm4EK6Dhq06llg5I3Qwi7qGKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=LP11FVl/; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CCA2F40F3D;
	Wed, 20 Mar 2024 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710924249;
	bh=+aw+nCBe+T3oJ08NUcmK8t7uBWVt6oUIlxWmPcFE1Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=LP11FVl/yZMXhnRTXF2PkvKa6S3Dk2kwamlqfX47REpx8fr4kmO+U8NCFpjtpXML3
	 myxDmfN4/rj5CCb80TDQqR41NDVMnyWBtiQ9WosUfAnd6VUzkuEGbehtvcEQXvWaSP
	 hHZl82+N0tH67TmyxoneiKSS5n6qUr83yFgXmbvfAwGV+wO38cbwcgOMo9eRMB2LPe
	 TGALCrz9NkJEs4xrWg0txyfY44sS8cO5C+SdRH/qCckqPBg+YH2VWf5kmJ/mZ/CZZL
	 9bzZ4wtcKC7+GdtM89FDRBmGMA+Gt/6TBAXZ8KJOk6z5rL18hIawZrtIXks17ijtqN
	 ycJPH+PkXTNpg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v5 1/2] ACPI: IPMI: Add helper to wait for when SMI is selected
Date: Wed, 20 Mar 2024 16:43:16 +0800
Message-Id: <20240320084317.366853-1-kai.heng.feng@canonical.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
v5:
 - No change.

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
index 5de954e2b18a..5a69cbd58c5e 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -976,11 +976,16 @@ static inline void acpi_put_acpi_dev(struct acpi_device *adev)
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


