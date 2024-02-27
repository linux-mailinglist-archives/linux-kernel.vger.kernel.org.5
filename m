Return-Path: <linux-kernel+bounces-83671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B669E869D16
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906F41C22232
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16A38DD5;
	Tue, 27 Feb 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b="m4BDBgQa"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41E249F5
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053470; cv=none; b=FikmtguWqCM48+5ONbIMHXUWLFaVu91alAy8nmeJIiPRp9bqShb+jUj46HP79jEDEMwnTNJhFesGhs0QOKQwCVmuRF5PComIXCm/btfdtq2p16cPBobxYc3CcG0D3DckeQs/2vafGFsnM4GtMYPvIzReMBGv5HCb2scbjma6n20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053470; c=relaxed/simple;
	bh=3Bc4JcS7h3uh1nH/uBs22YCORPrgVtcxn5c73BZBvQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fowp4C+pwvC2jqYSmyIRzRpSC3VTbcpXXVJmO+cKU08DEJHw+3+HI8HeclvBxkOpOTiAcgCdOcbyY0ELNN9cEp12460DZmtTlwqSaaFAvRoWFbJDpstVnvKvH/jOcdN35Z/1mWl9/P8BzwQStH5eEYx6OMuZGjdpk9CSwwiXQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es; spf=pass smtp.mailfrom=udima.es; dkim=pass (1024-bit key) header.d=udima.es header.i=@udima.es header.b=m4BDBgQa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=udima.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=udima.es
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412ad940fe8so6100165e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=udima.es; s=google; t=1709053466; x=1709658266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95wAwQRxYUW01FCwrYdkBVJ1oY3jiTOrAj5JhsuFKJA=;
        b=m4BDBgQad81TVza+0OI/6wCY4KyKoA+RnRkwbPHmJtBa18ydRGofiWs4VL2hTQHU0X
         dE+p887HVmMBmoLTWD5bcg+Uf2oTNfNG6c1AS2JVvOHY/S5ZU/9Qy5bm6Mx7S7OP1hq2
         IaoM9mZ2I67UhPfioAlTexQrHSmQvA2ZLHqJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709053466; x=1709658266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95wAwQRxYUW01FCwrYdkBVJ1oY3jiTOrAj5JhsuFKJA=;
        b=tlK6dfg4Iu2pFoNtss4hywYqSBRX38tkZzEuiyDBIe57yHdEqV5Ee3bmuMUKLVBhs3
         1fBJKfxBiNfyiLt35yVtiZUsIAIZ7/cXb/k7Ru5g8I9ta+qhsNntciAXmUCV+gkXiIh1
         sxjrKLa6MA6Qj8GvbBiquM4EfXCSMkE7BXEgLoHmLCdzl1hcC9ejG5jrvqVtuShkYuBT
         IlidUX7/0Trwng7Ej+x5rZ0mjoVTJyqZAW6QX6wLVwDbIEaRqOCYykvFOgh9aEv7s6CZ
         bSPKp0S0u8Q4l9MposOBnbCHKymeKbJX1F1ckvq2AabzjQqUG1r8TesXXXqYatSLcqSU
         lcAA==
X-Forwarded-Encrypted: i=1; AJvYcCUTECNAxljAQ9Dy5J1OD9G4YI09Nc+hdgHiq9tm3in4NJvay6M5inCfsaMvEHCLXQd51JNMil+1lqUhxirBmuYtJX1yVktbAektkByL
X-Gm-Message-State: AOJu0YyRhF183UHUfVmkIvmQvJdYbh2y9X0qHiIg5LXdNZh//2Xz772x
	Yo09CWh69WTODrl76gg+YnK9QosKCGmU6RJ4j/cZ5ZQz0yfscZabGRlTi0DbDoQ=
X-Google-Smtp-Source: AGHT+IGB1KvOAfDXWLVJwto/yIheyZ7CkEm/iZR711gDYwaMLA+8/p2ysr7MGqvci2mwbSoHCmzwMA==
X-Received: by 2002:a05:600c:3508:b0:412:b0ed:f18f with SMTP id h8-20020a05600c350800b00412b0edf18fmr640238wmq.21.1709053466496;
        Tue, 27 Feb 2024 09:04:26 -0800 (PST)
Received: from portatil76.udima ([79.116.0.170])
        by smtp.googlemail.com with ESMTPSA id j12-20020a05600c190c00b00412a5a24745sm6316878wmq.27.2024.02.27.09.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:04:26 -0800 (PST)
From: =?UTF-8?q?Javier=20Garc=C3=ADa?= <javier.garcia.ta@udima.es>
To: 
Cc: daniel.baluta@nxp.com,
	javier.garcia.ta@udima.es,
	daniel.baluta@gmail.com,
	broonie@kernel.org,
	krzysztof.kozlowski@linaro.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] ASoC: dt-bindings: img,spdif-in: Convert to dtschema
Date: Tue, 27 Feb 2024 18:03:56 +0100
Message-ID: <20240227170400.705862-1-javier.garcia.ta@udima.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227123602.258190-1-javier.garcia.ta@udima.es>
References: <20240227123602.258190-1-javier.garcia.ta@udima.es>
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
Changes since v1 and v2:
  - re-written the subject inline to include relevant prefix

  - Node name changed to spdif@18100e00 to be more generic

  - Added maintainers from Documentation/devicetree/bindings/sound/ who
    should be added to the maintainers list?

  - Drop reg description

  - Drop resets description

  - Added $ref for dai-common.yaml

  - Removed unused dt-bindigs/gpio/gpio.h include

  - Added reset and reset-names in the example

  - changed example hex to be lowercase

 .../bindings/sound/img,spdif-in.txt           | 41 ----------
 .../bindings/sound/img,spdif-in.yaml          | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 41 deletions(-)
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
index 000000000000..ab8f96cc37cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-in.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/img,spdif-in.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagination Technologies SPDIF Input Controller
+
+maintainers:
+  - Liam Girdwood <lgirdwood@gmail.com>
+  - Mark Brown <broonie@kernel.org>
+
+allOf:
+  - $ref: dai-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - img,spdif-in
+
+  reg:
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
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+    #include <dt-bindings/reset/pistachio-resets.h>
+    spdif_in: spdif@18100e00 {
+        compatible = "img,spdif-in";
+        reg = <0x18100e00 0x100>;
+        interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+        dmas = <&mdc 15 0xffffffff 0>;
+        dma-names = "rx";
+        clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
+        clock-names = "sys";
+        resets = <&pistachio_reset PISTACHIO_RESET_SPDIF_IN>;
+        reset-names = "rst";
+
+        #sound-dai-cells = <0>;
+    };
-- 
2.43.0


