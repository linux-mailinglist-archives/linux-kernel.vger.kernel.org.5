Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522E277114D
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjHESG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHESGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:06:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E903A8C;
        Sat,  5 Aug 2023 11:05:59 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-31768ce2e81so2758820f8f.1;
        Sat, 05 Aug 2023 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691258757; x=1691863557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjaA2yNdWRxoAIXKsMRIdPQiU+5JdGf4g+hfiGSEvXE=;
        b=qYKcS/LRkaOGXq4NdDRZzuiufmfi/JdXCUCdjxwvNlMaybZDSX+xGMyEpQTIV9OZnZ
         Gp4GB7jEPbcH9CWDW84PAFwbO0TClcrL1aQj9C8N3+bq0nxcYCPolbMCJ0eeZvdBV9ay
         ZAxs/9qDf+W5rvv6Y9l+xHmmsRaC5BJEAfFMJSpt0sHRKes7er/87raNN1FouMnr0lNA
         iYYMr5A7x6LN4+vL4w4rTM6AwN9sc0kyUnxH5uI4v5kMrNw/MNjSdGEhaL4kvXojMj65
         CznA+lUQm1lfKGBNQPnmKeQYtKKcVEGKXUzGXIRDiviT6mXGGyTe0umYKJHf2Up2LKYA
         oYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691258757; x=1691863557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jjaA2yNdWRxoAIXKsMRIdPQiU+5JdGf4g+hfiGSEvXE=;
        b=QBKUAzcccXwO5z0Y6407iLaMhk8zGzHW8cotpeqEaNIaBEi2PgV2v8jgtJU9BpTxn8
         xzQQmsZpfg5IcxoaGgWPwA4KI2iCuuu/ifN0Zherw3Z4/tas/H5vb93n+Hz9c3KVLQhx
         1XtMGicmhXgl4yHQ97B1oXR6r+91Jszw5L2jGXlgpdHXUni7P+OlcSUMPm7yh0M1/Zmu
         ULu8TAyVb8RiCqnUisfOCWFH/URXooG1kIz/7Iu/9fg6Gr0BUMi/WNv/hPmh7yVX7Z4Q
         C6BwYUwo1q/uDh/YfkND3NGkVhZ3UpdMiEZzaYct3qlCZVT7pANuKn8GyqG1eoLZnzY9
         U/aw==
X-Gm-Message-State: AOJu0YxAB0WgoYumW+La9LrGUG2ACSTLybczZk99G0cVQrq0RyuBtt/y
        cUY4F1AFhnQPhIXrcuv2+IU/1j6cDxmr1A==
X-Google-Smtp-Source: AGHT+IHH4WVwBu7aihjp9nuzFtSfjcWnZEsanbwbY8snGr0wZKCSwwwsVErXaYwxTLHpE9k4p+t7Qg==
X-Received: by 2002:a5d:4447:0:b0:317:3d36:b2cd with SMTP id x7-20020a5d4447000000b003173d36b2cdmr3214277wrr.71.1691258756721;
        Sat, 05 Aug 2023 11:05:56 -0700 (PDT)
Received: from user-PC.. ([178.134.198.138])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6104000000b003176aa612b1sm5710402wrt.38.2023.08.05.11.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 11:05:56 -0700 (PDT)
From:   Maksim Kiselev <bigunclemax@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maksim Kiselev <bigunclemax@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-riscv@lists.infradead.org
Subject: [PATCH v1 5/5] riscv: dts: allwinner: d1: Add device nodes for internal audio codec
Date:   Sat,  5 Aug 2023 21:05:05 +0300
Message-Id: <20230805180506.718364-6-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805180506.718364-1-bigunclemax@gmail.com>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT nodes for the internal D1/T113s audio codec and its analog part.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 1c48bfff1715..6ceb141c3f93 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -180,6 +180,28 @@ ths: thermal-sensor@2009400 {
 			#thermal-sensor-cells = <0>;
 		};
 
+		codec: codec@2030000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun20i-d1-codec";
+			reg = <0x02030000 0x300>;
+			interrupts = <SOC_PERIPHERAL_IRQ(25) IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_AUDIO>,
+				 <&ccu CLK_AUDIO_ADC>,
+				 <&ccu CLK_AUDIO_DAC>;
+			clock-names = "apb", "adc", "dac";
+			resets = <&ccu RST_BUS_AUDIO>;
+			dmas = <&dma 7>, <&dma 7>;
+			dma-names = "rx", "tx";
+			allwinner,codec-analog-controls = <&codec_analog>;
+			status = "disabled";
+		};
+
+		codec_analog: codec-analog@2030300 {
+			compatible = "allwinner,sun20i-d1-codec-analog";
+			reg = <0x02030300 0xd00>;
+			status = "disabled";
+		};
+
 		dmic: dmic@2031000 {
 			compatible = "allwinner,sun20i-d1-dmic",
 				     "allwinner,sun50i-h6-dmic";
-- 
2.39.2

