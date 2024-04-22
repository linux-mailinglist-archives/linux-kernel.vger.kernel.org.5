Return-Path: <linux-kernel+bounces-153180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DAC8ACAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465901F224A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081741448EA;
	Mon, 22 Apr 2024 10:30:56 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3F1448C6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 10:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781855; cv=none; b=ddSXt29Hplm9OLEaPljEGI7vdytlBIjplTPdALzsYzyaWNjFRl3TZFdjdvaZhda3zUPV2YJCaDxnk9enpLZvzvqTRgqu93/HUPTY9mqpxT1ta4N60jr6UK/vQiFEur/HuYMKidWR0zi5/pYdlM8rhyDr9bzgfB7DL6WOJOaFZco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781855; c=relaxed/simple;
	bh=6QHC+ODGPpPdfZMu3OB42pmbLRjqshGhT76S5AqEbwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scSySD6T3NHH/GL3NkBANelfN6HwY3yJjMGi9hXawyFSIrkqBEKPjVqefeSisMgh1DvUDxaVLVfnrFq7MRVyzg6NWzQnSAyvOhRSFor/tk5x4b+CdmhDsCyr7DwH8PEaKPUyRnkfzUFH8Bn0AycJXYnXw08kB1a4nI722k3G1LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by andre.telenet-ops.be with bizsmtp
	id EAWj2C00H0SSLxL01AWj4Y; Mon, 22 Apr 2024 12:30:45 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqw1-001cwH-C2;
	Mon, 22 Apr 2024 12:30:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1ryqwd-005i42-DK;
	Mon, 22 Apr 2024 12:30:43 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/11] Revert "drm: Switch DRM_DISPLAY_DP_AUX_BUS to depends on"
Date: Mon, 22 Apr 2024 12:30:36 +0200
Message-Id: <79824fec01eb9ab0673b9409f9b39cc8b5cc338d.1713780345.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713780345.git.geert+renesas@glider.be>
References: <cover.1713780345.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 4d15125d7fe637f401e64e33c99513adf6586fdd, as helper
code should always be selected by the driver that needs it, for the
convenience of the final user configuring a kernel.

The user who configures a kernel should not need to know which helpers
are needed for the driver he is interested in.  Making a driver depend
on helper code means that the user needs to know which helpers to enable
first, which is very user-unfriendly.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/bridge/Kconfig          | 6 +++---
 drivers/gpu/drm/bridge/analogix/Kconfig | 2 +-
 drivers/gpu/drm/display/Kconfig         | 1 -
 drivers/gpu/drm/mediatek/Kconfig        | 2 +-
 drivers/gpu/drm/msm/Kconfig             | 2 +-
 drivers/gpu/drm/panel/Kconfig           | 4 ++--
 drivers/gpu/drm/tegra/Kconfig           | 2 +-
 7 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 6015e2e4c2f620cf..a51ad2b3a0fb01e2 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -92,11 +92,11 @@ config DRM_FSL_LDB
 
 config DRM_ITE_IT6505
 	tristate "ITE IT6505 DisplayPort bridge"
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select EXTCON
 	select CRYPTO
@@ -225,10 +225,10 @@ config DRM_PARADE_PS8622
 
 config DRM_PARADE_PS8640
 	tristate "Parade PS8640 MIPI DSI to eDP Converter"
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
@@ -380,7 +380,6 @@ config DRM_TI_SN65DSI83
 
 config DRM_TI_SN65DSI86
 	tristate "TI SN65DSI86 DSI to eDP bridge"
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	select DRM_DISPLAY_DP_HELPER
@@ -389,6 +388,7 @@ config DRM_TI_SN65DSI86
 	select DRM_PANEL
 	select DRM_MIPI_DSI
 	select AUXILIARY_BUS
+	select DRM_DISPLAY_DP_AUX_BUS
 	help
 	  Texas Instruments SN65DSI86 DSI to eDP Bridge driver
 
diff --git a/drivers/gpu/drm/bridge/analogix/Kconfig b/drivers/gpu/drm/bridge/analogix/Kconfig
index ec98c94535736c0a..16d18dde483ae9c4 100644
--- a/drivers/gpu/drm/bridge/analogix/Kconfig
+++ b/drivers/gpu/drm/bridge/analogix/Kconfig
@@ -33,11 +33,11 @@ config DRM_ANALOGIX_DP
 config DRM_ANALOGIX_ANX7625
 	tristate "Analogix Anx7625 MIPI to DP interface support"
 	depends on DRM
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDCP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_MIPI_DSI
 	help
 	  ANX7625 is an ultra-low power 4K mobile HD transmitter
diff --git a/drivers/gpu/drm/display/Kconfig b/drivers/gpu/drm/display/Kconfig
index 0cd4396914224226..cffa2acdbc6c0988 100644
--- a/drivers/gpu/drm/display/Kconfig
+++ b/drivers/gpu/drm/display/Kconfig
@@ -11,7 +11,6 @@ config DRM_DISPLAY_DP_AUX_BUS
 	tristate "DRM DisplayPort AUX bus support"
 	depends on DRM
 	depends on OF || COMPILE_TEST
-	default y
 
 config DRM_DISPLAY_DP_AUX_CEC
 	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 2add54486ac4ab11..50bb28327f65fbf5 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -22,11 +22,11 @@ config DRM_MEDIATEK
 
 config DRM_MEDIATEK_DP
 	tristate "DRM DPTX Support for MediaTek SoCs"
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on DRM_MEDIATEK
 	select PHY_MTK_DP
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	help
 	  DRM/KMS Display Port driver for MediaTek SoCs.
 
diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
index 28a898722ace789b..2055266506e5adf0 100644
--- a/drivers/gpu/drm/msm/Kconfig
+++ b/drivers/gpu/drm/msm/Kconfig
@@ -5,7 +5,6 @@ config DRM_MSM
 	depends on ARCH_QCOM || SOC_IMX5 || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on DRM
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on IOMMU_SUPPORT
 	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
@@ -16,6 +15,7 @@ config DRM_MSM
 	select IOMMU_IO_PGTABLE
 	select QCOM_MDT_LOADER if ARCH_QCOM
 	select REGULATOR
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_EXEC
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index ed7949bebad812c9..5073c45481d55821 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -571,11 +571,11 @@ config DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01
 config DRM_PANEL_SAMSUNG_ATNA33XC20
 	tristate "Samsung ATNA33XC20 eDP panel"
 	depends on BACKLIGHT_CLASS_DEVICE
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	depends on PM
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	help
 	  DRM panel driver for the Samsung ATNA33XC20 panel. This panel can't
 	  be handled by the DRM_PANEL_SIMPLE driver because its power
@@ -811,12 +811,12 @@ config DRM_PANEL_STARTEK_KD070FHFID015
 config DRM_PANEL_EDP
 	tristate "support for simple Embedded DisplayPort panels"
 	depends on BACKLIGHT_CLASS_DEVICE
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	depends on PM
 	select VIDEOMODE_HELPERS
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	help
 	  DRM panel driver for dumb eDP panels that need at most a regulator and
diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index e0385d175ec6d266..44381ee6ea9e36f7 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -4,11 +4,11 @@ config DRM_TEGRA
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on DRM
-	depends on DRM_DISPLAY_DP_AUX_BUS
 	depends on DRM_DISPLAY_HELPER
 	depends on OF
 	select DRM_DISPLAY_DP_HELPER
 	select DRM_DISPLAY_HDMI_HELPER
+	select DRM_DISPLAY_DP_AUX_BUS
 	select DRM_KMS_HELPER
 	select DRM_MIPI_DSI
 	select DRM_PANEL
-- 
2.34.1


