Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5FC780B9A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376811AbjHRMPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376824AbjHRMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:15:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25788E7C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:15:15 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-26b399c6a4aso554874a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692360914; x=1692965714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/dyI2aIGIKCS+ZmVg3JhQYksxtHh82fOupuo38dlFco=;
        b=WJTZfyNTTyTH4r4oeSt4AHZQzdZjWqFzUSzv9rj9D4OL0eNFBUvg1q8GzvR+jMXLC0
         vAsoDEw/aay4UHBLfG3N8NWRhmLEHBpMwvT4ICoqDh1HpDfYBLd55xn0cYBugh50lSCM
         0X7nFy2hhJxkPuUitdxBZpbnVaCisPN6Y3RlOZ3YY3a2u2Hkiags1SrL34WpS79tVgBA
         tMJMfBeeNbbEXLGKOC47uq7zdj1uhGLX0JUDvjuqoIyndOl8ycGINBS+bvJyUooXJpnL
         6Y4CkMA/JddL3++heZ7MxX82QHyPYPglIyAc6dUB2ShNqIcH0YiMclTxXurqnqoOVJWr
         uNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692360914; x=1692965714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dyI2aIGIKCS+ZmVg3JhQYksxtHh82fOupuo38dlFco=;
        b=HprbOAti7TmvSXM5YLBFvT0IVggmc6g2Xhv+4Zz8ROswmJTvTdXqZHpKD+66P6Ixml
         CcElTAfqnXlwiR0lsV/sWHrgr+fi+SiTlcsznpMzxbfuaHhshKanvca5wkr2VBEk4P93
         4Am9XTyyC4/NMFWUWU89Rloe3U7FDP+Y4u4d87hbWnqi2aSOjdZBS7O7XqPnFwfRtdes
         f+8MjQbSztR81ShI5z6x3vWmsNrojRSuRsu/JPUQs1EdNekexCbS2FSCN9PrQqzhqzsN
         LGcH/sUXGp8zaWugKV6BTW/8dYpPTmYGxFSh7nAg7gkzJtj/dTsFsBk1JbfauZZgKA+K
         3dtw==
X-Gm-Message-State: AOJu0YxLKs50WuN9bp5cQhexBWfYyXgLD2QXlcnrXwZfvIcjPuwuMDav
        f1wyA9doRWla2pywslw/bEjEVMFVbFxy6fzth7U=
X-Google-Smtp-Source: AGHT+IF4x0l2vVL+nxG6H5cavkuZZmm71zaxUrKPLSw9GFclzVfkj4quozYKMB8junpaZOjML9YJ4Q==
X-Received: by 2002:a17:90a:b017:b0:268:fb85:3b2 with SMTP id x23-20020a17090ab01700b00268fb8503b2mr2114803pjq.7.1692360914619;
        Fri, 18 Aug 2023 05:15:14 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id js4-20020a17090b148400b0025dc5749b4csm3137540pjb.21.2023.08.18.05.15.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Aug 2023 05:15:14 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] riscv: add userland instruction dump to RISC-V splats
Date:   Fri, 18 Aug 2023 20:15:04 +0800
Message-Id: <20230818121504.60492-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/riscv/kernel/traps.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f798c853bede..69b5d18b5ae9 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -33,7 +33,24 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
-static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+#define get_user_nofault(val, ptr) ({				\
+	const typeof(val) *__gk_ptr = (ptr);			\
+	copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
+})
+
+static int copy_code(struct pt_regs *regs, u16 *val, const u16 *insns)
+{
+	if (!user_mode(regs))
+		return get_kernel_nofault(*val, insns);
+
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
+
+	return get_user_nofault(*val, insns);
+}
+
+static void dump_instr(const char *loglvl, struct pt_regs *regs)
 {
 	char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
 	const u16 *insns = (u16 *)instruction_pointer(regs);
@@ -42,7 +59,7 @@ static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
 	int i;
 
 	for (i = -10; i < 2; i++) {
-		bad = get_kernel_nofault(val, &insns[i]);
+		bad = copy_code(regs, &val, &insns[i]);
 		if (!bad) {
 			p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
 		} else {
@@ -71,7 +88,7 @@ void die(struct pt_regs *regs, const char *str)
 	print_modules();
 	if (regs) {
 		show_regs(regs);
-		dump_kernel_instr(KERN_EMERG, regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	cause = regs ? regs->cause : -1;
@@ -104,6 +121,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
-- 
2.20.1

