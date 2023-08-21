Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486E7782455
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjHUHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjHUHUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:20:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608EB8;
        Mon, 21 Aug 2023 00:20:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fef4b063a7so565125e9.2;
        Mon, 21 Aug 2023 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602439; x=1693207239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bEZTCW4anOz4OA529ZQF56jnwgreyTMpd9DmGcQ5jUU=;
        b=lhmQZrs0yQ1HRpbiCUMVRfrRMaiXK3K2sOx4VStllc7MHh9Wu0mR9QeyfxntSqJZjK
         HhpK/MZsNIYy2+nyfXiW5XsSixD7qktSn8+SCZaELkDsKiq39SQJuZb/LnJknt/GzGzM
         yeoXmIO4XdrQMSfvrGS41434/SmgViAiudCPtzsf2Zv9OSoC39AATnuJYcLfarTMB8IV
         rPAVvccvFJGvk2M+6xkyIcVn8hCeMBOgELnOMKCfsR/3TJpy8Bl6xe/6vWKg6tB8Lbx+
         v/fGelmD1syho0mpuoC7pZTwyu94s/JgGDUDz7CeAoW1JgE+2ZksFYTbtl6qE0UkPhrd
         8Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602439; x=1693207239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bEZTCW4anOz4OA529ZQF56jnwgreyTMpd9DmGcQ5jUU=;
        b=WOq+to6OgwtCtOc5cr2hH8T62hz1bFGEnYX10Pm+GFJNg9tSIrbLbyxul4oCLh4U/F
         t/s0mQIvtqh501iV3azThza+t7e3GNl7NFhYkRqg08UawtPpJhaNTxKje1U5N5B9buk4
         pIvbWU+7EGi5FQ+EzirBxJA0AwfQSq65icrT2om1+9rUMzxSVTVtmjIEltYAiwdL8OLN
         CfWZwoYKsDRpu4thtH+hzTzZvsJ2Brle6DqwJmTxQJDjPd3TVUuGKFhXxCPZJXCR20uk
         c/+6ZqnGcgTWelMI8pEYwoQ8ag+jyWDYJ57dkLgGRtNav0aimTCnL2YGHq3dAkmTUbIw
         frCg==
X-Gm-Message-State: AOJu0YyPEgMLyMzy28dh4RUsyP1hw/7x8GvVteTW1VkJRhIFRUKIRM1o
        OpsXj+7NsmqFJl6A1lf5pR9/njEGet/ZKw==
X-Google-Smtp-Source: AGHT+IECs4tjcEI/bx4VE8zC6AyLsiXDQbQNyNsMPkKvHCq7CeNg6z49JntwUh44hsMJN4gPg8jCeQ==
X-Received: by 2002:a05:600c:3646:b0:3fe:d448:511d with SMTP id y6-20020a05600c364600b003fed448511dmr4638679wmq.6.1692602438488;
        Mon, 21 Aug 2023 00:20:38 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b0031416362e23sm11631594wrw.3.2023.08.21.00.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:38 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 3/8] openrisc: Add prototype for show_registers to processor.h
Date:   Mon, 21 Aug 2023 08:20:02 +0100
Message-Id: <20230821072007.2698186-4-shorne@gmail.com>
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

  arch/openrisc/kernel/traps.c:67:6: error: no previous prototype for 'show_registers' [-Werror=missing-prototypes]

Fix by adding the prototype to the appropriate header file and including
the header file in the appropriate C files.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/processor.h | 1 +
 arch/openrisc/kernel/process.c        | 2 --
 arch/openrisc/kernel/traps.c          | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/openrisc/include/asm/processor.h b/arch/openrisc/include/asm/processor.h
index ed9efb430afa..3b736e74e6ed 100644
--- a/arch/openrisc/include/asm/processor.h
+++ b/arch/openrisc/include/asm/processor.h
@@ -73,6 +73,7 @@ struct thread_struct {
 
 void start_thread(struct pt_regs *regs, unsigned long nip, unsigned long sp);
 unsigned long __get_wchan(struct task_struct *p);
+void show_registers(struct pt_regs *regs);
 
 #define cpu_relax()     barrier()
 
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.c
index dfa558f98ed8..a07512de0169 100644
--- a/arch/openrisc/kernel/process.c
+++ b/arch/openrisc/kernel/process.c
@@ -119,8 +119,6 @@ void flush_thread(void)
 
 void show_regs(struct pt_regs *regs)
 {
-	extern void show_registers(struct pt_regs *regs);
-
 	show_regs_print_info(KERN_DEFAULT);
 	/* __PHX__ cleanup this mess */
 	show_registers(regs);
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index afa47501118f..f221e4b4298f 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -31,6 +31,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/io.h>
+#include <asm/processor.h>
 #include <asm/unwinder.h>
 #include <asm/sections.h>
 
-- 
2.39.1

