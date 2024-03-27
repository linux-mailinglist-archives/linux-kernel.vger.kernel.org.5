Return-Path: <linux-kernel+bounces-120343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB80988D60D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1F01C230D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D8B17BB3;
	Wed, 27 Mar 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2LOMQek"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC94A35;
	Wed, 27 Mar 2024 05:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518600; cv=none; b=NiewU+ge+9yCm9ltPE6wBz25Nq0HWOeeUzmiQjFz3ITTitjDoYWDUWH5Ge3XgXEK3BSL+C83VZbMCKJDssFYDhlR1XyOalDRzbfz0EHX5ScjikZMzqaQRfbPaXEZsLJu0l1e/xZWilY3CJE09kx4foCy2yqgphsIcVJh/l1UrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518600; c=relaxed/simple;
	bh=FHstnsP1SDrBUHQB6q/i/oufx2RAf4ywwFzHK0KTvDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jX+G3XDLDu4IWCMmzTMK2iIZjHbrkwn5dagfwiB40ImmwHZ2HIooNGi7/StiZQG806Ob/IqvOsfIAgPR+VI0GBuVSmSr3op8r4NvJF+cZGs6sxklejUAu8TUGAO887/+Uycv6azhCDRzRjZS541ICdEi61GcjSgP0sf+3oIpiZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2LOMQek; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dffa5e3f2dso41460545ad.2;
        Tue, 26 Mar 2024 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711518598; x=1712123398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7OYcKJp51JHzqHwSq9XW851pfhTE1Ptp9rlfuz3R/c=;
        b=Y2LOMQek1HWcsx/2cPHQY85aS0zZn/4lOH9zC7IUr1Ffh7yDYgma3hrBrikIC3ajAq
         okIllRKD2wYBucAvjSfQFFEkx5EBmDy7/Sdmq/JuZCz4AHWfqwBX3j7wZfwx5msMmlfa
         VKHRtqHHtIZCLU6wdF4nzJuWZiTOPQsNThT2UKkHtl0QgRagmjJNQGlXwnLX70Uzld/h
         Q1CXZluJ3FxBtJ0806dyojf4IR5YtGRZC/tbrO5DjL5cf5te/u2J5CEd1VAoC58kiXMC
         KGWJfXlfILRSV8yHEwj+KOHDlshWWUcqnjoOvH5bGDeamFRNzzs4+pthbh7qtkreTOTk
         Tyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711518598; x=1712123398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7OYcKJp51JHzqHwSq9XW851pfhTE1Ptp9rlfuz3R/c=;
        b=m0gc2RJTp8PAky6S+v0BeRF/zKBUQQzV3S/WX63rGe27yNkaghy5086YMJYqFQHQho
         fzbpkWqHUw6l18g3NM/Mvz4hPn5oVyXTTOb/9wIXwhoHXkK7OUoyEqd7AS1AodlAle4M
         MWnFTNwZ4T/YLPiVEk+LlCmVug4JF+zKObbV4jwuRHbHbk3+v1iRAqAWXv4Nxq50UAq/
         AIUsLSOibpu6YPzMAHwS0HRQyhb0co0QymPHnubRZt/BYwFuixt8mpYI5aiPK/M4I4Es
         h1Kb+dwNCAUimn6pMUnMTEfc92O1T0787ep8NgoG2suBXr+XH5J+XmHm0wyYxPOmnWKS
         J9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUbAb560ybYVrG6e/r7rsCEYENBRNjuzzL/ZoV2znsUXkLkwgoR8cexjozHDmZWpIQ2UFcB7Rrft47hl1xieMVTQbrf2YKw/JIGMfW3eV0Qk0vpsAumWTnwEctcyUtum4f8zPWMwZ47O5ZXYRRHZfk/ZW/N1Solgod1XffPfQ5viKB6FwVAhw==
X-Gm-Message-State: AOJu0Yw+w0KItWt+PX08mSZMdLKMUk/kD7XV3mD4JzoNdAA+MsGfInVj
	Q6rvCRydnIYC7xBs+dnLi7QBWhDHJ+Hm1w0fjho7QrsPUIAQJ+bn
X-Google-Smtp-Source: AGHT+IGMXSmuZrJ0pAAbisJq5ouEdATuxX9zC6nD4xEns155NaylWRnsFrQ06hSn2zG9SE67Bd4vqg==
X-Received: by 2002:a17:903:2409:b0:1e0:d630:f18e with SMTP id e9-20020a170903240900b001e0d630f18emr361813plo.14.1711518598242;
        Tue, 26 Mar 2024 22:49:58 -0700 (PDT)
Received: from fedora.. ([2409:40f4:37:3d1f:3a25:2b3d:10de:3da2])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001e0b863b815sm5761707plg.96.2024.03.26.22.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:49:57 -0700 (PDT)
From: Animesh Agarwal <animeshagarwal28@gmail.com>
To: 
Cc: animeshagarwal28@gmail.com,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: crypto: ti,omap-sham: Convert to dtschema
Date: Wed, 27 Mar 2024 11:19:06 +0530
Message-ID: <20240327054911.43093-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the OMAP SoC SHA crypto Module bindings to DT Schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v2:
- Moved vendor specific property below more common properties.
---
 .../devicetree/bindings/crypto/omap-sham.txt  | 28 ----------
 .../bindings/crypto/ti,omap-sham.yaml         | 56 +++++++++++++++++++
 2 files changed, 56 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/omap-sham.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml

diff --git a/Documentation/devicetree/bindings/crypto/omap-sham.txt b/Documentation/devicetree/bindings/crypto/omap-sham.txt
deleted file mode 100644
index ad9115569611..000000000000
--- a/Documentation/devicetree/bindings/crypto/omap-sham.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-OMAP SoC SHA crypto Module
-
-Required properties:
-
-- compatible : Should contain entries for this and backward compatible
-  SHAM versions:
-  - "ti,omap2-sham" for OMAP2 & OMAP3.
-  - "ti,omap4-sham" for OMAP4 and AM33XX.
-  - "ti,omap5-sham" for OMAP5, DRA7 and AM43XX.
-- ti,hwmods: Name of the hwmod associated with the SHAM module
-- reg : Offset and length of the register set for the module
-- interrupts : the interrupt-specifier for the SHAM module.
-
-Optional properties:
-- dmas: DMA specifiers for the rx dma. See the DMA client binding,
-	Documentation/devicetree/bindings/dma/dma.txt
-- dma-names: DMA request name. Should be "rx" if a dma is present.
-
-Example:
-	/* AM335x */
-	sham: sham@53100000 {
-		compatible = "ti,omap4-sham";
-		ti,hwmods = "sham";
-		reg = <0x53100000 0x200>;
-		interrupts = <109>;
-		dmas = <&edma 36>;
-		dma-names = "rx";
-	};
diff --git a/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
new file mode 100644
index 000000000000..d69b50228009
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/ti,omap-sham.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/crypto/ti,omap-sham.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OMAP SoC SHA crypto Module
+
+maintainers:
+  - Animesh Agarwal <animeshagarwal28@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - ti,omap2-sham
+      - ti,omap4-sham
+      - ti,omap5-sham
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
+    const: rx
+
+  ti,hwmods:
+    description: Name of the hwmod associated with the SHAM module
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [sham]
+
+dependencies:
+  dmas: [dma-names]
+
+additionalProperties: false
+
+required:
+  - compatible
+  - ti,hwmods
+  - reg
+  - interrupts
+
+examples:
+  - |
+    sham@53100000 {
+        compatible = "ti,omap4-sham";
+        ti,hwmods = "sham";
+        reg = <0x53100000 0x200>;
+        interrupts = <109>;
+        dmas = <&edma 36>;
+        dma-names = "rx";
+    };
-- 
2.44.0


