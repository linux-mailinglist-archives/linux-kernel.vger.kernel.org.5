Return-Path: <linux-kernel+bounces-60353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB5D85039E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 10:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC981F23462
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5E2B9CF;
	Sat, 10 Feb 2024 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8XjV0Yo"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D38282E1
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556723; cv=none; b=kCwYp+6f+Its+QAEYBy2s03p3y6lOsFpcS1V5FpgN82ryu+CaKNZsN0fxWI1eOk8i9wemVbXVZmRWBvKDwUVbeFlYBrDMeA89XOL00rtmryWs49dqSVOISaCsAbW39hM2ZXD5r/z2g+BaNenQJBKB9i9kgBsk8QeaOC/SnEDmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556723; c=relaxed/simple;
	bh=LC6wwKuwi5aVRuct2C9N3HzQXYLMKr4i4lX7/uXNsro=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bzBkZjH7fYbgYLFvh/Nyed2C9qnnJkuokojlj5RBOMfrBKaeJl6K9kiZbj3yC+iBv8aOGPcYbRFYm3m3LH4LQ0+7HIM93jSjdUhOo7E/tOHrurBn8rD2hcVxfMrCgFTylgpEedbRqJeM+h+p4XU7k9iLoPI7VFRRZTFkrc+Mwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I8XjV0Yo; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e117eec348so799107a34.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 01:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707556720; x=1708161520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bbrnpouUuffedythjQ6MAxMQbInpAn6Da5zEha5uHkM=;
        b=I8XjV0Yo5CniwXE1aYGvFD+4FvzA7hTXtJGYzOV+ET3WRtV15srP+B6gZ8y1iom91C
         E8jXVL4OzO7W6PkM3BQqgu8pZqpkuyHaiCigBetWnfwNgNuhC2SOM+5o35XTkZcttvy4
         8ndDGBb4YpwkvF0W4KweROyff7QOfOWkvtyG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707556720; x=1708161520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbrnpouUuffedythjQ6MAxMQbInpAn6Da5zEha5uHkM=;
        b=c2mP3tA5zOn1Oo38rL+kFDbY+HVL1HgN1I4alIMSiltkh866AdflifB1plDY0GhgKn
         fwxS3HlfKH+z5Fo6vUC79LKffMQYDV0zFimw3K5/a8uVAheUBBpO2oKclAdphTNZjWOw
         3lMo2cRfC7cGVDOG8jLa46QXA1LJCutCa5MDRNpdmB6VTw5IBlmtSwAr9hinN2hYjvjR
         Qvt9UDQSYsH6w78EfmKjOjphY7f9PFqdPyDt0QUIFOODi15A1nf06V7Onzq+Qa0eXh1a
         WvU6OzCU3tJ1/6Z7XVqYWYT+YiAWcul6Uqx+S+iJ+cv/zKLPgr36TT1OKgXMGBHxo4ou
         2skw==
X-Gm-Message-State: AOJu0YyR1EtXRMwQC1VniLhonQcPzdGFkvNqPdju8I0MNgRWlxMH01gR
	dj5PyndthoeOnv9TE2/7G7BqoxYYdFGyecuqGgXvNizmW/sCjo2lfOTrrF/5Tg==
X-Google-Smtp-Source: AGHT+IFU8zPeV6pg7NVco2CspTAljHSeVKcHPF+NDXjD4XLfIycXQY0lkm0Ks2GKd96muoZHBl44nA==
X-Received: by 2002:a05:6359:1284:b0:179:2771:69b with SMTP id ix4-20020a056359128400b001792771069bmr2246292rwb.29.1707556720309;
        Sat, 10 Feb 2024 01:18:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/6wH648XitzjB85LGagX01IAusIXFXJnajRIaSnCGXOAl9UaxapdT0NhciY0hS7vKCUhnOl5B/Z1sAMozqtUAbQ3KYAM/IcKJl2re4IXgCj7BtZWB/3Ek/G7iOrZkGrFI/ZPEKDnoLRon5FWdwgqp4kT8h6yE1jYEN1gi8Wep+nlSVfGYbXl0Ba7cJMa375/irN7JNO4gAGRxu9QuVd+a8JNTjC5u1hNYc2VbMyUwMgutxUUTKk4/GS7mF8+neQ5OVq2LPDg2bWvmtjnyUTqV0/R4w/OWy3lVTfUIdBuIsHTHODBxAUqwtqBjwlYBWK3UXuW01fPme82bU0ii7KBtoT+nhMsrmh8flW5Kv7MlewGC5XdXRIfKO0IxAQa5khZktkbHJ8nSo269aXM1yM7epFw23hRBInTcI7M+x7Hwkzf09TgHJb08TCggbrtcco8Dj9gpLxtuuYzvYh9IbfqAVQU2p52UBKCgvm1AvhVnTydKVDUa99FCtoZRKDnIXjUrp7ImItIbtQpbV6rXsOhM2Jh9kYQdzqr1CKRU0/ZRbzI1LGI95s53KTl/1ZaUd9Rlq8wG2ImcwG9PWLZQ3ftwIw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h24-20020a62b418000000b006e046085ee8sm1900420pfn.174.2024.02.10.01.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 01:18:39 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Daniel Micay <danielmicay@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Brian Gerst <brgerst@gmail.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Chang S. Bae" <chang.seok.bae@intel.com>,
	Igor Zhbanov <i.zhbanov@omprussia.ru>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	John Allen <john.allen@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/vdso: Move vDSO to mmap region
Date: Sat, 10 Feb 2024 01:18:35 -0800
Message-Id: <20240210091827.work.233-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5800; i=keescook@chromium.org;
 h=from:subject:message-id; bh=nWAm4frIQZAHrwq360LYqJ/akdG0MCWYRqawD3LyjJQ=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlxz9rP8+/kxR495DuBW1sEef72P32z8HT+R5Vn
 Woz2JQLg2OJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcc/awAKCRCJcvTf3G3A
 JsllD/9YCv1Um6OUYhAf13ZdwrqdFcxsN++7IxP2n+M5pIoxSQlB9seD6qdFsUVzMAnZ0FTPHcy
 9fNh/VLDCshDtRXNW8aFRCYprO+tzux051VXyF4M/VE2IMmOHUterNIq06F4LAk3nDp+puoosFf
 DGCyYiuthr5vVkAe7ajMCL1YbYRCdRVFn3RAFfjVwHpZ56h2CydocVDAfIecenVsDK5xkkqsO1N
 q5lq4bEN8WK5NHnzPHR/e477B2GAvF/WfJ1Awnar1aFcgIhWE2yka1hVnph+d9UgO0yIiUmR3J7
 bRjHnys7MriuJp1lBKrgId009NDk7PRh21AAYy/mhSTermyYw0ExscO9RfdJLElH0ah0vT8Oqse
 1Qp2jPZYMP7bSVwfw6CqGKMWqDacRiP2/eFh48slUHD3Y4OqP29gRIgFljGKJZltx1OloThX6Xq
 wl522PgOYOoJHFMss/BLuvZg2TThGsAj0oX7Jz7V+b0FnHp7f71gMAOpcaM19uPkOZ8yvboy9lo
 GIGbCexBX+rCzb1tOe7q7AUc/HSXIzynmuMHlsIvz0hMZJ8tVy8jKvzGXiaKIBgPTheTuigmsJT
 pH2ULTuVPMOey2c4o1sGOPGYYdVmoa/wGYiWWaGFBKeFmQPRwnACaTidI5mye1Nm+r2y/ymsyOn
 FCtaRWJ oThix6Kw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Daniel Micay <danielmicay@gmail.com>

The vDSO (and its initial randomization) was introduced in commit
2aae950b21e4 ("x86_64: Add vDSO for x86-64 with gettimeofday/clock_gettime/getcpu"),
but had very low entropy. The entropy was improved in commit
394f56fe4801 ("x86_64, vdso: Fix the vdso address randomization algorithm"),
but there is still improvement to be made.

On principle there should not be executable code at a low entropy offset
from the stack, since the stack and executable code having separate
randomization is part of what makes ASLR stronger.

Remove the only executable code near the stack region and give the vDSO
the same randomized base as other mmap mappings including the linker
and other shared objects. This results in higher entropy being provided
and there's little to no advantage in separating this from the existing
executable code there. This is already how other architectures like
arm64 handle the vDSO.

As an side, while it's sensible for userspace to reserve the initial
mmap base as a region for executable code with a random gap for other
mmap allocations, along with providing randomization within that region,
there isn't much the kernel can do to help due to how dynamic linkers
load the shared objects.

This was extracted from the PaX RANDMMAP feature.

Closes: https://github.com/KSPP/linux/issues/280
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Igor Zhbanov <i.zhbanov@omprussia.ru>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-mm@kvack.org
Signed-off-by: Daniel Micay <danielmicay@gmail.com>
[kees: updated commit log with historical details and other tweaks]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/vma.c    | 57 ++----------------------------------
 arch/x86/include/asm/elf.h   |  1 -
 arch/x86/kernel/sys_x86_64.c |  7 -----
 3 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 7645730dc228..6d83ceb7f1ba 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -274,59 +274,6 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr)
 	return ret;
 }
 
-#ifdef CONFIG_X86_64
-/*
- * Put the vdso above the (randomized) stack with another randomized
- * offset.  This way there is no hole in the middle of address space.
- * To save memory make sure it is still in the same PTE as the stack
- * top.  This doesn't give that many random bits.
- *
- * Note that this algorithm is imperfect: the distribution of the vdso
- * start address within a PMD is biased toward the end.
- *
- * Only used for the 64-bit and x32 vdsos.
- */
-static unsigned long vdso_addr(unsigned long start, unsigned len)
-{
-	unsigned long addr, end;
-	unsigned offset;
-
-	/*
-	 * Round up the start address.  It can start out unaligned as a result
-	 * of stack start randomization.
-	 */
-	start = PAGE_ALIGN(start);
-
-	/* Round the lowest possible end address up to a PMD boundary. */
-	end = (start + len + PMD_SIZE - 1) & PMD_MASK;
-	if (end >= DEFAULT_MAP_WINDOW)
-		end = DEFAULT_MAP_WINDOW;
-	end -= len;
-
-	if (end > start) {
-		offset = get_random_u32_below(((end - start) >> PAGE_SHIFT) + 1);
-		addr = start + (offset << PAGE_SHIFT);
-	} else {
-		addr = start;
-	}
-
-	/*
-	 * Forcibly align the final address in case we have a hardware
-	 * issue that requires alignment for performance reasons.
-	 */
-	addr = align_vdso_addr(addr);
-
-	return addr;
-}
-
-static int map_vdso_randomized(const struct vdso_image *image)
-{
-	unsigned long addr = vdso_addr(current->mm->start_stack, image->size-image->sym_vvar_start);
-
-	return map_vdso(image, addr);
-}
-#endif
-
 int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 {
 	struct mm_struct *mm = current->mm;
@@ -369,7 +316,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (!vdso64_enabled)
 		return 0;
 
-	return map_vdso_randomized(&vdso_image_64);
+	return map_vdso(&vdso_image_64, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -380,7 +327,7 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 	if (x32) {
 		if (!vdso64_enabled)
 			return 0;
-		return map_vdso_randomized(&vdso_image_x32);
+		return map_vdso(&vdso_image_x32, 0);
 	}
 #endif
 #ifdef CONFIG_IA32_EMULATION
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1e16bd5ac781..1fb83d47711f 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -392,5 +392,4 @@ struct va_alignment {
 } ____cacheline_aligned;
 
 extern struct va_alignment va_align;
-extern unsigned long align_vdso_addr(unsigned long);
 #endif /* _ASM_X86_ELF_H */
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index c783aeb37dce..cb9fa1d5c66f 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -52,13 +52,6 @@ static unsigned long get_align_bits(void)
 	return va_align.bits & get_align_mask();
 }
 
-unsigned long align_vdso_addr(unsigned long addr)
-{
-	unsigned long align_mask = get_align_mask();
-	addr = (addr + align_mask) & ~align_mask;
-	return addr | get_align_bits();
-}
-
 static int __init control_va_addr_alignment(char *str)
 {
 	/* guard against enabling this on other CPU families */
-- 
2.34.1


