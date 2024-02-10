Return-Path: <linux-kernel+bounces-60309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E4850300
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B67B26026
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2B936B15;
	Sat, 10 Feb 2024 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8Rpmmbt"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65415360BC
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548987; cv=none; b=erCiGttdWAbC99OAKcjr4TTg/b47WsIepCEG397COxbmvjktS8zhIcl2FBstqOejrjB52qTeCT3gSTWPZKOf5cUCyNf9cY9fKlqaYk+SX266Xd+NA8xcTDgdZLDujUWsHFAbBSGBMLfMHZ0hT3pNhlYNX99/Fowl8Rc0ct11JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548987; c=relaxed/simple;
	bh=PeDZQIpv2F0nTTHxmAelufZ+9YaQdvo2eTiG/pHOI/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSe9Sz4nE+fk8FGGcvqkw0GRSDBfdLrNbYs2nOSP8QRYLUsHZRp7Nyrjzz1MH/Er+FjLsHFr6Dk0YHRPpRmXE8qY2qhZtWW7NSEfXXfATAiMP0Vl9zNjdVqVKG65eQVCnsMxNx/y3Ev5AesAuAWtM7Is4gjSOqUnkWavHWJh8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V8Rpmmbt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d7431e702dso15755315ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548985; x=1708153785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UENrcY9RF89XEYAUM3UR0Kbw3cAWGOtKrrlH+rPz1Os=;
        b=V8RpmmbtVgxWHoxqOFc7tENIuYkwazXzg4eidDuBlO8Cq9PtVTk96TkMHZNBHr8LlV
         bEP7G12qkPEmZbzH81YOLuf7qRWq/RQLZpIAQu33wcQq415kvWxBySIQ4uFLKsybJsL9
         e2COkiut7CVrcyNLBGYULG5RSOideCB1ks9Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548985; x=1708153785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UENrcY9RF89XEYAUM3UR0Kbw3cAWGOtKrrlH+rPz1Os=;
        b=BABsPAep65zV4qCFBnMhqv4M1Ne5OkaJdGhouVsICvuv4T4ZD5S69934QDFtcKUKKq
         mlSApwLLeJNYghiBvInVZ4Bc4nZqbgLwTpBlMUdcD/j7JA/Xy5hbJMDnTYscll8OPAU+
         Gssq7blPC7k8O4VIyFseR1qgO1isXBVBLf/uX3H16reUcXj2v3FmZST/TK6pzdbBVhuF
         Blg5BpxuAMNwRXKEskCkXzxZyyVCJbaM67VwaTwtS5STtup6a6ENS/th8pOzcVRoH/IQ
         PS9C1VSUDqiS1PYTKTqSi01huK0T0F76ik0tddgjawa4IvOpcUugnCFzVsqH+PngqvT/
         oN7A==
X-Gm-Message-State: AOJu0YwwP41pMiLtHddSnRGAajoIwp2r5ujs2zkQt1VEL/PsGdQQvVmi
	Za64iIsNtXBGPJwVFu9HtxNQ+aqU0mODkLLcWerT0HdsosmUYT3NN+WyK3gXIA==
X-Google-Smtp-Source: AGHT+IGeYAK8ekxYXXY78qIHAecfdEKLr4g2+PQLKllAtw8+dhESn/vcq+039wpruZ/mWbRUYcdc5Q==
X-Received: by 2002:a17:903:58b:b0:1d9:b789:b1bd with SMTP id jv11-20020a170903058b00b001d9b789b1bdmr1490617plb.9.1707548984724;
        Fri, 09 Feb 2024 23:09:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW8sDzfMYBYjxyemsK+fiduXCKeElhlPm2IA15iWaQTyosgIv3SXegARx/7gWwIoNMf/OYJ1E5L5O5Yb2b2cIysWnO1oBD1SfE/Xesyq0bvl9Qttr51I2bt9ClXYAhX3IXr8h4Hu9CW6OoRfdlMa2TibWpE7LcBN1K8yo7rWf7F8oEzsK7wzzFq8ZitQ252uzLEjAaf+53MhwjFdA1ZyhuS8wLGDgnSyuia6hk1G3N/eEipCDs89DaebviqoHKBjDRZHKPc3zKsHGXtXUZUiqWOIKZLxWz89I6rUigdeA3U8/KzF/uxgWGJgOMP5mj52kafxMePldEjGbWkyKShGLNqo7W47/Z/OE8vsmZt8/drrEqhpc97BRAuzJ0UEJ+6JdgF89TFwnsdyCGgr29sP1qQcsFwW9SU6tKWO36qSqLHbn5pCKLzla/cJafZwaHTtTm2gWe9W6TnaLjptpvJDvFXaSttVVWHj7K67Uou9dL/lbB0Q+WtVQK/o8teLN2FjNT7QQlI
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id d4-20020a170903230400b001d90a67e10bsm2489560plh.109.2024.02.09.23.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:44 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-usb@vger.kernel.org,
	maciek swiech <drmasquatch@google.com>
Subject: [PATCH 03/22] dt-bindings: usb: Add downstream facing ports to realtek binding
Date: Fri,  9 Feb 2024 23:09:14 -0800
Message-ID: <20240210070934.2549994-4-swboyd@chromium.org>
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

Add a graph with 4 output endpoints to this hub binding to support the
scenario where a downstream facing port is connected to a device that
isn't a connector or a USB device with a VID:PID. This will be used to
connect downstream facing ports to USB type-c switches so the USB
superspeed and high speed lanes can be put onto USB connectors.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: <linux-usb@vger.kernel.org>
Cc: <devicetree@vger.kernel.org>
Cc: Pin-yen Lin <treapking@chromium.org>
Cc: maciek swiech <drmasquatch@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../bindings/usb/realtek,rts5411.yaml         | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index f0784d2e86da..5480a31698be 100644
--- a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
+++ b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
@@ -21,6 +21,12 @@ properties:
 
   reg: true
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   vdd-supply:
     description:
       phandle to the regulator that provides power to the hub.
@@ -30,6 +36,36 @@ properties:
     description:
       phandle to the peer hub on the controller.
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          1st downstream facing USB port
+
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          2nd downstream facing USB port
+
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          3rd downstream facing USB port
+
+      port@4:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          4th downstream facing USB port
+
+patternProperties:
+  "^.*@[1-4]$":
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+
 required:
   - peer-hub
   - compatible
@@ -50,6 +86,11 @@ examples:
             reg = <1>;
             vdd-supply = <&pp3300_hub>;
             peer-hub = <&hub_3_0>;
+            /* USB 2.0 device on port 2 */
+            device@2 {
+                compatible = "usb123,4567";
+                reg = <2>;
+            };
         };
 
         /* 3.0 hub on port 2 */
@@ -58,5 +99,14 @@ examples:
             reg = <2>;
             vdd-supply = <&pp3300_hub>;
             peer-hub = <&hub_2_0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    remote-endpoint = <&usb_a0_ss>;
+                };
+            };
         };
     };
-- 
https://chromeos.dev


