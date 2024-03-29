Return-Path: <linux-kernel+bounces-124346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E22891608
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 628101C23345
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B12585C6C;
	Fri, 29 Mar 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCjH87/1"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351085631;
	Fri, 29 Mar 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704505; cv=none; b=LDdLl+OoHnF87SJRTJ5G6k9HXjuUABY6M4qbARgqssG9kxg3pYTTtkoXGRWouG8+lhjO9k+IdAS1Tk781CS49GNnlju7UGTi6rpmXVO3T9jnXDQ4285QvKz+60JfIldcjz07pTYZsu9XzDm9gc4FXNfdUe6BXeAe8f7BGDyTyDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704505; c=relaxed/simple;
	bh=tbF9b/muDGMfCoxH1ZCVTgSmbzivSlDGSFld2qO4EMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYWwchvKjl8AI3zykykz0X3j43INCAS+Ve31/XrCa8gG9l0rcyEVSIrqJJxIjuPcXn1H3S+BO+B8iv8b0zoVuaioNrFiBfWaQSquaDxTVIdLB6qfOQhUgJ4R/VLf/krzDJ4Q7F3lqOd6IWQLyRRwlJvfkPVkDk0V6w5334zOlIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCjH87/1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46d0a8399aso481706566b.1;
        Fri, 29 Mar 2024 02:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711704501; x=1712309301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqUCkOqvIUH04vsFrScv57KnpQglh0Vcjq++kQXTzsQ=;
        b=iCjH87/1YNIjc1dgPXp2VVSp8291kgTWWQ9iirimV6gsFaVEGhlMiZ4tCWkMaB3ddz
         5yKxMUWaBOJMUNOnHq1GUVeXECTiSbCfSHhSTqQjRZG5pnQsu5ov6T7Px96zZyvoyRex
         IaX0p7gI6b0NcBBQafroNLqkg3z2k7TVYp0N6Krog2PM9aeFoW/5qKx6xK7DLkOFg0gB
         psm7mZtZwlI2YIDXIPNjGRQsuKj0Tgixrosyj0EiEjMDh+LCdLSWaA3I/kcZyAXrKTga
         24Wr1j5RTiT6e7FlFmanRYpSR1uuz+GNkNoHv85NuErnxIR4mgHLI3RjyuECMIm6fu/w
         JIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704501; x=1712309301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqUCkOqvIUH04vsFrScv57KnpQglh0Vcjq++kQXTzsQ=;
        b=s5MsRfuNkbIg0RdHGPcVhmL9//8W/7yjNxvZvlN9BVp0J5Q0T1IQE/YTLe3t6p8zHU
         zlzFvsBhXxRzJ5SUoKhx2P9le5wlWX45X3Lxz2VZ23j6d5rK3g7+7mXCtp5MjQWScFZb
         hgr99jSbe6YLNiJ9tAo+VE2bs5qCzeScW1AO8ACimlTVZoTbj8WURkh7KuS3hNKZ1mCA
         YYT4fuNwmWcnWPyLKlhcLwBoPNA0ZlDC2hxVZwN4GgyM12YHEuvrOv5IYqfa9xeYVR7N
         +4r3JnPgllOLDxdctxrLWW5OVbZD0e0tT5WMwEACIcJs7AV7sCtyexmoRY2p52KEZtNZ
         sfpA==
X-Forwarded-Encrypted: i=1; AJvYcCW2RMxlTn1JIeunuVi/UJAWVtMZDOnOzf0jswfHUaQAVnzQXnd9tljyfAuaEDZAXoBAe0N5Op5u+Y5nKoqxTVHJ+JpEv8x0bBoZS+Pi
X-Gm-Message-State: AOJu0YwUDmW11kpUJjpsLtb0orwarLglyqa06S8u3NhHBwhPuTbiRxRg
	aPcfEFYJqQv8lfO50MybKn1nFtPAQ+hdERNxFcXW6Vhenku55epO72sc5UVsf28=
X-Google-Smtp-Source: AGHT+IGqX6NpRbhpIPJ94ewuSJX9nh4Lk2+yZut80IbJeClJaGAZ2XRaDQJZedQpR2BZgVRjhVKG9g==
X-Received: by 2002:a17:906:2813:b0:a46:a3d1:679a with SMTP id r19-20020a170906281300b00a46a3d1679amr1632349ejc.14.1711704500804;
        Fri, 29 Mar 2024 02:28:20 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id jx24-20020a170906ca5800b00a47152e6d10sm1700975ejb.134.2024.03.29.02.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:28:19 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf 2/2] x86/bpf: Fix IP for relocating call depth accounting
Date: Fri, 29 Mar 2024 10:25:08 +0100
Message-ID: <20240329092723.17435-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329092723.17435-1-ubizjak@gmail.com>
References: <20240329092723.17435-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Joan Bruguera Micó <joanbrugueram@gmail.com>

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


