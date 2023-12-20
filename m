Return-Path: <linux-kernel+bounces-7664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FE81AB65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEBC4B225C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7174E622;
	Wed, 20 Dec 2023 23:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cqCgo5MJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF2A4D5AD
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-35da160de2bso907215ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116518; x=1703721318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGItW2tX+Z99WO9rLTZWRRLNJGNHjPVu0HpOP7a3OKs=;
        b=cqCgo5MJ+zQltH6gmsqAhQd4bBYDYD4ULm26qgJFLOYE+2YZbgxbNwmguh+wk27J02
         DBvVHmleH5W96tR06KqERKOQcstAhANlSmRTntAYo/fd4lmNtzaNUGEsJCq0aTzALpfu
         pWLELdH++kpUjhZ/Y5H54SwLm4T9mCbemWhwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116518; x=1703721318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGItW2tX+Z99WO9rLTZWRRLNJGNHjPVu0HpOP7a3OKs=;
        b=s7LxcEu4rZWLrL82KH3AY+sIi2MRm1F2PBOtMQ+9IWSUGz9l8xQ+qeb3d9KBADD50A
         nyU2ZkHfv6McARSxiNCDXjglc2IDVLOnIrbtqKFvcVLgnQuUFrjyMo/tieytR8pbN5/Y
         P369TB0OgcnSsnk31SM27iNPkhdc8z0NeqMiu2ltrg3kpWvP0A1g+8jyL/XKe0ZSorJH
         /MJXCvhzcTCclpC0N8w7HxN1UmMn56NCyovzXEPH4wJzZfbeJcbz0OpbGhGD/Y9t+BMf
         16rCUVcHbuZbMq9bf9qdehttC4wHmxalqfhAWvvuviSwzc/37GAQNNWaobV6T3GanyTF
         53gw==
X-Gm-Message-State: AOJu0YzXeNZz3jCv2veB8GvxB5NWe+ysKgW/prJeXHQVoF4/QDv96Ddn
	Xx9oK7WMSuYtkT5ofo5RsfhVogA6gRxYy86sBXo=
X-Google-Smtp-Source: AGHT+IEeTSi14BnWNyhDnJXCHg/iyGa81oQJSiNqZOmCD0hxTMyfI0gkwqEmm1ElucJzYwa6n9C2iA==
X-Received: by 2002:a05:6e02:3892:b0:35f:b4ef:ff2d with SMTP id cn18-20020a056e02389200b0035fb4efff2dmr5733161ilb.18.1703116518133;
        Wed, 20 Dec 2023 15:55:18 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:17 -0800 (PST)
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
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 11/22] arm64: dts: mediatek: mt8195: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:25 -0700
Message-ID: <20231220165423.v2.11.Iee33a7f1f991408cef372744199026f936bf54e2@changeid>
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

 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
index 5a7cab489ff3a..4292b72566bcf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
@@ -1067,6 +1067,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&cros_ec_int>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		keyboard-backlight {
 			compatible = "google,cros-kbd-led-backlight";
-- 
2.43.0.472.g3155946c3a-goog


