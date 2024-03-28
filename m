Return-Path: <linux-kernel+bounces-122302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C8388F4DA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F829292BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B220B21;
	Thu, 28 Mar 2024 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it0jMVq8"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D78847C;
	Thu, 28 Mar 2024 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711590061; cv=none; b=mpZCm+ANdIeXwFBaphI2jLcN2fAvwW09kYXYQ7s7AXlvKMhAUJnZfJWlvX3evpMO7qCnpV2c8taOSd046+KTsCRDq0VXpvdPurJh07U8XkvdZJ3WRHI6uRncicADaP7s7t840WLfyT/yfsBl4U/63LwPmExsofdotEugvgAOCfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711590061; c=relaxed/simple;
	bh=WxIUwzIRX245RWvPJ1HE1kAUL98+daIiJa1ylRa9i2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aqYJwS+GF6k+VD250X74ZZmnqgIoA7W94h8obeVnuplD0z12FU6LboG7QFLT6xd9d5upfG8AJ1sJ7MUpulFdle/GHYhf38mp6NYlhz85viZR7aq+kwBiVC76upIxQKUvBLSMLBBFUeq/J7RKPwfkauMjNvUMadKPs6+12Pk/mOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it0jMVq8; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c3d7e7402dso365122b6e.1;
        Wed, 27 Mar 2024 18:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711590059; x=1712194859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UQew5YYLgTvT6DTiJ19Nkd1adlHoEpKqIs98rlN2rko=;
        b=it0jMVq8Spwz64IQiCeyhTQPhD4tsV2cpx6DrEtozVJ6EzQlZcDmjXIVKFWlt0dqzD
         0zXsT9JxHDPCWVszY+xGp82FPQG8MGLK3LFUzDwTN+gZKetig1CmWpDsD3/i6WI1mtAh
         cyFjIuVCYGjDpAUEI0MFvb/qiiZehD41XuyV3GrO1zDkNUBvjfmZ6SF1Y257A5I1S3+e
         vT6EwFbcSu+nk5+zbbX3VFEYAf/Li8QLj8y88AuFmZCLHunGrkFqeUcJwuBejqgUbbL4
         57CK0PZaJxbfOPGZXUgbbjqV1YzgXT/OXjfzVzOEMA/rXI4Ej925sEyvQ8RxkaK/hEJo
         PrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711590059; x=1712194859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQew5YYLgTvT6DTiJ19Nkd1adlHoEpKqIs98rlN2rko=;
        b=SIeyotOeyNZTjPzGYHmkiisR8tFoeqYt3f+H3/zaS/xGmIiH4hdDYb2YhCDJAaQkRS
         OoXtxurrMXQnhrPjG2NMPZyzODT08cs+I9jTSFDwIe6fVkVb1oVR9DTeqM1f0CeneMbZ
         dG9zExjMvg9Ya60SsX5k1+NSKG5zcqUGfhHdphG7I3hPDmddcbhSL4fPc6zxcFvkm2DC
         j6HjPNAa7PQ7zdxJoew4wJYC0WOWHsidHpyQtcSHZlibB/5h0+1IeRjkOIoIKs0AZC8b
         CB0yMXFUy39QV8rtmnmImqUp8yQbTbf6Tfef5DbOnpGQT4QbGzlxE7pMWdQxD03zNP/n
         Ktig==
X-Forwarded-Encrypted: i=1; AJvYcCUx4+3HCnf1xKew9VZtQW299yIo9O7CjOTGuxJEx3Pl5yM32dqfvIsIoMBQrl66+XRnWjzC05ZWX6hDM5K3oKXhmLZIkx/BGxP3Up9fvd8Vgce+J4uvCnWGwu0xBWB+XJW4pLfRE60xTQ==
X-Gm-Message-State: AOJu0Yx8fTCFdPbhDMUzq7HeXoqHkmqbR4X586F6DxhU0MZt6dyaXV+7
	Y61CwpBcXyFZ+hkop9UvukuUPGLYCZ76fDoRmLA/r2a+p4phf7OE
X-Google-Smtp-Source: AGHT+IGcSrsak0kpRYq7vxFaL/0IQ4DAeYAFSWyaYVF7T1dV3iRr67NiFP1pVnKmxrcjunLsF/cv+A==
X-Received: by 2002:a05:6808:23d2:b0:3c3:d66f:239e with SMTP id bq18-20020a05680823d200b003c3d66f239emr1737695oib.54.1711590059033;
        Wed, 27 Mar 2024 18:40:59 -0700 (PDT)
Received: from localhost.localdomain ([122.187.117.179])
        by smtp.gmail.com with ESMTPSA id t4-20020a62ea04000000b006e6bda407b6sm188831pfh.202.2024.03.27.18.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:40:58 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ti,pcm1681: Convert to dtschema
Date: Thu, 28 Mar 2024 07:10:24 +0530
Message-ID: <20240328014029.9710-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Texas Instruments PCM1681 bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/sound/ti,pcm1681.txt  | 15 --------
 .../devicetree/bindings/sound/ti,pcm1681.yaml | 35 +++++++++++++++++++
 2 files changed, 35 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,pcm1681.yaml

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt b/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
deleted file mode 100644
index 4df17185ab80..000000000000
--- a/Documentation/devicetree/bindings/sound/ti,pcm1681.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-Texas Instruments PCM1681 8-channel PWM Processor
-
-Required properties:
-
- - compatible:		Should contain "ti,pcm1681".
- - reg:			The i2c address. Should contain <0x4c>.
-
-Examples:
-
-	i2c_bus {
-		pcm1681@4c {
-			compatible = "ti,pcm1681";
-			reg = <0x4c>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
new file mode 100644
index 000000000000..4093d0ff654d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ti,pcm1681.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ti,pcm1681.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments PCM1681 8-channel PWM Processor
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: ti,pcm1681
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pcm1681@4c {
+            compatible = "ti,pcm1681";
+            reg = <0x4c>;
+        };
+    };
-- 
2.44.0


