Return-Path: <linux-kernel+bounces-44674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643B68425CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64E128E71B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DE6A02A;
	Tue, 30 Jan 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WG1xgikS"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CB6A336
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706620181; cv=none; b=ITyT0c1B18tALl+IblYZbbDoNDvnhvlin8lD2/hwf6T5VY3gVMFvPEoxC5vsaxlj4rTsFP8LO70sebCXHjpsThMXbQBhz8fFiIYYEv151zxRsYeO3li0baZ5r30MyReDJNjpC5Gx3bZ7J0EwUSvRw4SV/yBWNcPPsf4VYEvRwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706620181; c=relaxed/simple;
	bh=KpYROYaatW6Isjk4f1pkRgmRRTIpZDV5sZJ3lMB0peU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKy4s0pdgBfuINE8jgGTuziV/GjjqhXt6UofVxY39FT4UR5guXpWNvlEHpGUInlx16wbsGdHmz8Ni8v07Ee0xQt2iYymXV5XGmzRG4XJvEiPryikjwnBVqZ8M3o7ay2V7F04z4Qo8uKEnIDhPrhpnEgv/Bo7+rJQUlWnOmEe9+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WG1xgikS; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33af3c7ef60so1189766f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706620177; x=1707224977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=641O5KHQTlcXUaI6gCkzZnK2EJKM4f5gO7ipwqsrsGE=;
        b=WG1xgikSRJ6So33DlHC8zG8y8qW+ELF/0kADuNnmF/UGZoD2SKRGlhpRDfNfqEHP4a
         4cPlqO+YsoTSOMJhWtaNO5TzLIi0Rv05dVrg/cjVKy1XIrV8hp6mFuPnNUQukTbb8BBE
         5fNK2+m1FY3qBrMMBxFiZEHgrh8BiNzj1GYBPMN758/HeDBy2H44lHdWpuoo1tV+Vice
         yvqUKCJHA7qT5UVFsnmkF1PNewf7StKduohcDWRWxA1QjHwB55/jMtPbctOG+QW7Jjev
         DUgT1kWbkV3ANj9mptLE5b/D0oBuSLtXn2Q1t8j0UEho046RHOfgjxGMiks3x8afxUS7
         4swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706620177; x=1707224977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=641O5KHQTlcXUaI6gCkzZnK2EJKM4f5gO7ipwqsrsGE=;
        b=SYZJ6mSQpkvs4W7G/HrPoNU6TXEXjQODkadHuG49VBTzy55TWlFfkL2DuYUxr1GuLA
         4cZUJE65yxJsVLhu5C8EDEb0Wk+ONpJCKjq6vgkrfwFP8IflQsliPsg/07CmYBgyf5Iu
         sbBQqmYltl7QrLK5REObQwXUPvRmLv+UI0RGXtfgPAgvGtcmOnigX5GFz0ajmxcJniTJ
         lcN1dQbx7zteBC6xmr1uSlYctFhJw03XW/uyTMIvadAp5nhWNoRCgGR+veHV5q7La5fr
         pHkj+9K0Lc+UJL97h687hB/HSK3S8TXP01sU/16A05uBwqza5Gns4jfh2d+n1NJIiQP/
         t5sQ==
X-Gm-Message-State: AOJu0YzgRTxI24tRK8H/XDWpmN07P3ZdhydhdaxxKZWXpcOcwfihl2p7
	wLg++kleOynKThBj4OXZaB9m3BiA734B/fwYWAKsd+zG7dO5VpdRIlXjZB2H6vc=
X-Google-Smtp-Source: AGHT+IGcG2t82vrFpWtgC/L8q9UtFGa7VQAYdqFlz0SlSMi/iZG1+N4FNocpDVlteql1+tuxUvcfOw==
X-Received: by 2002:a5d:4312:0:b0:336:8f9f:c690 with SMTP id h18-20020a5d4312000000b003368f9fc690mr6174963wrq.16.1706620177557;
        Tue, 30 Jan 2024 05:09:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:abc8:f77e:abeb:129c])
        by smtp.gmail.com with ESMTPSA id bk24-20020a0560001d9800b0033add8aa1d2sm10314782wrb.44.2024.01.30.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 05:09:37 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH] Revert "arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node"
Date: Tue, 30 Jan 2024 14:09:30 +0100
Message-Id: <20240130130930.18683-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This reverts commit 71a73864e144aadaa582fe8296ef73fcf3ea7377.

The bluetooth module of the QCA6391 should be represented as consuming
the power outputs of the PMU and not the regulators that are PMU's
inputs. We will be able to model it this way (together with the WLAN
module) once the pwrseq subsystem gets upstream with a dedicated driver
for the PMU.

Thankfully this change has no corresponding DT bindings yet so we can
safely revert adding the bluetooth node.

Fixes: 71a73864e144 ("arm64: dts: qcom: qrb5165-rb5: add the Bluetooth node")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 29 ------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..4501c00d124b 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -23,7 +23,6 @@ / {
 
 	aliases {
 		serial0 = &uart12;
-		serial1 = &uart6;
 		sdhc2 = &sdhc_2;
 	};
 
@@ -1264,14 +1263,6 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
-	bt_en_state: bt-default-state {
-		pins = "gpio21";
-		function = "gpio";
-		drive-strength = <16>;
-		output-low;
-		bias-pull-up;
-	};
-
 	lt9611_irq_pin: lt9611-irq-state {
 		pins = "gpio63";
 		function = "gpio";
@@ -1305,26 +1296,6 @@ sdc2_card_det_n: sd-card-det-n-state {
 	};
 };
 
-&uart6 {
-	status = "okay";
-
-	bluetooth {
-		compatible = "qcom,qca6390-bt";
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_en_state>;
-
-		enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
-
-		vddio-supply = <&vreg_s4a_1p8>;
-		vddpmu-supply = <&vreg_s2f_0p95>;
-		vddaon-supply = <&vreg_s6a_0p95>;
-		vddrfa0p9-supply = <&vreg_s2f_0p95>;
-		vddrfa1p3-supply = <&vreg_s8c_1p3>;
-		vddrfa1p9-supply = <&vreg_s5a_1p9>;
-	};
-};
-
 &uart12 {
 	status = "okay";
 };
-- 
2.40.1


