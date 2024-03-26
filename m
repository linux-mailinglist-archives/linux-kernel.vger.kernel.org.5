Return-Path: <linux-kernel+bounces-119351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5060D88C77A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C811F8009C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2817D13D258;
	Tue, 26 Mar 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MCX2/SbP"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231F13C91E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467438; cv=none; b=GagI3aNAt+1rmxjR3206Zzj4VUA3P2Wj/9s+DEskg3WeWM73nJwJnqOZPWHZQyqP2g7esq81+gUcD9oJTIGVxH6/Fgxgt7cpYl9+yIYq3Dc1V62n5S9Y/vfUz9h+SLEQCMWnwgUyhDRgqqTrchoc6YtICvD7MBu3JAhUsNbey4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467438; c=relaxed/simple;
	bh=lP5dS6Tq+FiqxKpTrDMAZkxw9jBHYyu9IhEQCNtnP0M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fQYoo96S9qOBb8Ch0v4U1nnkrsaamYucktCgigCCK8h7zhZBqTAcG2qf8uFs1Thlsp/UVQYwkMcy7STu8i6O0zbMqGgrokdeNQiBxfVc/oqJ9sZ7AZ0mBrPm7nwu/WYHSstNP/CqiGeDqv/45PdWRlfha4DcHgNUuIATUccoI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MCX2/SbP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a605154d0so63777717b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711467436; x=1712072236; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BMvO/gDA6wsc5/QrzpIMGz8r1v8np9pO9kTN8mjpmmc=;
        b=MCX2/SbPm5TyiVRTn1UmFJDmQXpQIAuShhePpYGuk8PO4SF0FEa9Y2rJLgugsxVTPg
         o7UL40Gjrvq2j+mXATRe0ibmq3usUJFZ4hWVgpLSAUat+XDm2LD1RRg9mo829aVkESBV
         A2aYreBlsnsdGzrLqNVqmBGuRTHWstdk728c9kqimokNSc+KgX3XhbWlsf/Ak5KJxhxo
         WtDu2KkSFrVXOto8wToPbxxpFZqXcos/7L9lWLDQsU7M8AYDTmDZ+hTUDjCeP+BKvdMZ
         ux67KARZKht5Sh95/VI2XNOFphcEm1oQk2VfN1HgZptevDOa1WLQVrC3818fxjCIRsYf
         Vn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467436; x=1712072236;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BMvO/gDA6wsc5/QrzpIMGz8r1v8np9pO9kTN8mjpmmc=;
        b=mf6m5qVBlpWT6Mvh+yVo0RMeFxIu4kPUoK1nWGrTS9GKrPWqUaV6XSOlBhLQYCkonM
         SH5GB1ukS89IUlRrgDHMuwgBWzGtM9jGW+/wvI6cvnOUuL7F4KrrNrJEfvbLSzBTmVf2
         hAUrHreqtunfBCwynnGAfy+oNxNuXJAC935uEYoZ1sml1X/Ezl8xq11VGMpuOGR+BwYt
         vDypn8wmpwV3Y0h7Zfo+HOXLvxXFRVYWNNUgANZNVl2bDV397cGkxorEyK9PCXE2bgxG
         tyv5YrWe1ICgsxYnNLPobZqdOP0U1NabWjIlcWoGM5mnKsTdqcpHnWV0kP1Th7tEYoxo
         CYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCVecExTtCJ1vCvPu2dznvmlJS74ifS02o/dnniZOpJF8txbsqM41G6n5hTJxaEf4noUIz6P+UAT/GF4LBVJg9MFnULOsTHpDi1dcA
X-Gm-Message-State: AOJu0Yx9gL3cim6XeuPfnMso+zpKeHF/6+HAs8AFQn6nVJXEaoLeQCvf
	6qHr1X2xxNPT0BkLE2DjXjOqDBMjKJBPP24u0PeMu/W/vNGR+KmqXZDvjR9lDm/pGZJIBG9pZp6
	sbDX5GKCYtpnuBRh/6CP3mLy1CA==
X-Google-Smtp-Source: AGHT+IEtAbrfT0KePjTSZM1C/n453rH7UBsGCdgk9CYCpbgWc5d2/+acGD9f2ceoAz0WcEi0b/jf/PyVJ9b+Z7F1JRs=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a81:f10c:0:b0:60a:1844:74ef with SMTP
 id h12-20020a81f10c000000b0060a184474efmr351393ywm.1.1711467435797; Tue, 26
 Mar 2024 08:37:15 -0700 (PDT)
Date: Tue, 26 Mar 2024 15:37:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=samitolvanen@google.com;
 h=from:subject; bh=lP5dS6Tq+FiqxKpTrDMAZkxw9jBHYyu9IhEQCNtnP0M=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmAuuoWZIuWrE47I8B1b5TKFB+Qw8KjT+kih/KH
 WHMg9Yk0QmJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZgLrqAAKCRBMtfaEi7xW
 7ufGC/9qxcoSs09RThvb6flQlJcD7unRQHlOjzVZnI0+k7IpZsx+Qp+lQQ7b9jXAKWtV0jW2CAU
 9qJ9Vcp7kM/YgrwWARkIImRpSz0oVBGPHwBPGlNv+gOHsGJiIEzT5PfwOBOQZ6+iFkIVrmcU+qV
 pzbIsGIH5AljMJExPewedP4DT8Q7MY2rGE4ty+mwF2fztac+Ir7zOF2zM5HoPlN2RW+zG0FGjl+
 bhi6cJQWnZ7b2zna7Ya8yAEnhqYIxby/AuhuCZYMcrajA/GrpHR4AYMYjoNiW6T8hG2oBSg1DMK
 mCIz2odn4rCrRrwGMaSOOGSDHufTvQDJiCwrynP1aBU+rtWYdimt/+rEiKSEEaaL1RPSTFOPXG3
 EAjsgQls7qrb6Shyu7ZX2zoxeGTFkRcQdFe0aNBWMeUOPw74ZJxGLnMps3YWo1DLQMes6eW39fh oxbbqx/2PvPAFL6HaHT87bJDNA0sS88ZWTCEFibxu5bZhNsG5fdqEv1kEkOKLAWPHOyTM=
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326153712.1839482-2-samitolvanen@google.com>
Subject: [PATCH] riscv: Mark __se_sys_* functions __used
From: Sami Tolvanen <samitolvanen@google.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Kees Cook <keescook@chromium.org>, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Clang doesn't think ___se_sys_* functions used even though they are
aliased to __se_sys_*, resulting in -Wunused-function warnings when
building rv32. For example:

   mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
    1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
     221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
     231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
      81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
      40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
         |                     ^~~~~~~~~~~~~~~~~~~~
   <scratch space>:30:1: note: expanded from here
      30 | ___se_sys_process_mrelease
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.

Mark the functions __used explicitly to fix the Clang warnings.

Fixes: a9ad73295cc1 ("riscv: Fix syscall wrapper for >word-size arguments")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/riscv/include/asm/syscall_wrapper.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index 980094c2e976..ac80216549ff 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 					ulong)						\
 			__attribute__((alias(__stringify(___se_##prefix##name))));	\
 	__diag_pop();									\
-	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
+			__used;								\
 	static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
 
 #define SC_RISCV_REGS_TO_ARGS(x, ...) \

base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.44.0.396.g6e790dbe36-goog


