Return-Path: <linux-kernel+bounces-117328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3C88AA0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E95E1F69513
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBE31448E6;
	Mon, 25 Mar 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEOYKTeu"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F014038F;
	Mon, 25 Mar 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379272; cv=none; b=VDJmz2fxFxvkoIjSRemQTrjDNMoHl6nbMGqSbwzLpCr5kBOFdqSGU5kT+GsGU6bJtfoU9kmxVvVDUYFaLKglF4qfYIyfY9NvA4ytHhTdLaVEc9QNg42dZ8a2A5+PmfkTIaI0KMAyspq3m7kJIw235un+oftuky0gzvnSBj+bcwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379272; c=relaxed/simple;
	bh=Ie3x+KTwt6Z37a/FZRfrHMxdqE8La72ApBSChe6Ms/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kidp4u3T7w+SjMi2UnZygTqu7qwrEs4DaF+fokvpC7YNCU2kgs4mTJscuHbdrzZLQNjLno7fbnpyaIbsPu4mbQ1xXZ2A9romhuGQZ+UYYZPpBqn6nuBqrcyrxi3em3DpcM9dbAItluza72tyUjy/U5BSCfWrILlaWnwEhH9oKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEOYKTeu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33edbc5932bso3195848f8f.3;
        Mon, 25 Mar 2024 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711379269; x=1711984069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKgUcK9eePBaIaiWP/lw6TUy8p+3+oXMGlLSd0omYW8=;
        b=eEOYKTeupWuM6Kr/7Y++/2AjpqfdBuD0s4oFm8oQkSjYD41eI3W+ANxJ6ps4M/CFGZ
         vJpi8utMpJWOkquYcZdXCaxMeO4kiQK5AEZCd+zcnrwPt6zsIFDHkvcoH3cGhkrLuZMK
         kBp8gUnY1StgB97S1tu75FTiYngb55LN/azF8G3O/8muks3O3pUGTNUxITl5YLzmA+xc
         Cju191qTdw5EabbTa+S3Vp/JGgctFP1nd4hO8t2LbjLxm03q785hfn43SYib1G2Ez+FJ
         3BSMIFV6kaUt8nBFD3vckUZlgZ4r7jIu8bqRyIdeyeLxNpQhfAF3v1MRKuLbOPIvj2z6
         sA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379269; x=1711984069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKgUcK9eePBaIaiWP/lw6TUy8p+3+oXMGlLSd0omYW8=;
        b=XkXwRTwdAk3P7s4Zw0YqzKchiVRYH654gh8RRVLcwuvlI4Sgpwny6FXEOp/FFpMrGW
         hd36b/df+OW9dIXpyACpc9O9h3ypa+MU3srszfisdXYwctJaecLlaGPPU2eCbsJbCdes
         boNIPW+C7Ltv3k6CbO/co0kiwe9FuzGqwqlCVvIktJxZSX1ex3lN6Q/Fv8xjPKWy106o
         oWGrcRFmblJq41MKNx6BTLmD6e1s2W6BFOup9UHAXSfLzbytzjVFArp4TNgLhc1luekV
         /xZmH5TPnS4OsY82VRpruHvyeo/dPMDyjuxT+l/RK9WW023V1woDbvvUKkuMn05kNRJx
         nNyA==
X-Forwarded-Encrypted: i=1; AJvYcCWLwqqFVF+ZuBwIK/dsa+YeHpK781uhXIPfiXywE9pSs3sT6+BqPyUbkZPd2N79wie4lmGZ7A/QbQu5DCe8M1I3St2/T4LpPwA5cZD+BcZTpo7kG85G5bAtS0vx3aXgNOrY
X-Gm-Message-State: AOJu0Yx1bGKLYgn1Z/UjSua4CcrVTq0FtrDStSrarCqUm/juJa4JGg3j
	wRTOOvfI0k7NiG6gm/X8KZL7k4L5cpVi7u0EdwZueQ2yV14XYamY
X-Google-Smtp-Source: AGHT+IEbdJGrcF9QrJklYYQs4cF1cLHyJaYCy1mn5yU4gBKQvCJAW6nC43KZ7WPEadn+yW5OfLo3hA==
X-Received: by 2002:a5d:54cd:0:b0:341:80ee:22fe with SMTP id x13-20020a5d54cd000000b0034180ee22femr4952613wrv.50.1711379269001;
        Mon, 25 Mar 2024 08:07:49 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id c1-20020adffb01000000b00341d186a2dbsm1488100wrr.14.2024.03.25.08.07.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 08:07:48 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/2] bpf: Add arm64 JIT support for PROBE_MEM32 pseudo instructions.
Date: Mon, 25 Mar 2024 15:07:15 +0000
Message-Id: <20240325150716.4387-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240325150716.4387-1-puranjay12@gmail.com>
References: <20240325150716.4387-1-puranjay12@gmail.com>
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
index bc16eb694657..ba6dabf62712 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -29,6 +29,7 @@
 #define TCALL_CNT (MAX_BPF_JIT_REG + 2)
 #define TMP_REG_3 (MAX_BPF_JIT_REG + 3)
 #define FP_BOTTOM (MAX_BPF_JIT_REG + 4)
+#define ARENA_VM_START (MAX_BPF_JIT_REG + 5)
 
 #define check_imm(bits, imm) do {				\
 	if ((((imm) > 0) && ((imm) >> (bits))) ||		\
@@ -67,6 +68,8 @@ static const int bpf2a64[] = {
 	/* temporary register for blinding constants */
 	[BPF_REG_AX] = A64_R(9),
 	[FP_BOTTOM] = A64_R(27),
+	/* callee saved register for kern_vm_start address */
+	[ARENA_VM_START] = A64_R(28),
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
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
 	const int idx0 = ctx->idx;
 	int cur_offset;
 
@@ -411,6 +415,10 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 
 	/* Set up function call stack */
 	emit(A64_SUB_I(1, A64_SP, A64_SP, ctx->stack_size), ctx);
+
+	if (arena_vm_start)
+		emit_a64_mov_i64(arena_vm_base, arena_vm_start, ctx);
+
 	return 0;
 }
 
@@ -738,6 +746,7 @@ static void build_epilogue(struct jit_ctx *ctx, bool is_exception_cb)
 
 #define BPF_FIXUP_OFFSET_MASK	GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK	GENMASK(31, 27)
+#define DONT_CLEAR 5 /* Unused ARM64 register from BPF's POV */
 
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
+	const u8 arena_vm_base = bpf2a64[ARENA_VM_START];
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
+			emit(A64_ADD(1, tmp2, src, arena_vm_base), ctx);
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
+			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
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
+			emit(A64_ADD(1, tmp2, dst, arena_vm_base), ctx);
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


