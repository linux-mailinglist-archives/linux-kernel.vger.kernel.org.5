Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB657A1746
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjIOHZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 03:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjIOHZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 03:25:06 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB8BA1;
        Fri, 15 Sep 2023 00:25:01 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-57358a689d2so1089353eaf.2;
        Fri, 15 Sep 2023 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694762700; x=1695367500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iVUDT6l1ChAeIi0RC+WcBnGHyj8AAnCtHrqteS2EV7o=;
        b=V3MY1Ywpcabxzlg0aq6AwBESyDQjCHYHlzKYqG3IsobzCfFCGZpQtecpFH5VBo3psK
         ak3Fb1MVuDrnledXuFEk1oqAwKJeV4ak+o63gFpDdfanmTKOgdFLTgZF7dKMGSdWNbVe
         teDJHJO83/FBvTBxc8mevc+VBuRXCE2/S05k25GmTRi3VHe8PY4xrfANriLzd7vlQjqx
         a/kw6iZUfgf8UsvO6pnEUno+EVKPZc0G2rbDaRXHrYUN88eKA2QtoW7a/ndaUcyAPiZ3
         klR6wclQLxeVtopM045djYGnfTgz+NsVVOjO+7ZHze9rG06EqpUsHSauQnVXtotxMNXF
         pUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694762700; x=1695367500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVUDT6l1ChAeIi0RC+WcBnGHyj8AAnCtHrqteS2EV7o=;
        b=BJMwAUKA+bguTPWOZGLkNLJ52LlRnRPPUfX/EGbuKHvvGOLga5iwfFT9VFLTlLnSlB
         KLEvL22ZOuXFrx16u2dcfnE3aeNf3E0D4inLpBnFT6SNl64T13O3KwtUWBbT5jtS8KvA
         BeCDJBi3NOGIzLzcy/GSGPDhPX1LS6xOjwO9kB0Zs5g7Mgqvq3SPoyebe+nqdVsFG8vU
         nA1Md8+GXf4fr6eehBF0bbhJnAzuV3AsqMpMfqGLvtPySIz9QKhoQKACyFA+J0F7BeVb
         OaupfHfU5/1NCsf++1wP4sPeP+LlpDB+H0Bebu+MU1C9aVMVtNrkPmLHtmEHXceYnWCi
         dncw==
X-Gm-Message-State: AOJu0YxMMXpxJk15E6twLTynUgsYgRdHBGCCDYzcEhLp1eJeLnPdW/mB
        kZ+WjCoi7Xlf61X4r0wd4nuO3pKM3NJN3A==
X-Google-Smtp-Source: AGHT+IGRLqRmoi2bf3u+M2EgyNuwEZFJdJ+tXdS9Q7q1+tkpKnPWtQYrlA1xI42427rGwp5xsUjCSg==
X-Received: by 2002:a05:6870:5803:b0:1b3:8cfb:78c5 with SMTP id r3-20020a056870580300b001b38cfb78c5mr1029357oap.34.1694762700635;
        Fri, 15 Sep 2023 00:25:00 -0700 (PDT)
Received: from localhost.localdomain ([222.95.63.58])
        by smtp.gmail.com with ESMTPSA id c10-20020a63a40a000000b0056b6d1ac949sm2131946pgf.13.2023.09.15.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 00:25:00 -0700 (PDT)
From:   Wang Chen <unicornxw@gmail.com>
X-Google-Original-From: Wang Chen <wangchen20@iscas.ac.cn>
To:     linux-riscv@lists.infradead.org, conor@kernel.org,
        aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>,
        Inochi Amaoto <inochiama@outlook.com>
Subject: [PATCH 08/12] riscv: dts: sophgo: add Milk-V Pioneer board device tree
Date:   Fri, 15 Sep 2023 15:24:51 +0800
Message-Id: <20230915072451.118209-1-wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Milk-V Pioneer [1] is a developer motherboard based on SOPHON
SG2042 in a standard mATX form factor. It is a good
choice for RISC-V developers and hardware pioneers to
experience the cutting edge technology of RISC-V.

Currently only support booting into console with only uart
enabled, other features will be added soon later.

[1]: https://milkv.io/pioneer

Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
---
 arch/riscv/boot/dts/Makefile                     |  1 +
 arch/riscv/boot/dts/sophgo/Makefile              |  3 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts     | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f60a280abb15..94788486f13e 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -6,5 +6,6 @@ subdir-y += renesas
 subdir-y += sifive
 subdir-y += starfive
 subdir-y += thead
+subdir-y += sophgo
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
new file mode 100644
index 000000000000..5a471b19df22
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
+
diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
new file mode 100644
index 000000000000..4f480ff88fbd
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 Sophgo Technology Inc. All rights reserved.
+ */
+
+#include "sg2042.dtsi"
+
+/ {
+	model = "Milk-V Pioneer";
+	compatible = "milkv,pioneer", "sophgo,sg2042";
+
+	info {
+		file-name = "sg2042-milkv-pioneer.dts";
+	};
+};
+
-- 
2.25.1

