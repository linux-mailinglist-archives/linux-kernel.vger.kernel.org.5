Return-Path: <linux-kernel+bounces-111813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F4E88714A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB8B286615
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B460274;
	Fri, 22 Mar 2024 16:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLY1kkgI"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272915FDCF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126374; cv=none; b=Aunc4YQ2ymbzpeUnvjpxoBIu0HiaL9NtqJFEvEohs+cpGNIaE40l+1kiiHIQ/RpKyMHeZa417Jk8yGLYoltDYmZ2VFkJoSeXKBggpg6RsHf6UFkzYZyRTLS/5a/+27kLMzAfcvZNUKjjbX+BiK8D9kGWcz64PM0x/cnj1iHj1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126374; c=relaxed/simple;
	bh=RklUhCugdS79Sgvea9NKA5O8n1Z8/hDlRq99HOBTwEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQCr+OY9haYSvsldl9Qfd7qmEKaWQL7zCLJuHwe49BEx/7GhkJCt/PGRCACts4mGzQdM/pudQD2OlPul64Clv4Wv/50QoT9ihUrsi1kPQX0jPqnqBzf2Jm9q3FSuCS/Aynsc/MvZ3a0ZUophKg4/SpvNAt8Qx2DfJb3neWdG9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLY1kkgI; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-789e3f17a6eso164790885a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126371; x=1711731171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbNPugqeDmoqssGoWTn8SPKVapnb1hcd5ZsudgigNFk=;
        b=XLY1kkgIj8iY3ILqtiv4myLjJE7RD/nEojwcOJiJlcL4KFb60jSlkm803c1g/IVRI3
         m5A12yMS52J7G8NWE501OrukG8MzUD7KNSPTQeXh/B+luEAhHt3R5D0oJyj4OwmH0Pni
         sgnHKtqILvSbteW5gR6rwu5v5n40iK3ai8dbm3VI+y3oPsmf5UQWRkLTrXnKb9Qaf1uO
         W1yaWPXbFhOUu85z7AwjC8Sm0QKcJYGciUfamF5GGHvTcCuNc8ykrWbr7d5pafC6LBNX
         XZUjMFm89sOTsfYyMcQYhFByBpxo10HTNQbxI+NS0FZncy5BOpIemKe2avaVEnQu15Pq
         QQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126371; x=1711731171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rbNPugqeDmoqssGoWTn8SPKVapnb1hcd5ZsudgigNFk=;
        b=NteSN6/AtQK61SEU1SIePEAYRfiKW484XsYHhP4L98j2EG51pqBcJWd0dqBMrH5soH
         DGll8hQE6LhOSaAy7FJ0Si0OdXyaodg8rUzgv99QX2bJ+BC3rBNRTklYZlbrbO1fLBJ7
         2xYdEdOaUR58ptkIEqCs155oj0DZeLzWaRmRkkcyk+Ln35ECzUvfiePovLYQiByBkxa+
         /EhkRgs2FN5jwc1so+WOvTn0erJBwaeLM+j3+snJKLIBDqQVWU3+apF4YXAXDVQMLxQy
         h3AseP0bW7ahrSATZEogEmpuhw+ElEgt5CuK/jXfp5L4Y+QLlB4F2O0anYcgGnPUlWeY
         Y2ZA==
X-Gm-Message-State: AOJu0Yx+4EK6/Gg541W+qaOL5Fb4d3jAVJJZAYFuhir51JV8Khnoj2Uk
	SwnAEqv5md610hcjJIgWBMg6HWvZLx9pNNtIYgpMKBSHhw9ntQ4h8/eUBn0=
X-Google-Smtp-Source: AGHT+IFp9Qt9VzC4/JAJENgOHxRsYrn05WAatJAj6yqKGA84MaofhjDez1oAYNaaK2ot81K/pVO0tA==
X-Received: by 2002:a05:620a:210c:b0:78a:2945:8658 with SMTP id l12-20020a05620a210c00b0078a29458658mr2789389qkl.33.1711126371089;
        Fri, 22 Mar 2024 09:52:51 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:52:50 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 04/16] x86/pvh: Use fixed_percpu_data for early boot GSBASE
Date: Fri, 22 Mar 2024 12:52:21 -0400
Message-ID: <20240322165233.71698-5-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of having a private area for the stack canary, use
fixed_percpu_data for GSBASE like the native kernel.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/platform/pvh/head.S | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index f7235ef87bc3..1f1c3230b27b 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -95,10 +95,15 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	/* 64-bit entry point. */
 	.code64
 1:
-	/* Set base address in stack canary descriptor. */
+	/*
+	 * Set up GSBASE.
+	 * Note that, on SMP, the boot cpu uses init data section until
+	 * the per cpu areas are set up.
+	 */
 	mov $MSR_GS_BASE,%ecx
-	mov $_pa(canary), %eax
-	xor %edx, %edx
+	lea INIT_PER_CPU_VAR(fixed_percpu_data)(%rip), %rdx
+	mov %edx, %eax
+	shr $32, %rdx
 	wrmsr
 
 	call xen_prepare_pvh
@@ -157,8 +162,6 @@ SYM_DATA_START_LOCAL(gdt_start)
 SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
-
 SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
-- 
2.44.0


