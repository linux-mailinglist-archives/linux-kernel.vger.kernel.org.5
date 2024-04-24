Return-Path: <linux-kernel+bounces-157258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E71A8B0F27
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F5862961E7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C2216C87C;
	Wed, 24 Apr 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXc+S6GX"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BA16C437
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974027; cv=none; b=MgmYhpHzPw5G9dWGwsIBP0DuH4g5wYYA8a782lZ0Ami4vTQnRJVDKknZT7ZziWp5n07n9QJkMoV0unov8amLwbpgaoIpoWF/ZkFm293PBZXBnW2Brrayc9XW3q35V7BE0vbClJpi8SOELW7HEUvBvSLL5VgI/HnBYpzPXwWdUJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974027; c=relaxed/simple;
	bh=H2ocIIiAupI/NDpLV8KCMiyTbQqB8T6hYpeW8AU/k/8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EYC0Yf5A2fhD2+3eIL53wEBwGrN91MICYx3NYL4DGz2ALjNJ/U1a20/lrcbgF3kgYwwQ+JX1BaELCj3Gl1h2faL6aT29vVtI7Cg4mBdvRe8qFtG1CVcg2vB+GLpgzMoVsFegHpk7Kvjh0DE61Kmb+2SXzXasxr/KJ5IQQdSLxFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXc+S6GX; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-346b8ef7e10so4478412f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974024; x=1714578824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjdGmdFWunSakeQxhcxmHXUAnMO8coypY8ElDRJZN3Y=;
        b=EXc+S6GXXm4arhpyX9iJJgrLQKnQRzBYoOj1MZyfYCa8/ORhF6/7ZdeOSqScboTQK7
         y52Oes0/w5Xn5zTPThaJSL6HQBAyzZ98AvjX2CLyuEvMnZ/9rr0ClJX8c1CJIhK/5v9O
         zg+kDZ/94DjOM7Rdd/njit16arwt+5zwwpJoH73yeN7MBBn5E0bt5U/xLgHJGu4AW9eH
         F6SkkRFHYlmYQTJz4PEAQMIF0M39Bu+3mq8pbSwxFdvzInSbAIggQnqs/aoVz4NG0bTO
         HqA0TXAFrFiCfAGg5N5RzPVVE5DhfQjMY2RiroYecX+Abngfu6i1/2WKQgT9MW/PXu5s
         0UdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974024; x=1714578824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjdGmdFWunSakeQxhcxmHXUAnMO8coypY8ElDRJZN3Y=;
        b=An4P5tPqkzLjlcbg9xL6A8UbclvFPvkH2nO+Z4eGwhSkf89jajj1p9MH/CoiQ7eKhE
         hFohIG9pNwXKT6ZSfe6ueZi+IYCdGXuZWkvJSb2GI0ufY2LxiXPxHj/0uZM0iE1+sItb
         tZFmERy1ZsbQV8bvqlUqYHJn3Bn8ohh49NLIIHXOofoVcRKFDxg2mxIheCgLmOIyL3bc
         0TkEW/LH6l2EFTFWo5Pf+V5awkIUtdVvrRmIpb+cfpfC+IKqcSX9kcEI3d/liLLCiRJq
         OSXMjYEG+L11FJsiAlKHb7nDc9gAEGh0l9IdVTN+NNq34ojVX7Yoa/is2XDo6y2WqarU
         lk2A==
X-Gm-Message-State: AOJu0YxIM9sNYyiSv8xIH0+aOaMmWPteEeCp3M+vB7+oJi0eLU2dccK7
	H6/L8XYGFDu8EU5hFuDo5/9iqLoBKFhw1Sf/iyvliuKbc7uApXY5C3G/jnPnZTGJPfc6j39rY8B
	rf659158UFJzNoNh1c+hVB7zSDQdXYB9wtmZHh3j3p78JjMIdb6aOMNxDH9h9VaLXwYwMkQMY01
	Adtu9ZdrjkytIF7LI8nEhh51y+Lc8/+w==
X-Google-Smtp-Source: AGHT+IEn5r/4qBnC8xtfim3xmOpYM/A60T3wlnxZ2weMiVXGxLyNbc4Y6I4sKkBsnHH/JjZQDh3D0l4v
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a5d:50ce:0:b0:343:c41b:3e37 with SMTP id
 f14-20020a5d50ce000000b00343c41b3e37mr9280wrt.10.1713974024525; Wed, 24 Apr
 2024 08:53:44 -0700 (PDT)
Date: Wed, 24 Apr 2024 17:53:15 +0200
In-Reply-To: <20240424155309.1719454-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240424155309.1719454-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495; i=ardb@kernel.org;
 h=from:subject; bh=2RmgWaHe6lR2Ojq2O13NtFX0a3tx2m9Gxd1ampluXaw=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU1T63V+yN3dj+1yefbxClw7U8dWc36DtjWPV4Vvk3hy4
 rIoFtWOUhYGMQ4GWTFFFoHZf9/tPD1RqtZ5lizMHFYmkCEMXJwCMJF/Hxj+J1tPOL1Z+ZCU+OHW
 BUX5N72YqiKDmRXT9jrfLt2yzGyvPiPDKSv2rLCc1k8cUhqBbEFmB59k3/r8QWv9dnsRi6jqRUW 8AA==
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240424155309.1719454-16-ardb+git@google.com>
Subject: [RFC PATCH 5/9] x86/purgatory: Simplify GDT and drop data segment
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Data segment selectors are ignored in long mode so there is no point in
programming them. So clear them instead. This only leaves the code
segment entry in the GDT, which can be moved up a slot now that the
second slot is no longer used as the GDT descriptor.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/purgatory/entry64.S | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/purgatory/entry64.S b/arch/x86/purgatory/entry64.S
index 888661d9db9c..3d09781d4f9a 100644
--- a/arch/x86/purgatory/entry64.S
+++ b/arch/x86/purgatory/entry64.S
@@ -23,14 +23,14 @@ SYM_CODE_START(entry64)
 	addq	$10, %rsp
 
 	/* load the data segments */
-	movl    $0x18, %eax     /* data segment */
+	xorl    %eax, %eax     /* data segment */
 	movl    %eax, %ds
 	movl    %eax, %es
 	movl    %eax, %ss
 	movl    %eax, %fs
 	movl    %eax, %gs
 
-	pushq   $0x10 /* CS */
+	pushq   $0x8 /* CS */
 	leaq    new_cs_exit(%rip), %rax
 	pushq   %rax
 	lretq
@@ -84,16 +84,9 @@ SYM_DATA_END(entry64_regs)
 SYM_DATA_START_LOCAL(gdt)
 	/*
 	 * 0x00 unusable segment
-	 * 0x08 unused
-	 * so use them as gdt ptr
 	 */
-	.word 0
 	.quad 0
-	.word 0, 0, 0
 
-	/* 0x10 4GB flat code segment */
+	/* 0x8 4GB flat code segment */
 	.word 0xFFFF, 0x0000, 0x9A00, 0x00AF
-
-	/* 0x18 4GB flat data segment */
-	.word 0xFFFF, 0x0000, 0x9200, 0x00CF
 SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
-- 
2.44.0.769.g3c40516874-goog


