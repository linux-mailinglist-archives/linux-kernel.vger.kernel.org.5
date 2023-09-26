Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C125F7AEF61
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjIZPEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234991AbjIZPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:04:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6022210E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32163c3ece5so1120017f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695740636; x=1696345436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uuvfJ5AANk2b1H7qXwiqMjtZ5fx5LwQZGgrS2bH6zQ=;
        b=IvpG+fJbcpybBzYIchFjWpENMuIq3Vx6KOoTvLMPxnr5iL1A7Zn6JQI47IWz0KtEjF
         rpow7Mz0NFNh95y3GcAWUoaseXtO6RoF2KGcMxppbx40JcOwrdWCI4DKoC7BEP3ETuPp
         rtatnnjn4BNBN5xiematBqXKl3f6NXzaSX1FfTQYaTIoRshvB5pIxfNxSNQm0r+T0OVs
         6RrALLyHrQgHGLkXE0qRsPsahTIHvrnu1pubMDl/LLgs73EANRrj6rAv+eW2N94hbu6a
         4DBr2RppX45l02lOoDfzkmU/g7FMbTAm6oPtEg7zziACdVR9OGIl+Gg8gM47E4DCj/YF
         f5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695740636; x=1696345436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uuvfJ5AANk2b1H7qXwiqMjtZ5fx5LwQZGgrS2bH6zQ=;
        b=AkREh6fLpIJJhG8sh6iY2AgaN1f9GDi/MisL9iIjuQL/NPjs7dQIlJREWJfftJCoNk
         llEexLa+B4+eZsVKuLneZ47K6y/aHeMegNeMEqA65q2lB/MA4j9tukNWKR0cuk4pvucO
         3V+CwidZW1w8xMuwydc0F2FTb++dRJhPLuAnLSlqtyb14tjOlTCWIVnCUBdU7QmoFp4W
         +VSTnSwYsY5L3OT6jlQ/W2RxpwaE/P+ukwowDBtumDdLizIDrtiaEA3R8Tln7a0kMSlU
         0Na3gNXj64KbhEoYXPL/rwhXeQlOWs64LfKlUobVX7Xg5TTamU1A8SVAdoq8BeaZnFfG
         kEcQ==
X-Gm-Message-State: AOJu0YyA1yKO1mX5e4aT1JvLF8xwojZhNxtRnag/80fCCNtV3wKLBPhM
        EQCdk8yyF0e8e5ww6cpHwvw4Fg==
X-Google-Smtp-Source: AGHT+IE8kK7m+adK60EJSFNwZFOqJSMd+4wvMQfHEfjOwfK+qxITAch3QRj6sfjlQtjyWNy3/S6QzA==
X-Received: by 2002:adf:ed84:0:b0:322:c494:d481 with SMTP id c4-20020adfed84000000b00322c494d481mr9917893wro.0.1695740635757;
        Tue, 26 Sep 2023 08:03:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:2b3d:6c70:9dbf:5ede])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d650b000000b00318147fd2d3sm14926060wru.41.2023.09.26.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 08:03:55 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20Topel?= <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: [PATCH 4/7] riscv: add floating point insn support to misaligned access emulation
Date:   Tue, 26 Sep 2023 17:03:13 +0200
Message-Id: <20230926150316.1129648-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926150316.1129648-1-cleger@rivosinc.com>
References: <20230926150316.1129648-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This support is partially based of openSBI misaligned emulation floating
point instruction support. It provides support for the existing
floating point instructions (both for 32/64 bits as well as compressed
ones). Since floating point registers are not part of the pt_regs
struct, we need to modify them directly using some assembly. We also
dirty the pt_regs status in case we modify them to be sure context
switch will save FP state. With this support, Linux is on par with
openSBI support.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/fpu.S              | 117 +++++++++++++++++++++
 arch/riscv/kernel/traps_misaligned.c | 152 ++++++++++++++++++++++++++-
 2 files changed, 265 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/fpu.S b/arch/riscv/kernel/fpu.S
index dd2205473de7..2785badb247c 100644
--- a/arch/riscv/kernel/fpu.S
+++ b/arch/riscv/kernel/fpu.S
@@ -104,3 +104,120 @@ ENTRY(__fstate_restore)
 	csrc CSR_STATUS, t1
 	ret
 ENDPROC(__fstate_restore)
+
+#define get_f32(which) fmv.x.s a0, which; j 2f
+#define put_f32(which) fmv.s.x which, a1; j 2f
+#if __riscv_xlen == 64
+# define get_f64(which) fmv.x.d a0, which; j 2f
+# define put_f64(which) fmv.d.x which, a1; j 2f
+#else
+# define get_f64(which) fsd which, 0(a1); j 2f
+# define put_f64(which) fld which, 0(a1); j 2f
+#endif
+
+.macro fp_access_prologue
+	/*
+	 * Compute jump offset to store the correct FP register since we don't
+	 * have indirect FP register access
+	 */
+	sll t0, a0, 3
+	la t2, 1f
+	add t0, t0, t2
+	li t1, SR_FS
+	csrs CSR_STATUS, t1
+	jr t0
+1:
+.endm
+
+.macro fp_access_epilogue
+2:
+	csrc CSR_STATUS, t1
+	ret
+.endm
+
+#define fp_access_body(__access_func) \
+	__access_func(f0); \
+	__access_func(f1); \
+	__access_func(f2); \
+	__access_func(f3); \
+	__access_func(f4); \
+	__access_func(f5); \
+	__access_func(f6); \
+	__access_func(f7); \
+	__access_func(f8); \
+	__access_func(f9); \
+	__access_func(f10); \
+	__access_func(f11); \
+	__access_func(f12); \
+	__access_func(f13); \
+	__access_func(f14); \
+	__access_func(f15); \
+	__access_func(f16); \
+	__access_func(f17); \
+	__access_func(f18); \
+	__access_func(f19); \
+	__access_func(f20); \
+	__access_func(f21); \
+	__access_func(f22); \
+	__access_func(f23); \
+	__access_func(f24); \
+	__access_func(f25); \
+	__access_func(f26); \
+	__access_func(f27); \
+	__access_func(f28); \
+	__access_func(f29); \
+	__access_func(f30); \
+	__access_func(f31)
+
+
+/*
+ * Disable compressed instructions set to keep a constant offset between FP
+ * load/store/move instructions
+ */
+.option norvc
+/*
+ * put_f32_reg - Set a FP register from a register containing the value
+ * a0 = FP register index to be set
+ * a1 = value to be loaded in the FP register
+ */
+SYM_FUNC_START(put_f32_reg)
+	fp_access_prologue
+	fp_access_body(put_f32)
+	fp_access_epilogue
+SYM_FUNC_END(put_f32_reg)
+
+/*
+ * get_f32_reg - Get a FP register value and return it
+ * a0 = FP register index to be retrieved
+ */
+SYM_FUNC_START(get_f32_reg)
+	fp_access_prologue
+	fp_access_body(get_f32)
+	fp_access_epilogue
+SYM_FUNC_END(put_f32_reg)
+
+/*
+ * put_f64_reg - Set a 64 bits FP register from a value or a pointer.
+ * a0 = FP register index to be set
+ * a1 = value/pointer to be loaded in the FP register (when xlen == 32 bits, we
+ * load the value to a pointer).
+ */
+SYM_FUNC_START(put_f64_reg)
+	fp_access_prologue
+	fp_access_body(put_f64)
+	fp_access_epilogue
+SYM_FUNC_END(put_f64_reg)
+
+/*
+ * put_f64_reg - Get a 64 bits FP register value and returned it or store it to
+ *	 	 a pointer.
+ * a0 = FP register index to be retrieved
+ * a1 = If xlen == 32, pointer which should be loaded with the FP register value
+ *	or unused if xlen == 64. In which case the FP register value is returned
+ *	through a0
+ */
+SYM_FUNC_START(get_f64_reg)
+	fp_access_prologue
+	fp_access_body(get_f64)
+	fp_access_epilogue
+SYM_FUNC_END(get_f64_reg)
diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 804f6c5e0e44..041fd2dbd955 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -153,6 +153,115 @@
 #define PRECISION_S 0
 #define PRECISION_D 1
 
+#ifdef CONFIG_FPU
+
+#define FP_GET_RD(insn)		(insn >> 7 & 0x1F)
+
+extern void put_f32_reg(unsigned long fp_reg, unsigned long value);
+
+static int set_f32_rd(unsigned long insn, struct pt_regs *regs,
+		      unsigned long val)
+{
+	unsigned long fp_reg = FP_GET_RD(insn);
+
+	put_f32_reg(fp_reg, val);
+	regs->status |= SR_FS_DIRTY;
+
+	return 0;
+}
+
+extern void put_f64_reg(unsigned long fp_reg, unsigned long value);
+
+static int set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val)
+{
+	unsigned long fp_reg = FP_GET_RD(insn);
+	unsigned long value;
+
+#if __riscv_xlen == 32
+	value = (unsigned long) &val;
+#else
+	value = val;
+#endif
+	put_f64_reg(fp_reg, value);
+	regs->status |= SR_FS_DIRTY;
+
+	return 0;
+}
+
+#if __riscv_xlen == 32
+extern void get_f64_reg(unsigned long fp_reg, u64 *value);
+
+static u64 get_f64_rs(unsigned long insn, u8 fp_reg_offset,
+		      struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	u64 val;
+
+	get_f64_reg(fp_reg, &val);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+#else
+
+extern unsigned long get_f64_reg(unsigned long fp_reg);
+
+static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	unsigned long val;
+
+	val = get_f64_reg(fp_reg);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+
+#endif
+
+extern unsigned long get_f32_reg(unsigned long fp_reg);
+
+static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	unsigned long fp_reg = (insn >> fp_reg_offset) & 0x1F;
+	unsigned long val;
+
+	val = get_f32_reg(fp_reg);
+	regs->status |= SR_FS_DIRTY;
+
+	return val;
+}
+
+#else /* CONFIG_FPU */
+static void set_f32_rd(unsigned long insn, struct pt_regs *regs,
+		       unsigned long val) {}
+
+static void set_f64_rd(unsigned long insn, struct pt_regs *regs, u64 val) {}
+
+static unsigned long get_f64_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	return 0;
+}
+
+static unsigned long get_f32_rs(unsigned long insn, u8 fp_reg_offset,
+				struct pt_regs *regs)
+{
+	return 0;
+}
+
+#endif
+
+#define GET_F64_RS2(insn, regs) (get_f64_rs(insn, 20, regs))
+#define GET_F64_RS2C(insn, regs) (get_f64_rs(insn, 2, regs))
+#define GET_F64_RS2S(insn, regs) (get_f64_rs(RVC_RS2S(insn), 0, regs))
+
+#define GET_F32_RS2(insn, regs) (get_f32_rs(insn, 20, regs))
+#define GET_F32_RS2C(insn, regs) (get_f32_rs(insn, 2, regs))
+#define GET_F32_RS2S(insn, regs) (get_f32_rs(RVC_RS2S(insn), 0, regs))
+
 #ifdef CONFIG_RISCV_M_MODE
 static inline int load_u8(struct pt_regs *regs, const u8 *addr, u8 *r_val)
 {
@@ -362,15 +471,21 @@ int handle_misaligned_load(struct pt_regs *regs)
 		return -1;
 	}
 
+	if (!IS_ENABLED(CONFIG_FPU) && fp)
+		return -EOPNOTSUPP;
+
 	val.data_u64 = 0;
 	for (i = 0; i < len; i++) {
 		if (load_u8(regs, (void *)(addr + i), &val.data_bytes[i]))
 			return -1;
 	}
 
-	if (fp)
-		return -1;
-	SET_RD(insn, regs, val.data_ulong << shift >> shift);
+	if (!fp)
+		SET_RD(insn, regs, val.data_ulong << shift >> shift);
+	else if (len == 8)
+		set_f64_rd(insn, regs, val.data_u64);
+	else
+		set_f32_rd(insn, regs, val.data_ulong);
 
 	regs->epc = epc + INSN_LEN(insn);
 
@@ -383,7 +498,7 @@ int handle_misaligned_store(struct pt_regs *regs)
 	unsigned long epc = regs->epc;
 	unsigned long insn;
 	unsigned long addr = regs->badaddr;
-	int i, len = 0;
+	int i, len = 0, fp = 0;
 
 	perf_sw_event(PERF_COUNT_SW_ALIGNMENT_FAULTS, 1, regs, addr);
 
@@ -400,6 +515,14 @@ int handle_misaligned_store(struct pt_regs *regs)
 	} else if ((insn & INSN_MASK_SD) == INSN_MATCH_SD) {
 		len = 8;
 #endif
+	} else if ((insn & INSN_MASK_FSD) == INSN_MATCH_FSD) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2(insn, regs);
+	} else if ((insn & INSN_MASK_FSW) == INSN_MATCH_FSW) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2(insn, regs);
 	} else if ((insn & INSN_MASK_SH) == INSN_MATCH_SH) {
 		len = 2;
 #if defined(CONFIG_64BIT)
@@ -418,11 +541,32 @@ int handle_misaligned_store(struct pt_regs *regs)
 		   ((insn >> SH_RD) & 0x1f)) {
 		len = 4;
 		val.data_ulong = GET_RS2C(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSD) == INSN_MATCH_C_FSD) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2S(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSDSP) == INSN_MATCH_C_FSDSP) {
+		fp = 1;
+		len = 8;
+		val.data_u64 = GET_F64_RS2C(insn, regs);
+#if !defined(CONFIG_64BIT)
+	} else if ((insn & INSN_MASK_C_FSW) == INSN_MATCH_C_FSW) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2S(insn, regs);
+	} else if ((insn & INSN_MASK_C_FSWSP) == INSN_MATCH_C_FSWSP) {
+		fp = 1;
+		len = 4;
+		val.data_ulong = GET_F32_RS2C(insn, regs);
+#endif
 	} else {
 		regs->epc = epc;
 		return -1;
 	}
 
+	if (!IS_ENABLED(CONFIG_FPU) && fp)
+		return -EOPNOTSUPP;
+
 	for (i = 0; i < len; i++) {
 		if (store_u8(regs, (void *)(addr + i), val.data_bytes[i]))
 			return -1;
-- 
2.40.1

