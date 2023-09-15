Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C87A1A5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233673AbjIOJV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjIOJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8502105
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:24 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bf78950354so30979631fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769683; x=1695374483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya9Nj5WT/J10Cs78iLoaa7AD4/TmGlT+hGtAjhqtW2Y=;
        b=mICIbkTQZWTjUM/ueObufJQd1Xd0gFyMCkTk+ZKxm3T/v2ijmfM0ci3IScsMa/hbfW
         Mu5Dt+ZLCkU60EmB0h8/toUu/VHNAI/9u4Xv6m4I1NVfo9PRNPgarUPpcTiPQSJbS+tH
         xRPdfAQI819gCxR1Ms0pYnCPllJ8muVNXrqWpND5mThk8LrBZPSLj9q6JVJul/XF7ZJZ
         ugocWdNS8XemIZyFOJ1gVriyUspzObx6BiFW2QVK1gMzxQ4Z4cDLdlP2hSmHFf+kKLJ0
         bE8jyCLDdyR4Lhol3nW2ARcin55CfGxj4HBamvbxAO69DmOno059DSVkr3P4Cs34Jxot
         zNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769683; x=1695374483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ya9Nj5WT/J10Cs78iLoaa7AD4/TmGlT+hGtAjhqtW2Y=;
        b=YOHz/Dm2LXhY5G4OPD1b7w2ppdGY0WGOuRr8cyL6Z+6q6TDK1ZNGynC1ehvc/cVhMn
         5NbY9N/XMa9oSlklhtpfHctRqu4Zt+ExslVbut+O9RCVAWBxIiO0k1GsalPENNeMdoFq
         raDgcOxKd2dvC7VbrOCCWpC2fG0uLjhfEE+7Y5oRDnKHNfLXR949fZ4fgjqLfEo4dcQm
         IVfuJOzrDS9PnMdPK1kIGyybL3j8O8oCd7vjwXC+3tiOUVaTq+jTtduKre3oz0DkJmBG
         7PSOvLo9hJNRajSeloPPy8cTgGqnjZT/SvWihJGRhCoNwHK4545IH2zULmwlSMEk5ZoN
         28IA==
X-Gm-Message-State: AOJu0YwHXhDjJnTooxhX5Q51xNj0GXggULXo5gzA7ow5gNO+C+xZZWdn
        Jq16xElfBakIM1cJGocowTxxqfEoTaMIldehphbjQQ==
X-Google-Smtp-Source: AGHT+IFSHJRoQx1Ctyhwv1uESkr0oLROtRLqXN8zd1BUs3GoaoZqPq2EXshY166uThtfcvsIXkDBgA==
X-Received: by 2002:a2e:8019:0:b0:2bf:b142:bd13 with SMTP id j25-20020a2e8019000000b002bfb142bd13mr1075017ljg.4.1694769683203;
        Fri, 15 Sep 2023 02:21:23 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:22 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 08/17] pmdomain: qcom: Move Kconfig options to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:19:54 +0200
Message-Id: <20230915092003.658361-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915092003.658361-1-ulf.hansson@linaro.org>
References: <20230915092003.658361-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig options belongs closer to the corresponding implementations,
hence let's move them from the soc subsystem to the pmdomain subsystem.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Andy Gross <agross@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig      |  1 +
 drivers/pmdomain/qcom/Kconfig | 41 +++++++++++++++++++++++++++++++++++
 drivers/soc/qcom/Kconfig      | 37 -------------------------------
 3 files changed, 42 insertions(+), 37 deletions(-)
 create mode 100644 drivers/pmdomain/qcom/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index b1d9dc7d71e3..c91fdd40163a 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -7,5 +7,6 @@ source "drivers/pmdomain/apple/Kconfig"
 source "drivers/pmdomain/bcm/Kconfig"
 source "drivers/pmdomain/imx/Kconfig"
 source "drivers/pmdomain/mediatek/Kconfig"
+source "drivers/pmdomain/qcom/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/qcom/Kconfig b/drivers/pmdomain/qcom/Kconfig
new file mode 100644
index 000000000000..3d3948eabef0
--- /dev/null
+++ b/drivers/pmdomain/qcom/Kconfig
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Qualcomm PM Domains"
+
+config QCOM_CPR
+	tristate "QCOM Core Power Reduction (CPR) support"
+	depends on ARCH_QCOM && HAS_IOMEM
+	select PM_OPP
+	select REGMAP
+	help
+	  Say Y here to enable support for the CPR hardware found on Qualcomm
+	  SoCs like QCS404.
+
+	  This driver populates CPU OPPs tables and makes adjustments to the
+	  tables based on feedback from the CPR hardware. If you want to do
+	  CPUfrequency scaling say Y here.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called qcom-cpr
+
+config QCOM_RPMHPD
+	tristate "Qualcomm RPMh Power domain driver"
+	depends on QCOM_RPMH && QCOM_COMMAND_DB
+	help
+	  QCOM RPMh Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPMh which then translates it into corresponding voltage
+	  for the voltage rail.
+
+config QCOM_RPMPD
+	tristate "Qualcomm RPM Power domain driver"
+	depends on PM && OF
+	depends on QCOM_SMD_RPM
+	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS_OF
+	help
+	  QCOM RPM Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPM which then translates it into corresponding voltage
+	  for the voltage rail.
+
+endmenu
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 715348869d04..b3634e10f6f5 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -26,22 +26,6 @@ config QCOM_COMMAND_DB
 	  resource on a RPM-hardened platform must use this database to get
 	  SoC specific identifier and information for the shared resources.
 
-config QCOM_CPR
-	tristate "QCOM Core Power Reduction (CPR) support"
-	depends on ARCH_QCOM && HAS_IOMEM
-	select PM_OPP
-	select REGMAP
-	help
-	  Say Y here to enable support for the CPR hardware found on Qualcomm
-	  SoCs like QCS404.
-
-	  This driver populates CPU OPPs tables and makes adjustments to the
-	  tables based on feedback from the CPR hardware. If you want to do
-	  CPUfrequency scaling say Y here.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called qcom-cpr
-
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
@@ -157,27 +141,6 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
-config QCOM_RPMHPD
-	tristate "Qualcomm RPMh Power domain driver"
-	depends on QCOM_RPMH && QCOM_COMMAND_DB
-	help
-	  QCOM RPMh Power domain driver to support power-domains with
-	  performance states. The driver communicates a performance state
-	  value to RPMh which then translates it into corresponding voltage
-	  for the voltage rail.
-
-config QCOM_RPMPD
-	tristate "Qualcomm RPM Power domain driver"
-	depends on PM && OF
-	depends on QCOM_SMD_RPM
-	select PM_GENERIC_DOMAINS
-	select PM_GENERIC_DOMAINS_OF
-	help
-	  QCOM RPM Power domain driver to support power-domains with
-	  performance states. The driver communicates a performance state
-	  value to RPM which then translates it into corresponding voltage
-	  for the voltage rail.
-
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM || COMPILE_TEST
-- 
2.34.1

