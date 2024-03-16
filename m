Return-Path: <linux-kernel+bounces-105107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AB587D933
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3112CB21729
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC96171AB;
	Sat, 16 Mar 2024 07:35:55 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A820D512;
	Sat, 16 Mar 2024 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710574554; cv=none; b=tgmGwXucV+RUDjoZLQG8UHbOqKX/6eCSsyqodFGH7wX7jiBZRzbr8AcvsgGggWy8D3cSxCiVRPPXBBZmZp+ifXvwpu/zxl/ZZ46GnS9OF7KjYo/12D014G7QUZBkGmJl415D8zkO8zNpmnEth13XIn7YrlD3t6pYtWaMir6rS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710574554; c=relaxed/simple;
	bh=LlnTHvbnivj9imG0loJ96IHBV/H/wsdSxRFgJXN80Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQNnvfWhYqn+4GnLUgiMYEDHqk2KLrt6Nm4S9poTzy+VD9WtzOHHP+EvuLC91wtAefWpYOdmSaoNHyhoCAqqEWQdi0BLRym4yD+rdGkjKjclxlyTwwX+Udc/jSfEEukuPAZmeRZnd0IfDWBoe5uwX2gikoa1y854v7XXhtr0vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TxXwK4dHBz9sgR;
	Sat, 16 Mar 2024 08:35:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rjeu-kkETH2k; Sat, 16 Mar 2024 08:35:45 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TxXwK3p1Fz9sfF;
	Sat, 16 Mar 2024 08:35:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 790DD8B764;
	Sat, 16 Mar 2024 08:35:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id KRZKZw9eqZpR; Sat, 16 Mar 2024 08:35:45 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO18731.IDSI0.si.c-s.fr [192.168.233.183])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EB608B768;
	Sat, 16 Mar 2024 08:35:44 +0100 (CET)
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
	netdev@vger.kernel.org,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH bpf-next v4 2/2] bpf: Check return from set_memory_rox()
Date: Sat, 16 Mar 2024 08:35:41 +0100
Message-ID: <fe1c163c83767fde5cab31d209a4a6be3ddb3a73.1710574353.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <42c635bb54d3af91db0f9b85d724c7c290069f67.1710574353.git.christophe.leroy@csgroup.eu>
References: <42c635bb54d3af91db0f9b85d724c7c290069f67.1710574353.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710574540; l=6994; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=LlnTHvbnivj9imG0loJ96IHBV/H/wsdSxRFgJXN80Jk=; b=Vre5KJCrSLF5oxg2jfaUL6rENoe4tHDG+LhmF3UdAECmWUQhueGO434Raw6VWm6dZxWspghC7 iZxJjvU/bOtAOlTVSyACGuFThN/KYUXe47+s1bQwa/orCaXTFAeA5YA
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

arch_protect_bpf_trampoline() and alloc_new_pack() call
set_memory_rox() which can fail, leading to unprotected memory.

Take into account return from set_memory_rox() function and add
__must_check flag to arch_protect_bpf_trampoline().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v4:
- In bpf_struct_ops_map_update_elem(), check return of arch_protect_bpf_trampoline() inside the loop.
- Split the line as it was reported over 80 chars by BPF patchwork's checkpatch report.

v3:
- Rebased and handled conflict in kernel/bpf/bpf_struct_ops.c

v2:
- Move list_add_tail(&pack->list, &pack_list) at the end of alloc_new_pack()
- Split 2 lines that are reported longer than 80 chars by BPF patchwork's checkpatch report.
---
 arch/arm64/net/bpf_jit_comp.c  |  3 ++-
 arch/x86/net/bpf_jit_comp.c    |  3 ++-
 include/linux/bpf.h            |  2 +-
 kernel/bpf/bpf_struct_ops.c    |  8 ++++++--
 kernel/bpf/core.c              | 29 ++++++++++++++++++++++-------
 kernel/bpf/trampoline.c        |  8 +++++---
 net/bpf/bpf_dummy_struct_ops.c |  4 +++-
 7 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 132c8ffba109..bc16eb694657 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2176,8 +2176,9 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
-void arch_protect_bpf_trampoline(void *image, unsigned int size)
+int arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
+	return 0;
 }
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 7a56d2d84512..4900b1ee019f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3004,8 +3004,9 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_prog_pack_free(image, size);
 }
 
-void arch_protect_bpf_trampoline(void *image, unsigned int size)
+int arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
+	return 0;
 }
 
 int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image_end,
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d89bdefb42e2..17843e66a1d3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1116,7 +1116,7 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 				void *func_addr);
 void *arch_alloc_bpf_trampoline(unsigned int size);
 void arch_free_bpf_trampoline(void *image, unsigned int size);
-void arch_protect_bpf_trampoline(void *image, unsigned int size);
+int __must_check arch_protect_bpf_trampoline(void *image, unsigned int size);
 int arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
 			     struct bpf_tramp_links *tlinks, void *func_addr);
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa057..2d4bfe6bfb5f 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -742,8 +742,12 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (err)
 			goto reset_unlock;
 	}
-	for (i = 0; i < st_map->image_pages_cnt; i++)
-		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
+	for (i = 0; i < st_map->image_pages_cnt; i++) {
+		err = arch_protect_bpf_trampoline(st_map->image_pages[i],
+						  PAGE_SIZE);
+		if (err)
+			goto reset_unlock;
+	}
 
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 63f100def31b..1e761c3c66db 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -908,23 +908,31 @@ static LIST_HEAD(pack_list);
 static struct bpf_prog_pack *alloc_new_pack(bpf_jit_fill_hole_t bpf_fill_ill_insns)
 {
 	struct bpf_prog_pack *pack;
+	int err;
 
 	pack = kzalloc(struct_size(pack, bitmap, BITS_TO_LONGS(BPF_PROG_CHUNK_COUNT)),
 		       GFP_KERNEL);
 	if (!pack)
 		return NULL;
 	pack->ptr = bpf_jit_alloc_exec(BPF_PROG_PACK_SIZE);
-	if (!pack->ptr) {
-		kfree(pack);
-		return NULL;
-	}
+	if (!pack->ptr)
+		goto out;
 	bpf_fill_ill_insns(pack->ptr, BPF_PROG_PACK_SIZE);
 	bitmap_zero(pack->bitmap, BPF_PROG_PACK_SIZE / BPF_PROG_CHUNK_SIZE);
-	list_add_tail(&pack->list, &pack_list);
 
 	set_vm_flush_reset_perms(pack->ptr);
-	set_memory_rox((unsigned long)pack->ptr, BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	err = set_memory_rox((unsigned long)pack->ptr,
+			     BPF_PROG_PACK_SIZE / PAGE_SIZE);
+	if (err)
+		goto out_free;
+	list_add_tail(&pack->list, &pack_list);
 	return pack;
+
+out_free:
+	bpf_jit_free_exec(pack->ptr);
+out:
+	kfree(pack);
+	return NULL;
 }
 
 void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
@@ -939,9 +947,16 @@ void *bpf_prog_pack_alloc(u32 size, bpf_jit_fill_hole_t bpf_fill_ill_insns)
 		size = round_up(size, PAGE_SIZE);
 		ptr = bpf_jit_alloc_exec(size);
 		if (ptr) {
+			int err;
+
 			bpf_fill_ill_insns(ptr, size);
 			set_vm_flush_reset_perms(ptr);
-			set_memory_rox((unsigned long)ptr, size / PAGE_SIZE);
+			err = set_memory_rox((unsigned long)ptr,
+					     size / PAGE_SIZE);
+			if (err) {
+				bpf_jit_free_exec(ptr);
+				ptr = NULL;
+			}
 		}
 		goto out;
 	}
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 04fd1abd3661..cc50607f8d8c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -456,7 +456,9 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err < 0)
 		goto out_free;
 
-	arch_protect_bpf_trampoline(im->image, im->size);
+	err = arch_protect_bpf_trampoline(im->image, im->size);
+	if (err)
+		goto out_free;
 
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
@@ -1072,10 +1074,10 @@ void __weak arch_free_bpf_trampoline(void *image, unsigned int size)
 	bpf_jit_free_exec(image);
 }
 
-void __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
+int __weak arch_protect_bpf_trampoline(void *image, unsigned int size)
 {
 	WARN_ON_ONCE(size > PAGE_SIZE);
-	set_memory_rox((long)image, 1);
+	return set_memory_rox((long)image, 1);
 }
 
 int __weak arch_bpf_trampoline_size(const struct btf_func_model *m, u32 flags,
diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
index de33dc1b0daa..25b75844891a 100644
--- a/net/bpf/bpf_dummy_struct_ops.c
+++ b/net/bpf/bpf_dummy_struct_ops.c
@@ -133,7 +133,9 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (err < 0)
 		goto out;
 
-	arch_protect_bpf_trampoline(image, PAGE_SIZE);
+	err = arch_protect_bpf_trampoline(image, PAGE_SIZE);
+	if (err)
+		goto out;
 	prog_ret = dummy_ops_call_op(image, args);
 
 	err = dummy_ops_copy_args(args);
-- 
2.43.0


