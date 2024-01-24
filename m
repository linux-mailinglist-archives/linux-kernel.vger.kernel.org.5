Return-Path: <linux-kernel+bounces-37334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0736683AE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9381F24CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CCF7CF38;
	Wed, 24 Jan 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eDrSbReg"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB817CF19
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113771; cv=none; b=rGe/RHHMNZ7qlLn5rmbR8XErQvoMwhsQ2+UrzqNUaOphuXlKLcwQio5gBnXD9zT/q+5Xf5BXpVQ2ELgDL/vrYoSZX98sJPJfUdITAnDGEYmvyhL5fm4tsJoYr7njdsu09W1TUxxL/pMBYOpST25fqiNuJ6d/2NiN+t5lgt8vLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113771; c=relaxed/simple;
	bh=3GeCVU9lFpVvzptLtm037mOVoLEWSSkoXOYnJm5Y+rk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qyFbUoEeS3AnFCIB+tt244S3gS6A4a4eKmBLZ9UqYbUMRr0/WIVW5RKQtTvL9kKi+qID4mk+rULzfu9m2Jdlq7YonR74vw70NNcYX82DC1AffLS48ewwggcEdH72LcmCEEe++UTuKg0wig8T1HQch6T7HB3RnX9EUkK8mjxZySI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eDrSbReg; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OGSwpN084768;
	Wed, 24 Jan 2024 10:28:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706113738;
	bh=x+L2uYKGyOxnn6Ah2qzfgvE5YuE+kUNuvs4KAY+aCXo=;
	h=From:To:CC:Subject:Date;
	b=eDrSbRegk2oycGuo83fL8HkP3D4ThSGNvWdqFuwXIKoM0pToyTX5EnY43wBCbnZUL
	 Dc5iVGn+oeETx3irJ8qscDY4ZqkdW0kOGpkYgD13k7APoR9nQkiVQC1howTc882XdO
	 I7oFLK8365+lt3ESOsVE+8/5tDgaqVg0GqdSHMow=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OGSwGH004719
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 10:28:58 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 10:28:58 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 10:28:58 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OGSvLu108543;
	Wed, 24 Jan 2024 10:28:57 -0600
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Add more TI Keystone support
Date: Wed, 24 Jan 2024 10:28:56 -0600
Message-ID: <20240124162857.111915-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The Keystone platforms used their own keystone_defconfig mostly to
enable CONFIG_ARM_LPAE which could not be added to the multi_v7 config.
Now that we have multi_v7_lpae_defconfig/lpae.config target we can and
should use that defconfig for Keystone. Add the remaining must have
options for Keystone support to multi_v7_defconfig.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ecb3e286107a4..04ba674e03f60 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -183,6 +183,7 @@ CONFIG_PCIE_RCAR_HOST=y
 CONFIG_PCI_RCAR_GEN2=y
 CONFIG_PCI_LAYERSCAPE=y
 CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_KEYSTONE_HOST=y
 CONFIG_PCI_ENDPOINT=y
 CONFIG_PCI_ENDPOINT_CONFIGFS=y
 CONFIG_PCI_EPF_TEST=m
@@ -191,6 +192,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_OMAP_OCP2SCP=y
 CONFIG_ARM_SCMI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_BCM47XX_NVRAM=y
 CONFIG_BCM47XX_SPROM=y
@@ -280,6 +282,8 @@ CONFIG_DWMAC_DWC_QOS_ETH=y
 CONFIG_TI_CPSW=y
 CONFIG_TI_CPSW_SWITCHDEV=y
 CONFIG_TI_CPTS=y
+CONFIG_TI_KEYSTONE_NETCP=y
+CONFIG_TI_KEYSTONE_NETCP_ETHSS=y
 CONFIG_XILINX_EMACLITE=y
 CONFIG_SFP=m
 CONFIG_BROADCOM_PHY=y
@@ -292,6 +296,8 @@ CONFIG_CAN_AT91=m
 CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_SUN4I=y
 CONFIG_CAN_XILINXCAN=y
+CONFIG_CAN_C_CAN=m
+CONFIG_CAN_C_CAN_PLATFORM=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_MCP251X=y
 CONFIG_MDIO_MSCC_MIIM=m
@@ -335,6 +341,7 @@ CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_MAX77693_HAPTIC=m
 CONFIG_INPUT_MAX8997_HAPTIC=m
+CONFIG_INPUT_GPIO_DECODER=m
 CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_AXP20X_PEK=m
 CONFIG_INPUT_DA9063_ONKEY=m
@@ -436,6 +443,7 @@ CONFIG_SPI_ATMEL_QUADSPI=m
 CONFIG_SPI_BCM2835=y
 CONFIG_SPI_BCM2835AUX=y
 CONFIG_SPI_CADENCE=y
+CONFIG_SPI_CADENCE_QUADSPI=y
 CONFIG_SPI_DAVINCI=y
 CONFIG_SPI_FSL_QUADSPI=m
 CONFIG_SPI_GXP=m
@@ -1073,6 +1081,7 @@ CONFIG_HWSPINLOCK_OMAP=y
 CONFIG_HWSPINLOCK_QCOM=y
 CONFIG_OMAP2PLUS_MBOX=y
 CONFIG_BCM2835_MBOX=y
+CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_STM32_IPCC=m
 CONFIG_QCOM_IPCC=y
@@ -1133,11 +1142,15 @@ CONFIG_ARCH_TEGRA_2x_SOC=y
 CONFIG_ARCH_TEGRA_3x_SOC=y
 CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_ARCH_TEGRA_124_SOC=y
+CONFIG_SOC_TI=y
+CONFIG_KEYSTONE_NAVIGATOR_QMSS=y
+CONFIG_KEYSTONE_NAVIGATOR_DMA=y
 CONFIG_RASPBERRYPI_POWER=y
 CONFIG_QCOM_CPR=y
 CONFIG_QCOM_RPMHPD=y
 CONFIG_QCOM_RPMPD=y
 CONFIG_ROCKCHIP_PM_DOMAINS=y
+CONFIG_TI_SCI_PM_DOMAINS=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=m
 CONFIG_ARM_TEGRA_DEVFREQ=m
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=m
@@ -1193,10 +1206,13 @@ CONFIG_PWM_STM32=m
 CONFIG_PWM_STM32_LP=m
 CONFIG_PWM_SUN4I=y
 CONFIG_PWM_TEGRA=y
+CONFIG_PWM_TIECAP=m
 CONFIG_PWM_VT8500=y
 CONFIG_KEYSTONE_IRQ=y
 CONFIG_RESET_MCHP_SPARX5=y
 CONFIG_RESET_SCMI=y
+CONFIG_RESET_TI_SCI=m
+CONFIG_RESET_TI_SYSCON=m
 CONFIG_PHY_SUN4I_USB=y
 CONFIG_PHY_SUN9I_USB=y
 CONFIG_PHY_BRCM_USB=m
-- 
2.39.2


