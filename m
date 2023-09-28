Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D349C7B171D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjI1JVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1JVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:21:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD4C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:02 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4064a0639b6so20751365e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695892861; x=1696497661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM/a/+V3p5AIwbNsZKgGbA5ufrscHGvXeuqTdYg9svM=;
        b=z/WYaGG7eX2uwET6RaaIJ+PafKNFbNsyAlAzbahzqr/lfeajIRMMD2aqjC5bo403Hg
         YMdKcnn+HWtqnFfnnKwPnd5pxO4F6lZ7FTaa3BYeKuRFuSY3QgjfXF1j+/o4TtjvXJ2D
         wqRSShAhDn8Ic9sL9nmmybdE5z/XySid7YoBeUX7e0dUg1ldb6w8V5QPedsUfkkQJdqF
         Zj1VB5LPeCL+H81+a9m72CWlMjWOooueBvu6jVPRc6nqlAgkq9wXtFIN4SAcQho60DKQ
         lWhNhK5KcveK0gA77I5PvErgMWWCHUO+j4o6lbB4By0QS4Yzn+//r927za6F2iY/tWpV
         1NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695892861; x=1696497661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZM/a/+V3p5AIwbNsZKgGbA5ufrscHGvXeuqTdYg9svM=;
        b=qF6YFjXAEaPBt8hHYr89WYaZdy6PRVHsXe5848aNjAn9yBDJrcheCWQxDwYRLdgHRN
         GTvYb9G5iLAtrCrRDZr8XLdJ0z7aJzqu/6KIOlqPpYO0LTscmWNVYDHLgzTO2FqZOrR0
         CA4RdiupNGtl4OCnzcZEtiYw1vnDFp5H5Aegn/GMXvpMxTqEzn5lDyBF0lwJsINVRLrf
         1Y2Re0Ticxdua3R7uZtAvsEWzyN6JaCZuh6HZ0ojRHZ0zCrx9M9UZRZ9NfGGyUtWM3hL
         hoQ/a6T7+cFEOLQeRhcK5HZi2bwN8pxny7Dlf6v6ZowNngi2rXNJMjhm3/64amM3X8O0
         E7YA==
X-Gm-Message-State: AOJu0YwUfabINrVxcbH/Iayli/PUAByIeTCvB2zzqVE8PA9sAREJ+yVw
        kI12gaThJ7sYxdVymxSqmNS2WQ==
X-Google-Smtp-Source: AGHT+IHhFLv4bVcddNImrQFdy4LHQLiifmm7KbUsOlGmkTHzYZCNQ+x3wbaR2X4ghkNRrDOV7KQ4Yw==
X-Received: by 2002:a05:600c:3658:b0:406:517f:ac71 with SMTP id y24-20020a05600c365800b00406517fac71mr766709wmq.29.1695892861085;
        Thu, 28 Sep 2023 02:21:01 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6e4c:e3c1:5cb8:b60e])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe7c9000000b003197efd1e7bsm5009156wrn.114.2023.09.28.02.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 02:21:00 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2 01/11] firmware: qcom: move Qualcomm code into its own directory
Date:   Thu, 28 Sep 2023 11:20:30 +0200
Message-Id: <20230928092040.9420-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928092040.9420-1-brgl@bgdev.pl>
References: <20230928092040.9420-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We're getting more and more qcom specific .c files in drivers/firmware/
and about to get even more. Create a separate directory for Qualcomm
firmware drivers and move existing sources in there.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 MAINTAINERS                                   |  4 +-
 drivers/firmware/Kconfig                      | 48 +---------------
 drivers/firmware/Makefile                     |  5 +-
 drivers/firmware/qcom/Kconfig                 | 56 +++++++++++++++++++
 drivers/firmware/qcom/Makefile                |  9 +++
 drivers/firmware/{ => qcom}/qcom_qseecom.c    |  0
 .../{ => qcom}/qcom_qseecom_uefisecapp.c      |  0
 drivers/firmware/{ => qcom}/qcom_scm-legacy.c |  0
 drivers/firmware/{ => qcom}/qcom_scm-smc.c    |  0
 drivers/firmware/{ => qcom}/qcom_scm.c        |  0
 drivers/firmware/{ => qcom}/qcom_scm.h        |  0
 11 files changed, 69 insertions(+), 53 deletions(-)
 create mode 100644 drivers/firmware/qcom/Kconfig
 create mode 100644 drivers/firmware/qcom/Makefile
 rename drivers/firmware/{ => qcom}/qcom_qseecom.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_qseecom_uefisecapp.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm-legacy.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm-smc.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm.c (100%)
 rename drivers/firmware/{ => qcom}/qcom_scm.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 861a16b4586c..88c2186b4975 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17887,13 +17887,13 @@ QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/firmware/qcom_qseecom.c
+F:	drivers/firmware/qcom/qcom_qseecom.c
 
 QUALCOMM QSEECOM UEFISECAPP DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-F:	drivers/firmware/qcom_qseecom_uefisecapp.c
+F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
 
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 817e011a8945..74d00b0c83fe 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -188,53 +188,6 @@ config MTK_ADSP_IPC
 	  ADSP exists on some mtk processors.
 	  Client might use shared memory to exchange information with ADSP.
 
-config QCOM_SCM
-	tristate
-
-config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
-	bool "Qualcomm download mode enabled by default"
-	depends on QCOM_SCM
-	help
-	  A device with "download mode" enabled will upon an unexpected
-	  warm-restart enter a special debug mode that allows the user to
-	  "download" memory content over USB for offline postmortem analysis.
-	  The feature can be enabled/disabled on the kernel command line.
-
-	  Say Y here to enable "download mode" by default.
-
-config QCOM_QSEECOM
-	bool "Qualcomm QSEECOM interface driver"
-	depends on QCOM_SCM=y
-	select AUXILIARY_BUS
-	help
-	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
-	  in the Trust Zone. This module provides an interface to that via the
-	  QSEECOM mechanism, using SCM calls.
-
-	  The QSEECOM interface allows, among other things, access to applications
-	  running in the SEE. An example of such an application is 'uefisecapp',
-	  which is required to access UEFI variables on certain systems. If
-	  selected, the interface will also attempt to detect and register client
-	  devices for supported applications.
-
-	  Select Y here to enable the QSEECOM interface driver.
-
-config QCOM_QSEECOM_UEFISECAPP
-	bool "Qualcomm SEE UEFI Secure App client driver"
-	depends on QCOM_QSEECOM
-	depends on EFI
-	help
-	  Various Qualcomm SoCs do not allow direct access to EFI variables.
-	  Instead, these need to be accessed via the UEFI Secure Application
-	  (uefisecapp), residing in the Secure Execution Environment (SEE).
-
-	  This module provides a client driver for uefisecapp, installing efivar
-	  operations to allow the kernel accessing EFI variables, and via that also
-	  provide user-space with access to EFI variables via efivarfs.
-
-	  Select Y here to provide access to EFI variables on the aforementioned
-	  platforms.
-
 config SYSFB
 	bool
 	select BOOT_VESA_SUPPORT
@@ -320,6 +273,7 @@ source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/psci/Kconfig"
+source "drivers/firmware/qcom/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
 source "drivers/firmware/xilinx/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index cb18fd8882dc..5f9dab82e1a0 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -17,10 +17,6 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
-obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
-qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
-obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
-obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
@@ -36,6 +32,7 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
+obj-y				+= qcom/
 obj-y				+= smccc/
 obj-y				+= tegra/
 obj-y				+= xilinx/
diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
new file mode 100644
index 000000000000..3f05d9854ddf
--- /dev/null
+++ b/drivers/firmware/qcom/Kconfig
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.rst.
+#
+
+menu "Qualcomm firmware drivers"
+
+config QCOM_SCM
+	tristate
+
+config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
+	bool "Qualcomm download mode enabled by default"
+	depends on QCOM_SCM
+	help
+	  A device with "download mode" enabled will upon an unexpected
+	  warm-restart enter a special debug mode that allows the user to
+	  "download" memory content over USB for offline postmortem analysis.
+	  The feature can be enabled/disabled on the kernel command line.
+
+	  Say Y here to enable "download mode" by default.
+
+config QCOM_QSEECOM
+	bool "Qualcomm QSEECOM interface driver"
+	depends on QCOM_SCM=y
+	select AUXILIARY_BUS
+	help
+	  Various Qualcomm SoCs have a Secure Execution Environment (SEE) running
+	  in the Trust Zone. This module provides an interface to that via the
+	  QSEECOM mechanism, using SCM calls.
+
+	  The QSEECOM interface allows, among other things, access to applications
+	  running in the SEE. An example of such an application is 'uefisecapp',
+	  which is required to access UEFI variables on certain systems. If
+	  selected, the interface will also attempt to detect and register client
+	  devices for supported applications.
+
+	  Select Y here to enable the QSEECOM interface driver.
+
+config QCOM_QSEECOM_UEFISECAPP
+	bool "Qualcomm SEE UEFI Secure App client driver"
+	depends on QCOM_QSEECOM
+	depends on EFI
+	help
+	  Various Qualcomm SoCs do not allow direct access to EFI variables.
+	  Instead, these need to be accessed via the UEFI Secure Application
+	  (uefisecapp), residing in the Secure Execution Environment (SEE).
+
+	  This module provides a client driver for uefisecapp, installing efivar
+	  operations to allow the kernel accessing EFI variables, and via that also
+	  provide user-space with access to EFI variables via efivarfs.
+
+	  Select Y here to provide access to EFI variables on the aforementioned
+	  platforms.
+
+endmenu
diff --git a/drivers/firmware/qcom/Makefile b/drivers/firmware/qcom/Makefile
new file mode 100644
index 000000000000..c9f12ee8224a
--- /dev/null
+++ b/drivers/firmware/qcom/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the linux kernel.
+#
+
+obj-$(CONFIG_QCOM_SCM)		+= qcom-scm.o
+qcom-scm-objs += qcom_scm.o qcom_scm-smc.o qcom_scm-legacy.o
+obj-$(CONFIG_QCOM_QSEECOM)	+= qcom_qseecom.o
+obj-$(CONFIG_QCOM_QSEECOM_UEFISECAPP) += qcom_qseecom_uefisecapp.o
diff --git a/drivers/firmware/qcom_qseecom.c b/drivers/firmware/qcom/qcom_qseecom.c
similarity index 100%
rename from drivers/firmware/qcom_qseecom.c
rename to drivers/firmware/qcom/qcom_qseecom.c
diff --git a/drivers/firmware/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
similarity index 100%
rename from drivers/firmware/qcom_qseecom_uefisecapp.c
rename to drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom/qcom_scm-legacy.c
similarity index 100%
rename from drivers/firmware/qcom_scm-legacy.c
rename to drivers/firmware/qcom/qcom_scm-legacy.c
diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom/qcom_scm-smc.c
similarity index 100%
rename from drivers/firmware/qcom_scm-smc.c
rename to drivers/firmware/qcom/qcom_scm-smc.c
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
similarity index 100%
rename from drivers/firmware/qcom_scm.c
rename to drivers/firmware/qcom/qcom_scm.c
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom/qcom_scm.h
similarity index 100%
rename from drivers/firmware/qcom_scm.h
rename to drivers/firmware/qcom/qcom_scm.h
-- 
2.39.2

