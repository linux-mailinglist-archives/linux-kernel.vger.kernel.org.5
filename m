Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5405178C060
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjH2Ihf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjH2IhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:37:23 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B98A4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:37:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c136ee106so528800166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693298239; x=1693903039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9iMpNXmIevE0BgwMDd4WWAnKWJLVfTLbZLwahfl61w=;
        b=bHALBVKUf3mzqjp5qBc54g26ErG0SAuQJGsGxNfmi9t4X8AcX1imw+RSpS5Z3Kh6h8
         ZkfFCO6U50LasBNoPW2zybtvb7zbV9y4T5QgXyYGXfSXJF17AW4lL+vt1eosQK4/KEAI
         zcK+Pcoc6yEtAQriLTCNQdPRF09WbFebyIw8+z1M4f3a/rpgdDZr6ofwLAaJukTjfx4X
         TQ92HdRCuqDNpVmSeeAycj931QggLaB+ifyEYj969j89qnKHfIdkVFN7ssU+XWKVY3o9
         Ey4JzgHaVZnyWMZSPgekXDJFuIqRjG4ygfOFH8DEbmfxXPGFrmOeEGF5CAZFzd9ZaFya
         CVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693298239; x=1693903039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9iMpNXmIevE0BgwMDd4WWAnKWJLVfTLbZLwahfl61w=;
        b=HFnH01XWnobcL9px5cNXCKTeIGwWnXAuWO7NE7XE5ulPZGDxIkKKKnbezqOHjIF5hq
         MpPhZ6os93nDBi6IhjB1yYPyRfn1Rp6SoIYjfleRVtHQV/ZfJ1wLLKHjnnS/zHOVg3Ri
         YHZJR1Ax07S+FHWbgnYZSYpNko4EFOpcKAD6kLl1b8Cw37TvWIe3rJpgKgiPiglZdlJF
         uLC6yCkPdfnwfGDeLIJgShKCvOGJwOuklwhcBogFGF8W1yrqL2CnG7Pw16xsA3Kg6Mdp
         4qf2ZkH2jtnT/NDeSHzFGi2wrNXuiA1GR4EbBQ18rLAAbmJ+g33PH98pddb5GpgKBNqx
         mz+A==
X-Gm-Message-State: AOJu0YyrwhbtGxPnpY2lBlVHUKBGR1LCPfKGFn3eVLayUnSAsNy74/YD
        YQow0wqj2Y4V521og2RO6Jw=
X-Google-Smtp-Source: AGHT+IG2AEi8AUkfv4qjEMaIGKPkcicN1p+fKc05evfp7vAQ8dWGFeUa2PUha7EV15lGbyxAZQ5UAg==
X-Received: by 2002:a17:906:7699:b0:9a2:1e03:1573 with SMTP id o25-20020a170906769900b009a21e031573mr11068276ejm.65.1693298238863;
        Tue, 29 Aug 2023 01:37:18 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id lx16-20020a170906af1000b0098de7d28c34sm5706257ejb.193.2023.08.29.01.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:37:18 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     bjorn@kernel.org, guoren@kernel.org, conor.dooley@microchip.com,
        Nam Cao <namcaov@gmail.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2] riscv: provide riscv-specific is_trap_insn()
Date:   Tue, 29 Aug 2023 10:36:15 +0200
Message-Id: <20230829083614.117748-1-namcaov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

uprobes expects is_trap_insn() to return true for any trap instructions,
not just the one used for installing uprobe. The current default
implementation only returns true for 16-bit c.ebreak if C extension is
enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
exception from userspace: uprobes asks is_trap_insn() who says there is no
trap, so uprobes assume a probe was there before but has been removed, and
return to the trap instruction. This causes an infinite loop of entering
and exiting trap handler.

Instead of using the default implementation, implement this function
speficially for riscv with checks for both ebreak and c.ebreak.

Fixes: 74784081aac8 ("riscv: Add uprobes supported")
Signed-off-by: Nam Cao <namcaov@gmail.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
v2: remove #ifdef CONFIG_RISCV_ISA_C (Guo Ren)

 arch/riscv/kernel/probes/uprobes.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probes/uprobes.c
index 194f166b2cc4..4b3dc8beaf77 100644
--- a/arch/riscv/kernel/probes/uprobes.c
+++ b/arch/riscv/kernel/probes/uprobes.c
@@ -3,6 +3,7 @@
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
 #include <linux/uprobes.h>
+#include <asm/insn.h>
 
 #include "decode-insn.h"
 
@@ -17,6 +18,11 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
 #endif
 }
 
+bool is_trap_insn(uprobe_opcode_t *insn)
+{
+	return riscv_insn_is_ebreak(*insn) || riscv_insn_is_c_ebreak(*insn);
+}
+
 unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
-- 
2.34.1

