Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B648A78FD49
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349461AbjIAMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349458AbjIAMbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:31:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2E910CA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:30:55 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bee12e842so1576738b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 05:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693571455; x=1694176255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OQC+A17dBwkV5biq6l7N28Il7bmSGqCXLaMTa2BoUI=;
        b=dZmOC1UZNzlSB9nYMMB8IaztL6wLAR56nttBgh1Kc5yOFBB6+6O8Jkn3KgO43KLqWL
         2Gg8V3rnzPrZMQ8Bh3HtZsyJrSypioQoEDGP6K4CS8dTSxiHn+z2RNOO0T4hoTUef+5k
         lzcX4wIghN4rBnmIXahAXPH+d5TOFwbDPqt7p07z2s8YlMmQHoTZhX4PHFJIE4zKMu8r
         5lMXetsNU7X4vJ3J+NxRS1oWLf+FSR5qB//rA1GLOkbeKCwoZHl71ORf1p0hwF3WxOGQ
         i4zR/6I2+BoDJlHzpSWS07vJaKMAA/vAzZF6IXpYjQ6k7+3uQxWXbyPjKy0PofqviMbN
         yqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693571455; x=1694176255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OQC+A17dBwkV5biq6l7N28Il7bmSGqCXLaMTa2BoUI=;
        b=fZ+PVvI2Dw6OMR77hSc/97QUvS0ZJY85I8vus3X9OzLetdQ2Z24zeRk3JvGYXCuSop
         9eAvojxkBSDwj6CJcBrBxMuklVvNczFXyp8+/vlrcBR/Z8IFmEoR5fXHb+Dnel1grqr6
         F3ehlbjT6XK1fX19GMEba9BzEkHQrAd0mcX0+mZOPkWkfqEO4UO3L12rXav4deD5Txbt
         LM1WrUAMRVXhmveIinEPrZfxjJS02a3EQRyNzbEQC3/+V650jlmW5I+Ynxs3o6gwP70A
         4wKFCggC31g4vF3/I3srsefVbRrQMFgGU5MXh8XyuPowApEO5BLz0KbbGeay07o6/8Dm
         XNCQ==
X-Gm-Message-State: AOJu0Yw/oYfUrHi3vvYzmU6vsqYQ8TSzg6jPIRz8bRzQWgUcSwtBSVEP
        t7hYBQxl0posJjgf6uotMlweHQ==
X-Google-Smtp-Source: AGHT+IFpH9TYzbvlVnhSRXGMUYD2omRkS3XxiP6OjYn9bZEgjSIYmWkrlFuNTdgydF6T77aIplkZIw==
X-Received: by 2002:a05:6a21:3390:b0:147:fd40:2482 with SMTP id yy16-20020a056a21339000b00147fd402482mr2974232pzb.44.1693571454993;
        Fri, 01 Sep 2023 05:30:54 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id s19-20020aa78293000000b006889081281bsm2861184pfm.138.2023.09.01.05.30.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Sep 2023 05:30:53 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] riscv: add userland instruction dump to RISC-V splats
Date:   Fri,  1 Sep 2023 20:30:43 +0800
Message-Id: <20230901123043.73700-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 arch/riscv/kernel/traps.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede..923b49c38985 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -33,7 +33,19 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
-static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
+{
+	if (!user_mode(regs))
+		return get_kernel_nofault(*val, insns);
+
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
+
+	return copy_from_user_nofault(val, insns, sizeof(*val));
+}
+
+static void dump_instr(const char *loglvl, struct pt_regs *regs)
 {
 	char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
 	const u16 *insns = (u16 *)instruction_pointer(regs);
@@ -42,7 +54,7 @@ static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
 	int i;
 
 	for (i = -10; i < 2; i++) {
-		bad = get_kernel_nofault(val, &insns[i]);
+		bad = copy_code(regs, &val, &insns[i]);
 		if (!bad) {
 			p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
 		} else {
@@ -71,7 +83,7 @@ void die(struct pt_regs *regs, const char *str)
 	print_modules();
 	if (regs) {
 		show_regs(regs);
-		dump_kernel_instr(KERN_EMERG, regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	cause = regs ? regs->cause : -1;
@@ -104,6 +116,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.20.1

