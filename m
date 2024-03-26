Return-Path: <linux-kernel+bounces-118817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BE88BFB0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F5D2E7817
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03454905;
	Tue, 26 Mar 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GGW0qbMR"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8722D3F8D4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449391; cv=none; b=cAJM3HJVbcfaxV0ELwfxEVVatuJ28QhhnH+zmqJ3PP/hzY6Ld78CzfSAteqA2eg8JyBe2t8ss1GYzJxdj5zusMYAOW2BiZCDqYxzvXeLMkXT3MYvw9BLeXmRDmd34JB10ri5ZDpYTsc6ghFafixbhnQZ1xBYTGMTm3YaSP6y5Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449391; c=relaxed/simple;
	bh=8qAaKLQO3SD0OJxvM87Kikklf46MRsJAjuazPlERR6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LhIFAuis+m/O1DKOrqoOxlHUxy8mTgrMgu2NUKGMEIK9WVF5OwMSWya8KOeF09fSVI7RsaKa3Osi/yZ3GIe69IFMj05sPak2eGcWsmoZlnVjPPlWviNyk6jtZzcPc0c7nXVQRP+XY4aGyuwSJVV9tN74rR/oLUsrYBu9P5zaGEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GGW0qbMR; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so17333001fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711449388; x=1712054188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/+w1Si7Huq78ZhchDNKDfNIJKb4s9aypKdtau9Mluo=;
        b=GGW0qbMRR6BrPmyCYeqhp/GuAgxFvQm7h28kqdS3wmVSF6REeOOj3wM03qMsZd1+J5
         sPDqNCduDgt8rbNmJbrZmbolCb5+/2VHUKkecY+uoIrL8aDsBLQNL+ObVtmyM/Sb77tH
         pKT5UR5oTcXPewutC4/dLVd++G5t5FsxNtn7ITVbxy/cNYghOftUJRiZD5XObIHfHCde
         xu5+lNTp9QCbUmww1JmKDfGlPXcv+areoRVGrHJO3hZ19IMTRGWL9Sn4wXj6Qao9PB9z
         H1aD+ND0vddq/odd/ArW+j9onfjGbfs2lwQWjm1puZOPOrCnpFsAhs6VIYJ429BK2GRN
         eH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449388; x=1712054188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/+w1Si7Huq78ZhchDNKDfNIJKb4s9aypKdtau9Mluo=;
        b=jbbVMY0bYSuEZytWfIdIHaYUocABp4NTkopp6+7JZUl1POMASteIhTi7y62yL/VHLH
         FnxqyA+/y1RbtaOyNTszXtvtkV58PHeJjjJR4BlejKogkrSXHUyvNNm3sNs7kWccc2M4
         m3ZIelP/PbTJQ8XfQcW/Q+II2roOA4uDfHLtdYy7IsxwNxWoiGfa2Rqu9VA9Gf1VMmEC
         kbIvpcwI+wrvHRQICgODd4RBIze1EsZZ7pKw8Nh5XcPfshnZPdMPBZq1+tAY0Wa7eJd7
         ZhMiTNMeOnnuAaRVLLKKnhQAevlapCbyOaS/knCr7OPOVtdKmiMb9or3ZWBNEtK0Li+I
         qvdA==
X-Forwarded-Encrypted: i=1; AJvYcCV+oOAv6XmjOBm8TNSVOcRlQQTQIOrTXj46FstNDB7izV1krxbNxS/iqZpFOIUKP7UFTXi6pghs6rnrwSmbs5wiVX4aTFyDI4zfzeQU
X-Gm-Message-State: AOJu0Yz4QnQVzpBeO/IkXemU9wB0JDlTIGX8AttwRkfjBfJNHLE1C8z7
	xRSCbBnXiSzk8IYMAgA/Mm5PVL8O1OywVBP5pkGuaokwO/TMBb/f8JEkTVQSvVs=
X-Google-Smtp-Source: AGHT+IGwty3UeP9o66ZZ7LxCzj86+p22j4+I70NUOy/UH/NFXljXxJiH0R+XBdgeJndcl3IiAL8qyw==
X-Received: by 2002:a05:651c:1a09:b0:2d4:3e82:117e with SMTP id by9-20020a05651c1a0900b002d43e82117emr1692298ljb.32.1711449387764;
        Tue, 26 Mar 2024 03:36:27 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm3337954wrb.98.2024.03.26.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:36:26 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: peter.griffin@linaro.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: alim.akhtar@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80 chars
Date: Tue, 26 Mar 2024 10:36:19 +0000
Message-ID: <20240326103620.298298-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240326103620.298298-1-tudor.ambarus@linaro.org>
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These lines fit 81 characters, which is pretty close to 80.
Join the lines.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index cfb3ddc7f885..690deca37e4f 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -374,8 +374,7 @@ pinctrl_peric0: pinctrl@10840000 {
 		};
 
 		usi8: usi@109700c0 {
-			compatible = "google,gs101-usi",
-				     "samsung,exynos850-usi";
+			compatible = "google,gs101-usi", "samsung,exynos850-usi";
 			reg = <0x109700c0 0x20>;
 			ranges;
 			#address-cells = <1>;
@@ -403,8 +402,7 @@ hsi2c_8: i2c@10970000 {
 		};
 
 		usi_uart: usi@10a000c0 {
-			compatible = "google,gs101-usi",
-				     "samsung,exynos850-usi";
+			compatible = "google,gs101-usi", "samsung,exynos850-usi";
 			reg = <0x10a000c0 0x20>;
 			ranges;
 			#address-cells = <1>;
@@ -419,8 +417,7 @@ usi_uart: usi@10a000c0 {
 			serial_0: serial@10a00000 {
 				compatible = "google,gs101-uart";
 				reg = <0x10a00000 0xc0>;
-				interrupts = <GIC_SPI 634
-					      IRQ_TYPE_LEVEL_HIGH 0>;
+				interrupts = <GIC_SPI 634 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
 				clock-names = "uart", "clk_uart_baud0";
@@ -454,8 +451,7 @@ pinctrl_peric1: pinctrl@10c40000 {
 		};
 
 		usi12: usi@10d500c0 {
-			compatible = "google,gs101-usi",
-				     "samsung,exynos850-usi";
+			compatible = "google,gs101-usi", "samsung,exynos850-usi";
 			reg = <0x10d500c0 0x20>;
 			ranges;
 			#address-cells = <1>;
-- 
2.44.0.396.g6e790dbe36-goog


