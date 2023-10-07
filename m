Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED9F7BC5E2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343785AbjJGH4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343823AbjJGH4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:56:36 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB58ED;
        Sat,  7 Oct 2023 00:56:31 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3af603da0f0so1955338b6e.3;
        Sat, 07 Oct 2023 00:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665390; x=1697270190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBpHGIaKLpPU171266rbLk8TrJkhcAtTOZV7fCxUUAs=;
        b=R/6VgYaXvHHEr9N4Bhb8m/Jg7I7W/m8bbdR+Cq2oWLcVN2ldGcl7/gyVoNW09m5v/x
         Wu3ADrXPLLgJBcNdRrC2G4CxLhu5zVHK2LHclEgwnB6beCbE06zwvTIqM5dsErG8HAJ7
         bgrLqBwb6uTF9Cmn0qbPl1/Kd5MUagfv7PIBQmk+o5QFrJLb2ihcwCKkg3dzw6vm2mqm
         dQcQcYozMWxdo9D56V/7wcvc7oTQk3m53caYVsMaI9mWUD0SsafxfiH83LbPFPKSHFuQ
         BfEVEUcMiDU2kLf/tChyL4n38jqmB0TbXXEztGM3KnuyAfcsc0iyh30b6TjcW/QMDNu5
         8qvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665390; x=1697270190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBpHGIaKLpPU171266rbLk8TrJkhcAtTOZV7fCxUUAs=;
        b=et7bLMb13JdwtWT/qOWg5iN2KW5L6PSe+7gLIQ55AI/8PBCkODeYbeblGArAvs2d32
         MWDQp7f1K6UzSMwStxlSpfnH0QtTMGlEk7MW03ceBib76Vq+Rg6VivGMDG6MzEVyqDMN
         LU2vNisRZlqRASWIiZ4/jaYwsrRpoGnf3VgePx3T8VkdCKySmZGtQf4u5KJuOw5JiLjB
         JTvKvQirT260XvkGoPFw+C3X8vJrSi8YuArceUVrcxVxZweAV80iZoboM6GoOt6y75c9
         KhZjnemzhjPanw6iTBzpqJNVkzqoMOhy7bWPOUaq8iFQNSi8yiZWnbEF05BvmcHZ0+uZ
         ZQdQ==
X-Gm-Message-State: AOJu0Yw5EXNiER6xG6KLfULrTP9lLU9DwcAYxg4Sf/Cj324k3vNm08nQ
        tjcdHU85PflzhnnZKtBVM14=
X-Google-Smtp-Source: AGHT+IHiU2Jxde6TIDkmqEUUI7gmEUMAxSt+GTwADoDz7as/kxYBdGs2+gl++XJuWpyzFS1RvZucpQ==
X-Received: by 2002:a05:6808:1153:b0:3af:7de8:ca90 with SMTP id u19-20020a056808115300b003af7de8ca90mr12597153oiu.56.1696665390394;
        Sat, 07 Oct 2023 00:56:30 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id j11-20020aca170b000000b003af5f6e40d7sm871005oii.15.2023.10.07.00.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:56:29 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 07/10] dt-bindings: interrupt-controller: Add Sophgo sg2042 CLINT mswi
Date:   Sat,  7 Oct 2023 15:56:22 +0800
Message-Id: <4db57bcb69b9182c171598eb8d65151a347cfe8f.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
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

The clint of Sophgo's sg2042 is based off IP designed by T-HEAD, and
implements the not yet frozen ACLINT spec. This spec seems to be
abandoned, and will not be frozen in the predictable future.
Frozen specs required by the RISC-V maintainers before merging content
relating to those extensions, therefore a generic compatible is not
appropriate.
Instead, add new vendor specific compatible strings to identify mswi of
sg2042 clint.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
[conor: re-wrote commit message to drop irrelevant sifive,clint discussion]
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../thead,c900-aclint-mswi.yaml               | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
new file mode 100644
index 000000000000..065f2544b63b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-mswi.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-mswi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo sg2042 CLINT Machine-level Software Interrupt Device
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sophgo,sg2042-aclint-mswi
+      - const: thead,c900-aclint-mswi
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
+      compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
+      interrupts-extended = <&cpu1intc 3>,
+                            <&cpu2intc 3>,
+                            <&cpu3intc 3>,
+                            <&cpu4intc 3>;
+      reg = <0x94000000 0x00010000>;
+    };
+...
-- 
2.25.1

