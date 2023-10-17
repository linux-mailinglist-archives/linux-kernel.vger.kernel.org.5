Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059DF7CBF24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbjJQJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbjJQJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:27:49 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA5182
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:39 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c503dbe50dso59645261fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697534857; x=1698139657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+rojG+D/Wj1A75mgwuu1cZCyQOB+WXYhLC8Beuvlmjc=;
        b=LFp0AwzqFrO70/gkp9iUCzs8Y6zxuDBsoZufjI85HySchDs4ej9VMjyyDNVvNpGpDN
         ZaVWNFPA9WO4jacq7ACrjwJ5x7MbNNfR3hOJpw5Dc7ygEHNytlDXhI24RVWquTr9N2Rn
         DsnGnsh9+Iu0W0xK2vOOjDFiGdjKlrrNCSwofv4aNpnTf/X07fC4RMdLrFiL0AcWqRTo
         xv3HKxr/BziCaUjDLBQpKt0n0r1WuPaCaHpMDZdLzY8tzF0e00mIzFLavTNQ2NrYhCua
         UBTkCHWa3WA0jIEXZLTCb2GLQCwGC/fe6xAg1zxU4Ydea6exAQiLynAscsdc3kFQWJk3
         JrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697534857; x=1698139657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rojG+D/Wj1A75mgwuu1cZCyQOB+WXYhLC8Beuvlmjc=;
        b=gWxRuohsGkDZLgGbPddDQPHx5sMePppeNwwzrlDjsVVvWVwn8mAAD+1O45a9s1LWRX
         h5ixTFWW0wdWvt9Zep40Lu9ob8f3oVJb25y6EMBYeuUSzFB992TjxvKAjHn8ysGEZOYD
         Ha6T39M713jv2p4YU52PhE9ioyc9xt1NC39Lh6UEvjINVPdXfk905kaz3D8bBBMYSh0t
         SISk7GhT4UYarUitCRTnbnaAN9jHmeyyGn4mDp+GFdHd5tYKGmbkdfae9drHzYB+KZMP
         QxAaq0sRAz+emf/Ru4SPVvqLuymzK+Hz6s/bvgwf/wmS/2qrmn6ov5bamxSAher9szry
         ChUg==
X-Gm-Message-State: AOJu0YxA/Fw2lijH5On7NWmvUHNWbwEInasXBHhdqHM1sjDuiTPkHn0J
        cjlHvib5G4AVZaCwI/or6Ig9IQ==
X-Google-Smtp-Source: AGHT+IFMls5YwVJqJg2G+mfa76+4WbXL/2zRR+vPCq5zvsJLyFTg1fTnFnPWvkFj1FnEjf+wstYgNQ==
X-Received: by 2002:a2e:3611:0:b0:2c5:6cb:2e50 with SMTP id d17-20020a2e3611000000b002c506cb2e50mr1297408lja.27.1697534857516;
        Tue, 17 Oct 2023 02:27:37 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f1ee:b000:ce90:ed14])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003fe1c332810sm9460787wms.33.2023.10.17.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:27:36 -0700 (PDT)
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
Subject: [PATCH v5 01/15] firmware: qcom: move Qualcomm code into its own directory
Date:   Tue, 17 Oct 2023 11:27:18 +0200
Message-Id: <20231017092732.19983-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017092732.19983-1-brgl@bgdev.pl>
References: <20231017092732.19983-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
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
index d3c55fe32470..c3ae177c36e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17933,13 +17933,13 @@ QUALCOMM QSEECOM DRIVER
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

