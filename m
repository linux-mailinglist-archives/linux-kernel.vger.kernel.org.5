Return-Path: <linux-kernel+bounces-7668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6522B81AB71
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20359282DCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DF4F612;
	Wed, 20 Dec 2023 23:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hbJ9A2us"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39EF4F1E0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7ba7e8ba078so8263239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116522; x=1703721322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjWQ8eHs2ceg5U4ktitsF8+YwQ1pARiSqNQDfBjNb6E=;
        b=hbJ9A2usGrH7IQvXrRk9FH5Jx/CipokbMBy80RejDGQy09ierB3oveknrICujQ5juw
         O/yKO3ezi+UriLtn5nCq1HXGjwgy6ufVJRLwmaCcR9uRKCZndrdPG7hLaH8TI2zQ0txO
         XJqVKAp8cSESzV7foeHH6SHLo/s0rBBhVCY44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116522; x=1703721322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjWQ8eHs2ceg5U4ktitsF8+YwQ1pARiSqNQDfBjNb6E=;
        b=R1ILaWsdvgvMdbqSa5SYfq9ClmZfDvpz+ZXKJFQU9RXwfHAeXzywYob4326Uyra4B4
         bG8znlJ9Fx1aEaW954i660Ng3pqsMu87BwP9tXgqaEE2QFnUFoq6EMtf7D9qmofk6zsR
         7YFKCUuF+/KPwR/3O3aY2MvrPD/WDXSakIuIKHb27zE1CjdL1jAXsZvrc3TVGOcAlz5V
         hoAIJd4WvC7uZIN+bDE6WPsLvWhVOdDKtZwBgiUkSFkh7Nxom/oxhRSW24x4uuCoWbxG
         +wV2XL3MjUv/1ZO2Ll0ai8hPXUicYTwuXk4wNEd2xJUI/THslXUBLxwpZ9uAAv2vFx3N
         UQpg==
X-Gm-Message-State: AOJu0Yxwn5Pvt7xhj5y/SjhHss25PKiBIZRyA0MpPaxha2T8UsymwiJW
	6sA9cDUjmeC6+hXyi4mfJyRFA6CNiiboPpyg6/s=
X-Google-Smtp-Source: AGHT+IHVHPsjxzWXdDQxx0hkClv58a6uuyHSa0qGobL+NY/YSniAlZM8fFxAz9OPni6RxwbAihyg9A==
X-Received: by 2002:a05:6602:2809:b0:7ba:80de:e3b9 with SMTP id d9-20020a056602280900b007ba80dee3b9mr786935ioe.11.1703116521985;
        Wed, 20 Dec 2023 15:55:21 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:21 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Hasemeyer <markhas@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 15/22] arm64: dts: qcom: sdm845: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:29 -0700
Message-ID: <20231220165423.v2.15.I870e2c3490e7fc27a8f6bc41dba23b3dfacd2d13@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231220235459.2965548-1-markhas@chromium.org>
References: <20231220235459.2965548-1-markhas@chromium.org>
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

Add the wakeup-source property to all cros-ec-spi compatible device
nodes to match expected behavior.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

Changes in v2:
-Split by arch/soc

 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 0ab5e8f53ac9f..e8276db9eabb2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -852,6 +852,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_ap_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
-- 
2.43.0.472.g3155946c3a-goog


