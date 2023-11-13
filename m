Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AF07E9CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjKMNTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjKMNTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:19:45 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92301D6F;
        Mon, 13 Nov 2023 05:19:41 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1f06931e4f7so2899561fac.1;
        Mon, 13 Nov 2023 05:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881580; x=1700486380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZcJHL1uyIZmEMFpfa9bF4kSIpnfRgaXoeVhjEt/aAo=;
        b=g4Qo5h+owx8+CTvjneUBeq1mqvjWhzBBkwmkn0pTktgAyYj2zIPNybW6kb/xOANPst
         EkqmgOgjzld7gXKAaWa9SR79NP98P5n3lkrtMS7EaTqP+xegecPa53sTA1iyknHkoJCQ
         WnAfSdJLIGFSc5BdEa9yzXY9cSErYMBbwoWPmiZUlf8/52kSX8/dhdcA60R4HOlnC/gq
         W9oEiRzMwmHfrkakbRTMHVJbOum6DxYP/aYnjryuSr8lpAsOSSY4MFEL/5a6aspwXkN6
         HWw842dgSEkeQDNItC+ZphD6TgGow4LcKx9YzgtEFymziMMH2juvNyo31jHaVBLolZlq
         U4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881580; x=1700486380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZcJHL1uyIZmEMFpfa9bF4kSIpnfRgaXoeVhjEt/aAo=;
        b=db6tbCiTT4uzNAg+BaaQt38FyTsFe8Uk89+lfXAv62BlMXk1bWkOHma3em7hrEpFXW
         MlH1fQdWpMu9i+/zlyMa1zn20kCZAGmsNFHndoCNzVwQwnc4VyV3OqnsrFkapysH/8vG
         mwQ70Ho6QWdE5lvq1B1ieP5mpIf6TN3VRZJyqkOk65bpjkSlAtRfW7PwhxXgdFWcz1a2
         ypSkp1RbLpoFD9gQdtjL2CDg3I5R008c1kkAWduao+ZNu2F2l0+RCU8T29tVgkFZiLOd
         QTn0SYYshDtU8pWQrWnmPwLiW3nsxF9hWoHDtPuXDAmDZA7ypFDICAQ5kRrEnb5o0ntZ
         0hdw==
X-Gm-Message-State: AOJu0YzMoEMjxT1fAHeFcTGN09koXlvJW5bxjgzVRCKzYUN8ACzAbey5
        lALwMimkZSHpaElGSZb6DMnZQX7bNbce8w==
X-Google-Smtp-Source: AGHT+IFJFjOdYJAttPy6vP0qnKr2YMChB+ivUxeTNAVbV9hmhX5ZXpCziZydh1yIrQkprZApewnJfw==
X-Received: by 2002:a05:6870:7d8c:b0:1ea:7bd1:c491 with SMTP id oq12-20020a0568707d8c00b001ea7bd1c491mr9129141oab.41.1699881579945;
        Mon, 13 Nov 2023 05:19:39 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id zf30-20020a0568716a9e00b001f224cbbde1sm1015375oab.41.2023.11.13.05.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:19:39 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 3/5] dt-bindings: clock: sophgo: Add SG2042 bindings
Date:   Mon, 13 Nov 2023 21:19:31 +0800
Message-Id: <1e5836360485b63e15bdf58da59e83139666b290.1699879741.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699879741.git.unicorn_wang@outlook.com>
References: <cover.1699879741.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Wang <unicorn_wang@outlook.com>

Add bindings for the clock generator on the SG2042 RISC-V SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../clock/sophgo/sophgo,sg2042-clkgen.yaml    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml

diff --git a/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
new file mode 100644
index 000000000000..e372d5dca5b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sophgo/sophgo,sg2042-clkgen.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 Clock Generator
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-clkgen
+
+  system-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to System Register Controller syscon node.
+    description:
+      The phandle to System Register Controller syscon node.
+
+  clocks:
+    items:
+      - description: Clock Generation IC (25 MHz)
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo-sg2042-clk.h> for valid indices.
+
+required:
+  - compatible
+  - system-ctrl
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+            compatible = "sophgo,sg2042-clkgen";
+            clocks = <&cgi>;
+            system-ctrl = <&sys_ctrl>;
+            #clock-cells = <1>;
+    };
-- 
2.25.1

