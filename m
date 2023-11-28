Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF4E7FB10D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 06:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbjK1EyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 23:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1EyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 23:54:23 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CF1A1;
        Mon, 27 Nov 2023 20:54:29 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35c86914439so13388925ab.2;
        Mon, 27 Nov 2023 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701147269; x=1701752069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b55s7y8g8GjEWWisOWcT6dnxOgGgxH8qO5b8KhVk6qE=;
        b=GVY81iCXMqx6LipJB+sU/TTO1niIQxThAp13xYdYP/oxxrpzXG8PSEmYwf2QouYcnE
         iQKnh74CobYVEm1qmnFue9JdRh1VEl6vup7EOyE9dxa3Qqney+3svFxgN89YfC59Sfsx
         jJngwC8egMI0nppCzjOU2AZId1uU9gorI8xfqYk7hABcmYZBqDr5gl71mL3nSc3Qcxji
         PnPzx8WCxPeEiSuzwj3VTbvZZDiv+uFVmaC4hr7P5gaLEkRU+EAsM5bz3DxtchzW+qx4
         y622yKUNN0g+lOXzdAsWCt/Z3RutEeDWrkwttKeUyn12e+odCM4RralwQcnUnK+yxQKE
         HnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701147269; x=1701752069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b55s7y8g8GjEWWisOWcT6dnxOgGgxH8qO5b8KhVk6qE=;
        b=EG8Nnc6S8XcRWlR2li8cGolcDYdLak9QjLpoyelDtWrg7R1hEZoxvfzD8Tw7P/d4/a
         XSJ/BvUUnathKZxFiqYNt6TnHERKyuYd3bjRKLXNzyuf5rQ4P0VoWh7+d30ZZy6B2VQV
         TK260LgQm2DSJnvkXErzV5Wi+pWad18S3qmIbCEZPUE5xnQOfi6L+TMzDmgERiKy/mdp
         RgSVCylGATNiDe0VFCD2mfUKu2k/tGaSPJ5Z+luvjvq4m6Ggmv91+B7PfSplcQRJjHDl
         UlZlvV2/6vgp7tghhLIXmGde8mQNh/cF218aEYoY+BWEqHI6GRwhknIA83Z5c2L08Lo0
         KUKw==
X-Gm-Message-State: AOJu0YxjO/wvZSRvF2y9Ck7ue2Na7kmVJVcsoVYHKNRftfHjM3We2UWc
        5i+kK1sLJkIjdC+oIQYNMPk=
X-Google-Smtp-Source: AGHT+IFhiH/15Ck9qsS6ll4kOBnmnDX2P/PqYsF/LqXF6kX3cwJfGxmN44P4EiNNZJ8jCQpyV4Nhaw==
X-Received: by 2002:a05:6e02:152e:b0:35c:b333:a853 with SMTP id i14-20020a056e02152e00b0035cb333a853mr8868900ilu.23.1701147268665;
        Mon, 27 Nov 2023 20:54:28 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:5d62:b359:8b5c:90ac])
        by smtp.gmail.com with ESMTPSA id bo33-20020a056e02342100b0035b0b05189bsm3357251ilb.38.2023.11.27.20.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 20:54:28 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembeded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: imx8mm: Simplify mipi_dsi clocks
Date:   Mon, 27 Nov 2023 22:54:13 -0600
Message-Id: <20231128045415.210682-1-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree clock structure for the mipi_dsi is
unnecessarily redundant.

The default clock parent of IMX8MM_CLK_DSI_PHY_REF is
already IMX8MM_CLK_24M, so there is no need to set the
parent-child relationship between them.  The default clock
rates for IMX8MM_SYS_PLL1_266M and IMX8MM_CLK_24M are
already defined to be 266MHz and 24MHz respectively,
so there is no need to define those clock rates.

On i.MX8M[MNP] the  samsung,pll-clock-frequency is not
necessary, because the driver will read it from sclk_mipi
which is also already set to 24MHz making it also
redundant.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 738024baaa57..8d872568231d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1151,12 +1151,8 @@ mipi_dsi: dsi@32e10000 {
 				clocks = <&clk IMX8MM_CLK_DSI_CORE>,
 					 <&clk IMX8MM_CLK_DSI_PHY_REF>;
 				clock-names = "bus_clk", "sclk_mipi";
-				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>,
-						  <&clk IMX8MM_CLK_DSI_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>,
-							 <&clk IMX8MM_CLK_24M>;
-				assigned-clock-rates = <266000000>, <24000000>;
-				samsung,pll-clock-frequency = <24000000>;
+				assigned-clocks = <&clk IMX8MM_CLK_DSI_CORE>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_266M>;
 				interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 				power-domains = <&disp_blk_ctrl IMX8MM_DISPBLK_PD_MIPI_DSI>;
 				status = "disabled";
-- 
2.40.1

