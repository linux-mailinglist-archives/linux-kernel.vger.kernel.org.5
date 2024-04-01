Return-Path: <linux-kernel+bounces-126730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D927E893C09
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943B9282C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8478F51021;
	Mon,  1 Apr 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVo8AoxF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2840C15;
	Mon,  1 Apr 2024 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980697; cv=none; b=NoWhIGeite8+92aW8btIgWJNPF7P0PyZRFa1CSkba3Js/3Jir8KyiwTxiaFpFfzh6E2XX0yxXXnI4IxjTQz642znY9FlXdMaazx5aTYASa+jUX6eUcYnWYvm61tO3QbhyaSO2IUroGpC9Yxbz2h/4ZEhAeXl7K/2mYy+7QKaZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980697; c=relaxed/simple;
	bh=fqSqBpoDAv3eYKEPiQPWmiwUtULG6f520A3nTjYX+i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mffngc4LZb2UxZM7vT5e+3D3sfuTHUv1MAtNtDB25OhknTwsYNjywor4qzoEdvaB+hC9thkO21EF/900x6rUbbUlnD2naMa4Ly34+RxdBggxNpnXaD75tESlDzNdXCs3bBPq6kiXLJbqzTaAxilD1xNWniozzrSWNSpNQf6iL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVo8AoxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AEDC433F1;
	Mon,  1 Apr 2024 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711980697;
	bh=fqSqBpoDAv3eYKEPiQPWmiwUtULG6f520A3nTjYX+i8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVo8AoxFOjZyUTUXCiAYKDY/SdjlOMudfPq1TUcFlfKUEop5W7aPs0DIx2Pij0tUp
	 dZVnPqN0QmHKxYO/+adH59QhgbXHn5Chs3R/RcrJ766C48xy9UUvrZnA7JDTa1W+k/
	 OQVUG6TNUrog1N2juvJGio23MNtrFTTsmcPjsoYbUsJ1f9eBKFgklmC5Q4cz/8IAT1
	 APcEbUe+7qcuELXogtCb1r4vXiw5AQQSMpX8NGluRc8VMA5E+e26P+KFV+aa69rTPM
	 11lN6dVcn4a/NeEboH8CGQADykNSnlwelos45iW2ZDVxoJYjPfdw+khn9vzOPVAOQN
	 wNiZ6wep29yZg==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/5] arm64: dts: sc9860: move GPIO keys to board
Date: Mon,  1 Apr 2024 16:11:25 +0200
Message-Id: <20240401141128.98317-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401141128.98317-1-krzk@kernel.org>
References: <20240401141128.98317-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GPIO keys are properties of a board, not SoC, because SoC physically
does not have any keys or buttons.

This also fixes dtc W=1 build warning:

  sc9860.dtsi:688.13-714.5: Warning (simple_bus_reg): /soc/gpio-keys: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/sprd/sc9860.dtsi      | 28 -----------------------
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 28 +++++++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/boot/dts/sprd/sc9860.dtsi b/arch/arm64/boot/dts/sprd/sc9860.dtsi
index b933979c9eee..e875dc8e3d98 100644
--- a/arch/arm64/boot/dts/sprd/sc9860.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc9860.dtsi
@@ -684,33 +684,5 @@ etm7_out: endpoint {
 				};
 			};
 		};
-
-		gpio-keys {
-			compatible = "gpio-keys";
-
-			key-volumedown {
-				label = "Volume Down Key";
-				linux,code = <KEY_VOLUMEDOWN>;
-				gpios = <&eic_debounce 2 GPIO_ACTIVE_LOW>;
-				debounce-interval = <2>;
-				wakeup-source;
-			};
-
-			key-volumeup {
-				label = "Volume Up Key";
-				linux,code = <KEY_VOLUMEUP>;
-				gpios = <&pmic_eic 10 GPIO_ACTIVE_HIGH>;
-				debounce-interval = <2>;
-				wakeup-source;
-			};
-
-			key-power {
-				label = "Power Key";
-				linux,code = <KEY_POWER>;
-				gpios = <&pmic_eic 1 GPIO_ACTIVE_HIGH>;
-				debounce-interval = <2>;
-				wakeup-source;
-			};
-		};
 	};
 };
diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
index 6b95fd94cee3..9b4128d9c5bb 100644
--- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
+++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
@@ -34,6 +34,34 @@ chosen {
 		stdout-path = "serial1:115200n8";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-volumedown {
+			label = "Volume Down Key";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&eic_debounce 2 GPIO_ACTIVE_LOW>;
+			debounce-interval = <2>;
+			wakeup-source;
+		};
+
+		key-volumeup {
+			label = "Volume Up Key";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pmic_eic 10 GPIO_ACTIVE_HIGH>;
+			debounce-interval = <2>;
+			wakeup-source;
+		};
+
+		key-power {
+			label = "Power Key";
+			linux,code = <KEY_POWER>;
+			gpios = <&pmic_eic 1 GPIO_ACTIVE_HIGH>;
+			debounce-interval = <2>;
+			wakeup-source;
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.34.1


