Return-Path: <linux-kernel+bounces-105307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5482B87DC01
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 00:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767D81C20ACF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 23:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D884F88A;
	Sat, 16 Mar 2024 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YfLvQtjk"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ABC433D8
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 23:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710631287; cv=none; b=oyW5Mpzg0S3emk9GTTRqCUqkvcLEkiuXv1KwrzPiDAKCaEdS1wSR+ZaBzEdmTKwOiWul+hkjQmJD+CesL4jszDEx0dMaAMobpRwkOinDmtJvhhha7owZ/gqMeTk3G236Z/UH/SIJBwj1fcNR75ZCvwGqPlsGz4hQ5j82oj665YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710631287; c=relaxed/simple;
	bh=n8w1ZtzBd5/Q5wTKnX7AEhzagI2H+aqaDS9Fye2Kfhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sNyAuB++kK9fbo6bDIt1bL3fQCENMqHXor+UAiZKLtYTUTy7Fi9AsQM37+pibTpQQrKAX7tVjCgenRQg9Czxf3uHs/ATH7mPuKz231b21Awq8SpW7iO8HusmUN8uo91QN/P94Nv1PVD8lnPgOUYkhRLL/LuS/VIjuK1rwrgnFlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YfLvQtjk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-413fea148c9so16116015e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710631284; x=1711236084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyYnPtGjqDeDPkvkILQi659Kg/uKdJDkB+U0D+eZfJw=;
        b=YfLvQtjkuIlyCpWbKYpYWedAIEHc7P7mxwSvUsOcJ/D9KbhCTVn/klkC+Ao5lCf5gY
         g1AxMmh6ARyu+dLfc6dLiUBuWZ6w2Maj96dWZiAy9+dc5leyJsd1tziMMMtiGxFRPD70
         +JIIBjNGF19xk0JUEJlwhta6ec62xfXBBnZki021Tb+gPgBn1elJmUNOOHZTD/sJOJgV
         SHMLknexhDIjkdS/0fI4anW0fkwqQ+4Hy+PHEybEflQrERUNQpysKhXYUyGTLK5VTdrI
         NbUFyg3EVqtUlQFLROeTyJdGEahp7YZqHN1WAghPYgo66hxKbjEWDTkuQIPrLNlHBj3+
         u8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710631284; x=1711236084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyYnPtGjqDeDPkvkILQi659Kg/uKdJDkB+U0D+eZfJw=;
        b=AYD0RsDKYv2KGJcqckQX71TF6DalIkU2vo3h4rD4y7cqcQvWNkxDvXJgIavXbFy0sH
         wU6iTZKEChj/+FnGPeKLpVFnfNdUlB7vo0cztxlJ9kEQBnZ3MiCF6lpxqbkY39+t9mYL
         59h8brmv4vDSrQ/x3DjMWqSBMA3ccW0lHV35LP7yDg81fmEIuVcVDuezFLSr3mReiWj1
         hHE9RkJeSnV0l/E7iIBunODza1k1OHrvmAAb37NXnjCUDc4Ez/sYvnxhNIR2bro0tw/K
         m/OKRLYFoigGl0HEZMy6Mng/Cn7nn+YPM6XDMG5d7kedTfAhLieY3jnCaaPgKDx5w4Pm
         FMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyBvnvO/WlFnb77isNRRRL5pZckQCQL46zpcPEbKeLJ3MJseB3z/EwWhMj41/Rc1kFqEdjkqnqLWjk6byKywj3GrfUAgWCpwySWVh
X-Gm-Message-State: AOJu0YwJ9NIsYnMu6zukZOQ1OeFjgQI7bOThGCMBt3KGNcAbrlYGTNkS
	Vd91d/WZYnDm3EDDtSZVassw7FfpvKtBXiDSeauUkA07JS3MsYui
X-Google-Smtp-Source: AGHT+IHEoz7YU5ogG/DA3gRILG6NmbkQL/3zAPF4zLOMgtqak+7iBU+huSDPe1KYz2uITMxmy/M+wg==
X-Received: by 2002:a05:600c:458e:b0:413:812:ce7b with SMTP id r14-20020a05600c458e00b004130812ce7bmr6483817wmo.24.1710631284007;
        Sat, 16 Mar 2024 16:21:24 -0700 (PDT)
Received: from solport.. (82.red-83-42-63.dynamicip.rima-tde.net. [83.42.63.82])
        by smtp.gmail.com with ESMTPSA id fm13-20020a05600c0c0d00b004140a13f998sm1597028wmb.11.2024.03.16.16.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 16:21:23 -0700 (PDT)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	=?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
Subject: [PATCH 2/2] x86/bpf: Fix IP for relocating call depth accounting
Date: Sat, 16 Mar 2024 23:21:04 +0000
Message-ID: <20240316232104.368561-3-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240316232104.368561-1-joanbrugueram@gmail.com>
References: <20240316232104.368561-1-joanbrugueram@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recently introduced support for %rip-relative relocations in the
call thunk template assumes that the code is being patched in-place,
so the destination of the relocation matches the address of the code.
This is not true for the call depth accounting emitted by the BPF JIT,
so the calculated address is wrong and usually causes a page fault.

Pass the destination IP when the BPF JIT emits call depth accounting.

Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
Signed-off-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
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


