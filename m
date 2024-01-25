Return-Path: <linux-kernel+bounces-38619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607183C34A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2444292E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C825820B;
	Thu, 25 Jan 2024 13:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ksk4o+Cd"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD556B6B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188005; cv=none; b=Ttbl+ZoFZkLkF3dQuHtI36CUuT8Lr9eHob1LbT6m0xijqiM5c0iGB0woJZtC38wPCLCPIvqPem7xaoiIMXhuRDvC23LuMmuvLXFvoHfIK5xQ2/1T6p+CHk2w4IxfqZTGJXu6hNu+FMWq//VUC1mCqI+uQpICr/Pe3HJtfnp0p0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188005; c=relaxed/simple;
	bh=Vm8FYWkCbiN6pEEwfgqVnqgx6X6dabUYF1SQcOeQgi4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K8DCGpWCBpzM8Vd2nPZR2AHSlAUCJxa1T7l+2GD1hcDl+Yi5Ja0GsHmjDHmqFMHeii661jgkER7w5xNWRcxRvFBiRFpFE2IE31EUoNb3CUhVwCYKOSMaMVH3dj+bM0C6u+tXKsgVhIS8KS7XtHgbDtmMo56T7JY12rn3nO9ecog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ksk4o+Cd; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so6221681a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706188001; x=1706792801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz4UOUwLaTrVZVjKRBIuuQV1CZ1n1JSNcVoZKpZXtzg=;
        b=Ksk4o+CdSuwqgXZZ1vMSQQhoXKBocWFevZyu4NuT9i3uFKhB5ZquGNzcHPZMjuTfW7
         UepuOrSB+CKGVq/Lg6tb2Jq22em++JBoBQrxUqWKF96MB8H/bp1T9iB7CCWd6TBq33cP
         Rqz3Y+Dn+ySFKmNKR5axj7BB/pXlkdRvPX5jdrjH2VcCsvwNihDtxS0zRH0ty7HlRpPX
         Obqk9BnOcmA2WM1fInPh/ANB0u2bYGUr5c+9+UCZ/bJYAZHnoVHmdKH3q/NcYevxso+a
         y1TXk3BSUUQWvR2pjBFZqvTbZF7zqLwo8zUb/na514yY0GolgvoCcRrSW2CTJY6z7NoI
         0NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188001; x=1706792801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hz4UOUwLaTrVZVjKRBIuuQV1CZ1n1JSNcVoZKpZXtzg=;
        b=QyE5MBFvD17Pa/a1GRxF8s3auAUoBBxnVEzQOtbJMyt2job83IUsI9hP/AmChogQMY
         cc4rVBgeCHki88qUo4eZdV+fyD/km7A5C0PLe575dzUZGQO7KIFHBVhcWA8r078NMx7q
         9aX7gOX94/OLx9y39rPNAy/Rtvz9bhR9Au/E9G+GhIQhbyHjyrXhX3449P4+oxGFNAZz
         EIHoUKCmv3G6xTmVATY7YfYpJvBwRMlVM6l6jkZVQHMbhmx8bKuJnw1Ty/QjXsSLYRVy
         Z9+oCa87hazB6uF1ix8Ub5WMYb45ejIbb9Kfj6w+S+wA4M3LTO3aGWKpIEJZgXxYZYhS
         BDuA==
X-Gm-Message-State: AOJu0YzMRsA29sf9XrFNYu1QRO4DAkRJiBZTmm3iXlt2DINEc/2Mtj/0
	igOqBZbLCsIeMERzzlU9lBCpoucc1P8NaZnw4rQjw6q563WHltaJr+r1jmYhIG0=
X-Google-Smtp-Source: AGHT+IHm6+LA7xKQVSTlAszsDlUkRYqXhWF42y0uqkcwpk8+pO6DRmRsYDU9XLKhjy6W3WVccCpC/Q==
X-Received: by 2002:a50:99de:0:b0:55c:fd62:18a4 with SMTP id n30-20020a5099de000000b0055cfd6218a4mr283034edb.82.1706188001502;
        Thu, 25 Jan 2024 05:06:41 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ig1-20020a056402458100b0055ca5ce62ddsm1873315edb.12.2024.01.25.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:06:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 6/6] arm64: dts: qcom: sm8650: describe all PCI MSI interrupts
Date: Thu, 25 Jan 2024 14:06:26 +0100
Message-Id: <20240125130626.390850-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org>
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each group of MSI interrupts is mapped to the separate host interrupt.
Describe each of interrupts in the device tree for PCIe hosts.  Not
tested on hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 2df77123a8c7..9fc4f3e37a8c 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2213,8 +2213,16 @@ pcie0: pci@1c00000 {
 			      <0 0x60100000 0 0x100000>;
 			reg-names = "parf", "dbi", "elbi", "atu", "config";
 
-			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 
 			clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
 				 <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
@@ -2317,8 +2325,16 @@ pcie1: pci@1c08000 {
 				    "atu",
 				    "config";
 
-			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "msi";
+			interrupts = <GIC_SPI 307 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 308 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 309 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 314 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "msi0", "msi1", "msi2", "msi3",
+					  "msi4", "msi5", "msi6", "msi7";
 
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-- 
2.34.1


