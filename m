Return-Path: <linux-kernel+bounces-96534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725CF875DAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF76281D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B436125;
	Fri,  8 Mar 2024 05:38:26 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0452E84A;
	Fri,  8 Mar 2024 05:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876306; cv=none; b=ZLaCfdAo2FAu5k82lRdBk0WlwiXlXdizBMztDGjOfHe8yt4d0DfPUY6ezqWkkX6/S2uqWGkWhjyIIe/dHlurpoL1wK2LmRbfhi8yYD5+I/BGyjMwyTlDHZEfOn4sroLKbAvsJUws6CFJXrQx5s9+aOzbZSL4OtyKUBB2XL0inWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876306; c=relaxed/simple;
	bh=V1cL1/7e+ZqqsHNFqCEQO4q4BiPuZ0HpS/Plz61y9Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yb4mx4iTKX3Qhp7CE4rgzdbCFtV4Ke1bPp8CgsRRlR5ZVNgHDqhOKJQh9gL45DOOVdItUQHnlsHQIkKYtgsRg9jC565Zi/+qUQR9yYJfJbBtHjo2j9UtDmrUtofy7Sl+3eRPKCqFqqz0lgtEqIA6n4JtSM+aaX6AjvdmvGcF5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TrZhQ6xLsz9snT;
	Fri,  8 Mar 2024 06:38:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpRWOs160HmF; Fri,  8 Mar 2024 06:38:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TrZhQ5gqCz9sl0;
	Fri,  8 Mar 2024 06:38:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BB8898B775;
	Fri,  8 Mar 2024 06:38:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xGi3Awh1Plf7; Fri,  8 Mar 2024 06:38:14 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO23130.IDSI0.si.c-s.fr [192.168.232.110])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 291F78B763;
	Fri,  8 Mar 2024 06:38:14 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Alexei Starovoitov <ast@kernel.org>,
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
	Jiri Olsa <jolsa@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH bpf-next v3 1/2] bpf: Take return from set_memory_ro() into account with bpf_prog_lock_ro()
Date: Fri,  8 Mar 2024 06:38:07 +0100
Message-ID: <286def78955e04382b227cb3e4b6ba272a7442e3.1709850515.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709876288; l=3060; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=V1cL1/7e+ZqqsHNFqCEQO4q4BiPuZ0HpS/Plz61y9Ik=; b=/YEOM3OHP8KDJyOO3ehJ1RVP4GzRAcAID6cCJZ/d0dp047mlx2Jh+9clH0DgIt4qgXGkgno5Y LywIbfa5G6aCqIarVYXz5gOrWTacPl27NnwyvDHDUe/9WDzqxsL3gUf
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_ro() can fail, leaving memory unprotected.

Check its return and take it into account as an error.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
Note: next patch is autonomous, it is sent as a follow-up of this one to minimize risk of conflict on filter.h because the two changes are too close to each other.

v3: Perform bpf_prog_kallsyms_add() after protection of all subprog have succeeded.

v2: No modification (Just added link in patch message), patchwork discarded this series due to failed test of s390 but it seems unrelated, see https://lore.kernel.org/bpf/wvd5gzde5ejc2rzsbrtwqyof56uw5ea3rxntfrxtkdabzcuwt6@w7iczzhmay2i/T/#m2e61446f42d5dc3d78f2e0e8b7a783f15cfb109d
---
 include/linux/filter.h | 5 +++--
 kernel/bpf/core.c      | 4 +++-
 kernel/bpf/verifier.c  | 8 ++++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 36cc29a2934c..7dd59bccaeec 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -884,14 +884,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
 
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
-static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
+static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
 {
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	if (!fp->jited) {
 		set_vm_flush_reset_perms(fp);
-		set_memory_ro((unsigned long)fp, fp->pages);
+		return set_memory_ro((unsigned long)fp, fp->pages);
 	}
 #endif
+	return 0;
 }
 
 static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 9ee4536d0a09..ae28bab2b138 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2393,7 +2393,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	}
 
 finalize:
-	bpf_prog_lock_ro(fp);
+	*err = bpf_prog_lock_ro(fp);
+	if (*err)
+		return fp;
 
 	/* The tail call compatibility check can only be done at
 	 * this late stage as we need to determine, if we deal
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee86e4d7d5fc..c97108935c9a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19153,10 +19153,14 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
 	for (i = 1; i < env->subprog_cnt; i++) {
-		bpf_prog_lock_ro(func[i]);
-		bpf_prog_kallsyms_add(func[i]);
+		err = bpf_prog_lock_ro(func[i]);
+		if (err)
+			goto out_free;
 	}
 
+	for (i = 1; i < env->subprog_cnt; i++)
+		bpf_prog_kallsyms_add(func[i]);
+
 	/* Last step: make now unused interpreter insns from main
 	 * prog consistent for later dump requests, so they can
 	 * later look the same as if they were interpreted only.
-- 
2.43.0


