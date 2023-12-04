Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6944E803376
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344137AbjLDMzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjLDMy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:54:58 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870DFC3;
        Mon,  4 Dec 2023 04:55:04 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3b8b6acc3e7so850441b6e.1;
        Mon, 04 Dec 2023 04:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701694504; x=1702299304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fp1QQy4nHJOCAUXp1K0aSSWLaVTSFOXyfLRKjezIxlk=;
        b=crMc6+hFFC48FXDu69Lf/+hSba4KQk635eEPchzjHi4K4KwRyVEIeDRKQYXRzAjaqb
         mCfDQn49t6f+OtvQP4xH7XM/p2AdntmdBSiSdkHNIaH5ig6QKCrT1jRbfd+WIez5Iob7
         KhSC3i0+ZDaBtiS149GjO1r5T12Wnj3v4dO9P76ORBOMqVPvtaptbR+S9p19dDuuhGos
         IIpF0bDY4/ZcyZV42Y0hYXmgggsLyrAfQXQ7rL/L7EFvFxP//e97HQxwrYaGaNRmxlli
         nd4klAv9vBiZBYKSXEJNV4w7h7vDzjUAb6hWWKt7fPv133ZwiJ6BsaEOmVrAgAkR6Reb
         RZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694504; x=1702299304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fp1QQy4nHJOCAUXp1K0aSSWLaVTSFOXyfLRKjezIxlk=;
        b=ssVpVWDQEyKCRFsOOdgUnyP8zHJYOkavP7k+UBFQjbQt11W1u+o+1ZFm5lD5F7kkh1
         m3tSTOAKiTR018c9X5wludcvVNREqjfcPx3l5I0QYCpbaRNZhuvfKNav8Q/AfKkqpJ05
         DvjtDbUnFwS45U0PFAIjSqr4bwn9Ws9JrX48QmYR9PwZ/4eZq2sOIBXdb1B1/7S/RBNw
         z8Iujftz0bpXZzet/O4qQuz4nQ9XIAI+Gaq0qkTy6a+qn08R1uKJ9whwCIx1Y0a5Zde5
         RJ8uGPG/E8Jmj8s0vaOVS7uvgD4zFwb2sjJiXAHT3u9JFzQnCYeQhzsckzClvuvmsCRa
         D3zA==
X-Gm-Message-State: AOJu0Yzo2AkpUOQhpf/y0lPtxXvvn+0W6nreF8EGwePX57nCsX6Pmm8H
        DF+srh2gP1wL1NmUSWFH2VU=
X-Google-Smtp-Source: AGHT+IFVm0R8UCnK8yzexeBkJRvv9sySXLrOfNZKlioVDEQH8/yrXtP/d5bGH9S4SS1NjKQjEdbLIA==
X-Received: by 2002:a05:6808:914:b0:3b8:643e:f09b with SMTP id w20-20020a056808091400b003b8643ef09bmr3855506oih.54.1701694503712;
        Mon, 04 Dec 2023 04:55:03 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 13-20020aca280d000000b003b8b262a347sm1089986oix.7.2023.12.04.04.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:03 -0800 (PST)
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
Cc:     Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH v3 1/4] dt-bindings: soc: sophgo: Add Sophgo system control module
Date:   Mon,  4 Dec 2023 20:54:53 +0800
Message-Id: <14616bce163d689a4e640ab7b372421ca8306a92.1701691923.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701691923.git.unicorn_wang@outlook.com>
References: <cover.1701691923.git.unicorn_wang@outlook.com>
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
---
 .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
new file mode 100644
index 000000000000..cf4b4b5a6300
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
@@ -0,0 +1,35 @@
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
+    items:
+      - const: sophgo,sg2042-sysctrl
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
+        compatible = "sophgo,sg2042-sysctl";
+        reg = <0x30010000 0x1000>;
+    };
-- 
2.25.1

