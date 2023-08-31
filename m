Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06C178EC76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345774AbjHaLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjHaLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:51:46 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E53CFF;
        Thu, 31 Aug 2023 04:51:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-794c7d95ba5so26844639f.0;
        Thu, 31 Aug 2023 04:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693482703; x=1694087503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihsq1G+Hub3rKossUtgp/zZy1yTWO30XUHy6RAXp+uk=;
        b=nIrjaccbsnE3t/jCjFBWjij+buylw9yDya53fs4k1gEUotlY+HfPp2O8tY5uRqohrR
         avXtg9E2puV++Q55BpPQEO7/m+9qmtQ+pP8maQ+bTrWbv8+NjKpynV+dnWSB7jLB5/zm
         qnLxa+3pOBUxzfjVMYY67i1LL7r7jJDFsafElIrqWAEkPeBD3ONkIikZLoDPNT3TCKvg
         Iv+h5vBMLmMraaT+cbhuQ7HW4Z4hp+zmfefhut4+xZ/PnPho0+3raAAh0gYAzE73Hq9Y
         o83KiebZfnQcAZtYJcO1l1tXUfqqdSwISbIwOeYaJiXJgEE92eBjuqd26rlG6WnBx1qv
         jq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693482703; x=1694087503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihsq1G+Hub3rKossUtgp/zZy1yTWO30XUHy6RAXp+uk=;
        b=S3+yz8+Li6Yo9BXxsEtX3jVw7Pa2w9iXxOXLo5nYuCiZK42xQKZMntXSojTqnbsSXK
         a4tS2HhfRcCV+8DQdDH7kCXirzidBESDLF9L2WWX+Jd1PXI2g6/0sGY7IEiDjpDuN3AZ
         jSviZzqXK44qrGQ1UoBRxjWxZYWcn0xOJ1K2tuyfdw8RaH53QJ7uDKLmfjQCCs7dJt56
         G8XeXtNd20qgU0lAN4SFIFE1xADYpB9MlRwKTGfPgLMNtq/9G8V+iOcmQuaTu7GIgD2z
         fbI13WDFI4jBS6DxvQMLYlb7MhavD3z3oMAHd90xr7cGL5cQZ/Pedg5R6bizWqru27eg
         ln+g==
X-Gm-Message-State: AOJu0YxyHlpCZnnB5PuW85DPrkLJu1Z01sOm1QVqITMTZx97QewXIcnt
        bfXxi2LYPk/ITL3H+/S0pPM=
X-Google-Smtp-Source: AGHT+IEnv1P/QYCarKpZ1Xer0P5ZGSgekwP3ctv3JCpSTmZKWn/RaUOys/p1eV8kWbXegyupSqv0Hw==
X-Received: by 2002:a6b:fe15:0:b0:787:1a8f:1d08 with SMTP id x21-20020a6bfe15000000b007871a8f1d08mr4906178ioh.15.1693482702990;
        Thu, 31 Aug 2023 04:51:42 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:2a0f:e1d5:3688:f2b8])
        by smtp.gmail.com with ESMTPSA id o28-20020a02cc3c000000b0042b1d495aecsm353529jap.123.2023.08.31.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 04:51:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: imx8mm-beacon: Migrate sound card to simple-audio-card
Date:   Thu, 31 Aug 2023 06:51:25 -0500
Message-Id: <20230831115128.254226-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a custom glue layer connecting the wm8962 CODEC
to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
This also brings this board in line with the imx8mn-beacon and
imx8mp-beacon.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index b10e2a703a44..313e93663d6f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -98,18 +98,30 @@ reg_usdhc2_vmmc: regulator-usdhc2 {
 		enable-active-high;
 	};
 
-	sound {
-		compatible = "fsl,imx-audio-wm8962";
-		model = "wm8962-audio";
-		audio-cpu = <&sai3>;
-		audio-codec = <&wm8962>;
-		audio-routing =
-			"Headphone Jack", "HPOUTL",
-			"Headphone Jack", "HPOUTR",
-			"Ext Spk", "SPKOUTL",
-			"Ext Spk", "SPKOUTR",
-			"AMIC", "MICBIAS",
-			"IN3R", "AMIC";
+	sound-wm8962 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8962";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,widgets = "Headphone", "Headphones",
+					    "Microphone", "Headset Mic",
+					    "Speaker", "Speaker";
+		simple-audio-card,routing = "Headphones", "HPOUTL",
+					    "Headphones", "HPOUTR",
+					    "Speaker", "SPKOUTL",
+					    "Speaker", "SPKOUTR",
+					    "Headset Mic", "MICBIAS",
+					    "IN3R", "Headset Mic";
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai3>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&wm8962>;
+			clocks = <&clk IMX8MM_CLK_SAI3_ROOT>;
+			frame-master;
+			bitclock-master;
+		};
 	};
 };
 
@@ -192,6 +204,7 @@ wm8962: audio-codec@1a {
 			0x0000 /* 4:FN_DMICCDAT */
 			0x0000 /* 5:Default */
 		>;
+		#sound-dai-cells = <0>;
 	};
 
 	pca6416_0: gpio@20 {
-- 
2.39.2

