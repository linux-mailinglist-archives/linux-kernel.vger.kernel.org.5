Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360A7781785
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 07:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbjHSFwS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Aug 2023 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245055AbjHSFwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 01:52:07 -0400
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36434208
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 22:52:02 -0700 (PDT)
Received: from dlp.unisoc.com ([10.29.3.86])
        by SHSQR01.spreadtrum.com with ESMTP id 37J5prnc009875;
        Sat, 19 Aug 2023 13:51:53 +0800 (+08)
        (envelope-from Yanxin.Huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
        by dlp.unisoc.com (SkyGuard) with ESMTPS id 4RSSVn2R2Nz2PbwF0;
        Sat, 19 Aug 2023 13:49:37 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sat, 19 Aug
 2023 13:51:51 +0800
From:   Yanxin Huang <yanxin.huang@unisoc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        huang yanxin <yanxin.huang07@gmail.com>,
        Wenming Wu <wenming.wu@unisoc.com>
Subject: [PATCH 1/7] dt-bindings: nvmem: Convert Unisoc efuse controller binding to yaml
Date:   Sat, 19 Aug 2023 13:51:35 +0800
Message-ID: <20230819055141.29455-1-yanxin.huang@unisoc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Originating-IP: [10.13.2.29]
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
Content-Transfer-Encoding: 8BIT
X-MAIL: SHSQR01.spreadtrum.com 37J5prnc009875
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Unisoc efuse controller binding to DT schema format.

Signed-off-by: Yanxin Huang <yanxin.huang@unisoc.com>
---
 .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 -----------
 .../devicetree/bindings/nvmem/sprd-efuse.yaml | 67 +++++++++++++++++++
 2 files changed, 67 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
deleted file mode 100644
index 96b6feec27f0..000000000000
--- a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
+++ /dev/null
@@ -1,39 +0,0 @@
-= Spreadtrum eFuse device tree bindings =
-
-Required properties:
-- compatible: Should be "sprd,ums312-efuse".
-- reg: Specify the address offset of efuse controller.
-- clock-names: Should be "enable".
-- clocks: The phandle and specifier referencing the controller's clock.
-- hwlocks: Reference to a phandle of a hwlock provider node.
-
-= Data cells =
-Are child nodes of eFuse, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-       ap_efuse: efuse@32240000 {
-               compatible = "sprd,ums312-efuse";
-               reg = <0 0x32240000 0 0x10000>;
-               clock-names = "enable";
-               hwlocks = <&hwlock 8>;
-               clocks = <&aonapb_gate CLK_EFUSE_EB>;
-
-               /* Data cells */
-               thermal_calib: calib@10 {
-                       reg = <0x10 0x2>;
-               };
-       };
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-Example:
-
-       thermal {
-               ...
-
-               nvmem-cells = <&thermal_calib>;
-               nvmem-cell-names = "calibration";
-       };
diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml
new file mode 100644
index 000000000000..77106aca52c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd-efuse.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sprd-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Unisoc eFuse controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sprd,ums312-efuse
+
+  reg:
+    description:
+      Registers location and eFuse size.
+    maxItems: 1
+
+  clock-names:
+    const: enable
+
+  hwlocks:
+    description:
+      eFuse hwspinlock id.
+    maxItems: 1
+
+  clocks:
+    description:
+      eFuse clock id.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - hwlocks
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sprd,sc9863a-clk.h>
+
+    aon {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ap_efuse: efuse@40240000 {
+            compatible = "sprd,sharkl3-efuse";
+            reg = <0 0x40240000 0 0x10000>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            clock-names = "enable";
+            hwlocks = <&hwlock 8>;
+            clocks = <&aonapb_gate CLK_EFUSE_EB>;
+        };
+    };
+...
--
2.17.1

________________________________
 This email (including its attachments) is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential or otherwise protected from disclosure. Unauthorized use, dissemination, distribution or copying of this email or the information herein or taking any action in reliance on the contents of this email or the information herein, by anyone other than the intended recipient, or an employee or agent responsible for delivering the message to the intended recipient, is strictly prohibited. If you are not the intended recipient, please do not read, copy, use or disclose any part of this e-mail to others. Please notify the sender immediately and permanently delete this e-mail and any attachments if you received it in error. Internet communications cannot be guaranteed to be timely, secure, error-free or virus-free. The sender does not accept liability for any errors or omissions.
本邮件及其附件具有保密性质，受法律保护不得泄露，仅发送给本邮件所指特定收件人。严禁非经授权使用、宣传、发布或复制本邮件或其内容。若非该特定收件人，请勿阅读、复制、 使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件的方式即刻告知发件人。无法保证互联网通信及时、安全、无误或防毒。发件人对任何错漏均不承担责任。
