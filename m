Return-Path: <linux-kernel+bounces-138179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B592289EDCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385DC1F21E99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FFB154C01;
	Wed, 10 Apr 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WHSfrO/W"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F32D339AB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712738453; cv=none; b=hLNmsm1YPeTvJ/rey5JnL5OTuTRxFrz1Oeywi/aDsFtoDYLIccvVr2cDC0GR4DTnLFtA8ebzm4YJDGq6/MZSLQyclrAvgl7CUA3zBKX+IddDThcRGLfkyQGoCcM2dhgOwlwdc33VLTP/fw1wEMboJE/O8vFT25f5m79xK5ajVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712738453; c=relaxed/simple;
	bh=tPkV/dgJUzieymppUjyKRIwaMmxFkge2PvtDcrZP96c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E0nWLm88QmjB4liV8ocfMIq5BVhKRS/vShSlVFYKip755Un0HdXEhD77YRzx+NINbSXVEZxyxMyeEsR4Xvt/Uku0H4MRLJtVwgMZRdFNEDT6NYeuB5iDI5ClW5Ro8DqLznR8IdS4MT4qMrs/s6yndm/w//trky+y8LgaXpCvgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WHSfrO/W; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5aa12c21ff4so2577615eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712738450; x=1713343250; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAyow8X3gkrKIXrdZZsBjPykepVjWpYDrdgw89x4pGE=;
        b=WHSfrO/WmVJJpSxVIeFYxhZhDTkoW9ZEIDwXDD1EMR5DCkIsE51SmS+nKOzzqOZrM2
         m0/hVeE3mNrx+wV2CShm/ZA3/3pbkXKIHTD2jpgu2HqYm9bgrBcHnaVAfMEM0FBpU9IE
         SSEBFRMzfA9K5A6Ok6mZY3Ju7NDCEG9WX1npo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712738450; x=1713343250;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAyow8X3gkrKIXrdZZsBjPykepVjWpYDrdgw89x4pGE=;
        b=q9uCgcV7Nc1o09p8bkrXuu8WNQmzNt9HahTVOHp1HM9n4KfugPFi2vRJf4HKfiC1MR
         9C3p3D1xlT4K4txpwWNMlj6At5yRsupkc4pzDibpunc4R8kn/OIWTh8wKLAuwm16s1Vx
         Bsnhlw8i31KS51U5TurL5kcxvwXsc4pxUusNoch51lRkwNcu3SfBS7FZoQdX8WdMAW1W
         VhTuJWIQjat2L+LK9mma7U/FrjgP7m/KCfiUoi/xNusS0ftOg7TFCNhBU+E5ykv2ZZXe
         YdgTIC0dfNSAJMPFuCooAchJuI6XHtcHWq9uGgNpxURZXrfPM3Oeen2R15CkSofaZ2gy
         zAjA==
X-Forwarded-Encrypted: i=1; AJvYcCUOeHP2iRhjyoV2GQ+XxqPc9QVdAR/+NhTViF0UYeFpWGtBTEfr5VC7LhFhwNT/V3m41FqbNpyS3CX8Cv9bMJ62IbqoF3tmpFH1Dk3u
X-Gm-Message-State: AOJu0Yxvi5lCEh0mzgqybWmLLenP+PejcQd7bRln0Fv+UtoNKk5jTWcc
	+lkOONmD7pvr5ixEcOcocR/pAbNamIpvQ7ZbdFbCVsBX/z6Bs6p+INCBlceXaQ==
X-Google-Smtp-Source: AGHT+IGQIGRSVbir8tD+7BU7dQc6yvCondb+sBONRHguGITH+9jJFPC17Z5wLbgHntSupY3dHcRiGg==
X-Received: by 2002:a05:6870:700c:b0:22e:d2b2:25fe with SMTP id u12-20020a056870700c00b0022ed2b225femr2049905oae.1.1712738450103;
        Wed, 10 Apr 2024 01:40:50 -0700 (PDT)
Received: from yuanhsinte1.c.googlers.com (88.216.124.34.bc.googleusercontent.com. [34.124.216.88])
        by smtp.gmail.com with ESMTPSA id i6-20020a056a00004600b006e04ca18c2bsm9606330pfk.196.2024.04.10.01.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 01:40:49 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Date: Wed, 10 Apr 2024 08:40:45 +0000
Subject: [PATCH v2] arm64: dts: mediatek: mt8192: Add missing trip point in
 thermal zone
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-upstream-torvalds-master-v2-1-679777847b63@chromium.org>
X-B4-Tracking: v=1; b=H4sIAI1QFmYC/42NTQ6DIBBGr2JYdxqg2L9V79G4IDgoSREzg6SN8
 e6lnqDL9yXvfatgpIAs7s0qCEvgkKYK+tAIN9ppQAh9ZaGlNtIoCcvMmdBGyImKffUM0XJGAiM
 tet8adXYXUfWZ0If3nn52lcfAVfnsT0X91j+iRYGCa6vxJk9eOnQPN1KKYYnHRIPotm37Aoofg
 AjDAAAA
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

According to Documentation/driver-api/thermal/power_allocator.rst, there
should be two passive trip points. Adding the missing trip point to
ensure that the governor works optimally.

Fixes: c7a728051f4e ("arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones")
Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Changes in v2:
- Clearify the reason of adding another passive trip point
- Link to v1: https://lore.kernel.org/r/20240410-upstream-torvalds-master-v1-1-852e903f0cec@chromium.org
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


