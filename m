Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF67C84E8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjJMLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjJMLs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:48:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E51BBF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4065dea9a33so20576075e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697197734; x=1697802534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6K09Y088XexdMauihB7tdz9YQTYF7/0bl19cPr5Q5A=;
        b=jZtU7wtqk/AoYAse6fb/gcCj+ge9dz0qVkpv8H6EAysHrGMronNKxixPPiiAhWtXUe
         bE/gPebd3+HvwwMt3x7LmWm8SwedWoi88caiTpa1f7NXxO5u/Bpf1aoC+MEehu/HI2Sk
         Fhl5WVYF5SjBTRDV2Bctu9cjKfzdlJvtKKb/Hxmeevv4dyVp5UvrnhKZJY6hYx9LYjl5
         NX8r4xpEbut1Gg8pju/Lk7/WkC7fuJlU3GyiCWBZhYEflZ3qTK4KkI/EA7mWeuTkUCn4
         feiLHsa2Vg6r6dMvX6cDjSEqIDllAh06X07CFYFw5dm6Limj4FL74zB9JlIEbjVtooth
         P4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197734; x=1697802534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6K09Y088XexdMauihB7tdz9YQTYF7/0bl19cPr5Q5A=;
        b=SNwhvyWBsa9114dDpEGXRVygG3c1gVZCEPsPN7TWMFRnVJ+5VBXo9HGRWs8xMy+Lpi
         wwIwOEI4zEjPIcwvK6WjGk3DgmXKj2nsxd9IupSWVyma1rd3e+g1Iv7+I98RRtH3df6S
         xLPBxn80azGeQZrMX743iZzesg6tPgy35/LjvWELmVKbjJmew9y8cgLt/+6TomBtiDFH
         rBblbyNSiPkwPFgwjrGmVTUTM2//hLQEbLSxWkTv44o05sbT5xjUm1wrOuaR0os7WF6C
         eHKgQOY4N88lueDCKUzww8GaZ02EFR0ekk02Sy1xu1AYblW9ShXiyGFGi4zCVzEfZSjI
         xznw==
X-Gm-Message-State: AOJu0YyiCWJqg60t0URPP4g3/8w2ZIJ1XhiW78YPW3ZDuBB6EWSd+Uad
        Bfn7vVvJUar16J/hXW06BIUk3Q==
X-Google-Smtp-Source: AGHT+IEJPz0H2qQX8CUPXs+F4O0gQvXaW4Tl6lcsbDcdyUJFwnfqxdX6pJCmcKkqyhn1RigNOYD/6Q==
X-Received: by 2002:a1c:7419:0:b0:405:7b92:453e with SMTP id p25-20020a1c7419000000b004057b92453emr23606459wmc.37.1697197733668;
        Fri, 13 Oct 2023 04:48:53 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4209:13a:988d:80be])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b00407754b998dsm974509wms.27.2023.10.13.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:48:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v4 01/15] firmware: qcom: move Qualcomm code into its own directory
Date:   Fri, 13 Oct 2023 13:48:29 +0200
Message-Id: <20231013114843.63205-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231013114843.63205-1-brgl@bgdev.pl>
References: <20231013114843.63205-1-brgl@bgdev.pl>
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
Acked-by: Elliot Berman <quic_eberman@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
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
index 0ad7caea2ee2..eac76b8de7e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17930,13 +17930,13 @@ QUALCOMM QSEECOM DRIVER
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

