Return-Path: <linux-kernel+bounces-115638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E62A889459
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B09A1C2F218
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004D136999;
	Mon, 25 Mar 2024 02:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LjcP1BYa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D12057F2;
	Sun, 24 Mar 2024 23:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321492; cv=none; b=rho28Lte3SlQewigBzqoYY2ILFK4pI2NLbY9YQtLyFKZlZCsOZPaz01fkx/VZE2k/O9RUz5J2Wv/q21WHC34QzWd6cyLQZCHJb4q2Xto/HDb1dDRPPNb4CiL41B6MXinDUqxl8dF5GzhDDWjeyK1tinhw3VOVIHbUaROBc+ksxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321492; c=relaxed/simple;
	bh=GuTjzVxswbVIyU4Pi1b/se2mxXzB3D3HzgGznfAvHCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+Dobbjf5VCWGeSH7pQBXig85B8A4IdzAMLbr0rOMYGvtiuCVSYYntsRjFEjBZSS9vrvJNJTVyoYzc5D/HA9PbyjviMSgUcxzM+hu3gNn5ITZUNc4bISqx6WzqCgA3iIP3PiXu4OKWUHL1+352TacXZKvAZGTd7DOtOc4ckyozE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LjcP1BYa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AE7C43399;
	Sun, 24 Mar 2024 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321492;
	bh=GuTjzVxswbVIyU4Pi1b/se2mxXzB3D3HzgGznfAvHCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LjcP1BYaLReZIDjnHhJbhqV735xgLRayrI6ylHUOwSvDJNk3q2YoBLnkocE6ZjHLx
	 O4lP0akVNwot3BBK7bpOp3yvdgfeOaxaS9h0U9xzeth/OyyPgY65ZVIVi9c1i53EDF
	 dQoMatdycsmLSnmOHkJ4j2cV9tZeA1was+OoGMypqSnnV29LumG21DE3giXXedDyD0
	 qbvhftH0XMrkCWwOlJTDIye+IJNB7gbO/g0Jja7eS5ymqSD4ZO0l0f3B7NfZtPFVVT
	 oMyPpyM9AmdtwWOJXmFaULMz4L3igDGSBlZavn/YSO7d0/6TLaQ2O8yFZ445sJLNBG
	 8o1+IcCkNQ02w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 217/638] bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
Date: Sun, 24 Mar 2024 18:54:14 -0400
Message-ID: <20240324230116.1348576-218-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yonghong Song <yonghong.song@linux.dev>

[ Upstream commit 178c54666f9c4d2f49f2ea661d0c11b52f0ed190 ]

Currently tracing is supposed not to allow for bpf_spin_{lock,unlock}()
helper calls. This is to prevent deadlock for the following cases:
  - there is a prog (prog-A) calling bpf_spin_{lock,unlock}().
  - there is a tracing program (prog-B), e.g., fentry, attached
    to bpf_spin_lock() and/or bpf_spin_unlock().
  - prog-B calls bpf_spin_{lock,unlock}().
For such a case, when prog-A calls bpf_spin_{lock,unlock}(),
a deadlock will happen.

The related source codes are below in kernel/bpf/helpers.c:
  notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
  notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
notrace is supposed to prevent fentry prog from attaching to
bpf_spin_{lock,unlock}().

But actually this is not the case and fentry prog can successfully
attached to bpf_spin_lock(). Siddharth Chintamaneni reported
the issue in [1]. The following is the macro definition for
above BPF_CALL_1:
  #define BPF_CALL_x(x, name, ...)                                               \
        static __always_inline                                                 \
        u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
        typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
        u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));         \
        u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))          \
        {                                                                      \
                return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
        }                                                                      \
        static __always_inline                                                 \
        u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))

  #define BPF_CALL_1(name, ...)   BPF_CALL_x(1, name, __VA_ARGS__)

The notrace attribute is actually applied to the static always_inline function
____bpf_spin_{lock,unlock}(). The actual callback function
bpf_spin_{lock,unlock}() is not marked with notrace, hence
allowing fentry prog to attach to two helpers, and this
may cause the above mentioned deadlock. Siddharth Chintamaneni
actually has a reproducer in [2].

To fix the issue, a new macro NOTRACE_BPF_CALL_1 is introduced which
will add notrace attribute to the original function instead of
the hidden always_inline function and this fixed the problem.

  [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KHWtpvoXxf1OAQ@mail.gmail.com/
  [2] https://lore.kernel.org/bpf/CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2srJnef0ZrQkZew@mail.gmail.com/

Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20240207070102.335167-1-yonghong.song@linux.dev
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/filter.h | 21 ++++++++++++---------
 kernel/bpf/helpers.c   |  4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 77db4263d68d7..5090e940ba3e4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -505,24 +505,27 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       \
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
 
-#define BPF_CALL_x(x, name, ...)					       \
+#define BPF_CALL_x(x, attr, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   \
 	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__)); \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     \
 	{								       \
 		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_ARGS__));\
 	}								       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
 
-#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, name, __VA_ARGS__)
-#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, name, __VA_ARGS__)
-#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, name, __VA_ARGS__)
-#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, name, __VA_ARGS__)
-#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, name, __VA_ARGS__)
-#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, name, __VA_ARGS__)
+#define __NOATTR
+#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, name, __VA_ARGS__)
+
+#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, notrace, name, __VA_ARGS__)
 
 #define bpf_ctx_range(TYPE, MEMBER)						\
 	offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index a5ce840f4fbef..31da67703307b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -333,7 +333,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 	__this_cpu_write(irqsave_flags, flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_lock_irqsave(lock);
 	return 0;
@@ -356,7 +356,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 	local_irq_restore(flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
-- 
2.43.0


