Return-Path: <linux-kernel+bounces-14830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB48222FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE47A281062
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE0179A6;
	Tue,  2 Jan 2024 21:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXTEKLe7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12317726
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 21:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7baa8da5692so421989739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 13:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704229728; x=1704834528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5uC/dqzQmYcBPDfBK6LehJHA1Nu9NUaC8OommBsuso=;
        b=fXTEKLe7q71mJsF+Dq10I3kngM4DFvGhqoxx//hTAim9J3VvhgQd4W/CiK4EUo7+Af
         uK8PO27JvkAxve0otUSqSKXT1YNZKQzNw8P788roY0qn05/S1OcWuW6AAHJPIVeiIUHb
         N4T8zQhbcNYrU/mfKq2Kf4JTp1/S8JwdyzYLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704229728; x=1704834528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5uC/dqzQmYcBPDfBK6LehJHA1Nu9NUaC8OommBsuso=;
        b=kDhqxO2D6CfAc+/5cT+8kZTFb/5qc/eKZNy7Ns35l8uOEtzVmeenmNh+mEFT+8bAGc
         Qwj+bMv4MJhu19sd9Cfepnv4H0g48wE7MCOvuT9z1PAkTUek9zf97F/1oVo0rI197P5f
         HqSAqq4P1KaTMNrstzMnapLikurlENFphCEy5QXuY8bC2ZcJF9Iqy+tOIw+Ws7pSx9bG
         U6hugddZ+VReMGuWcx+6UFiHhbrHNeiaQNv71uET6pdV3bkPR4s/R8a8JEB+Ce+bLaze
         cPZkjK/2ub9RfmGtWqIEXlDOmGda5BBDnJw7pL5LWj12XD4MsMVcsElu4ub9qcAv0b2f
         1SvQ==
X-Gm-Message-State: AOJu0Yw6X0Bmh/jtf88798lIAdQARK4bRrcB493cToUjogbnuVIO8i9G
	TvpwF7z6hlnOBthmx6orhC9YzqVSWIY409bjFw8PIrxpGJLz
X-Google-Smtp-Source: AGHT+IHWKoCxJRGKNJPcLHrsAhYdGs8ek7DpUdoZoMbtH5+b3OOlyzYczn2NyfouKVIhZZpmVYFcgQ==
X-Received: by 2002:a5d:8d84:0:b0:7bb:40db:9a47 with SMTP id b4-20020a5d8d84000000b007bb40db9a47mr8538555ioj.34.1704229728788;
        Tue, 02 Jan 2024 13:08:48 -0800 (PST)
Received: from markhas1.lan (71-218-50-136.hlrn.qwest.net. [71.218.50.136])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056638439200b0046993034c91sm6956978jab.77.2024.01.02.13.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 13:08:48 -0800 (PST)
From: Mark Hasemeyer <markhas@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
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
Subject: [PATCH v4 06/24] ARM: dts: rockchip: rk3288: Enable cros-ec-spi as wake source
Date: Tue,  2 Jan 2024 14:07:30 -0700
Message-ID: <20240102140734.v4.6.I8249df4df0b7d12fb68ea1e69f84ca589c574bb1@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20240102210820.2604667-1-markhas@chromium.org>
References: <20240102210820.2604667-1-markhas@chromium.org>
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

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

(no changes since v3)

Changes in v3:
-Update commit message to provide details of the motivation behind the
change

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


