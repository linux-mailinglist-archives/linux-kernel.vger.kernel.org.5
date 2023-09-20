Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819077A72FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjITGlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233393AbjITGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:41:08 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159EF0;
        Tue, 19 Sep 2023 23:41:01 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-572a7141434so3823807eaf.2;
        Tue, 19 Sep 2023 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695192060; x=1695796860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yveMbLv2+NblyHjS4ZDFugIb595kXowdDQelFhwmBqc=;
        b=Ah5fFIR5P2pHsNomUNvBKQVb00xh5K0/wfCh2NBg8ly77mp6r1EeD0vswYnSRQhkos
         3TX7v5UaNnq+M+F5NzVzHnOqTi6/NuzECrlzbYkjBzPxaXLVyHLxfPf3A/1TZ0z+O0o/
         re7kUr6wPc1ZdE4J9im+TskMCOoWUS4t6HCb8ZMqKbqjFDq8eN51ElQSn0PJPiINBsTE
         sFcKPnMPdkVz+FDxALnjhgf8nD8whAAffH5Hsw1PoLFh4KgJmhVHxxMOgdZddp6QLKZR
         8t8kNKKZyb0/SY8pM8Hrzuv5CmFCHYTTVAdlfLgxMenEnJurq4+i1pQho3+qNr1p+Imp
         pHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695192060; x=1695796860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yveMbLv2+NblyHjS4ZDFugIb595kXowdDQelFhwmBqc=;
        b=xMaNgYbk144Cuofq9fgw4stw7M0LRg6ayNSAYIN9GL6NruUqkMxEUFEiOPGQuVO4gS
         8VcvH+x5LlGFBafScTlS95TkUnHig7qNm8mKSON3MAc7Zvw6bFeDkmSSv1bU76y5Trri
         meDYI1bsbCyRObYoeiXOAOaIELnvaQTdk8y5MbnAi7sB1SXeheF1nblzaeSkWsZXZrSu
         M4sQskPKCyogY9qt5uXBE+3uE3M1hbO9stEyhQYSrsgvsIJNbxvdtjgZGoC1gNcZWdto
         VKBjdzIqpYMGRvcXCVeX732HEB4amDbCkzJl45m9do8bxZJbpIGge8lSmJwjqMHrRh6C
         DUvw==
X-Gm-Message-State: AOJu0Yznw6X4k1pWVQlYvu5n+4L6DTR8mTIBi/PKPFahb6gZlZeL89AW
        n5ixrmqKY9JTU7sQkWDZTKo=
X-Google-Smtp-Source: AGHT+IHpXiDlyuVx7CkluNKS075+3yRXcB1SfrU4WSQUnbNKNNVlL7D1VCjygFqYQjVrgIRXIbOxeQ==
X-Received: by 2002:a05:6870:658b:b0:1d6:b404:a50a with SMTP id fp11-20020a056870658b00b001d6b404a50amr1671312oab.31.1695192060592;
        Tue, 19 Sep 2023 23:41:00 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id eg50-20020a05687098b200b001db36673d92sm2220744oab.41.2023.09.19.23.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 23:41:00 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
X-Google-Original-From: Chen Wang <wangchen20@iscas.ac.cn>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v2 10/11] riscv: dts: sophgo: add Milk-V Pioneer board device tree
Date:   Wed, 20 Sep 2023 14:40:53 +0800
Message-Id: <e9ff83e4fac9a9ebd217ef10e5f8d3260342102b.1695189879.git.wangchen20@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695189879.git.wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
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

Acked-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
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
index 000000000000..d6e8c0285d1e
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -0,0 +1,19 @@
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
+	chosen: chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1

