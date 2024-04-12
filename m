Return-Path: <linux-kernel+bounces-142958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034C38A3285
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 863D41F24880
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAB148308;
	Fri, 12 Apr 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/FmKeKw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4795914E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935974; cv=none; b=toRQVJrT2VGRt+zyPAB2ljnzQAeIIJeK1ndvdocit079qlhZQIEcDZTrYR44A1H5KjT3MC2qXfQQELaQRMkLAVt8vcbvIXGzJjwV6mgGljeGqQM+KAYxjg+l3i+DEe/7cRd1PSKbBLP9SrDD/PhSIZyjh+Z9+dfaC7bEEGc9wp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935974; c=relaxed/simple;
	bh=UFaq0ZdoaAokHjBDmb2GnGSnjteDkN3nqKEA8qMhodI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aORCWECf+21+z+d34LbIjSJSrr0KAk4KqYTkBijWcmrZTf2BFANH1VHpujcCeab0bjnoxxmGMNLTbZDs7Qla4orJ4+Vz1Db1ETRUz6kqjP2KhrUN8iTMKOEUFZkj5kzsT2+hAVQA5+56zz7PLLKzTyeCJhRwxdPsMMfoEdxQaIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k/FmKeKw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d5facf3161so36504039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712935972; x=1713540772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uqDcmcdfEAxpSmSYIoRjoyegxjm8YY6DAayxwa7eB28=;
        b=k/FmKeKwkP109g4z22eKPhum0evxOdrXuh9WFFgd+YiKVZ9ijk2zaNhsMi2h/PkW+7
         XYz/dICCp3j/KkBA9s4OwfVSL6iuabF2bSOHdpkP1BYFCeq2s3DiD4XHD4NQK0Z7Jeth
         KjXpZup5YyTan0IxPjF5+6A3meWnVe3hrbeqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712935972; x=1713540772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uqDcmcdfEAxpSmSYIoRjoyegxjm8YY6DAayxwa7eB28=;
        b=IwZyFlJSSK10tmMybgmXqtX3EucZZxYkVUUjmyInj5VJvQHV04EudYlCzeOmVTFMkI
         AWbu38UeLT4p/frFg0pTtsM/F3zgE2E406wQRLMEo4QwV7ew1+RNx+tjjzV/bYBNkT3E
         4hak3wlr53cfyOiTExvqNQxe+5tEAgqLfeb6fKYYApwZIRTDbhODZDr/XeRUeAK/mTwo
         nmqqMgdVB4wwEffWwi22aPuUHo+1004obL7yNDCrpyzMRMdMNNNSY5CTn8cLYqOZPDsI
         NSecXJRKKzNP7y7e8r15anElcB5e5zkQQYvLHgFQGEozit4ZblPp7SrosAgTsar4nsNa
         PvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYEvcbWClOr5/1rVYl++zKUXjrdf9o3ctouRafL9QjRK4rQizQYEx1w/AS5Q10DtWtswIghp7L8lkcRBWITHthvsQu4aTFi59j4BM8
X-Gm-Message-State: AOJu0Yx3zB/OwXCRD1By31N0Z1V5T91x0uikbqc5jJ/ZUweU5GZ9UlTl
	t3vPrODwxSYu5u2d+MFSw8k8vuv9M1Zt5eQ86jfOBU8XoAxd5txGFVibocSTdA==
X-Google-Smtp-Source: AGHT+IHbtl8u5oM4YD0V1cyL9JOfCkw7w+xIl41C6otd6LoyoE8+lKTPybLQ5MBLMHKFw5O2MCIjbw==
X-Received: by 2002:a05:6602:1a98:b0:7d6:3f52:2f27 with SMTP id bn24-20020a0566021a9800b007d63f522f27mr3223842iob.0.1712935972439;
        Fri, 12 Apr 2024 08:32:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id ik14-20020a0566026c0e00b007d65a95d95csm1093828iob.42.2024.04.12.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 08:32:52 -0700 (PDT)
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
Subject: [PATCH v11 1/2] dt-bindings: mtd: fixed-partitions: Add alignment properties
Date: Fri, 12 Apr 2024 09:32:48 -0600
Message-Id: <20240412153249.100787-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add three properties for controlling alignment of partitions, aka
'entries' in fixed-partition.

For now there is no explicit mention of hierarchy, so a 'section' is
just the 'fixed-partitions' node.

These new properties are inputs to the Binman packaging process, but are
also needed if the firmware is repacked, to ensure that alignment
constraints are not violated. Therefore they are provided as part of
the schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v11:
- Drop mention of Binman
- Use 'content' instead of 'contents'

Changes in v10:
- Update the minimum to 2

Changes in v9:
- Move binding example to next batch to avoid build error

Changes in v7:
- Drop patch 'Add binman compatible'
- Put the alignment properties into the fixed-partition binding

Changes in v6:
- Correct schema-validation errors missed due to older dt-schema
  (enum fix and reg addition)

Changes in v5:
- Add value ranges
- Consistently mention alignment must be power-of-2
- Mention that alignment refers to bytes

Changes in v2:
- Fix 'a' typo in commit message

 .../bindings/mtd/partitions/partition.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index 1ebe9e2347ea..31bbeb161396 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -57,6 +57,57 @@ properties:
       user space from
     type: boolean
 
+  align:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry in bytes.
+
+      The entry offset is adjusted so that the entry starts on an aligned
+      boundary within the containing section or image. For example ‘align =
+      <16>’ means that the entry will start on a 16-byte boundary. This may
+      mean that padding is added before the entry. The padding is part of
+      the containing section but is not included in the entry, meaning that
+      an empty space may be created before the entry starts. Alignment
+      must be a power of 2. If ‘align’ is not provided, no alignment is
+      performed.
+
+  align-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment of the entry size in bytes. It must be a power
+      of 2.
+
+      For example, to ensure that the size of an entry is a multiple of 64
+      bytes, set this to 64. While this does not affect the content of the
+      entry itself (the padding is performed only when its parent section is
+      assembled), the end result is that the entry ends with the padding
+      bytes, so may grow. If ‘align-size’ is not provided, no alignment is
+      performed.
+
+  align-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 0x80000000
+    multipleOf: 2
+    description:
+      This sets the alignment (in bytes) of the end of an entry with respect
+      to the containing section. It must be a power of 2.
+
+      Some entries require that they end on an alignment boundary,
+      regardless of where they start. This does not move the start of the
+      entry, so the content of the entry will still start at the beginning.
+      But there may be padding at the end. While this does not affect the
+      content of the entry itself (the padding is performed only when its
+      parent section is assembled), the end result is that the entry ends
+      with the padding bytes, so may grow. If ‘align-end’ is not provided,
+      no alignment is performed.
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1


