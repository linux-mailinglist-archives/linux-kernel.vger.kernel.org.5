Return-Path: <linux-kernel+bounces-104694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38087D274
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2E1285097
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42AF5103D;
	Fri, 15 Mar 2024 17:06:55 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4314EB51;
	Fri, 15 Mar 2024 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710522415; cv=none; b=sqePon0axOnjQe5m+/Ijcuiw6OhgmvweVxBwUVP5KO9a1Yun31Pa6Dx4r/zBZfRgogzafIoIF4Y0SxXGdb4l9lTcGIiiAj0/ZW2pUarGtg3/wYVh34mTPUcRg/Pst+B74gf0fFm+4y5ccKUNG2WuV6ofERHT52DO7f2IxC6tOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710522415; c=relaxed/simple;
	bh=sl2cr8YeYnuznXFIaEYjAzPf9uV8OZ4t6aOmppKeo4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4rU2tBetFKm3I7ka4HD4/tzTHlnptxtkntjFs8RmglMbc9oN6TDqecldnJJNk9GBRyvrHIkOXw3d4grMcn6ZdWaKHBy5ecfMBvcEIqVpQgL9Baqp+A/t1pFkpIjY1qm6xZ5+m08W2LHN/k197+xU+eaWuuU6SPau8cIpgbtS3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Tx9dc3pRnz9scZ;
	Fri, 15 Mar 2024 18:06:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hki_c1Hyr4T0; Fri, 15 Mar 2024 18:06:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Tx9dc2z5Xz9scH;
	Fri, 15 Mar 2024 18:06:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CD998B764;
	Fri, 15 Mar 2024 18:06:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id sNFuq5X96zpF; Fri, 15 Mar 2024 18:06:44 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.95])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F31E68B792;
	Fri, 15 Mar 2024 18:06:42 +0100 (CET)
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
Subject: [PATCH bpf-next v3 2/2] bpf: Check return from set_memory_rox()
Date: Fri, 15 Mar 2024 18:06:39 +0100
Message-ID: <4d7cc25e937403ac61ae61be06f998f27e631a65.1710522112.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
References: <2b9fdb119ef73cfa4516572026ba4936e86aedca.1710522112.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710522399; l=6786; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=sl2cr8YeYnuznXFIaEYjAzPf9uV8OZ4t6aOmppKeo4M=; b=uEhDuYR2vQxMEE08Lyf8q7+SycatJE65mq03LP/hv8VTlqdUA8dd1eVdm6i645YWnbISJ9Pvx JJfbwMO/MDgBvpJU8mDPq5rltRKgNQNq4sp79M/WLthcHDsXl2yHIEa
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

arch_protect_bpf_trampoline() and alloc_new_pack() call
set_memory_rox() which can fail, leading to unprotected memory.

Take into account return from set_memory_rox() function and add
__must_check flag to arch_protect_bpf_trampoline().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v3:
- Rebased and handled conflict in kernel/bpf/bpf_struct_ops.c

v2:
- Move list_add_tail(&pack->list, &pack_list) at the end of alloc_new_pack()
- Split 2 lines that are reported longer than 80 chars by BPF patchwork's checkpatch report.
---
 arch/arm64/net/bpf_jit_comp.c  |  3 ++-
 arch/x86/net/bpf_jit_comp.c    |  3 ++-
 include/linux/bpf.h            |  2 +-
 kernel/bpf/bpf_struct_ops.c    |  7 +++++--
 kernel/bpf/core.c              | 29 ++++++++++++++++++++++-------
 kernel/bpf/trampoline.c        |  8 +++++---
 net/bpf/bpf_dummy_struct_ops.c |  4 +++-
 7 files changed, 40 insertions(+), 16 deletions(-)

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
index 43356faaa057..ca1d9b87c475 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -742,8 +742,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		if (err)
 			goto reset_unlock;
 	}
-	for (i = 0; i < st_map->image_pages_cnt; i++)
-		arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
+	for (i = 0; i < st_map->image_pages_cnt && !err; i++)
+		err = arch_protect_bpf_trampoline(st_map->image_pages[i], PAGE_SIZE);
+
+	if (err)
+		goto reset_unlock;
 
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


