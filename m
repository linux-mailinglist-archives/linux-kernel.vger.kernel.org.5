Return-Path: <linux-kernel+bounces-113081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23532888151
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6222850A3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998B614E2E6;
	Sun, 24 Mar 2024 22:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUpmGfhF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF554548E2;
	Sun, 24 Mar 2024 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319890; cv=none; b=sUvE6/n5pxX30pt4Wn83CVANDzh5K/mcJkpzEV0skVbCW90q0NiCYWZt5AZ3DuJbruoqT8J5D6DAZxdSOo2tsckCI2yjeDWS4Sg3+2d9hD2N96a+YzhpGLLClnEMpQb0yEa0IOQKzwjPxoF+lnrOEjIUmCJ0lyw9dV150bv2+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319890; c=relaxed/simple;
	bh=ZnrPdgvk06axdQ2YBtY3yByvM2uHKf4dwGAffJixHV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHdlbV7i1VGJxVJHIh9178T+gjdDPcMCvx88u4tXuiXulPvXPPBT0qG9oO0HSFoqW+S4v7N1h8pAuGIsSHKlrRYClh1us1RXimxldWSohXwVzyP0qQ7QlsU5PtFb2RlJ775ELOtac0DWlQyOQonhUrYL5uMwqMjAlfi2fYe9Olc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUpmGfhF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6881C433C7;
	Sun, 24 Mar 2024 22:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319890;
	bh=ZnrPdgvk06axdQ2YBtY3yByvM2uHKf4dwGAffJixHV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUpmGfhF2yAQitpTRRopdZxZhHys5k8giWvVdnB6JeOYWwRNjrCH3omkjiaKEHibx
	 bXhDEWGNhIi3qKBo6jZy6za9x+KwpEnSN8IssVX4wdta3XRnD3wnvmbp6ue9Yb3GY1
	 7tZw6L13shMbBwaRaVS2mri9oL7vpOHsq7jwM1JF1kLc40K7PdLiNNFquT+lG8AoI0
	 d7oY/noKDijCnTBUzEHw7tTrh2xYYMeZnwr406YDi7QKSHXSr2+ZOJ92dtNO5CkMuW
	 dCVyYYmVl+DYAeU64tXegZ/YlS0znTTisNvuZVX5M2YDaedHvcns0x+eG7bA6ohnv9
	 aNM8qs6RPqWWQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 195/715] bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
Date: Sun, 24 Mar 2024 18:26:14 -0400
Message-ID: <20240324223455.1342824-196-sashal@kernel.org>
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
index 68fb6c8142fec..f537a394c42d0 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -547,24 +547,27 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
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
index d19cd863d294e..b10092754dde3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -334,7 +334,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf_spin_lock *lock)
 	__this_cpu_write(irqsave_flags, flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_lock_irqsave(lock);
 	return 0;
@@ -357,7 +357,7 @@ static inline void __bpf_spin_unlock_irqrestore(struct bpf_spin_lock *lock)
 	local_irq_restore(flags);
 }
 
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
-- 
2.43.0


