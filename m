Return-Path: <linux-kernel+bounces-44656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801AF842590
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC85F1F2E746
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672E6A346;
	Tue, 30 Jan 2024 12:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="fXz9y118"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3B46A329
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619370; cv=none; b=hvMzUDUwXhbJppNKOP61zYIi96dhi82zl5/udkwE90ugCSQf3pxNkIiO9BXlpKhFWw049zsxPwc/53l9OkIS7K6iWzcuDAnXPdq7mriGtELc+3aVjTYHHce1X7mkZvjN7kMz0XVjXMrYtXiDk6Fm8IdnAudh/x1vK2rE/7OfQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619370; c=relaxed/simple;
	bh=M4XsD2YqgFaHUtkGgYzJicc7rP4UsBxaptjLYNfjVQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5SMZ7J5h7YGMI0/C3IFHPSqRvDWdVzXHVsS/8mEqGDoJjEf7bV33F+4q7lByeRSWsxXvRmlpWiZv1f23z0rX56sZfETVignO6qBxV0NgcUwTqGg+6PRCOcDpNJ7NF/UVkTne7m5vr8Lt6sozTe/fgQ9rReLP/VW25PDKIArB8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=fXz9y118; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40fafae5532so2317975e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706619366; x=1707224166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p0WnNI2YK39ATDOg8LAfQTT3VKByFvuowcIiTTw06Xg=;
        b=fXz9y118rwHEV6PDkTe9N6SctY/nUXbGbb78S5VB/mafFn8MyqC9FLAEoxDh9tBn+X
         irGQDFx2EOuFM0LtNqZ1rVk/Uu/FWAqNDWnelr2Fh7FvcX3hS6Rln75gIlNf5hCtZ9Cm
         uh2XWdzhdAZ1sUb8ZGdQ25kuUE2aja1VsRzqGYoxftO6NfWVoUyiyi81iN1APVuTtioX
         UyXa0ns9wO7mxsylKE2Sr2qEV99KEJ9mJhIZU1vhNimJQsAe6O6ARIqt44qkZfTrnXF9
         MKljnU9361/7Gfupes8Fi1p9B2zfZUTyxi0G2aO1FVr3GKw68pFLo35b8bnnHUJzc9wl
         Ph1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619366; x=1707224166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p0WnNI2YK39ATDOg8LAfQTT3VKByFvuowcIiTTw06Xg=;
        b=Gx0QPxPOdNYB09baaa0Y/CE5rQ5PCt4uvktgisfiHrFN7kxRWe0wZ/l58VvvDsNRr5
         ayYn5I6ieeOO65uDCvTn3kdgUZgQkhdo+MeoVqeqRsI8i+glEDadHu3v+3MViHpt8dGt
         THPSVimvpOlMm8Tjn42xg7pLgT758l9WXKJXKf7axDx8i8oIULwaSbrvaCf48r3d0GzT
         b7+++MbLR/9DsCed2tjLpVDdTOk4VK43LaKHVIymEskgsQbCuySfBZEp2t0BRQL2F13g
         EvHDJLcLBAZ/v0GgSuJsTBrVt7MhVIDkwAn4q/D12rYFecrZXe+uWujfFMMmKDzFAbu1
         JepQ==
X-Gm-Message-State: AOJu0Ywxwd2vSbBavyerhdb+oxibL/fAL4tbfHqTwf3qHM6OhbueDA63
	fX3Dm85oieWfie2n/cmDeuJKn2bTsqX32T7rThGTkChrYE/pPXcNhfsgyO0KtDs=
X-Google-Smtp-Source: AGHT+IH5UpEtCHAwYxTDzZEdfbp6IFLtYvDCya77aywlbw0lKIjxQZRgTXhCgWkMmuE25Z5GRCadPg==
X-Received: by 2002:a05:600c:20d3:b0:40e:ac8f:e6c with SMTP id y19-20020a05600c20d300b0040eac8f0e6cmr8306243wmm.30.1706619366322;
        Tue, 30 Jan 2024 04:56:06 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVyZyNtVYjlyE7L+nAo4rZgAuKLYRBzaj3IlcekAWyO/LiZvf5ny7nMfjyJj1/m60akb90sqB9QANITftV/LcRI+BoIaYKb06yYHdXKSas7WnMNedS+QbIbACA8EiS6dUEupHvAK0sRa7o4BFAuPQ1JXb3PeU8k09faxFvmkjPIsvEDEGS/BU6c93nVQfVmnX25nM4Gelpxqhnmyq+PEDAJiWJfeBuBh7bkT+1GsQDN5h1IMbaf1Fn4XXlcQDkIa8rpBPhXkh2CmPWHHEUEtYK3774LRL4cTWBkctoR1lz6sFR+yecM4RYt0Xmq3SOmUiJQdhAVh5uimNy313Qtsty96pR+PCHzdd2fQ/sygg==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b0040ee6ff86f6sm11878125wmb.0.2024.01.30.04.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:56:05 -0800 (PST)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: mazziesaccount@gmail.com,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
Date: Tue, 30 Jan 2024 18:26:01 +0530
Message-ID: <20240130125602.568719-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update maxItems to 60 for gpio-reserved-ranges to allow multiple gpio
reserved ranges.
Add input-enable property to allow configuring a pin as input.
Update example & fix alignment.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 38 ++++++++++++++-----
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
index 7f30ec2f1e54..90dda5d3cc55 100644
--- a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
@@ -45,7 +45,8 @@ properties:
     maxItems: 1
 
   gpio-reserved-ranges:
-    maxItems: 1
+    minItems: 1
+    maxItems: 60
 
   vdd-supply:
     description:
@@ -85,6 +86,8 @@ patternProperties:
 
       bias-disable: true
 
+      input-enable: true
+
       output-high: true
 
       output-low: true
@@ -125,14 +128,29 @@ examples:
       #size-cells = <0>;
 
       pinctrl@20 {
-        compatible = "cypress,cy8c9520";
-        reg = <0x20>;
-        gpio-controller;
-        #gpio-cells = <2>;
-        #interrupt-cells = <2>;
-        interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
-        interrupt-controller;
-        vdd-supply = <&p3v3>;
-        gpio-reserved-ranges = <5 1>;
+          compatible = "cypress,cy8c9520";
+          reg = <0x20>;
+          gpio-controller;
+          #gpio-cells = <2>;
+          #interrupt-cells = <2>;
+          interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
+          interrupt-controller;
+          vdd-supply = <&p3v3>;
+          gpio-reserved-ranges = <1 2>, <6 1>, <10 1>, <15 1>;
+
+          pinctrl-0 = <&U62160_pins>, <&U62160_ipins>;
+          pinctrl-names = "default";
+          U62160_pins: cfg-pins {
+              pins = "gp03", "gp16", "gp20", "gp50", "gp51";
+              function = "gpio";
+              input-enable;
+              bias-pull-up;
+          };
+          U62160_ipins: icfg-pins {
+              pins = "gp04", "gp17", "gp21", "gp52", "gp53";
+              function = "gpio";
+              input-enable;
+              bias-pull-up;
+          };
       };
     };

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


