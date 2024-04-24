Return-Path: <linux-kernel+bounces-157261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0CB8B0F2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03103296A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EEA16D4DD;
	Wed, 24 Apr 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+NC66p2"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C916D33C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974034; cv=none; b=nAtYIDwUtVXR0iZ4ZLX+xInoxv0toDP9XQVUcTLa4FyTYX7DjnygrMfW09qBjbK8joIs7LkRNwtx1D/GRnbdYlvaUuLZ3osjlKUTEpP4DKml7dQKBVFyzYcX/BdlLTl2ElBjZxEl30fIEcgmisrjOB9lgJF2hdtP492CdLQUVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974034; c=relaxed/simple;
	bh=HZYQYaRf1dR7DEcXcxVov+yo3FzyXQK8WUfc4ejJyH0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KsGfoIiMAckxtEuMc032h+ONx+bhYEKTmcSEFRIzCLW8F+JyOiu/e9PtpRjCoxi0QEy51rbIbRei04YLutSwlPHyxiMIxhoZWOZ9QZJD1tWzsBWPWYq3QvHdC8MIOslOHqyTa0rRPCJICzGjAutfKOujUaLsRyDHVr+Utz2KIFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+NC66p2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-418a673c191so21845e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974031; x=1714578831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vceqt7TifCou1HPRPnwqXwiyHcq6CY32UQFrKskdP68=;
        b=X+NC66p2Srp5QzpqavJEIn+9qFvdJ4iFe10ZLzKpnJZcLxY/GRQJuuhHlzZKWOHbVc
         eAT4cOf6HVXuyJa2XuhICgkzsoojaF1oo/o7oUkUqn8udIjFIc8SKI64HxQyHiz2kYBc
         qzYJ1uRymid9O1IlvZxKphZq5VAvD7crF8nVUgNWcwvFgPeA2a0pUPWy7y3hTmQlqTBU
         hK0mY/hRLehPFvRkDbcheVCW7Gxe7TrUvj0vv89Vdw+OurN3jCH5HAoy4/YXl5Fy1p/Z
         ppfk2Uq52ve+elhNRGaCBoSVSOwCsNw4wiu41+iaJ1Rmgu7urGVxrCsBmwEUL2GJVVq6
         PFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974031; x=1714578831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vceqt7TifCou1HPRPnwqXwiyHcq6CY32UQFrKskdP68=;
        b=MqNaEQRFMWdoEoAX4mcKa0rgUs9cBbNyjX/60ZB3dKytVOm0GfYTWFGxLr8GPFZqLU
         Pv/nxxqJSTou0UxHaOZ3+G/I+G9IDFdgwJK+qWX1X+saH9zLgfOP94k0qWyZlLZxcE23
         6okXVHtBWUVIDB0m+HqLDeW/Dkt1W4YxGzN6WyIrjzAZ852D4eogPIUH4nKqLH1jUfl8
         PITknsWcFznJA4sXikg5tgyHEZLUuKcrHY03xpudBzzX5qoO8Ugac58Jtk9i9uet9pej
         b/79feIDmHnx6ocM5n4JEyBJclKa8ZETY7d8Mw2D1H8ZjXIyw2W0TBCcWUB/24TCjnb7
         JG8w==
X-Gm-Message-State: AOJu0YyOlchMy3zWH45C+jwtqlTfJxqzifpaZ8SGcx0JLjMF8udjC5ci
	ERK2PMBCxlsPnaZ/SeBDk5+N9daehqlJr2M8Pe2DCWru3ASohccmRy3kPe92MbpK0wsi5It/qmL
	ieLGQ/rBxrKxL7I2rjhQ+qLhkjF9CGrvepCQ4tta3FgwYv8mtu4b5gSJNl14CdyKGn/cSQ+NyoE
	twwK3s5prJeXlOvc8pfoQNHiCUrFNZiQ==
X-Google-Smtp-Source: AGHT+IEgIce6FPBXR6zGeN4ZV5e/jTyyGjrZ6o4ezBolJ8kjLZr2gRR3t4yw5Tk8N83KwMIeS+t+nCjf
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:adf:fb01:0:b0:33d:5804:7f6e with SMTP id
 c1-20020adffb01000000b0033d58047f6emr11165wrr.4.1713974031332; Wed, 24 Apr
 2024 08:53:51 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:18 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357; i=ardb@kernel.org;
 h=from:subject; bh=oIYWiPazWt0a3ZXKk6EjdN5wcBfWVZ3Z+EicqDLij6o=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T651wYZulH1f2qRa5GSoKb76+01Bdt6Vp4d3Zn+a3e
 suc8HLvKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABO5fIyR4Wli15yznFPOrDh7
 WuK76io2sVyftOqDHJVuKmpSQuwT0xkZXs8/diLx6dm55mrHZe6/zJixP2mzo7iHFvchmVUzvhd sYAMA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-19-ardb+git@google.com>
Subject: [RFC PATCH 8/9] x86/purgatory: Simplify references to regs array
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use a single symbol reference and offset addressing to load the contents
of the register file from memory, instead of using a symbol reference
for each, which results in larger code and more ELF overhead. While at
it, rename the individual labels with an .L prefix so they are omitted
from the ELF symbol table.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 67 ++++++++++----------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 3d09781d4f9a..56487fb7fa1d 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -37,45 +37,46 @@ SYM_CODE_START(entry64)
 new_cs_exit:
 
 	/* Load the registers */
-	movq	rax(%rip), %rax
-	movq	rbx(%rip), %rbx
-	movq	rcx(%rip), %rcx
-	movq	rdx(%rip), %rdx
-	movq	rsi(%rip), %rsi
-	movq	rdi(%rip), %rdi
-	movq	rbp(%rip), %rbp
-	movq	r8(%rip), %r8
-	movq	r9(%rip), %r9
-	movq	r10(%rip), %r10
-	movq	r11(%rip), %r11
-	movq	r12(%rip), %r12
-	movq	r13(%rip), %r13
-	movq	r14(%rip), %r14
-	movq	r15(%rip), %r15
+	leaq	entry64_regs(%rip), %r15
+	movq	0x00(%r15), %rax
+	movq	0x08(%r15), %rcx
+	movq	0x10(%r15), %rdx
+	movq	0x18(%r15), %rbx
+	movq	0x20(%r15), %rbp
+	movq	0x28(%r15), %rsi
+	movq	0x30(%r15), %rdi
+	movq	0x38(%r15), %r8
+	movq	0x40(%r15), %r9
+	movq	0x48(%r15), %r10
+	movq	0x50(%r15), %r11
+	movq	0x58(%r15), %r12
+	movq	0x60(%r15), %r13
+	movq	0x68(%r15), %r14
+	movq	0x70(%r15), %r15
 
 	/* Jump to the new code... */
-	jmpq	*rip(%rip)
+	jmpq	*.Lrip(%rip)
 SYM_CODE_END(entry64)
 
 	.section ".rodata"
-	.balign 4
+	.balign	8
 SYM_DATA_START(entry64_regs)
-rax:	.quad 0x0
-rcx:	.quad 0x0
-rdx:	.quad 0x0
-rbx:	.quad 0x0
-rbp:	.quad 0x0
-rsi:	.quad 0x0
-rdi:	.quad 0x0
-r8:	.quad 0x0
-r9:	.quad 0x0
-r10:	.quad 0x0
-r11:	.quad 0x0
-r12:	.quad 0x0
-r13:	.quad 0x0
-r14:	.quad 0x0
-r15:	.quad 0x0
-rip:	.quad 0x0
+.Lrax:	.quad	0x0
+.Lrcx:	.quad	0x0
+.Lrdx:	.quad	0x0
+.Lrbx:	.quad	0x0
+.Lrbp:	.quad	0x0
+.Lrsi:	.quad	0x0
+.Lrdi:	.quad	0x0
+.Lr8:	.quad	0x0
+.Lr9:	.quad	0x0
+.Lr10:	.quad	0x0
+.Lr11:	.quad	0x0
+.Lr12:	.quad	0x0
+.Lr13:	.quad	0x0
+.Lr14:	.quad	0x0
+.Lr15:	.quad	0x0
+.Lrip:	.quad	0x0
 SYM_DATA_END(entry64_regs)
 
 	/* GDT */
-- 
2.44.0.769.g3c40516874-goog


