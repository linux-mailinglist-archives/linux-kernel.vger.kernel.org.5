Return-Path: <linux-kernel+bounces-108647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0EE880DCE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9061C20F6A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC29D3A1A1;
	Wed, 20 Mar 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mdx1PW+V"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B839FF2;
	Wed, 20 Mar 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924606; cv=none; b=OpUfIf+qFKV9KF7+OsKWVwu0UxBfGpmZ1NDWA06CksTMrR2FaNmxVGppp0IZuGQBX1eUBYlNuvOPLgrhwrOY3hXS/cucshUUjYd3Us1ljCo/wLw2JJmnqHdtBZHomowWuxZ8UTnhPHxrsD9066+HK/ZMvpkyFV9jbakeVM/YhZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924606; c=relaxed/simple;
	bh=qN90YsyhEdTYLpAgk86xiUkWMEl53xc5BeEM/tePBFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SxKw/LyW8CpGCtpfT0R0CdC+G9oG+x40BBnW9Rr7Bd5HoFuHFegsUp0N5+cy0nV4i0/wMf6DX9uh4VAx2YsaaOgJaOPbf4Jn3FYJoqdqeFolxbcIIHIz9tdOKP/vZapyqlpFSkeeR+TX3akmUprWEGtNpjNGknGIow/mMBh9H2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mdx1PW+V; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 0ACE241C1B;
	Wed, 20 Mar 2024 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1710924254;
	bh=3Phe7IR9wF0mRfOHuRR6w4aXwl1W5QC++Hur2AKYbiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=mdx1PW+Vl7YelstHZeGGC96/XjqJrPLabPIvRYbpM0kGPveB2JaU9y/YRkWVOv2FI
	 AKjtuJW6HyiRQYgqmP4E28tuQ6w0mmnMrrIKfZosMd3h3iPl+u4mG+lFHSNWDH6bfz
	 r/Lmlbis4H6D8sXbQpqMF3dYJgvZ14bL/XbxrPOtUU7CjER8DeG5h+TVPyKD0KDoUu
	 vAlQsJ7sxPqY3Foptos8KLwHwPA+9vu2gOuRP0+Zhp6mhe3x4XQXd5rGUPoaC1oClz
	 LlG5g2ms5YQbmeGKaf8Y8i8CckL2xpOyr9TU7MMdkiRYGAx0rNuzKP2trvPPd+1d7Z
	 Zk0/7KiIENTYA==
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
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v5 2/2] hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems
Date: Wed, 20 Mar 2024 16:43:17 +0800
Message-Id: <20240320084317.366853-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320084317.366853-1-kai.heng.feng@canonical.com>
References: <20240320084317.366853-1-kai.heng.feng@canonical.com>
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

Since the dependency is inside BIOS's ASL code and it's not
discoverable, so use this fixup is a hack to workaround BIOS issue.

[0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v5:
 - Check CONFIG_ACPI_IPMI to fix link error.
 - Use acpi_dev_put() to balance reference count.
 - Wording.
 - Add comment to explain the rationale.

v4:
 - No change.

v3:
 - Use helper.
 - Use return value to print warning message.

v2:
 - Use completion instead of request_module().

 drivers/hwmon/acpi_power_meter.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 703666b95bf4..b34cb57f2a0e 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -868,6 +868,9 @@ static int acpi_power_meter_add(struct acpi_device *device)
 {
 	int res;
 	struct acpi_power_meter_resource *resource;
+#if IS_REACHABLE(CONFIG_ACPI_IPMI)
+	struct acpi_device *ipi_device;
+#endif
 
 	if (!device)
 		return -EINVAL;
@@ -883,6 +886,24 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
 	device->driver_data = resource;
 
+#if IS_REACHABLE(CONFIG_ACPI_IPMI)
+	/*
+	 * On Dell systems several methods of acpi_power_meter access
+	 * variables in IPMI region, so wait until IPMI space handler is
+	 * installed by acpi_ipmi and also wait until SMI is selected to make
+	 * the space handler fully functional.
+	 */
+	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.")) {
+		ipi_device = acpi_dev_get_first_match_dev("IPI0001", NULL, -1);
+
+		if (ipi_device) {
+			if (acpi_wait_for_acpi_ipmi())
+				dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
+			acpi_dev_put(ipi_device);
+		}
+	}
+#endif
+
 	res = read_capabilities(resource);
 	if (res)
 		goto exit_free;
-- 
2.34.1


