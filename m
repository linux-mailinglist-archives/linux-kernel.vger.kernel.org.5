Return-Path: <linux-kernel+bounces-11643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228181E95B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AEB1F22A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83D7182CC;
	Tue, 26 Dec 2023 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mdI896Et"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9EE16416
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7ba8e33dd0cso199196139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618535; x=1704223335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAnFSzJDHfNnMpGVaHg6fCPRHIBad/we4YSkuQl5+SM=;
        b=mdI896EtZtzOvRkvTaOPQTqfohF6Fm12/2OpXEHXUmWE/sIJuXduG3gUqx5fkgLSqz
         JeEkExwLeZ5142v7EvSCs0Zd/O0MA7orhIsputPVgkj60oADhAUtC/H8XaICo1RcjX6t
         BVr0OqN6dMzC0n3rF3LMJfvOGxCHsBEvNfUgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618535; x=1704223335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAnFSzJDHfNnMpGVaHg6fCPRHIBad/we4YSkuQl5+SM=;
        b=wBxXUDMWLPsRBkbAZD1GimVFU1XqyoH5E4fsYbuVR7vQ1g81Nzhw+RE43obd6WaRZa
         9tjiKX0S1k1HBdf9IepNFVRGUMb02c/6aiZVkdOwbKbw5Kb+fHBmUBVgsuEDlRMEv2Ba
         s2bNFcmsDAe5OjlUKibLhjg1MJtuP2q+MegkVpQMwtfe716qxOrTi6IHnzuVyEiDHSy8
         pxaUKB9q7OiF3k+m9Mk1EWbWpkrK3DFYRe6cpXQ6bipevEEke3ZW13InjFNE0IM7tMO5
         eXXf4wVwRBzrNW9rcroT0EcB6n8N/A5tkspnLK+7U+s/LfP1PN3oBc/a1TuyjEOzZaE/
         E8fw==
X-Gm-Message-State: AOJu0Yyv/PGGA0U83qM7fjvrSLBAM3F+S/nBR1FazAW5eZddoK4GS3Bq
	rBZ31k94OhvjonVRKCF11PlfzeXRXcvL4DgLpBA57GFOp2Rp
X-Google-Smtp-Source: AGHT+IEzBIeiXFU4rn0iqW6wJdrynrvlyiLuDVC+E/J27rd0IXEV8/bD2oBhdXZGlp7zJi8p5eN5NA==
X-Received: by 2002:a05:6602:5c8:b0:7ba:8314:cbee with SMTP id w8-20020a05660205c800b007ba8314cbeemr7588062iox.19.1703618535057;
        Tue, 26 Dec 2023 11:22:15 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:14 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Hasemeyer <markhas@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v3 15/24] arm64: dts: qcom: sc7280: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:19 -0700
Message-ID: <20231226122113.v3.15.I7ea3f53272c9b7cd77633adfd18058ba443eed96@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231226192149.1830592-1-markhas@chromium.org>
References: <20231226192149.1830592-1-markhas@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cros_ec driver currently assumes that cros-ec-spi compatible device
nodes are a wakeup-source even though the wakeup-source property is not
defined.

Some Chromebooks use a separate wake pin, while others overload the
interrupt for wake and IO. With the current assumption, spurious wakes
can occur on systems that use a separate wake pin. It is planned to
update the driver to no longer assume that the EC interrupt pin should
be enabled for wake.

Add the wakeup-source property to all cros-ec-spi compatible device
nodes to signify to the driver that they should still be a valid wakeup
source.

-Commit-changes: 3
-Update commit message to provide details of the motivation behind the
change

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v2)

Changes in v2:
-Split by arch/soc

 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 1 +
 arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 9ea6636125ad9..2ba4ea60cb147 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -548,6 +548,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
index ebae545c587c4..fbfac7534d3c6 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp-ec-h1.dtsi
@@ -19,6 +19,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
-- 
2.43.0.472.g3155946c3a-goog


