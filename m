Return-Path: <linux-kernel+bounces-69309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AB3858707
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CEA1C248E8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1749214E2D2;
	Fri, 16 Feb 2024 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="fJO3t5mH"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E5214A4EF
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115606; cv=none; b=ZL5HwRWsE7AJHgXGgYW5/mpGPWlXNS482jbbzZ9JOVH4EDkXCAsK8A8BXlXn779EUUp9bKvkXcnh70kVu05d6ZK5n6fwckn7uBLnmVEDyZLXpyN+BLTqM/NqEfZWjUaQHxshHooaX/TombexxQZsMiUcA8AhvyzQBU13WynpP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115606; c=relaxed/simple;
	bh=DA4ectayxTx+RjdRwpkpKa9bLFLkHFkmFO+48GVSSpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PuSquvuQrzhgjOa5fGZDGetrNFtPNayMv+N+1WNa+wIg7Kg7ebI1hUIkxYYhJEgdkIdWA2OKYrQKpxsKHqEsCzFzVdqZ2pKr02U+h2GgY0LLe7vTvayU70AuCTwQTdz3v9XgBeExkdIfLch7wRSa+GU6wYWlZX84Vo6ZzZCKnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=fJO3t5mH; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so31451811fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115602; x=1708720402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxxyf5WK5kLEb1ft4RDq8oKAwu3D1i1cTrok0abawwQ=;
        b=fJO3t5mHa7DdULYXt+lZvU/2eM2lEOmcbu9X2uy/UNm2wscLaBe2+8dl/E2JD83s9x
         b3QwdhvoZySAPaAdlwQ/du/1yx7sIPZ+XWUsrTDQhTJOlPKG4X70lddeacXpxCObFckn
         yiEXTNai8/6k/WNFQPbeyYkZUyZU0PUOIZswYBPAGIXWqOXB7JEdL5o6hYdTiP1OMd0y
         VUw333fYKirnwWYGN+XAAGHeTW+49TIzlP7ZMvpLePhBKy+ttyAP6e55zGc6ykDbGplf
         uTLRicLz5Tl6Spd9MUyyuuGT4MMq43vNJ3EjYC6OtTcI8JWcUPi21e6guJcKamYDTrMj
         NzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115602; x=1708720402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxxyf5WK5kLEb1ft4RDq8oKAwu3D1i1cTrok0abawwQ=;
        b=pBVlOVlrXrVxCnZsEGQ2zNkXMy0QZGfFAS4N7CXNAIWT47OWusy5ONax04nKiB0tnR
         RIrrYlVpikfWHgANuAPOQ24qJK8wAWhauvuYl3nUlgEYs1GvF+iKOHQ+/lgwO1ha30wA
         6nbHV+36aT1Y9cnG6QigXaJRiyfXVGnsqHp8vrIJxYcASme+ZAi7PmVzb1DtbLBUp09M
         isuFxo0YtCxEhkM63J5jA+Ge+nV06CTnEXGqMofibQny5LLuTIRjpeg1V9cJbs8KqVdW
         oVBpIPV/9lJijoLDyp1Z4nFKaGcF8S9oAt9+/S/EO61+fa9CSIgl09aEDWevwWykM6w9
         GQfA==
X-Forwarded-Encrypted: i=1; AJvYcCWFPZ0yjDjvg1Ne++Fh/BMwbjqHYObm6r9mqMSVylZ1CbkMSqvhBIJP5jZGL1lLxuhe3EQiKJmLcjqDCD1UI2qLDslLcBqA+dlcgaP/
X-Gm-Message-State: AOJu0YxC4xBPEXKvvy96mVSK6QGV/KDpxVJ/If6IgQFtdYrD/pMktEU4
	lPB/Q96JGzN+Ns+s+aC8rTrabZGNfi4LkJaBE9OW0qDwAYsBWFwFbvAz4LEYOpU=
X-Google-Smtp-Source: AGHT+IE/2ahKMsZvabc/gm6bCNhd1e6PO1jafL5NM+NOIbNtqIA1pLBKR3l3Gurnhpr74OlhOP7RBQ==
X-Received: by 2002:a05:651c:21b:b0:2d0:bf87:b3a6 with SMTP id y27-20020a05651c021b00b002d0bf87b3a6mr4518706ljn.37.1708115602002;
        Fri, 16 Feb 2024 12:33:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:21 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 07/18] arm64: dts: qcom: sm8550-qrd: add the Wifi node
Date: Fri, 16 Feb 2024 21:32:04 +0100
Message-Id: <20240216203215.40870-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Neil Armstrong <neil.armstrong@linaro.org>

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
[Bartosz:
  - move the pcieport0 node into the .dtsi
  - make regulator naming consistent with existing DT code
  - add commit message]
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 37 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8550.dtsi    | 10 +++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 92f015017418..67bd11e82abd 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -824,6 +824,25 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
+
+		enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+
+		vdd-supply = <&vreg_s5g_0p85>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s2g_0p85>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p8-supply = <&vreg_s6g_1p86>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
@@ -911,6 +930,17 @@ &pcie_1_phy_aux_clk {
 	clock-frequency = <1000>;
 };
 
+&pmk8550_gpios {
+	pmk8550_sleep_clk: sleep-clk-state {
+		pins = "gpio3";
+		function = "func1";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1084,6 +1114,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart7 {
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 9a545087d70e..5fcf8d5ac084 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1767,6 +1767,16 @@ pcie0: pcie@1c00000 {
 			phy-names = "pciephy";
 
 			status = "disabled";
+
+			pcieport0: pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+
+				bus-range = <0x01 0xff>;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
-- 
2.40.1


