Return-Path: <linux-kernel+bounces-118816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE87A88BFAC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 230C0B269D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAA4AEC8;
	Tue, 26 Mar 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EO8BAolL"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA726DF60
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449389; cv=none; b=h6fKaoomHLMfyyRv9xD7IW8Alr8sHnLpvJOm43CPhIjQ2FXe57qSbvLUV2UooQfzEpkdiTw1affbNn+DpqQoPFNSUqD5+WZTyHnHbAnqk8naPDclaVUVRKHoGGFWzc4ctUenk3/KqscxUQp6kOCM49NlVQ2T5UiZMZCbc2W8OyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449389; c=relaxed/simple;
	bh=PBa73x1wwQXSr1P6PnZ29H+R5VqrMGOD2B/9/u3cZTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJZlavpNsTutU/iCbyKV6AmSERKfjUFtFyLw2YdLZS+lMNLI7XOsJHRlej0ROxVCfNCQM8fKhQePrAmvNwKa/HM7wTET8jz9ZqVs91samxD25k9sfjlQhXIPykm1kgiqwG7yL5f6c3maBAVQtgN8LRl1Ooan/PCpE9anhv05n9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EO8BAolL; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4148c95db1fso6301685e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711449386; x=1712054186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAnt5lmsl2K0nUjwM4CQ0tHKixAt6mU13mvbj43RCEo=;
        b=EO8BAolLtHZG+evEHU1LjNaZABgg2qpum6e7IHn3k2n32dAtNEyn3V5dpA9B5fDqoU
         Xz+VNTWT76Hoeq+GACC+msdoo5SXTXqy4GJenmR1/yrQyS8fPaVblwI3+m64CIz/g0pa
         B/cMUQ1t/xA/LitKrZhEMX0T9f7hRekzcH9TQvv8OAdglxZ1SflUFnSlLAiVj6o5rPnH
         ldA34Xz64tUuWxHIMW7LOvUAj34AluEA8ahLH7L1sEKJfozyZkG8AawFbAYPuG9U7j7k
         OPptEQbKzthGeVgHBzuhtjITrZVmd0YpMGDcsZSUMIn+B6STQk3R5gkQdBj5glmJzyQ7
         KBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711449386; x=1712054186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAnt5lmsl2K0nUjwM4CQ0tHKixAt6mU13mvbj43RCEo=;
        b=PTL4u77iuit38GdqXJKOx2ekUyqNdgiye8QuDIyHA5RUckcvWVeRxSVYtCrGUMdqGa
         2gsrShKyQ8hEkvNJRF9e5ReTruwI0FaOdxHzC15+gC4o13xMO3N6qiq3AS0fMve1CpHL
         /3WHN3JyS+K02bxZvmDROuGhRDwRveX2Nkzvi/CSRtdo4diEp9CYfiyGDRL1ldN8ZhF/
         /LD3BtUlrNBF9NnBf0/SskD6z83Qpa/YHb2/p9fghG3RlTiuBW4AKQH5+wh0LRTjh2nj
         sT8IZh1Q7M+gCP738GO+AuuSQkeEkpyHeL6YkLr6HVCRGI+xTlRFrjvIzc7xeDtvlaSB
         7uqg==
X-Forwarded-Encrypted: i=1; AJvYcCVouWEHWYVKA42vBuQuU0k71Got6sN1RR6+EjRVgB2jvLS4sk+VlkQrURWUPzrdiQvNWIfYapdGV9iKpmuMvrKB6tswb8ECZLAuuIIK
X-Gm-Message-State: AOJu0YxXA3sMJ7wMjZAxfw3a/wySynozVoVBdqtCVf+orkOgAvFE+VLG
	zf63Ry0Yq53LvDt822HBkMLJZDcAqbqKL336iC5gjW2Je22tD97jeV0d9OVZwgU=
X-Google-Smtp-Source: AGHT+IHkLp5ejLlaz88vMjjQ7QEsUY5+JZvNwptIjuzqF/7HWfnMzcqY9973ZnjEQ9Yu4jgC5BJpsQ==
X-Received: by 2002:a05:600c:1d08:b0:413:30dc:698a with SMTP id l8-20020a05600c1d0800b0041330dc698amr6705807wms.25.1711449386342;
        Tue, 26 Mar 2024 03:36:26 -0700 (PDT)
Received: from ta2.c.googlers.com.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id bn22-20020a056000061600b00341d2604a35sm3337954wrb.98.2024.03.26.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 03:36:25 -0700 (PDT)
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
Subject: [PATCH v2 2/4] arm64: dts: exynos: gs101: order pinctrl-* props alphabetically
Date: Tue, 26 Mar 2024 10:36:18 +0000
Message-ID: <20240326103620.298298-3-tudor.ambarus@linaro.org>
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

Reverse pinctrl-* lines, first pinctrl-0 then pinctrl-names. Move the
pinctrl-* properties after clocks so that we keep alphabetic order and
align with the other similar definitions.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 0b0db735dc8e..cfb3ddc7f885 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -393,11 +393,11 @@ hsi2c_8: i2c@10970000 {
 				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&hsi2c8_bus>;
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				pinctrl-0 = <&hsi2c8_bus>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 		};
@@ -473,11 +473,11 @@ hsi2c_12: i2c@10d50000 {
 				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				pinctrl-0 = <&hsi2c12_bus>;
-				pinctrl-names = "default";
 				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
 					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				pinctrl-0 = <&hsi2c12_bus>;
+				pinctrl-names = "default";
 				status = "disabled";
 			};
 		};
-- 
2.44.0.396.g6e790dbe36-goog


