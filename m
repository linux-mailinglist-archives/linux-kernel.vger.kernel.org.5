Return-Path: <linux-kernel+bounces-60719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8421B8508E0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD3B1F241B6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5675A7A9;
	Sun, 11 Feb 2024 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="ZlutzGl0";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="0PFuMinM"
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF65A4E3;
	Sun, 11 Feb 2024 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650962; cv=pass; b=S5iaXq+waMUoNeI6tC+bFdOzuQmrotdIYysHVygVz4X40GQIeq1N7BLDAEJsMJejFBSYdFSkpo9FySEJezn+GwEvXNFnmj2uvwiNRh81pqAFotchm5vYdsRl+bPaeL3yDJMfrzlpMB8M1IcYDtb1p9IEuyXlryBgaBnIvRccpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650962; c=relaxed/simple;
	bh=tYMdb2LLTRJ2YPUNIoiWFiSTohAhAU9eoI1ncEhCMyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PefYX6sQeIoAthVOOlPw9uz8OIsLGJ2wevsjTzxUItX0PG+wFqoI0A4gqy1QKy8wfyVxCPl6DFMlf21Hm4pHh/tF45vUuh/d3od+jPZl3jtB9e8sq1CeDrtCW2NjGGyoyGwyZDNivpWUQ/wLHCkMwzLNQFN+iK5hfY5zE1Ub354=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net; spf=none smtp.mailfrom=gerhold.net; dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=ZlutzGl0; dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b=0PFuMinM; arc=pass smtp.client-ip=85.215.255.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1707650776; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kOiiCJEmE0TSIOagG9z/d0f5JYdQN04K3eg1VS9ynNnL7bY2vdUOAXQJcLOu1qJhV2
    9CFJS/6LzSBQD/x9rDxLNnve/QUO2RntTVRwNlPLlVFJb8mZmSIanzmOZVI9EkVIdWc2
    3gZLSZ0tdnOVJCAaAmY4Y8gp3bv3p8FgFq/kRbSXe5CDIqHatMjKv8Z1ZeiBp5L5eaLY
    QPafPU4GuzM0r3ozSM0DD8Sngxp0R0KaiseMXCkThZpaM5I4ZVsmeWxUVmooUKi39z3V
    f/DMI1LFeH443J4AmQi9ge+11kChtdRIM02dfYKxiIzZHf//4EG/0wFHmVuGy1yDTnVj
    VD2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dFelX5EHlu+pZ8B6gF/nAN2jUERUrCFzhnmIS9NBoP0=;
    b=HHcyf3yuic6Bp62uBV/XIndriKVnXJoLynHDy+rVw4H9nOHgRL/LUY1qQnfR44uxSx
    1KHieXBohSXCNNnPH3WR3bXA0hwjFxC7Og+ywD5WTUU7M/ophkeMqpqGt7wcfTgdgbpE
    Glh7T1ct7hTrdC2skMu6GpprCs4hoFKXNa5BgMZASEYelhBFNlfTuKkrlAk8IdWhTN/X
    G1sAucY7TuhBW0UK67toqnT0hlwBP9gwHjBY9zCRoA8V45nHt8t9gZTzAmaQl9y8JOTL
    miXZ+LfPnn49HLX3Dn81gMVak0JXDX7iasxIni2TyAAkth81nl+2wmoh2IcvQBG876n5
    QpfQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dFelX5EHlu+pZ8B6gF/nAN2jUERUrCFzhnmIS9NBoP0=;
    b=ZlutzGl0zwneklmSSeL28p0KFjVLApBaTFcfzEK4U4AqYy7bcxui3q7RFSiO6zDn1B
    ixzBG2Ho77wXuYQ9yYujDzZI4wx11sjjX4x7tzjc4Qe9Gb03LxkFxBKReWPEqbM7TYai
    95qZv4DLAGjKNSgfnNRL3dZt3Ck+xzHJdLXikuQrItrjIPfHFb7DrTVait9XgRTflsk1
    P+GJ/Pi3RN+AFDeogoHarAICX8gYRzaXIu/WOiffb/+pD1Hnwcymar0/Q8A1uz9Xaa3/
    nDwS2RYr1YR6iNOFqrl+hxdvHbwOqU2cQZjvyQ8YuuohL2JSt1bUL+DPw8GtwvH2MPOn
    U7Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1707650776;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=dFelX5EHlu+pZ8B6gF/nAN2jUERUrCFzhnmIS9NBoP0=;
    b=0PFuMinM4KxoD7PNY7+WdUDXFmdccYlMQlnJlsoyyj5sPO946cByF0AkSReXLqTjcV
    RFn3ACkKh81lOt5OPaAQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p3mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.11.2 DYNA|AUTH)
    with ESMTPSA id ze34f101BBQGwzt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 11 Feb 2024 12:26:16 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
Date: Sun, 11 Feb 2024 12:25:50 +0100
Subject: [PATCH RESEND v3 1/2] dt-bindings: input: touchscreen: document
 Himax HX852x(ES)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240211-hx852x-v3-1-f682e2fcf11d@gerhold.net>
References: <20240211-hx852x-v3-0-f682e2fcf11d@gerhold.net>
In-Reply-To: <20240211-hx852x-v3-0-f682e2fcf11d@gerhold.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, 
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff LaBundy <jeff@labundy.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Jonathan Albrieux <jonathan.albrieux@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4

Himax HX852x(ES) is a touch panel controller with optional support
for capacitive touch keys.

Unfortunately, the model naming is quite unclear and confusing. There
seems to be a distinction between models (e.g. HX8526) and the "series"
suffix (e.g. -A, -B, -C, -D, -E, -ES). But this doesn't seem to be
applied very consistently because e.g. HX8527-E(44) actually seems to
belong to the -ES series.

The compatible consists of the actual part number followed by the
"series" as fallback compatible. Typically only the latter will be
interesting for drivers as there is no relevant difference on the
driver side.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/input/touchscreen/himax,hx852es.yaml  | 81 ++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml b/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
new file mode 100644
index 000000000000..40a60880111d
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/himax,hx852es.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/himax,hx852es.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX852x(ES) touch panel controller
+
+maintainers:
+  - Stephan Gerhold <stephan@gerhold.net>
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - himax,hx8525e
+          - himax,hx8526e
+          - himax,hx8527e
+      - const: himax,hx852es
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Touch Screen Interrupt (TSIX), active low
+
+  reset-gpios:
+    maxItems: 1
+    description: External Reset (XRES), active low
+
+  vcca-supply:
+    description: Analog power supply (VCCA)
+
+  vccd-supply:
+    description: Digital power supply (VCCD)
+
+  touchscreen-inverted-x: true
+  touchscreen-inverted-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-swapped-x-y: true
+
+  linux,keycodes:
+    minItems: 1
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@48 {
+        compatible = "himax,hx8527e", "himax,hx852es";
+        reg = <0x48>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+        reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+        vcca-supply = <&reg_ts_vcca>;
+        vccd-supply = <&pm8916_l6>;
+        linux,keycodes = <KEY_BACK KEY_HOMEPAGE KEY_APPSELECT>;
+      };
+    };
+
+...

-- 
2.43.1


