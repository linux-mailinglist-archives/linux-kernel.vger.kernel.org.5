Return-Path: <linux-kernel+bounces-38899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F0E83C813
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20AFB1F24D57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8587A12FF9A;
	Thu, 25 Jan 2024 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h7F61qQR"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F374612FF7D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200335; cv=none; b=jVu2wisBl99hdXoPyctqfMkAmeoyd8gLowPbTkqJB3wR2B4K2MuymiAELXOPQNzOySBeXZqKGZyLDR7bQxOJQeZ6HAjAGOFN1V0kZAeG9fSVIp2/CK081mmK/RZZMoKUT7NqVE4oKuLZdBP49JAtGq2vGuAitHQo/a3dnQFbnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200335; c=relaxed/simple;
	bh=P7bz9qpD+UZBuEr+nq11pGI6DFsBPrkpJJ0oMufejc4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HFAvV2Ezl/2HlCxIsYZNv17rFFqFPb+YVvAJCvm1TsTgUtOnBHVyf+MaNxUZTIB3QZoZbZTUocwnpq1hpuyuFNifU/FmgQ5xF4F4C+UxAE7/XcdnxJ8OEfDpigHBqgiiLqXLMzbhSZ7ujZ0qmzYwMGc5LFknn8GGAZVbFIXbQ2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h7F61qQR; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PGVlSC087734;
	Thu, 25 Jan 2024 10:31:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706200307;
	bh=Cl3Qt1VMAoc3d0+jGr54RxrsX3G1o93szqP7qlDSK1E=;
	h=From:To:CC:Subject:Date;
	b=h7F61qQRef5kSLTr6M1BaQmb0SCm/OvS3UTesx4/2r07eMvVlpha3ONVGCUlYraEb
	 Do68RW1N4shH4zd6g4unN4s9mHEQ0nULNMVmD98i9pwUQarTgguDtPqN8OIpI9BT7N
	 X+RaI0P/9NzK5Rlp6UXYO8e+4xHYJHKkNBxT53OE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PGVl8d118838
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 10:31:47 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 10:31:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 10:31:47 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PGVkHR049591;
	Thu, 25 Jan 2024 10:31:46 -0600
From: Andrew Davis <afd@ti.com>
To: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH v2] ARM: multi_v7_defconfig: Add more TI Keystone support
Date: Thu, 25 Jan 2024 10:31:45 -0600
Message-ID: <20240125163145.87055-1-afd@ti.com>
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
should use that defconfig for Keystone. Add the remaining must-have
options for Keystone support to multi_v7_defconfig.

TI_SCI_*:
TI_MESSAGE_MANAGER:
 Allows TI-SCI communication with system control firmware (PMMC) on K2G.

TI_KEYSTONE_NETCP*:
KEYSTONE_NAVIGATOR*:
 Network driver, needed for NFS boot.

PCI_KEYSTONE*:
CAN_C_CAN*:
INPUT_GPIO_DECODER:
SPI_CADENCE_QUADSPI:
PWM_TIECAP:
 Miscellaneous on-chip peripherals. Added as modules where possible.

RESET_TI*:
 Used by DSP Remoteproc driver.

bloat-o-meter:
add/remove: 387/0 grow/shrink: 6/0 up/down: 130945/0 (130945)
Total: Before=22791863, After=22922808, chg +0.57%

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Added some info on why each of these configs were added
 - Added bloat-o-meter output

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


