Return-Path: <linux-kernel+bounces-113083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10F888154
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8971C21657
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BA214E2FE;
	Sun, 24 Mar 2024 22:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV0gYiMV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC214E2E5;
	Sun, 24 Mar 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319891; cv=none; b=Snbmbvtv1IcQC3vX6wvjUUe2XRinJMNnOdo5tJfib8IR6ra0BqEY4xMgsuv7v1jDO6gWIIVPItRzp3eC0tN+Vce/bPuvrenUQ/s5A/QGMts74qmNhtttDcaYukv5NBXAN6f1bAub+f/y9LuyxyqLXDEAoHpHtMSzDuSGP4XSJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319891; c=relaxed/simple;
	bh=nTdHPVEhp+m6EDgmRo0XGumx0slog8xFkDKuDFI+Krk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvTvG5HG31nriMoDoU88cbOucuilV/1iju9NQSioOjCNvC3X4kY4HYBk3hPabXgfiXSMloHvM+Ua9cZixdpb7RTmtP9w1DGVmrj9A3g4Jekxb5QDUiGGK5Z4UKelM1FBNYl631iYB8nzjqc8HOsIkr+QIPP1o+gTFpqaRpat/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV0gYiMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CECC43390;
	Sun, 24 Mar 2024 22:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319891;
	bh=nTdHPVEhp+m6EDgmRo0XGumx0slog8xFkDKuDFI+Krk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fV0gYiMVuDPpMUbBC5+ASAq3lH4Qv7Bng/CQTNTZNR1ekI9uPAmmrcpRoimSUnyFL
	 Q6a/3tQDx95M7UgjfH9oojR+S8qUcbJOm22jPCyLYU0u3dAXgEBaSJXmP00u7c5PmU
	 uvBxLyG96esaemRmAq9BLiXjkD/+myVoWmL8jbXflm3SC5YJEW8kKT4q0NMA1fHLzh
	 tmXaHfkUioD1Dyz4Zs3TApibaiq1q4Ece91jEh3t0JbgW0kjIOzXIQ+twZOjIo2OMd
	 5Msh4G6m0TtFB3mQdag52tOUcnvbMBiSERVo+DOe1yYEhE/RhfeEuLayMDFqqdZoKo
	 pf9DdPKWXJDbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 196/715] bpf: don't infer PTR_TO_CTX for programs with unnamed context type
Date: Sun, 24 Mar 2024 18:26:15 -0400
Message-ID: <20240324223455.1342824-197-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 92aa3cf0396b8..9041848cf1a1b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5685,6 +5685,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
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
index 9a06e5eb1fbef..143c8a4852bfe 100644
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


