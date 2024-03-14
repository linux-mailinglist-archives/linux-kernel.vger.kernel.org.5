Return-Path: <linux-kernel+bounces-103446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6F487BF71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D771C21495
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE18771B3C;
	Thu, 14 Mar 2024 15:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvlDYO6y"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A72B71749;
	Thu, 14 Mar 2024 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428416; cv=none; b=BVGvdaFCXeStiawI76ZmNc4cPFBfK5TOuSB/tHqxHf1KU7dKOBuOBObBkVxvpw/Vxlw47XHcMVKlGVABpdHxUIP+71CRGdO1bMIfdOfSrVRyRNBh0Zz/Kl7erjCf4YIaIDpE25cqNKbyrjYISu0GROX+H0EIbiGfxfgoxHlBdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428416; c=relaxed/simple;
	bh=yAG115ATII8VMHxeg3dEhfZN1mRkO7nQDHO3xzPHF5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpQ138xmIfDP/HxsVDbqjKUHTa5rXYXzgta8CPSxFknyV8f/PxBAlWCvlkwYqcwAzE3jC0Cr1Ly5SWapIsoUCu8m7QjF2uhI9GI5larJsdoCToMVx5WSQDHzBI0HnWe9VmQTAcsQ24ei2QFEY/lkrIBRz9ExHLbjyfiRQpHTIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvlDYO6y; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-513b022a238so1430474e87.0;
        Thu, 14 Mar 2024 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710428412; x=1711033212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5A2DmH/4DEJIbboJZbQFHydQ2Im+0QkmARS/xgHUPI=;
        b=AvlDYO6yRKEWbQKxBlAppCsMOni6LNjywHNn5nwPF+vTXgD/hB47rcJel+Xp9CHLAt
         OBWjlJ9yedCIEzkKI4+h/h+hRrS+qNYJn3QI3ISEZZA5wblD8EotFpkv8LQvfodufTwl
         xumAfkaXZhmuoSierAxf26Fb/1bQG7A8VdELM5sqJDq1EtXvJaeMe9Uo4Y/Yq/GzVEnr
         2nggRMj7xOUZh3orpyu4sN820d3NPf84F72oT/SID8VnuYTsfdwb98Dh/k4+kVADEs4q
         YUdmvV+5zqN7yWh8oJgYgv501H7N0eyAx80qhJfYXSI16RLAockaYC8L0sriszCvw9FS
         TvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428412; x=1711033212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5A2DmH/4DEJIbboJZbQFHydQ2Im+0QkmARS/xgHUPI=;
        b=SrdpRGxWwT4tUGIm2EjDbiH+xcnV636VlbrYrj7/u5PI3xglXtPZNG7go1m7BRHy8Q
         HhP285rLkdMTw7wgWiN7s9fmTv4jEpVTHYFPjfARdAxaTFym/Y/qtcJcNYobWV5nNOkM
         lfXVUx38oqOu1BW8+xVmxyBDGKTwGQys/cmER4z83tSZg3rNYRATS2Yy4S5D+umeSPxU
         F7j3d5uzKenL4xVnhaOrgY91dw+OyfnsPFacRAvOZOkwn5kkmys3+BFX4cjtOEID4Z2U
         /BxAhcY0yqdctc6p0cRWhtleYf/JcS9mtbcu3B5GhVr6pJKzOm7XIjEqwJH8P4RBDuY/
         u1fg==
X-Forwarded-Encrypted: i=1; AJvYcCUaTuO0DA9kqdWtFcmGywil9bNJJ7T6ti8NAeZMiOFSRHNOwNTouHX/9OSkw18XpRhpRgG5zZyPUsEUUw8pyGgtKYN0NB0807Gwk8ncYvZ16IUZgOan4sOwFPMgkOA86ZpF
X-Gm-Message-State: AOJu0YxKimNOfcy3LMngW3YB7J8UlZDN1DUOZJf7118GGY3+EXKCFMmf
	20/p0jywzpiIJgBJ/jzkNY+pCw742WtWBPw9Ga55afhMJbc1ALV1
X-Google-Smtp-Source: AGHT+IHRY18iWCdsZXbAQ5qJh72aXG/SANqeUwS1l1UukZ4qwWthRou395QjPWPHO8x7HnBQVroEDA==
X-Received: by 2002:ac2:47fb:0:b0:513:c2e6:fbb2 with SMTP id b27-20020ac247fb000000b00513c2e6fbb2mr1473706lfp.62.1710428411770;
        Thu, 14 Mar 2024 08:00:11 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b004132f3ace5csm5836312wmq.37.2024.03.14.08.00.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:00:11 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>
Cc: puranjay12@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
Date: Thu, 14 Mar 2024 15:00:02 +0000
Message-Id: <20240314150003.123020-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240314150003.123020-1-puranjay12@gmail.com>
References: <20240314150003.123020-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
instructions.  They are similar to PROBE_MEM instructions with the
following differences:
- PROBE_MEM32 supports store.
- PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
  src/dst register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in R28
  in the prologue). Due to bpf_arena constructions such R28 + reg +
  off16 access is guaranteed to be within arena virtual range, so no
  address check at run-time.
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
  LDX faults the destination register is zeroed.

To support these on arm64, we do tmp2 = R28 + src/dst reg and then use
tmp2 as the new src/dst register. This allows us to reuse most of the
code for normal [LDX | STX | ST].

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 70 ++++++++++++++++++++++++++++++-----
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda438..ce66c17b73a0 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -29,6 +29,7 @@
 #define TCALL_CNT (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
 #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
+#define PROBE_MEM32_BASE (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -67,6 +68,8 @@ static const int bpf2a64[] = {
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
 	[FP_BOTTOM] = A64_R(27),
+	/* callee saved register for kern_vm_start address */
+	[PROBE_MEM32_BASE] = A64_R(28),
 };
 
 struct jit_ctx {
@@ -295,7 +298,7 @@ static bool is_lsi_offset(int offset, int scale)
 #define PROLOGUE_OFFSET (BTI_INSNS + 2 + PAC_INSNS + 8)
 
 static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
-			  bool is_exception_cb)
+			  bool is_exception_cb, u64 arena_vm_start)
 {
 	const struct bpf_prog *prog = ctx->prog;
 	const bool is_main_prog = !bpf_is_subprog(prog);
@@ -306,6 +309,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 tcc = bpf2a64[TCALL_CNT];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
+	const u8 pb = bpf2a64[PROBE_MEM32_BASE];
 	const int idx0 = ctx->idx;
 	int cur_offset;
 
@@ -411,6 +415,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 
 	/* Set up function call stack */
 	emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
+
+	if (arena_vm_start)
+		emit_a64_mov_i64(pb, arena_vm_start, ctx);
+
 	return 0;
 }
 
@@ -738,6 +746,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 
 #define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+#define DONT_CLEAR 32
 
 bool ex_handler_bpf(const struct exception_table_entry *ex,
 		    struct pt_regs *regs)
@@ -745,7 +754,8 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 	off_t offset = FIELD_GET(BPF_FIXUP_OFFSET_MASK, ex->fixup);
 	int dst_reg = FIELD_GET(BPF_FIXUP_REG_MASK, ex->fixup);
 
-	regs->regs[dst_reg] = 0;
+	if (dst_reg != DONT_CLEAR)
+		regs->regs[dst_reg] = 0;
 	regs->pc = (unsigned long)&ex->fixup - offset;
 	return true;
 }
@@ -765,7 +775,8 @@ static int add_exception_handler(const struct bpf_insn *insn,
 		return 0;
 
 	if (BPF_MODE(insn->code) != BPF_PROBE_MEM &&
-		BPF_MODE(insn->code) != BPF_PROBE_MEMSX)
+		BPF_MODE(insn->code) != BPF_PROBE_MEMSX &&
+			BPF_MODE(insn->code) != BPF_PROBE_MEM32)
 		return 0;
 
 	if (!ctx->prog->aux->extable ||
@@ -810,6 +821,9 @@ static int add_exception_handler(const struct bpf_insn *insn,
 
 	ex->insn = ins_offset;
 
+	if (BPF_CLASS(insn->code) != BPF_LDX)
+		dst_reg = DONT_CLEAR;
+
 	ex->fixup = FIELD_PREP(BPF_FIXUP_OFFSET_MASK, fixup_offset) |
 		    FIELD_PREP(BPF_FIXUP_REG_MASK, dst_reg);
 
@@ -829,12 +843,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 		      bool extra_pass)
 {
 	const u8 code = insn->code;
-	const u8 dst = bpf2a64[insn->dst_reg];
-	const u8 src = bpf2a64[insn->src_reg];
+	u8 dst = bpf2a64[insn->dst_reg];
+	u8 src = bpf2a64[insn->src_reg];
 	const u8 tmp = bpf2a64[TMP_REG_1];
 	const u8 tmp2 = bpf2a64[TMP_REG_2];
 	const u8 fp = bpf2a64[BPF_REG_FP];
 	const u8 fpb = bpf2a64[FP_BOTTOM];
+	const u8 pb = bpf2a64[PROBE_MEM32_BASE];
 	const s16 off = insn->off;
 	const s32 imm = insn->imm;
 	const int i = insn - ctx->prog->insnsi;
@@ -1237,7 +1252,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 	case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
-		if (ctx->fpb_offset > 0 && src == fp) {
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit(A64_ADD(1, tmp2, src, pb), ctx);
+			src = tmp2;
+		}
+		if (ctx->fpb_offset > 0 && src == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
 			src_adj = fpb;
 			off_adj = off + ctx->fpb_offset;
 		} else {
@@ -1322,7 +1345,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_ST | BPF_MEM | BPF_H:
 	case BPF_ST | BPF_MEM | BPF_B:
 	case BPF_ST | BPF_MEM | BPF_DW:
-		if (ctx->fpb_offset > 0 && dst == fp) {
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit(A64_ADD(1, tmp2, dst, pb), ctx);
+			dst = tmp2;
+		}
+		if (ctx->fpb_offset > 0 && dst == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
 			dst_adj = fpb;
 			off_adj = off + ctx->fpb_offset;
 		} else {
@@ -1365,6 +1396,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			}
 			break;
 		}
+
+		ret = add_exception_handler(insn, ctx, dst);
+		if (ret)
+			return ret;
 		break;
 
 	/* STX: *(size *)(dst + off) = src */
@@ -1372,7 +1407,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	case BPF_STX | BPF_MEM | BPF_H:
 	case BPF_STX | BPF_MEM | BPF_B:
 	case BPF_STX | BPF_MEM | BPF_DW:
-		if (ctx->fpb_offset > 0 && dst == fp) {
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+		if (BPF_MODE(insn->code) == BPF_PROBE_MEM32) {
+			emit(A64_ADD(1, tmp2, dst, pb), ctx);
+			dst = tmp2;
+		}
+		if (ctx->fpb_offset > 0 && dst == fp && BPF_MODE(insn->code) != BPF_PROBE_MEM32) {
 			dst_adj = fpb;
 			off_adj = off + ctx->fpb_offset;
 		} else {
@@ -1413,6 +1456,10 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 			}
 			break;
 		}
+
+		ret = add_exception_handler(insn, ctx, dst);
+		if (ret)
+			return ret;
 		break;
 
 	case BPF_STX | BPF_ATOMIC | BPF_W:
@@ -1594,6 +1641,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bool tmp_blinded = false;
 	bool extra_pass = false;
 	struct jit_ctx ctx;
+	u64 arena_vm_start;
 	u8 *image_ptr;
 	u8 *ro_image_ptr;
 
@@ -1611,6 +1659,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		prog = tmp;
 	}
 
+	arena_vm_start = bpf_arena_get_kern_vm_start(prog->aux->arena);
 	jit_data = prog->aux->jit_data;
 	if (!jit_data) {
 		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
@@ -1648,7 +1697,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	 * BPF line info needs ctx->offset[i] to be the offset of
 	 * instruction[i] in jited image, so build prologue first.
 	 */
-	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb)) {
+	if (build_prologue(&ctx, was_classic, prog->aux->exception_cb,
+			   arena_vm_start)) {
 		prog = orig_prog;
 		goto out_off;
 	}
@@ -1696,7 +1746,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	ctx.idx = 0;
 	ctx.exentry_idx = 0;
 
-	build_prologue(&ctx, was_classic, prog->aux->exception_cb);
+	build_prologue(&ctx, was_classic, prog->aux->exception_cb, arena_vm_start);
 
 	if (build_body(&ctx, extra_pass)) {
 		prog = orig_prog;
-- 
2.40.1


