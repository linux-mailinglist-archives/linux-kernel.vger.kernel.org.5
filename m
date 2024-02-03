Return-Path: <linux-kernel+bounces-51258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CB8848864
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 20:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9762821D5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470B5FDAE;
	Sat,  3 Feb 2024 19:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="igtWCgzx"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E675FBB4
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987550; cv=none; b=drWl3v49cExkN2bYsji7yvUpmQuLsTLqHvQsZyp570T1P6gaRi2ufUq0GCWHDWp0Pbm/FEdLwl9cOGqGpTU/pXM0baE3St8VpAbigiiVX80LuY4t5ZfwmeTl1H20VcfaXZJh6xtNDy6NTJS6id5ypXmxAOOMiFkV0FtNV8zfpQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987550; c=relaxed/simple;
	bh=giYyQ4lqO2YoScnu5Fp4JQtpjhwywXg+LNVOFgiaUWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Btk3Gm2WrfjuaO8elAy+1fPZPXcfsAlW5Y5ldeJJSmH1Ot4l9PYTbgfu6+go6uuh2sg7uqiYmhew1mE59X8EnNxV4qQwaBcal7+xM3sFSUFCIkUXDGnH6PY7fS1XcVCburSyobntBq5idFBtT4Yn4yL8dJo7pFJltfNizSwb8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=igtWCgzx; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1706987547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k8u/VoqVTUPlxnhfNHXLj42MX1rvQDLgTi15K0P6Loc=;
	b=igtWCgzxSlUCY3vSNXhlX14Ld4HMdQpGC5OG1/xekfw1Iw7LK9I+a7JvnL26JGiJnJo5Y7
	FP9Jee7bYrhOo7U9FN8YZ5lR2KUNeQG+kLvgEYTt101d+yY7+iFifakR41ZvDiNnBJ0b4J
	sbMONfaK0/k27pCQGvFhgLBMrd9l/77Y85KwTYql02DuDTSMT3JzsPvO6zNkeCWDhoiSZa
	g5NO19QNoHLDepK++u0ln4Y+gHT2tdLMR4SnVDAJn7biNNpbgBtfuNAugU2sHnI+/HOq+E
	fWjDThdRgxx04oIaw+xV6cictjDm6Taek0dtySMNGx8Kgc7iGLS+5yyngfOqdw==
From: Anton Bambura <jenneron@postmarketos.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8180x-lenovo-flex-5g: move pinctrl to appropriate nodes
Date: Sat,  3 Feb 2024 21:11:57 +0200
Message-ID: <20240203191200.99185-4-jenneron@postmarketos.org>
In-Reply-To: <20240203191200.99185-1-jenneron@postmarketos.org>
References: <20240203191200.99185-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Split keyboard and touchpad pinctrl nodes since they are for different
devices and move keyboard, touchpad and touchscreen pinctrl references to
appropriate nodes.

Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
---
 .../boot/dts/qcom/sc8180x-lenovo-flex-5g.dts  | 41 +++++++++++++------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index af61acf58d68..6ae6cb030b70 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -357,7 +357,7 @@ zap-shader {
 &i2c1 {
 	clock-frequency = <100000>;
 
-	pinctrl-0 = <&i2c1_active>, <&i2c1_hid_active>;
+	pinctrl-0 = <&i2c1_active>;
 	pinctrl-names = "default";
 
 	status = "okay";
@@ -368,13 +368,16 @@ touchscreen@10 {
 		hid-descr-addr = <0x1>;
 
 		interrupts-extended = <&tlmm 122 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&ts_int_default>;
+		pinctrl-names = "default";
 	};
 };
 
 &i2c7 {
 	clock-frequency = <100000>;
 
-	pinctrl-0 = <&i2c7_active>, <&i2c7_hid_active>;
+	pinctrl-0 = <&i2c7_active>;
 	pinctrl-names = "default";
 
 	status = "okay";
@@ -385,6 +388,9 @@ keyboard@5 {
 		hid-descr-addr = <0x20>;
 
 		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&kb_int_default>;
+		pinctrl-names = "default";
 	};
 
 	touchpad@2c {
@@ -393,6 +399,9 @@ touchpad@2c {
 		hid-descr-addr = <0x20>;
 
 		interrupts-extended = <&tlmm 24 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&tp_int_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -669,14 +678,6 @@ i2c1_active: i2c1-active-state {
 		drive-strength = <2>;
 	};
 
-	i2c1_hid_active: i2c1-hid-active-state {
-		pins = "gpio122";
-		function = "gpio";
-
-		bias-pull-up;
-		drive-strength = <2>;
-	};
-
 	i2c7_active: i2c7-active-state {
 		pins = "gpio98", "gpio99";
 		function = "qup7";
@@ -685,8 +686,8 @@ i2c7_active: i2c7-active-state {
 		drive-strength = <2>;
 	};
 
-	i2c7_hid_active: i2c7-hid-active-state {
-		pins = "gpio37", "gpio24";
+	kb_int_default: kb-int-default-state {
+		pins = "gpio37";
 		function = "gpio";
 
 		bias-pull-up;
@@ -718,6 +719,22 @@ wake-n-pins {
 		};
 	};
 
+	tp_int_default: tp-int-default-state {
+		pins = "gpio24";
+		function = "gpio";
+
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio122";
+		function = "gpio";
+
+		bias-pull-up;
+		drive-strength = <2>;
+	};
+
 	usbprim_sbu_default: usbprim-sbu-state {
 		oe-n-pins {
 			pins = "gpio152";
-- 
2.42.0


