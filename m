Return-Path: <linux-kernel+bounces-11640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0981E953
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133061F22A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76674134CA;
	Tue, 26 Dec 2023 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KNBDXOTR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8C13AC0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-35fe756e8dfso6892335ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618532; x=1704223332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O8RtIP4pYk/I1CB5YssfqNJgeBGU8rziw+9z/3E58g=;
        b=KNBDXOTRa9TRuzLfjN0nENjKHo7jOEfo9jyUYKuYwTjmWVxgkSlM7d96c1C1xHhZjE
         40ufDV2ONTWZialao6qgAmqbe4NQvnoynfLafu7HmIrRV8HUrvuNlJCh9uugL/Ls+gC+
         tjRr8CtqrpJkg6K6pzxilcH/4NNZA3OpfvZUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618532; x=1704223332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0O8RtIP4pYk/I1CB5YssfqNJgeBGU8rziw+9z/3E58g=;
        b=aPXdyyb54m4SlWtgE0Tbm0bScOEcGOYZViV8sPAQQEiGf9/EljT6kS6F731LVUPI+e
         g7X0BXx9aR9wCBqjjXViixyTBs03NyDdGnX9iM7HIz55gUpNSQd7sI373+Z5RdKYdUN6
         qc/0RmtYdA4rF5YSbzY2HNBm1Y5B+dMxcsTWh5e+RXMI/EqhG+EukBnomCOMCoTfv5sF
         qLK6beHuExZt0qdwVcHgj6Z7iiVywT7u5lnKORFN7kcpgyhhAlhgc9Y50pcczf2yzFFJ
         pVZo8doCkZnH9NPPyBr/AE/yt4POmbpHE0t+1WXhVuNVZqNBPq1YTYTTU5rIO01CUL8G
         I7Vg==
X-Gm-Message-State: AOJu0YzHvSzkF7vv21O4Dk3pmT6Nj4RPSWB8TNNeNHBD+Lf5Qy2v/RYa
	vwLRZOldKr2YeZhFPtUhFWvHOoDmPRvS1pyrRzf/nrIDqTlk
X-Google-Smtp-Source: AGHT+IEPvjdPgLWnim9CRScF1zgDLSQesNC/8qGs5BHhtwyK/zW05fi43O35+h7z9keU2BUHrJr/5Q==
X-Received: by 2002:a05:6e02:1a08:b0:35f:eceb:f845 with SMTP id s8-20020a056e021a0800b0035fecebf845mr4107785ild.8.1703618532594;
        Tue, 26 Dec 2023 11:22:12 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:12 -0800 (PST)
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
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v3 12/24] arm64: dts: mediatek: mt8195: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:16 -0700
Message-ID: <20231226122113.v3.12.Iee33a7f1f991408cef372744199026f936bf54e2@changeid>
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

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index bbdcd441c049d..2edb270d0bc2f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1149,6 +1149,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&cros_ec_int>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		keyboard-backlight {
 			compatible = "google,cros-kbd-led-backlight";
-- 
2.43.0.472.g3155946c3a-goog


