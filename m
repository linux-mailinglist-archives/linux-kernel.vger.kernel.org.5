Return-Path: <linux-kernel+bounces-38617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF983C33C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730A31C23AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0834651014;
	Thu, 25 Jan 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu6UsZaW"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEC754278
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188001; cv=none; b=sngODtYyMDpcivzzO2ecc0fd2AFbwfABJIf/Xft2bBWH2sokqVuYXc1GPIXc4toct/2jodqdxNOR9ZycYmj8UHkE3Qlo3773oY9mvcenG4XpYbhWLLFD/kJesNmsXIYObwVUeaEjgnXSPXtH5b6+q2uj69lFWjPTnk5Ht5sbp6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188001; c=relaxed/simple;
	bh=8XC8NJ2NcS8Kjm/9BPbg3ZBSERWHKQEz2mfwjSKoC/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CNwFbMswa1avVq8uXXVpg6z69tgHKvBtRpjX61pBxE47UMsCWrYMOVLkCKUYogJ4q6QXejIOt26e5UeX5Xfs8Uct4bA+k8Q0lyHlYqgfN6S45yvZP4/JhYZOVyb1pVxNf69ehQYTD0VI1OkoGsJsIFrOXNS0qKB+nCCPMu9ojHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu6UsZaW; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55cef56c6f9so954470a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187998; x=1706792798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFG5WQb/wLFt5isMQsjJbaJFdl++eyZorkiaDRvi+/M=;
        b=eu6UsZaWWMoKIh8jKBeZ7FUvPHEcHiV8/yt9ktuCm/qaH+0l+07bylh5MmO6WC/iZ4
         orEmdDnijKnvJUHizzBB3spXgfkCyBqCKRgJ+aDW9jTRYzo0/6HVJ1Or9Mh8KExBRRIz
         4tee0xqiIyub2uYf//Zrw/daoOKaIPCW6CJajUFYLHhP90ZLxybs7ZTVcJ/HCAfZMTcw
         l+AP+f132vOb/+7rknGa4s722vN+w3FM5BGO95BcV103iAfD254PeVjyYSdiG8uyNRz5
         g3oQXhh0hxt1KClzes+HT/qLxsn8PqBmvMrN7ddkqV809IWLir1kHUHRwDazxLTQmHmH
         cYKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187998; x=1706792798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFG5WQb/wLFt5isMQsjJbaJFdl++eyZorkiaDRvi+/M=;
        b=LcwiKFvI9e84Nmz9vLT2c8WziVQtptAkQVHv7U2Tikbznq/Nw2TrJnrVXAkXZvVFsk
         nMkyCkSUDDaZBQ0/42qG3peZCtCEe7wJ9AS0TRfR4grBkcUHZ7m/XFCBFJC8gPLgMdrY
         tl/G1VtQ57r2awTJGttdbLby1jZvWtTJMQZdg7vrzHMrVtpxw65TnurO56IFW0Q4HYsN
         uIxtrmU9ZYkkpwdSlOvk9a6qbmJRJNtjHjNfBB6Ai08ieafs4aJTbiP1LuBLH1S1ikhv
         OPd2qtewqeGTPtHPhgF3DsXIJcmlYKDRoL3WDUcQKaaakU5v+edXgtXpLKJR3+PSocLt
         Bpow==
X-Gm-Message-State: AOJu0YxE7jPZbR0AMgwGjQ2vK9G+GYumRGEGrDJEUjjQZM23IP+tFvxu
	rpedmrdKFiLthq6EaCLVa9tw94LtecZlQp0u+hmPezvNxMj/UWUcqqLY4HuiIWc=
X-Google-Smtp-Source: AGHT+IE6XvYnsRe9NdOXHcH+gkynxuFp3rjAzo2eH85YohKw2h78OkbY5UTossGSMmDogXwScw88BQ==
X-Received: by 2002:aa7:c914:0:b0:55d:1774:b130 with SMTP id b20-20020aa7c914000000b0055d1774b130mr81105edt.85.1706187997820;
        Thu, 25 Jan 2024 05:06:37 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ig1-20020a056402458100b0055ca5ce62ddsm1873315edb.12.2024.01.25.05.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:06:37 -0800 (PST)
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
Subject: [PATCH 4/6] arm64: dts: qcom: sm8450: describe all PCI MSI interrupts
Date: Thu, 25 Jan 2024 14:06:24 +0100
Message-Id: <20240125130626.390850-4-krzysztof.kozlowski@linaro.org>
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
Describe each of interrupts in the device tree for PCIe hosts.  Only
boot tested on hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 06f183ef8c78..235e31c86e38 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1784,8 +1784,16 @@ pcie0: pcie@1c00000 {
 			msi-map = <0x0 &gic_its 0x5981 0x1>,
 				  <0x100 &gic_its 0x5980 0x1>;
 			msi-map-mask = <0xff00>;
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
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
@@ -1893,8 +1901,16 @@ pcie1: pcie@1c08000 {
 			msi-map = <0x0 &gic_its 0x5a01 0x1>,
 				  <0x100 &gic_its 0x5a00 0x1>;
 			msi-map-mask = <0xff00>;
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
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &intc 0 0 0 434 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-- 
2.34.1


