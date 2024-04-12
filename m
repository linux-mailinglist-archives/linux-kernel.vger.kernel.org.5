Return-Path: <linux-kernel+bounces-142959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD28D8A3287
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1B5B23650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89F1487DD;
	Fri, 12 Apr 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T/c6wPmx"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E4147C90
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935976; cv=none; b=MZ50dXQnowmlUmSIagM7D6oGe6WKoQUS8PjTnmpPTVZaP4BMigS/+ANAuuaEVva8xZx/N1YEyXXl0+FkZbNpcgK8tjUryKBhfRumlrNrxU+RH2yz4ld0SUhvo5P8+wHYVDsuFOP593Eu/0I9FpUdpKnsU6Or4GO7gjv1uB2oYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935976; c=relaxed/simple;
	bh=VRJH6JB+IzY6tdn1LAeG5Ibt80aWtkhZqlui69b/CZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GiBQmnOY6dYZyWSUibJGkMievVE+aAixncvBc15PE4zwoDNs2ZV/MGKQ66UuM/FQRE9f5+l/soWtlEgkd6Wjja72qGlGiaxFBqp9G5Xs/ERWXPa5oIuwrrde2VSaQsMdVdODIWxMpmhTH+x3xX/bmC7y/167mLNPJ5xKYSAjwVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T/c6wPmx; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6578e8262so40240939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712935974; x=1713540774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVk91NoB1mb4Ya4VZgNI4Mqy/+sMIdBT8JrdncMceds=;
        b=T/c6wPmxNFbdAeqWqTBgTTMNTaBVDIn24Q0yskQxLN+J2QS1TBdz0+GXNJc5VWu12T
         7NPVULYA8qEkKCztxi4INhjjhfOu8vLWzGeVYnwXQb3HeTMAEEfvZJbzWx3/UMZBSzcR
         OTsCZdwFP/uJS4/8bM9MdkZs5h6+vfGYE5NFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935974; x=1713540774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVk91NoB1mb4Ya4VZgNI4Mqy/+sMIdBT8JrdncMceds=;
        b=bVw24HeXNHkpSGooBW4kx7lRazB7ILGh/mk8Cj6GFLHzPqLyrudRf1aAKBPeY36qc+
         u0eu5agip5KqyykSUxbru2ClTotidrXWLJhfk5wLllYxkjVBjFkPd+9/VoptDvieUaID
         DrELnS3Xcl3YJxCQ2Jmq9N0ytMnc8BJnc0ne8xYPuOPQHaR+UljpxxRDM5Dt8Lreeyyw
         alLst1/XOyKCgUxfyMEQohyJb8OLKusWMuqE2GovPRrk0OFas/oZpJK/9sgv/RyQBNIh
         nW4vXT9VvG1o/sP3/F+yy8r7rjIwU5r0IIaOTpnIaAdh1BW0MZNTOcJhy8qosOMP7iyU
         Mu6w==
X-Forwarded-Encrypted: i=1; AJvYcCUfxonQEgfTJhZXPRuZ5hv9tkMnJaQcq2gOR3FD//VxbqrxGBDUC43BcXuULT8mBx9hFxK9QlpwMle9f2mJZjLhi2nmo1bocfthzQnA
X-Gm-Message-State: AOJu0YwsugjkGwpliAL8AN8NZsWclAn/ODSHqFyh+XVocNAHa1ED7UKb
	uOJln1U9cD/RCr+4qOhjy2jXzVRlzOgBANvV18YkBaMhOQ020A/b8TE3MZQBfQ==
X-Google-Smtp-Source: AGHT+IGkiz6PwnIU+zNzBRMsgrX6Di+Gl2zPGrx8z9DynYpgkn7YBpjO4V9dGup0bH7vtQLmpvwvBw==
X-Received: by 2002:a05:6602:3d6:b0:7d5:f3d4:201c with SMTP id g22-20020a05660203d600b007d5f3d4201cmr3209346iov.21.1712935973913;
        Fri, 12 Apr 2024 08:32:53 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id ik14-20020a0566026c0e00b007d65a95d95csm1093828iob.42.2024.04.12.08.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:32:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
	Michael Walle <mwalle@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	linux-mtd@lists.infradead.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/2] dt-bindings: mtd: fixed-partition: Add binman compatibles
Date: Fri, 12 Apr 2024 09:32:49 -0600
Message-Id: <20240412153249.100787-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412153249.100787-1-sjg@chromium.org>
References: <20240412153249.100787-1-sjg@chromium.org>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v10)

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
index 31bbeb161396..80d0452a2a33 100644
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
index b1b074ce2cf3..b1a4ca692578 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3684,6 +3684,11 @@ F:	Documentation/filesystems/bfs.rst
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


