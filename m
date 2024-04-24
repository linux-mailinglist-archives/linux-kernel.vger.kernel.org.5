Return-Path: <linux-kernel+bounces-157257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 196FD8B0F26
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B67FE1F22CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF4D16C6A6;
	Wed, 24 Apr 2024 15:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwQvhJ0F"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AB9168AF1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974024; cv=none; b=uwgX+cBnfPCqRqTdprJjIKfSXcnLkcOMHuaZCDyRxPzxu5kmMYI46MKj031wOJdt8iBQUYi9+AVh14OYkhWlA0wjpVeoVAWrYfSYra3bJP8hYhrm9bLj6+XGlie5NhoSftWruWZja/sew4LC/4poP7PDU8UbOwcEJkjFIbk6c3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974024; c=relaxed/simple;
	bh=9+swj6gVAPxZ4sAKUioQftvHESZtWdbvHkiKo8iymQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C8+0LJaBIOYvARypqBZZ9rakMYpYFw2BsO46J1dR0mLDurtwQ2X+p7iGtrzTJ9xYiHrPJvreYVnDbGSH6MMDkmODfu5I3Gd418M5cZ8Q5AiGjljtYDU76EU/PBlJd6FrYdmcDpKY2/UusqCPuBd9yXnXt59hZgCsRjW9ZWJfYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwQvhJ0F; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso64851276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974022; x=1714578822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I1uZvGOJrDJyNyZbDNRiP2qZHG8ZyjcmYdwIIxk4UA4=;
        b=HwQvhJ0FaHR78G6Jbt6K/CIL9VbHYYXTkU5MnotDrw0ec4ncEmmD7mvT8LO4J+McIH
         pay+7sq7VwRA1e0dPXByUXSYJ8OycnQDqbavL/5dDNmLfQJ9SpmyeuoZuxSe+QcvtP18
         +6jzrBqVADyzAZqJ8Jw5lXOz4YY4BigPRikyYNOxtuSrW3YosopitVSU61Xi06ZVvgC5
         kY2awLOqUINZtSdJ2A0ypad0t9fPSa/WadwbUSiwiVoK98dQmhdgf880AN+Ut9mrgG0P
         CPG+5K/CnP1U5Ef8iTwn0Xxxnu3ScZ+jnPowg24fdtNhUb37PWpRR79/ZxE32vZC3ATk
         n7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974022; x=1714578822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I1uZvGOJrDJyNyZbDNRiP2qZHG8ZyjcmYdwIIxk4UA4=;
        b=P5eYym/OeGfK/aymv92e9xWETGVRpoQOmXpyizbK7Ci+DWV1T6y/4ufmqi5aUa/vSa
         yBcleH525SVUauAS59/AvWPzpMmf3DhVgf7b5B/KCblDo0Ai9Xul6lownNyA/jAFUjRg
         HO4IfAYA319CUY9LPjpVI/cfu7OvOqSpIA7/hw9lrY89FEEujwt5eU56gOF4GMTG3C5y
         C686mRtK1Pt22E1CN3bdP8v1e0QBrX+Yvn3KbaXc+0kV+RJknK9lydHjvmn0fJtAnHXq
         9mxDCvDdmhAwBksUwh0AjoFFmx5w8C7EbV1SBmX/clhUHRwuL+27gszXtYvGJ7amDyRv
         BbDA==
X-Gm-Message-State: AOJu0YwzZB9Cq+1xZzXOpD5WABCyZrKAlFBbfFHS/cce6AubSCnuN8JR
	XCCX7XT0QqUYaX6mYDX3pLTQNNzvLV7NbODin5dtCZ1YQK2vbJYQvUm/7dtvnnMZuDWBnmgPzpp
	TMhiykVBaAfbG+yliYFq6ibuV7Gwa45JBYXMT/4jneBbchnPAJXdnJfhlYlAReluS4P445SRPo4
	uKvzttjznFvymy/58cxZt1xCRhvro3ug==
X-Google-Smtp-Source: AGHT+IFEGGFxfMnQooqXA71tEBTY29NX0MUA7pIaduK0k76YjwQ4bXrhWlZuNWvOPSLJ1YLTC5jr9V+A
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:120b:b0:de4:67d9:a2c6 with SMTP id
 s11-20020a056902120b00b00de467d9a2c6mr203644ybu.2.1713974022222; Wed, 24 Apr
 2024 08:53:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:14 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=ardb@kernel.org;
 h=from:subject; bh=XNDtlXNqERbrKnet8kKgoeintaNkpRS0TQFFAtyMk8M=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T69WP2+KSbU965hyyfHHbMubHPOZrK1Ia1xxZZPv4e
 ocgr9GmjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRgzGMDDOOXfadUMz1Y5e7
 1Eej2e0P/GS3/Nw2R0dVO2trpJaVz3SG//FvfZ746Kprbm2vkwqLLn3/d4XNfJnneuvDPfcZZ/1 4xAQA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-15-ardb+git@google.com>
Subject: [RFC PATCH 4/9] x86/purgatory: Avoid absolute reference to GDT
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The purgatory is almost entirely position independent, without any need
for any relocation processing at load time except for the reference to
the GDT in the entry code. Generate this reference at runtime instead,
to remove the last R_X86_64_64 relocation from this code.

While the GDT itself needs to be preserved in memory as long as it is
live, the GDT descriptor that is used to program the GDT can be
discarded so it can be allocated on the stack.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 9913877b0dbe..888661d9db9c 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -16,7 +16,11 @@
 
 SYM_CODE_START(entry64)
 	/* Setup a gdt that should be preserved */
-	lgdt gdt(%rip)
+	leaq	gdt(%rip), %rax
+	pushq	%rax
+	pushw	$gdt_end - gdt - 1
+	lgdt	(%rsp)
+	addq	$10, %rsp
 
 	/* load the data segments */
 	movl    $0x18, %eax     /* data segment */
@@ -83,8 +87,8 @@ SYM_DATA_START_LOCAL(gdt)
 	 * 0x08 unused
 	 * so use them as gdt ptr
 	 */
-	.word gdt_end - gdt - 1
-	.quad gdt
+	.word 0
+	.quad 0
 	.word 0, 0, 0
 
 	/* 0x10 4GB flat code segment */
-- 
2.44.0.769.g3c40516874-goog


