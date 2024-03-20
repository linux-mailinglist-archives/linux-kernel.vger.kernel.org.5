Return-Path: <linux-kernel+bounces-108446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD4880AA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922341C21BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F24E182D2;
	Wed, 20 Mar 2024 05:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VxivA3og"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E3417BD9
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710912308; cv=none; b=UCqmIfl0edhee8Cklw2O8tvqP690WQkdeTlSfcw6z4MhBhxqx4xDGN/iIRyaW1UwgVaUxZ6sKO43yfwXU4DrnhGegXe4yagUYKs+tGsZuHIhCaPz6swvg1GTpMfPOd4ZdcqJjH94zSFx+B8O9RpPeZUMxfd/s8jJezXXYyedKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710912308; c=relaxed/simple;
	bh=L+fDUJJrUavzHVpxVuN9H89qVhOCPqZqCUY/1bq4E+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJfS8dB5SzKr9SIaa7W9UAI3PzC38x1Zcy8I0aN5rSRyfELMdQgId4Rdj0lsbMlZedPpUio0Ll6Eell7wEwDEzLWnZ7zxp/QFciG7bPg87XJ/aeXj6+PfuU0qMeYqpu51Ju2oDa3ssPbN2acBCyWr79vkrJxen6SJl+fTgOkmdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VxivA3og; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso6024490b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 22:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710912306; x=1711517106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcuWLpfpwEQlI3/YVSySFA4Fv1Tx8PQOGU1A54pTOVc=;
        b=VxivA3ogBvCaVUQ/ZjeRvGHrRaO8LXeX+229pvcVwsBo7LznnvR2tqk50LCE5AQcNX
         66L4hf4wWYWPTsj3EQq3TpGzzOzvlvradCgXAf8xLPc8hbYzhyBFNWe6NJ4UAIl9yGby
         jDEjS1dvsyYflVoRZwDxOVE5jdJSMNXBFiCEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710912306; x=1711517106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QcuWLpfpwEQlI3/YVSySFA4Fv1Tx8PQOGU1A54pTOVc=;
        b=tr8hU0gZD/XQwZcqjw8Ytupu4WEW6MVtyArpWA7UhxeIbb7SAYMsP0ZQw9G7FpH6kv
         ncFhAiIrrapvzG8+421mWtfXSh3CVcv5uLiHidWinoFWogVedkS2D2Q/CHaiyW8NsRn4
         zeW8I4baWkng2DqL2HM0INx+65ECOrP6rq7GM7sONv/d14ps/7mL0EBttJ8dY9vX/bYL
         CM2QL2hlqLGZn6qUT7x2dJlQUQ6yo7F65DMas3Kdnmd6P1vXV0DIHSnsEOmcFkqfA8qf
         8qyExjCMVn2O5A5csafxVQ7NOrR0LOuuJoA2cTx5TVJnFhgQoBwhxhTrcN1GNEc5qMfT
         QTxA==
X-Forwarded-Encrypted: i=1; AJvYcCUG1r8ZZ8bxXnEVDanNzcebjjURuYq1LU/3Jk1E9BEiTrRB+iFlXE/laYkMWZrun0gp4JkTnxBTvdS320h24G7pAa121+Qc8FdFZl4I
X-Gm-Message-State: AOJu0Yxyc4RGv6sv5QBGqNrlgjn2ce7IVXNSmIBkBaFI95SJuV4kZDVp
	NRTsxo8oPxaCdyth/Sibq+52tp0m39Uz2FdNYXLa9J4nnXE9WW0OFfO7T9fkow==
X-Google-Smtp-Source: AGHT+IEExdv2ILwyCgyYcA4XcseoU8HlmCfQWxTr6g04DTIjaLHXQo6TTQWZ0bxCnwHWDSnJWZ6SoA==
X-Received: by 2002:a05:6a21:999a:b0:1a3:55d2:1483 with SMTP id ve26-20020a056a21999a00b001a355d21483mr10628115pzb.5.1710912306340;
        Tue, 19 Mar 2024 22:25:06 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
        by smtp.gmail.com with ESMTPSA id sb14-20020a17090b50ce00b0029ffba4bf0esm572355pjb.19.2024.03.19.22.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 22:25:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: linux-mtd@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
Date: Wed, 20 Mar 2024 18:24:49 +1300
Message-Id: <20240320052449.175786-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320052449.175786-1-sjg@chromium.org>
References: <20240320052449.175786-1-sjg@chromium.org>
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

(no changes since v8)

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
 .../bindings/mtd/partitions/partition.yaml    | 21 ++++++++
 MAINTAINERS                                   |  5 ++
 3 files changed, 75 insertions(+)
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
diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 39c7d7672783..3df12df06116 100644
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


