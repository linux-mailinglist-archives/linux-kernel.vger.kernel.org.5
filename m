Return-Path: <linux-kernel+bounces-112292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206F887801
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 11:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D15BB215E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428BE1A58B;
	Sat, 23 Mar 2024 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erGycpAw"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D51863B;
	Sat, 23 Mar 2024 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189878; cv=none; b=sGajt2wi/G6ulxxUmghpoH0355VSWOZTYwy/itwWSU1Cqfs7caEkUexJVZRjbLeTkf7GkcVYGNHJkRyU9IiKC5bhYU+rtbFetoUjPaZ6NVIBitY0THWDJ0IyVY+4IPm/WXFjT7FE4ZqPxkMR7yA2i7wOfqLI2EBYvqSb+HmnKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189878; c=relaxed/simple;
	bh=tlcWxKjsJ0cnmuS1p0+clZlWoKFvwLy9gw50l6PRT1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WJrl8WJYLxf4Ch/H+4buXdsVe2jKGnC43a3WCXTswBgutoxul1/NP45yKgwu570RJCu0+31O6pXVw4U/i4vUpxUt+gFuJBTTsXn9Mc4WTBNBPTIEbhH//nIZTxY8CDwniOiIlgugSH2jpzhSDunuq47Rpi3t9TEOycIlgsDxPHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erGycpAw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ec8f13c62so2225615f8f.0;
        Sat, 23 Mar 2024 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711189875; x=1711794675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30FW01JOLwSXfoC6Ogm8zvLxafKlOBlS0uMxuEtgM1k=;
        b=erGycpAw1XF2T5P70Lot7cn3E9YyiaAWuM/t5v5AFD/PiT6l5omwxx0WYp1IqiZfuZ
         dsaxe1QJBd6bAwQT8WMu+O0vmCCB1U8gmjcftanYYjLK2isCrBlM7v8xSgtGMv7ETnML
         01saZ+pWrWyMXqdoSN7xdrkwhS7VAiIa0QzUsTEcgXFUh8XL0p4vW165k+qpNxCs08d4
         jPxC29Y0oNkpLQKflxPPGN4xcZGuRky1I8ymQhhXGzFlp6AJT1AZkyfiixD/RyDlQaof
         YiDr47u14sdwzQoi/usPWLecaHx5whUq8ipgq7R/JaCfyKP6zjgryRgCArTG4ReTvyyM
         BuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711189875; x=1711794675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30FW01JOLwSXfoC6Ogm8zvLxafKlOBlS0uMxuEtgM1k=;
        b=IMe21N7uFi5ytc/oZNaJkxSLz1swI2rJlbGLwqlPej75EHSzdYNzzYAn7xAgRwYAvr
         C7WSYdvVOIpp5q1GJNrCoB96r9yUsvpNvbJjgzMjIoGm1m5u6mPE7u3Yc0mMdbunZ8pg
         A15x/N0P9MsU7ftomg80n1ce55xkpnafg9dTR0BNB0CqTT6dzNLYSBbZrlMO4GF5buUJ
         89RQh6uFUXxWrsb6l8nkVcY8veZxbaxmnDaTRilDbZGGXIxNuPA+BuhbFRuuF/5MkrHD
         4DXaJ3TdvEIHj69SfmPigrnGpbB/zsfej0WzcACXWVK7yJI64fi5u5dS4oyeYU8D1LJd
         /T8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIGW2RAzr1brSXk68L+iAhUkvPqgv5GU5UVrLNMdxgjM82LC7WAVPCC+iL7WNFpf4Q1qc6b161maf21narjo3ID+PBwS4Jmoii+6wFUK9SVmYhqqCipOSd+LIVuaaq7IR1
X-Gm-Message-State: AOJu0YwxFgbZ73i7Q95YIHXDdE5E/h9N0cHTptA6/JHrgFvSt0KaSE3t
	h6juBlRFRhbiUCev7MMNpNVNH5JZCsggXPpQL5ByXhTq9FdD6jgtDnwgdf9KY1FxvQ==
X-Google-Smtp-Source: AGHT+IF30mXI0vvHYyEoCrFeS0FZ6WY28MlvzdInjHZPtoeCZz6TwUNftQj006Swmd1fVMWMkd6R9g==
X-Received: by 2002:a5d:6483:0:b0:341:c0ba:2733 with SMTP id o3-20020a5d6483000000b00341c0ba2733mr1289022wri.27.1711189874949;
        Sat, 23 Mar 2024 03:31:14 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id bq3-20020a5d5a03000000b0033e9f6997c7sm3702490wrb.66.2024.03.23.03.31.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Mar 2024 03:31:14 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 2/2] bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
Date: Sat, 23 Mar 2024 10:30:57 +0000
Message-Id: <20240323103057.26499-3-puranjay12@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240323103057.26499-1-puranjay12@gmail.com>
References: <20240323103057.26499-1-puranjay12@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=1 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY

rY = addr_space_cast(rX, 1, 0) has to be converted by JIT:

Here I explain using symbolic language what the JIT is supposed to do:
We have:
	src = [src_upper32][src_lower32] // 64 bit src kernel pointer
	uvm = [uvm_upper32][uvm_lower32] // 64 bit user_vm_start

The JIT has to make the dst reg like following
	dst = [uvm_upper32][src_lower32] // if src_lower32 != 0
	dst = [00000000000][00000000000] // if src_lower32 == 0

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c                | 17 +++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 --
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b9b5febe64f0..cd418c07f806 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -82,6 +82,7 @@ struct jit_ctx {
 	__le32 *ro_image;
 	u32 stack_size;
 	int fpb_offset;
+	u64 user_vm_start;
 };
 
 struct bpf_plt {
@@ -868,6 +869,16 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn->off == BPF_ADDR_SPACE_CAST && insn->imm == 1U << 16 &&
+		    BPF_CLASS(code) == BPF_ALU64) {
+			emit(A64_MOV(0, tmp, src), ctx); // 32-bit mov clears the upper 32 bits
+			emit_a64_mov_i(0, dst, ctx->user_vm_start >> 32, ctx);
+			emit(A64_LSL(1, dst, dst, 32), ctx);
+			emit(A64_CBZ(1, tmp, 2), ctx);
+			emit(A64_ORR(1, tmp, dst, tmp), ctx);
+			emit(A64_MOV(1, dst, tmp), ctx);
+			break;
+		}
 		switch (insn->off) {
 		case 0:
 			emit(A64_MOV(is64, dst, src), ctx);
@@ -1690,6 +1701,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.fpb_offset = find_fpb_offset(prog);
+	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 
 	/*
 	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
@@ -2511,6 +2523,11 @@ bool bpf_jit_supports_exceptions(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
index d8ade15e2789..0445ac38bc07 100644
--- a/tools/testing/selftests/bpf/DENYLIST.aarch64
+++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
@@ -10,5 +10,3 @@ fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_mu
 fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95
 missed/kprobe_recursion                          # missed_kprobe_recursion__attach unexpected error: -95 (errno 95)
-verifier_arena                                   # JIT does not support arena
-arena_htab                                       # JIT does not support arena
-- 
2.40.1


