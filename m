Return-Path: <linux-kernel+bounces-117329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD21088AA10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEECF1C31CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302DE14601D;
	Mon, 25 Mar 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqLrrYf8"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB061448DC;
	Mon, 25 Mar 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379275; cv=none; b=Zkj5mh23zsUQkAK3Su0PiMUzUKV976CwdidtbAq/Gbn3vlTn9Tl1HNnuV4SlV/oapsQR9vIXWnSb26nbfog/GvibZukq6RAaZtvhpUK6wi6bVdafG8/125SqsrIdTPChhO9kepK/U5/4EsLeerMCPjg7mH82yw51kLODMjbDShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379275; c=relaxed/simple;
	bh=WPZJxY64JttEsmo9dhnvvcg4+XVoCTGJflosyMC/1s0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sPumAyzsX15wwZTslEv5uoRMP10UZG2RisYhM7mnfDTW2SRa5Fpq22aO8+Y4UjIjFlNZaNvc034ijqP6fZIuR8D3Lz3w2A7lod84X9iIh0nI9etLuStrLcRQ+iIbzxV1aq0VJGwFLOcqo5c1Qs9ZbSHMokK9ouJDpmk8Fj7FOpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqLrrYf8; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33ececeb19eso2923156f8f.3;
        Mon, 25 Mar 2024 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711379272; x=1711984072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoq50HiMB9NXZrdEZyv6uWqBCBaEdhgRrvWxBqHbu6s=;
        b=VqLrrYf8pjSbxGPUa0OM0KkBfgPM0E0DG3+sOieErQlG6vWp0z1Y91nw6yXng6LPUp
         kwD1q817x6x5hsBy4jkGgckzeWmZkBMda31IID+SDc3EUFQGsaCQJathhkjqXrYcga6Z
         iQCPOdt/Gc2WRstKhuWsCuzgV1VZx7OGYPmSN/zKTbS2di2S1vqjE/YIJ57xDaRs9zU6
         Su+r/F8+CYeDqRl3NEFdUO2+Im99l0qv5bBRNVKzdqorm/6L2FcSPB83TaoWHGyxoEFi
         zSZ25HkcWeHgvv1mS4yv+bJpDaneDrs7RVBveE99PRDfKwzmfVj08UEzpiTB0m7k0eCh
         jmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379272; x=1711984072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoq50HiMB9NXZrdEZyv6uWqBCBaEdhgRrvWxBqHbu6s=;
        b=Pp7lKSWprM/1gpBxpLGDGT1Oudbj1IZ5aFscDYIGMkWk5XCsQYneNx8rRVfodbp1Uh
         ZCE4aLrgMOxyiuiSCtrsA7NnRVF6ll7uYxS6ILZCOwRd9gF8c7TzcL5jxhh1DNvoT69X
         30q4BjCVdb3pEzOoD8XFG2YGEMDtRLq2gFQw/5Ip1Uecxw8M7lAXVvaq07Rr+vSCO0/W
         h/+Wus8qoQtg3vOmBOfnvLGloO/n+MUnaWvmWHueitn1tWSdU57vOTT1Lq4V9ke7oYcD
         XDVZaVvCuufVYaEy8ciUywqh6tqx+NrDpCGQAN+4vLwdP+5yiYQelYgov83ByFlFfxZp
         8Tgw==
X-Forwarded-Encrypted: i=1; AJvYcCVa5oW+LQbMWzl3BhubBEmYlo9gX+Cfpi1VWwwJWR3GTB+9bUnowAIha8p0Qu/+AMWnmVGbM9XQ9DUyxRIfqmZWntiidOz1zpTSWCqDWhTeMyFZuyGHd3qYA1jGvON7Aa/1
X-Gm-Message-State: AOJu0YxZ6V3YollAEaSriZf4YaN7k16FKKBix3rQYqPCm2YMBpTLL065
	2HVE0CGqD8TBjS+X6x8LoU8lSJvgL10Dn9Krj4Z4DbSvCKsK1Rjo
X-Google-Smtp-Source: AGHT+IG1cMwiUEuNrHBMmu6sqUJLhG/rlDeqg1mVtGwOfLgoffq+lA+qEDtufFTRBH9I+6gcWzbsUg==
X-Received: by 2002:a5d:4612:0:b0:33e:7f51:c2f7 with SMTP id t18-20020a5d4612000000b0033e7f51c2f7mr4458901wrq.52.1711379271822;
        Mon, 25 Mar 2024 08:07:51 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id ck8-20020a5d5e88000000b00341ba91c1f5sm8505949wrb.102.2024.03.25.08.07.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2024 08:07:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/2] bpf: Add arm64 JIT support for bpf_addr_space_cast instruction.
Date: Mon, 25 Mar 2024 15:07:16 +0000
Message-Id: <20240325150716.4387-3-puranjay12@gmail.com>
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

LLVM generates bpf_addr_space_cast instruction while translating
pointers between native (zero) address space and
__attribute__((address_space(N))). The addr_space=0 is reserved as
bpf_arena address space.

rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
converted to normal 32-bit move: wX = wY.

rY = addr_space_cast(rX, 1, 0) : used to convert a bpf arena pointer to
a pointer in the userspace vma. This has to be converted by the JIT.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c                | 16 ++++++++++++++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 |  2 --
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ba6dabf62712..8967388446d5 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -82,6 +82,7 @@ struct jit_ctx {
 	__le32 *ro_image;
 	u32 stack_size;
 	int fpb_offset;
+	u64 user_vm_start;
 };
 
 struct bpf_plt {
@@ -868,6 +869,15 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
 	/* dst = src */
 	case BPF_ALU | BPF_MOV | BPF_X:
 	case BPF_ALU64 | BPF_MOV | BPF_X:
+		if (insn_is_cast_user(insn)) {
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
@@ -1690,6 +1700,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	ctx.fpb_offset = find_fpb_offset(prog);
+	ctx.user_vm_start = bpf_arena_get_user_vm_start(prog->aux->arena);
 
 	/*
 	 * 1. Initial fake pass to compute ctx->idx and ctx->offset.
@@ -2511,6 +2522,11 @@ bool bpf_jit_supports_exceptions(void)
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


