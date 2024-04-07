Return-Path: <linux-kernel+bounces-134334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678FA89B070
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFBEC2828DC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7534208B4;
	Sun,  7 Apr 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fb1/aDeu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A0E14294
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485743; cv=none; b=QitYn//8X3FSGd8/uXpcnRGgbxVbQzYMJMdl15f1wLhmCEv9MrCUo+g2bxEEIM20TdfKJZqcZ6Uf5wwAIR1Blo7Ew1oPQS5HsCZwX/X4waT7kw8ECfr6ggJSrVK5izJiw5O91xFkCLLGEw/YwKj6njJ4N5BJJuLmmQ4kWhYjTYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485743; c=relaxed/simple;
	bh=lQSPSVetvPUWxqut0QR2546+506zoTsrYKJlCjIjThk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CCrPjF371ENNQFyK3DHsGab7pqlAwVoN2SxeejVj1cfc5rV1eopx9rKW41jkv+QIlEyd/zam80T3B7yD837bXCOI+Rxm5Ts3hEfCrAwsdXCmcc1KVbD0IQUW0cTz14LrC7mUrkhqXyrjvCMtoxxuEzVUp96LzZ5WkjUZklnyfOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fb1/aDeu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41551500a7eso29008125e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712485740; x=1713090540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taxHWKaZxjJsfBMATKjyb5DNf/BYQaehkgsorzItAt4=;
        b=fb1/aDeuurAQbbxEloCJRGiayQAF2OpXIFkFZRFCqtcLcy5R4h/4K2ru4R7jff2yEb
         fwGYQgYBnTF9p+6+cU3nIChZh6gcOFBlqwfvEyTEVOi8g0F/kpyb9YlqGt++fbVFTqLg
         JVRJoT5nvz0yDLxdfnuXuUx45r3WpvXPwWgz3bxDokjH0x3FbQRbAKvyAEyledOhxTx6
         xwIhG0f6EIYeoPDuDp1zq4bwRNNgBbjpf9X1OUCrJRt9d85XjZBJ/acK/sl7fpfIzRne
         YIdRYDffzXhX6kgtQARaPyM1QLt3/Iox74Fp0sftXjcDnPVvlTRpOxhtYhk0uOyVEZZl
         GUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712485740; x=1713090540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taxHWKaZxjJsfBMATKjyb5DNf/BYQaehkgsorzItAt4=;
        b=OQW8YikpaXciVK3gltqTROxf3n43xJuo4EkioDprJHyFA4D2x9otttYbXFp5eFb5NE
         hJMTMSI12/NdufIUmIrYpSYTbZ1fGeHgbjlDQf35EslrQFgk/Lc3F2eE7Y4cR6gIkoYy
         bDej6lrv/PbzdnXA1+hpLtAO5AMFlpf1dcn6xc3JkS6XzTQbxvKxGALW5sri+6TMwaoQ
         XnNJVM0eWP1KDNZOZ9EKReVGf/vSGWAs7xDjP0iDpc2EfLH35Rd8oDxtrl8JRsqoUhit
         WjUbSzXgmEiJKgQAo9d0Citi0omTe+vaY8EMwh6zZ8E447mQbIO4H8jURyDAeS9Hu422
         oIOg==
X-Forwarded-Encrypted: i=1; AJvYcCVvQUfaIW5X4Je5JZTYOOHtsWuQAEH89VyqICgXU+jJCsFy14GqTJtuPNPP4x3gkYhe1oVj25p1sA3PoG/FhrwndMwMGBppOSTdjU21
X-Gm-Message-State: AOJu0YyAGYZKtVVRhJvqlLX+b0UrEnEPlt//+suomIvGXiwN31N072Ty
	WM3Me5RELx8CdD4Qm6Xa7cxWC8avkev9vkcKpnGnEqLx7UU5aiLIkycJ6c7BowM=
X-Google-Smtp-Source: AGHT+IE62JsWsWYbi5WeTviefWU7yFrxeoYcfdIRR5xOpUJ3VUr3HoKK/FWNUdVFckfiAQMv2PaGAw==
X-Received: by 2002:a05:600c:5021:b0:416:5508:256e with SMTP id n33-20020a05600c502100b004165508256emr990278wmr.22.1712485739876;
        Sun, 07 Apr 2024 03:28:59 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b00416665d3e09sm675487wms.9.2024.04.07.03.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:28:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] arm64: dts: rockchip: drop redundant bus-scan-delay-ms in Pinebook
Date: Sun,  7 Apr 2024 12:28:52 +0200
Message-Id: <20240407102854.38672-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
References: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no "bus-scan-delay-ms" property in the PCI bindings or Linux
driver, so assume this was copied from downstream.  This fixes
dtbs_check warning:

  rk3399-pinebook-pro.dtb: pcie@f8000000: Unevaluated properties are not allowed ('bus-scan-delay-ms' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 054c6a4d1a45..294eb2de263d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -779,7 +779,6 @@ &pcie_phy {
 };
 
 &pcie0 {
-	bus-scan-delay-ms = <1000>;
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
 	pinctrl-names = "default";
-- 
2.34.1


