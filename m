Return-Path: <linux-kernel+bounces-96535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E89D6875DB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618EF1F21959
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEFD3BBC5;
	Fri,  8 Mar 2024 05:38:31 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C9374F1;
	Fri,  8 Mar 2024 05:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876310; cv=none; b=Opa/JSIzCoEEXyegjiDk8kbd+dE+pnpyQkGiUMJA6KWKiOEzTiYrSIkAAbELxuX5+Q6IGvgJTWRXAwCf/4hPygu2kTYGJ4VnNxtgc/C7kq9Ubm0hhUllgMrfrjsrg2mI4xrRR/8i2bpQF7JrA5Akymiuyn69mIA1Ut4Ad0OF3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876310; c=relaxed/simple;
	bh=VB7aCjrEyzCQl6Nd/SXyLObblfAjTNf+f9jJHdI22IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kX26G5ie/yRpn8p1uLJPhyfME9JL7UxkRwf65As6plN0ctvDlgBKFra6kdEKRShEs4Z1o7li0KSpxOuMfCYYhQTFbLjcjQ2y0XwrAkJgl2iQ7kLwd8FtoaNalumw/pTyeO9EHOK0XkhDMaDYEEtFNSW0XLlhgfFuZ+95ez6muak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4TrZhS5TqJz9sq0;
	Fri,  8 Mar 2024 06:38:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iQWDwp23YgG0; Fri,  8 Mar 2024 06:38:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4TrZhR6Sgnz9sps;
	Fri,  8 Mar 2024 06:38:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CBE128B775;
	Fri,  8 Mar 2024 06:38:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ENLZYn_Rd5af; Fri,  8 Mar 2024 06:38:15 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (PO23130.IDSI0.si.c-s.fr [192.168.232.110])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B13378B774;
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
	Jiri Olsa <jolsa@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Johan Almbladh <johan.almbladh@anyfinetworks.com>,
	Paul Burton <paulburton@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Wang YanQing <udknight@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
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
Subject: [PATCH bpf-next v3 2/2] bpf: Take return from set_memory_rox() into account with bpf_jit_binary_lock_ro()
Date: Fri,  8 Mar 2024 06:38:08 +0100
Message-ID: <036b6393f23a2032ce75a1c92220b2afcb798d5d.1709850515.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <286def78955e04382b227cb3e4b6ba272a7442e3.1709850515.git.christophe.leroy@csgroup.eu>
References: <286def78955e04382b227cb3e4b6ba272a7442e3.1709850515.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709876288; l=8100; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VB7aCjrEyzCQl6Nd/SXyLObblfAjTNf+f9jJHdI22IY=; b=W33lPIDIgr8PEUyjwxEMcKO+D+Z+D1qaqtgtxD+CJRhI5nR6avIRzXxN4xH8ZhGslueQokkTD 6pCCtavJARKCNfgTPc1pXtSM6n9j4jA+SIP+lOhNv4QtO4ONZe1cMHc
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_memory_rox() can fail, leaving memory unprotected.

Check return and bail out when bpf_jit_binary_lock_ro() returns
an error.

Link: https://github.com/KSPP/linux/issues/7
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-hardening@vger.kernel.org <linux-hardening@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Puranjay Mohan <puranjay12@gmail.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>  # s390x
Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>  # LoongArch
Reviewed-by: Johan Almbladh <johan.almbladh@anyfinetworks.com> # MIPS Part
---
Previous patch introduces a dependency on this patch because it modifies bpf_prog_lock_ro(), but they are independant.
It is possible to apply this patch as standalone by handling trivial conflict with unmodified bpf_prog_lock_ro().

v3: No change.

v2:
- Dropped arm64 change following commit 1dad391daef1 ("bpf, arm64: use bpf_prog_pack for memory management")
- Fixed too long lines reported by checkpatch
---
 arch/arm/net/bpf_jit_32.c        | 25 ++++++++++++-------------
 arch/loongarch/net/bpf_jit.c     | 22 ++++++++++++++++------
 arch/mips/net/bpf_jit_comp.c     |  3 ++-
 arch/parisc/net/bpf_jit_core.c   |  8 +++++++-
 arch/s390/net/bpf_jit_comp.c     |  6 +++++-
 arch/sparc/net/bpf_jit_comp_64.c |  6 +++++-
 arch/x86/net/bpf_jit_comp32.c    |  3 +--
 include/linux/filter.h           |  5 +++--
 8 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 1d672457d02f..01516f83a95a 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -2222,28 +2222,21 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	/* If building the body of the JITed code fails somehow,
 	 * we fall back to the interpretation.
 	 */
-	if (build_body(&ctx) < 0) {
-		image_ptr = NULL;
-		bpf_jit_binary_free(header);
-		prog = orig_prog;
-		goto out_imms;
-	}
+	if (build_body(&ctx) < 0)
+		goto out_free;
 	build_epilogue(&ctx);
 
 	/* 3.) Extra pass to validate JITed Code */
-	if (validate_code(&ctx)) {
-		image_ptr = NULL;
-		bpf_jit_binary_free(header);
-		prog = orig_prog;
-		goto out_imms;
-	}
+	if (validate_code(&ctx))
+		goto out_free;
 	flush_icache_range((u32)header, (u32)(ctx.target + ctx.idx));
 
 	if (bpf_jit_enable > 1)
 		/* there are 2 passes here */
 		bpf_jit_dump(prog->len, image_size, 2, ctx.target);
 
-	bpf_jit_binary_lock_ro(header);
+	if (bpf_jit_binary_lock_ro(header))
+		goto out_free;
 	prog->bpf_func = (void *)ctx.target;
 	prog->jited = 1;
 	prog->jited_len = image_size;
@@ -2260,5 +2253,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 		bpf_jit_prog_release_other(prog, prog == orig_prog ?
 					   tmp : orig_prog);
 	return prog;
+
+out_free:
+	image_ptr = NULL;
+	bpf_jit_binary_free(header);
+	prog = orig_prog;
+	goto out_imms;
 }
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index e73323d759d0..7dbefd4ba210 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1294,16 +1294,19 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	flush_icache_range((unsigned long)header, (unsigned long)(ctx.image + ctx.idx));
 
 	if (!prog->is_func || extra_pass) {
+		int err;
+
 		if (extra_pass && ctx.idx != jit_data->ctx.idx) {
 			pr_err_once("multi-func JIT bug %d != %d\n",
 				    ctx.idx, jit_data->ctx.idx);
-			bpf_jit_binary_free(header);
-			prog->bpf_func = NULL;
-			prog->jited = 0;
-			prog->jited_len = 0;
-			goto out_offset;
+			goto out_free;
+		}
+		err = bpf_jit_binary_lock_ro(header);
+		if (err) {
+			pr_err_once("bpf_jit_binary_lock_ro() returned %d\n",
+				    err);
+			goto out_free;
 		}
-		bpf_jit_binary_lock_ro(header);
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->image = image_ptr;
@@ -1334,6 +1337,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	out_offset = -1;
 
 	return prog;
+
+out_free:
+	bpf_jit_binary_free(header);
+	prog->bpf_func = NULL;
+	prog->jited = 0;
+	prog->jited_len = 0;
+	goto out_offset;
 }
 
 /* Indicate the JIT backend supports mixing bpf2bpf and tailcalls. */
diff --git a/arch/mips/net/bpf_jit_comp.c b/arch/mips/net/bpf_jit_comp.c
index a40d926b6513..e355dfca4400 100644
--- a/arch/mips/net/bpf_jit_comp.c
+++ b/arch/mips/net/bpf_jit_comp.c
@@ -1012,7 +1012,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_prog_fill_jited_linfo(prog, &ctx.descriptors[1]);
 
 	/* Set as read-only exec and flush instruction cache */
-	bpf_jit_binary_lock_ro(header);
+	if (bpf_jit_binary_lock_ro(header))
+		goto out_err;
 	flush_icache_range((unsigned long)header,
 			   (unsigned long)&ctx.target[ctx.jit_index]);
 
diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index d6ee2fd45550..979f45d4d1fb 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -167,7 +167,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(jit_data->header, ctx->insns + ctx->ninsns);
 
 	if (!prog->is_func || extra_pass) {
-		bpf_jit_binary_lock_ro(jit_data->header);
+		if (bpf_jit_binary_lock_ro(jit_data->header)) {
+			bpf_jit_binary_free(jit_data->header);
+			prog->bpf_func = NULL;
+			prog->jited = 0;
+			prog->jited_len = 0;
+			goto out_offset;
+		}
 		prologue_len = ctx->epilogue_offset - ctx->body_len;
 		for (i = 0; i < prog->len; i++)
 			ctx->offset[i] += prologue_len;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index b418333bb086..e613eebfd349 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2111,7 +2111,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 		print_fn_code(jit.prg_buf, jit.size_prg);
 	}
 	if (!fp->is_func || extra_pass) {
-		bpf_jit_binary_lock_ro(header);
+		if (bpf_jit_binary_lock_ro(header)) {
+			bpf_jit_binary_free(header);
+			fp = orig_fp;
+			goto free_addrs;
+		}
 	} else {
 		jit_data->header = header;
 		jit_data->ctx = jit;
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index fa0759bfe498..73bf0aea8baf 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -1602,7 +1602,11 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	bpf_flush_icache(header, (u8 *)header + header->size);
 
 	if (!prog->is_func || extra_pass) {
-		bpf_jit_binary_lock_ro(header);
+		if (bpf_jit_binary_lock_ro(header)) {
+			bpf_jit_binary_free(header);
+			prog = orig_prog;
+			goto out_off;
+		}
 	} else {
 		jit_data->ctx = ctx;
 		jit_data->image = image_ptr;
diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index b18ce19981ec..f2be1dcf3b24 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -2600,8 +2600,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	if (bpf_jit_enable > 1)
 		bpf_jit_dump(prog->len, proglen, pass + 1, image);
 
-	if (image) {
-		bpf_jit_binary_lock_ro(header);
+	if (image && !bpf_jit_binary_lock_ro(header)) {
 		prog->bpf_func = (void *)image;
 		prog->jited = 1;
 		prog->jited_len = proglen;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 7dd59bccaeec..fc42dcfdbd62 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -895,10 +895,11 @@ static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
 	return 0;
 }
 
-static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
+static inline int __must_check
+bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
 {
 	set_vm_flush_reset_perms(hdr);
-	set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
+	return set_memory_rox((unsigned long)hdr, hdr->size >> PAGE_SHIFT);
 }
 
 int sk_filter_trim_cap(struct sock *sk, struct sk_buff *skb, unsigned int cap);
-- 
2.43.0


