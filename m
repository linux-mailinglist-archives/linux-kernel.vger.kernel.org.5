Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593B87A1A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjIOJWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjIOJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:21:55 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773702D41
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bfc1d8f2d2so23454501fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694769692; x=1695374492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0LzjuzekaO+LUgw0Z4oAojZpLU0XF+vjTLwwFv3zjw=;
        b=NdaXwJnFVUFa38OvyPFChy9sHK627CnYfVGHB552a42PtP6LBEh3HSGIhCvYztIeN8
         CVny+EBzs6prYpUClFiG48OtZAtCBjKXM8oUSDSKrgFoL2g6d40EBehA8I4eHSHIdi5p
         2l9zBOFjCCHgAZP+Cab412gBdqlFSRsX3/CHSFsOMxqoFNP3RwUXdVG5Em2SpV7V3vV3
         e1uow4AjIzl8AHB09FAGwG64PCCE2hHe3IZ4Fp3vI+jtRJFBxeg+IulK8T7bI9j7Rtwx
         kJ+pIiVdkGAjrVe+kHK6v9cJCdfUZB/3WAoi7atOM8rGOW/kj0e0UmOJTA0p3uf1ASZB
         fcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694769692; x=1695374492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0LzjuzekaO+LUgw0Z4oAojZpLU0XF+vjTLwwFv3zjw=;
        b=gDR8vjs3vSQ7pCZIfpTaIYCfyBwgIXqBY/XKqLPaTqlmdTzI+FOtHBIU76KIrlnLyt
         0iaOM8gNJsnLKbl+CmLhAtkqdBFOKcApyJjKq/ZRvpd5dyG37rZwqVAeB4kxZq21RFXT
         WHLDJPgCeORq0Zk7pIqSh9r0bGSrfLK2KH/1FLeLWau9EWskyAGsblO7g4qvMHqb449a
         +PYP2c1/0KdXsrz0Rp4xoCSoFPQnIdLdA1BU5oJTYhCqjLyIfJZxPUpGdYfYl2OmD1Ik
         7WbjWPRX9M1QNzILAB9cXbTBble43Sliv8ckpfjl9tcTMnCEAlR0WTbvga2XqJFzsDi/
         nIIA==
X-Gm-Message-State: AOJu0YzS2p02732XvOh7MANZNbTzQSYHEBOYj5qSqx6BAYyFxMAa6haR
        IHgiSEqYpFtv/DwdOOoWOYVc/Q==
X-Google-Smtp-Source: AGHT+IGlhxclDokFJJoDCsB2E+IRV6YNT97EznA5CVX9FoIK3dQoYlmtjn1XPSwMiiENDAOdee/EAQ==
X-Received: by 2002:a2e:a17a:0:b0:2bb:c19b:710c with SMTP id u26-20020a2ea17a000000b002bbc19b710cmr415223ljl.5.1694769692670;
        Fri, 15 Sep 2023 02:21:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id p8-20020a2e7408000000b002b9ec22d9fasm639376ljc.29.2023.09.15.02.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:21:31 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michal Simek <michal.simek@amd.com>
Subject: [PATCH v2 17/17] pmdomain: xilinx: Move Kconfig option to the pmdomain subsystem
Date:   Fri, 15 Sep 2023 11:20:03 +0200
Message-Id: <20230915092003.658361-18-ulf.hansson@linaro.org>
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

The Kconfig option belongs closer to the corresponding implementation,
hence let's move it from the soc subsystem to the pmdomain subsystem.

Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/Kconfig        |  1 +
 drivers/pmdomain/xilinx/Kconfig | 10 ++++++++++
 drivers/soc/xilinx/Kconfig      |  9 ---------
 3 files changed, 11 insertions(+), 9 deletions(-)
 create mode 100644 drivers/pmdomain/xilinx/Kconfig

diff --git a/drivers/pmdomain/Kconfig b/drivers/pmdomain/Kconfig
index 33bfec9c4f7a..c98c5bf75a14 100644
--- a/drivers/pmdomain/Kconfig
+++ b/drivers/pmdomain/Kconfig
@@ -16,5 +16,6 @@ source "drivers/pmdomain/starfive/Kconfig"
 source "drivers/pmdomain/sunxi/Kconfig"
 source "drivers/pmdomain/tegra/Kconfig"
 source "drivers/pmdomain/ti/Kconfig"
+source "drivers/pmdomain/xilinx/Kconfig"
 
 endmenu
diff --git a/drivers/pmdomain/xilinx/Kconfig b/drivers/pmdomain/xilinx/Kconfig
new file mode 100644
index 000000000000..5242753d848a
--- /dev/null
+++ b/drivers/pmdomain/xilinx/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config ZYNQMP_PM_DOMAINS
+	bool "Enable Zynq MPSoC generic PM domains"
+	default y
+	depends on PM && ZYNQMP_FIRMWARE
+	select PM_GENERIC_DOMAINS
+	help
+	  Say yes to enable device power management through PM domains
+	  If in doubt, say N.
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 8a755a5c8836..49d69d6e18fe 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -16,15 +16,6 @@ config ZYNQMP_POWER
 
 	  If in doubt, say N.
 
-config ZYNQMP_PM_DOMAINS
-	bool "Enable Zynq MPSoC generic PM domains"
-	default y
-	depends on PM && ZYNQMP_FIRMWARE
-	select PM_GENERIC_DOMAINS
-	help
-	  Say yes to enable device power management through PM domains
-	  If in doubt, say N.
-
 config XLNX_EVENT_MANAGER
 	bool "Enable Xilinx Event Management Driver"
 	depends on ZYNQMP_FIRMWARE
-- 
2.34.1

