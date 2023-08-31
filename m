Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568278E586
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 06:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbjHaEov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 00:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjHaEor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 00:44:47 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71125E0;
        Wed, 30 Aug 2023 21:44:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-792975085b2so18506939f.1;
        Wed, 30 Aug 2023 21:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693457082; x=1694061882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQ7Elv9ApZLe2GYTI96AHEN7WqsqdKFiYhTU12StZ5g=;
        b=pIXo8zVz8gAaltN9hGvaJXn+CES04SqUk5XPhMW0e3hR2kktUtLPGTjbkvyJgzOwXe
         JN6HTuqW9WYBKLOygmZ6gmGI4QkmIrCxR/FZdOLBmJZ6aymqfWcUoyvkERhKj8LbIGxr
         D41n9JR1gg6Nv7qYzyk4VclbiweU1suEBsdJN3MQd2b/OvZhtW6pojuuFNcRcx78ZO/s
         c9gVvC2tkuTbrmqkbAGzEzG32LcrvVULcABKTBxo6iTXRKmz3f2P5M8BMrRzhwAExXfV
         MrddzpKMoYyju30RKtkh/5vlHNEPP+wxdyqPdkI/UYUdrNOtHwZxCKvd5IgfWPNx2824
         jNMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693457082; x=1694061882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQ7Elv9ApZLe2GYTI96AHEN7WqsqdKFiYhTU12StZ5g=;
        b=inytlywpf5um/Q6OjORoMVj9pxCo6uwsN/BmUdM+YtuWEvXI9YyJBSMqmxyb0DJme9
         fuLzAFeFU6xHlq4XEkOHyb/XuUvW8PSa7HBjBy3SjBm6COCD9KGZRA25nV4tm+zq2+/9
         +Tzn9WJbH6ePzG/zFpDEDOwremPa0X9ZuLbd9IpQhD2dSY4c08N3mOFJjW4VpQDtGBZ9
         zYaCA+4fotSQrj1+HcBytcxD7in8S2decVSVVOopk9lVSNgw1Bybvn76j/sEPSQNLssb
         aLXH4n2KJAadXxxyzqPzS+saGDpMNQgajV6OiYkTFvtEyVm+UugBvG5mu0KMgFJaR82s
         qgsQ==
X-Gm-Message-State: AOJu0YyjY+A9gxj/pxBD6AcHNlExTfl1HM8vpprAIk2uwCN0RapzE88A
        w8JFg+hIoaEZhtmOIpjk0XbY+/VSa6Y=
X-Google-Smtp-Source: AGHT+IGFuF+jYKTWHbR70wmZ2rnuek30RxIcZaEgwY5pmdU+lyscr+Y78wG/1Z4A6L1TjwTYjbMcHQ==
X-Received: by 2002:a5d:990f:0:b0:792:792e:6616 with SMTP id x15-20020a5d990f000000b00792792e6616mr4791076iol.2.1693457081560;
        Wed, 30 Aug 2023 21:44:41 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:d40b:6175:6beb:6448])
        by smtp.gmail.com with ESMTPSA id x6-20020a5e8306000000b0077a1d1029fcsm215006iom.28.2023.08.30.21.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 21:44:41 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     marex@denx.de, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH V3 1/3] arm64: dts: imx8mp: Add easrc node
Date:   Wed, 30 Aug 2023 23:44:29 -0500
Message-Id: <20230831044431.250338-1-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
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

The i.MX8MP has an asynchronous sample rate converter which seems
to be the same as what is available on the i.MX8M Nano.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  No Change.  The dt-binding update was already accepted into the sound tree, so that patch
     was dropped from the series

V2:  No Change.
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 83d907294fbc..3167706d81e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1459,6 +1459,26 @@ sai7: sai@30c80000 {
 					interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 					status = "disabled";
 				};
+
+				easrc: easrc@30c90000 {
+					compatible = "fsl,imx8mp-easrc", "fsl,imx8mn-easrc";
+					reg = <0x30c90000 0x10000>;
+					interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+					clocks = <&audio_blk_ctrl IMX8MP_CLK_AUDIOMIX_ASRC_IPG>;
+					clock-names = "mem";
+					dmas = <&sdma2 16 23 0> , <&sdma2 17 23 0>,
+					       <&sdma2 18 23 0> , <&sdma2 19 23 0>,
+					       <&sdma2 20 23 0> , <&sdma2 21 23 0>,
+					       <&sdma2 22 23 0> , <&sdma2 23 23 0>;
+					dma-names = "ctx0_rx", "ctx0_tx",
+						    "ctx1_rx", "ctx1_tx",
+						    "ctx2_rx", "ctx2_tx",
+						    "ctx3_rx", "ctx3_tx";
+					firmware-name = "imx/easrc/easrc-imx8mn.bin";
+					fsl,asrc-rate  = <8000>;
+					fsl,asrc-format = <2>;
+					status = "disabled";
+				};
 			};
 
 			sdma3: dma-controller@30e00000 {
-- 
2.39.2

