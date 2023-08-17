Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D120C77F578
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbjHQLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350397AbjHQLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:42:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E4E55
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:41:41 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdca7cc28dso44817155ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692272501; x=1692877301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FkyAXznhp6cOJAOhNLbLls85E4BqJM87BQMyq7g7kKg=;
        b=FaHk4pOhDKiJUO8dJ1D3mwYd1hPq2ZftPeZC1Qfk5gAy1K9CRp0Qy1xnbqKqZA3hwY
         k369oHtdVQAB4aqb4LWE8WfdcirACmCPX+Ws52lz7xUc5u+jLGz9VtGhtpRAHyYTnJvF
         c6Zt4ITaJuApTkmIPHULg0fCFrLTvd3edOTWU11WGWFaYJKUINz3yfAfiIXac59vqHem
         156LCIvdNI31YFrqCcKruCGdZD55O2TfWmBi2/Vn5xcVtHrtOkI6p4ZDX3aVafvT0ESY
         y9r484yITIcDPEEYe0cL1LbH9nM+fh8qgF4XRS4s411aVGdmoiJfsRXxrAVV+GitDEMp
         5MBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692272501; x=1692877301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkyAXznhp6cOJAOhNLbLls85E4BqJM87BQMyq7g7kKg=;
        b=SzwjBCD2OSSh8ojOaEBPMOeJ9WBo3B9nLY8NJhaj2FEDL+q7Kj0FlWMTrHF8Pt1mA6
         1ztdoNjIWVUk1B2XCcYFDe+yyUrT+rZDLKvX5DLKhF9Hd5n9fB/E6J6aQmrv+BPSlWhb
         A3IDyJaQNG/gBa+Qa7jSheQttWx5h2S3jT4oD+xoXMZkyRyG9wZCSm+5m2ve0uKWAFoD
         dYtK5ndbgHsTEf1xQ0T0x+A1edkDLqCFdBOi8j+b2sK5+p6gGPlvP0vmL1esRaamkav/
         8CdlhgMW+FFxNVhOB6TpHhmDVqnNX1BhxeVktY6ElluLcuCYMTPY01Ddmi8m/fk0ji8R
         kRqg==
X-Gm-Message-State: AOJu0YxuOzn4zqGM3vrLnlaLFmW6z3v7MY6n9V7kq5z48tz5UDMMktsW
        oSphQm4opykpFMG6gSvHa5DFJA==
X-Google-Smtp-Source: AGHT+IGoMA44hbMYCpEg+YZ5hRDT+s7bOFaD1KFta1HCgB887BPa4qTyui2SBXzLX5GATCamE/rgcQ==
X-Received: by 2002:a17:902:dacd:b0:1bc:5e85:9871 with SMTP id q13-20020a170902dacd00b001bc5e859871mr6227553plx.54.1692272501271;
        Thu, 17 Aug 2023 04:41:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id ji6-20020a170903324600b001bdf046ed63sm6447572plb.141.2023.08.17.04.41.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Aug 2023 04:41:40 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, bjorn@rivosinc.com,
        conor.dooley@microchip.com, jszhang@kernel.org,
        andy.chiu@sifive.com, cuiyunhui@bytedance.com,
        dave.hansen@linux.intel.com, elver@google.com, glider@google.com,
        cyphar@cyphar.com, kirill.shutemov@linux.intel.com,
        keescook@chromium.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv: add userland instruction dump to RISC-V splats
Date:   Thu, 17 Aug 2023 19:41:30 +0800
Message-Id: <20230817114130.24662-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added userland instruction dump in dump_kernel_instr().

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
 arch/riscv/kernel/traps.c | 10 +++++++---
 include/linux/uaccess.h   |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index f910dfccbf5d..a6a850e42d59 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -33,7 +33,7 @@ int show_unhandled_signals = 1;
 
 static DEFINE_SPINLOCK(die_lock);
 
-static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
+static void dump_instr(const char *loglvl, struct pt_regs *regs)
 {
 	char str[sizeof("0000 ") * 12 + 2 + 1], *p = str;
 	const u16 *insns = (u16 *)instruction_pointer(regs);
@@ -42,7 +42,10 @@ static void dump_kernel_instr(const char *loglvl, struct pt_regs *regs)
 	int i;
 
 	for (i = -10; i < 2; i++) {
-		bad = get_kernel_nofault(val, &insns[i]);
+		if (user_mode(regs))
+			bad = get_user_nofault(val, &insns[i]);
+		else
+			bad = get_kernel_nofault(val, &insns[i]);
 		if (!bad) {
 			p += sprintf(p, i == 0 ? "(%04hx) " : "%04hx ", val);
 		} else {
@@ -71,7 +74,7 @@ void die(struct pt_regs *regs, const char *str)
 	print_modules();
 	if (regs) {
 		show_regs(regs);
-		dump_kernel_instr(KERN_EMERG, regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	cause = regs ? regs->cause : -1;
@@ -104,6 +107,7 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
 		pr_cont("\n");
 		__show_regs(regs);
+		dump_instr(KERN_EMERG, regs);
 	}
 
 	force_sig_fault(signo, code, (void __user *)addr);
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 3064314f4832..ba8cb37a7241 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -385,6 +385,11 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 		long count);
 long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
+#define get_user_nofault(val, ptr) ({				\
+	const typeof(val) *__gk_ptr = (ptr);			\
+	copy_from_user_nofault(&(val), __gk_ptr, sizeof(val));\
+})
+
 #ifndef __get_kernel_nofault
 #define __get_kernel_nofault(dst, src, type, label)	\
 do {							\
-- 
2.20.1

