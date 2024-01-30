Return-Path: <linux-kernel+bounces-44583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09220842483
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365D21C24065
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734306A330;
	Tue, 30 Jan 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="QhF49jlT"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D916A32F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706616526; cv=none; b=jKI2KzBVJRkX1rdJePPYVbMIfukeMQ6rPWDPTb6SIZer+VVti1/Or0H4gmtJ+sUHMTJvXgigXH5YBRttuDMgV+rQ8LN10m66IZeaNUK4WCHvuGLpiWaSbRmh6TaOyj4Uuxhw7LzcTqE/qYb1um5+RPsQTZlk/SJNkCtmr4n489Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706616526; c=relaxed/simple;
	bh=zDcAbkLItqPMxxfP3aRTCDFDYSoc9GjSDeC3F04oer0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erOYCCjK2vrMb0NjUZlsP40ODsvy7wCifJbcNKdsKvTrM1M6TTxXl8F18OuiymmgQZpro8yZgmXMQlDh1xASTg6C7k4vEIdegFELSZL5VH3fQcnuZRwd2wGCakCajsj50Pk2t1JrPJk0aMNev2wroeMVbYXhofXCtyGwAP/0ZmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=QhF49jlT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a271a28aeb4so475491766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1706616523; x=1707221323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=In0D55Mdq6WXKilN4JPLmFe9w0y3bSsay5sRffELyd0=;
        b=QhF49jlTP4HyP1Aa5qS0zvUUoigbQqkg/0Lg2F8+7UYD0tGrU9GxoNOuiTTCujhc8g
         +9nmxj6rA1CHZhTzagCl2xNqBy3PwpQ39+lRdqtYsgtSsAka8JKAeeU6iR3Ym47ZqidO
         6bu72f45bns/XS6xWz1DxxvgEuViFBo3xblZj0jNBxA0lW4zk7Vm013XOUQAcqduvJP9
         xGWLAJm8JnIige/2OY3K1+XgQxYdGS9pVHIZjuRd4GfxiW4TZaTCMlqkrfx3ezwZF7rw
         FS3NkfAW3sYdV/pdpVOvAbC+I4/Cka9hJG/cr41FLsvXGLr3iMhPHkWurtVSaGPo2nzR
         sl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706616523; x=1707221323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=In0D55Mdq6WXKilN4JPLmFe9w0y3bSsay5sRffELyd0=;
        b=qhSVUlNr6nEJaCsyeYLy6xzNYlk9v8DdIpFerieBLe0WNbpFMjSNpnyfLdHi2ocf3E
         +FV5nA4nMM5sa3ssqJT+3iWlCKbA7lbEGcNUOsbTAuXyx5Pi1v15GosQCYrKjvP+zz0r
         D2+VGUTVHp9kI8YrRh6KFifbjLRxu05eoq76mM7M420YTX9IsVlpLPzpxtO1HEakn6dP
         /afxYRjEzl8w8CKJOs3KCnlK0veNzMfXLHqpnhaGnRhzNVPxMD6f3CLs2K4zFyM7dAlb
         HJfkjt7YOUz8i2EW1Vxj6oBJWaweI4ddNbTUo1f74pGrl4kJRNKFd4kz/SAV1aiZI7fb
         92Mg==
X-Gm-Message-State: AOJu0YwT6AnDCf3PDGuYJhqUdic++v/cPHy3kzcyXNuM2EDObrSZ1t6Y
	7JBv3P91hzObCZ9cffys6m4btzneWAIxc1VHopZGDjXNir4enO2yZ//RuL5Rd/4=
X-Google-Smtp-Source: AGHT+IFu1x2NO+wOXcim/9FpMa2Nl7kBu7CCXr4K65rQBZKR8gTlcepFpx4upRKOpR9sz4mFwIAZRg==
X-Received: by 2002:a17:906:1c50:b0:a35:7438:113d with SMTP id l16-20020a1709061c5000b00a357438113dmr5415571ejg.27.1706616523224;
        Tue, 30 Jan 2024 04:08:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVVEfzifHvj6OKtuasaqW26a+xizwHZ3E8WMl3oLvw9q1sUgyPHCdTkUDaULnVKunGgFNz/wLhqddeFP/eDAs3/mjn3Ic33YTcJn/e4D2ZQL1QzT9Z0LokBbUfnNIMnJP9k9OTY40OpG8vw4LaBdCx16q0ikCYUp+xxRafwqPa5s51hnlzavQPmRz01D/4p/KbniIVIV0K74NIScTnk3T/OHBSIhkuba23XYHnYHkUH25J2Y/Ux7trcr3NJVhM+EdaQt4pA0XQAlSkWeGUttGpK4h/bw6TIkhksZMwafqp2yS9mPk4R6OuIlJSizShaz+2EQ/RQcMgbEXkc/IU5+BTqKzmnBItij2hmsmCREg==
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id vv9-20020a170907a68900b00a354a5d2c39sm3751242ejc.31.2024.01.30.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 04:08:42 -0800 (PST)
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
Subject: [PATCH v2] dt-bindings: pinctrl: cy8x95x0: Minor fix & update
Date: Tue, 30 Jan 2024 17:38:06 +0530
Message-ID: <20240130120807.460335-1-naresh.solanki@9elements.com>
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
Rearrange allOf
Update example.

Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
---
 .../bindings/pinctrl/cypress,cy8c95x0.yaml    | 28 +++++++++++++++----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml b/Documentation/devicetree/bindings/pinctrl/cypress,cy8c95x0.yaml
index 7f30ec2f1e54..89ce0cb68834 100644
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
@@ -101,6 +104,9 @@ patternProperties:
 
     additionalProperties: false
 
+allOf:
+  - $ref: pinctrl.yaml#
+
 required:
   - compatible
   - reg
@@ -112,9 +118,6 @@ required:
 
 additionalProperties: false
 
-allOf:
-  - $ref: pinctrl.yaml#
-
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -133,6 +136,21 @@ examples:
         interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-controller;
         vdd-supply = <&p3v3>;
-        gpio-reserved-ranges = <5 1>;
+        gpio-reserved-ranges = <1 2>, <6 1>, <10 1>, <15 1>;
+
+        pinctrl-0 = <&U62160_pins>, <&U62160_ipins>;
+        pinctrl-names = "default";
+        U62160_pins: cfg-pins {
+                        pins = "gp03", "gp16", "gp20", "gp50", "gp51";
+                        function = "gpio";
+                        input-enable;
+                        bias-pull-up;
+        };
+        U62160_ipins: icfg-pins {
+                        pins = "gp04", "gp17", "gp21", "gp52", "gp53";
+                        function = "gpio";
+                        input-enable;
+                        bias-pull-up;
+        };
       };
     };

base-commit: 861c0981648f5b64c86fd028ee622096eb7af05a
-- 
2.42.0


