Return-Path: <linux-kernel+bounces-117006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F588B2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20C5B44B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC6213AD20;
	Mon, 25 Mar 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EHB0+G81"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D61137C42
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370037; cv=none; b=Pr0GvjzD9WxreiqgjTziKn3bx9+LLl0NwrLJCjp/7CaNedECcE6jumOPbvkmbLtr3dbBUQIhuNM7J9MF7gW990GkGfjuNjMn2A2LlOide8J+uEzdPP3Y+i5fu79cNBDdaCFsdBKz8RslpKQZxSpawt4pr1TdPm3dME7CRBtfHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370037; c=relaxed/simple;
	bh=HEkrLhhRRUjJmnvU23W480E8X/VNsYOMU/gxm5X8yQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmvsmmezFa96Gq7vFlHqX87drb4lxiE4ojgALxol4zM7oU/TUZ+dfq86CN9nwgdmSlK3rmzNjFwX2ZRSouQNPklAwxfo3BmGYXXiFs5Uame1wbDwDTVIvyjxY/CBc8z8L2Lmh+39XNw2efLcd+RA54C81I3lIj+9O/Ho/7l3sRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EHB0+G81; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56c0613307cso1525233a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711370034; x=1711974834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZg1upjIEPOUaPSwFv7osGLwaVnVPmPJA02WN7iv0AQ=;
        b=EHB0+G81zYtTAr/OmzJAsPTDpxKEfJaIbvJLLmXjJuvEZ2Cl0sz5CXXdBcgE9WDFoA
         BbBwXqyJfSvGoykAeZGKk0Ts6f7iF88FB6kQxOl1vWTVq82yxkLi2tA2XoAe1YI8GWpN
         mG+yd3+0hlH6GyqfEf5QXJiwtuigT67jUJmGPDC/aCX7tkUML3yx2Qsb4MRT7GJ05XdR
         kZhYFd5EaU2Uqf+1Uv3p89+eqRqFhno0BLHth+Pzt4+4JzUeDv3X9XkmrACi0KdqiR5D
         9OjV+elnol2Kcaqbp4MRP591jzyqj4sFo0N4Xkifzdr4R2huApn2HA+5bqAatqAKikRl
         kxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711370034; x=1711974834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZg1upjIEPOUaPSwFv7osGLwaVnVPmPJA02WN7iv0AQ=;
        b=wQhVCUvXDbUFQpVSh0Q0DRkqiRhDZ0nV0ZQ33oetVhf5KbblrHs3mXd0NA+wTKWY4K
         elpYRmUaikSFyKSWBfwNOAittcum5TKFOz1uFJI4+3ROhLngqSSjZOc3TRxDASuYJ45f
         jHG5llUKW3yIOyf0EjzDBRhkl9YQDtqJChgVsRy6kIFlfVNIqasttWONkYsiszmUT5LV
         wRTCYF8NW5XC333AFfjUHeI8pTT/V2BKtclByeisk/uuREcTZgVXNtxlPFJMGOpHZHH0
         7p7aJ3T5TOv+3k5X47ML7hkdxn6MnOirearI48KI4X+rFes/8MwBUDQtVEB0OElDozL/
         JhZg==
X-Forwarded-Encrypted: i=1; AJvYcCVF3fzpemu+YkHgpKbpQ289Ouwp9XWnrJKNaw/uQ+Jp5C6P1jufk2sheJCjNShvTuKTLy3PdBwz/UHa31yqJRfrPmvCthnjkbtF3bDM
X-Gm-Message-State: AOJu0YwAhMvlL5WbR+SpwBaWtzHlcL4lnVaDA6PoFufd4Jh2dzMC67pW
	hnnx7iE73MLoDZDCWUVv8/hxMbWuO2J4SLEdScwUvCYcnkCiRaozioK7YuoC3vE=
X-Google-Smtp-Source: AGHT+IGmNf0RUIWn6ph3r7Da/55t3j9lg9CcqsBNxnZlh/fecDcW4+l8yAnomJUiqzHts9TgxdM0iQ==
X-Received: by 2002:a50:8e54:0:b0:568:d1a2:8ff with SMTP id 20-20020a508e54000000b00568d1a208ffmr4003552edx.34.1711370034069;
        Mon, 25 Mar 2024 05:33:54 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id es9-20020a056402380900b00568d60cfbccsm2933383edb.42.2024.03.25.05.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 05:33:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: x1e80100-crd: switch WSA8845 speakers to shared reset-gpio
Date: Mon, 25 Mar 2024 13:33:48 +0100
Message-Id: <20240325123348.45249-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123348.45249-1-krzysztof.kozlowski@linaro.org>
References: <20240325123348.45249-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each pair of WSA8845 speakers share the powerdown SD_N GPIO, thus this
GPIO is specified twice in each WSA8845 device node.  Such DTS was added
hoping non-exclusive GPIO usage would be accepted, but it turned out
otherwise: it is not supported by the Linux kernel.

Linux kernel however supports sharing reset GPIOs, when used via the
reset controller framework as implemented in commit 26c8a435fce6 ("ASoC:
dt-bindings: qcom,wsa8840: Add reset-gpios for shared line") and
commit c721f189e89c ("reset: Instantiate reset GPIO controller for
shared reset-gpios").

Convert the property with shutdown GPIO to "reset-gpios" to use
mentioned Linux kernel feature.  This allows to bring all four speakers
out of reset.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Rb tag.
2. Fix typo in commit msg (bia->via)

Patch #3 in the series was already applied.

v1: https://lore.kernel.org/all/20240227142725.625561-1-krzysztof.kozlowski@linaro.org/
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index d7ba45953277..266a461f4882 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -802,13 +802,14 @@ &smb2360_2_eusb2_repeater {
 &swr0 {
 	status = "okay";
 
+	pinctrl-0 = <&wsa_swr_active>, <&spkr_01_sd_n_active>;
+	pinctrl-names = "default";
+
 	/* WSA8845, Left Woofer */
 	left_woofer: speaker@0,0 {
 		compatible = "sdw20217020400";
 		reg = <0 0>;
-		pinctrl-0 = <&spkr_01_sd_n_active>;
-		pinctrl-names = "default";
-		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "WooferLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -819,8 +820,7 @@ left_woofer: speaker@0,0 {
 	left_tweeter: speaker@0,1 {
 		compatible = "sdw20217020400";
 		reg = <0 1>;
-		/* pinctrl in left_woofer node because of sharing the GPIO*/
-		powerdown-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 12 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TwitterLeft";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -853,13 +853,14 @@ wcd_tx: codec@0,3 {
 &swr3 {
 	status = "okay";
 
+	pinctrl-0 = <&wsa2_swr_active>, <&spkr_23_sd_n_active>;
+	pinctrl-names = "default";
+
 	/* WSA8845, Right Woofer */
 	right_woofer: speaker@0,0 {
 		compatible = "sdw20217020400";
 		reg = <0 0>;
-		pinctrl-0 = <&spkr_23_sd_n_active>;
-		pinctrl-names = "default";
-		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "WooferRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
@@ -870,8 +871,7 @@ right_woofer: speaker@0,0 {
 	right_tweeter: speaker@0,1 {
 		compatible = "sdw20217020400";
 		reg = <0 1>;
-		/* pinctrl in right_woofer node because of sharing the GPIO*/
-		powerdown-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&lpass_tlmm 13 GPIO_ACTIVE_LOW>;
 		#sound-dai-cells = <0>;
 		sound-name-prefix = "TwitterRight";
 		vdd-1p8-supply = <&vreg_l15b_1p8>;
-- 
2.34.1


