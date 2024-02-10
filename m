Return-Path: <linux-kernel+bounces-60328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8142085033D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68BE1C20AD9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9180B3D576;
	Sat, 10 Feb 2024 07:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/vIqtnF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B73D0A6
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549020; cv=none; b=d0KSf/H3X4CIwCxlMQNgdBpFS8pzSKXCnuS+6n1v1/s1B+COngirqRtAwAkeRtoKhOPXos30HgyLOIx1D3k3FzuRs2wlKx867w5glu9A8/OG7zkBuBfkocb64Nb4dIfaLcXTjPAy0ZHYSKPpPxXmpcAA6yBXo0tXyoRCItO8Xik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549020; c=relaxed/simple;
	bh=H0NsPdNWM169T1yWm69PYm5MP513RfPgSq5A5nLj2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR3truONYQfCQDUnzJXEBWDX9dxPOCoTzoB6ZxfJqFSjvGQlX6o2z5OYuaB/fzqxkem7BnCw9VR8FuR2SJQ00ZdmnYJHqSNSSiNmPYsikTN9lVQvX2czVimO3BzHWd2xoqPiifqc2e/TFNP2LA+CgEEzdpSTu3Tb65zuXBRpUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z/vIqtnF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so13021395ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549017; x=1708153817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYVNJQLOFo6Ade1iKtFESw8BRBL8sVWXNL9IvcUDicE=;
        b=Z/vIqtnFFKqTNrSa1zj8OaV+IGv71C0KeOJ9/4JME3pQQbLQFgcc9TkEs0D4H+rWl/
         I9t3VucS2UvxGLFVPfKTByKUgpf+pOKcj+7tfuFWkhqPfbhodMF6LGZyuQ3xXUfdRLeI
         2jnyKzDFDTXtCjtAyBNsvCFo3mjd7vegAXigA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549017; x=1708153817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYVNJQLOFo6Ade1iKtFESw8BRBL8sVWXNL9IvcUDicE=;
        b=vPTgc1XZ40tXc6h0ReJZbkgzzgQjNkiKdcRchv4paCbEAaj1QdonJB3j7Us+x9wcTc
         jkT1kqkE5DbPwOoNsmcWpz2gh3NeKb1Lktxg2+DydMJTT//LfHtTg1fL/u10jEZqvxcf
         Cehjrn01e8zwQkf7Pf2cZBgCOvB7GIRCh7AR1dEB7KkgGiwdipCGnNerhd9IbwAvmuJG
         +jtXyKeE2315enuZyct6kJSAMNOOeyFZ++lxVaHJiWBNrQty/GK5KvWubFQydew0/KT1
         DmXEtY9ERM1EDc7dfbcljFX8XsoamVFEoAieBZWNbRAZen4FjZW5ujcaB+qKfDapevhT
         2gqQ==
X-Gm-Message-State: AOJu0YyKR/EuUlAaW2+y/YH4d8tZ2n0SL7faNXzmwUq6KAXLBF8Zycqk
	0QLMexlTD3bPUbxDnISX4G5izFatrwKBJEXLk7GG7LgTwAhxznpoGLrxL89Vqg==
X-Google-Smtp-Source: AGHT+IGLVICRvn56WUY63ePsz4VHQpDwKXW4WcDvin4MKKJ3B8XPhTBV0QpchGE67tTNFQMtAtjOJQ==
X-Received: by 2002:a17:902:d3cd:b0:1d9:65e6:4af7 with SMTP id w13-20020a170902d3cd00b001d965e64af7mr1676051plb.30.1707549017056;
        Fri, 09 Feb 2024 23:10:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0/qZXPH5mRYuI2OuvU8Doe9RbrDpkyAN3Ttf5hsYE5C6B46Lz8Eb7QAQrr2yB8pIGtt2/WETocK7zQAJ+v1kBoXrhlR6sON0WurqNUAYNLUiqNMouBOQicRBsg7DCvsIS5I/UKet+EUTxsT2gaa6OErpifZaiF/d3H21P19yN9LPfK2Q0m14BAcndXss/HCkbMNNFezqPpW7C6HGxc+ImFFNqCa/XrSg3S4LgVVgTeC1pUQSejbxafAKVGuRkG2vbpAju/Pw7ffxPQCOUWmqIAMMuT3lZLiwPriv8alsX1lMg7mjarcFwXViOespg/lNZlcTXpc0DNuYdVPQWdtNnBPaMb+x1hS5sebOvoyJyyeDB6dfFEZgLOzs3Cbq25o0SOknmOwFneso6UvCAWS9gu40bIZ/vzAAi6mHX5P5Mq2N8unvX/BMXrYdaEwd86Q9SM0wNCYGH8LcMghFoKbZ7lW71CUEliQMaM9/OA9etUqksIiJgJksa09Qe0Lqlg734QTHuQA5CfAAL1g==
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id jc9-20020a17090325c900b001d9f4c562b2sm2504374plb.23.2024.02.09.23.10.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:10:16 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	cros-qcom-dts-watchers@chromium.org,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH 22/22] arm64: dts: qcom: sc7180-trogdor: Wire up USB and DP to usb-c-connectors
Date: Fri,  9 Feb 2024 23:09:33 -0800
Message-ID: <20240210070934.2549994-23-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fully describe the USB type-c and DP topology on sc7180 Trogdor devices.
Most Trogdor devices have two USB type-c ports (i.e. usb-c-connector
nodes), but quackingstick only has one. Also, clamshell devices such as
Lazor have a USB webcam connected to the USB hub, while detachable
devices such as Wormdingler don't have a webcam, or a USB type-a
connector. Instead they have the pogo pins for the detachable keyboard.

Fully describing the topology like this will let us expose information
about what devices are connected to which physical USB connector (type-A
or type-C) and which port is connected to an external display for DP.

Cc: <cros-qcom-dts-watchers@chromium.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../dts/qcom/sc7180-trogdor-clamshell.dtsi    |  21 +++
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  47 +++++
 .../dts/qcom/sc7180-trogdor-detachable.dtsi   |  13 ++
 .../dts/qcom/sc7180-trogdor-homestar.dtsi     |  47 +++++
 .../dts/qcom/sc7180-trogdor-kingoftown.dts    |  55 ++++++
 .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  55 ++++++
 .../boot/dts/qcom/sc7180-trogdor-pazquel.dtsi |  55 ++++++
 .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  44 +++++
 .../qcom/sc7180-trogdor-quackingstick.dtsi    |  31 ++++
 .../dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  47 +++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 175 ++++++++++++++++++
 11 files changed, 590 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
index bcf3df463f80..96137202fc64 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-clamshell.dtsi
@@ -7,3 +7,24 @@
 
 /* This file must be included after sc7180-trogdor.dtsi */
 #include <arm/cros-ec-keyboard.dtsi>
+
+/ {
+	usb-a-connector {
+		compatible = "usb-a-connector";
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			usb_a0_hs: endpoint@0 {
+				reg = <0>;
+				/* Remote endpoint filled in by board */
+			};
+
+			usb_a0_ss: endpoint@1 {
+				reg = <1>;
+				/* Remote endpoint filled in by board */
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 6e6a4643c4dd..4cf5b1e20b27 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -135,6 +135,17 @@ skin-temp-thermistor@1 {
 	};
 };
 
+&pogo_pins {
+	keyboard@4 {
+		compatible = "usb18d1,504c";
+		reg = <4>;
+	};
+};
+
+&pogo_pins_in {
+	remote-endpoint = <&usb_hub_dfp4_hs>;
+};
+
 &pp1800_uf_cam {
 	status = "okay";
 };
@@ -176,6 +187,42 @@ &sound_multimedia0_codec {
 	sound-dai = <&adau7002>;
 };
 
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp1_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp1_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_hub_dfp1_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp1_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
+&usb_hub_dfp4_hs {
+	remote-endpoint = <&pogo_pins_in>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
index ab0f30288871..b24a0213a477 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-detachable.dtsi
@@ -5,6 +5,19 @@
  * Copyright 2024 Google LLC.
  */
 
+/ {
+	pogo_pins: pogo-pin-connector {
+		compatible = "google,pogo-pin-connector";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		/* Detachable keyboard populated for each board */
+		port {
+			pogo_pins_in: endpoint {
+			};
+		};
+	};
+};
+
 &cros_ec {
 	keyboard-controller {
 		compatible = "google,cros-ec-keyb-switches";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index a86a6c5c3f67..9e32c984ab32 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -162,6 +162,17 @@ skin-temp-thermistor@1 {
 	};
 };
 
+&pogo_pins {
+	keyboard@3 {
+		compatible = "usb18d1,5052";
+		reg = <3>;
+	};
+};
+
+&pogo_pins_in {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
 &pp1800_uf_cam {
 	status = "okay";
 };
@@ -190,6 +201,42 @@ &sound_multimedia1_codec {
 	sound-dai = <&max98360a>, <&max98360a_1>, <&max98360a_2>, <&max98360a_3> ;
 };
 
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp4_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp4_ss>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&pogo_pins_in>;
+};
+
+&usb_hub_dfp4_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp4_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_HOMESTAR";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
index 655bea928e52..476c0a2f30da 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
@@ -78,6 +78,61 @@ &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
+&usb_a0_hs {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
+&usb_a0_ss {
+	remote-endpoint = <&usb_hub_dfp3_ss>;
+};
+
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp1_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp1_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_hub_2_x {
+	camera@4 {
+		compatible = "usb4f2,b75a";
+		reg = <4>;
+	};
+};
+
+&usb_hub_dfp1_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp1_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&usb_a0_hs>;
+};
+
+&usb_hub_dfp3_ss {
+	remote-endpoint = <&usb_a0_ss>;
+};
+
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_KINGOFTOWN";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
index c3fd6760de7a..2603607ebd80 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
@@ -68,6 +68,61 @@ &trackpad {
 	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 };
 
+&usb_hub_2_x {
+	camera@1 {
+		compatible = "usb408,a092";
+		reg = <1>;
+	};
+};
+
+&usb_a0_hs {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
+&usb_a0_ss {
+	remote-endpoint = <&usb_hub_dfp3_ss>;
+};
+
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp4_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp4_ss>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&usb_a0_hs>;
+};
+
+&usb_hub_dfp3_ss {
+	remote-endpoint = <&usb_a0_ss>;
+};
+
+&usb_hub_dfp4_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp4_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_LAZOR";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
index 60ccd3abddfc..dee06c64b59a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel.dtsi
@@ -83,6 +83,61 @@ &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
+&usb_a0_hs {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
+&usb_a0_ss {
+	remote-endpoint = <&usb_hub_dfp3_ss>;
+};
+
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp1_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp1_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_hub_2_x {
+	camera@4 {
+		compatible = "usb5c8,b03";
+		reg = <4>;
+	};
+};
+
+&usb_hub_dfp1_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp1_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&usb_a0_hs>;
+};
+
+&usb_hub_dfp3_ss {
+	remote-endpoint = <&usb_a0_ss>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 43b2583f0f26..88ffa2331cd2 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -180,10 +180,54 @@ &sound {
 	dmic-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
 };
 
+&usb_a0_hs {
+	remote-endpoint = <&usb_hub_dfp4_hs>;
+};
+
+&usb_a0_ss {
+	remote-endpoint = <&usb_hub_dfp4_ss>;
+};
+
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp3_ss>;
+};
+
 &usb_c1 {
 	status = "disabled";
 };
 
+&usb_hub_2_x {
+	camera@1 {
+		compatible = "usb4f2,b718";
+		reg = <1>;
+	};
+
+	camera@2 {
+		compatible = "usb13d3,56e9";
+		reg = <2>;
+	};
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp3_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp4_hs {
+	remote-endpoint = <&usb_a0_hs>;
+};
+
+&usb_hub_dfp4_ss {
+	remote-endpoint = <&usb_a0_ss>;
+};
+
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_POMPOM";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
index 00229b1515e6..d0d9871b74cb 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-quackingstick.dtsi
@@ -104,6 +104,17 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&pogo_pins {
+	keyboard@1 {
+		compatible = "usb18d1,505b";
+		reg = <1>;
+	};
+};
+
+&pogo_pins_in {
+	remote-endpoint = <&usb_hub_dfp1_hs>;
+};
+
 &pp1800_uf_cam {
 	status = "okay";
 };
@@ -128,11 +139,31 @@ pp3300_disp_on: &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
 
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
 /* This board only has 1 USB Type-C port. */
 &usb_c1 {
 	status = "disabled";
 };
 
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp1_hs {
+	remote-endpoint = <&pogo_pins_in>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 1d9fc61b6550..409d332fbc13 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -180,6 +180,17 @@ skin-temp-thermistor@1 {
 	};
 };
 
+&pogo_pins {
+	keyboard@3 {
+		compatible = "usb18d1,5057";
+		reg = <3>;
+	};
+};
+
+&pogo_pins_in {
+	remote-endpoint = <&usb_hub_dfp3_hs>;
+};
+
 &pp1800_uf_cam {
 	status = "okay";
 };
@@ -196,6 +207,42 @@ &pp2800_wf_cam {
 	status = "okay";
 };
 
+&usb_c0_hs {
+	remote-endpoint = <&usb_hub_dfp2_hs>;
+};
+
+&usb_c0_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp2_ss>;
+};
+
+&usb_c1_hs {
+	remote-endpoint = <&usb_hub_dfp4_hs>;
+};
+
+&usb_c1_ss_rxtx {
+	remote-endpoint = <&usb_hub_dfp3_ss>;
+};
+
+&usb_hub_dfp2_hs {
+	remote-endpoint = <&usb_c0_hs>;
+};
+
+&usb_hub_dfp2_ss {
+	remote-endpoint = <&usb_c0_ss_rxtx>;
+};
+
+&usb_hub_dfp4_hs {
+	remote-endpoint = <&usb_c1_hs>;
+};
+
+&usb_hub_dfp3_ss {
+	remote-endpoint = <&usb_c1_ss_rxtx>;
+};
+
+&usb_hub_dfp3_hs {
+	remote-endpoint = <&pogo_pins_in>;
+};
+
 &wifi {
 	qcom,ath10k-calibration-variant = "GO_WORMDINGLER";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba28604..ee08a4ecade9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -650,6 +650,12 @@ cros_ec: ec@0 {
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
 
+		cros_ec_gpio: gpio {
+			compatible = "google,cros-ec-gpio";
+			#gpio-cells = <2>;
+			gpio-controller;
+		};
+
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
 			#pwm-cells = <1>;
@@ -662,6 +668,65 @@ i2c_tunnel: i2c-tunnel {
 			#size-cells = <0>;
 		};
 
+		typec-switch {
+			compatible = "google,cros-ec-typec-switch";
+			no-hpd;
+			mode-switch;
+			mux-gpios = <&cros_ec_gpio 42 GPIO_ACTIVE_HIGH>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					dp_ml0_ml1: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&mdss_dp_out>;
+						data-lanes = <0 1>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					usb_c0_ss_rxtx: endpoint@0 {
+						reg = <0>;
+						/* Endpoint filled in by board */
+					};
+
+					usb_c1_ss_rxtx: endpoint@1 {
+						reg = <1>;
+						/* Endpoint filled in by board */
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					cros_typec_c0_ss: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&usb_c0_ss>;
+						data-lanes = <0 1 2 3>;
+					};
+
+					cros_typec_c1_ss: endpoint@1 {
+						reg = <1>;
+						remote-endpoint = <&usb_c1_ss>;
+						data-lanes = <0 1 2 3>;
+					};
+				};
+			};
+
+		};
+
 		typec {
 			compatible = "google,cros-ec-typec";
 			#address-cells = <1>;
@@ -674,6 +739,25 @@ usb_c0: connector@0 {
 				power-role = "dual";
 				data-role = "host";
 				try-power-role = "source";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						usb_c0_hs: endpoint {
+							/* Endpoint filled in by board */
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						usb_c0_ss: endpoint {
+							remote-endpoint = <&cros_typec_c0_ss>;
+						};
+					};
+				};
 			};
 
 			usb_c1: connector@1 {
@@ -683,6 +767,25 @@ usb_c1: connector@1 {
 				power-role = "dual";
 				data-role = "host";
 				try-power-role = "source";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						usb_c1_hs: endpoint {
+							/* Endpoint filled in by board */
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						usb_c1_ss: endpoint {
+							remote-endpoint = <&cros_typec_c1_ss>;
+						};
+					};
+				};
 			};
 		};
 	};
@@ -794,6 +897,7 @@ &mdss_dp {
 &mdss_dp_out {
 	data-lanes = <0 1>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
+	remote-endpoint = <&dp_ml0_ml1>;
 };
 
 &mdss_dsi0 {
@@ -965,6 +1069,41 @@ usb_hub_2_x: hub@1 {
 		reg = <1>;
 		vdd-supply = <&pp3300_hub>;
 		peer-hub = <&usb_hub_3_x>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_hub_2_x_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				usb_hub_dfp1_hs: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+			port@2 {
+				reg = <2>;
+				usb_hub_dfp2_hs: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				usb_hub_dfp3_hs: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				usb_hub_dfp4_hs: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+		};
 	};
 
 	/* 3.x hub on port 2 */
@@ -973,6 +1112,42 @@ usb_hub_3_x: hub@2 {
 		reg = <2>;
 		vdd-supply = <&pp3300_hub>;
 		peer-hub = <&usb_hub_2_x>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb_hub_3_x_ports: ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@1 {
+				reg = <1>;
+				usb_hub_dfp1_ss: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				usb_hub_dfp2_ss: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				usb_hub_dfp3_ss: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				usb_hub_dfp4_ss: endpoint {
+					/* Remote endpoint filled in by board */
+				};
+			};
+		};
 	};
 };
 
-- 
https://chromeos.dev


