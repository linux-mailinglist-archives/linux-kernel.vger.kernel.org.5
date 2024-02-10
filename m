Return-Path: <linux-kernel+bounces-60319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6E850322
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2350D286166
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8087C3B780;
	Sat, 10 Feb 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NJeVySfl"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950813A8EA
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707549004; cv=none; b=KgJif7t4zas8/DolCeMly9ILsIBW5PW43q83kLL1MlbEIGLmCB4TEFiRRpdh6NJHu5eVDOYshKuxE9nKYo6kY8FRk55LVQiUByIK/yn1PJJ8waukEwF99OVLR0zAuHnI/D/UJckW7/VOepnz2GB6lpxJSC4Omj5M0EQEjFImI1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707549004; c=relaxed/simple;
	bh=KWg4agLN18znoG2Iygxv4/gRG3/yzkv60PQlSKgj+cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHKIe6bsmssmCsEcN12bvTQZS0Qd8wR5u0EJvZqf++BMOaVBDhFivkm2bwtFprNFKDYZG19Spg/ka3SOD38ppoMCgN/nM7JSjl+iSL7f1+02csxpNQxSyUePMhv1NN2Ac+XxyT9XWp5za+/92Jw+yhpLQ6upqwcqtEBQcpKu/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NJeVySfl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3bbbc6bcc78so1193402b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707549002; x=1708153802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDKP545ncIGfTtTSVlBXDPYZUg/LkNBLMZfBasJozE4=;
        b=NJeVySflWRDpHnw3WR2V4zfwxfb1J6kJA24de80XtS7OuPgKedrvRgyYalYc1nrrC4
         4BQzvcrJSHw/x7+QzGfBazRpfGsT9O7wIApCSbALbaPvV36FPguAgudQAEVaPRiSCaMN
         geHgz3BxuW5+MpXo71rQPSPKfgo9G5UyZEUqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707549002; x=1708153802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDKP545ncIGfTtTSVlBXDPYZUg/LkNBLMZfBasJozE4=;
        b=VaI0ZA1d0a6w+C2tDl6FiIqakAVad/gqgEqwp5u21VF2+3P6yX5nked5B00ZmARKcW
         k43MNukWyIGUY4Hj599Id6ahsDpvJHhq8b6eN1HALe7FVvIlOgAZY+i7X1Uy7h6nJaZg
         313OX9waxElL2GFcnsmcCIUVNM09QuUHf6CFzXVjlnD1AUrL2d+JSSgUniE9zZjhLFHv
         69jd3n9xw5eed3km6XgZLfEa5bK9+3kbUFwO/R8PYhrJy+ajjOyX3vTyZ4HQ4gxLbUO6
         LmVe588efqHRXBF4qLvgtePfcsACFY9AZmTWCkCV6+kPryy/nLPq/oonOJ+LVa2fJj0A
         34cg==
X-Gm-Message-State: AOJu0Yz3Sh0v0+TzahZTId4gv4G/XUHg8ST3IE2uHWlX1pTx2gAP51Qm
	XSczaDky8dV57ShNDpnrLnWhc0XV9gIZSZivoTgDTZ1788u7ksjlR1X4h3ajFg==
X-Google-Smtp-Source: AGHT+IHfhNbINEK47mtM27Xc5vDyW74i+uZgmEoJwD3UJ6z8ChV5NU+V1lHowi8SgTL6HxzPAHmg2g==
X-Received: by 2002:a05:6808:1988:b0:3bf:f0a8:cb2 with SMTP id bj8-20020a056808198800b003bff0a80cb2mr1400608oib.37.1707549001771;
        Fri, 09 Feb 2024 23:10:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2HrdVmLOcw4Sf/frtnmvY4PJIlX3jT5jll7lFNna1Fpso9xTbdH9rvhiDq6GKPHHy1tZP4nw+5TDy7xMM/ogtsU1SgxEzFe0tDscca19xhkYhiPP6/KxaZgNxED4kb45lZugMR1ueAcwlz73PlvoNVig+xlqg15ALJbOr24kaaMtk0JYVNbP2Bjh74jvcp/MQW8OqL3U+PxPXPx2XWt6f/aCwTpSDDSWlQlg+n5HEMAjSkyX1cXYupkVHBkqGYIE2xV0/cRdSfMTVX7W+S8Y9q1iB4OFy4BcyqIJrxmvu3X2zbPyXxtBBCYeid94cWjS+Jx2IRX/YwbEBBPTNgro10RnVy6XEswrD/FgV2RoWFpccIW2m76rNfVu31Pndn7Vr6pBD244bFKBBWVx8nh/0pEXtzYyqbKkyzItyMaiM5hMJEGV+f8+/O7FuWJzi3bCVO5qE3cASR9QgC6wGqN+KFRKFwh05svoB8WAvy9WayFj+Bv8z7BUa/G6m1m7BbjrMSg7np2qG
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id b18-20020aa78712000000b006dfbecb5027sm1687313pfo.171.2024.02.09.23.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:10:01 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 13/22] dt-bindings: chrome: Add google,cros-ec-typec-switch binding
Date: Fri,  9 Feb 2024 23:09:24 -0800
Message-ID: <20240210070934.2549994-14-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a binding for the USB type-c switch controls found on some ChromeOS
Embedded Controllers (ECs). When this device is a mode switch, it takes
one DisplayPort (DP) port as input and some number (possibly zero) of
USB SuperSpeed ports (bundles of USB SS lanes) as input, and muxes those
lanes into USB type-c SuperSpeed lanes suitable for the SSTRX1/2 pins on
a usb-c-connector. When this device is an orientation switch, it
redirects the DP lanes to the proper USB type-c SSTRX lanes.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Lee Jones <lee@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: <chrome-platform@lists.linux.dev>
Cc: Pin-yen Lin <treapking@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../chrome/google,cros-ec-typec-switch.yaml   | 365 ++++++++++++++++++
 .../bindings/mfd/google,cros-ec.yaml          |   5 +
 2 files changed, 370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
new file mode 100644
index 000000000000..17a0ba928f5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec-switch.yaml
@@ -0,0 +1,365 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/chrome/google,cros-ec-typec-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Google Chrome OS EC(Embedded Controller) USB Type C Switch
+
+maintainers:
+  - Benson Leung <bleung@chromium.org>
+  - Prashant Malani <pmalani@chromium.org>
+  - Stephen Boyd <swboyd@chromium.org>
+
+description:
+  Chrome OS devices have an Embedded Controller(EC) which has access to USB
+  Type C switching. This node is intended to allow the OS to control Type C
+  signal muxing for USB-C orientation and alternate modes. The node for this
+  device should be under a cros-ec node like google,cros-ec-spi.
+
+properties:
+  compatible:
+    const: google,cros-ec-typec-switch
+
+  mode-switch:
+    description: Indicates this device controls altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Indicates this device controls orientation switching
+    type: boolean
+
+  mux-gpios:
+    description: GPIOs indicating which way the DP mux is steered
+
+  no-hpd:
+    description: Indicates this device doesn't signal HPD for DisplayPort
+    type: boolean
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        description: Input port to receive DisplayPort (DP) data
+        unevaluatedProperties: false
+
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: DisplayPort data
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical DP data lane indexes
+                  - 0 is DP ML0 lane
+                  - 1 is DP ML1 lane
+                  - 2 is DP ML2 lane
+                  - 3 is DP ML3 lane
+                oneOf:
+                  - items:
+                      - const: 0
+                      - const: 1
+                  - items:
+                      - const: 0
+                      - const: 1
+                      - const: 2
+                      - const: 3
+
+        required:
+          - endpoint@0
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Input port to receive USB SuperSpeed (SS) data
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: USB SS data
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/properties/endpoint
+            description: USB SS data
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+
+      port@2:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description:
+          Output port for USB-C data
+        properties:
+          endpoint@0:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@1:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 1st type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@2:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 2nd type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@3:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 3rd type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@4:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 4th type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@5:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 5th type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@6:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 6th type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+          endpoint@7:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            description: USB-C data for EC's 7th type-c port
+            unevaluatedProperties: false
+            properties:
+              data-lanes:
+                $ref: /schemas/types.yaml#/definitions/uint32-array
+                description: |
+                  An array of physical USB-C data lane indexes.
+                  - 0 is SSRX1 lane
+                  - 1 is SSTX1 lane
+                  - 2 is SSTX2 lane
+                  - 3 is SSRX2 lane
+                minItems: 4
+                maxItems: 4
+                items:
+                  maximum: 3
+
+        anyOf:
+          - required:
+              - endpoint@0
+          - required:
+              - endpoint@1
+          - required:
+              - endpoint@2
+          - required:
+              - endpoint@3
+          - required:
+              - endpoint@4
+          - required:
+              - endpoint@5
+          - required:
+              - endpoint@6
+          - required:
+              - endpoint@7
+
+    required:
+      - port@2
+    anyOf:
+      - required:
+          - port@0
+      - required:
+          - port@1
+
+required:
+  - compatible
+  - ports
+
+allOf:
+  - if:
+      properties:
+        no-hpd: true
+      required:
+        - no-hpd
+    then:
+      properties:
+        ports:
+          required:
+            - port@0
+  - if:
+      properties:
+        mode-switch: true
+      required:
+        - mode-switch
+    then:
+      properties:
+        ports:
+          required:
+            - port@0
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      cros_ec: ec@0 {
+        compatible = "google,cros-ec-spi";
+        reg = <0>;
+        interrupts = <35 0>;
+
+        typec-switch {
+          compatible = "google,cros-ec-typec-switch";
+          mode-switch;
+          orientation-switch;
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+              dp_in: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dp_phy>;
+                data-lanes = <0 1>;
+              };
+            };
+
+            port@1 {
+              reg = <1>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              usb_in_0: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&usb_ss_0_out>;
+              };
+
+              usb_in_1: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&usb_ss_1_out>;
+              };
+            };
+
+            port@2 {
+              reg = <2>;
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              cros_typec_c0_ss: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&usb_c0_ss>;
+              };
+
+              cros_typec_c1_ss: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&usb_c1_ss>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index ded396b28fba..563c51a4a39c 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -164,6 +164,10 @@ patternProperties:
     type: object
     $ref: /schemas/extcon/extcon-usbc-cros-ec.yaml#
 
+  "^typec-switch[0-9]*$":
+    type: object
+    $ref: /schemas/chrome/google,cros-ec-typec-switch.yaml#
+
 required:
   - compatible
 
@@ -227,6 +231,7 @@ allOf:
         "^i2c-tunnel[0-9]*$": false
         "^regulator@[0-9]+$": false
         "^extcon[0-9]*$": false
+        "^typec-switch[0-9]*$": false
 
       # Using additionalProperties: false here and
       # listing true properties doesn't work
-- 
https://chromeos.dev


