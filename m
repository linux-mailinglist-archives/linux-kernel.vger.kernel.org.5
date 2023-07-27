Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE0E7653BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjG0MZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjG0MYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:24:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1613B2D64;
        Thu, 27 Jul 2023 05:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB2661E51;
        Thu, 27 Jul 2023 12:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAA1C433C8;
        Thu, 27 Jul 2023 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690460617;
        bh=/shLq4qzxc3NXa/9E/Gu6HjzRfsdLokrY9AG3a6p8tU=;
        h=From:To:Cc:Subject:Date:From;
        b=YAwtkcpPf5xIaMIjG5UKw7gNsda0nETisMjiYC70/K3m++/7yygPbaekS3UPER+VD
         YewdPVJ+DFVWDvKh/o0DMQBvZVLSGwZ/8ygb4i4UvyT12p57rUU9xBrI2YosPy9p6T
         M8JoTCVcY1jSodRMmpb+cnJGbsarV+SNBdT0VBFiV+qqI873xlRBqRE2Z8sjLB5Ybd
         XzU+notVxM3VPHLRS1P4b1pc8qcbZilBiALGkWhpkt5yHR0TrNXxvXPLjJ66WL3GaO
         mliZHWMAnPIWH9BJSkBm2toRVe7kBTUGMF/QmD+DKmLDP53GEj696OlkSGFGLAr2cc
         /oWctlaVHvpsQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: ipu3-cio2: allow ipu_bridge to be a module again
Date:   Thu, 27 Jul 2023 14:22:58 +0200
Message-Id: <20230727122331.2421453-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This code was previously part of the VIDEO_IPU3_CIO2 driver, which could
be built-in or a loadable module, but after the move it turned into a
builtin-only driver. This fails to link when the I2C subsystem is a
module:

x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_unregister_sensors':
ipu-bridge.c:(.text+0x50): undefined reference to `i2c_unregister_device'
x86_64-linux-ld: drivers/media/pci/intel/ipu-bridge.o: in function `ipu_bridge_init':
ipu-bridge.c:(.text+0x9c9): undefined reference to `i2c_acpi_new_device_by_fwnode'

In general, drivers should not have to be built-in, so change the option
to a tristate with the corresponding dependency. This in turn opens a
new problem with the dependency, as the IPU bridge can be a loadable module
while the ipu3 driver itself is built-in, producing a new link failure:

86_64-linux-ld: drivers/media/pci/intel/ipu3/ipu3-cio2.o: in function `cio2_pci_probe':
ipu3-cio2.c:(.text+0x197e): undefined reference to `ipu_bridge_init'

In order to fix this, restore the old Kconfig option that controlled
the ipu bridge driver before it was split out, but make it select a
hidden symbol that now corresponds to the bridge driver.

When other drivers get added that share ipu-bridge, this should cover
all corner cases, and allow any combination of them to be built-in
or modular.

Fixes: 881ca25978c6f ("media: ipu3-cio2: rename cio2 bridge to ipu bridge and move out of ipu3")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/pci/intel/Kconfig      | 21 +++++----------------
 drivers/media/pci/intel/ipu-bridge.c |  3 +++
 drivers/media/pci/intel/ipu3/Kconfig | 20 ++++++++++++++++++++
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/media/pci/intel/Kconfig b/drivers/media/pci/intel/Kconfig
index 64a29b0b7033b..51b18fce6a1de 100644
--- a/drivers/media/pci/intel/Kconfig
+++ b/drivers/media/pci/intel/Kconfig
@@ -1,21 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IPU_BRIDGE
-	bool "Intel IPU Sensors Bridge"
-	depends on VIDEO_IPU3_CIO2 && ACPI
-	depends on I2C
+	tristate
+	depends on I2C && ACPI
 	help
-	  This extension provides an API for the Intel IPU driver to create
-	  connections to cameras that are hidden in the SSDB buffer in ACPI.
-	  It can be used to enable support for cameras in detachable / hybrid
-	  devices that ship with Windows.
-
-	  Say Y here if your device is a detachable / hybrid laptop that comes
-	  with Windows installed by the OEM, for example:
-
-		- Microsoft Surface models (except Surface Pro 3)
-		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
-		- Dell 7285
-
-	  If in doubt, say N here.
+	  This is a helper module for the IPU bridge, which can be
+	  used by ipu3 and other drivers. In order to handle module
+	  dependencies, this is selected by each driver that needs it.
 
 source "drivers/media/pci/intel/ipu3/Kconfig"
diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 62daa8c1f6b18..bd67c3e990ea8 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -493,3 +493,6 @@ int ipu_bridge_init(struct pci_dev *ipu)
 	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(ipu_bridge_init, INTEL_IPU_BRIDGE);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Intel IPU Sensors Bridge driver");
diff --git a/drivers/media/pci/intel/ipu3/Kconfig b/drivers/media/pci/intel/ipu3/Kconfig
index 9be06ee81ff05..0951545eab21a 100644
--- a/drivers/media/pci/intel/ipu3/Kconfig
+++ b/drivers/media/pci/intel/ipu3/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_IPU3_CIO2
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
 	select VIDEOBUF2_DMA_SG
+	select IPU_BRIDGE if CIO2_BRIDGE
 
 	help
 	  This is the Intel IPU3 CIO2 CSI-2 receiver unit, found in Intel
@@ -17,3 +18,22 @@ config VIDEO_IPU3_CIO2
 	  Say Y or M here if you have a Skylake/Kaby Lake SoC with MIPI CSI-2
 	  connected camera.
 	  The module will be called ipu3-cio2.
+
+config CIO2_BRIDGE
+	bool "IPU3 CIO2 Sensors Bridge"
+	depends on VIDEO_IPU3_CIO2 && ACPI
+	depends on I2C
+	help
+	  This extension provides an API for the ipu3-cio2 driver to create
+	  connections to cameras that are hidden in the SSDB buffer in ACPI.
+	  It can be used to enable support for cameras in detachable / hybrid
+	  devices that ship with Windows.
+
+	  Say Y here if your device is a detachable / hybrid laptop that comes
+	  with Windows installed by the OEM, for example:
+
+		- Microsoft Surface models (except Surface Pro 3)
+		- The Lenovo Miix line (for example the 510, 520, 710 and 720)
+		- Dell 7285
+
+	  If in doubt, say N here.
-- 
2.39.2

