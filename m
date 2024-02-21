Return-Path: <linux-kernel+bounces-74634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C984D85D71E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835482838BE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011F145BF6;
	Wed, 21 Feb 2024 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysv8a2Xv"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6314C634
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515347; cv=none; b=P6XlCJjqZnYzzv9q6+mVUFHYU+2wrsBSWEVMrhBTwURHielBrUNKzQ6yEd2EUssnY/6JrA40onD91yDUmjc5Kk3dDO6j1TJr7FLSDDXL9Smb9FC5+6HDl/XeyHGGIi5sjOXC/WHmVJXtOryxf5biLqEZEfWlS0Cs4XL+gyO2Lx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515347; c=relaxed/simple;
	bh=6Y7B3eAU7WFGxIfJIx2em1X2j1KbkoJBGgvBRFQVJuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctCkypFDhxQBR4w+n8Y9dZDufkA4NCFvgBHqcs5cfsKv2DFZ2gWBh07LF+7lql5IiW5jvZdR7dWzGw7u0m5v22x6CdPAlk6964j77xeOMYtYZGZNq3QZ1NrJwJ2yDBPAX4jQ7/pVA/zVOQgWvR+vPSl0/vcIhWtaec522CgsI1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysv8a2Xv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6088a755299so4077387b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515345; x=1709120145; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0rqzUwS6BdxGjI3H1JUFmWLh2DB/nlQLPYKogLCLbB8=;
        b=ysv8a2XvMPZsZwkeZTnIkW8Dbj6ADJcYD6YqvfAITSGcBc13xHyDbI1xO6jTYs4Hre
         DNu2TS74LhzOWhjDEz3FvtS0eQ8k336xSXvbj2ucGOG6wrrgsZAhFKbRjJFO4HEYACEo
         MJJU7bowIeaScEJjDX0mY+iP5VcpFw/JH2hH0KxEJUlDplgBuRzERISP6eJkTYvMBO8O
         2yFjjlpWHViUzlN6/UYiN0/9dtQ++68Tt4CfEHqaTl1d92HDDjmIrMguX7BF5t1AR7bL
         pkvm1Gr5VpeFK5/9JD4KCWWWZ1Vy9PNWb+QpDSnG/Mxfdb/5w5W1HUXsj4fOvgTNhrIk
         J5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515345; x=1709120145;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0rqzUwS6BdxGjI3H1JUFmWLh2DB/nlQLPYKogLCLbB8=;
        b=jHw4pezBzsMpe7Nlm9RkSUbNPlpCC8cmFCy8HXwXKry1iEi/GipaK5reKl2b7hNRfU
         RRFLTzUhMKTAVnCssLKDwwIggrC8AptD6Gkm3+GzZgBUqQ+cPeUmbbrJFTMP26f7d/Lf
         5Koco5XmFJq5YPAzWVpzF08/lmi4wNMYSGiNz83nMIWBTTNHIlO61xrE/fKAnMLFaWgM
         rmH5qXlmhd0uMpwoxXdFYxM6wEvI7Fu69XB48kbFUh31x6yx6lnLpj+dakJ6PcLtvwnf
         Xj17l48uV0NV8RvGsLm2hYl++JyzrE8Nu40o90jmqOtLfweiEhu4f49BcvdqJcReezNl
         b7Zw==
X-Gm-Message-State: AOJu0Yw0bq42u8n+U8ijpYkZa0G4ohUha9N2KLkrWC+bDJigkJqZga1r
	NZHPJfflgkxi1edr7m9HaDCKp+Hiw8FDp/IrDiCd/8Wjc+lo3NvN5ZHF0mPwudx7elIEhqpJt8a
	DHss4yu6dBZ8USg6Q82Ki37SqSu1pjhTjxk8/kCaZcaQmSR2Bw//zWItecA9bQvK0RAS4Kc4gtQ
	Shv9653MeCMn00y7045hz5+6idEYYlIw==
X-Google-Smtp-Source: AGHT+IEwHju/X9vIeqhihYIRGISY1cX5Xt88mGLo3fj9jImWuJGJ1FfqScqrj4iTyDBujg+MUcvlGxTW
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a81:5748:0:b0:607:c418:33ba with SMTP id
 l69-20020a815748000000b00607c41833bamr4147129ywb.8.1708515344377; Wed, 21 Feb
 2024 03:35:44 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:11 +0100
In-Reply-To: <20240221113506.2565718-18-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221113506.2565718-18-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=ardb@kernel.org;
 h=from:subject; bh=e7Puh3E2XK1VJqqP8geKZexKLK94zY042KFjfKEULUs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/bd/VsVJTi+bPPmYuH9fB1t473PjspnToo1YUsxUq
 2rZ/8p1lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlcn8fwP59By9ztn+WWpIp/
 Ox3ZZ2pacQjfWxM61eabxvsZwdx2xxj+2ZrtjxF+psy/dvm6zgKZQ2ypEpVS2Y8L2oKWh7RmbCt kBgA=
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-22-ardb+git@google.com>
Subject: [PATCH v5 04/16] x86/startup_64: Use RIP_REL_REF() to access __supported_pte_mask
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

__supported_pte_mask is accessed from code that executes from a 1:1
mapping so it cannot use a plain access from C. Replace the use of
fixup_pointer() with RIP_REL_REF(), which is better and simpler.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/head64.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 2ac904110f6a..e2573ddae32f 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -177,7 +177,6 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	p4dval_t *p4d;
 	pudval_t *pud;
 	pmdval_t *pmd, pmd_entry;
-	pteval_t *mask_ptr;
 	bool la57;
 	int i;
 
@@ -259,8 +258,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	pmd_entry = __PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL;
 	/* Filter out unsupported __PAGE_KERNEL_* bits: */
-	mask_ptr = fixup_pointer(&__supported_pte_mask, physaddr);
-	pmd_entry &= *mask_ptr;
+	pmd_entry &= RIP_REL_REF(__supported_pte_mask);
 	pmd_entry += sme_get_me_mask();
 	pmd_entry +=  physaddr;
 
-- 
2.44.0.rc0.258.g7320e95886-goog


