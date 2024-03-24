Return-Path: <linux-kernel+bounces-112859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EADC887F1E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79183B21084
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD523A8D0;
	Sun, 24 Mar 2024 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmAyYgxh"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EAD1CD04;
	Sun, 24 Mar 2024 21:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314930; cv=none; b=qEE8VerDId/UOfak+OekTVGb6urXyJx+momVkezfkkVwxXhSrBqH+7a5kC6qkctvaCicWRxsFT2lfAoCM1hS7H7HZxZmoLcTUcyfWPRKxmNDjrhehztDLBuFDbdlILhoQR+fx+zm7MVUHw/PSlX5BpBd1JERz2/JomEWYhpmsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314930; c=relaxed/simple;
	bh=6dE6L6hhlGhATyKGSiBlGja2p9URTXf642USYkjqJ7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WCuBlzGh50OpVY80A/BZU/9bsN8y064VLF9xddasuquFl4fDDpRqhdX+jsYyIJcUyw7midoSkYSLb+PIwGmHR6r9BfYUl2445TFimIoEh/zF/akppCk43HUxYVr17+TvA8OBnyx/DBntyKEg0JFQZBydYdKltjcBoMOcUMM6MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmAyYgxh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-341c7c8adf3so681077f8f.0;
        Sun, 24 Mar 2024 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711314927; x=1711919727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+hQBZmnSVN9HewOiblrQK3C2T98xP0zStDNINtIws0=;
        b=mmAyYgxhXoQI6tD75fD0huy9efvRYyjnHQpcxuvNpx2J41SQpjVbfIdAKB05PIIGYN
         BAcggwYdcB78WnquScXU/x1SulosiAorcTsj8ci7pgdRYR5UkxUPhhOrYqp0ij78Cf0o
         IY/iEe9LEeIlQnk0Wxl0io4Lc9YWENlTaKVPo94vbeLNZE8867F8Spu6uLeoTPWN96pm
         c1HQJN4cjKKBdmdzZfUOe/bPhmLbAqfdtzD37NuP7gqvR1tJBEqmrjCDZfI9mMO8mu++
         D4Lile76IghjtwEikNZL1XdrTTBeXa7EcjOcIFVST/g0RLH98lJZKPhRy9oKjV8tkoH1
         eNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711314927; x=1711919727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+hQBZmnSVN9HewOiblrQK3C2T98xP0zStDNINtIws0=;
        b=Msb5wkRm1HmeqRcHjbpt1qbH7zhSLmpzrCcSIdfLRJc3g5PB5HWrTCqvfLUWVUk9d8
         JJnb5DSasztS74aojr0KLcGKbcGDiHR/zQpWl4hURcwkWLMeWUlwKjCMsAd02ODlc+U1
         JbP4FhQUbfiDZEtCfzRdPARfbB4S7gChpueknWbmZrxIGPmRYgB6UU5NdEpCLA1fZkep
         r6PGeLfcztVNsZwoU9nHGHPt7zjiLfJ4dULtR7diRBQCZY2JdRB0B8izFCN5eIsb/UwE
         MK5Gh3CJZhIfRS3D+UZbs9h6sW7JZezVNUWiJ0wQqmoI6jykBf7Jeam1Zj2Vlr0aRa/o
         zf+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9kTposuF78EtZdarSo4h3a5wAihPqBZBrJ4mfu/ApFPKsC/wyc1g1CpU7i/MILiLaQX16L4wyedLMA3RIIWN1viYDUQ5QyXYT/DC//6kbT68gDhkt3B8e8UkoaTSSzr3w
X-Gm-Message-State: AOJu0Yzg26dA7rbuIRvOspMlll+pcoo7SUjj6+J+ZK1KhlPD9KsYjZkE
	Jc8GJJnI9VPc/Oaaup74sbELPD/7AzSXBUE2TutCRHZcrNzxvbYh
X-Google-Smtp-Source: AGHT+IF09u55LK04HZ2m7C725taCQ/WMxwE6LLOn76lGa8Iy6EkDzdDPuIlI/2LpVPSHkKzFCPGiOw==
X-Received: by 2002:adf:e887:0:b0:341:bfe2:4509 with SMTP id d7-20020adfe887000000b00341bfe24509mr3183574wrm.42.1711314926668;
        Sun, 24 Mar 2024 14:15:26 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id t13-20020a5d42cd000000b0033ec312cd8asm7625890wrr.33.2024.03.24.14.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2024 14:15:26 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list),
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)),
	Josh Poimboeuf <jpoimboe@kernel.org>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next v2 1/1] arm64/cfi,bpf: Support kCFI + BPF on arm64
Date: Sun, 24 Mar 2024 21:15:18 +0000
Message-Id: <20240324211518.93892-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240324211518.93892-1-puranjay12@gmail.com>
References: <20240324211518.93892-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, bpf_dispatcher_*_func() is marked with `__nocfi` therefore
calling BPF programs from this interface doesn't cause CFI warnings.

When BPF programs are called directly from C: from BPF helpers or
struct_ops, CFI warnings are generated.

Implement proper CFI prologues for the BPF programs and callbacks and
drop __nocfi for arm64. Fix the trampoline generation code to emit kCFI
prologue when a struct_ops trampoline is being prepared.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/include/asm/cfi.h    | 23 ++++++++++++++
 arch/arm64/kernel/alternative.c | 54 +++++++++++++++++++++++++++++++++
 arch/arm64/net/bpf_jit_comp.c   | 28 +++++++++++++----
 3 files changed, 99 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm64/include/asm/cfi.h

diff --git a/arch/arm64/include/asm/cfi.h b/arch/arm64/include/asm/cfi.h
new file mode 100644
index 000000000000..670e191f8628
--- /dev/null
+++ b/arch/arm64/include/asm/cfi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARM64_CFI_H
+#define _ASM_ARM64_CFI_H
+
+#ifdef CONFIG_CFI_CLANG
+#define __bpfcall
+static inline int cfi_get_offset(void)
+{
+	return 4;
+}
+#define cfi_get_offset cfi_get_offset
+extern u32 cfi_bpf_hash;
+extern u32 cfi_bpf_subprog_hash;
+extern u32 cfi_get_func_hash(void *func);
+#else
+#define cfi_bpf_hash 0U
+#define cfi_bpf_subprog_hash 0U
+static inline u32 cfi_get_func_hash(void *func)
+{
+	return 0;
+}
+#endif /* CONFIG_CFI_CLANG */
+#endif /* _ASM_ARM64_CFI_H */
diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 8ff6610af496..1715da7df137 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -13,6 +13,7 @@
 #include <linux/elf.h>
 #include <asm/cacheflush.h>
 #include <asm/alternative.h>
+#include <asm/cfi.h>
 #include <asm/cpufeature.h>
 #include <asm/insn.h>
 #include <asm/module.h>
@@ -298,3 +299,56 @@ noinstr void alt_cb_patch_nops(struct alt_instr *alt, __le32 *origptr,
 		updptr[i] = cpu_to_le32(aarch64_insn_gen_nop());
 }
 EXPORT_SYMBOL(alt_cb_patch_nops);
+
+#ifdef CONFIG_CFI_CLANG
+struct bpf_insn;
+
+/* Must match bpf_func_t / DEFINE_BPF_PROG_RUN() */
+extern unsigned int __bpf_prog_runX(const void *ctx,
+				    const struct bpf_insn *insn);
+
+/*
+ * Force a reference to the external symbol so the compiler generates
+ * __kcfi_typid.
+ */
+__ADDRESSABLE(__bpf_prog_runX);
+
+/* u32 __ro_after_init cfi_bpf_hash = __kcfi_typeid___bpf_prog_runX; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_hash,@object				\n"
+"	.globl	cfi_bpf_hash					\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_hash:							\n"
+"	.word	__kcfi_typeid___bpf_prog_runX			\n"
+"	.size	cfi_bpf_hash, 4					\n"
+"	.popsection						\n"
+);
+
+/* Must match bpf_callback_t */
+extern u64 __bpf_callback_fn(u64, u64, u64, u64, u64);
+
+__ADDRESSABLE(__bpf_callback_fn);
+
+/* u32 __ro_after_init cfi_bpf_subprog_hash = __kcfi_typeid___bpf_callback_fn; */
+asm (
+"	.pushsection	.data..ro_after_init,\"aw\",@progbits	\n"
+"	.type	cfi_bpf_subprog_hash,@object			\n"
+"	.globl	cfi_bpf_subprog_hash				\n"
+"	.p2align	2, 0x0					\n"
+"cfi_bpf_subprog_hash:						\n"
+"	.word	__kcfi_typeid___bpf_callback_fn			\n"
+"	.size	cfi_bpf_subprog_hash, 4				\n"
+"	.popsection						\n"
+);
+
+u32 cfi_get_func_hash(void *func)
+{
+	u32 hash;
+
+	if (get_kernel_nofault(hash, func - cfi_get_offset()))
+		return 0;
+
+	return hash;
+}
+#endif
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index bc16eb694657..2372812bb47c 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -17,6 +17,7 @@
 #include <asm/asm-extable.h>
 #include <asm/byteorder.h>
 #include <asm/cacheflush.h>
+#include <asm/cfi.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/patching.h>
@@ -158,6 +159,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
 		emit(insn, ctx);
 }
 
+static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
+{
+	if (IS_ENABLED(CONFIG_CFI_CLANG))
+		emit(hash, ctx);
+}
+
 /*
  * Kernel addresses in the vmalloc space use at most 48 bits, and the
  * remaining bits are guaranteed to be 0x1. So we can compose the address
@@ -295,7 +302,7 @@ static bool is_lsi_offset(int offset, int scale)
 #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
-			  bool is_exception_cb)
+			  bool is_exception_cb, bool is_subprog)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
@@ -306,7 +313,6 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -332,6 +338,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	 *
 	 */
 
+	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
+	const int idx0 = ctx->idx;
 	/* bpf function may be invoked by 3 instruction types:
 	 * 1. bl, attached via freplace to bpf prog via short jump
 	 * 2. br, attached via freplace to bpf prog via long jump
@@ -1648,7 +1656,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
+	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
+			   bpf_is_subprog(prog))) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1696,7 +1705,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
+	build_prologue(&ctx, was_classic, prog->aux->exception_cb,
+		       bpf_is_subprog(prog));
 
 	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
@@ -1745,9 +1755,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		jit_data->ro_header = ro_header;
 	}
 
-	prog->bpf_func = (void *)ctx.ro_image;
+	prog->bpf_func = (void *)ctx.ro_image + cfi_get_offset();
 	prog->jited = 1;
-	prog->jited_len = prog_size;
+	prog->jited_len = prog_size - cfi_get_offset();
 
 	if (!prog->is_func || extra_pass) {
 		int i;
@@ -2011,6 +2021,12 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	/* return address locates above FP */
 	retaddr_off = stack_size + 8;
 
+	if (flags & BPF_TRAMP_F_INDIRECT) {
+		/*
+		 * Indirect call for bpf_struct_ops
+		 */
+		emit_kcfi(cfi_get_func_hash(func_addr), ctx);
+	}
 	/* bpf trampoline may be invoked by 3 instruction types:
 	 * 1. bl, attached to bpf prog or kernel function via short jump
 	 * 2. br, attached to bpf prog or kernel function via long jump
-- 
2.40.1


