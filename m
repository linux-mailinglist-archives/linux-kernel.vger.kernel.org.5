Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E7C78245C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbjHUHVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjHUHVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:21:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB897128;
        Mon, 21 Aug 2023 00:20:54 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31ae6bf91a9so2147342f8f.2;
        Mon, 21 Aug 2023 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602453; x=1693207253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5JCAEGGsGz8CsfvHPWWh5Q2sigmg/HJtWn0W/rRUfc=;
        b=pf6VhGV0058cUUDP9bEW9WsQrpQLSCMTLk6gDxK17DNlMhGgRgod6cTrguz8rQ3/9d
         /s+geTI/+b//YJ8lmpmguE2lERCeAySiqM3ogRLf0IPzOcm3SnKyX4y/IvEQ/KPahK0i
         KA8ASd8PGWbGeyhiTZGJfn2WZDGk4pAyFMrEobnDX2EWtV3dL4KlpUtqzRpew4skAhKV
         2wf+wti4tqt/y4FkYihavmidOQqWvIJmBCwSjKlIJxVZWPgYnO8ZNhsoOzBdgAEXz9i7
         xDBNUH9jNVOx7AxhTbVQVUWzweO+C2L77tOZbvD+ZkC7kdD2vXwrwdPcC8QxTUzjnFiP
         ZJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602453; x=1693207253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b5JCAEGGsGz8CsfvHPWWh5Q2sigmg/HJtWn0W/rRUfc=;
        b=aTFqa9G3o8v4C+hXUIbaZtwWwZpJ8qTiuDcoGJopdA2XdBtvsAQsT3niiaHVuXx7dQ
         7cn7wEd+XPshgKOomuYUW+wdBGwHDEGDoV7XEO3J2I6Fp1aQlzLI/kBHnlQx/wwcAqe2
         zUm042iE26c+wBo3+9kuvzXS0UexqGaT5fLK/4j5iSfUjZRQV/3FH9v9UPt9Zwu3e0R9
         GYxFkz5R+2U/Wlp2fifVwItsSCsCJnGDTthDwLX9/0szlxebIGxUzA9o5/BSOTxbUqiq
         B3wzrvtG+eYRFTQCgQudDN09d8ZHcaWo3jVhsdmrBLTQOQHYUgnsYyA88nMzwi9gmXrN
         z0hQ==
X-Gm-Message-State: AOJu0YwOAVcva6r4CZ7g32S2Fh/4b/2BoAw2uWzClLF75aRbALZpc5dH
        8YF3bLlkX2v3WBARtGMrlpdon4v6Wx0=
X-Google-Smtp-Source: AGHT+IGk1vmeXmb2KC89lcy6G3MiMIBEat9EVg3lcTFYxsXeNVe/8TR8bZE0gFw8ROR1roI9IF5B7g==
X-Received: by 2002:adf:e6c9:0:b0:313:dee2:e052 with SMTP id y9-20020adfe6c9000000b00313dee2e052mr4299183wrm.26.1692602452808;
        Mon, 21 Aug 2023 00:20:52 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id w14-20020adfec4e000000b003180822cf8fsm11591707wrn.1.2023.08.21.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:52 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 6/8] openriac: Remove unused nommu_dump_state function
Date:   Mon, 21 Aug 2023 08:20:05 +0100
Message-Id: <20230821072007.2698186-7-shorne@gmail.com>
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

  arch/openrisc/kernel/traps.c:146:6: error: no previous prototype for 'nommu_dump_state' [-Werror=missing-prototypes]

This function is not used so remove it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 75 ------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 879fbf57c04e..9370888c9a7e 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -36,7 +36,6 @@
 #include <asm/unwinder.h>
 #include <asm/sections.h>
 
-static int kstack_depth_to_print = 0x180;
 int lwa_flag;
 static unsigned long __user *lwa_addr;
 
@@ -153,80 +152,6 @@ void show_registers(struct pt_regs *regs)
 	printk("\n");
 }
 
-void nommu_dump_state(struct pt_regs *regs,
-		      unsigned long ea, unsigned long vector)
-{
-	int i;
-	unsigned long addr, stack = regs->sp;
-
-	printk("\n\r[nommu_dump_state] :: ea %lx, vector %lx\n\r", ea, vector);
-
-	printk("CPU #: %d\n"
-	       "   PC: %08lx    SR: %08lx    SP: %08lx\n",
-	       0, regs->pc, regs->sr, regs->sp);
-	printk("GPR00: %08lx GPR01: %08lx GPR02: %08lx GPR03: %08lx\n",
-	       0L, regs->gpr[1], regs->gpr[2], regs->gpr[3]);
-	printk("GPR04: %08lx GPR05: %08lx GPR06: %08lx GPR07: %08lx\n",
-	       regs->gpr[4], regs->gpr[5], regs->gpr[6], regs->gpr[7]);
-	printk("GPR08: %08lx GPR09: %08lx GPR10: %08lx GPR11: %08lx\n",
-	       regs->gpr[8], regs->gpr[9], regs->gpr[10], regs->gpr[11]);
-	printk("GPR12: %08lx GPR13: %08lx GPR14: %08lx GPR15: %08lx\n",
-	       regs->gpr[12], regs->gpr[13], regs->gpr[14], regs->gpr[15]);
-	printk("GPR16: %08lx GPR17: %08lx GPR18: %08lx GPR19: %08lx\n",
-	       regs->gpr[16], regs->gpr[17], regs->gpr[18], regs->gpr[19]);
-	printk("GPR20: %08lx GPR21: %08lx GPR22: %08lx GPR23: %08lx\n",
-	       regs->gpr[20], regs->gpr[21], regs->gpr[22], regs->gpr[23]);
-	printk("GPR24: %08lx GPR25: %08lx GPR26: %08lx GPR27: %08lx\n",
-	       regs->gpr[24], regs->gpr[25], regs->gpr[26], regs->gpr[27]);
-	printk("GPR28: %08lx GPR29: %08lx GPR30: %08lx GPR31: %08lx\n",
-	       regs->gpr[28], regs->gpr[29], regs->gpr[30], regs->gpr[31]);
-	printk("  RES: %08lx oGPR11: %08lx\n",
-	       regs->gpr[11], regs->orig_gpr11);
-
-	printk("Process %s (pid: %d, stackpage=%08lx)\n",
-	       ((struct task_struct *)(__pa(current)))->comm,
-	       ((struct task_struct *)(__pa(current)))->pid,
-	       (unsigned long)current);
-
-	printk("\nStack: ");
-	printk("Stack dump [0x%08lx]:\n", (unsigned long)stack);
-	for (i = 0; i < kstack_depth_to_print; i++) {
-		if (((long)stack & (THREAD_SIZE - 1)) == 0)
-			break;
-		stack++;
-
-		printk("%lx :: sp + %02d: 0x%08lx\n", stack, i * 4,
-		       *((unsigned long *)(__pa(stack))));
-	}
-	printk("\n");
-
-	printk("Call Trace:   ");
-	i = 1;
-	while (((long)stack & (THREAD_SIZE - 1)) != 0) {
-		addr = *((unsigned long *)__pa(stack));
-		stack++;
-
-		if (kernel_text_address(addr)) {
-			if (i && ((i % 6) == 0))
-				printk("\n ");
-			printk(" [<%08lx>]", addr);
-			i++;
-		}
-	}
-	printk("\n");
-
-	printk("\nCode: ");
-
-	for (i = -24; i < 24; i++) {
-		unsigned long word;
-
-		word = ((unsigned long *)(__pa(regs->pc)))[i];
-
-		print_data(regs->pc, word, i);
-	}
-	printk("\n");
-}
-
 /* This is normally the 'Oops' routine */
 void __noreturn die(const char *str, struct pt_regs *regs, long err)
 {
-- 
2.39.1

