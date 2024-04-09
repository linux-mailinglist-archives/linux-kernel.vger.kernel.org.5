Return-Path: <linux-kernel+bounces-137459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D69A189E26D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C82B237C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689F156C54;
	Tue,  9 Apr 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t9nDgE42"
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB481156999;
	Tue,  9 Apr 2024 18:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686891; cv=none; b=RyXS6okDmyVmOef8OJvrF3HQuVHM6MjVlX/8oJj9nT8wiEnqByYZs1p74srvGBmiEjsWpaClksx8FOUtQRU4zKhQ50l/Km7dY2vLijkytjJXJcx8WKwmYXW9CiWfBK1kIRioAG3R5veaRcLNw29YSwk2L3qh9CQb8hnc0O4sUk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686891; c=relaxed/simple;
	bh=EcZlkq4mhkJTecvlYLJiT9xew1ftS1oIMx4P6vr0rwc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDaTO5E695RZKEMLCt2Plawj3DtvgkLRKDVX4vDzyr6sm6uukVQrXEcvHcDZzumWryMMbaKq4AH0W/oTuegEgENsaZXM8X1FWkkjm0aq5M8c/+cq5GGI3Sh7RNTvBWMWwlZPZtaG6kpKD7mlOzyRBb6h1BJrHyOrfHaeCv2cICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t9nDgE42; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712686891; x=1744222891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JxlOcBDU6r908oKknpBe0s7bQqLQWVDeva8VVC0aQbE=;
  b=t9nDgE42rKpWI4WEOFm+GZ8TtFDmb0xJpIoo5/3WooqFXtRAAmq9y3bp
   moMl4wkYqEXS05QvLc0V3jeFVS3v4CgKSB8y7AJp+6yYB4m1wWOSmh8gU
   Wa8eImkQkSUw0YAQPauD9XfBiO3pAtxX0HCeMgfyzV61e4g+aBbXg0w5p
   A=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="388585344"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:13:29 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:4817]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.56:2525] with esmtp (Farcaster)
 id d21595e7-51f4-4c2a-9b93-72cbdcceb447; Tue, 9 Apr 2024 18:13:26 +0000 (UTC)
X-Farcaster-Flow-ID: d21595e7-51f4-4c2a-9b93-72cbdcceb447
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:13:26 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:13:21 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 3/5] virt: vmgenid: enable driver regardless of ACPI config
Date: Tue, 9 Apr 2024 19:11:52 +0100
Message-ID: <20240409181154.9962-4-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240409181154.9962-1-sudanl@amazon.com>
References: <20240409181154.9962-1-sudanl@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

Since with next commits vmgenid driver will support both ACPI and
devicetree, and since either one of CONFIG_ACPI or CONFIG_OF will
always be enabled, there is no need for the driver compilation to
depend on ACPI/OF. So, remove ACPI dependency for compiling the driver.

Signed-off-by: Sudan Landge <sudanl@amazon.com>
---
 drivers/virt/Kconfig   |  1 -
 drivers/virt/vmgenid.c | 16 +++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 40129b6f0eca..d8c848cf09a6 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -16,7 +16,6 @@ if VIRT_DRIVERS
 config VMGENID
 	tristate "Virtual Machine Generation ID driver"
 	default y
-	depends on ACPI
 	help
 	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
 	  to reseed the RNG when the VM is cloned. This is highly recommended if
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index c028e2064fdd..3d93e3fb94c4 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -36,13 +36,15 @@ static void vmgenid_notify(struct device *device)
 	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
 }
 
-static void vmgenid_acpi_handler(acpi_handle __always_unused handle,
-				 u32 __always_unused event, void *dev)
+static void __maybe_unused
+vmgenid_acpi_handler(acpi_handle __always_unused handle,
+		     u32 __always_unused event, void *dev)
 {
 	vmgenid_notify(dev);
 }
 
-static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
+static int __maybe_unused
+setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 {
 	if (IS_ERR(next_id))
 		return PTR_ERR(next_id);
@@ -53,9 +55,10 @@ static int setup_vmgenid_state(struct vmgenid_state *state, u8 *next_id)
 	return 0;
 }
 
-static int vmgenid_add_acpi(struct device *dev,
-			    struct vmgenid_state *state)
+static int vmgenid_add_acpi(struct device __maybe_unused *dev,
+			    struct vmgenid_state __maybe_unused *state)
 {
+#if IS_ENABLED(CONFIG_ACPI)
 	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_buffer parsed = { ACPI_ALLOCATE_BUFFER };
 	union acpi_object *obj;
@@ -98,6 +101,9 @@ static int vmgenid_add_acpi(struct device *dev,
 out:
 	ACPI_FREE(parsed.pointer);
 	return ret;
+#else
+	return -EINVAL;
+#endif
 }
 
 static int vmgenid_add(struct platform_device *pdev)
-- 
2.34.1


