Return-Path: <linux-kernel+bounces-87349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5016586D324
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E932865BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0313D2ED;
	Thu, 29 Feb 2024 19:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWcbzvjC"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7331428EC;
	Thu, 29 Feb 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234833; cv=none; b=oU7Kbz6c3dA2I+GkAWkKE2jXkJmxH5cgi0baNMu2TA4bsoAWJoE+ItfVVp3vcTI7Iy1Bzx1S0sr7BJCOvBakgmIsBIyhdrP9q/RxbQZvqWCh6vdObNoQ1xtNL+CF64C+zB1UPNRB6q57zvJj+d70qHhgY5aD7nKI+YMKY3yvnAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234833; c=relaxed/simple;
	bh=8H/tOXt2VM0cB2gFZgy5l9YIXKh951auxB3otM6qfCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YtibnPhLEXTKw0x4YKnmdczJNiM6ryqdl8Sgpi2CwfknP75Sd68BK66fXYJZ9DS6DgOvrE+i9cNknSSq9nFHct3xI9V311KRN1YWkfzDBxOiKfgSb9+K0UnD+sBg6250u+6wMNQqAX250HqweNfWeBZFIkf+BsoKmEChFXWa1B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWcbzvjC; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5131c21314fso1665329e87.2;
        Thu, 29 Feb 2024 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709234829; x=1709839629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRkrxLzAapN1oFv+RsuOX+L6Z3XPlb+lZYTxmPs/FuM=;
        b=QWcbzvjC5xyudTwqXtCsn/wbgDPDr6C4/BTeUvJeCYN54UlqZokB6eMFYYkxcsNo94
         /DZ0IE9AhcXkMxGt1rJ+xQB7BFZCce/1UWLe2VCn3oCqW2feGguEuqiA2UOEiVBWACUB
         IvrKZTbTOFLUtOSnfy2+qKp9DKI24QIoMMIo2nWQpGRZn0cDdF88Qvw0tCJrem3rgeoH
         BD9rWXamO16biiQIctWFZqWJNi48+o5PGW0Va+0H07/dV2/voj6ukAjepKEAOJAycbub
         0Dx3SCxblUXCTOrlfA1J1nsUCfBbLPdDYsFm6G4GQTT9fyaOlfJA0ZgNANv+DWIUUdhS
         owoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709234829; x=1709839629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRkrxLzAapN1oFv+RsuOX+L6Z3XPlb+lZYTxmPs/FuM=;
        b=pWrnFhatReY5eUcvsJSF3xlM238zZI+VpK7kVfpTpWYKS8Hw92agKkLKy4LfQLwFY5
         LhgLy9WD9vVQLkN8VYwujudAvcq49OoVQ5PmKu+RxfqdvVEI90e+Pj5wyUAu4hFqEJmy
         vD7OnvGq4Nj5c7SykVvIfguKfDKED/VEIbp6AkLXQp8cCayt3EGxfItggAoA+VhVQ3zs
         mYVro4Q+lWA+MZnX7n0mT8M9yItadBImngXSfsYa4lENd4rmVZQFzlhNoul8MeIK0QD5
         QcPhwVv5myhFhL7MaSCMqT55D0dwcgcFiub76CbTyVi2Ru7RezBmGWfYAibKcP/kWTkF
         BDTg==
X-Forwarded-Encrypted: i=1; AJvYcCVinqnfkhPGypv6JUNZgq+xg3z1rU1QTS+3B41yP+kIp6N+2Q0byLZcGhjHyo7EWDVsXXoNS92PWti0Rt4SQVm4CFIyN+v6GygYdp2cNFoHfJqjUu8sv0p41PtJp2MmT03XY6cyAGeFmg==
X-Gm-Message-State: AOJu0YzAyFImWhPcdv0pxnA57zCifAa6VZvXaj1IH6YfYsMERWUPaEKq
	6mIaZZ9WkUZ1AeENZ+XG1ovYwIshwoAS6F1sM/feANx4b1ZV70XHQ50QrC43Ej44EQ==
X-Google-Smtp-Source: AGHT+IErVqjV3a+j6Yl9ulo0aeAHio/JIuZkEQoqds6hmzl54SAZ9JSyigSZr1dPGg7WfLjV5P15QA==
X-Received: by 2002:a05:6512:acc:b0:512:c9bc:f491 with SMTP id n12-20020a0565120acc00b00512c9bcf491mr3108393lfu.47.1709234829291;
        Thu, 29 Feb 2024 11:27:09 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:6ebc::d35])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c1c1400b00412bca49a5bsm2853944wms.42.2024.02.29.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:27:09 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 29 Feb 2024 23:26:34 +0400
Subject: [PATCH v3 3/5] arm64: dts: rockchip: Add CPU/memory regulator
 coupling for RK3588
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-rk-dts-additions-v3-3-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709234816; l=5927;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=8H/tOXt2VM0cB2gFZgy5l9YIXKh951auxB3otM6qfCo=;
 b=bqp+KXlto4YfmOpGe6God+ep8UDgtPadNyatqUfzq6lMupZbDME0CufrEW9xNpyE31Wam2SX7
 J1KuN2GU9A2Cvl8qe+f5Wdzdby1BkpK2mKN3vmagirbWjZnfoPsS5RM
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

RK3588 chips allow for their CPU cores to be powered by a different
supply vs. their corresponding memory interfaces, and two of the
boards currently upstream do that (EVB1 and QuartzPro64).

The voltage of the memory interface though has to match that of the
CPU cores that use it, which downstream kernels achieve by the means
of a custom cpufreq driver which adjusts both at the same time.

It seems that regulator coupling is a more appropriate generic
interface for it, so this patch introduces coupling to affected
device trees to ensure that memory interface voltage is also updated
whenever cpufreq switches between CPU OPPs.

Note that other boards, such as Radxa Rock 5B, define both the CPU
and memory interface regulators as aliases to the same DT node, so
this doesn't apply there.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts    | 12 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index de30c2632b8e..dfae67f1e9c7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -788,6 +788,8 @@ regulators {
 			vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -800,6 +802,8 @@ regulator-state-mem {
 			vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -812,6 +816,8 @@ regulator-state-mem {
 			vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -836,6 +842,8 @@ regulator-state-mem {
 			vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -849,6 +857,8 @@ regulator-state-mem {
 			vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -873,6 +883,8 @@ regulator-state-mem {
 			vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
index 87a0abf95f7d..9c038450cd7c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-quartzpro64.dts
@@ -818,6 +818,8 @@ vdd_cpu_big1_s0: dcdc-reg1 {
 				regulator-name = "vdd_cpu_big1_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -831,6 +833,8 @@ vdd_cpu_big0_s0: dcdc-reg2 {
 				regulator-name = "vdd_cpu_big0_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -844,6 +848,8 @@ vdd_cpu_lit_s0: dcdc-reg3 {
 				regulator-name = "vdd_cpu_lit_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_mem_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;
@@ -870,6 +876,8 @@ vdd_cpu_big1_mem_s0: dcdc-reg5 {
 				regulator-name = "vdd_cpu_big1_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big1_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -884,6 +892,8 @@ vdd_cpu_big0_mem_s0: dcdc-reg6 {
 				regulator-name = "vdd_cpu_big0_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_big0_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <1050000>;
 				regulator-ramp-delay = <12500>;
@@ -910,6 +920,8 @@ vdd_cpu_lit_mem_s0: dcdc-reg8 {
 				regulator-name = "vdd_cpu_lit_mem_s0";
 				regulator-always-on;
 				regulator-boot-on;
+				regulator-coupled-with = <&vdd_cpu_lit_s0>;
+				regulator-coupled-max-spread = <10000>;
 				regulator-min-microvolt = <675000>;
 				regulator-max-microvolt = <950000>;
 				regulator-ramp-delay = <12500>;

-- 
2.44.0


