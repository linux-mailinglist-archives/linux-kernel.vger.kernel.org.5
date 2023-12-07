Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AE2808460
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378399AbjLGI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLGI5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:57:32 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A973719A;
        Thu,  7 Dec 2023 00:57:38 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6d7fa93afe9so422722a34.2;
        Thu, 07 Dec 2023 00:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701939458; x=1702544258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Wg3vTVI+KNNtCZ40tO4THN1Rc/sssddRQwHLFYhkAc=;
        b=aI1tKQT1If3SLW8VhMnyvZiPlrLq7VpQ4CHDiWc3n8d6if1ZjZMi2FsAajM13Qtecv
         A9+nDQ5ihRabYr3dLbXQngohJAy/DaHZgeAygX1M3rnMYBt92l4Zd7vyqLR1isYt+E1I
         j2Hx5HEkYJl2IBYme6Vu+9HJK+diZyqUMgjFQ3iYGIyxYP895kgISgmTUDyww5AECXHs
         rLVrcgu6sgfYpvTiVvQ9QuDhLkb24oKJ3NaE85NL0ULHqxsnFvQWE1a848qBH1e05ZsA
         ReNTefvEXW1/UjXLChWF9nW63HjHZauRRPxmH0HgRfTOX78NgGfJZqLy5x//CII+5XZq
         SxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701939458; x=1702544258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Wg3vTVI+KNNtCZ40tO4THN1Rc/sssddRQwHLFYhkAc=;
        b=OKEHt0sdW02K4YC/woNVImF0rkGjjTlJPTWr45bqnRNV71tpggty/645DVUP1vvSTk
         JmAexjLTGxQOEGAijbNC+ocb68THKzmtLwWxPVYGLS3M2I1WmCAuXCUglejIfcr4vxit
         L+K/FKA18wdt4zEWUIXLi9WlJpta5kZbqIFtecIjLiJME2ccw6sx5O2421miDzvF1d8E
         9w54XcnUyeLqGcIEHhwU0SniIwp9Sz9keMGlpNAp+VMtnkJbAiXsGhFxm90sULpUKKD6
         O7nJ4gnALGP7c9/r/B51Jp7fBxOaESzCuK4Zolb2+cf5v7wkHDaa3t/i4ZfLhtqz/8Y1
         ZBkg==
X-Gm-Message-State: AOJu0YwdndLuRwlIQzmYWy6Cshwzx9q52DWuMd9RI5ZgDgZTA0XEw6Fi
        pk1LKZwq6CInmC5wrhp/WkE=
X-Google-Smtp-Source: AGHT+IHW4HSIb3obMzTrfiP4Gy1b6m5qiGblv1GKI63bYQ+XoerAbg/BeN69ofo3MRl6Vitfd51XPA==
X-Received: by 2002:a9d:62d2:0:b0:6d8:2883:cb5a with SMTP id z18-20020a9d62d2000000b006d82883cb5amr2130164otk.24.1701939457879;
        Thu, 07 Dec 2023 00:57:37 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id a15-20020a056830008f00b006d7f41c7e11sm152567oto.33.2023.12.07.00.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 00:57:37 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/4] dt-bindings: soc: sophgo: Add Sophgo system control module
Date:   Thu,  7 Dec 2023 16:57:28 +0800
Message-Id: <3bb50fea3ae6e15f67dcc5bc21315edd1f4793d8.1701938395.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701938395.git.unicorn_wang@outlook.com>
References: <cover.1701938395.git.unicorn_wang@outlook.com>
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

Add documentation to describe Sophgo System Controller for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
new file mode 100644
index 000000000000..1ec1eaa55598
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 SoC system controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  The Sophgo SG2042 SoC system controller provides register information such
+  as offset, mask and shift that can be used by other modules, such as clocks.
+
+properties:
+  compatible:
+    const: sophgo,sg2042-sysctrl
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    system-controller@30010000 {
+        compatible = "sophgo,sg2042-sysctrl";
+        reg = <0x30010000 0x1000>;
+    };
-- 
2.25.1

