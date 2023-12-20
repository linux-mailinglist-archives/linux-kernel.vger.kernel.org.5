Return-Path: <linux-kernel+bounces-7660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F4281AB5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89DD1C23CAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CDF4D5B9;
	Wed, 20 Dec 2023 23:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJNijnIQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8024C3D6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7b7fdde8b54so8829139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 15:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703116512; x=1703721312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uCBYuSyv1htu4Z4UMY79JiCUyFE6xNOmu0NfxL7CL1o=;
        b=lJNijnIQqt6zUOSl4xal2gPN3JSGaAbShE86eaxXK1s+pzdkYO0ADji40tV9EEDyhB
         cbggHELnV5v2dCBlhDHg59hxqkWBMYigXmnoBJ35sFb6X5zqS2ywNsOeRDarxXec7355
         qBIoEaeYpAZ2TijzBss38xJOkYZWAmiR1NxME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703116512; x=1703721312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCBYuSyv1htu4Z4UMY79JiCUyFE6xNOmu0NfxL7CL1o=;
        b=FLzDrhEdHvgI0HJfhExkLCkBUufBjo40onjX83R3Dql/iiPijTTEQhEayn3XyfU1kD
         Vv5wvtfq9dP2wfOGXIdS0FQRyl2y8WYuqYADmwo0lkM9loCVKZ/Fa0oDEjY+zTU2Svm7
         5ZTYOaC7o3e2e9X6rPHYyySUHeuZHyVSaVnirk76mA1x72mpw9H73liGDcmYPPjeAg62
         Uan/S7hoVJcwQJqFdYSg2ek+BuVflWn2baNn2MhxJ/yo6CWT4eI7g5jQikT7lLoL8fGD
         ddK7k53KWDB5rPIyGVNomhrItckFB8SaPifZ5KDPsprpinJ4ORoQWBJ+G+/7V1Akvv0D
         ERJw==
X-Gm-Message-State: AOJu0Yyl0k2g7l2r8i5E+WFSCBmjGmIiRQuqJsVkmN4Hts6imyI936ur
	OYvk7OtYjCEOo4ifrY4useg0q6hQuyeKiw4TgEs=
X-Google-Smtp-Source: AGHT+IHSg3mJJWavfesm2hpmBZ0S+/Z6QyumQes9iV9E7AinPPpe4ysdoPMdMc1c/Ob/o7mRjGp4Kg==
X-Received: by 2002:a6b:c8c8:0:b0:7b7:f971:8e75 with SMTP id y191-20020a6bc8c8000000b007b7f9718e75mr3226475iof.12.1703116512588;
        Wed, 20 Dec 2023 15:55:12 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bp22-20020a056638441600b0046b39a6f404sm177805jab.17.2023.12.20.15.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:55:12 -0800 (PST)
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
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 05/22] ARM: dts: rockchip: rk3288: Enable cros-ec-spi as wake source
Date: Wed, 20 Dec 2023 16:54:19 -0700
Message-ID: <20231220165423.v2.5.I8249df4df0b7d12fb68ea1e69f84ca589c574bb1@changeid>
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

 arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
index 092316be67f74..1554fe36e60fe 100644
--- a/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288-veyron-chromebook.dtsi
@@ -112,6 +112,7 @@ cros_ec: ec@0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&ec_int>;
 		spi-max-frequency = <3000000>;
+		wakeup-source;
 
 		i2c_tunnel: i2c-tunnel {
 			compatible = "google,cros-ec-i2c-tunnel";
-- 
2.43.0.472.g3155946c3a-goog


