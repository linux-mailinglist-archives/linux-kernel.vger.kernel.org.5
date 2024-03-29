Return-Path: <linux-kernel+bounces-124368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DB89164F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12C5B1C22E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288045477C;
	Fri, 29 Mar 2024 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOuc8Zbn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA251C42;
	Fri, 29 Mar 2024 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711705770; cv=none; b=KNJwWR9XzkvuisRUQ+IuveOS/Gi39IJddkOjMNhjfSnlejuxky1En1JmgcLgqbYIkbNdGyPcOYXM+OZ0icCw6POYuEQRDvrjU/g7N/Digx3cctgqhnKM/8a8kZksAr4nWhcTvjNAQw+lcXWkB48zH+JxCxDrgNelQv8K8LI6idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711705770; c=relaxed/simple;
	bh=hqCljvC32qy1aJQwAmFON1j9oPrqVbZVDNy4RJHdb/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJfoeq3xB6gj/Z3OKMB6Plrd4L1t46XGQLHywduhCTsx7Sm12jTUQxC8vyXco5cOOsBtVpNGS7AHaxV36WL0P9LbD4mLxW8OXlKpp0c0KFFa4VV9+A7Z941vX2RE3OnDv5GWToImbMQAPmybZKdT6/kYlUYztEre9Dx3Yt0aW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOuc8Zbn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a465ddc2c09so106847366b.2;
        Fri, 29 Mar 2024 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711705767; x=1712310567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHSOVIWxWM7IMY+bvKjJnZsIEx5Dhp5jPlyzSlliO1I=;
        b=XOuc8ZbnT4/sl8dT+PMdlpcpLVbvrYF8IQleYXBpogqn9A3HmkRQZBD4zl82jzi0hy
         iCrshPuTjeXNu1guMVvwsIKn/PZZ4PcPVKVrtmZSVD8LxdW3hRUcFNN3Z8a5dR94Govb
         zl4mLE4eC3+8LfRWnUULgEUfQdGLB8I5rfqS+pqz77HDV0hTRIzFV/hNSplQVm31hcth
         CqIN0Ex3fhjApKWbTfcGlgCXC0me6GvK62rjDxuyKsOcAJedsKMbf5VpU2I+UTrwUNgs
         gcyxbKx8DYuAIe5u7/kpU6/Tv/Mt2gU4p1IyQ/aixMXKpbob+1WjYt0g8tcING4A8JWH
         R32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711705767; x=1712310567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHSOVIWxWM7IMY+bvKjJnZsIEx5Dhp5jPlyzSlliO1I=;
        b=p+22zyOZFBV40qTQMmjZkjkJX3oLlFncuSDdFLCTEeJtCB8oJsMiMg3hXrenjJnGfz
         P9Nr/rMmiSNXO9gqkveGBNxLZ08EwMzUNeTVTiXFKfIIZIRySt53wwGIgJgFfhCRp9Om
         bhGcw5BkQtrh0zqVgIXQFECCiOENAOR3ZOtpQ+staVuG0Qz+KETlWMZh5MZ7raPgx2Vm
         GNIH6dc/DGoaZyg+UIIrtrBne1pd9fZz30uBXjC8pLbxze+NTV4Yhn5UL5km/oCN4gV5
         GN9GT+kEOg457bZKKlqPPduDkM7hA+xq4PoVPt306dwFk86skpa10VnyoVEq7a08IuAD
         tAXA==
X-Forwarded-Encrypted: i=1; AJvYcCWpQ3yKvp4UjjNTBYmMpfFN0aMIWtC9sSjYMtvQcQjGtII+9WIYQIBZ+LxtU4kEh+V5vzMy64t1M3GdzpDsQCCy/4rv20rXqedQnzR4lve2Dnqk3Bqbf8yN+CR7tBaGTFwomnIptl8DUNpgh+a8s3ty8nPFZjy8iC0f
X-Gm-Message-State: AOJu0YxjF5D59pPmtImtLdw/MlfbkkeEZAT5ySucdFKET4IJhQC3k2Fb
	LdqjRCJrSlvrKp9Boii5HU4FyM4Zq17WDLXujeqbyZFO/CWwCe1a
X-Google-Smtp-Source: AGHT+IFACKnbtBeJLF5ik9tpo0Ya/WArpgeSL7iNa9UO8o7ombLR0YWPBn0KSIsUuamOWRvaMhglxg==
X-Received: by 2002:a05:6402:13d6:b0:56c:5a7b:5dbf with SMTP id a22-20020a05640213d600b0056c5a7b5dbfmr2019197edx.2.1711705766578;
        Fri, 29 Mar 2024 02:49:26 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id b4-20020a0564021f0400b0056c1cca33bfsm1829733edb.6.2024.03.29.02.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:49:25 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RESEND bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
Date: Fri, 29 Mar 2024 10:46:18 +0100
Message-ID: <20240329094906.18147-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329094906.18147-1-ubizjak@gmail.com>
References: <20240329094906.18147-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

The recently introduced support for %rip-relative relocations in the
call thunk template assumes that the code is being patched in-place,
so the destination of the relocation matches the address of the code.
This is not true for the call depth accounting emitted by the BPF JIT,
so the calculated address is wrong and usually causes a page fault.

Pass the destination IP when the BPF JIT emits call depth accounting.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Reviewed-by: Uros Bizjak <ubizjak@gmail.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 arch/x86/include/asm/alternative.h |  4 ++--
 arch/x86/kernel/callthunks.c       |  4 ++--
 arch/x86/net/bpf_jit_comp.c        | 19 ++++++++-----------
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index fcd20c6dc7f9..67b68d0d17d1 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -117,7 +117,7 @@ extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
-extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
+extern int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -128,7 +128,7 @@ static __always_inline void *callthunks_translate_call_dest(void *dest)
 	return dest;
 }
 static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
-							  void *func)
+							  void *func, void *ip)
 {
 	return 0;
 }
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 30335182b6b0..e92ff0c11db8 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -314,7 +314,7 @@ static bool is_callthunk(void *addr)
 	return !bcmp(pad, insn_buff, tmpl_size);
 }
 
-int x86_call_depth_emit_accounting(u8 **pprog, void *func)
+int x86_call_depth_emit_accounting(u8 **pprog, void *func, void *ip)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
 	u8 insn_buff[MAX_PATCH_LEN];
@@ -327,7 +327,7 @@ int x86_call_depth_emit_accounting(u8 **pprog, void *func)
 		return 0;
 
 	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
-	apply_relocation(insn_buff, tmpl_size, *pprog,
+	apply_relocation(insn_buff, tmpl_size, ip,
 			 skl_call_thunk_template, tmpl_size);
 
 	memcpy(*pprog, insn_buff, tmpl_size);
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 09f7dc9d4d65..f2e8769f5eee 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -481,7 +481,7 @@ static int emit_rsb_call(u8 **pprog, void *func, void *ip)
 {
 	void *adjusted_ip;
 	OPTIMIZER_HIDE_VAR(func);
-	adjusted_ip = ip + x86_call_depth_emit_accounting(pprog, func);
+	adjusted_ip = ip + x86_call_depth_emit_accounting(pprog, func, ip);
 	return emit_patch(pprog, func, adjusted_ip, 0xE8);
 }
 
@@ -1973,20 +1973,17 @@ st:			if (is_imm8(insn->off))
 
 			/* call */
 		case BPF_JMP | BPF_CALL: {
-			int offs;
+			u8 *ip = image + addrs[i - 1];
 
 			func = (u8 *) __bpf_call_base + imm32;
 			if (tail_call_reachable) {
 				RESTORE_TAIL_CALL_CNT(bpf_prog->aux->stack_depth);
-				if (!imm32)
-					return -EINVAL;
-				offs = 7 + x86_call_depth_emit_accounting(&prog, func);
-			} else {
-				if (!imm32)
-					return -EINVAL;
-				offs = x86_call_depth_emit_accounting(&prog, func);
+				ip += 7;
 			}
-			if (emit_call(&prog, func, image + addrs[i - 1] + offs))
+			if (!imm32)
+				return -EINVAL;
+			ip += x86_call_depth_emit_accounting(&prog, func, ip);
+			if (emit_call(&prog, func, ip))
 				return -EINVAL;
 			break;
 		}
@@ -2836,7 +2833,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		 * Direct-call fentry stub, as such it needs accounting for the
 		 * __fentry__ call.
 		 */
-		x86_call_depth_emit_accounting(&prog, NULL);
+		x86_call_depth_emit_accounting(&prog, NULL, image);
 	}
 	EMIT1(0x55);		 /* push rbp */
 	EMIT3(0x48, 0x89, 0xE5); /* mov rbp, rsp */
-- 
2.44.0


