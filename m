Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C777AFF58
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjI0JC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjI0JCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:02:53 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FEEB;
        Wed, 27 Sep 2023 02:02:52 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so6185802a34.0;
        Wed, 27 Sep 2023 02:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695805371; x=1696410171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDfODZTn111ZZ8DX98LZ4K1E0ZmX3dAdVwjheRuwzs8=;
        b=Ofj0I42w3YFoRbRWbh7rvm7u8lfuzvAjQCiAdZzjQTgH32SpiUhUBTFWXbqbCmb3Hl
         fnTlfQu02KBBKSZXLXccsBicCNfxfsILGr5TQZ54YBA0j8+Sr3GaNRpswmykN0hHHJ9b
         uPLss03uRSmcjE8VNgmod7DvaNsJMxnUezk5Z8SNwfOmNol8rKct+2kpaULcakWrIoxX
         aG0T9cbnzgUwUzC24y/4kdWwTldjcaF97/sodIIPL4VFH0ErXT/LxHyEk4SZTDtKIcnE
         8IeUEj1Bz1pZh9tPIRdxWKZbmI9efrCCbsw8yfy8kq24IjzbcEoQHsaRajoLJs59YggE
         0T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805371; x=1696410171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDfODZTn111ZZ8DX98LZ4K1E0ZmX3dAdVwjheRuwzs8=;
        b=Blk8Y78WV6e4HxNuSBiZuRW0LAyo00o5H7CKfh1md82/HS9UQr8RVZNPGOVk6mwXFG
         Z5VEy22F/XctVlPQnNMwooghcRKmFouZnMAqX1V4FQxL/Z2PjHfJ6HlOlCGtTccfA/5t
         +TwBuPh6iF1inpEFrdwjvDQLGeDHxVC8AsvGflvNbWyl3tBlcmp0KBDM+oZTAKwRYBw5
         37VeRVM6RY6m40A74HfJdlxOHqLMvJ53FKFnzheGYByP6Aeg25oCWS62PqIdJ1KZ+B5o
         4T3rYucGYMZmzftMHZmhjyCh+TZ52sSLR8R2dcMz0HngSZrXtPu/qo1Lxl0nCQCrrKsH
         VlFw==
X-Gm-Message-State: AOJu0YwS/xUH6FBJZTOboc9iTR7hM+ZwBcirCOcq64rDjmZOgxPYclVV
        +QCfgyLKvh+zrfYXSug7KIM=
X-Google-Smtp-Source: AGHT+IHIjzzQuh2yLkWHMREiBgUch5rTTTkz3abO07HnClhXdNoZfEzboK3+7hF2NH1lllXbKbVsPw==
X-Received: by 2002:a05:6870:a693:b0:1d0:f5bd:6fe with SMTP id i19-20020a056870a69300b001d0f5bd06femr1726827oam.50.1695805371567;
        Wed, 27 Sep 2023 02:02:51 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id eg46-20020a05687098ae00b001dd17c5356dsm1369946oab.11.2023.09.27.02.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:02:51 -0700 (PDT)
From:   Chen Wang <unicornxw@gmail.com>
To:     aou@eecs.berkeley.edu, chao.wei@sophgo.com, conor@kernel.org,
        devicetree@vger.kernel.org, guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Cc:     Chen Wang <unicornxw@gmail.com>, Chen Wang <wangchen20@iscas.ac.cn>
Subject: [PATCH v3 10/11] riscv: dts: sophgo: add Milk-V Pioneer board device tree
Date:   Wed, 27 Sep 2023 17:02:44 +0800
Message-Id: <e094732421d7f3ec88c635ef54da65aef8665874.1695804418.git.unicornxw@gmail.com>
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

Milk-V Pioneer [1] is a developer motherboard based on SG2042
in a standard mATX form factor.

Currently only support booting into console with only uart
enabled, other features will be added soon later.

Link: https://milkv.io/pioneer [1]

Reviewed-by: Guo Ren <guoren@kernel.org>
Acked-by: Chao Wei <chao.wei@sophgo.com>
Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
Signed-off-by: Chen Wang <unicornxw@gmail.com>
---
 arch/riscv/boot/dts/Makefile                  |  1 +
 arch/riscv/boot/dts/sophgo/Makefile           |  3 +++
 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+)
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
index 000000000000..5a471b19df22
--- /dev/null
+++ b/arch/riscv/boot/dts/sophgo/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_ARCH_SOPHGO) += sg2042-milkv-pioneer.dtb
+
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

