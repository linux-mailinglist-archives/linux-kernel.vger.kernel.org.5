Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9CAC7FC48F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjK1UC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjK1UC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:02:26 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90DB19A6;
        Tue, 28 Nov 2023 12:02:32 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35942cb9ef4so20024955ab.3;
        Tue, 28 Nov 2023 12:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701201752; x=1701806552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL70M8adFcOLLCGpHkIPZ0fFtu8Pki6s4ZjZx6Yvqu4=;
        b=U+li5Q5yywNkS1V/DdYpcodaW8lGtVtVnTfwWmcrec6CpnC8x4ZcN2GTdV58DMZRD/
         kpYqfvo/fKoGAMaFOmelQs7tkPI8vSEG6YGZFcAUJFL0Kz194dD4E64CamzELre4FC5Z
         UcXxmGC1FetEe+EEIikwHr978j00hQgXxkGdi7wcMwp4VoFvZS4vRrhOPjVNVxV5GxAK
         Zxqu0ygs6wl8bGKHAq4slO6QHwMUHtkJthB/UseH1wxvHlmATGwrm1ss+OPXXkLjb/ks
         xib/tlsLUJ9yhDyFdVnjSfKoNSysdOMmmu/L6/b5M4DU5dmV7bdyffFww53b8k2OK+7Y
         JIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701201752; x=1701806552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL70M8adFcOLLCGpHkIPZ0fFtu8Pki6s4ZjZx6Yvqu4=;
        b=G0V274f0lL140o327LJfiUy3ZOwT+sxaXSygMi36wMv3jEDKbhOG/KB6fnj4Wk0rvO
         5ksbLvDgvMV2jtQGZXF6kooBTMBMMhOus2yiZ59yCq33Efm577mWDsW2WMt+okbw0DCU
         hy6kdjChp0R7DxouyRYu62K9D/taMhN+CoZZWMF61kcurLPdkdNXTRvOnZIIa0IqrU4P
         lOk3FPlIdp+4dcwzAxQoqkIqlvhfpcCVQ+y2Zq+STCU6KOvj80qC/mWfbE0RqR5gGyT5
         CZw6itd62yo76OdtWbFm30E1TaTSKYmCyUaOR0B09Hd0ysl6XmJwwnQufGrSP9+nwWNk
         MMYA==
X-Gm-Message-State: AOJu0YxYvy9cm2PZ4mPwDfzgcv047+MK262Tq09jM4brxv5Jsb1YuivY
        2TDv6ROYqLZJSNXiPakdveY=
X-Google-Smtp-Source: AGHT+IEGeJdSVdfMenIfjs/XLyzvGUcDgc4QUTjM2yrzkgjJHalUKlctJKCJEhc/NEiqWHYeWdm07w==
X-Received: by 2002:a92:d809:0:b0:35c:ae44:1766 with SMTP id y9-20020a92d809000000b0035cae441766mr11706874ilm.4.1701201752153;
        Tue, 28 Nov 2023 12:02:32 -0800 (PST)
Received: from aford-System-Version.lan ([2601:447:d002:5be:9cf:804b:3499:a67b])
        by smtp.gmail.com with ESMTPSA id bs12-20020a056e02240c00b0035d21e48d28sm323392ilb.8.2023.11.28.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:02:31 -0800 (PST)
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
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: imx8mm: Add optional overdrive DTSI
Date:   Tue, 28 Nov 2023 14:02:17 -0600
Message-Id: <20231128200219.226038-2-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128200219.226038-1-aford173@gmail.com>
References: <20231128200219.226038-1-aford173@gmail.com>
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

For boards who run their SoC at a higher voltage than nominal,
the boards can run several clocks at an overdrive rate for
better performance.  Add an optional DTSI file which can be
included by various boards to run in overdrive mode.

This raises the GPU PLL to 1000MHz, and the VPU PLL to
700MHz while moving VPU_G1 and VPU_H1 to the SYS_PLL3_OUT
which runs at 750MHz.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-overdrive.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-overdrive.dtsi
new file mode 100644
index 000000000000..b31436b5e9b7
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mm-overdrive.dtsi
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+&gpu_2d {
+	assigned-clocks = <&clk IMX8MM_CLK_GPU2D_CORE>,
+			  <&clk IMX8MM_GPU_PLL_OUT>;
+	assigned-clock-parents = <&clk IMX8MM_GPU_PLL_OUT>;
+	assigned-clock-rates = <0>, <1000000000>;
+};
+
+&gpu_3d {
+	assigned-clocks = <&clk IMX8MM_CLK_GPU3D_CORE>,
+			  <&clk IMX8MM_GPU_PLL_OUT>;
+	assigned-clock-parents = <&clk IMX8MM_GPU_PLL_OUT>;
+	assigned-clock-rates = <0>, <1000000000>;
+};
+
+&vpu_blk_ctrl {
+	assigned-clocks = <&clk IMX8MM_CLK_VPU_G1>,
+			  <&clk IMX8MM_CLK_VPU_G2>,
+			  <&clk IMX8MM_CLK_VPU_H1>,
+			  <&clk IMX8MM_VPU_PLL_OUT>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL3_OUT>,
+				 <&clk IMX8MM_VPU_PLL_OUT>,
+				 <&clk IMX8MM_SYS_PLL3_OUT>;
+	assigned-clock-rates = <750000000>,
+			       <700000000>,
+			       <750000000>,
+			       <700000000>;
+};
-- 
2.40.1

