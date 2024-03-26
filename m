Return-Path: <linux-kernel+bounces-119858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7734088CDD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EB31C65AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384213D29E;
	Tue, 26 Mar 2024 20:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1rEwJlr"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0105481A3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483614; cv=none; b=c8xHGGatlpuN/HLcQGW8mk8Vt0NXv3lCEoaKFeYZo862K+d4QkkkSAeJfpyIhYDD+wyhCattAwlmL3Q4FQ3f9eef6E0tGH0UzYxP8GrLsg2jPWhQnT4tZDzl/tPMIsjKNhMK+v6TcOya6u7s4ChCy7zEXfh6zjeA5JOU7Z6pUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483614; c=relaxed/simple;
	bh=KuLN8d0qnMcvpgJutdh0ul8iNkoqgbjGo+49RSgKIuU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qg+BZ6Xoe/QNf+TcdiH0q7eIGjqW76+HfzDOqoEZZMkyaic81VVKjLCigc6KErsFhvGNHsI5g59mE+tuxf0eUq28H+Top/lP9hkkdxTCch+tGLJtX+Hi8jI7OYiCsXK8+dQa651W/LnSI7Ty7yr2EXoetrikJ6Hs+TvTLbrsnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q1rEwJlr; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-368a02d28baso4630365ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711483612; x=1712088412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOoqtTXqNB7CbouRAVSQd0zkiIBmv+wfES6PKWSZxek=;
        b=Q1rEwJlrHnl9Lo/E75y9ooeOLgakZqOmOynBDwz5EKDcMExoY9Ea56EiHMNKoQxzf1
         7Pj7mGnXRjnZliuTFhvSpJ7LAf2F9SUe1VFnYH8gjQpj4fHHdOJy1V/EQRMyN78LChkz
         ywZCgGTPuCA6A6iqIbezF6P1qS/lmPkYn0blg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483612; x=1712088412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOoqtTXqNB7CbouRAVSQd0zkiIBmv+wfES6PKWSZxek=;
        b=LqDStvgjgTA+80XqGHE5DnPKBOoNT3W+tXi7el+MXNQ0isVvg9XjJYACfXgj9Hc1bI
         lYFhLBdVBJW6skNjwS3EK5dFOsWjsQcHRPnee9NnIhSWQzcrKfDvd0teO1JgUy8GOi3S
         kTbIYmo/CsWYyX1QOQ8qpz8ZFOdSJ0Rk2auhxlFFF0/ci7o7yPrc+Jhv4vTYQ4drM2nl
         mi3tv6d0jk5cPClYaQf5Qn91Yq1DS6497ACTGWMjEuw4BH7QxAsupBanBqf4IctRJOwz
         hUbELAXNieYNIFEApszIiFMdjARkvhkiWcSbzKt3y061zjlo3JAHvQIdcMjNCirUljR7
         SKlw==
X-Forwarded-Encrypted: i=1; AJvYcCVNo2GqHgs67oGD+DSztirOu154OmeWecVwUadVPlBQ9D7xY3EsV+MmXjZE+l1FctujvpolUheFUQuqUIesSvtWHpYe31A2Qj/s7bL7
X-Gm-Message-State: AOJu0YypVjH9teWeIYbydaA3Gi+sfcOQ4D0oE5Wtt5NBqDor4v2bWBSD
	fwJ/PwLP2e43u53DqlVceFDiQqtS6N0xA04W4U5OXzstGhmeH4xX4eJ4KAoOlQ==
X-Google-Smtp-Source: AGHT+IHTocnVcq9cstKtXGBQJuOibTyGsdLxHD14zpbkXXj+IHMGiLoZQLlFXo7FItBICbelmkTerw==
X-Received: by 2002:a92:ce50:0:b0:365:e274:5e55 with SMTP id a16-20020a92ce50000000b00365e2745e55mr908968ilr.7.1711483612066;
        Tue, 26 Mar 2024 13:06:52 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
        by smtp.gmail.com with ESMTPSA id f4-20020a92cb44000000b0036896f76593sm1002343ilq.85.2024.03.26.13.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 13:06:51 -0700 (PDT)
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
Subject: [PATCH v10 1/2] dt-bindings: mtd: fixed-partitions: Add alignment properties
Date: Tue, 26 Mar 2024 14:06:44 -0600
Message-Id: <20240326200645.1182803-1-sjg@chromium.org>
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
index 1ebe9e2347ea..656ca3db1762 100644
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
+      bytes, set this to 64. While this does not affect the contents of the
+      entry within binman itself (the padding is performed only when its
+      parent section is assembled), the end result is that the entry ends
+      with the padding bytes, so may grow. If ‘align-size’ is not provided,
+      no alignment is performed.
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
+      entry, so the contents of the entry will still start at the beginning.
+      But there may be padding at the end. While this does not affect the
+      contents of the entry within binman itself (the padding is performed
+      only when its parent section is assembled), the end result is that the
+      entry ends with the padding bytes, so may grow. If ‘align-end’ is not
+      provided, no alignment is performed.
+
 if:
   not:
     required: [ reg ]
-- 
2.34.1


