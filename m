Return-Path: <linux-kernel+bounces-115883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D68889877
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2010429760C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29518227518;
	Mon, 25 Mar 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxgAd/jZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA2914601C;
	Sun, 24 Mar 2024 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322078; cv=none; b=I24neWEx1PB7cpC5kX7XG2sAe1sOO7ABwJ3nXU8zCySYy+1upQi/6E8VOYEL/4u/NlkA6t4fGGsS/BHVsUkZqqk5bnwfTRHcDQDoBnNuoj1bDWR7XB9AB73LfjxUmKUMwmcd1ezGTobgnP/xevX2zpZg4x56jfV+MHRCL1h2B7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322078; c=relaxed/simple;
	bh=uHy+ZQRtaiUU/OqpA7P1f9fxwPU31Q0gaycK+CSU++4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqUR3BYKd/lrTDd3PXoc17DYkMe2YbZ1gaN5aVbyruiZe5qWmvx/IK/JDrJQGQRz6fAwS9Mqe1tZSW4t0N7boIJY7nEgg3di49nBjmzloAfFFZmsQQ1ajFAbDzLnZCVYeu9YLQbM1ZAj2ZTOLyKVHIydSXHGfEo7OajeQzfs5VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxgAd/jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA96C43390;
	Sun, 24 Mar 2024 23:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322077;
	bh=uHy+ZQRtaiUU/OqpA7P1f9fxwPU31Q0gaycK+CSU++4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxgAd/jZZlHd6+RAiLi4RVJ1uTB1F/gT7a3+oCLsasLhxsl0OlqzkpCYxf+skHefn
	 HVFXz/cDKkzBLI8i7axT51BJww/94velkJC4TfFPbKw7+wl/ncH8Cj/eNZhKmaqKwR
	 wZV3+zjdaMcmA/ps2LuXT7kU2XRM41KqrCJvOEZR/fX20fPrgjPkEN3JKuFRxHJsVA
	 ZeOkXuxyxTPE/QbqdFQZAoR9xlpaiyn/9obNM1Ni9uavndyTZOFiQ9GfOZS4ima22A
	 TQmv5nfOjID3IFR11uTcMwfHpmV5bbh1vVhPn/V80+wb00lvgvAAwMe49Xr+Rs2cdj
	 QzIpXZheyW4Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 150/451] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
Date: Sun, 24 Mar 2024 19:07:06 -0400
Message-ID: <20240324231207.1351418-151-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 879bbe7aa4afa80acf72a1cad7f52416ea78c52d ]

For program types that don't have named context type name (e.g., BPF
iterator programs or tracepoint programs), ctx_tname will be a non-NULL
empty string. For such programs it shouldn't be possible to have
PTR_TO_CTX argument for global subprogs based on type name alone.
arg:ctx tag is the only way to have PTR_TO_CTX passed into global
subprog for such program types.

Fix this loophole, which currently would assume PTR_TO_CTX whenever
user uses a pointer to anonymous struct as an argument to their global
subprogs. This happens in practice with the following (quite common, in
practice) approach:

typedef struct { /* anonymous */
    int x;
} my_type_t;

int my_subprog(my_type_t *arg) { ... }

User's intent is to have PTR_TO_MEM argument for `arg`, but verifier
will complain about expecting PTR_TO_CTX.

This fix also closes unintended s390x-specific KPROBE handling of
PTR_TO_CTX case. Selftest change is necessary to accommodate this.

Fixes: 91cc1a99740e ("bpf: Annotate context types")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240212233221.2575350-4-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c                              |  3 +++
 .../bpf/progs/test_global_func_ctx_args.c     | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7582ec4fd4131..73c36ff758b5e 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5135,6 +5135,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
 		bpf_log(log, "Please fix kernel include/linux/bpf_types.h\n");
 		return NULL;
 	}
+	/* program types without named context types work only with arg:ctx tag */
+	if (ctx_tname[0] == '\0')
+		return false;
 	/* only compare that prog's ctx type name is the same as
 	 * kernel expects. No need to compare field by field.
 	 * It's ok for bpf prog to do:
diff --git a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
index 7faa8eef0598b..144d30e654ad2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func_ctx_args.c
@@ -26,6 +26,23 @@ int kprobe_typedef_ctx(void *ctx)
 	return kprobe_typedef_ctx_subprog(ctx);
 }
 
+/* s390x defines:
+ *
+ * typedef user_pt_regs bpf_user_pt_regs_t;
+ * typedef struct { ... } user_pt_regs;
+ *
+ * And so "canonical" underlying struct type is anonymous.
+ * So on s390x only valid ways to have PTR_TO_CTX argument in global subprogs
+ * are:
+ *   - bpf_user_pt_regs_t *ctx (typedef);
+ *   - struct bpf_user_pt_regs_t *ctx (backwards compatible struct hack);
+ *   - void *ctx __arg_ctx (arg:ctx tag)
+ *
+ * Other architectures also allow using underlying struct types (e.g.,
+ * `struct pt_regs *ctx` for x86-64)
+ */
+#ifndef bpf_target_s390
+
 #define pt_regs_struct_t typeof(*(__PT_REGS_CAST((struct pt_regs *)NULL)))
 
 __weak int kprobe_struct_ctx_subprog(pt_regs_struct_t *ctx)
@@ -40,6 +57,8 @@ int kprobe_resolved_ctx(void *ctx)
 	return kprobe_struct_ctx_subprog(ctx);
 }
 
+#endif
+
 /* this is current hack to make this work on old kernels */
 struct bpf_user_pt_regs_t {};
 
-- 
2.43.0


