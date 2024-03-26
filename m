Return-Path: <linux-kernel+bounces-118955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A5688C1E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561C41C384BC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92271B2D;
	Tue, 26 Mar 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kd71Eoxp"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1833812B6C;
	Tue, 26 Mar 2024 12:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455480; cv=none; b=rzM/wHkbadLdHtVfGJ+QNEnDrJwFLfeWxnVNq86NbP0eA2dVN3hMIybiu8JzBQV4wUePT5rUY4VQ1xIMvi3J9Fo6Ev7Dc6Q99mI4bVLSOlzwpE5Hpj/CH2tnnH35U+Xfggc61EAenPmDpT/20DAkQu2c3w3Zrn3fLamp0hjA23Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455480; c=relaxed/simple;
	bh=SZpe6jdHkKyQfyGM2FX+SQHSwwtIaufimKkdrPF/nWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d56rHefKy56tqRxXeG12UNWtihlvQEUxz5Q/fS07Q/dkSHIHAS0faO37YZ1e7QyA7tCKbjup3pmJGDkMR2Vl7cXTugkLdoLfKmGStU96J8rDel7b30pivfvXwMLiiC1Hg9rAyKL9dIDj0ybFpFRtOPS1m9mP5vaepY+FuvlCUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kd71Eoxp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso2929658a91.1;
        Tue, 26 Mar 2024 05:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711455478; x=1712060278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oaT5m0Iyd7jZvLkszdxr7iHrfKjSWwXKGCm7ndW3Vt4=;
        b=kd71Eoxpdca+bGq3W/DzBrddG+2cH+3qPHWBIfXb3zEW3yorrT6/L9SB0hLluE3I4Q
         BAe07HCvb0EmWH695YHS2x2obemSIbrpUyAVndP3cYRxc7h7otuS4bO96/QUw8c1mjzj
         CP+OZCw6v9EjPalXBzeVW3szJel9RqzWVEz/pJPR4Ekcs7iZn4oIoznk0wNgNxn7UZX8
         gyJFVwpVNetckIKw2NtE3ZMJ7TgbwPdHQ/zNreERaNbo6vJMRPWrWB9iQUjIWfiMLmD5
         5/iABOlQFb00uZRSltOJmIAdLYT6ttdZVZWDOONquCkTeplop5fJbtrFROKXdgPmM2LK
         LC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711455478; x=1712060278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaT5m0Iyd7jZvLkszdxr7iHrfKjSWwXKGCm7ndW3Vt4=;
        b=IPDzESRgM0CFWm1iacaaaoGWW+MmzqtsrrFbCAHtitba/0GOD77SbyWyk6f8/CroPV
         jNEERWmDUy3WeAA/tXet77ljEV3T/TZoPgueQKB51qNdKlSrN9+p934nq8BD/KnAtL4A
         GIFS/NQl0pB8Nsm2L/owVIjlrSmdjaegbleb6IbQ7c3XXV5CyXGHv4moK00QGnd+Iq+T
         tvSPO5PG0xqk4U7CMHjRZ4aEo09IYuF/s1Z4Nywd/iJPOl75sV/I+WtFiK4CUG2Klf4k
         e2MkI2oC3ggU+nXNR4/5JxOVrEXe8bSSaBkQOxK7zrCh/faS7GRAeEXYijF4IwcMDysm
         N5Mg==
X-Forwarded-Encrypted: i=1; AJvYcCVG8d7JVtBzAgKsHNwQV+GrPv21VxJNL6e+3rWbgFdosv/OKUXtNGrhjHF5oBfld1x4wHOBkcMQcSt07T7+4j82x5lh83esE71NkN08PP86UCguFJJ+URR5tAGuUCTeJ27siVvgJssVXV7yHOhvZKm8OzKM/AcHUyUrLmgzWrwcNlTzwg==
X-Gm-Message-State: AOJu0Yzb7mrq8Qxh2K2xTGOIypEwBeC7T2Vw0amLKx7X8pDLmX4erAAP
	N+FrRQTIak0AxMeh5ix+bYn0f22q0+u4+Ayq1+Fvl9x7oxao3tjc
X-Google-Smtp-Source: AGHT+IE5JFg/XWOvPTK11xWkHEHl2w/Tu+A9xRm6qkMWdNt1u5Zw6ejbvsYMXP4A8Ks3uNz9qggv6g==
X-Received: by 2002:a17:90a:5994:b0:2a0:8bba:f997 with SMTP id l20-20020a17090a599400b002a08bbaf997mr833325pji.32.1711455478320;
        Tue, 26 Mar 2024 05:17:58 -0700 (PDT)
Received: from localhost.localdomain ([122.187.117.179])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090ae51600b002a000f06db4sm11765779pjy.5.2024.03.26.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 05:17:58 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: ahci-da850: Convert to dtschema
Date: Tue, 26 Mar 2024 17:47:28 +0530
Message-ID: <20240326121735.11994-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ahci-da850 bindings to DT schema

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
---
 .../devicetree/bindings/ata/ahci-da850.txt    | 18 ----------
 .../bindings/ata/ti,da850-ahci.yaml           | 36 +++++++++++++++++++
 2 files changed, 36 insertions(+), 18 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
 create mode 100644 Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml

diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt b/Documentation/devicetree/bindings/ata/ahci-da850.txt
deleted file mode 100644
index 5f8193417725..000000000000
--- a/Documentation/devicetree/bindings/ata/ahci-da850.txt
+++ /dev/null
@@ -1,18 +0,0 @@
-Device tree binding for the TI DA850 AHCI SATA Controller
----------------------------------------------------------
-
-Required properties:
-  - compatible: must be "ti,da850-ahci"
-  - reg: physical base addresses and sizes of the two register regions
-         used by the controller: the register map as defined by the
-         AHCI 1.1 standard and the Power Down Control Register (PWRDN)
-         for enabling/disabling the SATA clock receiver
-  - interrupts: interrupt specifier (refer to the interrupt binding)
-
-Example:
-
-	sata: sata@218000 {
-		compatible = "ti,da850-ahci";
-		reg = <0x218000 0x2000>, <0x22c018 0x4>;
-		interrupts = <67>;
-	};
diff --git a/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
new file mode 100644
index 000000000000..d54f58c12e78
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ata/ti,da850-ahci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI DA850 AHCI SATA Controller
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    const: ti,da850-ahci
+
+  reg:
+    minItems: 2
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    sata@218000 {
+        compatible = "ti,da850-ahci";
+        reg = <0x218000 0x2000>, <0x22c018 0x4>;
+        interrupts = <67>;
+    };
-- 
2.44.0


