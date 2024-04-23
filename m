Return-Path: <linux-kernel+bounces-155302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383258AE88A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F591C21FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696DC139CEA;
	Tue, 23 Apr 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcOuIMN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F9213667A;
	Tue, 23 Apr 2024 13:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880012; cv=none; b=hU87AspLKP8PZFEVEFfwsqU3F8kuP72j4fQQI1jgwMvBLVe8jPrLpMjc7NeRcl3wMetPpGhgphMQ7l9p6lzGOHVbQoCx8wNHgjVxDYCNL2e3NU+uEPFd3okXDMUkPM6kyW/JQSB1v9Tohu5pOLVSvBkzFcu/4a8RzH6VNf/IUTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880012; c=relaxed/simple;
	bh=FHGWR5/JvEtSCzN6BsDdKdt7AWKO+kzD4nDxcEDqLvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J++itqmysfPFJ71QZ4YX4prt2VbhZ+m+oPIRP9pEdCo+Abk/+mvcUjtHTYj6N0qdr8UzEKdAmQ38dbTZtY/66YgOy6nTqx8jmknHTUmz/Uv3sQqGUwNN9Rx3hbO9n6c5yOwdwMMbnckPU0XL7PRwjbHYBD4rG8E4ejpXpDkU0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcOuIMN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0040EC2BD11;
	Tue, 23 Apr 2024 13:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713880012;
	bh=FHGWR5/JvEtSCzN6BsDdKdt7AWKO+kzD4nDxcEDqLvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcOuIMN0CqoaXi3/V2LwYASFmAqpQusYdaqjCht1rNbKaKdoHyb/xtCP2qxs6KdGf
	 drEZWKY9InbjAkL09UA4vLBeSATWd4re35fpgpe8mWH5bsfO9E5VQ/J2GF7fmmmZAU
	 poRg18vFbjCf1GZaMq5uFpuNzbXTzjsLyBWlkbtuHgZx2EokmSfrAbBokFakDR8ZOt
	 K41RktY3rTo1IoMB+BrEmmtehXkz9JJcWDZAokledObRM9eB5osZzNvN9NO2rEDe05
	 2CIn0EAfyckVoXedQCAcz5cOKkpoIl6S2i5DYa6NGLMfJIE/SyQGnkXhXkCQ6/sSRa
	 Tm169E7DhEQew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1rzGTy-000000008Ko-1mxx;
	Tue, 23 Apr 2024 15:46:50 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: qcom: sc8280xp-x13s: fix touchscreen power on
Date: Tue, 23 Apr 2024 15:46:10 +0200
Message-ID: <20240423134611.31979-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240423134611.31979-1-johan+linaro@kernel.org>
References: <20240423134611.31979-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Elan eKTH5015M touch controller on the X13s requires a 300 ms delay
before sending commands after having deasserted reset during power on.

Switch to the Elan specific binding so that the OS can determine the
required power-on sequence and make sure that the controller is always
detected during boot.

Note that the always-on 1.8 V supply (s10b) is not used by the
controller directly and should not be described.

Fixes: 32c231385ed4 ("arm64: dts: qcom: sc8280xp: add Lenovo Thinkpad X13s devicetree")
Cc: stable@vger.kernel.org	# 6.0
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b220ba4fba23..e27c8a21125c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -674,15 +674,16 @@ &i2c4 {
 
 	status = "okay";
 
-	/* FIXME: verify */
 	touchscreen@10 {
-		compatible = "hid-over-i2c";
+		compatible = "elan,ekth5015m", "elan,ekth6915";
 		reg = <0x10>;
 
-		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
-		vdd-supply = <&vreg_misc_3p3>;
-		vddl-supply = <&vreg_s10b>;
+		reset-gpios = <&tlmm 99 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+		no-reset-on-power-off;
+
+		vcc33-supply = <&vreg_misc_3p3>;
+		vccio-supply = <&vreg_misc_3p3>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts0_default>;
@@ -1637,8 +1638,8 @@ int-n-pins {
 		reset-n-pins {
 			pins = "gpio99";
 			function = "gpio";
-			output-high;
-			drive-strength = <16>;
+			drive-strength = <2>;
+			bias-disable;
 		};
 	};
 
-- 
2.43.2


