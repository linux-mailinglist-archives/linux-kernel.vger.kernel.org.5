Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922497E9CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjKMNTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbjKMNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:19:14 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0033171A;
        Mon, 13 Nov 2023 05:19:10 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-581f78a0206so2500723eaf.2;
        Mon, 13 Nov 2023 05:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699881550; x=1700486350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cILQpOBvb+TfKiK6ZQZxVGfG6yumttRB0ZdBq3qtuMo=;
        b=dLtb6C7MSvk0qWMQjorUwfkypOwTsYwHlBu/JrMTn16wfNFT6ArS6CWxUk+LfmpjXt
         pQ3HLxlX+ksOGcz2nisGoQn05ieTyWqQ8I3DvRCM6FkogLgRjyP5Q2YEiZwmSyE4LfCL
         tf+E5uUXsaEbSBXaxBaqOaXvttW4+9r9YpfxoXfNfu5PnbiKzVNKNQ5dsxVXDAjBCXNh
         20a0dVm1ACttH21gVfkhiqbM602ibJTw1NxG0algFwZJy7uIC+XkESsnewM+OxlqlNV2
         +3HYVNhYn/Em8jTKL/ucoclzauCMEzqDrSnDUDoWREFUonBPMZFAv6zdIBevkJeD2Kso
         aShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699881550; x=1700486350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cILQpOBvb+TfKiK6ZQZxVGfG6yumttRB0ZdBq3qtuMo=;
        b=C8PpwN87uKqrrxMcgeBRi3Gko8HSBoIiiRjinLajC1tCoXI2qlcTRfDOo/y37WLYqb
         6E9KDj0KZc8sGQHf64GVA+Iq4Nzjx1sKXuPanJzXhkD72AoSf/J4lByJT9TGcyp9z2b6
         DlNCecqGA51iZFJQtK/zpGUeUB0tK0hv8g1/POubAfiRiiAiZb5Q9+dU3qE8fXUx1ZAr
         kgVLYMiSjBr63BPPgHRyoihcmQhJ8uOHpY5vj64ef7S8J4dYXxDm1v3eMly4jhciinhq
         nXfNaIQOfiU+ZniJdzCcDswtutHczcq8yPQqOGEsaFHXw82NT8cHjbUntnIfKQp+eGJ4
         TRNA==
X-Gm-Message-State: AOJu0YwVu9u6F+9Bs8FLWNGfvx/Cj+HcqZOBuhba5eN1hP8qcuOApwab
        FCi08JqikORtVTxpMididoo=
X-Google-Smtp-Source: AGHT+IHGu08XC660yZ66f68Mmebro0V2bn0R5bRMPD2XBiV2hiZPo8vFmbjyr+ZUlNTWZ4ylkZhGwg==
X-Received: by 2002:a4a:851d:0:b0:581:d922:e7f3 with SMTP id k29-20020a4a851d000000b00581d922e7f3mr6288302ooh.9.1699881550098;
        Mon, 13 Nov 2023 05:19:10 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id j15-20020a4aab4f000000b0057327cecdd8sm908572oon.10.2023.11.13.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 05:19:09 -0800 (PST)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 2/5] dt-bindings: soc: sophgo: Add Sophgo syscon module
Date:   Mon, 13 Nov 2023 21:19:02 +0800
Message-Id: <3c286171af30101b88f0aaf645fb0a7d5880ac0a.1699879741.git.unicorn_wang@outlook.com>
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

Add documentation to describe Sophgo System Controller Registers for
SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../soc/sophgo/sophgo,sg2042-syscon.yaml      | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
new file mode 100644
index 000000000000..829abede4fd5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 SoC system controller
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+description:
+  The Sophgo SG2042 SoC system controller provides register information such
+  as offset, mask and shift to configure related modules.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - sophgo,sg2042-syscon
+          - const: syscon
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
+    syscon@30010000 {
+        compatible = "sophgo,sg2042-syscon", "syscon";
+        reg = <0x30010000 0x1000>;
+    };
-- 
2.25.1

