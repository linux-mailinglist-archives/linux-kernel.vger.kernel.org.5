Return-Path: <linux-kernel+bounces-41243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0483EDE7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 16:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36331F22683
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1BA28E1B;
	Sat, 27 Jan 2024 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gcSbM8Ck"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F0228DC9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706369311; cv=none; b=Cmc+b+i1SzeAaKIj48lTHMfpv8oA8XnmMA+zAoYFpVQFdpLjA+imO/xmqy+THVVfx4Axt5uOqRwldfkFLpbJeCz6Vvj/mXUJTeywCSB3LniOUysAQzfPCCS7cS9CfJdEhCeFIW1idWC2quR5HxsC/McIkb5KEwiRSbKdmJyfTqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706369311; c=relaxed/simple;
	bh=B1lQN2DRgn3nQBtFdWkRtHnud7Y315A8P2HYAFO7EV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3BBt5PmyTi8I6tpaUofGOoLBTqmLAiHvsuRmwVY53+JdQSsOrKKElOcjiV+yQ0JGkMKr939mM4mXPgiiwpFg+CCb4SlYX44LmYrt8zo6apjxLWK3hhuXpvDVzgdFN7IX/awTOx4bBzh1BN80N/xXdAJnRFH6P9BOcZxVXVIO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=gcSbM8Ck; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a277339dcf4so129603866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 07:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1706369308; x=1706974108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haBaXjP3IuqWi4Vh3TynqcBtGi5D9/RbAjyH8MaxFEk=;
        b=gcSbM8CkOWCDF+p+eNKp7quYEF1qTbiUKuPCtutrj74yh7XXteIhq1thvHMUJW3z9f
         Nwee7ZIKqZb7EMrRgHx0uO3iQxemyB10MpeOXmQ4i/0+bqi9b58fORmNFrrJBI7RNYR8
         ofXaySANPiWe81hUVtcWIcaz47T7Kco5T8Q6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706369308; x=1706974108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haBaXjP3IuqWi4Vh3TynqcBtGi5D9/RbAjyH8MaxFEk=;
        b=CA0+eIvcgMQqtQDMFo9rVFnO5PgU3BKDpNpvGTwur6SprpLZfOPHH7Kuee+DlUWibX
         44HUuvSC1/RNm3WgMZ+fPW1x3Yo99Q2reed5xy+L+4O+DQ2RPnMqh4YdUhu20nKpQtV7
         bFQQjKhsa7ctZ5/Aehad9n/P/HGw88YXcNYTa+yMpj2on9x4RfPJlJf/K/J/FHYCeqc/
         PX1GI9RFqgFzOUCCkd9JUpAvNnwGotmCFSvC4vLdTfv8bys3o4FzTfQL8lu/p7TnmApL
         0LYeOvYTXHyJAl46LJvrJgLzpvwxILZOLUlFlYceRtSt1ilTD2i1l2125wUIJ47M7HXw
         GbLQ==
X-Gm-Message-State: AOJu0YzM0/HlKT54pelglAUpz+vSE0p/i7bKtB+VEe6bpqew45uLKkbH
	zUIYzLZrtLFUQ/Hh9XD6bxyT6k8Dyp3A4rp6L6H7B1nj9WR5FpPcYDpcCnkyK6RqLKSW56Fq9Wo
	5
X-Google-Smtp-Source: AGHT+IErhFoxSEE+bInbELtSYR5kkaNSeW62dXAyFHtebD7TQBYzbADVG8K8/cyVC3nEdk8weBw+vw==
X-Received: by 2002:a17:906:6953:b0:a34:af8a:ee3d with SMTP id c19-20020a170906695300b00a34af8aee3dmr1160137ejs.16.1706369308266;
        Sat, 27 Jan 2024 07:28:28 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-21-103-141.retail.telecomitalia.it. [79.21.103.141])
        by smtp.gmail.com with ESMTPSA id vs3-20020a170907a58300b00a3550c56127sm509361ejc.9.2024.01.27.07.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jan 2024 07:28:27 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [drm-drm-misc:drm-misc-next] dt-bindings: nt35510: document 'port' property
Date: Sat, 27 Jan 2024 16:28:08 +0100
Message-ID: <20240127152821.65744-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow 'port' property (coming from panel-common.yaml) to be used in DTS:

  st/stm32f769-disco-mb1166-reva09.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>

---

 .../display/panel/novatek,nt35510.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
index a4afaff483b7..72913719df23 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
@@ -31,6 +31,22 @@ properties:
   vddi-supply:
     description: regulator that supplies the vddi voltage
   backlight: true
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - frida,frd400b25025
+then:
+  required:
+    - port
+
+else:
+  properties:
+    port: false
 
 required:
   - compatible
@@ -54,5 +70,23 @@ examples:
             backlight = <&gpio_bl>;
         };
     };
+  - |
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "frida,frd400b25025", "novatek,nt35510";
+            vddi-supply = <&vcc_3v3>;
+            vdd-supply = <&vcc_3v3>;
+            reg = <0>; /* dsi virtual channel (0..3) */
+            reset-gpios = <&gpioj 15 GPIO_ACTIVE_LOW>;
 
+            port {
+                dsi_panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
 ...
-- 
2.43.0


