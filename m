Return-Path: <linux-kernel+bounces-117695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9EB88AE82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7203B1C39BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF2635;
	Mon, 25 Mar 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbJg6AXg"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5118E20;
	Mon, 25 Mar 2024 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390795; cv=none; b=qNMJEygw9uX6OtBQlHy/O0mcirU52rPXTMhvfa9ptgqImhU24Wbd2uWxK6r1Av0HrhXLB43nsHWvpCDnaNvPtIET+6XBsHhKrpYnMvLxbpd95597QW6MomxoPA1H1hfgXowdAz3iibebOoEb1veyQt1k3SkaDrjt76FSnU/R3Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390795; c=relaxed/simple;
	bh=E81LA2THJKeDidFFeqQI4zKcNnZcZ38Rs/hVCGWis4k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sElSdpHIdaOlHcbe+YwguJ0inkfQGMNL7Q3a/7iW9GCZVy4QJDxloFNcguyRyxri7Ukn5rLiv8v6efaCfj+0ZZWefKNVfYs2uwyi4+wJ7qSJ49lAxVfZ8QNAVXf/r6Qec6fN1G8DyoviKviLYlPx2gxetL5PCIn4sJMvCre3qCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbJg6AXg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dddbe47ac1so35629585ad.1;
        Mon, 25 Mar 2024 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711390793; x=1711995593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rMzrRncdSfwKv7bbmYuayc7ahUnMmS+d++1NpNJY28g=;
        b=YbJg6AXgUalcLsoo/QQVf0UOmUtewy5Z38bMZ7zTHQJHUKXF++5MG1HqsKJMnbx8n7
         JsRacJy7SyvDeRvvcICLEaB/DTFKIc8swJ10YPsSZHUPPclguFpChbayKelq8V2/+jd8
         gzI6kQ4iFPks2obEctwKm/BlbGZwrawL5OfNIvZJiGHv86x6cn7EbwzWJNqw4kEwT8Jf
         9u4CaItYm7UZXuv07+KowexL2ey5CoJwUQjTozuNycU8hduzDdv/JTXofgpBWzPKOQxa
         w02lE2nuf9y03+2VIITsHKS1n38zXSTnUdjJlambqCwe8Y2gj5zvMR4x/tVs8qw/XUsm
         A+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390793; x=1711995593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMzrRncdSfwKv7bbmYuayc7ahUnMmS+d++1NpNJY28g=;
        b=P+FNaQOqMyCEBn58vrV2TpTgQgkZo+gbmENnalIMjngDQsaba+8oyJLOKHjNJhyQT0
         wdxNuQwyT7cuZIcxACtLSkfiAE3Ndi4VYkWkgqrhgHKLgJhoi7gTEZYf35Nf/b0bNNX0
         VIP7r/yxajSWdgRt87DyjZX0SOtwfr3WgJPV6XcAqI+xiKasrf5GZ1T8/axH+DW9XijN
         T8gN5N7XWNtBGP9PdjkS/IWkWnqZcL2/UmI50Eq5Ze70jO9xeoBlPr2atzOVVNo889Jz
         NieQhQ8aubiDOk2WL/3t5TT8tGiqtVwETHPezdxNlKDYDDy5n31jHhAvguoAdnYpD3Es
         BTfA==
X-Forwarded-Encrypted: i=1; AJvYcCX+twh78TSfzu7wRDwMvOLpGuoqToXwaMjh4jeIHALAv4GqKFD158DHzIp+nVev5Feig4nlkvyOcuw9mPj6lbWLN5w3BPf4sFRCEPeIthFdYxnKVUMB+Njrs5c2zlF/9c+ypHV7RFQYz8KUeq685zvN46TU1VD6f/n3l0SK5Jyo9BNO8dQm
X-Gm-Message-State: AOJu0Yzv2ri0Islv0CKtJV84B/BZ2AnJO4NPeP8Gzlb5juanW1E56nof
	YpHYafV/Lh523zKwdEWX9b/KEERNYmQiAm+GWprhs7a99nDnPHWnQELSQGSr/Rs=
X-Google-Smtp-Source: AGHT+IHKUevLsdZcPN6IM1ik1xoJp2mQaYxMFZBtrEmNtYwA6oFk+gLB3eosr+OB5zj862LgKib99w==
X-Received: by 2002:a17:902:d507:b0:1e0:bc64:a37a with SMTP id b7-20020a170902d50700b001e0bc64a37amr6034767plg.8.1711390792834;
        Mon, 25 Mar 2024 11:19:52 -0700 (PDT)
Received: from localhost ([103.139.191.219])
        by smtp.gmail.com with UTF8SMTPSA id h10-20020a170902f54a00b001e02875930asm4957694plf.25.2024.03.25.11.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:19:52 -0700 (PDT)
From: Kartik Agarwala <agarwala.kartik@gmail.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: Kartik Agarwala <agarwala.kartik@gmail.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] ASoC: dt-bindings: wm8974: Convert to dtschema
Date: Mon, 25 Mar 2024 23:49:42 +0530
Message-Id: <20240325181943.116733-1-agarwala.kartik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert WM8974 audio CODEC bindings from text to dtschema.

Signed-off-by: Kartik Agarwala <agarwala.kartik@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8974.txt  | 15 -------
 .../devicetree/bindings/sound/wlf,wm8974.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.txt
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.yaml

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8974.txt b/Documentation/devicetree/bindings/sound/wlf,wm8974.txt
deleted file mode 100644
index 01d3a7c83..000000000
--- a/Documentation/devicetree/bindings/sound/wlf,wm8974.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-WM8974 audio CODEC
-
-This device supports both I2C and SPI (configured with pin strapping
-on the board).
-
-Required properties:
-  - compatible: "wlf,wm8974"
-  - reg: the I2C address or SPI chip select number of the device
-
-Examples:
-
-codec: wm8974@1a {
-	compatible = "wlf,wm8974";
-	reg = <0x1a>;
-};
diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
new file mode 100644
index 000000000..d27300207
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8974.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/wlf,wm8974.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: WM8974 audio CODEC
+
+maintainers:
+  - patches@opensource.cirrus.com
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    const: wlf,wm8974
+
+  reg:
+    maxItems: 1
+
+  "#sound-dai-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        codec@1a {
+            compatible = "wlf,wm8974";
+            reg = <0x1a>;
+        };
+    };
-- 
2.34.1


