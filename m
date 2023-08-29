Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48878BC62
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbjH2B1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjH2B10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:27:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F737CA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:27:23 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc8a2f71eeso22717735ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693272443; x=1693877243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7KpDeJqIlM0mp0ux71n4I6Vql3yYpF8JViJ7LJsV9nI=;
        b=AWyw5Kk4IEBYD6dusUnpdbPEgKIhTmE3bBoiJH6K2RqgvDhriGxI/WgKReYWdkN7hE
         o5r4UHw6viiqks5ahM3WA9yFQIsUHxgAeF3cuEHR/9jT3Zkby/ohuYRrlRmuoYLw/xCM
         353I1RM2Gxi0apZDV9VutPTWoVLfz3H+1/3lOumuebbMSUOAIrCVTRkhK7PaoseQ9XPx
         XhsUq0yFhqRcEApGIthcwhnu3rYuNC1j7Fj5hPAChaTARp2ue75VBOnCnHHqMmFb3HvN
         BaIO+tH2rjCkIhde37K6q19nWHm3J943vX0L4y4a6DrizMNeSOTtOTvAMxhj13SwwrCh
         /j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693272443; x=1693877243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7KpDeJqIlM0mp0ux71n4I6Vql3yYpF8JViJ7LJsV9nI=;
        b=JDmLDeUh6zDhu2a6aPl/Tv55vz6hafs4FAkCCeIzJO9tUGsf7VJxQBGtqia7XSGpOL
         oL5S5Kik2UNmS5ZI/9YHKtfJzlQ27UZS8nrG8oj+SThhE5rSl2M8vYOUl8aZnVdlHdtl
         IUmLghKfLj+mn61bk33/C53LrNhiytmlk+BedcnPETN5owkhBl7RishKzsZ5/qwNnp0z
         6rNWo2itpLaz5bGn1awss0Gx8wLQq4Lvpr7YURxWXTkhZYYe3+0shgAeXClVja0uFgVT
         j9StqEDIxerw/sFavqQM1StSgmoye0+ybqWgioe13GAb8qAq4Z2GdgUbeBWVufg216OE
         fgYA==
X-Gm-Message-State: AOJu0Yz13My5YjmGxM3jIdq1ncvC81K1rMN7wPo+VXgdbWIZMBd+uUHG
        GE/c53TqRn8Oh2cs/abSjtwL059qT8I=
X-Google-Smtp-Source: AGHT+IE+GlWMbhi7D6ZHvZy0VgTd8ihwAff9CZ+Fl+A10q0veZKrfQjyuppTZZYtY9y+txiVmgS5Vg==
X-Received: by 2002:a17:902:e80f:b0:1c1:f15c:976f with SMTP id u15-20020a170902e80f00b001c1f15c976fmr3673198plg.26.1693272442720;
        Mon, 28 Aug 2023 18:27:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a201:19d0:dd19:9546:e00c:cf93])
        by smtp.gmail.com with ESMTPSA id v9-20020a170902b7c900b001bb750189desm8040981plz.255.2023.08.28.18.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:27:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: add XIP-aware MTD support
Date:   Mon, 28 Aug 2023 18:27:08 -0700
Message-Id: <20230829012708.1917031-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kconfig symbol, asm/mtd-xip.h header and define related macros:
xip_cpu_idle, xip_irqpending, xip_currtime and xip_elapsed_since.
Append .xiptext to the vectors when separate vectors are configured
because otherwise they are appended to the data and data may not even be
executable in XIP configuration.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Kconfig                |  3 +++
 arch/xtensa/include/asm/mtd-xip.h  | 14 ++++++++++++++
 arch/xtensa/include/asm/sections.h |  4 ++++
 arch/xtensa/kernel/setup.c         |  3 +++
 arch/xtensa/kernel/vmlinux.lds.S   | 11 ++++++++++-
 5 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 arch/xtensa/include/asm/mtd-xip.h

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2a51a466779f..070a112b7dbe 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -70,6 +70,9 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
+config ARCH_MTD_XIP
+	def_bool y
+
 config NO_IOPORT_MAP
 	def_bool n
 
diff --git a/arch/xtensa/include/asm/mtd-xip.h b/arch/xtensa/include/asm/mtd-xip.h
new file mode 100644
index 000000000000..514325155cf8
--- /dev/null
+++ b/arch/xtensa/include/asm/mtd-xip.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_MTD_XIP_H
+#define _ASM_MTD_XIP_H
+
+#include <asm/processor.h>
+
+#define xip_irqpending()	(xtensa_get_sr(interrupt) & xtensa_get_sr(intenable))
+#define xip_currtime()		(xtensa_get_sr(ccount))
+#define xip_elapsed_since(x)	((xtensa_get_sr(ccount) - (x)) / 1000) /* should work up to 1GHz */
+#define xip_cpu_idle()		do { asm volatile ("waiti 0"); } while (0)
+
+#endif /* _ASM_MTD_XIP_H */
+
diff --git a/arch/xtensa/include/asm/sections.h b/arch/xtensa/include/asm/sections.h
index 3bc6b9afa993..e5da6d7092be 100644
--- a/arch/xtensa/include/asm/sections.h
+++ b/arch/xtensa/include/asm/sections.h
@@ -34,6 +34,10 @@ extern char _SecondaryResetVector_text_start[];
 extern char _SecondaryResetVector_text_end[];
 #endif
 #ifdef CONFIG_XIP_KERNEL
+#ifdef CONFIG_VECTORS_ADDR
+extern char _xip_text_start[];
+extern char _xip_text_end[];
+#endif
 extern char _xip_start[];
 extern char _xip_end[];
 #endif
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index aba3ff4e60d8..52d6e4870a04 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -311,6 +311,9 @@ void __init setup_arch(char **cmdline_p)
 
 	mem_reserve(__pa(_stext), __pa(_end));
 #ifdef CONFIG_XIP_KERNEL
+#ifdef CONFIG_VECTORS_ADDR
+	mem_reserve(__pa(_xip_text_start), __pa(_xip_text_end));
+#endif
 	mem_reserve(__pa(_xip_start), __pa(_xip_end));
 #endif
 
diff --git a/arch/xtensa/kernel/vmlinux.lds.S b/arch/xtensa/kernel/vmlinux.lds.S
index c14fd96f459d..f47e9bbbd291 100644
--- a/arch/xtensa/kernel/vmlinux.lds.S
+++ b/arch/xtensa/kernel/vmlinux.lds.S
@@ -118,6 +118,7 @@ SECTIONS
     SECTION_VECTOR2 (.DoubleExceptionVector.text, DOUBLEEXC_VECTOR_VADDR)
 
     *(.exception.text)
+    *(.xiptext)
 #endif
 
     IRQENTRY_TEXT
@@ -201,6 +202,9 @@ SECTIONS
 		   .DebugInterruptVector.text);
     RELOCATE_ENTRY(_exception_text,
 		   .exception.text);
+#ifdef CONFIG_XIP_KERNEL
+    RELOCATE_ENTRY(_xip_text, .xiptext);
+#endif
 #endif
 #ifdef CONFIG_XIP_KERNEL
     RELOCATE_ENTRY(_xip_data, .data);
@@ -319,7 +323,12 @@ SECTIONS
 		  LAST)
 #undef LAST
 #define LAST .exception.text
-
+  SECTION_VECTOR4 (_xip_text,
+		  .xiptext,
+		  ,
+		  LAST)
+#undef LAST
+#define LAST .xiptext
 #endif
   . = (LOADADDR(LAST) + SIZEOF(LAST) + 3) & ~ 3;
 
-- 
2.30.2

