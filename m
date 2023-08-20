Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83160781F22
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 20:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjHTSBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 14:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjHTSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:01:32 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A62123;
        Sun, 20 Aug 2023 10:57:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79225651b06so33777139f.3;
        Sun, 20 Aug 2023 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692554229; x=1693159029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tixiGJ6i1PZ9SXymw91nUfc5toP1B5evyHhJBDgTIcE=;
        b=KzURO5AJkuZp/OhmQyOo1d8V2X6FoW20Z2nCtaLzHqQ/RX/RTlAGMgkZD7GdeZgKR+
         Ofo8EXRQHmBcqqEqBcGxbq0vc9/Wq+gP8746e/ve+o9RTCqdD2855yUU4QDlYDxH6Pfn
         B9opvvhUnEM/8XhpnpYZqTbFSCXaqRdvap/t0ht5PwRu0tWEBINVRmlMLhViBKZC7xYH
         8dJb4MzFDJPWqjIoLsRb7MMwYKUaDNDYMqBLXhGwVJMjM2H7E4qzjjuXAsp3HL9NuRuU
         17yBWhiLjJTwY7WEI3L0D12VQAI+OnW6M4c2Re3Odzsg8gUQFv/Ootq2Xs7t6uq/AZV9
         5X5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692554229; x=1693159029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tixiGJ6i1PZ9SXymw91nUfc5toP1B5evyHhJBDgTIcE=;
        b=PytFoU3bf46h7Vjt35c6uwwH7RWegVoReWNxRHwg9Mwz2eghTr3AzQCzAu0MLHYeIL
         kpID/GehtyYnEu6X22IYohil8hTOGMZ58Lpl1Kpoh1KNgfwTcYkoBUx3D6t1R8HOYyxd
         R2ZVIIAoPCeuQKoeEnuOtdTDloD6CAI4b0Fj2x51q87F7iFF/fbci2FM3XT3nC5NN9n/
         859e8YqhemDYFPAQdyQjSA624qkNqGSGclVjC7QYFBchz0BCTNMdeD3kR7Cr8LFNZRGI
         KSoqP+hxlicdwmnwNooYY00t9iPcGCZD7B0h8fKg0ndMCrWnVaR5UDHUSulmFgAG8JWj
         XKDA==
X-Gm-Message-State: AOJu0YzMaYgwVfRvw3ysWqUb8hypB3lUQJNErFpWPG455bi+gYyFQ41e
        VJIViDQCbaivzLYsmeqfuA8=
X-Google-Smtp-Source: AGHT+IGWLY4seK8Yz4fCltg3UPUf1L7ZFcoSQFhnD7/SFAe5DcEU6KPIaA2isCb1s4XdIKKKXj4hGg==
X-Received: by 2002:a6b:dd16:0:b0:791:8d:91de with SMTP id f22-20020a6bdd16000000b00791008d91demr6510760ioc.13.1692554228984;
        Sun, 20 Aug 2023 10:57:08 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:4e93:5643:7a4:7606])
        by smtp.gmail.com with ESMTPSA id gn16-20020a0566382c1000b0042b3a328ee0sm692448jab.166.2023.08.20.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 10:57:08 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: imx8mp: Add micfil node
Date:   Sun, 20 Aug 2023 12:56:55 -0500
Message-Id: <20230820175655.206723-3-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230820175655.206723-1-aford173@gmail.com>
References: <20230820175655.206723-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MP has a micfil controller which is used for interfacing
with a pulse density microphone. Add the node and mark it as
disabled by default.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 3167706d81e1..a6f5b8526698 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1479,6 +1479,27 @@ easrc: easrc@30c90000 {
 					fsl,asrc-format = <2>;
 					status = "disabled";
 				};
+
+				micfil: audio-controller@30ca0000 {
+					compatible = "fsl,imx8mp-micfil";
+					reg = <0x30ca0000 0x10000>;
+					#sound-dai-cells = <0>;
+					interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>,
+						     <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_IPG>,
+						 <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_PDM_ROOT>,
+						 <&clk IMX8MP_AUDIO_PLL1_OUT>,
+						 <&clk IMX8MP_AUDIO_PLL2_OUT>,
+						 <&clk IMX8MP_CLK_EXT3>;
+					clock-names = "ipg_clk", "ipg_clk_app",
+						      "pll8k", "pll11k", "clkext3";
+					dmas = <&sdma2 24 25 0x80000000>;
+					dma-names = "rx";
+					status = "disabled";
+				};
+
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.39.2

