Return-Path: <linux-kernel+bounces-83245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79C8690C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EFDF284452
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B0813A896;
	Tue, 27 Feb 2024 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b="SORrIfKN"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823CD13A258
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037569; cv=none; b=qySezkxrjohLkXPERo+9VwJrPad/9hjzjQsajCc3Zve4bWOr2Li/D4ALz0MvJJ/9/8QzAa5CBMSLAz0OPYxL6jah1MurAEa5T6CkjefUkHbmV8gy7gsduwbf3XBDF6RbYZ436QBDvFyApWrBNLaxaL2Xh3s1i9OPNhLVIjCComQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037569; c=relaxed/simple;
	bh=IglaxdcZLU76jtprsOmWHg7k//GQ0hgdjNnuOUMEAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A3ROdBuzCQVO3XyjpU2reQgynp0VGjTBDesod398heupWtxqo/1PyzidZfy9VlTFOXu9yVdbkkZ73E440frYPIPJ6ueCOiAjHQIpY+cXgEY+PMS8rB+etHubGD8Ls6ngnzY1+vdiuyOQg/CRLwjAexFiKBPi1vhcHSeRI7dXdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es; spf=pass smtp.mailfrom=udima.es; dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b=SORrIfKN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=udima.es
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d26da3e15so2379279f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 04:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=udima.es; s=google; t=1709037564; x=1709642364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ulSh+zGZ8+dyF926zcKrRhp4LS8bqP+HSdasdk27iBg=;
        b=SORrIfKN823y17rLyenkBj+/iROfbZGuBLb81Yrk6DPdYExXqlvZphXiwfPPLFETNg
         tUk+Ke1aN29TvDYVkdjy/kpv3ZucL2PLbnwoZLpeW7jH3bWzvyyTK2pIsher5NvZQbp0
         ZVi4yObKoBeatg8talaP0a8S1IGCquZJiS+wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709037564; x=1709642364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulSh+zGZ8+dyF926zcKrRhp4LS8bqP+HSdasdk27iBg=;
        b=SYhjBZZXHqOE5A6Qom2NyRfVlRc000EfaGfe9rCaFEa5StNgwcm8AKQKSnxA9UAOR0
         oV5nkWkzi4gCn93iMbEGIH8hzsa2y7JotaL+EdU1/Po8ZLA+7qi1IcUezpriBhQ8E6sT
         ZWIPDGmoAyh5ED5YRQALmKmQYZX81CIAnFdvdzqSrTjVjnBnUn2tlGDgrbhXxM75e0YW
         U6jljCsF/28pUp2fHUQzKkyz6qZgCE37Y7fW4ASobtmRD9FIj/9oHVRlYKdF42hAFW/5
         90zpZ4TQB9zJjeKF2NqQCATsDUlz1hTkOxeviADji8Fk14YK/YT8QH8cnUzfPYM823tz
         jFXg==
X-Forwarded-Encrypted: i=1; AJvYcCVEG6rfCprNzjNnz+jOxYFrRo9UpcoMZWa22sKXJKdVdl46Rdxcn7mCWI4xGmr4RV3DSQUHFNIPHC2BjSch/Qgqi6Is3fZ6VGZiix6H
X-Gm-Message-State: AOJu0Yz31ZE60O4Becndsogw3dxd4vHS3pT1n4OOMvIuoZ81fZtOAKOf
	zCPd7PSXkDrJlQaFjhVvbVu+n+SsDDDKhQftzya4LWIGoQ1bcULpk6i+TPUlbrU=
X-Google-Smtp-Source: AGHT+IEmHNL+YaOOg3Qorj9DIRtr3BjF7dDzlkl0TJwo1yMeS3zmaiUNv0d+QEC07JdkBi5KsJphoQ==
X-Received: by 2002:adf:d1c3:0:b0:33d:7ec9:f5d0 with SMTP id b3-20020adfd1c3000000b0033d7ec9f5d0mr9918938wrd.2.1709037563746;
        Tue, 27 Feb 2024 04:39:23 -0800 (PST)
Received: from portatil76.udima ([79.116.0.170])
        by smtp.googlemail.com with ESMTPSA id bw1-20020a0560001f8100b0033af3a43e91sm11444061wrb.46.2024.02.27.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 04:39:23 -0800 (PST)
From: =?UTF-8?q?Javier=20Garc=C3=ADa?= <javier.garcia.ta@udima.es>
To: 
Cc: daniel.baluta@nxp.com,
	javier.garcia.ta@udima.es,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Convert the Imagination Technologies SPDIF Input Controllerto DT schema.
Date: Tue, 27 Feb 2024 13:35:55 +0100
Message-ID: <20240227123602.258190-1-javier.garcia.ta@udima.es>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Convert the Imagination Technologies SPDIF Input Controllerto DT schema.

Signed-off-by: Javier García <javier.garcia.ta@udima.es>
---
 .../bindings/sound/img,spdif-in.txt           | 41 ----------
 .../bindings/sound/img,spdif-in.yaml          | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.yaml

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.txt b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
deleted file mode 100644
index f7ea8c87bf34..000000000000
--- a/Documentation/devicetree/bindings/sound/img,spdif-in.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Imagination Technologies SPDIF Input Controller
-
-Required Properties:
-
-  - compatible : Compatible list, must contain "img,spdif-in"
-
-  - #sound-dai-cells : Must be equal to 0
-
-  - reg : Offset and length of the register set for the device
-
-  - dmas: Contains an entry for each entry in dma-names.
-
-  - dma-names: Must include the following entry:
-	"rx"
-
-  - clocks : Contains an entry for each entry in clock-names
-
-  - clock-names : Includes the following entries:
-	"sys"	The system clock
-
-Optional Properties:
-
-  - resets: Should contain a phandle to the spdif in reset signal, if any
-
-  - reset-names: Should contain the reset signal name "rst", if a
-	reset phandle is given
-
-  - interrupts : Contains the spdif in interrupt, if present
-
-Example:
-
-spdif_in: spdif-in@18100e00 {
-	compatible = "img,spdif-in";
-	reg = <0x18100E00 0x100>;
-	interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
-	dmas = <&mdc 15 0xffffffff 0>;
-	dma-names = "rx";
-	clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
-	clock-names = "sys";
-	#sound-dai-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.yaml b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
new file mode 100644
index 000000000000..d201293d63c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination Technologies SPDIF Input Controller
+
+maintainers:
+  - Rob Herring <robh+dt@kernel.org>
+  - Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - img,spdif-in
+
+  reg:
+    description:
+      Offset and length of the register set for the device.
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
+  clocks:
+    items:
+      - description: The system clock
+
+  clock-names:
+    items:
+      - const: sys
+
+  '#sound-dai-cells':
+    const: 0
+
+  resets:
+    items:
+      - description: Should contain a phandle to the spdif in reset signal, if any
+
+  reset-names:
+    items:
+      - const: rst
+
+required:
+  - compatible
+  - reg
+  - dmas
+  - dma-names
+  - clocks
+  - clock-names
+  - '#sound-dai-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/pistachio-clk.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/reset/pistachio-resets.h>
+    spdif_in: spdif-in@18100e00 {
+        compatible = "img,spdif-in";
+        reg = <0x18100E00 0x100>;
+        interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&mdc 15 0xffffffff 0>;
+        dma-names = "rx";
+        clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
+        clock-names = "sys";
+
+        #sound-dai-cells = <0>;
+    };
-- 
2.43.0


