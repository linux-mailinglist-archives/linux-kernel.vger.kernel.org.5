Return-Path: <linux-kernel+bounces-149847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7501F8A96B7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A0F1F211BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B109F15B985;
	Thu, 18 Apr 2024 09:51:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE4115B56B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433913; cv=none; b=Y0P+Flu8EuQaimNTJhmJVBH3kZiid0BubkAN6Ut2WJBBOo/HiY+UOg3V8AyXYGgsyzb+A0YBM+N6XM3VhlgGdegTlobq5q/4rIliyBDglw6UbB2Y6HiYyHIAlr+dCzenXpeiR0R+aiTL4NYcAYiIETcZyor3PlSunoefFrx+K24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433913; c=relaxed/simple;
	bh=NsGjx/jomoCy4xShRYD7a+fxBdFl3tLSSNdfPyeTJyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0eKSTMM7pRo+rJij49rUi4s+wBUCGiDL73Nu/eXVqFFGAxTq2hKFAwdjyG5AcS8aE/NhYW5V5cK69Lqdn4nR9JiCp4ugvmCVFtmrc060wtKn2G63berOYvYyPjP8MzY9mhSsJU/OJ6zqXRJOdC3y9CCyGuZL4NV7/65jEDc5us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D811595;
	Thu, 18 Apr 2024 02:52:18 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00F0D3F64C;
	Thu, 18 Apr 2024 02:51:48 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	konrad.dybcio@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 2/2] firmware: arm_scmi: Add dedicated vendor protocols submenu
Date: Thu, 18 Apr 2024 10:51:21 +0100
Message-ID: <20240418095121.3238820-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240418095121.3238820-1-cristian.marussi@arm.com>
References: <20240418095121.3238820-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dedicated Kconfig submenu and directory where to collect SCMI vendor
protocols implementations.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/Kconfig          | 2 ++
 drivers/firmware/arm_scmi/Makefile         | 1 +
 drivers/firmware/arm_scmi/vendors/Kconfig  | 4 ++++
 drivers/firmware/arm_scmi/vendors/Makefile | 2 ++
 4 files changed, 9 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/vendors/Kconfig
 create mode 100644 drivers/firmware/arm_scmi/vendors/Makefile

diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
index aa5842be19b2..db9166e99177 100644
--- a/drivers/firmware/arm_scmi/Kconfig
+++ b/drivers/firmware/arm_scmi/Kconfig
@@ -180,4 +180,6 @@ config ARM_SCMI_POWER_CONTROL
 	  called scmi_power_control. Note this may needed early in boot to catch
 	  early shutdown/reboot SCMI requests.
 
+source "drivers/firmware/arm_scmi/vendors/Kconfig"
+
 endmenu
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index a7bc4796519c..1316892a230d 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -15,6 +15,7 @@ scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
 obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
+obj-$(CONFIG_ARM_SCMI_PROTOCOL) += vendors/
 
 obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
 
diff --git a/drivers/firmware/arm_scmi/vendors/Kconfig b/drivers/firmware/arm_scmi/vendors/Kconfig
new file mode 100644
index 000000000000..7c1ca7a12603
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "ARM SCMI Vendor Protocols"
+
+endmenu
diff --git a/drivers/firmware/arm_scmi/vendors/Makefile b/drivers/firmware/arm_scmi/vendors/Makefile
new file mode 100644
index 000000000000..c6c214158dd8
--- /dev/null
+++ b/drivers/firmware/arm_scmi/vendors/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# obj-$(CONFIG_ARM_SCMI_PROTOCOL_<your_vendor_proto>) += <your_vendor_proto>.o
-- 
2.44.0


