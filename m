Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDACF7AFF4E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjI0JCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjI0JCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:02:06 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A387E4;
        Wed, 27 Sep 2023 02:02:04 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ae2f8bf865so4995311b6e.2;
        Wed, 27 Sep 2023 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805323; x=1696410123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYb+x/wAKIajaMdzWu38bo8URRaln6e+0LguScHfSNU=;
        b=D5orGmkfBVGNC6SA9D/OjFAUCmnJLyKjz1BAZ3dz7b6d0B7xNEB3zQYG/VCtOna7NA
         pK5VO/7bgtjeKRt6BXZqvkJiIdYoNeXHOopRaB96hcTnXZZTp7uXSWfs5JtBTY6KeCr5
         l/sROxY/G4MB5666sLfdmezrptO6TsTT3BJakbzGtRXa1diiggzudJ6r07AefWTk/aSp
         czZBB5cEwy7Hll4QASRlmDewwp825L7PRu5LTqqAJXPdL51WQRWJ7S5bybmD0Akpk2/u
         BlkVaMBiCaA99neG9zkbxsNPYPXtj7k8dX+tfZd/qWC0/f9suSjruMODIvS4V5L4dfzb
         88Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805323; x=1696410123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYb+x/wAKIajaMdzWu38bo8URRaln6e+0LguScHfSNU=;
        b=UYp4Q0NcjyUVx2ZxFk8vHOIDenr4QIrMdWmD5zLkgfOHxxG98r81hyGDmjxWyHK7F7
         FOmYjIymXkbfviPiR2WfZ2HHVzwtKiOhNx6THOHtK+IJqfx9rRZkfeYNRiZpqTCtpjXS
         9lfZhCFXtb9j4kjKSak2nERLhb2PwgEONGvJR0k8ccEDrH1BFVO1n+mO1MUTin3y0fMJ
         VFa497FhSgHhRxVuqH2bY3f7buj2/zOmdYcIDHn3gNy9vxSSWabGamILYvCO6O5gtvDo
         Yo2oG2dd5+5cAM0O6LbfjALq3Z+bMhboYgnTgR4185n16I9ygzHFwcvi9701oht3qMuX
         YCfQ==
X-Gm-Message-State: AOJu0YxYqibnfjjD9icNKtsk5b+B3brmxL5fY6A1To/lEIqiYSYsPivO
        3KILjBdwQgYdFgW98aGIh90=
X-Google-Smtp-Source: AGHT+IEb5dlecz8eAtSfltSmdujtwoVtRC6Z7aE3UEu34jdVnUbAVOmlFXFYRMw5hvFLvQY4iMCrbw==
X-Received: by 2002:aca:2b14:0:b0:3a8:1c07:17d3 with SMTP id i20-20020aca2b14000000b003a81c0717d3mr1694343oik.19.1695805323309;
        Wed, 27 Sep 2023 02:02:03 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id j1-20020a056808034100b003a7a34a4ed8sm2452085oie.33.2023.09.27.02.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:02:03 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <wangchen20@iscas.ac.cn>,
        Chen Wang <unicornxw@gmail.com>
Subject: [PATCH v3 07/11] dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
Date:   Wed, 27 Sep 2023 17:01:56 +0800
Message-Id: <4dcfca1b0fa736a226bd01c796e4d8986ce49e63.1695804418.git.unicornxw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695804418.git.unicornxw@gmail.com>
References: <cover.1695804418.git.unicornxw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Inochi Amaoto <inochiama@outlook.com>

Like the timer of Sophgo sg2042 clint. The machine-level software
interrupt device (mswi) of sg2042 clint have the same problem when
dealing with the standard sifive clint.

To avoid the same conficts as the timer of sg2042 clint, also add the
vendor specific compatible string to identify the mswi of sg2042 clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 .../sophgo,sg2042-clint-mswi.yaml             | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml
new file mode 100644
index 000000000000..a79c4c3db3b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-clint-mswi.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-clint-mswi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo sg2042 CLINT Machine-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,sg2042-clint-mswi
+
+  reg:
+    maxItems: 1
+
+  interrupts-extended:
+    minItems: 1
+    maxItems: 4095
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+
+examples:
+  - |
+    interrupt-controller@94000000 {
+      compatible = "sophgo,sg2042-clint-mswi";
+      interrupts-extended = <&cpu1intc 3>,
+                            <&cpu2intc 3>,
+                            <&cpu3intc 3>,
+                            <&cpu4intc 3>;
+      reg = <0x94000000 0x00010000>;
+    };
+...
-- 
2.25.1

