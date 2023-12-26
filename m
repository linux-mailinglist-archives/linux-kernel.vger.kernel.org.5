Return-Path: <linux-kernel+bounces-11634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B9381E945
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B25282A83
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 19:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B5711192;
	Tue, 26 Dec 2023 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P3pr2sOR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712E10787
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7fe0ae57bso282932639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703618527; x=1704223327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0beT1lRwobeT/udVDQveaOigS7b6fLoDcuD/SsK5GZQ=;
        b=P3pr2sOR9z0/tXAJUanFzFtyCpxX8jbcbdKNQdMmTG63pnUrHJmnd9rcLN/9j4KNrm
         fGXf88rKXmH4Rfw7N0WObjnLgxNWHzedNvqDHWRWEjBkO5vpbAyUBpQDjQeDX2Nm1l49
         ltSzlD1/qd4tCRX4flNFw9NKlkBNryfXG/Rto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703618527; x=1704223327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0beT1lRwobeT/udVDQveaOigS7b6fLoDcuD/SsK5GZQ=;
        b=cEQe+1X6gNY0kHjrujRXRpcpgUUAvHkr4niCIjNq5AjHWpKYjhZ8iHI/sChxcMHtwV
         xyJKPxeCRoA9xE3QtO2fhIXwxztOOPOjFaUYrm8BNXPvEgPL8mhCus2p4zCDYC9YxFIv
         EvWtUccMkz+1pF1vHgsa1HewMawPfqWTcvhM3/CCJIO1beokOX5EMykO99n+kcuTk+WE
         /rjs6SnIO64Z6w8EUpXrmIJEzYXbrdM/8Qd8TbNMc6fTU4ofCzzcA6D+/pr4euVKOOPW
         iaNeee6zdAqA+nCRNKYMwhaANPwNPfOsEF4PXXGbTCROauwgVUFzalzczJeQIXbWFqcH
         17ow==
X-Gm-Message-State: AOJu0YxtEUp6ohEoMC0f14MjMkrctT6LuKhf0LTrFlv0pZ+lFxbCD8QY
	0Ay8cvrxTGbqPSId0lGjwwlnAUEQ3TAhLLSAeJzgLINbnEZw
X-Google-Smtp-Source: AGHT+IGADxqOdqzCrh+kKQobH0CySQymMukyoXwB9KeUWYmRE9fqJHH6xGioz00eswrRyG6LPpu5FQ==
X-Received: by 2002:a6b:5a15:0:b0:7ba:b0d7:20e5 with SMTP id o21-20020a6b5a15000000b007bab0d720e5mr9733427iob.0.1703618527498;
        Tue, 26 Dec 2023 11:22:07 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id gw3-20020a0566381ee300b0046b692e719esm3207609jab.150.2023.12.26.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 11:22:07 -0800 (PST)
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
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 06/24] ARM: dts: rockchip: rk3288: Enable cros-ec-spi as wake source
Date: Tue, 26 Dec 2023 12:21:10 -0700
Message-ID: <20231226122113.v3.6.I8249df4df0b7d12fb68ea1e69f84ca589c574bb1@changeid>
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


