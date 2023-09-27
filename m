Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A5B7AFF49
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjI0JBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjI0JBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:01:47 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D9BA3;
        Wed, 27 Sep 2023 02:01:46 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4b9e09521so5412175a34.3;
        Wed, 27 Sep 2023 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805306; x=1696410106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXIpE3t2S5hvGBlA4qF3kN7EACJyW+Do/rfIdtRkLUc=;
        b=Qgbj+kDXSNrOL8+s6qH8JiM/QySkP4ucirf4cglRfmHJ9S8E7oViI4WSsT8CJI080D
         sts0dsgt+bLb7ej2Y8dn6dWId9Hofltb1y7vpqSu+iM19rf31/9bDWYxY6PLqfcy2/1q
         e4SMXnNTpH4UN+eEIrJiTfnNsyBHDUuJDX3UG4Gh03ADRwH2NiX44eOqmsXc6hnFshl8
         ZXCeAE8IMOVDx1fJ+a8Nw/RPVQK2NGOEa3tj9U004eqQctdrv3KMbg6VSyYytUW2/XVA
         UsssapRIKFwxktpG+xKM38SwuxFzRf/k0VYWP3M1WxE0wOFFIhIW+EuDE04R3iqYQNsE
         j+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805306; x=1696410106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXIpE3t2S5hvGBlA4qF3kN7EACJyW+Do/rfIdtRkLUc=;
        b=ZGj232M1gjT12CEBDy5GFQ5AGk7q7RCcJkp8cxgnlkmjmZ45Et7YsO+B3mHmBMg+cp
         aMt944K/SLZwTkLWPkAUawQjS4qpzShofwkjAh7Vx1xuuKu6avC4wf4dupsOKsaCVXE5
         179DJHWUy35YESqKzp8wF6LbCQBHmtkQoxUHAGe4Wy4P8kMXnm0lcXHx8RH7WH8YgEeg
         5Bb54qTKUl/cXQ3IMXze6V1VIj/2YwejZhiNY+sr3rwG5wXwQM0cf4+Y5Nr00D73HVgQ
         v2ow6DfiwwOL7R9ChGNrSUTOOh8SVEEMr1ZwSWZMg3t1JN2DLloLkTiAY6kNEfA1X30q
         WKNQ==
X-Gm-Message-State: AOJu0YzKkmlZWpqWatIBqtmrTBZkIvsISmDjE5YfnhbUCDRM5qqAB3GN
        NbMNs/WCsdrNrR/Ks9LtdYIKnVuxiO7AOA==
X-Google-Smtp-Source: AGHT+IGIIPx7LpmWuBAwJyMC+B4D+B7f2hNQ3krtTefomBIb8tOVeWEMPZHi106hegZJOgN1jP48zA==
X-Received: by 2002:a05:6830:1291:b0:6c4:cdce:5de8 with SMTP id z17-20020a056830129100b006c4cdce5de8mr1517090otp.26.1695805305760;
        Wed, 27 Sep 2023 02:01:45 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id t7-20020a05683022e700b006b9b0a08fdasm2312157otc.59.2023.09.27.02.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:01:45 -0700 (PDT)
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
Subject: [PATCH v3 06/11] dt-bindings: timer: Add Sophgo sg2042 CLINT timer
Date:   Wed, 27 Sep 2023 17:01:37 +0800
Message-Id: <6e263430685732a4f354b45396c7422a37440ac8.1695804418.git.unicornxw@gmail.com>
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

The clint of Sophgo sg2042 is incompatible with the standard sifive
clint, as the timer and ipi device on the different address, and can
not be handled by the sifive,clint DT.

In addition, the timers of sg2042 are mapped by per cluster, which is
hard to merge with its ipi device.

To avoid conficts caused by using the same clint compatible string when
this device is parsed by SBI, add a new vendor specific compatible string
to identify the timer of sg2042 soc.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 .../timer/sophgo,sg2042-clint-mtimer.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml

diff --git a/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml b/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
new file mode 100644
index 000000000000..5da0947d048a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/sophgo,sg2042-clint-mtimer.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/sophgo,sg2042-clint-mtimer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CLINT Timer
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: sophgo,sg2042-clint-mtimer
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
+    timer@ac000000 {
+      compatible = "sophgo,sg2042-clint-mtimer";
+      interrupts-extended = <&cpu1intc 7>,
+                            <&cpu2intc 7>,
+                            <&cpu3intc 7>,
+                            <&cpu4intc 7>;
+      reg = <0xac000000 0x00010000>;
+    };
+...
-- 
2.25.1

