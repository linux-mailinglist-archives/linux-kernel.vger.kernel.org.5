Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8CB767F7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjG2Nnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2Nnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:43:42 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA1CCA;
        Sat, 29 Jul 2023 06:43:42 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso2225535b3a.3;
        Sat, 29 Jul 2023 06:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638221; x=1691243021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7A5wSsDhI3tPDg2Zhs0lCCHvGH1hBcKwDXt+QlBQO8=;
        b=U6FVngLbFRNIdhiWnSyKQHg1BsmRAlHrq9cBCjWyr36diNFOTipDcZ6EMxh1WWZl05
         eVHkVDPsLw1LY988WZOvNcvL7IRbY8OFrJvghapJfUfcyEv28gh7sKFCgXyioikMg5xv
         rP1s7FwoW8+T1/C4oLPALIHPfqvYhLjE5ZsI6sqsXRaQknHkxTLphYjLIuyFXDAT+Ynl
         2xxA2HeGXHOnqozS88QbZo6plZKZ/naoNqQiF/LO7eQVHMc1Y4HBuO/kk9kqCt3zqMVD
         hKyeK5oCAkcxJCDUdDrzP5axY0PMbqH2YFYIX+g5jZsoJRpYGBF4KiuR89cG6ncrijR4
         fi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638221; x=1691243021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7A5wSsDhI3tPDg2Zhs0lCCHvGH1hBcKwDXt+QlBQO8=;
        b=A7dFON3CWdiuasImNdRuLotnb6QJA7Dlr309YRnyy2llCCQ8KgPZkiVx1NUkmzVkXL
         Z95HznpYpZDsBWxU08at03AiPnYLeYtQChYKnq5M9S1Td+l9ANTN+2hNMw2GjGjtQMUC
         LUYfvtwV7XDFDvE6yiSItY2mxX+zzG4Xun03IKFE7598/zzt5hyvhmlddCViYIWxnlbn
         Kg3ky5/Womv7jiVsomjAEhyZmXYBycOJJENfzAWuFJGXMRL2YsroW8pIZJuLX03I4ELB
         ys1SClKcBjPeTOCeehAGZrt+5CDZIaO6zVGYR3vHS0tapNd6alc2J28sJbmuxcOuYbZv
         waOQ==
X-Gm-Message-State: ABy/qLa0IS4mNyqdmQo3VD/6vN0i4078ZebyuzHxlmEZBEzi/7jd8HfC
        6C/jrSg0iy9IZmNmSC2y/LsBtHNChStI5w==
X-Google-Smtp-Source: APBJJlHcwMef/WGA2AmKHcbNB87hUr5x8z+OobB+C05D/s7quNFYkHUqQHa8dPTYFJOW1P5IeeZCvA==
X-Received: by 2002:a05:6a00:843:b0:67a:9208:87a with SMTP id q3-20020a056a00084300b0067a9208087amr5700074pfk.23.1690638220889;
        Sat, 29 Jul 2023 06:43:40 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:40 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 01/17] MIPS: loongson32: Get the system type from DT
Date:   Sat, 29 Jul 2023 21:43:02 +0800
Message-Id: <20230729134318.1694467-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
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

Get the system type from devicetree.
And update the copyright accordingly.

In addition, the system type belongs to proc info.
So rename setup.c to proc.c.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/Makefile        |  1 +
 arch/mips/loongson32/common/Makefile |  2 +-
 arch/mips/loongson32/common/setup.c  | 26 --------------------------
 arch/mips/loongson32/proc.c          | 20 ++++++++++++++++++++
 4 files changed, 22 insertions(+), 27 deletions(-)
 delete mode 100644 arch/mips/loongson32/common/setup.c
 create mode 100644 arch/mips/loongson32/proc.c

diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index ba10954b4b21..c3881af369e9 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -3,6 +3,7 @@
 # Common code for all Loongson 1 based systems
 #
 
+obj-$(CONFIG_MACH_LOONGSON32) += proc.o
 obj-$(CONFIG_MACH_LOONGSON32) += common/
 
 #
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index f3950d308187..b44527b1a178 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -3,4 +3,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= time.o irq.o platform.o prom.o setup.o
+obj-y	+= time.o irq.o platform.o prom.o
diff --git a/arch/mips/loongson32/common/setup.c b/arch/mips/loongson32/common/setup.c
deleted file mode 100644
index 4733fe037176..000000000000
--- a/arch/mips/loongson32/common/setup.c
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/smp.h>
-#include <asm/cpu-info.h>
-#include <asm/bootinfo.h>
-
-const char *get_system_type(void)
-{
-	unsigned int processor_id = (&current_cpu_data)->processor_id;
-
-	switch (processor_id & PRID_REV_MASK) {
-	case PRID_REV_LOONGSON1B:
-#if defined(CONFIG_LOONGSON1_LS1B)
-		return "LOONGSON LS1B";
-#elif defined(CONFIG_LOONGSON1_LS1C)
-		return "LOONGSON LS1C";
-#endif
-	default:
-		return "LOONGSON (unknown)";
-	}
-}
diff --git a/arch/mips/loongson32/proc.c b/arch/mips/loongson32/proc.c
new file mode 100644
index 000000000000..1ea54346b3d4
--- /dev/null
+++ b/arch/mips/loongson32/proc.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/of.h>
+
+#include <asm/bootinfo.h>
+
+const char *get_system_type(void)
+{
+	const char *str;
+	int err;
+
+	err = of_property_read_string_index(of_root, "compatible", 1, &str);
+	if (!err)
+		return str;
+
+	return "Unknown";
+}
-- 
2.39.2

