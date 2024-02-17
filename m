Return-Path: <linux-kernel+bounces-70113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C385938E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30575B2188C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 23:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050CB6D1A8;
	Sat, 17 Feb 2024 23:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldZBVex4"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624B7F7F6;
	Sat, 17 Feb 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708211510; cv=none; b=Hif5VlGJwidLGe5BmevWLK2Y6/T+BQayoe2I+7HXZepE97HOGNGoQEXkGR8Iih8gOF6AhZiPJtOhrCe8myvQUFxJcm3uRk/99mwD/Sm5VJvivOL0FIg7cjWJ61XhG7ZHWp1WnDmmV/vQ45Y2JX/7euXu+F5hWFaL7FAydpoDdr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708211510; c=relaxed/simple;
	bh=PuY7CoHelqqxMR2WY2gwHQsUwUn4HmGDxqITqw8g0+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aJeCbAdf5E8JvlYBR2Xpi0m7CGr6516S38yOWe+Mmzp+pPu+80o5hJ6XksX/6LaqpaVpqOAH6AVgb8qloCGx12yUkCKtpaiPgSdKzRBG5f756VnD4oy5f2JfQLS4zoRM4J26kJH6wgc9Cn1xIHMZMUp7DNDcNWNIChi8rqPbFQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldZBVex4; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c031776e0cso1468688b6e.0;
        Sat, 17 Feb 2024 15:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708211506; x=1708816306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UTpDENxTy13x+lQaGg96zVTVcyV5n3Aze00u7CsdzkA=;
        b=ldZBVex4xOVTGVHt8Z4VWYxNKFpqcGvpDqBm4aDLFeMx3aQ5gW3ehPML6Dt8n1UgGA
         /I4LGRwgKgNaCSlt9EocLzq96dqkh0VgK7pLr7Yr/4G4BTS/kba3mlJ8ivFYK4x/epY7
         YZ5YuFaap743pt0Hm0r9L0yKeur3pKoc9/VgsKR81C3MKCRpv/qaNLplTaOUF7ATcvI5
         rDYKLxXgIptyhZ37gO4Keq9gZ6gMHuAmUyJq3vZHVA3ih69ClYQv53qMiFJ2mbpQRHJ2
         /x0fnmDRElJECGwJjXvSOLgicK/9a/5GTWqsf8XPTF26Jf4ZSZeqeygTvxkUpy22iT3W
         FihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708211506; x=1708816306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UTpDENxTy13x+lQaGg96zVTVcyV5n3Aze00u7CsdzkA=;
        b=nnkSiiKJBEOoOp06390xSP0xAJe5tKU5xBzlmJRbVqRzTj27HLHN7r2xxF/OggcJW3
         elpGs7IBnwpDlGd5HPwDOv7CdoUYQnE8HeM6NuPavLHirg7doXYWj3J1Rjw9X/l6loEe
         bSTqE4TUdvhTrMC57oYlnmTd+YtfpVr8wIdrLImvbBJIwvza7TYRuLcasDU22S7UyU0q
         muTjR0vHP81l38p5j9cfeddFYiznZsDvnanUnHiLFNd9xRbS2aAVBL6GTIokbl8FbtZz
         ghTVj26MbFx4RdfzXYHRH1Y+6GgeD8YjYzoTRw+FTl3Wr1mL2KFevbcNhj4AKUibHhcW
         sdWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ5jgFo5El8BxCBSm7o+WjrO/QS+fdMM4Pk0LhsNK2/x34mMaZ0vH/8xtVKKjXrcGANr1wqj7lLtwl3UyYJDnr/lAiLE4Itnel6NSX5aUEdklOZPmaYLyfizyrqcOsa5Lxd+z+OszCqFxq9B/2m8E/WQBJdlQG1ltwF3EiVnNve9uocUc=
X-Gm-Message-State: AOJu0Yy4K1dsML1EqPkOZmX2Ekv11MdcOMMsC86eCjQ8eyNa6UnFUWx4
	2dNpRqAH7U9DAYnLeQ+4I5Qlvpqe9ELRoNSYOOt4l1x5ueJp3MLN
X-Google-Smtp-Source: AGHT+IH3xtn5XaR26I2MvrkXUFytQJ/WmPbjn4uLt2QfC/qqbLozRjGEDlCdRW6MKpu235MF0H5fQw==
X-Received: by 2002:a05:6808:2e87:b0:3c1:41fc:d012 with SMTP id gt7-20020a0568082e8700b003c141fcd012mr7150189oib.34.1708211506366;
        Sat, 17 Feb 2024 15:11:46 -0800 (PST)
Received: from localhost.localdomain ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id lu8-20020a0562145a0800b0068cc837fa1asm1503506qvb.53.2024.02.17.15.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:11:45 -0800 (PST)
From: Abdel Alkuor <alkuor@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abdel Alkuor <alkuor@gmail.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>,
	Alice Chen <alice_chen@richtek.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: leds: Add NCP5623 multi-LED Controller
Date: Sat, 17 Feb 2024 18:09:19 -0500
Message-Id: <20240217230956.630522-1-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NCP5623 is DC-DC multi-LED controller which can be used for RGB
illumination or backlight LCD display.

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v2:
 - Fix commit subject prefix
 - drop | from the main description
 - Use const in address reg
 - Remove LEDs reg description
 - Link to v1: https://lore.kernel.org/linux-kernel/20240208130115.GM689448@google.com/T/

 .../bindings/leds/onnn,ncp5623.yaml           | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml

diff --git a/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
new file mode 100644
index 000000000000..9c9f3a682ba2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/onnn,ncp5623.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ON Semiconductor NCP5623 multi-LED Driver
+
+maintainers:
+  - Abdel Alkuor <alkuor@gmail.com>
+
+description:
+  NCP5623 Triple Output I2C Controlled LED Driver.
+  https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
+
+properties:
+  compatible:
+    enum:
+      - onnn,ncp5623
+
+  reg:
+    const: 0x38
+
+  multi-led:
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^led@[0-2]$":
+        type: object
+        $ref: common.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 2
+
+        required:
+          - reg
+          - color
+
+    required:
+      - "#address-cells"
+      - "#size-cells"
+
+required:
+  - compatible
+  - reg
+  - multi-led
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@38 {
+            compatible = "onnn,ncp5623";
+            reg = <0x38>;
+
+            multi-led {
+                color = <LED_COLOR_ID_RGB>;
+
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                led@0 {
+                    reg = <0>;
+                    color = <LED_COLOR_ID_RED>;
+                };
+
+                led@1 {
+                    reg = <1>;
+                    color = <LED_COLOR_ID_GREEN>;
+                };
+
+                led@2 {
+                    reg = <2>;
+                    color = <LED_COLOR_ID_BLUE>;
+                };
+            };
+        };
+    };
-- 
2.34.1


