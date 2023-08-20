Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D43781F21
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjHTSBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjHTSBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 14:01:32 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56019121;
        Sun, 20 Aug 2023 10:57:08 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34992fd567bso6126565ab.1;
        Sun, 20 Aug 2023 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692554227; x=1693159027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9/VjGyT9xu6/XWCD38HhKREDTKPLKBqFGrqkI0zss8=;
        b=im5B+GZC1uxApYsNl1L/d6/bMjyk/GD49WVdS2Ksuk+CNTS65K4bucYPA9lYvysQY1
         gX1l2DLllCxq9D1BTKKtQbqCdzTthgQybq2hQLUxhJFU6lsZMGTi4lymWBVU0HSq8hUA
         QJDiFBmxyFoN9fNP8mv/mNZmEIus7hfEYnhkPiRK5ObSYdfyaCVO6LetR47cmuQ+Tu8q
         qyxTPI/39FMJGlorfhrXK1QWIIm8XdmMspDAsrft3kcZu1dGz8RCMGvwCxN10MDIpLSK
         h5tpgTlQaD+CAL8i+56QMrL1+q9KIjdFXlBsvh4ytQgxflKR5I+jYT4Cml0rYV6/tbEo
         /2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692554227; x=1693159027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9/VjGyT9xu6/XWCD38HhKREDTKPLKBqFGrqkI0zss8=;
        b=L3t/QMTnp4U6YgupgTY2ewtUR5cJdHPIAKceHdvaTkQVAiMuJ7gReyhW3aSGl94B9M
         Vfh359hxPrEYoshoPfZXl6a2LSfHevk0uNegOr6PAFA2ht3YbVllIfaJx9h4yzjj+4HJ
         pcLrx8+1XKqqY4GsJD0FK/VbCmyoKloa6dWIj/XMEvr3/mlkjaDoGrkFuj0b7R67EP1q
         pKR+0KSBTnxhj9GSND4Mjk4uTcwDmbPrsN1GNjxCJvfDihfUu2k25Rl9WHmF1pjWHqkb
         NMK3YAofkEiTUh8K7De5Adm+ZQnWfmCOv3gxrgxOaDvEoHMH+Asih2HFBuDkkzRCosj5
         q2+w==
X-Gm-Message-State: AOJu0YwcD3I1s2TY21aZT6dg1Q3Ln/oRs4L638HspXmCIAyj9WuQLgLi
        DBYUionXo8LvAhUNd0KpVYoSCbu9dv0=
X-Google-Smtp-Source: AGHT+IGYnv01pqaU6lCB6Z8CIerZ0oYODmvzGcgMvqwE0F7fHU54qcMVI458fWYQekMpwe9GYvOrqQ==
X-Received: by 2002:a05:6e02:1d96:b0:34a:95f9:650c with SMTP id h22-20020a056e021d9600b0034a95f9650cmr5574836ila.10.1692554227545;
        Sun, 20 Aug 2023 10:57:07 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:4e93:5643:7a4:7606])
        by smtp.gmail.com with ESMTPSA id gn16-20020a0566382c1000b0042b3a328ee0sm692448jab.166.2023.08.20.10.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 10:57:07 -0700 (PDT)
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
Subject: [PATCH 2/3] arm64: dts: imx8mp: Add easrc node
Date:   Sun, 20 Aug 2023 12:56:54 -0500
Message-Id: <20230820175655.206723-2-aford173@gmail.com>
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

The i.MX8MP has an asynchronous sample rate converter which seems
to be the same as what is available on the i.MX8M Nano.

Signed-off-by: Adam Ford <aford173@gmail.com>

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

