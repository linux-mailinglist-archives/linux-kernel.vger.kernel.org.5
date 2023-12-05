Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CBA804339
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjLEAWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLEAWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:22:47 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7921D107;
        Mon,  4 Dec 2023 16:22:53 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58d08497aa1so3706396eaf.0;
        Mon, 04 Dec 2023 16:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735773; x=1702340573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWzi5VFScWkMe1hfBc2EXsXYdiAbd/+bGr8M1EA3Tok=;
        b=K+H+ni82FYlyjrMiSF6SoyQgxEZZp6Wb3Bw9qkcybErFDd0be0PMxoDzJXpMdTAeqY
         /p9bwRWd0azevBZExkFA9l2aVHr/lRpvWymmRigJCvPZsczE4F2H7iaucAY+Kljr0W4P
         EMUDvd0LM3eQXQ80vsMy1u6uh29J20VKkBn9vzm7oYuGXLwOOSC0NEq2TdT+O885ph8y
         jyS6y30uh3O4KJvCctnYPqXeWejupcds/ggDrHRacPUpZqcsjgcIgKvMBSVkc+fNcoAQ
         fDGeQ2qxoK6r0gnjKva0M6fGfFYilyTBD1QeoIF7fIoUDGWjaS8EfQrSgYJh5Vh5ITrx
         Mi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735773; x=1702340573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QWzi5VFScWkMe1hfBc2EXsXYdiAbd/+bGr8M1EA3Tok=;
        b=KFZ/dmcOffcl3KJXNQv/4Qv42lKR5sbt1RUon37GU4pKn1Arl5hoz2NY+Tmrugsh4H
         tdau8dbpnJrIiTJGVeEtg7vn8FzyOz3fTYh9smXIkvsgCCZtk3Z/Ug5Ey8HQ0Z+e+ptM
         1zpBZkgNh4csdfkGQ301FMIgMju/sNaIpKPEV2CxB+6xFfGDsJJCHqKc1DNxE/gp3qDm
         OL6Z+0C0KyzAm9QybX7f90W3m0s8Ke2akwC7Cs7N14Gg260VOx0ghL0nW+ZzL5B6PpYa
         Mj24/gedLOwlhOWOPTO0Y46+xaMZ2TkvIbOmQN6zvueaDgOq+/d+LqtOABS2pnDkrUf+
         yF2A==
X-Gm-Message-State: AOJu0Yxiewo50apTuHqj2IhDLLI3KY0ncd5bInp10ZKlmq9UoU2pVuSo
        RzdWLgZD1hIOyqpVRwOuaV4=
X-Google-Smtp-Source: AGHT+IFAs26Fa4uHzufA3+AF+TKHenR8RwzQfBCwtZcjjddNVt1By5baeF7SOpG0rzvv1tQjF8C8Gg==
X-Received: by 2002:a4a:e883:0:b0:58e:1c48:4951 with SMTP id g3-20020a4ae883000000b0058e1c484951mr3761102ooe.11.1701735772698;
        Mon, 04 Dec 2023 16:22:52 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id t67-20020a4a5446000000b0058df9ed9291sm1976915ooa.34.2023.12.04.16.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:22:52 -0800 (PST)
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
Subject: [PATCH v4 1/4] dt-bindings: soc: sophgo: Add Sophgo system control module
Date:   Tue,  5 Dec 2023 08:22:44 +0800
Message-Id: <d02730f0b2b531ce7f59e6569e83a57f551f72aa.1701734442.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1701734442.git.unicorn_wang@outlook.com>
References: <cover.1701734442.git.unicorn_wang@outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
index 000000000000..e50b25aaaa95
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
+        compatible = "sophgo,sg2042-sysctrl";
+        reg = <0x30010000 0x1000>;
+    };
-- 
2.25.1

