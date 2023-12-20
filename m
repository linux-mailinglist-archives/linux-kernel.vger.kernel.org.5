Return-Path: <linux-kernel+bounces-7665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA681AB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 704FF1C244EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B920D4D585;
	Wed, 20 Dec 2023 23:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m67xZNrj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37594E61D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7b7fb34265fso9423539f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116520; x=1703721320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJduS/1fJUByj83cmxVS/XQjbXOMlAAEnEEqFMZKGGY=;
        b=m67xZNrj+bACUTayQ8vCk89bCG3aJ28wj3+AqWdfhb/qVO+YiEUYCVbWttmog6/dUg
         HBvQxuQO+CNyNoc4yCurTN7IgCziZZIwczOJmGTNJwYjCeA8UsJJSwwvt2z74jDeDdW8
         4uiIE/nnmHJxzfBWYUAEQqrJmekZ923LqZHuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116520; x=1703721320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wJduS/1fJUByj83cmxVS/XQjbXOMlAAEnEEqFMZKGGY=;
        b=qy05l5UQ0mCbzYj8AYI41P9ffhM6nPrreEjbeoXPiIB4vlWOUPRsXKjgP42yjCiyPG
         O0yDgOTZYswr7bEPVLerEhL9KdE269SRbTRbzdPKTa0WSoqCY6OWNL5Ngj2PAgvCGFQm
         aOl89XKhkNQn6lLKX70KAMyJpj0r0qH9at+yT7Wz5xqj4CpXK9l/BrekHkIpp3Tzbc3z
         FeK0ePzq8zrUA8yBM3JClenB1L6DxR6v38kYkPbHRLbZCvmjNzv8MAigwa9v7tMjqj7i
         U1e5tb9/Pi9F2l/KiWjp53EawCLzkKoxFjhaBZLSeV8qMf9xFYywZA2PnknzPRDWkAsz
         KRJg==
X-Gm-Message-State: AOJu0Yx3WYtm8zGDPBM0wlpV8h9kMiJQ5c61hN/44PAUhxnyVvOT2y0r
	ZUyKMPjuDQ3jXzzh1Va87EIg0XNBWrxSwVEEHPs=
X-Google-Smtp-Source: AGHT+IHGFtnZQ7iLgJfoVYEVEaK5odOPIEkB3kjTbyuaK6Zg3MTx5G7vEnhwrIdBftS6jyvuHgaTVw==
X-Received: by 2002:a5e:8610:0:b0:7ba:753a:ed0a with SMTP id z16-20020a5e8610000000b007ba753aed0amr1782436ioj.16.1703116520055;
        Wed, 20 Dec 2023 15:55:20 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:19 -0800 (PST)
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
Subject: [PATCH v2 13/22] arm64: dts: qcom: sc7180: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:27 -0700
Message-ID: <20231220165423.v2.13.I2ee94aede9e25932f656c2bdb832be3199fa1291@changeid>
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

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 46aaeba286047..f3a6da8b28901 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -649,6 +649,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ap_ec_int_l>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		cros_ec_pwm: pwm {
 			compatible = "google,cros-ec-pwm";
-- 
2.43.0.472.g3155946c3a-goog


