Return-Path: <linux-kernel+bounces-28624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616828300D9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766391C21614
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F421118D;
	Wed, 17 Jan 2024 07:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E92xSFzG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF4C148
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478188; cv=none; b=bx+8g+GhbTKPvYMx6YkMGA0XgTZuIT8JjFAsKTfs4m9wzwS8dZGsI4VCX6nBLKzn/W33mcQzuO+rsYMONzpUsDhIZIopM7L7C3OSZUgiuWCLj6tWaxEInsakXcVK2JNH+NpVbubbD/mrS9v6OIoFE8/GXgJYLVK5QrpQnvmSn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478188; c=relaxed/simple;
	bh=evreGpJ9LHGvEJptpUIvv5R5Yc026tQowwx5l8jkU9Y=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding; b=VOpmQDknhrEhgXi7Ff6mrL7Gt2BB4LFagMdtzj/K+IMRTuiCFpUb1lkYPSrjwG6m2ycwDhir8WMHc/ZOsmxwJltRgQpfuolsA0k7k8BSMenJMcjxHNVZr3VJF4Hl+AENVDSVlVBOh9s8yHRrXOTDKdqZqhamPPvUmf4KJFLQ8qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E92xSFzG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e741123acso13162138e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 23:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705478185; x=1706082985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1ikojdbGs7xDo7niT+1oLSnQGCDtDxb/MkgvOzMnfQ=;
        b=E92xSFzGkEOGEtvX7OvpbbaO+O2HTKggEELIcNsZWDdNaOfU2gUqsE1pT7MdDaz+g/
         7eaEmHj9g6MLI26jm4XzaBH7XPhHk4abbvCNKahjpPBuI1fLvF56hEawlKObW6NLcMF9
         MeipUqNy5eDeCL0VwH5J2hL0loH89xRefGAN+Ut4RU1dW1JsZvPDcHEfbE9MgIVGSg2A
         sHvL8VfoMXj/QffeNaVXnEfQlfXBmxlKItgnaTyD6aV3bw9vPZFpij8JQYORzPjzBnBP
         y2ccU8unPIFAh+CBhgv/ukUUyxFWkxtZFi/0IHTl10KFQpNNbKKRmm6P8YmE8Gki7cNA
         XsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705478185; x=1706082985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1ikojdbGs7xDo7niT+1oLSnQGCDtDxb/MkgvOzMnfQ=;
        b=fFVF+VcMWoIMbv8j5vdPiqB6c3VpvSKV4hV7nXoMw7Toqiw5NaXVlOz0PFPFcws9ik
         7kiUrfACvbE0vprM32wNxdO7Ho+2cf8bB7FMTtexDV61S+uK4v1WuqNu33nS3uEvAmLs
         DLJ6MhSh7sWaoKeYm5Hbi8O5MLnrrT37+iuZDwQliy8zo041+9Ax3WynKWh2rfAOkxpY
         w9modVmuSoTda+g19tQ2gMiOrABT6qVBaS9hVHTkkNwhATRFZPt/f7H7ZSJpiOXqtdef
         rxlBpM6xFVRnHVd/br7fIXwpbVQ1CHgJWLjqvw9d/83RBKZGAG9qODaW5t5JThc7DOh2
         +VDg==
X-Gm-Message-State: AOJu0YzI5+RgM3VGV0N73HEJ4w2xe778mdadNuV8w6vgI1I4dVMEBrT8
	MEpQYpXYbQTJkHBY9+xHqo1yjQbG4+6HOg==
X-Google-Smtp-Source: AGHT+IH1lZmQtaAndRJ+LXGucJE38oBaOnStf0fj+tk7FqnFGzgsPeytlARYdgzXocquwH2AHk6E9w==
X-Received: by 2002:a05:6512:e91:b0:50e:7fd9:11 with SMTP id bi17-20020a0565120e9100b0050e7fd90011mr4391489lfb.83.1705478185190;
        Tue, 16 Jan 2024 23:56:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fg7-20020a056402548700b005593c83bdafsm3911729edb.45.2024.01.16.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 23:56:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] arm64: dts: imx93: drop "master" I3C node name suffix
Date: Wed, 17 Jan 2024 08:56:17 +0100
Message-Id: <20240117075618.81932-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following change in the I3C bindings, the "master" suffix in I3C
controller node name is discouraged (it is "controller" now) and not
accurate (if device supports also target mode).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

The change can be applied through independent trees, if the I3C bindings
change is applied.  Therefore please take it once I3C bindings is
applied.
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f2e7c42ad6e..601c94e1fac8 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -294,7 +294,7 @@ tpm2: pwm@44320000 {
 				status = "disabled";
 			};
 
-			i3c1: i3c-master@44330000 {
+			i3c1: i3c@44330000 {
 				compatible = "silvaco,i3c-master-v1";
 				reg = <0x44330000 0x10000>;
 				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
@@ -671,7 +671,7 @@ tpm6: pwm@42510000 {
 				status = "disabled";
 			};
 
-			i3c2: i3c-master@42520000 {
+			i3c2: i3c@42520000 {
 				compatible = "silvaco,i3c-master-v1";
 				reg = <0x42520000 0x10000>;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1


