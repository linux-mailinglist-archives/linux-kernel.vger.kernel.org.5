Return-Path: <linux-kernel+bounces-137976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B33D89EAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41B881C210E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC67288AE;
	Wed, 10 Apr 2024 06:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RpyfwBom"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6080F20DDB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730028; cv=none; b=W9UdYZz8sRkRuKcx7sEDgJOSskF5pdgrzB+d0/lgczEcFeAPwhjPnUWWUE0hr/RtKQAWNQDDH5jdUJAZZXq9soeECI9MOy5CSxOriB4wXFWfp5gj6181WvwUFJJsphGz2NntKwjkL2rkK1roawoFYTvyNE2t9AnYnnNKHcLVIF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730028; c=relaxed/simple;
	bh=uwt784Shk9K3LkOdlCkuId4R+pmLZMhJOJTkzgnUs+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QN4giq2036oEZTM5ZhaTMeyw3YZwSOIq4APiJjp4JD3aedpDYTTT5ArzN0XUJHcFvBfnvkABOfYJqx9IJduu7Whxaa0wrfP2WxsIoOPkvumNEkezg6eQtv+MRz7jUr4m2/Tveu1wnVwcSwUSZz6VLWGHc9J5XBkoPrkPfI2btV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RpyfwBom; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed054f282aso3851432b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712730026; x=1713334826; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5v4LfNlblo2WKgRAn2D3NW7xqD55htd+EO/6vEx8Ak=;
        b=RpyfwBomodqtD+enc0lrnylD7sKxrpv6BBk608AdaH4aN2/3JKS+THUZK3megyV6EW
         jZdswysfCSTf+wo0a+ZeIuJoQcZtxf5dC/5X/EQM3zQQogEK/4KD66yNwlGZ80dvqiP9
         UqfhR/FokvPBKv8XoYCZaYwiyp0aiPDJ2tlD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730026; x=1713334826;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5v4LfNlblo2WKgRAn2D3NW7xqD55htd+EO/6vEx8Ak=;
        b=N9+HFMlhKbm1AyxYCTKDKN2E/g5uAue50jdhEzWC93B6Yy/+TYFGoyO5DOr1wKElDB
         HTl9sONd+8zxlKIekc0c199/Iim7bVtEimHIWCwsx8W3FSKf2V9yLHhBH/4eE65Mc6pW
         7mj2HI2biMjg60ZeLHOXM/rif9ZSs9jNxqgGHIE3Q5udeowEeqcjhC/hilcv16KAzWa7
         8kWUeMf7Aqd4FyF/2D5j//HdiiUXHDtYhU/G/9D/1uBiQ4oIWO7I5z+Tio6QwszCW5Yo
         3LOFAXexMT+jnqacDGzZRNeB/PQGQnJU0Yz/0lN5uILvczjYUtF3TcY/LsRd0LgbfjWJ
         f9yg==
X-Forwarded-Encrypted: i=1; AJvYcCVn1wqfRyau9QZ+sw0Q2xZqr8pN4mlGNQCQS0CoLyuFFK7JMWm6MRCnTnaqkL+Cq3/n55Juac+XH0kWhwaZ/372U9phMAwvS9pLX38j
X-Gm-Message-State: AOJu0Yz23szSIXdkhVvRR+5jaA1X2tpdNkyGe9dnLpVBfMdLaXbCL+2O
	KM407tEBLy08ClaD2WQmCqUOXY8DYzitGxcpMAg+h0LZ/xPw58z3/hDkyHzsC82hYMv/HK9t3qE
	8EQ==
X-Google-Smtp-Source: AGHT+IHAta98FxLNG/x0sc1YsRsry9ENklaCOvy0ZnfjzpSfwTLrCO0ZpnFeZ9TC6+QWoa+lKUCVCQ==
X-Received: by 2002:a05:6a00:21c9:b0:6ec:ee7c:141c with SMTP id t9-20020a056a0021c900b006ecee7c141cmr2087534pfj.16.1712730025858;
        Tue, 09 Apr 2024 23:20:25 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id lb14-20020a056a004f0e00b006ead47a65d1sm9411384pfb.109.2024.04.09.23.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 23:20:25 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 06:20:20 +0000
Subject: [PATCH] arm64: dts: mediatek: mt8192: Add missing trip point in
 thermal zone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org>
X-B4-Tracking: v=1; b=H4sIAKMvFmYC/x3MTQqEMAxA4atI1gZa6Sh4FXERajoT8I+kiiDe3
 TLLb/HeDcYqbNBXNyifYrKtBb6uIP5o/TLKVAyNa4IL3uGxW1amBfOmJ82T4UKWWTE44pQ+wbe
 xg5Lvykmu/3oYn+cFMVnATGoAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>, 
 Balsam CHIHI <bchihi@baylibre.com>, 
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.12.4

Add the missing passive trip point which is expected by kernel.

Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 05e401670bced..08d8bccc84669 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -1959,6 +1959,11 @@ cpu0-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU0>;
 
 			trips {
+				cpu0_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu0_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -1989,6 +1994,11 @@ cpu1-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU1>;
 
 			trips {
+				cpu1_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu1_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2019,6 +2029,11 @@ cpu2-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU2>;
 
 			trips {
+				cpu2_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu2_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2049,6 +2064,11 @@ cpu3-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_LITTLE_CPU3>;
 
 			trips {
+				cpu3_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu3_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2079,6 +2099,11 @@ cpu4-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU0>;
 
 			trips {
+				cpu4_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu4_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2109,6 +2134,11 @@ cpu5-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU1>;
 
 			trips {
+				cpu5_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu5_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2139,6 +2169,11 @@ cpu6-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU2>;
 
 			trips {
+				cpu6_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu6_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;
@@ -2169,6 +2204,11 @@ cpu7-thermal {
 			thermal-sensors = <&lvts_mcu MT8192_MCU_BIG_CPU3>;
 
 			trips {
+				cpu7_thres: trip-point {
+					temperature = <68000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
 				cpu7_alert: trip-alert {
 					temperature = <85000>;
 					hysteresis = <2000>;

---
base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
change-id: 20240410-upstream-torvalds-master-40aeff5416c7

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


