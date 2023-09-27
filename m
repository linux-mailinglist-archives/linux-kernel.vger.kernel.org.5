Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6667B0A93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjI0Qr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjI0Qr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:47:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7853DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:47:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3512efed950so27403805ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695833246; x=1696438046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xi0NPAXOKB2g4KhPtyHEVHOc+BFF5U0uejfT8FKn0j4=;
        b=ANev2KbLmjb0e3xXYqld5zgaRI70VN7XQUK2fw4yoVdiTpStIFJOWFiDu5iAG0/TlR
         QzKwtdNwFhFVSdaRLUTGMwhGfGJ8IYpK2yeVwHpmq0ZbbHLse2Xs20C6sdbE2lUFROrg
         RzTogpyfS5f+LKAQlCXyASltpGj5d2dHUbVPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695833246; x=1696438046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xi0NPAXOKB2g4KhPtyHEVHOc+BFF5U0uejfT8FKn0j4=;
        b=sjjzTHtTV1KipmmMIpgwx9CI7UpYVwNBneUalaooYwIZW3NbJZkd42b3D0SZWVKeSQ
         LozcIu/Rui77fKIzCfey2FfZuTdrd5+2e6X3DBcZ4vmTwTps5d3W9vJorBVaqBnE0P/m
         5M7RQPK1cjyAhZHnfpGWwTbzp2KUPMxf5fd8SdcU4Ye/qjFvzQHRz8RXM0SJPe6oZPsv
         if+KhQ26zJkLrjCoDaCu5wto3Z1E5H4vj1g3sP8725l/BdazCaOiVVCZDE63f4mZDsav
         849SixP7/hptVsmIuBr0pN8rVDAhdY+B2ffwsVb1bNt404hNzZPp9kF6+Wo7noZFhI66
         4ghQ==
X-Gm-Message-State: AOJu0YygjmXvCJLy3rkjHwcuIdINJhqW3DKkrjKaAPTuiEgnkK76mM+u
        XG+LKmSqnhl4Q9hD7Z3yecNIaEi3DsJbWQtu8nQ=
X-Google-Smtp-Source: AGHT+IH+JcaNhVNz7FfFGoWF8iw2OSTtskunRegjjj1eGuC9QOYwU8eTORJoA1lvodxfPDArPEpPZw==
X-Received: by 2002:a05:6e02:12c5:b0:34c:ecc8:98e7 with SMTP id i5-20020a056e0212c500b0034cecc898e7mr3216823ilm.9.1695833246163;
        Wed, 27 Sep 2023 09:47:26 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5d4f:fe51:5575:6f76])
        by smtp.gmail.com with ESMTPSA id ei25-20020a05663829b900b00439eda8c1c1sm3980500jab.111.2023.09.27.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 09:47:25 -0700 (PDT)
From:   Simon Glass <sjg@chromium.org>
To:     devicetree@vger.kernel.org
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>, Rob Herring <robh@kernel.org>,
        linux-mtd@lists.infradead.org, Simon Glass <sjg@chromium.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Nick Terrell <terrelln@fb.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: mtd: fixed-partitions: Add compression property
Date:   Wed, 27 Sep 2023 10:46:51 -0600
Message-ID: <20230927164654.3397353-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes the contents of a partition are compressed. Add a property to
express this and define the algorithm used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Just add a compression property for now

Changes in v2:
- Use "binman" for compatible instead of "u-boot,binman"
- Significantly rework the patch
- Use make dt_binding_check DT_SCHEMA_FILES=Documentation/../partitions

 .../mtd/partitions/fixed-partitions.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
index 331e564f29dc..13ff313cabda 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
@@ -29,6 +29,24 @@ properties:
 
   "#size-cells": true
 
+  compression:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      Compression algorithm used to store the data in this partition, chosen
+      from a list of well-known algorithms.
+
+      The contents are compressed using this algorithm.
+
+    enum:
+      - none
+      - bzip2
+      - gzip
+      - lzop
+      - lz4
+      - lzma
+      - xz
+      - zstd
+
 patternProperties:
   "@[0-9a-f]+$":
     $ref: partition.yaml#
-- 
2.42.0.515.g380fc7ccd1-goog

