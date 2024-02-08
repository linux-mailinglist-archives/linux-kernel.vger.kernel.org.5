Return-Path: <linux-kernel+bounces-57903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B39A84DED4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42391F2B075
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDDE76910;
	Thu,  8 Feb 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/mJ8J8F"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3C76908
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389569; cv=none; b=d1G/vreiT9Wp8XEYh5pkvZu4rmaTmCKc0Em7dJx5i7xRimCE/XfZSAGe6i5a4SQ6Jlun+tWASsNVCY9w0fMnDMc85AqGr8JQVOqRwfwy7Ds+MfkTfz6/dzzPXd7Qv/Z985U8BU3iBP+lgeIuGpzqkZrQ0mJU5X+PYit0ix5+PQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389569; c=relaxed/simple;
	bh=+ifZekRvDModjrZr9ApFYUpDKplDQ6MJNn7whDRcbdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zov5Xa6t2tHn/LmIPskGzHl2k1O2en+kSG//s5GS64+Qtq810yp3gt5BzrqWcuIoV8u9AICR+EJRZeOEHB3gwb9bs2Th3/btrFGDNIJUqU3FflEIwC3U7z5iiMPR2sLDNqWsML5QK4xsm2TUk5Ldp85Zurgo2OyC0Xlit58t5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/mJ8J8F; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4100826df08so14446945e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389566; x=1707994366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ULymJuwmD+Lr46QJ71fk24DGc1du2NJ/zYZWiE1O5UM=;
        b=T/mJ8J8Frannm3s3QiRhLyEnK2rbjSEIJ0pJk3FHXPjj/0ZV4Ms6GTyXgpi0CIc7ee
         LeYVWAcgMh1PRkrAcyCUo3a9qhlB1jAt1NubPf0FyTzlK0LdH3YC9dv9dXx3HvP6L5Bk
         LrufGX1MXiLNXB6DjfP4jpKODSN678CSgzoJ9Ys+AQVp7/BrN3fR9L0fHPL6EQ/XODrk
         gJpt+GvjGgO3MxRJqkvDAZNz7y0dazG41SGvnsje57wpIu2Z/W9yNpmOECp5y4dN4IqE
         EC1CnMyz5rLHa1UEjuifHDMzQ91RoW805HdLUPqTKM+Q5Q+whEsGjNIMT8xeb2JPQDwA
         Ic5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389566; x=1707994366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ULymJuwmD+Lr46QJ71fk24DGc1du2NJ/zYZWiE1O5UM=;
        b=nAz6qLL7Q56QpGDadQeROI3plip3xawIvKkTQPqd5mgfrFCOwMaPx55An0er7j5fCI
         RzsqGIOUwRIK47+J3dXNn6404+m8Gwsp5ISmn1PTafxqSSkCFTzw5y8jKMp+9I6xDsTc
         4mQteD7s3QCPYsLEKJaFlS3Q7gtnykO7ieHzoJQJXA009yBKAk7NtZ9pNfQt9VDf2d5k
         p7CslLUygyHNVdZpol8Mbxe/RhREIy4wT1LSkW7B9++51IzFwl8Jy0Q4AgEtzm6eIuTV
         +RsbdDOsQu+T9OWZ/Wu4RDFQ1OJPBP/ttcTmWBFKrz6+pHTXJojQQfFteuqlY9CBvTRT
         yvrw==
X-Forwarded-Encrypted: i=1; AJvYcCUQBnAPdJcrUyvUsIAqjZVQzXk0ia5kX7QhL9OszxAhMUlm7+9HwYrJavbaJ3Uh+InEPfE+qhIyVuoK+OO+0cBrSIowh2k6ugWI5UOX
X-Gm-Message-State: AOJu0YxeAXYoysCvkpeOca9qGf+9cRoYsRpv0WcRH8oq74rFNeu1AmGa
	eREe1jLbxjsthZuab+HTYwTEwhKvSU4PN2QcdXOmIwK+0GbVQIfQ/db7Gu1jjRM=
X-Google-Smtp-Source: AGHT+IHSQ/eekp3xo5+hhK7tiyrNeOIKtbM+FLiPFEeiXtdBsZ1zWPFLxSafr6BJGZfZPPirQp7H1A==
X-Received: by 2002:a5d:47a2:0:b0:33b:4965:cccc with SMTP id 2-20020a5d47a2000000b0033b4965ccccmr7610614wrb.46.1707389566390;
        Thu, 08 Feb 2024 02:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJIbt/XSD2As4nymbMxlVRelZyipTS1wVsTFu8DBkc/dckLnWGCGYNUCbsJJNOS1v8In6Oze72UR2p65kmuAUVT7sqNUB4LtXA+iugolWQS0izth50/oxD6kA2ZqbF7B9PwZyJntm2tgoO/C6RODAcerOfLhYlXfsFsDgGLXmu9tA8PzsPqETodCQtxgOD9Qon//74uDbSxdDGA3MigiNOg5dsttNkb054VJzoNZDqSZ2kLnXIqQkkuWUQVpOv8cwX4ITRbDCVC5kwzTnXfi1hgyPZ+XD6tkLei/4W/3NmmTY4rcKRgKD0RaPvB6pz4rY=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id q13-20020adff50d000000b0033b4d603e13sm3319416wro.51.2024.02.08.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:52:46 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: exynos: gs101: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:52:43 +0100
Message-Id: <20240208105243.128875-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{' and
around '=' characters.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../boot/dts/exynos/google/gs101-pinctrl.dtsi    |  2 +-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi     | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
index e6a9776d4d62..a675f822acec 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
@@ -251,7 +251,7 @@ gph1: gph1-gpio-bank {
 		#interrupt-cells = <2>;
 	};
 
-	pcie0_clkreq: pcie0-clkreq-pins{
+	pcie0_clkreq: pcie0-clkreq-pins {
 		samsung,pins = "gph0-1";
 		samsung,pin-function = <GS101_PIN_FUNC_2>;
 		samsung,pin-pud = <GS101_PIN_PULL_UP>;
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index c7a9e81d23b9..80cc933cca3d 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -73,7 +73,7 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0000>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -83,7 +83,7 @@ cpu1: cpu@100 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0100>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -93,7 +93,7 @@ cpu2: cpu@200 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0200>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -103,7 +103,7 @@ cpu3: cpu@300 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0300>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ANANKE_CPU_SLEEP>;
+			cpu-idle-states = <&ANANKE_CPU_SLEEP>;
 			capacity-dmips-mhz = <250>;
 			dynamic-power-coefficient = <70>;
 		};
@@ -113,7 +113,7 @@ cpu4: cpu@400 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0400>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ENYO_CPU_SLEEP>;
+			cpu-idle-states = <&ENYO_CPU_SLEEP>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
 		};
@@ -123,7 +123,7 @@ cpu5: cpu@500 {
 			compatible = "arm,cortex-a76";
 			reg = <0x0500>;
 			enable-method = "psci";
-			cpu-idle-states =  <&ENYO_CPU_SLEEP>;
+			cpu-idle-states = <&ENYO_CPU_SLEEP>;
 			capacity-dmips-mhz = <620>;
 			dynamic-power-coefficient = <284>;
 		};
@@ -133,7 +133,7 @@ cpu6: cpu@600 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0600>;
 			enable-method = "psci";
-			cpu-idle-states =  <&HERA_CPU_SLEEP>;
+			cpu-idle-states = <&HERA_CPU_SLEEP>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
 		};
@@ -143,7 +143,7 @@ cpu7: cpu@700 {
 			compatible = "arm,cortex-x1";
 			reg = <0x0700>;
 			enable-method = "psci";
-			cpu-idle-states =  <&HERA_CPU_SLEEP>;
+			cpu-idle-states = <&HERA_CPU_SLEEP>;
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <650>;
 		};
-- 
2.34.1


