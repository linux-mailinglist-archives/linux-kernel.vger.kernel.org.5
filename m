Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AEF7BCE0B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjJHLN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbjJHLNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:13:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14F3D6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:13:49 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9b9faf05f51so384900266b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1696763628; x=1697368428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGvwmv7blnoHjX1qS2bGhDolAncwyiZsBGNZLg6R4Cw=;
        b=QWv/4MZhau5K2WfbYMvWbSjkfR/1c/JF5H9j5lj7RcDbGAE9cCMOfES00twBrFvm7Z
         RRz0TrykTvAuW6CIKVRKVXQZEda4yIblC0ZVI2sNAEvdGT2XMEviSGA4ZzacgpkIAbHU
         +Gz9ZADJs2j/DDm8llnjRp3mXDh0U/EoBQMfim5BNzAmaOTlBWnN7UBa0bpBPExrTc4z
         FkkO4A0vFHi1To86aGiFEOe8bm7BoVDkEddPafQCvTH2goDf1EKSJg+X0HQUEeWx4Ysf
         tYIef/zCUN+vmtphDBNBi/wQ+abQUzsuWtiIbLM0XchYHw0CNbiYbJfVWEBrkKZbgJcx
         /sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696763628; x=1697368428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGvwmv7blnoHjX1qS2bGhDolAncwyiZsBGNZLg6R4Cw=;
        b=CwFLz6XC72fjuaue/ke00mo5nbjRJPzkTa4TwhGKiWBSjl4jkL2wfkRzYMZAi+yd+U
         fipN1vAqR5p/DdB4FCqRKRzew1W45ZsNPt+Ss2GxZ3TnpqLi93hI5l+s+eKF301PE6Ac
         CTTdSlmQAzHG+QnpsGqPiIb20wcNjmobcGTAQTH68JCB5cBskQOlznj9ZN8g1ciQ+uO+
         1P/LjnLoWM2KlZhsfSj9wZsmYeOKGKCNEsIfYJBths/1lGWgYAfQWuE/Z/9B3ScKlJFd
         b9jwDFwwn0qmFwuaAVRNjlXqw3KshyoH+IXUpcU1poFrQaUXGkq55A7X7VsmocKdJ5JP
         3ccA==
X-Gm-Message-State: AOJu0YxvExyBDSNjc2mjRP8LJ1Nb4pEIwRhfG10+V+YQrFci0j0Qm/NB
        o3OJNkGXdysMkvsHE/aKs33DfA==
X-Google-Smtp-Source: AGHT+IE0QA27/V+vCqomxsUSXZAqQdvYTkjRYYSLNt6jPoolnR8WC8vIMJw/yOTtDhMBgFUY9V5PxA==
X-Received: by 2002:a17:906:3156:b0:9b2:b71f:83be with SMTP id e22-20020a170906315600b009b2b71f83bemr11113918eje.1.1696763628206;
        Sun, 08 Oct 2023 04:13:48 -0700 (PDT)
Received: from capella.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709064f0300b009b928eb8dd3sm5383396eju.163.2023.10.08.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 04:13:47 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: clock: si5351: add PLL reset mode property
Date:   Sun,  8 Oct 2023 13:09:38 +0200
Message-ID: <20231008111324.582595-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231008111324.582595-1-alvin@pqrs.dk>
References: <20231008111324.582595-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

For applications where the PLL must be adjusted without glitches in the
clock output(s), a new silabs,pll-reset-mode property is added. It
can be used to specify whether or not the PLL should be reset after
adjustment. Resetting is known to cause glitches.

For compatibility with older device trees, it must be assumed that the
default PLL reset mode is to unconditionally reset after adjustment.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Cc: Jacob Siverskog <jacob@teenage.engineering>
Cc: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 .../bindings/clock/silabs,si5351.yaml         | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
index 99c4e2271b6d..9a36d1f55c18 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
@@ -56,6 +56,27 @@ properties:
         - description: PLL source, XTAL (0) or CLKIN (1, Si5351C only).
           enum: [ 0, 1 ]
 
+  silabs,pll-reset-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    minItems: 1
+    description: |
+      A list of cell pairs containing a PLL index and its reset mode.
+    items:
+      items:
+        - description: PLL A (0) or PLL B (1)
+          enum: [ 0, 1 ]
+        - description: |
+            Reset mode for the PLL. Mode can be one of:
+
+                0 - reset whenever PLL rate is adjusted (default mode)
+                1 - do not reset when PLL rate is adjusted
+
+            In mode 1, the PLL is only reset if the silabs,pll-reset is
+            specified in one of the clock output child nodes that also sources
+            the PLL. This mode may be preferable if output clocks are expected
+            to be adjusted without glitches.
+          enum: [ 0, 1 ]
+
 patternProperties:
   "^clkout@[0-7]$":
     type: object
@@ -198,6 +219,9 @@ examples:
         /* Use XTAL input as source of PLL0 and PLL1 */
         silabs,pll-source = <0 0>, <1 0>;
 
+        /* Don't reset PLL1 on rate adjustment */
+        silabs,pll-reset-mode = <1 1>;
+
         /*
          * Overwrite CLK0 configuration with:
          * - 8 mA output drive strength
-- 
2.42.0

