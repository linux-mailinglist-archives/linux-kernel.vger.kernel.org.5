Return-Path: <linux-kernel+bounces-105106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919A787D930
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32190B215CE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697ECF505;
	Sat, 16 Mar 2024 07:35:49 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22D1D512;
	Sat, 16 Mar 2024 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574549; cv=none; b=tG0d4458dPQyEamx3BxkChw4MJ04q0kO9Unz42Ko2V+OgjTOdDO/2I1XGf2U28KqJovCkqnCQmiSEkKIDowwr70S1AyzJAh2tVMw1ur0/nA6ZuGns9Kv/74mpNAHpkifSPKPvM3TdFXkioful0Mr6E0dNpIyhnGJAL0ydHopXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574549; c=relaxed/simple;
	bh=T5bIwnC4F5+XhzcizGiodJCow49SKAvyJt/UVTT6f10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TgvFMfvzIE/GhxjaR7qwee76cY12OgF9kqt3yqfllGeUT6xQ5Q2NKxkuXUQPSlfJ8HvyBD3MSx8gho4aDfTHHpsRHHrsTW0IFfLAgXKs/DdyOcjZoUhvptigb8sbaOsFEFfOPwCx3IqtONFyyGOFFVUxhnnPf+s+RsghO6r+nGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TxXwJ2XHBz9sgJ;
	Sat, 16 Mar 2024 08:35:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Xxb4X6sR4Uy; Sat, 16 Mar 2024 08:35:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TxXwJ1RwDz9sfF;
	Sat, 16 Mar 2024 08:35:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 27CF18B76C;
	Sat, 16 Mar 2024 08:35:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dBMYRJzyNT0I; Sat, 16 Mar 2024 08:35:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO18731.IDSI0.si.c-s.fr [192.168.233.183])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CED238B764;
	Sat, 16 Mar 2024 08:35:42 +0100 (CET)
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
	Jiri Olsa <jolsa@kernel.org>,
	Zi Shen Lim <zlim.lnx@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v4 1/2] bpf: Remove arch_unprotect_bpf_trampoline()
Date: Sat, 16 Mar 2024 08:35:40 +0100
Message-ID: <42c635bb54d3af91db0f9b85d724c7c290069f67.1710574353.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710574540; l=3028; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=T5bIwnC4F5+XhzcizGiodJCow49SKAvyJt/UVTT6f10=; b=uzUMQgPir//Sh+yMaOXG853ZNTpLoDmrEjAMPUnFKvQzYmjW/5XfEgXO8ToeWNMzHDlUKfvzZ qmpBTuxFwLxCVXBC6mvXWExGa9rbUlQpUIzwm587U4CmPlUxU465Mli
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Last user of arch_unprotect_bpf_trampoline() was removed by
commit 187e2af05abe ("bpf: struct_ops supports more than one page for
trampolines.")

Remove arch_unprotect_bpf_trampoline()

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Fixes: 187e2af05abe ("bpf: struct_ops supports more than one page for trampolines.")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4: No change
v3: New
---
 arch/arm64/net/bpf_jit_comp.c | 4 ----
 arch/x86/net/bpf_jit_comp.c   | 4 ----
 include/linux/bpf.h           | 1 -
 kernel/bpf/trampoline.c       | 7 -------
 4 files changed, 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index c5b461dda438..132c8ffba109 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2180,10 +2180,6 @@ void arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
 }
 
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-}
-
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 				void *ro_image_end, const struct btf_func_model *m,
 				u32 flags, struct bpf_tramp_links *tlinks,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index a7ba8e178645..7a56d2d84512 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3008,10 +3008,6 @@ void arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
 }
 
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-}
-
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
 				const struct btf_func_model *m, u32 flags,
 				struct bpf_tramp_links *tlinks,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4f20f62f9d63..d89bdefb42e2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1117,7 +1117,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
 void arch_protect_bpf_trampoline(void *image, unsigned int size);
-void arch_unprotect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr);
 
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index db7599c59c78..04fd1abd3661 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -1078,13 +1078,6 @@ void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
 	set_memory_rox((long)image, 1);
 }
 
-void __weak arch_unprotect_bpf_trampoline(void *image, unsigned int size)
-{
-	WARN_ON_ONCE(size > PAGE_SIZE);
-	set_memory_nx((long)image, 1);
-	set_memory_rw((long)image, 1);
-}
-
 int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 				    struct bpf_tramp_links *tlinks, void *func_addr)
 {
-- 
2.43.0


