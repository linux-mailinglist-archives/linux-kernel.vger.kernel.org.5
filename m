Return-Path: <linux-kernel+bounces-148112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7788A7DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D509B23B96
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF097D412;
	Wed, 17 Apr 2024 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="h39TEJPv"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162566CDA8;
	Wed, 17 Apr 2024 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713341627; cv=none; b=edG6t+de4QQB4ODT17FvjCoKc45/Q8lBG7Hpv7h6d0OyTIOlg89VFhEvDVvr3l2ojKwhu+QVh+t1vl8YF0mGkuZLMbos5C0ZzBRYPZtDvc289vTKU4ZEE11Z9qH8Cq+L4dWE9iEJlryiUK6WxRGEZX8GwD6M1a+wmfsRkvAl1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713341627; c=relaxed/simple;
	bh=1CfEx7En//rQTPjNkdBRxgYY8YsR3cT9VDy6Q3aq1js=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLwtRdTnqFHH0S+OgXHIfqieRfoIOhE1fZ0TPPUnnRy1IqKB3a73HNLW/yCRXo+T9CqUsz8wrW/jrExhOCrSLqGMI4lvLeTJVPrFhxu86XAr6sGwsCXnMi5GDZknHOpZ9MRwd7O5JJqG5Xqy76BdBroDOZvxV8zJawrjlXIaQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=h39TEJPv; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713341626; x=1744877626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hme3ue3JG7Wn60xJ6N2Jtr7lrjUzAQYZjAaiSzLCYi0=;
  b=h39TEJPvYoQLHDI+Lwl98vnCIOCgA+GziCZHX7jy9mpLnT5K1X/IQRvr
   iLX0xn498urAtubGi18M9rVWlDn9Wm53Fml1UZ5+7PoiVGH6wNGRhvhhg
   a3nYbQJJ6Abe4C5KtQegts9gNUxZrlhdTZpVop7S6yGxw2NjvTXV1JVUO
   U=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="82072282"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:13:42 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:52930]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.7.11:2525] with esmtp (Farcaster)
 id fb31b545-39b8-4f6a-ba97-b76de78b4325; Wed, 17 Apr 2024 08:13:41 +0000 (UTC)
X-Farcaster-Flow-ID: fb31b545-39b8-4f6a-ba97-b76de78b4325
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:39 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.1.212.48) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:13:34 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v5 3/5] virt: vmgenid: enable driver regardless of ACPI config
Date: Wed, 17 Apr 2024 10:12:10 +0200
Message-ID: <20240417081212.99657-4-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417081212.99657-1-bchalios@amazon.es>
References: <20240417081212.99657-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

From: Sudan Landge <sudanl@amazon.com>

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
2.40.1


