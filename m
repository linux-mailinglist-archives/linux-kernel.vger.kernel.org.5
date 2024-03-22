Return-Path: <linux-kernel+bounces-111106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815A8867FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD43E1F25134
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF68168CC;
	Fri, 22 Mar 2024 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0rJJiIR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30E17998;
	Fri, 22 Mar 2024 08:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095152; cv=none; b=MTo2T7n4xZ27gYp4Ilj9UjlSjr5oEYwgfJ7eIdVX508d1QDn++9mKzPh1QMR88RgXSJRKCa3l3E4n/GQGWdoDRV1ROQQknsGiBFy/4VH6Xfd4eSgjJAeAOU3Iy4GLgNRHpw8TJFKLVpE4lZ6bAPeb9Bzc61yhbdSphd5Vk2qKbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095152; c=relaxed/simple;
	bh=301i7Aef1JYyE5/4AzGVyJQAFZDvNzA6dBmv5J5jE6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixCRkBzIIZdS0Dm8ZKJnqCI9+1hCZgrqEVAIMIhZJ25w2hRMd/5wuoE58euxHnai2Jcn1tazY0GdLQe9BbjsNxC//L6MitluAiTH3eCO+HVTI8PVD3zGN9vKqY2RbVifg/n26kJ2GskKJ8yyPOUrcOlQ/ZhhjPL7itnrlf5lSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0rJJiIR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6b729669bso1457265b3a.3;
        Fri, 22 Mar 2024 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711095150; x=1711699950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g2twXgqk/JJH1iFtYUNR8nPJ8pAL7XuG13GUJFxIX6E=;
        b=h0rJJiIRnXUfB/epiGqhPyUtkqtywt1gfGZ5IHFcE0eZTsA3U6QEalDyedpye2LITG
         4gbRMq1M92IP0ENRp2tIhR30r+Xix4l8hNP/bVcO2g3rHzkZdxi8ypIZuFhRaEiBrJtN
         HUMAToQ8ict8t/C0YnZBGHSxHOuwaKevhGeNZx8yvw4V7oirQaP8L3/GSE7g2uZf2aJx
         kzan7AKJsZHMcZ4oDB8PL6UQ45oiOve4KGxRrewEQ5d/awOFPWki+wn5bG8cnOOiiaMz
         DoX2aEEuvpFCy5R5F3tIMxbPn3Wxejdv0SrxEHG6FtrC0ouLdr2yJKipmdeVzCxCsPRn
         zuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095150; x=1711699950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2twXgqk/JJH1iFtYUNR8nPJ8pAL7XuG13GUJFxIX6E=;
        b=MvFPhdtTHz/be5RrEph6sQzzLVbvNq0gpbhX8DxpNr0qxj0d7QF9/s0UhMIeex2dOi
         QDiOPJPLLHgcNvmUxoDltpskAvzQP/LCdS2azNtPJ2b9I5svnerB2Pn230DYUakbbaq9
         Dwp/g/aO6LEUBMISFARjWkCWDCltTHR/sUEBxDGrCm+o3KUSyvb+vqeoryQaJ2yUgE1U
         LfFYQrGsQ1Y0HO5e6fvfx5mz9K0Nfec/WwxOUSA8nlMhLi00Jg+tSvlSeWD9UarUasWe
         30cDkUs40zZXMaRxAaD9Yt7djCXLf/lgyXvHwVopwI6nKsVd/CSBSI0YfgQMSbXRTKfm
         6Plw==
X-Forwarded-Encrypted: i=1; AJvYcCV+rxBfHaLT5OY/BSsn3dhzFrnpTbwDJaxGOVeVxnesgGaxFhVKsHJipLvGHpCTTvK0FHoSOE/kEORgRgcBWtv7LyjnaG4YMSbou0xo0fyoVXC4YxwKdbYn1o+2JJlpKJWfz876OZKKj+z05hS3OFZ96TJkYBZOEoqvlfBcWeOdqteDmQ==
X-Gm-Message-State: AOJu0YylRqUYjZgxTkdEGDfdnxc8l2TNY3WiY8yge82tL8z4avygIvv3
	C3YTgBhjoZSn5GnKhrpXZqvQiqVPdykbJYRn+ccE4vttxvx8jkaig5yKX/b4J9Q=
X-Google-Smtp-Source: AGHT+IHau1QP+QER+BhNbYRjwpexZyV9kw4kLmibA11HZHIoAFd/J+EJOM3PS5pH/y+83Y1YTec3sQ==
X-Received: by 2002:a05:6a00:1142:b0:6e7:1b3d:4dbf with SMTP id b2-20020a056a00114200b006e71b3d4dbfmr1808324pfm.2.1711095150423;
        Fri, 22 Mar 2024 01:12:30 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s128-20020a625e86000000b006e749161d40sm1132564pfb.113.2024.03.22.01.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:12:30 -0700 (PDT)
From: baneric926@gmail.com
X-Google-Original-From: kcfeng0@nuvoton.com
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	corbet@lwn.net
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	kwliu@nuvoton.com,
	kcfeng0@nuvoton.com,
	DELPHINE_CHIU@wiwynn.com,
	Bonnie_Lo@wiwynn.com,
	Rob Herring <robh@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH v5 1/2] dt-bindings: hwmon: Add NCT7363Y documentation
Date: Fri, 22 Mar 2024 16:11:57 +0800
Message-Id: <20240322081158.4106326-2-kcfeng0@nuvoton.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322081158.4106326-1-kcfeng0@nuvoton.com>
References: <20240322081158.4106326-1-kcfeng0@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ban Feng <kcfeng0@nuvoton.com>

Add bindings for the Nuvoton NCT7363Y Fan Controller

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
---
 .../bindings/hwmon/nuvoton,nct7363.yaml       | 66 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
new file mode 100644
index 000000000000..c1e5dedc2f6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/nuvoton,nct7363.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton NCT7363Y Hardware Monitoring IC
+
+maintainers:
+  - Ban Feng <kcfeng0@nuvoton.com>
+
+description: |
+  The NCT7363Y is a fan controller which provides up to 16 independent
+  FAN input monitors, and up to 16 independent PWM outputs with SMBus interface.
+
+  Datasheets: Available from Nuvoton upon request
+
+properties:
+  compatible:
+    enum:
+      - nuvoton,nct7363
+      - nuvoton,nct7362
+
+  reg:
+    maxItems: 1
+
+  "#pwm-cells":
+    const: 2
+
+patternProperties:
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+    required:
+      - pwms
+      - tach-ch
+
+required:
+  - compatible
+  - reg
+  - "#pwm-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        hwmon: hwmon@22 {
+            compatible = "nuvoton,nct7363";
+            reg = <0x22>;
+            #pwm-cells = <2>;
+
+            fan-0 {
+                pwms = <&hwmon 0 50000>;
+                tach-ch = /bits/ 8 <0x00>;
+            };
+            fan-1 {
+                pwms = <&hwmon 1 50000>;
+                tach-ch = /bits/ 8 <0x01>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index de6a64b248ae..2705e44ffc0c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15216,6 +15216,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct6775.yaml
 F:	drivers/hwmon/nct6775-i2c.c
 
+NCT7363 HARDWARE MONITOR DRIVER
+M:	Ban Feng <kcfeng0@nuvoton.com>
+L:	linux-hwmon@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/hwmon/nuvoton,nct7363.yaml
+
 NETDEVSIM
 M:	Jakub Kicinski <kuba@kernel.org>
 S:	Maintained
-- 
2.34.1


