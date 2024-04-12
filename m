Return-Path: <linux-kernel+bounces-142800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BD18A3047
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D5285D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354D8626D;
	Fri, 12 Apr 2024 14:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="SPW1M2jb"
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0BC219FF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931360; cv=none; b=s+vUptZn2tEpUZZfpdPfYIC108lyDCPJ05l/QCFmjmAXecLG7VG1ekwHodFYMV8ixbrymTKxw/axMUGYS/uhzUzQ1zpwPLg8/wx70Lima+3wy8ddQ1jVuF049fnSywHHQiQ2Whh0Z3J5XWB8AZqbbNyGFpopBLEm/TxepJWb9aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931360; c=relaxed/simple;
	bh=pi4POFJGbmG+EFSX5jHO6VKwHpT+QQ5oihzvzacsONs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NmoAV+gwcIUJs/jTEutU9HWl5aio/UgW+WFBP9GYe5xsPItJuxxsS87Gs+f9Goyxfch/17cV62qyCgCACeIrZA9rrytg9DX+ed7ZkPx8qE7tzaDGQQvNvmOxMAZ2VDV8RlCAX49cgPelEotCxs5rD9EznTMnPqQntnYAG4ALozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=SPW1M2jb; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E3B9C148CE13;
	Fri, 12 Apr 2024 16:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1712930894; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=sBl9oAOfMtgLk5aj+/DBmqnWaUXUF14bw/24EPbqnmA=;
	b=SPW1M2jbnU6MXKb15lSvyKvVIN3FnC7iukYQaJ+nL5+BosGJV2W/kIB5iUEgeoO/buenw1
	3iP7i2kNOXbKY4srZXprxOIwIAibd2/F/TK9UU2MEejaNa/SCTROP4WyUIGgdvFcAZ/VE2
	6Fm/HSlWoRi0n0wbKJKFKISb+uKMisKtZPaTxQVrMBzegDGhNlfDUN05rnoebRIQGCjBcN
	JAH9dgJcBmxIJ6uBCrWt0mptj915VvQ+C81e1sI256vx52+VxPEaAvAfDyb1iUdfQ4PCVy
	70/Q/V/47qw04WSk7wHWy43Kp2viH40X7duL4IbAs7QmR8PlKTxelcjb9dcssA==
From: Alexander Dahl <ada@thorsis.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/1] nvmem: microchip-otpc: Add support for SAM9X60
Date: Fri, 12 Apr 2024 16:08:02 +0200
Message-Id: <20240412140802.1571935-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240412140802.1571935-1-ada@thorsis.com>
References: <20240412140802.1571935-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

---
 .../dts/microchip/at91-sam9x60_curiosity.dts     |  4 ++++
 arch/arm/boot/dts/microchip/sam9x60.dtsi         |  7 +++++++
 drivers/nvmem/microchip-otpc.c                   | 16 +++++++++++++---
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
index c6fbdd29019f..754ce8134f73 100644
--- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
+++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
@@ -254,6 +254,10 @@ ethernet-phy@0 {
 	};
 };
 
+&otpc {
+	status = "okay";
+};
+
 &pinctrl {
 	adc {
 		pinctrl_adc_default: adc-default {
diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
index 291540e5d81e..010c45f533fe 100644
--- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
+++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
@@ -156,6 +156,13 @@ sdmmc1: sdio-host@90000000 {
 			status = "disabled";
 		};
 
+		otpc: efuse@eff00000 {
+			compatible = "microchip,sam9x60-otpc", "syscon";
+			reg = <0xeff00000 0xec>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index 7cf81738a3e0..af9ab1158a2b 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/dev_printk.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
@@ -248,29 +249,38 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 	int ret;
 
 	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
-	if (!otpc)
+	if (!otpc) {
+		dev_err(&pdev->dev, "devm_kzalloc() error\n");
 		return -ENOMEM;
+	}
 
 	otpc->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(otpc->base))
+	if (IS_ERR(otpc->base)) {
+		dev_err(&pdev->dev, "devm_platform_ioremap_resource() error\n");
 		return PTR_ERR(otpc->base);
+	}
 
 	otpc->dev = &pdev->dev;
 	ret = mchp_otpc_init_packets_list(otpc, &size);
-	if (ret)
+	if (ret) {
+		dev_err(&pdev->dev, "mchp_otpc_init_packets_list() error (%d)\n", ret);
 		return ret;
+	}
 
 	mchp_nvmem_config.dev = otpc->dev;
 	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
 	mchp_nvmem_config.size = size;
 	mchp_nvmem_config.priv = otpc;
 	nvmem = devm_nvmem_register(&pdev->dev, &mchp_nvmem_config);
+	if (!nvmem)
+		dev_err(&pdev->dev, "devm_nvmem_register() error\n");
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id __maybe_unused mchp_otpc_ids[] = {
 	{ .compatible = "microchip,sama7g5-otpc", },
+	{ .compatible = "microchip,sam9x60-otpc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mchp_otpc_ids);
-- 
2.39.2


