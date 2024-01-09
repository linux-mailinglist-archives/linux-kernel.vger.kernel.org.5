Return-Path: <linux-kernel+bounces-20369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F923827DC7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32DD3B21E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 04:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A57497;
	Tue,  9 Jan 2024 04:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MQD8Opn4"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E3568B;
	Tue,  9 Jan 2024 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from HP-EliteBook-x360-830-G8-Notebook-PC.. (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8C5F64211A;
	Tue,  9 Jan 2024 04:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704773549;
	bh=D/WDV5fXgOpgS9EEKmedByWQnN4+GBubzNwhkbzIl/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=MQD8Opn4BoX1DQLdeIyZYT9H2qhb7uaZAYoX+WESIF6w57wdv/sKTYYyadV1OEbH0
	 5Bzw5KTa7k2IIBtRum3feVZkzIc7RWNL3sTpGGHzSIxWXkigdJQ6Y1aA2z+Pjkn4bd
	 419G7Tb2ynBbsQtQpYRYfFSSZ81G5PmXOHxvZevgjZL3YY9pkjqxURxN8fb5HoNwYz
	 sckkvJWsGlyGaY4gYk8cXptpaoqXfp0Zua4lV14C691xHGGmSyiWHfIh1W5y8lyCt2
	 QGLi3nXmRZxU5xsSvEFoFTtKGLneb1mnk73RlAA7rhLx60lcd0tLvcc96xNpdOY/rT
	 9e52RZGaEkLxA==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] hwmon: (acpi_power_meter) Ensure IPMI space handler is ready on Dell systems
Date: Tue,  9 Jan 2024 12:12:17 +0800
Message-Id: <20240109041218.980674-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109041218.980674-1-kai.heng.feng@canonical.com>
References: <20240109041218.980674-1-kai.heng.feng@canonical.com>
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
v4:
 - No change.

v3:
 - Use helper.
 - Use return value to print warning message.

v2:
 - Use completion instead of request_module().

 drivers/hwmon/acpi_power_meter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 703666b95bf4..33fb9626633d 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -883,6 +883,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), ACPI_POWER_METER_CLASS);
 	device->driver_data = resource;
 
+	if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
+	    acpi_dev_get_first_match_dev("IPI0001", NULL, -1)) {
+		if (acpi_wait_for_acpi_ipmi())
+			dev_warn(&device->dev, "Waiting for ACPI IPMI timeout");
+	}
+
 	res = read_capabilities(resource);
 	if (res)
 		goto exit_free;
-- 
2.34.1


