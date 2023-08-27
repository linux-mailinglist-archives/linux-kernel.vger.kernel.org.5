Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EA2789AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 04:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjH0Cco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 22:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjH0CcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 22:32:14 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E34129;
        Sat, 26 Aug 2023 19:32:08 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34bae82b2ffso7234735ab.1;
        Sat, 26 Aug 2023 19:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693103528; x=1693708328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6JljaP6ydDpiKUAUEr2HJLofyqFW0MhNueQ/UlFehE=;
        b=lo9ZFtZglKjl08HKkE5t0WneBOqBkXhXzXR2N778Blp7gbLP1XcXlyM4hoSYaQwg9H
         jhiTL1MUwwo6IDuqSdhw1lTCA7YuQP/qjtmKjXsJ9uTKgvLZVW/ynSbudpOhq2nuexJJ
         Q8LCxVUg0XTp3hx7uQL8K2rOXFXiHwH1S7W/HBw1KjJegELDdErKqDdf5CBjsQzFc1MR
         7266uEIsBXOMz1QLbq2L/ok+QJ7TF5Xny/ed/31KrvO9D8dJKZiiBw2iVWpJRV+m6M/U
         piKEifYVVVblXXC6TGJI+ltxrq/jqsopS1UA48bDufRMq8TMQ1kPRo4v/1u1ZQYLW8cj
         iz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693103528; x=1693708328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6JljaP6ydDpiKUAUEr2HJLofyqFW0MhNueQ/UlFehE=;
        b=J0Kljyj7ePQgH9uE9sQeKoIEouyCGizeP3AMYct3Ll50sKeQu3zZbf9lk6QnkiUiYl
         zMxCHqRoiApEcjCK03CycEC5M+TAq/rVm3tiNjoIWZt0x8PEvUpIcg0gmZs9rR3t4jZO
         gXHRbRYSm4ZS3eboE9z+NhnbgVdfK5xjPpWQgZnU+KYUWwyLS4gzUxskh//mMMbldW34
         NrThmfBRO5XaDfyzjfNy7d8u89vyFkYuVWOQpXyL1eBAV1clLsndpUmY3f4TTpIgC3MY
         2wYQrbeTc2jUNOce9SQ+FRINA29qu6wXr0k/1/kTl6uIaHuOg0l/d47IUANb5H40DBEw
         3ueQ==
X-Gm-Message-State: AOJu0Yx8A8U60rDXKAeGlYEGDvkLl4XmQC2/GbTUve11weeQaLbOZ1C5
        hEuquCW1EdZhoPX5qHr+IgI=
X-Google-Smtp-Source: AGHT+IFHmtefwiknYqi7kY+GlLeufxz2ZPziMtQjJxWIMqW4V/Lw28aZlw4f8ngVDEGD8Ckeq39R/Q==
X-Received: by 2002:a05:6e02:ca7:b0:34b:b024:a07c with SMTP id 7-20020a056e020ca700b0034bb024a07cmr11373658ilg.5.1693103528163;
        Sat, 26 Aug 2023 19:32:08 -0700 (PDT)
Received: from aford-B741.lan ([2601:447:d001:897f:80ee:1859:87ec:6d31])
        by smtp.gmail.com with ESMTPSA id n18-20020a056e0208f200b0034202d05fadsm1581533ilt.72.2023.08.26.19.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 19:32:07 -0700 (PDT)
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
Subject: [PATCH V2 2/3] arm64: dts: imx8mp: Add easrc node
Date:   Sat, 26 Aug 2023 21:31:54 -0500
Message-Id: <20230827023155.467807-2-aford173@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230827023155.467807-1-aford173@gmail.com>
References: <20230827023155.467807-1-aford173@gmail.com>
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

The i.MX8MP has an asynchronous sample rate converter which seems
to be the same as what is available on the i.MX8M Nano.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2:  No change

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6f2f50e1639c..79cdd4c066c8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1453,6 +1453,26 @@ sai7: sai@30c80000 {
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

