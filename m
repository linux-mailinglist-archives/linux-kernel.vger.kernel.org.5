Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD518782458
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjHUHVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjHUHVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:21:16 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E6AD9;
        Mon, 21 Aug 2023 00:20:51 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe9c20f449so28626225e9.3;
        Mon, 21 Aug 2023 00:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602449; x=1693207249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtNc3Du6gG8oZnZl3Qw+qjBjvlHx+WfMztJOy5nnEYA=;
        b=flSrl4IhE/aUkCSW53h+QGujT6TMqRPEtcAmrnwkcbq5EKxiqkUjCC9zkQdiyWulh/
         g4lYjTt1WzbE6kbMD8yWjedfzxcN5/Ete9q87nvLXKQ3+as9DtD5R+m1hbWX98iDJH5D
         6BwWTVBlKlAOChBNPvwQ5BunkahRUnn16nJX7CvZoSsCel1qjUEUOXJd3Y9pufic8ppr
         SMGwA5Ma5OuD9AygpHtt/bSouaxdHtiKOUiSYDmoGZ7TDdwrw/xhnyuV/JYCUSx5cybI
         BMN0l/EHTeORdmqp4RFvXQwFw7FBhRw7LuqMRcggD3wwoVkxoieXcIkeFeP7Qm/Ta3Pq
         lEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602449; x=1693207249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtNc3Du6gG8oZnZl3Qw+qjBjvlHx+WfMztJOy5nnEYA=;
        b=JnTUjgT8WvjXLAb4PjJBBFZAN5MH1gu0ObC7F5IOSEu6kvqOR5fM3eKU65kszl1auZ
         Uwt/9L+NsWxldde/BB88p8NQSVJyn3ia/lHaJYLpfWLszCE05bUKzYq69mnhqtfAgC+B
         pQPYt/Y9jzpy00/JY+s1yFUs0ectTO5TCLAMxodjQ/gqdGy+u1eAsgtAceXmk5LeMZRg
         /EQpecBYq6s0e8O5tLPEtS7Vr58qBwIARIpH0aVyxowlh+e8YidokK/ghWSMcyXoBgbP
         bA14iG5oF0UoxTUeA79QQ/eBv6mXYjXAQ8PUBbcCPDmF/C3gjWmwvFZDV34gBRN2hybN
         RUcw==
X-Gm-Message-State: AOJu0YyAZlfQXHfg1OB2WPq5hUG1N5fLjvu7jqjXQ0jvw4CGiOIx7Xob
        /+pWGLrDsp4DN8IfEKfogbXwOQhhNjImtA==
X-Google-Smtp-Source: AGHT+IFFy6kyYsxl8K+nHlrUjEOUrHB710r1vOeQWaLqJHkdQQgstcQsIuxtrYX+JYb4wdy0gDGkXw==
X-Received: by 2002:a05:600c:22cf:b0:3fb:fea1:affa with SMTP id 15-20020a05600c22cf00b003fbfea1affamr4656031wmg.37.1692602449077;
        Mon, 21 Aug 2023 00:20:49 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003fe4ca8decdsm15317688wmf.31.2023.08.21.00.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:48 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 4/8] openrisc: Add prototype for die to bug.h
Date:   Mon, 21 Aug 2023 08:20:03 +0100
Message-Id: <20230821072007.2698186-5-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
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

When compiling with W=1 enabling -Wmissing-prototypes the compiler
warns:

  arch/openrisc/kernel/traps.c:221:17: sing-prototypesrror: no previous prototype for 'die' [-Werror=missing-prototypes]

Fix by adding the prototype to the appropriate header file and including
the header file in the appropriate C files.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/bug.h | 11 +++++++++++
 arch/openrisc/kernel/traps.c    |  1 +
 arch/openrisc/mm/fault.c        |  3 +--
 3 files changed, 13 insertions(+), 2 deletions(-)
 create mode 100644 arch/openrisc/include/asm/bug.h

diff --git a/arch/openrisc/include/asm/bug.h b/arch/openrisc/include/asm/bug.h
new file mode 100644
index 000000000000..6d04776eaf10
--- /dev/null
+++ b/arch/openrisc/include/asm/bug.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_OPENRISC_BUG_H
+#define __ASM_OPENRISC_BUG_H
+
+#include <asm-generic/bug.h>
+
+struct pt_regs;
+
+void __noreturn die(const char *str, struct pt_regs *regs, long err);
+
+#endif /* __ASM_OPENRISC_BUG_H */
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index f221e4b4298f..879fbf57c04e 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/kallsyms.h>
 #include <linux/uaccess.h>
 
+#include <asm/bug.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/unwinder.h>
diff --git a/arch/openrisc/mm/fault.c b/arch/openrisc/mm/fault.c
index 01dc18aa8410..29e232d78d82 100644
--- a/arch/openrisc/mm/fault.c
+++ b/arch/openrisc/mm/fault.c
@@ -18,6 +18,7 @@
 #include <linux/perf_event.h>
 
 #include <linux/uaccess.h>
+#include <asm/bug.h>
 #include <asm/mmu_context.h>
 #include <asm/siginfo.h>
 #include <asm/signal.h>
@@ -30,8 +31,6 @@
  */
 volatile pgd_t *current_pgd[NR_CPUS];
 
-extern void __noreturn die(char *, struct pt_regs *, long);
-
 asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long address,
 			      unsigned long vector, int write_acc);
 
-- 
2.39.1

