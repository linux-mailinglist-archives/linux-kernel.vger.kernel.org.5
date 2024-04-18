Return-Path: <linux-kernel+bounces-150755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6438AA425
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8E3E1F21808
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA199190696;
	Thu, 18 Apr 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeaMMQHg"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFC1199E8B;
	Thu, 18 Apr 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472706; cv=none; b=sehMKlQdmjq5v2l2WA17B2XNciDMHNr9RT889ysOF4CVgO+vOovxSMAZ06n/CFJ6aZ5m+3gqeAXcUzbZNXdBurqVX7jVv/V6kenLbQipcknOLnT6SKJzjJbK4MQLbd5Hd1kBJCqhwAm/1I+4U3xUJWZucEGx1T3CfOQ8TCRI1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472706; c=relaxed/simple;
	bh=IXsOSB48KhBFOf88YD8Blw+Mq+X3++0K3YE2RV82H3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i+ubhUx9R4hMIcqnP0OlWPnR7uoTQhRtEQ1BB+pe60+quOVfZ4Paye/Lx0wv9OiUNIhizHrr44Lmoyh3I9qq3oG5QWYyMPl+0JmcncMxM8U2X7O61fWHJSkQ3obCx74mFcTXLN/T/BNq+8Vh0kJ4r1O6FyeF0dZ7z+7T/Al02j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeaMMQHg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a52582ecde4so121980666b.0;
        Thu, 18 Apr 2024 13:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713472703; x=1714077503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A9GTsxN8IunCYp1DUkY8RgJAa3KxxBOsbu5rncJB9Y=;
        b=YeaMMQHgSoYK8eiiUqWRCwQVO9h9/+vdk4P+HzU9+3PF2Nug/vmBanjR9jVxkRp4fj
         /XL4HPKTJ6IHsM/ra4LfrAz1A176WWlPLtZJooIGtyCmJxKsjWo0JucC5yKUz8pAp9Do
         d+QOr9I1zv1m+ptF6KWoyXXvCc9XbXq8g84qg/bm5sxr4Oqv82X5CAzfjlFO9aImYVAc
         U98qCvTc2QYHzmGXoEATvO6rvuBvukyYmkhn8J3TfcV/RZ50fs5wSzKzJcB7JGQlidV5
         NyIlLXwOmxep1g+fcEgYXg041NXIejbDY+56vzuc1M+IbnFYhnJ/GakBkqdWcHLNztP1
         wDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472703; x=1714077503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A9GTsxN8IunCYp1DUkY8RgJAa3KxxBOsbu5rncJB9Y=;
        b=m7kKkfAcuEg70ZbjvsAp3ELpbQDVhG8ETVQLZYCNHThMDhv6dXJhXs5qHKovhDox/L
         UqXC8K0+EoW646QpsIBnX+0t+7u1ln4Wc5dQzlaF7r1/vOUyyJxWTtp3hu9DEVKeeaME
         R/snxTFoUCQjC2FqbTMYrSBHsF6h5/lLiXA2SUCsW3jyq8czHtjjDYjlOCTLYhzaOS+Q
         Hfucz6/wFvZY2NiZUhym2P4moOyt5NyK1+IRTb2C2m9PVznmoCCQoXzTbAmcrOXnS4hM
         rJv0uha/eF7i4Mbu0JVrzmxn1xflceGoQtfXw7P7YrPAwmCO/8t8+i65Y7RkE3ZKf8Di
         lPiw==
X-Forwarded-Encrypted: i=1; AJvYcCWXZndWjs+Sh/ECwej2dDPDzsu1BmFLPi0kZmf2w7jsdcYJGPkSPhAUiJurugJlzNFn+mXzU3mLRg1mjK4KahH7MWFMwlX7hE74yLnpiVNz8tC2o5suJFgZ0V+4Hv2uqRpQyNKWNoJJGw==
X-Gm-Message-State: AOJu0YzqtU4dhbuUhbFX15Ou9Jd6XOptiW615peS1KCgQf6wwHWCG735
	ldhUqLufat0Z7fl0QtmphVfPhKVMjIptKo8s3tKWeDBAbIYdToN9
X-Google-Smtp-Source: AGHT+IGzLyE7VxWjZDABe7Un265onJx95a/vOFgpB1qchpktSO/egBKsgsmbcFgr7ax7wodqHkbROQ==
X-Received: by 2002:a17:906:5f89:b0:a55:5ba6:ace9 with SMTP id a9-20020a1709065f8900b00a555ba6ace9mr165722eju.9.1713472702807;
        Thu, 18 Apr 2024 13:38:22 -0700 (PDT)
Received: from lmc-playground.localdomain ([188.25.209.252])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906079500b00a473774b027sm1305649ejc.207.2024.04.18.13.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:38:22 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Liu Ying <victor.liu@nxp.com>
Cc: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/3] arm64: dts: imx8ulp: add DSP node
Date: Thu, 18 Apr 2024 23:37:20 +0300
Message-Id: <20240418203720.8492-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
References: <20240418203720.8492-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add node for i.MX8ULP's DSP core and its dependencies.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 39 +++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 22 +++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..5dadcbba370d 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -67,6 +67,32 @@ vdevbuffer: vdevbuffer@a8400000 {
 			reg = <0 0xa8400000 0 0x100000>;
 			no-map;
 		};
+
+		dsp_reserved: dsp_reserved@8e000000 {
+			reg = <0 0x8e000000 0 0x1000000>;
+			no-map;
+		};
+
+		dsp_reserved_heap: dsp_reserved_heap@8f000000 {
+			reg = <0 0x8f000000 0 0xef0000>;
+			no-map;
+		};
+
+		dsp_vdev0vring0: vdev0vring0@8fef0000 {
+			reg = <0 0x8fef0000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0vring1: vdev0vring1@8fef8000 {
+			reg = <0 0x8fef8000 0 0x8000>;
+			no-map;
+		};
+
+		dsp_vdev0buffer: vdev0buffer@8ff00000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x8ff00000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	clock_ext_rmii: clock-ext-rmii {
@@ -95,6 +121,15 @@ &cm33 {
 	status = "okay";
 };
 
+&dsp {
+	assigned-clocks = <&cgc2 IMX8ULP_CLK_HIFI_SEL>, <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>;
+	assigned-clock-parents = <&cgc2 IMX8ULP_CLK_PLL4_PFD0>;
+	assigned-clock-rates = <0>, <475200000>;
+	memory-region = <&dsp_vdev0buffer>, <&dsp_vdev0vring0>,
+			<&dsp_vdev0vring1>, <&dsp_reserved>;
+	status = "okay";
+};
+
 &flexspi2 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_flexspi2_ptd>;
@@ -176,6 +211,10 @@ &mu {
 	status = "okay";
 };
 
+&mu3 {
+	status = "okay";
+};
+
 &iomuxc1 {
 	pinctrl_enet: enetgrp {
 		fsl,pins = <
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..99ed8c1ee57c 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -198,6 +198,22 @@ soc: soc@0 {
 		ranges = <0x0 0x0 0x0 0x40000000>,
 			 <0x60000000 0x0 0x60000000 0x1000000>;
 
+		dsp: dsp@21170000 {
+			compatible = "fsl,imx8ulp-hifi4";
+			reg = <0x21170000 0x20000>;
+			clocks = <&cgc2 IMX8ULP_CLK_LPAV_BUS_DIV>,
+				 <&cgc2 IMX8ULP_CLK_HIFI_DIVPLAT>,
+				 <&cgc2 IMX8ULP_CLK_HIFI_DIVCORE>,
+				 <&pcc5 IMX8ULP_CLK_MU3_B>;
+			clock-names = "ipg", "ocram", "core", "mu";
+			power-domains = <&scmi_devpd IMX8ULP_PD_HIFI4>;
+			firmware-name = "imx/dsp/hifi4.bin";
+			mbox-names = "tx", "rx", "rxdb";
+			mboxes = <&mu3 0 0>, <&mu3 1 0>, <&mu3 3 0>;
+			fsl,dsp-ctrl = <&avd_sim>;
+			status = "disabled";
+		};
+
 		s4muap: mailbox@27020000 {
 			compatible = "fsl,imx8ulp-mu-s4";
 			reg = <0x27020000 0x10000>;
@@ -520,6 +536,12 @@ per_bridge5: bus@2d800000 {
 			#size-cells = <1>;
 			ranges;
 
+			avd_sim: syscon@2da50000 {
+				compatible = "fsl,imx8ulp-avd-sim", "syscon", "simple-mfd";
+				reg = <0x2da50000 0x38>;
+				clocks = <&pcc5 IMX8ULP_CLK_AVD_SIM>;
+			};
+
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-- 
2.34.1


