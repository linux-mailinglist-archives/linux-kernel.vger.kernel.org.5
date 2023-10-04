Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC07B77F6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbjJDGhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 02:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241434AbjJDGhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 02:37:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73594AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 23:37:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53639fb0ba4so3052914a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google; t=1696401458; x=1697006258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QGSDNn6mvgk3D6FylGr3G9S7gB7eM4JL0YqBrEuXRo=;
        b=cgmX09quanarZet8h2P8+bVl4u5yT293Uyg+CS01qEtYIdB5Ll1Uoylfwku5GapOAF
         iSvfccmHbYCWkAxZPpbNsqdK1CWQO9Wa+FNGWRamNFwLI+9W3uY/ErB93u4MhKZWV9MT
         NxxVZH0pHIoajQZrrcC/kGxr0lhUB6JhzrAD1iqfjWXh9RV6WK06rRDBHYkGxzJuB5t/
         Yb2ZkODMkoX6RlXdhRTaiN4XNDtQ4f9V0RMPnS2X/qqlET8ZFSSvf8RzBD8PdShRBwFZ
         pX0beRB3nQIJd0Mx4FzrU9NBNGlAoLqsglGCwY7ljeZnUDKXOXQPN6qbUWMl6X1H7ybf
         ojYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696401458; x=1697006258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QGSDNn6mvgk3D6FylGr3G9S7gB7eM4JL0YqBrEuXRo=;
        b=dGoWRWPgQDuqg32ZPsMYX9Hxh9LjiDqqyB/kdvSZkYtwc8kAb8/QcOlF2euG20N1dr
         EiB3GZx4s6tudhkmu1u5tojxTcfFAKMcm2Gq88ZAZgMTrluVrA2p+R/xThPz0/cRNKGj
         iImqDrVTerCw64i5X1QFn1VmJXs3mSJTeYLeG2Lpnp6zQIY6K/K1UJY662Nfv7w2UVxu
         Z067QHxMGPRkQb6XviTINwN8Om7soz3x7guzeofl8n/zpgFdKzeNWWB8Ecc6dyF0qlpO
         sQYeJG7rRQLZCeJ3UHLAqE77W8wShPv2dnEK0jGKX53vzNc7tQvotZmd/oRLh5w8Thub
         zgig==
X-Gm-Message-State: AOJu0Yw47ymQyA1FT00h/ckTseP6LbsHpzjgTWJohSUJwsz0jiTrZhA1
        G0Pr8oa7RNRsVxJtkn5HGgd5eQ==
X-Google-Smtp-Source: AGHT+IFndInI3ROJr7Xma3uL1HuF3MxWN7W2vtrRlnwhIYSMbBbuFCG3VE4WjMo60/MNXEXTe2yByQ==
X-Received: by 2002:a17:906:7492:b0:9b2:d018:20b2 with SMTP id e18-20020a170906749200b009b2d01820b2mr1372868ejl.39.1696401458083;
        Tue, 03 Oct 2023 23:37:38 -0700 (PDT)
Received: from capella.localdomain ([193.89.194.60])
        by smtp.gmail.com with ESMTPSA id jx14-20020a170906ca4e00b009ade1a4f795sm2193507ejb.168.2023.10.03.23.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 23:37:37 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        =?UTF-8?q?=A0ipraga?= <alsi@bang-olufsen.dk>
Cc:     Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 3/4] dt-bindings: clock: si5351: add PLL reset mode property
Date:   Wed,  4 Oct 2023 08:35:29 +0200
Message-ID: <20231004063712.3348978-4-alvin@pqrs.dk>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004063712.3348978-1-alvin@pqrs.dk>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 400c8cec2a3a..f1be09b5c48c 100644
--- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
+++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
@@ -53,6 +53,27 @@ properties:
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
@@ -207,6 +228,9 @@ examples:
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

