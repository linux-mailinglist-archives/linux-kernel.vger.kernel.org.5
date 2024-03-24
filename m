Return-Path: <linux-kernel+bounces-112990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14849888050
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FEA281544
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5418A12DDB8;
	Sun, 24 Mar 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtARC0bx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABC412DD99;
	Sun, 24 Mar 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319802; cv=none; b=kw2ro03KP8grL3cx+jaMkvd9SoOXwdhclEUshkJK03dFuty/1lTzb9dC6rXDSa6xOy6AJ9F42wqJxP1RWnmfB49bHGc5ln2RLcK16A808AbvH6saXGi0/KJIvmM0mh16fLW7T2mr+WGHLMDk6bPSutKw+MsOh4nFRC2MZkHICdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319802; c=relaxed/simple;
	bh=Pt8lfoqc4pHW8JA5jUyEQqyGcf753/ema3dIBVHANG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzsgWe5O6SbV2nQN6KqfC5RCSxb0oVFSf3UlBy1hVxNNmaf+kPuZOlRcyNzbF0YCw1IaPxQyRp7t13beI6VfgHVhpW4OuVw8gu6g0SWhGcaqcC6roH3+JI92Itm77BNaztCM9BXx5ZTDQ6PYrHL6Qk6oisXSExULi30Tjrqj5w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtARC0bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88DFC433C7;
	Sun, 24 Mar 2024 22:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319802;
	bh=Pt8lfoqc4pHW8JA5jUyEQqyGcf753/ema3dIBVHANG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QtARC0bxHUGNRWASKUlk5lgv1zoETnWQgC6rQ16mHBpONnoSgN2bbJtqkPrcyT52r
	 zvI7UFbO8p8qnmib9sHBvVNSO8cJ7E1WxFuirQTiBfSXpN8sshox/qTji5aJqRchm5
	 Hu5g9r7gnvrDJE0BbYucHeXwQMf1oSiWV6jR726nWgy+M4eNU433oOgPd74QbvRHaL
	 mqWApKpd9pPSbpVnvth/yfvxzEbThqPdMmwr2LDEvrwh0ET8QZVmQHWuL7af7MM+G5
	 rWq3n4TVh6QD/luhzPGnsZKNG0zsgGaPPKVLgMiV/GjZ9nx6Uw/ulzE2YuVKUoRUfw
	 zj3+HtNOWjKAA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 103/715] libbpf: fix __arg_ctx type enforcement for perf_event programs
Date: Sun, 24 Mar 2024 18:24:42 -0400
Message-ID: <20240324223455.1342824-104-sashal@kernel.org>
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

[ Upstream commit 9eea8fafe33eb70868f6ace2fc1e17c4ff5539c3 ]

Adjust PERF_EVENT type enforcement around __arg_ctx to match exactly
what kernel is doing.

Fixes: 76ec90a996e3 ("libbpf: warn on unexpected __arg_ctx type when rewriting BTF")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20240125205510.3642094-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b8b00da629071..910f72c9e6a49 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -33,6 +33,7 @@
 #include <linux/filter.h>
 #include <linux/limits.h>
 #include <linux/perf_event.h>
+#include <linux/bpf_perf_event.h>
 #include <linux/ring_buffer.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
@@ -6699,6 +6700,14 @@ static struct {
 	/* all other program types don't have "named" context structs */
 };
 
+/* forward declarations for arch-specific underlying types of bpf_user_pt_regs_t typedef,
+ * for below __builtin_types_compatible_p() checks;
+ * with this approach we don't need any extra arch-specific #ifdef guards
+ */
+struct pt_regs;
+struct user_pt_regs;
+struct user_regs_struct;
+
 static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_program *prog,
 				     const char *subprog_name, int arg_idx,
 				     int arg_type_id, const char *ctx_name)
@@ -6739,11 +6748,21 @@ static bool need_func_arg_type_fixup(const struct btf *btf, const struct bpf_pro
 	/* special cases */
 	switch (prog->type) {
 	case BPF_PROG_TYPE_KPROBE:
-	case BPF_PROG_TYPE_PERF_EVENT:
 		/* `struct pt_regs *` is expected, but we need to fix up */
 		if (btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
 			return true;
 		break;
+	case BPF_PROG_TYPE_PERF_EVENT:
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct pt_regs) &&
+		    btf_is_struct(t) && strcmp(tname, "pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_pt_regs) &&
+		    btf_is_struct(t) && strcmp(tname, "user_pt_regs") == 0)
+			return 0;
+		if (__builtin_types_compatible_p(bpf_user_pt_regs_t, struct user_regs_struct) &&
+		    btf_is_struct(t) && strcmp(tname, "user_regs_struct") == 0)
+			return 0;
+		break;
 	case BPF_PROG_TYPE_RAW_TRACEPOINT:
 	case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
 		/* allow u64* as ctx */
-- 
2.43.0


