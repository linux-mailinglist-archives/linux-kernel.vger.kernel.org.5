Return-Path: <linux-kernel+bounces-119859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B69B688CDD6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACB81C3940E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD58B13D504;
	Tue, 26 Mar 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+L2nwDA"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E6313D296
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483616; cv=none; b=e9++jJx5x46YQS6D1fKhW+kVupz7wHYkqzorG09qDa77ip6rhh2YsCqvTK4uh6MuY+9QB7vKKsS9ztrcAV5pJJ0kIos464nPaIzpYLNEYK0RkS2EHLOFBfA6vuq3KdYhYWy+81r8ZTPHZ7HRy0/mq/rEun60lH+qFXTjXhExsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483616; c=relaxed/simple;
	bh=FGyi8jCeLG9+F63Cjvg4FXEcck4eJUhApsEhbStA0C0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUSuzUTkNNLZRPqHCE1L5FkjqkCJN12XJJbHbqQEkR6EOiAO5YaaJm2wO2kNmp465rW79FNA3/0do+QCrLW6RU9xxTsKMfZbHk9hwQ5Dn+me6zjql1RxzMZ7GmfCmfUkyJEU/ZvWUQh13mkyrEgB1rA72zhwq2SdZ2OIH7lRMUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+L2nwDA; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-366a4bcb2a8so27881485ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711483614; x=1712088414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8EEc3adyFE7Wxfe+nLm4ZchWJV+nLrr+8hBvhQE2L0=;
        b=P+L2nwDAgA1uo63C8/iMbXAfcV8u74pVGz6ZS5mxOp9GyD51+aUYJIGAPg1s9anKde
         Iusq7lJSTmqtCj+yDDiFmdzurI4Cr0Bmj37DBLxWVS5Vs78UdG9gYwFw/z9lhGpVC0Kt
         yswFmNcVIwiBuW9NUDecA3e5sTgMCRndr8Vzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483614; x=1712088414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8EEc3adyFE7Wxfe+nLm4ZchWJV+nLrr+8hBvhQE2L0=;
        b=MrXrDASVAdkgrEJUTRcMuuFiijEfqHjnDc8jXoh8YzYGziFqvZZd4XAj33ZrKLynmX
         MBO9LN1m71aDm1L12LNnk4xlILPMeXohHw1x3XkKpBSuX8REEkp0nCddwlQHA34CzD84
         AFvEZw3LDUDXlKoBfjt1BZGnMxNfBkgtTCaSRrfdiflg7SDtG6Nj95xm0oiT/naxi7xO
         4Bmv+R6MoUJCRpSQM+cvxui+QaPW97uFF6LV73LHqJUYQITXZxk4HUFhjdCIvtZYBWro
         C5I2p6qTOS01jfe1aM0Gkko/GFfZ43UsIvKQStxtrysqcwc39QUodGAvNC+4cqLJ4vhP
         Mbzw==
X-Forwarded-Encrypted: i=1; AJvYcCXwBadjWlKulhS9Abt+bALj7I0CrOm8oFauWvIp8PQsIv2mFkXj6Wlm1/FyaQE66hQS5MayJqYf5POxpLhHwJegmflaf5PHcKOk0ofb
X-Gm-Message-State: AOJu0YxqMHQNGja/Odbi7+IUcZp5hgFoIrR3c9rGrEcy/yyI+IL13uZb
	miS1TDiEkGujJ7nRGDcpzgOKdVk0qI4MAp3WBpiTHWIDSCVkFXOx0p8o8qPcsg==
X-Google-Smtp-Source: AGHT+IEEDeZcsz5sXCNnD2ZC6a2Wo23FMused7zzkcdVuJSmg7qZ+plRlZe/HcCYGC8F13GS4tmU/w==
X-Received: by 2002:a05:6e02:1a8f:b0:368:8d20:b18a with SMTP id k15-20020a056e021a8f00b003688d20b18amr10568423ilv.29.1711483613849;
        Tue, 26 Mar 2024 13:06:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id f4-20020a92cb44000000b0036896f76593sm1002343ilq.85.2024.03.26.13.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:06:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Michael Walle <mwalle@kernel.org>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Tom Rini <trini@konsulko.com>,
	Rob Herring <robh@kernel.org>,
	linux-mtd@lists.infradead.org,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
Date: Tue, 26 Mar 2024 14:06:45 -0600
Message-Id: <20240326200645.1182803-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326200645.1182803-1-sjg@chromium.org>
References: <20240326200645.1182803-1-sjg@chromium.org>
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

Changes in v10:
- Drop binman,entry since it is likely not necessary
- Put the description back

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

 .../bindings/mtd/partitions/binman.yaml       | 53 +++++++++++++++++++
 .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
 MAINTAINERS                                   |  5 ++
 3 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml

diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
new file mode 100644
index 000000000000..bb4b08546184
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binman entries
+
+description: |
+  This corresponds to a binman 'entry'. It is a single partition which holds
+  data of a defined type.
+
+  Binman uses the type to indicate what data file / type to place in the
+  partition. There are quite a number of binman-specific entry types, such as
+  section, fill and files, to be added later.
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
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 656ca3db1762..bb3c326c6588 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -118,3 +118,24 @@ then:
 
 # This is a generic file other binding inherit from and extend
 additionalProperties: true
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
index a848d6ca67e4..1eeb6ebde21f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3639,6 +3639,11 @@ F:	Documentation/filesystems/bfs.rst
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


