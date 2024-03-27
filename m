Return-Path: <linux-kernel+bounces-120334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB44988D5F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8644929F3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3DC1401F;
	Wed, 27 Mar 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5bumHTB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898E010949;
	Wed, 27 Mar 2024 05:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518038; cv=none; b=XDZl2qTvrAyJXU4OAiVhOxaDnc4UStgT2/99m+9o+q6rh3w8qmxog+sU8jYZniN50Q4IeMR5jcwwYk44d9fqNOtWGSs73Zi1fgZikdCsnQhVODMab7z4F/phIir11RWIU0cqD2X1fu2687/AOW2Olfrklu52ZN5yp/t52jsoJGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518038; c=relaxed/simple;
	bh=KKEp5sc6sFi1eq1upDmeSVzyDCa2sp6vUs9sPYMLjyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FplMI7sffQLYvmR4GS1SXK9+gfuwCFEWDC43yfkz1qDizYoHHc7bntcqGzUQ0ZpDJ8K6bOpfJsq/TazUCjaaXKEQxTdI3eOr5GaVrx/3z0dsLLCGw2mV4csyqrjFy+QjwCJMbVkpjYgDLUgVy4Kr1WXjKg7VSvh2/M5pHVc2WM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5bumHTB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29ddfada0d0so3528544a91.3;
        Tue, 26 Mar 2024 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711518036; x=1712122836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZcOrIhJIFiQ3b0HbHJAkzbepauO6QKGgBvXuK2i+pE=;
        b=E5bumHTB1K3lkjysaMPWhzEFIJ+VQSmXGoInE33TPFLTiT2GMh1FYXXoLtyL3/3+em
         d6M3exVi2oW7ypO46lvTQo1vwhPVvhfJVTx4Q7SQDPldWREv21BfGjcVTMav+Ll9fuyv
         D95BV0P/q/Gm+d0uyqgyZtVkniZArCHIStK7Tyq3yCaNbUur0lHgpsaI8FBEuC5MGbel
         ZIsZYWlK5hakVCiWg+ovqHPeUTEWWkKkeFJjZxrwNMFfJVde5pS9fWUaZofesJO+xYMa
         Emd3NS4t3FVJmQrdml5punmrvg8xX+alRLUb/uCU8a1ZXPLJAh0fEwvp1Q3gDK7BhkeT
         NNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711518036; x=1712122836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZcOrIhJIFiQ3b0HbHJAkzbepauO6QKGgBvXuK2i+pE=;
        b=C7FRoYQO90yyyq0cdjRt7JhFQq0pi8OQDl7QqrHKWCA8/Af8RIYQ6Ko+MqcH+8RTfH
         a3X38dtIHeAsHBnRUfgyJlmNb1OIILkIW0gi0wbqkp29jPI4dunA8KoEi4ZYU+ZiZsfn
         rpoZPpDRIF37PDrvHg0ct1e4gANgWhnOG7M2x2dYMAjbg8B0ms9n/9xUHApK6ASTCvei
         ByCfcxgFATWTj5gdjYhbmZLfwVpfPQbeMiXXryDdGOcm2pZ4uqYKNZxJCpwvF4I1Wz+3
         c11vRGcMPoJV4EAEt7J9QRuc4htcAKKiM+wLfWdPb8Pr03MhhrjFxR2SPMawmU1WzDl7
         xLIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1wHYK8flyQW6Q4LqGuSxYpVYo3J7gP2ADDP1q2xsCM9xFJoKnnf1wCwVllAw4qcnl1G3QkQoeNDWUVzvksYCLbhdddW4+gpLx7bB6ZKsVH6nDuIRk9/HKyPo9HoGuM7cz4IwMasbAWdp+CmuPCBPFBpgc9QGSQOxbVqC5iqh1x7cbPg==
X-Gm-Message-State: AOJu0Yz4ZXyY7Yg1hzkSdO/F5E0HKop05pbE50FviZiOl2HKWkHCKCjL
	l1mDEPjlVTrfittq6Kpgdxcelq7YeNmSq+WhM7k8OCUw6i68izRdEGaJjuI1Gcjl+TXs
X-Google-Smtp-Source: AGHT+IGOaG0gpfwiSadNSvtanAIQa1+D3zFUjfTLN9tDaL+YwYO90R+YQMEzTRrI0qcTfNjTzhrssA==
X-Received: by 2002:a17:90b:2d83:b0:29c:720b:5f95 with SMTP id sj3-20020a17090b2d8300b0029c720b5f95mr4290548pjb.30.1711518035855;
        Tue, 26 Mar 2024 22:40:35 -0700 (PDT)
Received: from fedora.. ([2409:40f4:37:3d1f:3a25:2b3d:10de:3da2])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a8b0c00b0029baf24ee51sm649437pjn.48.2024.03.26.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 22:40:35 -0700 (PDT)
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
Subject: [PATCH v2] dt-bindings: ata: ahci-da850: Convert to dtschema
Date: Wed, 27 Mar 2024 11:10:10 +0530
Message-ID: <20240327054014.36864-1-animeshagarwal28@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the ahci-da850 bindings to DT schema.

Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

---
Changes in v2:
- Added description for reg property items.
---
 .../devicetree/bindings/ata/ahci-da850.txt    | 18 ---------
 .../bindings/ata/ti,da850-ahci.yaml           | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 18 deletions(-)
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
index 000000000000..b8f31187f34b
--- /dev/null
+++ b/Documentation/devicetree/bindings/ata/ti,da850-ahci.yaml
@@ -0,0 +1,38 @@
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
+    items:
+      - description: Address and size of the register map as defined by the AHCI 1.1 standard.
+      - description: |
+        Address and size of Power Down Control Register (PWRDN) for enabling/disabling the SATA clock receiver.
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


