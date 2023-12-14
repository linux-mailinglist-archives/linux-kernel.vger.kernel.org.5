Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9D813A23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573086AbjLNSkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjLNSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:39:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEA0124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:40:04 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABA7C433C8;
        Thu, 14 Dec 2023 18:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702579204;
        bh=J4U6wb6lu/CHw150O1fiDTxZ3HL8M735WWSgKLN8raA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I28hsePzUIMHYmJ8XbVLvoJrdUVS8RocUspbPYh6PhpbIoOpr+YsDl6z1iddDUejT
         bk9tMB4EimrncVOJqFgj3E1DgL3+gkKITvGse5MZMgZ38e5Xlv+E8mGLun/PGtiqeC
         52I2JrjkiAa46CFBpLWrD7pG5zAh/0WRHYLUbMWHjWWuRixAuVwhtsytQwFu23CWu3
         dg42Mp6c4WTYAUZeRuuwqAF14xYPf4VRIq6xEr7fgiScS7J4T0/R6cHOH1kpTBSnxe
         xTWH6iUnEljd/LSMKz7ejQqSc7Yf9NXUlgEj98nuYhOQm2O0C2mqeIvfjn+4R8w3A6
         bNX6TVB0KDuRA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Wentong Wu <wentong.wu@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mei: rework Kconfig dependencies
Date:   Thu, 14 Dec 2023 18:39:32 +0000
Message-Id: <20231214183946.109124-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214183946.109124-1-arnd@kernel.org>
References: <20231214183946.109124-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The dependencies in the mei framework are inconsistent, with some symbols
using 'select INTEL_MEI' to force it being enabled and others using
'depends on INTEL_MEI'.

In general, one should not select user-visible symbols, so change all
of these to normal dependencies, but change the default on INTEL_MEI to
be enabled when building a kernel for an Intel CPU with ME or a generic
x86 kernel.

Having consistent dependencies makes the 'menuconfig' listing more
readable by using proper indentation.

A large if/endif block is just a simpler syntax than repeating the
dependencies for each symbol.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This does not fix a bug, but seems like a sensible cleanup to me,
making the logic less error-prone for future changes. Feel free
to just take the first patch and ignore this one if I missed
an important reason for the original variant, or if you prefer
a different method.
---
 drivers/misc/mei/Kconfig           | 14 ++++++--------
 drivers/misc/mei/gsc_proxy/Kconfig |  2 +-
 drivers/misc/mei/hdcp/Kconfig      |  2 +-
 drivers/misc/mei/pxp/Kconfig       |  2 +-
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 1e28ca23a74a..67d9391f1855 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -3,6 +3,7 @@
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on X86 && PCI
+	default GENERIC_CPU || MCORE2 || MATOM || X86_GENERIC
 	help
 	  The Intel Management Engine (Intel ME) provides Manageability,
 	  Security and Media services for system containing Intel chipsets.
@@ -11,10 +12,11 @@ config INTEL_MEI
 	  For more information see
 	  <https://software.intel.com/en-us/manageability/>
 
+if INTEL_MEI
+
 config INTEL_MEI_ME
 	tristate "ME Enabled Intel Chipsets"
-	select INTEL_MEI
-	depends on X86 && PCI
+	default y
 	help
 	  MEI support for ME Enabled Intel chipsets.
 
@@ -38,8 +40,6 @@ config INTEL_MEI_ME
 
 config INTEL_MEI_TXE
 	tristate "Intel Trusted Execution Environment with ME Interface"
-	select INTEL_MEI
-	depends on X86 && PCI
 	help
 	  MEI Support for Trusted Execution Environment device on Intel SoCs
 
@@ -48,9 +48,7 @@ config INTEL_MEI_TXE
 
 config INTEL_MEI_GSC
 	tristate "Intel MEI GSC embedded device"
-	depends on INTEL_MEI
 	depends on INTEL_MEI_ME
-	depends on X86 && PCI
 	depends on DRM_I915
 	help
 	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
@@ -62,7 +60,6 @@ config INTEL_MEI_GSC
 
 config INTEL_MEI_VSC_HW
 	tristate "Intel visual sensing controller device transport driver"
-	depends on INTEL_MEI
 	depends on ACPI && SPI
 	depends on GPIOLIB || COMPILE_TEST
 	help
@@ -75,7 +72,6 @@ config INTEL_MEI_VSC_HW
 config INTEL_MEI_VSC
 	tristate "Intel visual sensing controller device with ME interface"
 	depends on INTEL_MEI_VSC_HW
-	depends on INTEL_MEI
 	help
 	  Intel MEI over SPI driver for Intel visual sensing controller
 	  (IVSC) device embedded in IA platform. It supports camera sharing
@@ -88,3 +84,5 @@ config INTEL_MEI_VSC
 source "drivers/misc/mei/hdcp/Kconfig"
 source "drivers/misc/mei/pxp/Kconfig"
 source "drivers/misc/mei/gsc_proxy/Kconfig"
+
+endif
diff --git a/drivers/misc/mei/gsc_proxy/Kconfig b/drivers/misc/mei/gsc_proxy/Kconfig
index 5f68d9f3d691..ac78b9d1eccd 100644
--- a/drivers/misc/mei/gsc_proxy/Kconfig
+++ b/drivers/misc/mei/gsc_proxy/Kconfig
@@ -3,7 +3,7 @@
 #
 config INTEL_MEI_GSC_PROXY
 	tristate "Intel GSC Proxy services of ME Interface"
-	select INTEL_MEI_ME
+	depends on INTEL_MEI_ME
 	depends on DRM_I915
 	help
          MEI Support for GSC Proxy Services on Intel platforms.
diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
index 54e1c9526909..9be312ec798d 100644
--- a/drivers/misc/mei/hdcp/Kconfig
+++ b/drivers/misc/mei/hdcp/Kconfig
@@ -3,7 +3,7 @@
 #
 config INTEL_MEI_HDCP
 	tristate "Intel HDCP2.2 services of ME Interface"
-	select INTEL_MEI_ME
+	depends on INTEL_MEI_ME
 	depends on DRM_I915
 	help
 	  MEI Support for HDCP2.2 Services on Intel platforms.
diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
index 4029b96afc04..838eae556dd4 100644
--- a/drivers/misc/mei/pxp/Kconfig
+++ b/drivers/misc/mei/pxp/Kconfig
@@ -4,7 +4,7 @@
 #
 config INTEL_MEI_PXP
 	tristate "Intel PXP services of ME Interface"
-	select INTEL_MEI_ME
+	depends on INTEL_MEI_ME
 	depends on DRM_I915
 	help
 	  MEI Support for PXP Services on Intel platforms.
-- 
2.39.2

