Return-Path: <linux-kernel+bounces-104900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDB787D52A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920831C22394
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE454903;
	Fri, 15 Mar 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bxnTuR+x"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFC5478B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535542; cv=none; b=Z5mR0Bo9S0PvjQY9h0nPZKBfoCgBhtrtkRfQlDukqN7kn8mW2PqQprA2uYiuQCy3Y/G64vK3Cj7mh1MUoNTphY03COPnkUtGwM9/9LcAe8JbP1pQ/fmjENPMUcoqTSi+VOeQ7nFrNZmwCfHMQaCaPTG8UOOi8Kx+tR6v+r3mPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535542; c=relaxed/simple;
	bh=qhRZ7KNcNZTG0t7m0MhJiM10BG0jCqjLES2YnkBc37c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gu9IkltVFEOzNPIBjNb+CxWuU5iAhjiTrRJ6XsiGfKYfVTaiggpnxe1KHaDThFbDGgyTPUz3kuN0UTQ5ykRVBOothWCq4DpWYWsSZMIpXpcR6AiRQXlRaXqRpJD4omnQzzdRTTgkXiEScj7uEm++tHTpj+ByyniQ2RjiZGixZgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bxnTuR+x; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so348521a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710535537; x=1711140337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5f3g6jt+SPPkTn9q3kiXsClKs8YsDQB9FBPsmFWqzL8=;
        b=bxnTuR+xS1UXRqEWoPmYQw4IF7KiYGUhacD8hDSycbe3LHNnk+8iJLebLL4pN19VW/
         DLcJRuRZddY4vlZrQcauyIS1Mw9F310zW/kWW8yifBCe1Sxrju/lZAyZUBpH57c0bGvg
         y0zgumfTdAP/oCmva1ALTWJR30P669hze3vn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710535537; x=1711140337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5f3g6jt+SPPkTn9q3kiXsClKs8YsDQB9FBPsmFWqzL8=;
        b=jdkAb3CWKtnY38O4UUR29rOOH3fduSKVrjyzadE6yTlb8ckHsditBlxvRq3TFDLpLS
         +II+y543DK2vU9Ahovr7p+hC7BPaSFYYfPVT8eupbxpVSQL5T0b7Jp1CedrH9kSFTWd1
         QooifPJ5wZeVsnscMwwvHDObJr0iusadkOT6iVsYfBqIxXcE1OuTd7u/0c0QtjQg+qNG
         4zZDNevpdqbxMJI0qL6yuLfDplur5z1LBe70Rd5GOwXnAT2Ww5+bkTKJhUVqZo/3wnmC
         WRtM87t99HpnXdA/rZsQP/jjTx5Wh5Y3ex9GwMpy0CvNXGAolyEXTmm0qhCSk4mbrTVU
         cPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNRZUx1wKswMM+3lBzGyQb4dfBco5qXwPXHfCuJT97tlZL8PpmFICRi3MykGDwLIUjRUeXa9s+N+NEgE4lC6iCDSd4Dg/I552lS4CV
X-Gm-Message-State: AOJu0YyjEqwqB1vwnZ/oi0WgOmIgIgD0lvKzf2/EucrYZQZ8SyQFAmQW
	o0o4C8IaG6Ba8DhlrcXpP7BwczN/RRa+XPQHnUdG/m5MBCNSaW5VUBbwOqxXKQ==
X-Google-Smtp-Source: AGHT+IG/MP/COIzylJY9BIgpwRYj+RjYQJGtY4FHk+hzIe5y+OmnhKRTDa2xdvlEOYm87TA6ZLifnw==
X-Received: by 2002:a17:90b:215:b0:29b:347f:23ea with SMTP id fy21-20020a17090b021500b0029b347f23eamr5423371pjb.3.1710535537628;
        Fri, 15 Mar 2024 13:45:37 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
        by smtp.gmail.com with ESMTPSA id iq3-20020a17090afb4300b0029bb8ebdc23sm3400516pjb.37.2024.03.15.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 13:45:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
Date: Sat, 16 Mar 2024 09:45:21 +1300
Message-Id: <20240315204521.28613-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315204521.28613-1-sjg@chromium.org>
References: <20240315204521.28613-1-sjg@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two compatibles for binman entries, as a starting point for the
schema.

Note that, after discussion on v2, we decided to keep the existing
meaning of label so as not to require changes to existing userspace
software when moving to use binman nodes to specify the firmware
layout.

Note also that, after discussion on v6, we decided to use the same
'fixed-partition' schema for the binman features, so this version
adds a new 'binman.yaml' file providing the new compatibles to the
existing partition.yaml binding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v8:
- Switch the patch ordering so the partition change comes first

Changes in v7:
- Adjust MAINTAINERS entry
- Put compatible strings into the 'fixed-partition' binding

Changes in v5:
- Add mention of why 'binman' is the vendor
- Drop  'select: false'
- Tidy up the compatible setings
- Use 'tfa-bl31' instead of 'atf-bl31'

Changes in v4:
- Correct selection of multiple compatible strings

Changes in v3:
- Drop fixed-partitions from the example
- Use compatible instead of label

Changes in v2:
- Use plain partition@xxx for the node name

 .../bindings/mtd/partitions/binman.yaml       | 49 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..83417ad5cee9
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman entries
+
+description: |
+  TBD
+
+maintainers:
+  - Simon Glass <sjg@chromium.org>
+
+allOf:
+  - $ref: /schemas/mtd/partitions/partition.yaml#
+
+properties:
+  compatible:
+    enum:
+      - binman,entry # generic binman entry
+      - u-boot       # u-boot.bin from U-Boot project
+      - tfa-bl31     # bl31.bin or bl31.elf from TF-A project
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    partitions {
+        compatible = "fixed-partitions";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        partition@100000 {
+            compatible = "u-boot";
+            reg = <0x100000 0xf00000>;
+            align-size = <0x1000>;
+            align-end = <0x10000>;
+        };
+
+        partition@200000 {
+            compatible = "tfa-bl31";
+            reg = <0x200000 0x100000>;
+            align = <0x4000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b43102ca365d..5b08ee363140 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3610,6 +3610,11 @@ F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
+BINMAN
+M:	Simon Glass <sjg@chromium.org>
+S:	Supported
+F:	Documentation/devicetree/bindings/mtd/partitions/binman*
+
 BITMAP API
 M:	Yury Norov <yury.norov@gmail.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
-- 
2.34.1


