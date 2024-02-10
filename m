Return-Path: <linux-kernel+bounces-60540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1E7850653
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85A27285CCC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B356026D;
	Sat, 10 Feb 2024 20:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFpIJVAj"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135515FDCF;
	Sat, 10 Feb 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597991; cv=none; b=HIrRSqC86lqG2VqJwVk3l4wXZWz3SUO3dyxwDy2Fm16lwS7wQnnzre5jSARcbOR88X+Sy8QrsHbdUpxfe5JE37LQMGH4mHjL16nuFtgiYMmEtznlnUQZbOuh9LiTjSOjzEIUG8Nqc4HiM7murfNWUnUEoOFSCNele0wNyC94jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597991; c=relaxed/simple;
	bh=ue0GFnZw3dNjXibDm5Ix2yNl0Ik8WqRl7PbhdaBtUuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heEgx43cVI+eDZZuSUpB+Jka2psmA1B9t09AoWPSDdBLTm8rDMXCwSErHVl3qohRsWwRm5Irsi1U0uc477fbv9oPXTricQOWPU0AUsa9EzxzibJkbQ0S41n9/6tJmtTfZPdR6YOizNX/5oA1gZ8O7K26+WaWYEA8rIJv8wxqcg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFpIJVAj; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5961a2726aaso1326015eaf.0;
        Sat, 10 Feb 2024 12:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707597989; x=1708202789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+jee4efnNUiNV1RtX5y1A9X8AcFgWXwTvWCcq5t/8o=;
        b=HFpIJVAjkK2+C+SqjUdXtpzIzM6g4FnBkKNpPoJLcSrJssnn0StddbAL5H+C64sgPy
         070wwwG3cRo8cPMuNbXe70ErGno/CcZDDR4u0+s6imSE/G+JZARuNiiUoqCyLzWJ6AF5
         EdzQ7DCjb6Aalv8yIwORsA5zBMeBrfSkYC01RrYWNRr/wce/ZvRgAhwPqpm/qra6GAPG
         4mPISmodAi2rI1+DiG1Eme7bTjmpFgvpb+JvWerzxs84Xfr7/+/La4z1pQ/R8vTM/QXH
         uq0TAa24wyxfXGg6kJRQ5KuIg2mF5RjSm19jyO6uIxuBGzbN0DHVk9idWMsALa4OMV/Y
         QKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707597989; x=1708202789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+jee4efnNUiNV1RtX5y1A9X8AcFgWXwTvWCcq5t/8o=;
        b=cIwiO8M9cMxzRxodFKI75xYvpG0Hg1NNj9w9Cgs0OOzb4N+ic0rQ8rNVvbSLdbQwix
         dRH77xsdZBA+YqdQX8v21mBKQ/k+xgXaX9Yp5IxzEaQPKEpQ9gZVvqwBKLVO7+h+3+gc
         oxfpHo5mD+sKXUSmfx0qGiUYSGmPKDAYw/GAhwSX/Vko07ERgS1EhEg3v3X7k99T/u+w
         bLBBbVUSexr8YZHNwdvaXpvyRbVrlZqg6qz9eoySeo+mpwOag0C5Eb9GCSJ0VHgff+Lw
         v5KEuUDV8uEpxvxzAAXnbQ03UF03DDJGy/+WkiXXt6vSLJSWhx6WqKC6QrmK3qyeA4fZ
         C3ag==
X-Gm-Message-State: AOJu0YxYbY3jFyx06K0WZMtD75FEFGm3DoI/TKAka/myj/3FJNY2322l
	drI9Ws8WrL9m/fKamJz7a9cLSZLABI15YoiN+qxzZXTFWS0wt2RW
X-Google-Smtp-Source: AGHT+IE+7Q4zjnqD99X1wOCIWZux1UlC3g48TiSZqsWGyoEcQOAOcEZ9Sgyjp6zyB0blK/ckLz0q4A==
X-Received: by 2002:a05:6358:61c6:b0:176:5c75:b348 with SMTP id x6-20020a05635861c600b001765c75b348mr5305197rwx.4.1707597988924;
        Sat, 10 Feb 2024 12:46:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/Funz6vl4Z8HBiKu/tAOPe+UvMuiG/UEkDEf0wfP4rrmmLME6f5IAZc3kZr1cpU6lsLRwPHo42SbVjrjngMsy4dvhblCcqsGbFjxGQYVb3hy/zmhyi/Q+eOjGTo0c0dSZxBar+5mwsxWNbqO0s7XHwg1hudShO8rTwJulSyD+LzqB+64kPrjB3qa7t0v5TZLy1ckyoshpSildO27RPlSrYITgLtoVfGTPmG4hmhlbuD+Tre+wdv1w8PiRh2AgAfOf2eTjkGTP+CZWpuQGLa9jsrzQrUT1/sljK6GA0ZToA/b3IU47Prq8OSjj7LxPf0tRZz7WNCNpa1aEpTw4bjOZsHXLtEUjsbuiMN3QJWQ4PnDahI00sE1JP9SDA9CEeMraXkuCyu1Nk0Gd+BFkS8/eQm4cdRaM6T88D0HO1KV71B3vXl9zj8LmLahFDscex8oAUSY9/br9NOcaf7pQKMktQg3YpzxcMwL2jf6PtVRL5cNrraGggfGzEDhmVipDzK3FY8NrxMSs8kGhdWFPN6+8eKwtOvefnR++wbFLQNdQbuC51lMPjve2YgpUsKm1nZqJJUUcywNFUOBQA9ysRS01KfBND6jm5rghpnToD8Wwfw==
Received: from aford-System-Version.lan ([2601:447:d002:5be:27d7:3989:2897:88a7])
        by smtp.gmail.com with ESMTPSA id m20-20020a0cdb94000000b0068c9db26ae1sm2079526qvk.41.2024.02.10.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:46:28 -0800 (PST)
From: Adam Ford <aford173@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: marex@denx.de,
	aford@beaconembedded.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/6] arm64: dts: imx8mp: add HDMI display pipeline
Date: Sat, 10 Feb 2024 14:46:01 -0600
Message-ID: <20240210204606.11944-6-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210204606.11944-1-aford173@gmail.com>
References: <20240210204606.11944-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Stach <l.stach@pengutronix.de>

This adds the DT nodes for all the peripherals that make up the
HDMI display pipeline.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  Re-ordered the HDMI parts to properly come after irqstree_hdmi
     inside AIPS4.  Change size of LCDIF3 and PVI to match TRM sizes
     of 4KB.

V2:  I took this from Lucas' original submission with the following:
     Removed extra clock from HDMI-TX since it is now part of the
     power domain
     Added interrupt-parent to PVI
     Changed the name of the HDMI tranmitter to fsl,imx8mp-hdmi-tx
     Added ports to HDMI-tx
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 94 +++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 9b8ab367d774..013c2d9824cd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1940,6 +1940,100 @@ irqsteer_hdmi: interrupt-controller@32fc2000 {
 				clock-names = "ipg";
 				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_IRQSTEER>;
 			};
+
+			hdmi_pvi: display-bridge@32fc4000 {
+				compatible = "fsl,imx8mp-hdmi-pvi";
+				reg = <0x32fc4000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <12>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_PVI>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						pvi_from_lcdif3: endpoint {
+							remote-endpoint = <&lcdif3_to_pvi>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						pvi_to_hdmi_tx: endpoint {
+							remote-endpoint = <&hdmi_tx_from_pvi>;
+						};
+					};
+				};
+			};
+
+			lcdif3: display-controller@32fc6000 {
+				compatible = "fsl,imx8mp-lcdif";
+				reg = <0x32fc6000 0x1000>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <8>;
+				clocks = <&hdmi_tx_phy>,
+					 <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_ROOT>;
+				clock-names = "pix", "axi", "disp_axi";
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_LCDIF>;
+
+				port {
+					lcdif3_to_pvi: endpoint {
+						remote-endpoint = <&pvi_from_lcdif3>;
+					};
+				};
+			};
+
+			hdmi_tx: hdmi@32fd8000 {
+				compatible = "fsl,imx8mp-hdmi-tx";
+				reg = <0x32fd8000 0x7eff>;
+				interrupt-parent = <&irqsteer_hdmi>;
+				interrupts = <0>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_REF_266M>,
+					 <&clk IMX8MP_CLK_32K>,
+					 <&hdmi_tx_phy>;
+				clock-names = "iahb", "isfr", "cec", "pix";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_REF_266M>;
+				assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_266M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX>;
+				reg-io-width = <1>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						hdmi_tx_from_pvi: endpoint {
+							remote-endpoint = <&pvi_to_hdmi_tx>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						/* Point endpoint to the HDMI connector */
+					};
+				};
+			};
+
+			hdmi_tx_phy: phy@32fdff00 {
+				compatible = "fsl,imx8mp-hdmi-phy";
+				reg = <0x32fdff00 0x100>;
+				clocks = <&clk IMX8MP_CLK_HDMI_APB>,
+					 <&clk IMX8MP_CLK_HDMI_24M>;
+				clock-names = "apb", "ref";
+				assigned-clocks = <&clk IMX8MP_CLK_HDMI_24M>;
+				assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+				power-domains = <&hdmi_blk_ctrl IMX8MP_HDMIBLK_PD_HDMI_TX_PHY>;
+				#clock-cells = <0>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		pcie: pcie@33800000 {
-- 
2.43.0


