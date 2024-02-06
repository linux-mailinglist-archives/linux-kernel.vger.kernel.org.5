Return-Path: <linux-kernel+bounces-54765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8BF84B36C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8101F22928
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54C12E1D8;
	Tue,  6 Feb 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Qz184yDn"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E5312EBEE
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218709; cv=none; b=GkepILfUGeLVBgO9T8PkoC0EWFu97qrjkkQOivjIvVh6iNbYm4WFSI+yDvF0iGbtj+3AiNUBvcgwoGIbdC0S68sDfH0una0vh+x8nHeezpt82AO6WNFCeh6+wibnlY/AO8OdWYTJNE0MdJ7dSffmBhF6TIR3jQiOmQNBN9LYbwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218709; c=relaxed/simple;
	bh=D5rY55ZVWa2j3iyWooQtIR56A7LxQVE5Z7VzvJRN4f4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S7yHiowlr/G7bAB/lNJLsyxlvyiVWts0OJvaSlXp9CvwRI8IJ7uDU+Se4W1SNp96UGIiLr58Nmj2Wj7IBFUkWIpfi5yVvU76ZLesTomK1g269HjIhy6NKOJMyToYHjwu3OR5u403R7Wew+5Xo5tWyOFtcu/ayTXGo2RnYsM8vpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Qz184yDn; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fe6c66c3fso3040605e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 03:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1707218705; x=1707823505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdUPrvm3uK6fsu9NtDUXaLyCVRtgeDGLH0MFBS15pl0=;
        b=Qz184yDn2eb7d+kEZpFTGcWBYlF+vp14/pHeB//KJb0cmEmY2OMOspAJH5V/KLYtj+
         07cGfoRhZjD2SZtcD3xileqKGioTkdSotQwEKgdJ4Y0Q85SEoyi/G1LyEkyjbxubtnTF
         h2QOZ1K+YMXqpIQT9pyQycg34g4OKi6rYzZLGWrbvGClgwJtmPgDDjjTKsesrIlbwSdA
         6b47mWZebLQI9UKwN//zpmGwVMevooC1s/chjylvC+ltQgCKYdHd9MWH5u6CSeWawX8y
         Shd3tBM7pI+zB8QTY/bDEViKYX31ue4wONiEGLuvs/MGK0fwQkmc/4EOYmzEqt+4VUn2
         mErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218705; x=1707823505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdUPrvm3uK6fsu9NtDUXaLyCVRtgeDGLH0MFBS15pl0=;
        b=btStJjYLPL/sUHjejM95GleWU6+uDK7LeIKNx4jmeSt4yHN6MHCyqvEbCJVd9EnN6f
         SLFeu96idS9Y6YKShc9/OSDMZhNLXsQB6YNc/GBCBNs08ClBdlO7B1sKTPc7nFHkCPhX
         +0ZSNjc9Dp+q8dCjMqEPBRQhwzKTHrquVsDrvp9vJ+9Yu5+EB+dZXXgMM2barT7ZXdTr
         FmUDHp6AfHMcGM5+LPWWuU7VoQfoSIctHO5ZlHyXKVOi+iprWVSxCCg73JAqyoE9rsaW
         pT2LRGXhz6mZgMEf1wYOE3RiAvwxJmYVds9u+WvxhOzO2sO7CnseU1p4PSnksu8alfqI
         FTGw==
X-Gm-Message-State: AOJu0YwT0tYzH4zwVbAv9OiVdsetd7ZvhfYGPspSLzNOV5HemXv7oQF4
	Uv3ZplN50+wruAI8rYCfkXXJT2ERbxt9VbTwdX0uYsdAcAXlidaZw+M5KRgg938=
X-Google-Smtp-Source: AGHT+IHAfLd1SsZ3eD1799NyVZHe7CLAsRsTG1bGXZeAQhXx338yJxeK9+8buYf+hpejikQwSQS3rQ==
X-Received: by 2002:a05:600c:5491:b0:40e:5933:e2c2 with SMTP id iv17-20020a05600c549100b0040e5933e2c2mr1560002wmb.19.1707218705549;
        Tue, 06 Feb 2024 03:25:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxFLdsCp31yGWcmf7bnv5ZnLkRhC0gMfcFF8fPTMsYMYojULrN7KLTt6zygmzBRYB+KRDoXItvc8Jr/ZC61GgiTcVCNjUlbpCp166JkYZhLZWQlwPWzAr/bLUneFUjQ/QMcW/shiWgqWDZ77OrES3PTrNrCqnxSdYqwphNfYKOdoNlJDgc/9YCUseOqZjiNLbRBaCABklZLDL2Z6FWajnZ2CXSev3k3JTvIM+9ivw2A89A2gsJRiasjuHiCs8tvWTwQYfF6RTEKWbubEwE/Xojk/kg+wGcAa6EOH6ww8YGBVT9kBUuMeWBkMiKenH4yRY0VPfcSfLArRnqd+rcFtjjqi64XRBO/tOoyH6Sag==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c458c00b0040efd192a95sm1725010wmo.1.2024.02.06.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:25:05 -0800 (PST)
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
Subject: [PATCH v4] dt-bindings: pinctrl: cy8c95x0: Update gpio-reserved-ranges
Date: Tue,  6 Feb 2024 16:55:01 +0530
Message-ID: <20240206112501.715042-1-naresh.solanki@9elements.com>
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
Also update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
index 7f30ec2f1e54..700ac86c26b6 100644
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
@@ -133,6 +136,23 @@ examples:
         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-controller;
         vdd-supply = <&p3v3>;
-        gpio-reserved-ranges = <5 1>;
+        gpio-reserved-ranges = <1 2>, <6 1>, <10 1>, <15 1>;
+
+        pinctrl-0 = <&U62160_pins>, <&U62160_ipins>;
+        pinctrl-names = "default";
+
+        U62160_pins: cfg-pins {
+          pins = "gp03", "gp16", "gp20", "gp50", "gp51";
+          function = "gpio";
+          input-enable;
+          bias-pull-up;
+        };
+
+        U62160_ipins: icfg-pins {
+          pins = "gp04", "gp17", "gp21", "gp52", "gp53";
+          function = "gpio";
+          input-enable;
+          bias-pull-up;
+        };
       };
     };

base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
-- 
2.42.0


