Return-Path: <linux-kernel+bounces-148344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218048A8137
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48061F214CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BCA13C68A;
	Wed, 17 Apr 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="RfbOAqDy"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3AF139CEF;
	Wed, 17 Apr 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350557; cv=none; b=SQ/0wm6Ptx7uyep7A8li4WQS6ZPCvXdSNBads6vy1+0vEZVGcTQYTxvTjH6bH0VoSOBec5kixskwXWGLeDdi5MWkA0G5ugunZPGTXW1Psqj55cCx/w0EbCv/ZSeVirShtoEzVYLFG1+3dUJJoCONTNM6TDAsAme618O0J9KitlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350557; c=relaxed/simple;
	bh=L4IM14Lp1IerdghKC1MdCHqHOc9dTQQr3oC33c79Ow4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MONjY7UYHFxrTipdrG+4feADR5yHBWN6+J9f/NE5hmfVsf5cV4+nxapiHxT+WEANaNCHSgf2IiuuHPyPMrOPyUNp2c57gCS6TpNjjnmb2GNpfjaCx58w56xsl1yNdD2JujHQDcbfSSDZhaSPEgxce8EVURL1lBhJ55m/GMDcb9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=RfbOAqDy; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713350557; x=1744886557;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z4v5SZ4fM558dr5bHE9WDlkTbOj+ppWRkve9bLyx7E8=;
  b=RfbOAqDym29WtQQougFumGx4OkYQQAWj9WLB/De9dvNUsYdu6+cBqh7T
   99VBLpBIcEANNBxsinE3WHkqnprd1RPJsWzzv4zMQqnCCYTD8RnFDa5+I
   zJWSqWTBHqj51t1Oq12+8KGsddE6dbuj3AuY7+IMMLouiXKNpSZhKvyeu
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="395281432"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:42:32 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:59449]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.183:2525] with esmtp (Farcaster)
 id ef619efc-0ea9-4bbc-bc9d-6b633eb603c6; Wed, 17 Apr 2024 10:42:30 +0000 (UTC)
X-Farcaster-Flow-ID: ef619efc-0ea9-4bbc-bc9d-6b633eb603c6
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:42:30 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.106.83.20) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:42:24 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>, Alexander Graf
	<graf@amazon.com>
Subject: [PATCH v6 3/5] virt: vmgenid: enable driver regardless of ACPI config
Date: Wed, 17 Apr 2024 12:40:44 +0200
Message-ID: <20240417104046.27253-4-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240417104046.27253-1-bchalios@amazon.es>
References: <20240417104046.27253-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

Since with next commits vmgenid driver will support both ACPI and
devicetree, and since either one of CONFIG_ACPI or CONFIG_OF will
always be enabled, there is no need for the driver compilation to
depend on ACPI/OF. So, remove ACPI dependency for compiling the driver.

Co-authored-by: Sudan Landge <sudanl@amazon.com>
Signed-off-by: Babis Chalios <bchalios@amazon.es>
Reviewed-by: Alexander Graf <graf@amazon.com>
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


