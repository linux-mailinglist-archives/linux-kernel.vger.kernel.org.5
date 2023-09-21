Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B0A7AA005
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjIUUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjIUUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:19:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8DFD5119
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:37 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso13361595e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695320736; x=1695925536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tO07y52ihL4jiW+/YSc6o4oy7K98rV4fDYJiTaFp/cc=;
        b=Zc8tPHFy8tfz2wHylvcLVQ4h/PJH5H2A2FB4J8Q/AA7FE9zJyRJvpofvR6jfwV1hc/
         8Kcoo6+Vf79aJLqh/7k7R9ga1CyBCAQzQULQyx8NikMM8GEyr8ujGRDsuc7kgpvpNo3N
         bGLT2CqCMY2x+hUmK9TnQ4wab9QvImwd1O2GMEdpqnwozkHdnBqsyxN65QVicjVhoNa7
         9tl1Flxd00V0IJzLMoaRrz7QWVJIRwIftG++skM2ob4jNfGzhgv7IJQ+gAc03h6AcFIW
         LcRAGk/FWuNYVbPtuq0qc02VRnCW2ltpyM+Ak469l8Jv36SZ/yFjuQHxioTDNgz+5LLF
         AZvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320736; x=1695925536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tO07y52ihL4jiW+/YSc6o4oy7K98rV4fDYJiTaFp/cc=;
        b=XDzgjqdGXcT+IVzxhReW4YOyZknmE5LUdl+4ZO2iOyphZ/2lotk0kCX5cAsbV5UKgD
         c8Ist2VALZzVA1zzlmbxp5E+Hzy4nC+QcwQS/jxl0QOg6muTck0u2+9Pr5TjZmwmF89f
         t8i20UAbKqdo/9o8KgyQLaQOXjJFS/R4derf9b/oKOmfz07JnWJcPhOMtf/1Ki8nNac3
         I0vMT6VpPjMe2G41sc6la3iRkpp4FSRBttfW1XtYY86OZGWO/Z7GwUNtKoDS2G5ievKF
         LxdIZLYc07L13pbHx4hEyv/ahmth2h4dgM7mqWf8J3ELrvDpmwG9Bygm110TQwXluocC
         z1Vg==
X-Gm-Message-State: AOJu0Yx/Gw53yTjzvZnfzguqYJ0sg520gjvtCznBJt1ymx/sfx5DVoGJ
        M0CSNGA3Xk/jA3zh3oLyvXD0qvFq2qygEqNviqSHug==
X-Google-Smtp-Source: AGHT+IGOsPGLaNytNXaesgM8DKeO7lYi8IWldSKE9SkPDnT2UG04FmyFBfLgnPmFbVLicstMGWgsLQ==
X-Received: by 2002:a17:906:ef8c:b0:9ae:4ba4:7983 with SMTP id ze12-20020a170906ef8c00b009ae4ba47983mr3166503ejb.37.1695289020335;
        Thu, 21 Sep 2023 02:37:00 -0700 (PDT)
Received: from hackbox.lan ([86.120.16.169])
        by smtp.gmail.com with ESMTPSA id zg22-20020a170907249600b009a5f1d15642sm763085ejb.158.2023.09.21.02.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 02:36:59 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] clk: imx: Select MXC_CLK for CLK_IMX8QXP
Date:   Thu, 21 Sep 2023 12:36:47 +0300
Message-Id: <20230921093647.3901752-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the i.MX8QXP clock provider is built-in but the MXC_CLK is
built as module, build fails:

aarch64-linux-ld: drivers/clk/imx/clk-imx8-acm.o: in function `imx8_acm_clk_probe':
clk-imx8-acm.c:(.text+0x3d0): undefined reference to `imx_check_clk_hws'

Fix that by selecting MXC_CLK in case of CLK_IMX8QXP.

Fixes: c2cccb6d0b33 ("clk: imx: add imx8qxp clk driver")
Closes: https://lore.kernel.org/all/8b77219e-b59e-40f1-96f1-980a0b2debcf@infradead.org/
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index f6b82e0b9703..db3bca5f4ec9 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -96,6 +96,7 @@ config CLK_IMX8QXP
 	depends on (ARCH_MXC && ARM64) || COMPILE_TEST
 	depends on IMX_SCU && HAVE_ARM_SMCCC
 	select MXC_CLK_SCU
+	select MXC_CLK
 	help
 	  Build the driver for IMX8QXP SCU based clocks.
 
-- 
2.34.1

