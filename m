Return-Path: <linux-kernel+bounces-38812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90083C64F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6221F241FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F9874E29;
	Thu, 25 Jan 2024 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lr8ZW/KF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B0373173
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195806; cv=none; b=ATD/dt/85bpjB3s5od+yP1n0J7Z8gcUpXfIm/j2oKwANkTVz5M86/QUOMp01SIdl4gR8dM4FcDwtHX0bmXUxVfa3jYbZMMYY7MwtqsdTkn4S6nw+4YXjEscHqv3mD8INM20fwiuWb3dE3TtVERzIArbeEgQPABQbRAzvZI7yR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195806; c=relaxed/simple;
	bh=CIAizzJebZtx1/g8zjjifKsCrrjh+jRaAW0m31CylKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1i5WRa4sdXB32QS9xFq9tGB6NpQCPwjLPhRb1vIVXSFxZnLaEWoH8gv0wKok/PvXL6Lly6yyZgR2ppcPLLoxVmuA0Ps9EFtmanexG9iN82vpQlEMt4AkuGGQz5F4kuyQOGfXBCdANhLdN8Y/fByw5d2TDNZU4YyBUKeN5SF1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lr8ZW/KF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso74966715e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706195803; x=1706800603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYvvmpy3gvXDtu9+cgwcBJMRAtk90gz+DuNp4PyQjQs=;
        b=lr8ZW/KFLrMlmub6tCbbsov0TV3h6WBAEzfm9AkY7k29SoFnS/yT4lOvEHDmBHXFqJ
         7CX/+D4KM8X+FbwVKpzhoWCRilJbIMN1nnjoTjyzJFSPI7HRAuk5sW4hX9KQzvzhSc7s
         NShek+smH3N6HoTsdY1SiuA3GKe5wRw22OraeemSNzQ+MyHXp+EwM6ISR7oof625DVpZ
         FELf4AIWnyq1HahTCzRxpiFo2d9S1BuDTZqcx6YlantAbFghSJwBBnEQoZRdqL9lvEfe
         SnnEJ/kZMWCdZoWmUHPc16LGLuGOHJhRVGuaJrRd6epCvIK7AtQFWYAZbWMwrqvc0ZE9
         PByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195803; x=1706800603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYvvmpy3gvXDtu9+cgwcBJMRAtk90gz+DuNp4PyQjQs=;
        b=U+Z82UQX2Dpvo+uaQ7N/uHmLG06i1yCK8Xbdqi+wIZUujn0ID9qOfdxQLJRhtoBjN5
         zXEV4pVA9MZBOzO852cpds3Rjlvt2+kYPkiUg542oziKbEje4w14Do+fKPobwN0x5kQ8
         lW+NxhS/uqraurdY6jkqR19M+sbeTMuU8FZhpqCAQUtY8PSBEEOtg38MdbQEkBxhKSGK
         ES+0JEC9tz3yEmuVTeuMQXYNH/uYEWXSH5o+Lqjuv3GAmsp2qu3n6ZugrymClf+AMi8+
         6lEv/zxrtpNF1gxTC1aKZzDuU+Bvp1u9JjyBTw03fUO6XFyugaNpVU4lYUpvw0/KxZQN
         1naQ==
X-Gm-Message-State: AOJu0YyHVItrISEdklW7Z+1uq+h9v/8IX/zx61tPaoyzoLJH+a+x0wi8
	PYSuFHqnOSTVuzPzQYciAB0cDVAcFrrb96pQC9JngByHSNz9uW0kdWGyxX+VwWo=
X-Google-Smtp-Source: AGHT+IGuWq41cd/mRGhM7in6UzcnHANCL0ranLj92tjRczIUg8SRuL80g/hVClELM745HKmfd4IpZQ==
X-Received: by 2002:a05:600c:4f52:b0:40e:d425:841 with SMTP id m18-20020a05600c4f5200b0040ed4250841mr256288wmq.60.1706195803587;
        Thu, 25 Jan 2024 07:16:43 -0800 (PST)
Received: from ta2.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcb91000000b00337d3465997sm3184656wrh.38.2024.01.25.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 07:16:42 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org,
	broonie@kernel.org
Cc: robh+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	andre.draszik@linaro.org,
	peter.griffin@linaro.org,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 3/7] ARM: dts: samsung: exynos4: specify the SPI fifosize
Date: Thu, 25 Jan 2024 15:16:26 +0000
Message-ID: <20240125151630.753318-4-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Up to now the SPI alias was used as an index into an array defined in
the SPI driver to determine the SPI FIFO size. Drop the dependency on
the SPI alias and specify the SPI FIFO size directly into the SPI node.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm/boot/dts/samsung/exynos4.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/samsung/exynos4.dtsi b/arch/arm/boot/dts/samsung/exynos4.dtsi
index 7f981b5c0d64..10967063727c 100644
--- a/arch/arm/boot/dts/samsung/exynos4.dtsi
+++ b/arch/arm/boot/dts/samsung/exynos4.dtsi
@@ -621,6 +621,7 @@ spi_0: spi@13920000 {
 			clock-names = "spi", "spi_busclk0";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi0_bus>;
+			samsung,spi-fifosize = <256>;
 			status = "disabled";
 		};
 
@@ -636,6 +637,7 @@ spi_1: spi@13930000 {
 			clock-names = "spi", "spi_busclk0";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi1_bus>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
@@ -651,6 +653,7 @@ spi_2: spi@13940000 {
 			clock-names = "spi", "spi_busclk0";
 			pinctrl-names = "default";
 			pinctrl-0 = <&spi2_bus>;
+			samsung,spi-fifosize = <64>;
 			status = "disabled";
 		};
 
-- 
2.43.0.429.g432eaa2c6b-goog


