Return-Path: <linux-kernel+bounces-157256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574268B0F25
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889B11C228F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3563C15FD15;
	Wed, 24 Apr 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GpEM94zB"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF371635BB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974022; cv=none; b=UhYYpUZlxKUgRDPnvx9QCmtI/LXSjRZiS86g0eGDmO20t7ZhRWCxl9mIadgp+2CrC5mmaLcMXBAxXkkNC1/Y5Ud8Z1ZLEypFW5WP19nfViCNq183RonWR+6B0OK3YhgrViI/58LCPX9O0F8oIrwm7ESmdjdPpFndcB2YVyp/+jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974022; c=relaxed/simple;
	bh=fyw024FNdzCgn0OBHM3Ypj7OxQnitm+MYHa2n2pobIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XiojHNyZ8UUZvGmpKtrXj3ySK0TrSNBuQXrGmO4ATImglPRWj/vXeE7tatuKs4PhrTNICCN5i56MxTwKvRgSqm2JQxHqhFI0WOuP+DNWCLUad4VfvslKCGjTlRwLL19G5EtIiZkCDZh7EurLEYwVuLu26PBPCAMnUHdfbEtG5o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GpEM94zB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de54be7066bso63909276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974020; x=1714578820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ONwyVskTWQHpslgTZw8hf4C4K9cIt0E7xmJFnUiDsPw=;
        b=GpEM94zBJ4TiAGiELnhNronveYXwiYbUskLe0gZn8G+xa1HCkLnxVWvO+sTzLABoSd
         TJptsJlXFgTNzQb3F+kjxO2pHDGP/ikvQ0lzSt/v16xGo5wVvgYZ8d3wIYEJ2IInhCdg
         Ei+cv63B18r85Ui2QL+oQbpBoJaEXI7oBccsEgTg25P9cC8evnzF8RbXwhW2lnrPXf0q
         9692K3NZyimvQQEauQaf3SVe8F5vLzTt41e0/sae9xMnvOw1Bl/QJHjCaL3EjEwPB1/F
         VfedCXrFyv6R8i29RpfKv+MdMTwCfeHjyDtnT1k0wVa2W+QF6EJby/oP85QZYScr8bdC
         PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974020; x=1714578820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ONwyVskTWQHpslgTZw8hf4C4K9cIt0E7xmJFnUiDsPw=;
        b=W+4zuKAWOgcoONGf6SXTzVEuW9lVEK6+CAMpdXyTemh+EMhyUeAR4HyGLm/nR4kzBP
         BDUszknOzsMcyEomIlj6a7MjB8ZigIG4nRyG8jXwUT1HtuQvksWfFyyx1jmE/end2ZpF
         fVNDz1lvdtsSq1B20JNE3WKt5OnhVjBOH9bGZvU0+gyFwhH32iULB0wTYlH6lfAQ8OvX
         XcxtcxI214pbA0ye7In6JUftp4QyXIxTsXor7dbqULy42N4f33fk238U3pBkJjTH/2Qo
         aacnNIaBgTouK+TkKE/vhw/Z07aSa7mbsB+N0WgRlDdhE2vcIIXl4TdSwIJzZBxHyE4f
         Jg7Q==
X-Gm-Message-State: AOJu0YzBlAEpO6hmNAmaHc60A+36jIvq3KQU8JotPWSowpzhhXLLdawv
	pmVAbBAlI92rw5uVTilHS6P8t3owv4CGJqgjr6LdWPtLsRGQh6avPPCNNodcu/pvlURYBQoSAaV
	uO2ZzDjVAdFJCs+f/o/0UsNFRiS3QB62kRnGX6d0vgJsVFB2u0FIWt2y+GONurES4OfbS4LArW0
	l0K6Ckoas8ILFYq9Wped4MkZissdJ0nQ==
X-Google-Smtp-Source: AGHT+IHX7WtsVsNqwNKvhI+To4SnGawKByTnzbSwsG/s5eCZ1zrHonsgJl1jG+GXDbRYbFRHkYOwz1DB
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2b0a:b0:de5:319b:a226 with SMTP id
 fi10-20020a0569022b0a00b00de5319ba226mr985183ybb.1.1713974019817; Wed, 24 Apr
 2024 08:53:39 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:13 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=ardb@kernel.org;
 h=from:subject; bh=KmSF5Zvyw7fE7ONhepC4hKKyoNQsKlI4bUs+BgqWQzY=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T60VG8aksjVwf35OnVyknZLtwrJ/zuvg3i411QMi0z
 M/NWw51lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIn8aWNk2NaTLt+veqD2RfKL
 BpeprI7nRbYvNzii87FxgfgRvslalowMax45Sl90CNyqsOWg9boPYoyVed3yfrNkVm/f909/WoY yJwA=
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-14-ardb+git@google.com>
Subject: [RFC PATCH 3/9] x86/purgatory: Drop pointless GDT switch
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86 purgatory switches to a new GDT twice, and the first time, it
doesn't even bother to switch to the new code segment. Given that data
segment selectors are ignored in long mode, and the fact that the GDT is
reprogrammed again after returning from purgatory(), the first switch is
entirely pointless and can just be dropped altogether.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/setup-x86_64.S | 29 --------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/x86/purgatory/setup-x86_64.S b/arch/x86/purgatory/setup-x86_64.S
index 2d10ff88851d..f160fc729cbe 100644
--- a/arch/x86/purgatory/setup-x86_64.S
+++ b/arch/x86/purgatory/setup-x86_64.S
@@ -15,17 +15,6 @@
 	.code64
 
 SYM_CODE_START(purgatory_start)
-	/* Load a gdt so I know what the segment registers are */
-	lgdt	gdt(%rip)
-
-	/* load the data segments */
-	movl	$0x18, %eax	/* data segment */
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	%eax, %ss
-	movl	%eax, %fs
-	movl	%eax, %gs
-
 	/* Setup a stack */
 	leaq	lstack_end(%rip), %rsp
 
@@ -34,24 +23,6 @@ SYM_CODE_START(purgatory_start)
 	jmp	entry64
 SYM_CODE_END(purgatory_start)
 
-	.section ".rodata"
-	.balign 16
-SYM_DATA_START_LOCAL(gdt)
-	/* 0x00 unusable segment
-	 * 0x08 unused
-	 * so use them as the gdt ptr
-	 */
-	.word	gdt_end - gdt - 1
-	.quad	gdt
-	.word	0, 0, 0
-
-	/* 0x10 4GB flat code segment */
-	.word	0xFFFF, 0x0000, 0x9A00, 0x00AF
-
-	/* 0x18 4GB flat data segment */
-	.word	0xFFFF, 0x0000, 0x9200, 0x00CF
-SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-
 	.bss
 	.balign 16
 SYM_DATA_START_LOCAL(lstack)
-- 
2.44.0.769.g3c40516874-goog


