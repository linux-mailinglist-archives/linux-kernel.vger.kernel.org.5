Return-Path: <linux-kernel+bounces-6380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B8D819807
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B00DB255DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C32D312;
	Wed, 20 Dec 2023 05:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="RibTiH7b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8E11C81;
	Wed, 20 Dec 2023 05:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DD3713FB71;
	Wed, 20 Dec 2023 05:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703049239;
	bh=ZBrxATvDecKxcBA3yFt+cxq4r2eDxfaznghQg4Vtl9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=RibTiH7bbAyoafZournYPJgMLjpR3HEjXUpH+BR8Ky93YpPItFTd7AxYJXBumYYzV
	 FY01g9ctGaotueWx16eFy+Kiq2OOdOJ+hZuDa+J9eZ6Wv0yRlNsljX3GfeVsqcVBfH
	 m1fzW/Hx87kvj5qGDjmExCUf2HysEjsT5Ffy5WLBZODyPo2dumJ5iWX1tag/Bqy5rM
	 L8sqv/za7TU5oIRNTRrY5bPSoCeJX08byQCWLhgt2c/64DuAmh2ce2WEEAcUGF4yp3
	 fWWntuwceGSHIooEk4NbXnB83I9Q9GWmHc2IN5rtiOssMReQdH2A39+IlMAEZ7oo4a
	 tavAK3FrnHFLA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (acpi_power_meter) Install IPMI handler for Dell systems
Date: Wed, 20 Dec 2023 13:13:50 +0800
Message-Id: <20231220051350.392350-1-kai.heng.feng@canonical.com>
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
IPMI region [0], so request module 'ipmi_si' which will load 'acpi_ipmi'
and install the region handler accordingly.

[0] https://www.dell.com/support/manuals/en-us/redhat-enterprise-linux-v8.0/rhel8_rn_pub/advanced-configuration-and-power-interface-acpi-error-messages-displayed-in-dmesg?guid=guid-0d5ae482-1977-42cf-b417-3ed5c3f5ee62

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hwmon/acpi_power_meter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 703666b95bf4..b9db53166bc9 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -882,6 +882,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	strcpy(acpi_device_name(device), ACPI_POWER_METER_DEVICE_NAME);
 	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
 	device->driver_data = resource;
+	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc."))
+		request_module("ipmi_si");
 
 	res = read_capabilities(resource);
 	if (res)
-- 
2.34.1


