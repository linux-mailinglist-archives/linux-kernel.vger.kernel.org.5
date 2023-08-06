Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E8A771673
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 21:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjHFTGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 15:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHFTGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 15:06:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A67F1712;
        Sun,  6 Aug 2023 12:06:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-790ca0ed6d3so129791539f.3;
        Sun, 06 Aug 2023 12:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691348789; x=1691953589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtA/DXQ16Iik0MVLRswYcHvRP3Ma3gJUyRXapnCHuSU=;
        b=g5yQZhefWvLdV2003/eA374xxnL4k+Av25DWV3BT9LQ8LYc7uHrRw+vIxKCm8zzudc
         s5Uu/mIkaaAu2P3DYICFlo+4Iozq43ueYNdJtiyjyDRbSKre1fi6zRkoby1dy7idRCvj
         9NcQtEBYdSSnRB0Vpr3ijiYPAy5UoBdOMAsYs9vWRVCz4SZZGZ6ckbWGkCdVVHa0GaYH
         MV/Qq+V0GnLC5k0lzzkYBhhMSmWW77L8T/d4mk03BF97BBidvLH+hsyg8DI61d67kGQy
         lLUX3KQ13o6+EtRrT3dLOWojiRm+ORgZXdo+1BwajLDHAvaWq7oJhDI0BBrUzA97Uj3a
         T5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691348789; x=1691953589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtA/DXQ16Iik0MVLRswYcHvRP3Ma3gJUyRXapnCHuSU=;
        b=fayFrpfF3fJcbZ/JN3JDbeaZC8GToxu1UgTW6cdIgG9Z+hTqVdoBI1gEU5cbmpPgLS
         H/iRNeEDzV+doLh7QTvDYZS/SfAYxsvSusMC7zvihCGWgmlJ9bT37mUct9oKAS1OFowq
         VUwsK7BM4nNKXMBHtHPwUneaN6dSTHYk2YCxep/VzfNfFyWS1UAdFvaxvhUCkq/NEVRU
         A/AIq5SNLAeMOgLLDPFAcnmJ3gqZoVmM54KMlJiv/j/ZXxdKmeevPXW+3ZArIZiIOjXb
         DK7qntKI3Cy1r++vUuhmP1Tz3NXwTbi7Y3oz60tuIjFkYqxd+SRjHkrf3ZcWE1R59GMQ
         Kwpw==
X-Gm-Message-State: AOJu0YzSm3D7xPDT6BopaTSbrdQkIu3GiXFURbUx076hdmYbaQ+J1uW6
        Hqd/yvPgYVRJSR7rMPCkDMk=
X-Google-Smtp-Source: AGHT+IFWbyDPDi3n+1IiJNyDqVllymgmvBn0GL0USdFN0qfpO9oaRGJz4Td6pb38IM0q9HcaFt1HZg==
X-Received: by 2002:a6b:6b0d:0:b0:790:d813:2d38 with SMTP id g13-20020a6b6b0d000000b00790d8132d38mr9144889ioc.11.1691348789548;
        Sun, 06 Aug 2023 12:06:29 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:3be6:798d:d8e6:3ba5])
        by smtp.gmail.com with ESMTPSA id i24-20020a02b698000000b0042b1dd89b0bsm1982400jam.155.2023.08.06.12.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 12:06:28 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, cstevens@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mp-beacon: Configure 100MHz PCIe Ref Clk
Date:   Sun,  6 Aug 2023 14:06:21 -0500
Message-Id: <20230806190622.505887-1-aford173@gmail.com>
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

There is a I2C controlled 100MHz Reference clock used by the PCIe
controller. Configure this clock's DIF1 output to be used by
the PCIe.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
index 06e91297fb16..332269dedeee 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
@@ -23,6 +23,12 @@ chosen {
 		stdout-path = &uart2;
 	};
 
+	clk_xtal25: clk-xtal25 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
+
 	connector {
 		compatible = "usb-c-connector";
 		label = "USB-C";
@@ -246,6 +252,13 @@ pca6416_3: gpio@20 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 	};
+
+	pcieclk: clk@68 {
+		compatible = "renesas,9fgv0241";
+		reg = <0x68>;
+		clocks = <&clk_xtal25>;
+		#clock-cells = <1>;
+	};
 };
 
 &i2c3 {
@@ -372,8 +385,9 @@ &pcie {
 };
 
 &pcie_phy {
+	fsl,clkreq-unsupported;
 	fsl,refclk-pad-mode = <IMX8_PCIE_REFCLK_PAD_INPUT>;
-	clocks = <&pcie0_refclk>;
+	clocks = <&pcieclk 1>;
 	clock-names = "ref";
 	status = "okay";
 };
-- 
2.39.2

