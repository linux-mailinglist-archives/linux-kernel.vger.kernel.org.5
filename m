Return-Path: <linux-kernel+bounces-77596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6C8607E9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5159DB2237E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4654BE4A;
	Fri, 23 Feb 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CAFwyX3f"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C90AD5A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649911; cv=none; b=bvtYUFPPqtDQu88J7cccgRqruNTu/rqdXnxWG2PyHCeUu0Co7lLRNl8alzT9GlwO9nPuPpm9qe8NF1wgM8Qta3n78MeGuzuX1G/3KLslAJwc1gB/P+GQpqTwJ8JR2MoC0TA1qMyEYHYNZsmvBsuG/FiDjVWbbdbSS2ZCh+m+7gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649911; c=relaxed/simple;
	bh=O1sCSpMrQuVP4Z+oTQDMovl4p0LxmLa8st/+UmNeCw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWovj9Cbam4FVW95qkXqT/XdVocEqAUwfIizA0X/kZ1yEKvEGH9AvpFCeUAQd4HZLBvf/h7XWkxgbjsTSMexTocP9c7Vr8dsDYPr3sX0tDOVXKmYZzTDpCw3IjsjzcTyDxZHaI0xRhfhVZAssXSU+0eN7xVk3kxy3f8JsjmwnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CAFwyX3f; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso379578276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708649907; x=1709254707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUukn0iRYfq5PWEhEP7nadIeFb7HXOkHlZH9C2/kzss=;
        b=CAFwyX3fxgveUxR6RRagHZ0b5uYjW3EJcZI7PhECpmON6zPyrEAVevDtujCj/Skgig
         03ocYUmFJfQTcEnYMryirpfeHbgy4xOFT9nDbnejihvG5tqyiOvLcs4MtwHshsGDGxVd
         Cm/UO3BoivmdSODWec8kjMKY5G2z9zgivCEVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708649907; x=1709254707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zUukn0iRYfq5PWEhEP7nadIeFb7HXOkHlZH9C2/kzss=;
        b=mjxQaeRd/wWvKJD9rucVRogYVuS3Yh4sIijUrj2YkgV0H/77od5VPiEpee+f1oRfE1
         ipEsQ1BoAOeomc21x8gCYauyRBqDGGaSOwK4P2K23QuDPwed3vQ9VQv1WLgBTtz2nLrj
         FksOXNpqfXIHf9uciOk2IFdQv2E/rfsijxjc9/0BZ2PJY15wLGlVSf9G3MTDrmq2U+QG
         1HZvOHSKd0OR3yUXFcVw0EzaCq5cUf2NHst3l6Nt7hgpvs+HxdY/M/TXmWT9poyvvFZi
         oFyXy1YZKVutvhG8Zs6t6QfsS6hDplxJ5BReuB5iAz08z1m6PwqDV1wk8E4ds/g0YLQI
         mWmQ==
X-Gm-Message-State: AOJu0Yw4JfsDfeNlEr8+/mNxhSgNqDH1nzeOWG3hHBw0d/E+3i9n64Q/
	FZH7nWM7z7Om7KJ2tGhZBX6zGT1WsVxu+aMvP5FQQTKFwPdabvBO+D54f0MeSQ==
X-Google-Smtp-Source: AGHT+IG7cIldAux1KCpcOyUTRGVAfY4OuwFGQoFyysr4Ky17iN4jW+0w6szCAWKEExF3w960f89FHg==
X-Received: by 2002:a25:c244:0:b0:dc6:a8c6:c9e5 with SMTP id s65-20020a25c244000000b00dc6a8c6c9e5mr877740ybf.26.1708649907539;
        Thu, 22 Feb 2024 16:58:27 -0800 (PST)
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id p14-20020a056a0026ce00b006e4887b13ffsm4820031pfw.1.2024.02.22.16.58.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 16:58:27 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Roy Luo <royluo@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Kaehlcke <mka@chromium.org>,
	linux-usb@vger.kernel.org,
	maciek swiech <drmasquatch@google.com>
Subject: [PATCH v2 1/2] dt-bindings: usb: Add downstream facing ports to realtek binding
Date: Thu, 22 Feb 2024 16:58:20 -0800
Message-ID: <20240223005823.3074029-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240223005823.3074029-1-swboyd@chromium.org>
References: <20240223005823.3074029-1-swboyd@chromium.org>
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
 .../bindings/usb/realtek,rts5411.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml b/Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
index f0784d2e86da..0874fc21f66f 100644
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
+  '^.*@[1-4]$':
+    description: The hard wired USB devices
+    type: object
+    $ref: /schemas/usb/usb-device.yaml
+
 required:
   - peer-hub
   - compatible
@@ -50,6 +86,13 @@ examples:
             reg = <1>;
             vdd-supply = <&pp3300_hub>;
             peer-hub = <&hub_3_0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            /* USB 2.0 device on port 2 */
+            device@2 {
+                compatible = "usb123,4567";
+                reg = <2>;
+            };
         };
 
         /* 3.0 hub on port 2 */
@@ -58,5 +101,17 @@ examples:
             reg = <2>;
             vdd-supply = <&pp3300_hub>;
             peer-hub = <&hub_2_0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                /* Type-A connector on port 4 */
+                port@4 {
+                    reg = <4>;
+                    endpoint {
+                      remote-endpoint = <&usb_a0_ss>;
+                    };
+                };
+            };
         };
     };
-- 
https://chromeos.dev


