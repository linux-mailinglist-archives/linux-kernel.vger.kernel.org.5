Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB967BC5E5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbjJGH5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343775AbjJGH5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:57:43 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EE2D6;
        Sat,  7 Oct 2023 00:57:39 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c4a25f6390so1886824a34.2;
        Sat, 07 Oct 2023 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665459; x=1697270259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSE2B0Sk0lNGKGqCG89tJGLae6XeuqHUYjO2VhHq1Fs=;
        b=XsEhMtwiTU/fpIUoFuPZ3kyJ7zzVDOu5jKLP2LPiQ/YSiOddwQU1OiP7O8r+LODH4g
         Za0u+HoD5XOMhIxVf4LUbVtiz+Afm6QUEgjOCiSQapmD9n/ZNPuD4tEnxGDe/awKuG6o
         wa3lxLq7IA01r9fAg1wTzH019VS1jqTF8iRD5qYrAGlSQ+AyIiCZyMdZO0sD/JYOKtLB
         EiVieg4hS0BBvis9D4lYqjZnli8SZ0PzqJmHNQrjM+E8J5r83lc7EabDVVYqeg6Y2MvV
         sgJ4LnGsdukpLiMCajrQ+Md0Y4ELao2qyrtpi0S++hpRIICFbT3g1oC3ctrHNQWkXX6Q
         UQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665459; x=1697270259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSE2B0Sk0lNGKGqCG89tJGLae6XeuqHUYjO2VhHq1Fs=;
        b=RiDjl42gsVxBu7YKVmVDS0vZ/3d606vrkCWiK2DlxZ2xtx/x0W8DZzDe8wMCwzo7pu
         m1O7HmYSGwqQkhKTrEUrUqoS+uv3ggGUtrChY/IiIOoF6vsgkbr58T/8Lyz1fUMJY450
         kK+doyAHIj5fRnFtc+VSkSskJRB72UTiaw9NZsuYlh6tSp0PhEVi4LD1rPKvEnBSe/a3
         4vOhYBZ81vIdK/YjkbGj6O92Z5vzHziXaY76U3lrtoimKrb65XsaiQqgFNbjZ5DX6wXD
         CadJbjKiEOYlw55aZs9ME41eO2a9F8GXfanI4GouvNZVZYAJI8h7FqefnsKQ+jU1nO74
         f6rA==
X-Gm-Message-State: AOJu0YysQQwdiqwK0ZWZ8kYtcoz40crbxvy+q862y2nJUTz+4zRlfB1O
        UGqoHSvVXR6zZWtJSAn6tYbLwwUmW4wRQh/L
X-Google-Smtp-Source: AGHT+IH0YQ4jRcVV2vj9RcB6/hAqQBZjf+EhgANAHz7njIewApQMsD8jlshmfOPdLKOLkPvEf9pBTw==
X-Received: by 2002:a05:6830:1d43:b0:6b9:a192:aaf3 with SMTP id p3-20020a0568301d4300b006b9a192aaf3mr10541851oth.17.1696665458914;
        Sat, 07 Oct 2023 00:57:38 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d6b9a000000b006c0d686f76esm831294otq.63.2023.10.07.00.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:57:38 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicorn_wang@outlook.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 09/10] riscv: dts: sophgo: add Milk-V Pioneer board device tree
Date:   Sat,  7 Oct 2023 15:57:31 +0800
Message-Id: <990193b3a3f3d7854d4d652a034fd33cd759d33f.1696663037.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696663037.git.unicorn_wang@outlook.com>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
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

From: Chen Wang <unicorn_wang@outlook.com>

Milk-V Pioneer [1] is a developer motherboard based on SG2042
in a standard mATX form factor.

Currently only support booting into console with only uart
enabled, other features will be added soon later.

Link: https://milkv.io/pioneer [1]

Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/sophgo/Makefile           |  2 ++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
 3 files changed, 22 insertions(+)
 create mode 100644 arch/riscv/boot/dts/sophgo/Makefile
 create mode 100644 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index f60a280abb15..72030fd727af 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -4,6 +4,7 @@ subdir-y += canaan
 subdir-y += microchip
 subdir-y += renesas
 subdir-y += sifive
+subdir-y += sophgo
 subdir-y += starfive
 subdir-y += thead
 
diff --git a/arch/riscv/boot/dts/sophgo/Makefile b/arch/riscv/boot/dts/sophgo/Makefile
new file mode 100644
index 000000000000..73af15f42ec2
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
new file mode 100644
index 000000000000..49b4b9c2c101
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
+	chosen {
+		stdout-path = "serial0";
+	};
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.25.1

