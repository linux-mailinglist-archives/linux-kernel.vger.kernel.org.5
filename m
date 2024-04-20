Return-Path: <linux-kernel+bounces-152272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C5A8ABBB2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473701C20A40
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A230C1E521;
	Sat, 20 Apr 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b="mxYXu2Pr";
	dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b="PzYpkLDT"
Received: from mail-gw3.jing.rocks (mail-gw3.jing.rocks [219.117.250.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7C26AC5;
	Sat, 20 Apr 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.117.250.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713618984; cv=none; b=DlRxtERxkHglvisvpl+4kROncONgJy0WY96uuQq+RYVsB2Cx06+gzBsIW4H/IDHCJ2De6pkB8NN2gPXZgvHY2hsONF6MJN9X/LvAsYJn1HBiZj5YEWKGHeJJdinN1Bh3Oa0sn0bCbOLpS+/C/tr4ivJXkddh/zRzeEcRxhXfyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713618984; c=relaxed/simple;
	bh=/E2SsRI6+1CnMkzJGqUluzn1ZgdJDM+ZQA8WYx/El34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mIu9TBzLbmjmUAx6XTKG6R5k7WP7C7a6Fqs28lo2DymQ6e/+I/EgNQuJusIWs/Ao2S2YECuV40vgndSjHO1teK62+F9xirfA/GUGB5BqtEg88txW6AV79qGJ7wfDvyfIPsc/us8+KdBIMGWeDlczJuHATcRxkaedNcBSNpTeil0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jing.rocks; spf=pass smtp.mailfrom=jing.rocks; dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b=mxYXu2Pr; dkim=pass (2048-bit key) header.d=jing.rocks header.i=@jing.rocks header.b=PzYpkLDT; arc=none smtp.client-ip=219.117.250.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jing.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jing.rocks
Received: from mail-gw3.jing.rocks (localhost [127.0.0.1])
	by mail-gw3.jing.rocks (Proxmox) with ESMTP id AA609EA94;
	Sat, 20 Apr 2024 22:04:46 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jing.rocks; h=cc
	:cc:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=mail-gw; bh=Ekh+
	vb1T4uv7G/SoGT6Q0xLqqdJaTLg2htjm/0kf+g8=; b=mxYXu2PrPRUvnggtCw3t
	T4HRKMEHfrZh1pY/WHlYvhQpwWOHJenyxQ44e43g4liLbWX6WS82bbNvpRTFeMTz
	4sWdYLuLlTmETtPZX2ixZiG+iTJhVYhZPqtYyfsuiY+j59OVrcMo+BEoxk0AAuV5
	QpFHoIxPqreR2tU3sZFV34qFOGCMGSwvIf1LeU5QsbjRdy9q4/ehfjfHstVijnmv
	t7OSFQQBvD54OdWg7tAmWpXJAxyPFGQpF0R8n5M7POT85uX/u8c3vdSzbiKNVKbn
	SfSyPnFhUc6iTzrxWL65yen3PsOxxjvfY9UiZeq/JknyE+4r27o2qdj5nbmGtPla
	cQ==
Received: from mail.jing.rocks (mail.jing.rocks [192.168.0.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-gw3.jing.rocks (Proxmox) with ESMTPS id EDCEAE951;
	Sat, 20 Apr 2024 22:04:43 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jing.rocks;
	s=default; t=1713618283;
	bh=/E2SsRI6+1CnMkzJGqUluzn1ZgdJDM+ZQA8WYx/El34=;
	h=From:To:Cc:Subject:Date:From;
	b=PzYpkLDTdZbu4Bl34ShZimDAkm0Kk0lrub53OqJRg0H7z0mTGHPtCkcChdyAIBP3m
	 C7jPe0O5fJlksBZl2OufUv8Lb3WrCcevCrF5/UlIiGYLOsizV4qcf9OqBq1/As5cBp
	 0IkT02fIcZ8XuuZ2A/rclotBXLuJJX3pomKwzDoz7HTW/guYJm0clVPucl8E49X8+l
	 T3rYawFDymAhrcEtK9M1vqx72Q/erS2Fn3329UAY7fAdQdE6wsisvEMMrtg6kRjY4+
	 g0hDCdNDfCeUnZzsYCta7DPxhcnH1q0K8oqfDaqv974zVIe9NmPt++a1vcpR66/5aN
	 ODUkEr8Rl+Uqg==
Received: from X570AM.jing.rocks (X570AM.jing.rocks [IPv6:240b:10:f00:1b00::7e82])
	(Authenticated sender: jing@jing.rocks)
	by mail.jing.rocks (Postfix) with ESMTPSA id B8FB22A509;
	Sat, 20 Apr 2024 22:04:43 +0900 (JST)
From: Jing Luo <jing@jing.rocks>
To: heiko@sntech.de,
	linux-rockchip@lists.infradead.org
Cc: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	sebastian.reichel@collabora.com,
	cfsworks@gmail.com,
	jagan@edgeble.ai,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jing Luo <jing@jing.rocks>
Subject: [PATCH] arm64: dts: rockchip: correct gpio_pwrctrl1 typos on rk3588(s) boards
Date: Sat, 20 Apr 2024 22:03:55 +0900
Message-ID: <20240420130355.639406-1-jing@jing.rocks>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpio_pwrctrl2 gets duplicated by both rk806_dvs1_null and rk806_dvs2_null
gpio_pwrctrl1 is unset. This typo appears in multiple files. Let's fix them.

Note: I haven't had the chance to test them all because I don't own all
of these boards (obviously). Please test if it's needed.

Signed-off-by: Jing Luo <jing@jing.rocks>
---
 arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi           | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts                | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi                | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi           | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts      | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts           | 2 +-
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts              | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
index cce1c8e83..5fc40f16d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5.dtsi
@@ -357,7 +357,7 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
index c0d4a1532..d9bf67525 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-edgeble-neu6a-common.dtsi
@@ -182,7 +182,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 39d65002a..7d7303f8e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -452,7 +452,7 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 1eb2543a5..9a196836e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -396,7 +396,7 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index dc08da518..6b9206ce4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -318,7 +318,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index e037bf9db..7f4d7bb9a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -479,7 +479,7 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index ce8119cbb..a5b76e24c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -528,7 +528,7 @@ pmic@0 {
 		vcca-supply = <&vcc5v0_sys>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
index 25de4362a..73700d77e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5.dts
@@ -336,7 +336,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 00afb90d4..5c99636a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -414,7 +414,7 @@ pmic@0 {
 		#gpio-cells = <2>;
 
 		rk806_dvs1_null: dvs1-null-pins {
-			pins = "gpio_pwrctrl2";
+			pins = "gpio_pwrctrl1";
 			function = "pin_fun0";
 		};
 
-- 
2.44.0



