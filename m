Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430B079C42B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 05:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235632AbjILDcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 23:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbjILDcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 23:32:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3865B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:14:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fb2e9ebbfso1640134b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 19:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694484855; x=1695089655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMdI++gNYIzHXCNz0NYasP3u8jZS+14rJqhqLVImQDs=;
        b=Oj/oM0XvBc72YTQ5jz1jiFwRKG+j81TLPMEiLu8tetL90B6UhBde/yWZvCvZT8tGEz
         qvi/uG/TRsxTW04yBzL5hdwkUrotXKONEjWkqGqc24PSBgR+1dtg+iZC/fEuN65hB2jT
         RVpTUvlA6Ib5U/9wnvWLywOCcGvHWOrV/IyMi/MOBXkfU/xL7kI2lfgHKrMTXojcsZHc
         Wew0M5j0a8blprwgblWSH82Rl5IhXvtQnGVMs9ZiQ0ougewqL8tC/UYo0xuIE1eD/aga
         iZP33c7x9orzTXUkAoA/G9UHxKrHsax9EGLZUbgdcFU4vPCc8RVTg4OPg9AHHz4BcKFX
         F+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694484855; x=1695089655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMdI++gNYIzHXCNz0NYasP3u8jZS+14rJqhqLVImQDs=;
        b=nN5iWPvPXIp7UhMeycQXwh5tLIP4onIsxSAtYAgNh04Mgoa06lJHDSML+PDLSpslka
         I4pl6lPZ7SPSXmFlYAcZOq0HkMAFzSGZXniEUyaaVKpuu5EA4cPDv8dyzDimDH21gofK
         jNRJkoABIFZmj8NWBwEDSZS3ZbOc5N5Fz/hoA4uLs+iP+38+Hw0BoJ91N9jHW/16zsyd
         7fosWemOx9YSx4sXxdNkkse2L+kxgTPsQTd4RKrdKB3hoyV8qwtuD6dE3nxDdKOaNbKl
         y+xZEwiIakyD+k7Cuf0lNjVmARZLOwbTjUL38zZC1LO5KiN2lYMP22X027vdkQWoWIRq
         CIcQ==
X-Gm-Message-State: AOJu0YzBYOVDhCpemqyenUhVS1Ud4fFblR9iUWATYOLUCGwYQG7LAWYt
        WZSdh3zDyYfQpQsRgOZ4N/sIl/0uuEghfQKkumSEMA==
X-Google-Smtp-Source: AGHT+IFJ8bD5SV0c6ZwDJS8oPfnvL8ApGejDumlH0l8Gj0ZH3x4lpjB48U9RQa+O95ArOwni7dQVDw==
X-Received: by 2002:a05:6a00:4395:b0:68f:e0c2:6d46 with SMTP id bt21-20020a056a00439500b0068fe0c26d46mr1952828pfb.23.1694484855307;
        Mon, 11 Sep 2023 19:14:15 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.9])
        by smtp.gmail.com with ESMTPSA id e17-20020a637451000000b0055387ffef10sm2991543pgn.24.2023.09.11.19.14.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Sep 2023 19:14:14 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6] riscv: add userland instruction dump to RISC-V splats
Date:   Tue, 12 Sep 2023 10:13:49 +0800
Message-Id: <20230912021349.28302-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add userland instruction dump and rename dump_kernel_instr()
to dump_instr().

An example:
[    0.822439] Freeing unused kernel image (initmem) memory: 6916K
[    0.823817] Run /init as init process
[    0.839411] init[1]: unhandled signal 4 code 0x1 at 0x000000000005be18 in bb[10000+5fb000]
[    0.840751] CPU: 0 PID: 1 Comm: init Not tainted 5.14.0-rc4-00049-gbd644290aa72-dirty #187
[    0.841373] Hardware name:  , BIOS
[    0.841743] epc : 000000000005be18 ra : 0000000000079e74 sp : 0000003fffcafda0
[    0.842271]  gp : ffffffff816e9dc8 tp : 0000000000000000 t0 : 0000000000000000
[    0.842947]  t1 : 0000003fffc9fdf0 t2 : 0000000000000000 s0 : 0000000000000000
[    0.843434]  s1 : 0000000000000000 a0 : 0000003fffca0190 a1 : 0000003fffcafe18
[    0.843891]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[    0.844357]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000000000
[    0.844803]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
[    0.845253]  s5 : 0000000000000000 s6 : 0000000000000000 s7 : 0000000000000000
[    0.845722]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
[    0.846180]  s11: 0000000000d144e0 t3 : 0000000000000000 t4 : 0000000000000000
[    0.846616]  t5 : 0000000000000000 t6 : 0000000000000000
[    0.847204] status: 0000000200000020 badaddr: 00000000f0028053 cause: 0000000000000002
[    0.848219] Code: f06f ff5f 3823 fa11 0113 fb01 2e23 0201 0293 0000 (8053) f002
[    0.851016] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/traps.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede..bd2e8fa25c43 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -33,7 +33,21 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
-static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
+{
+	const void __user *uaddr = (__force const void __user *)insns;
+
+	if (!user_mode(regs))
+		return get_kernel_nofault(*val, insns);
+
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
+
+	return copy_from_user_nofault(val, uaddr, sizeof(*val));
+}
+
+static void dump_instr(const char *loglvl, struct pt_regs *regs)
 {
 	char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
 	const u16 *insns = (u16 *)instruction_pointer(regs);
@@ -42,7 +56,7 @@ static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
 	int i;
 
 	for (i = -10; i < 2; i++) {
-		bad = get_kernel_nofault(val, &insns[i]);
+		bad = copy_code(regs, &val, &insns[i]);
 		if (!bad) {
 			p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
 		} else {
@@ -71,7 +85,7 @@ void die(struct pt_regs *regs, const char *str)
 	print_modules();
 	if (regs) {
 		show_regs(regs);
-		dump_kernel_instr(KERN_EMERG, regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	cause = regs ? regs->cause : -1;
@@ -104,6 +118,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.20.1

