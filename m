Return-Path: <linux-kernel+bounces-95735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D328751E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBE71C2197D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE76741C65;
	Thu,  7 Mar 2024 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X9XT+5a+"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682AB1DFEB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821842; cv=none; b=KZAbDWeo/kBERTdJxsQucKivQW4w9PKEoGvJwrDpdQDPDJSObMqIJT6Pf8ldUQOyRN5nmuvLlr2E21BeED3VTHJR4n+qS4hGo8FgNEo6lANP18UTExxek8Kusr1dqAwDpk3vT9gQQulTDQI4RqJ6i1/3uqNis3LJB19bOMsJTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821842; c=relaxed/simple;
	bh=jVZK3aryMlr09Y5jE4GZCu3fLG5lIA56rDW2gL8ygAQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RFWGxsaBCf2CEp7A1syUWAD8Z2yjkuwGMJUV/Ot82dZvU+Y3u/T3W+ls5T3h3BzZdNCk8ixD1TNaLGxhuObfo+V/bWvMk/msQOvXcDrSE0Ts2KsBRFaaye8bvnT7kTV+Zu2BB2wDGI1VAQd8R/popPxnHDbdC3LL/XpLNOYvOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X9XT+5a+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-412de139895so10100575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 06:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709821839; x=1710426639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8P1mBSrOoIVSHEGheJp8MwxcULnyxkEnlFR21hL/im4=;
        b=X9XT+5a+aFrkz7aQxfyG9aMokKYRkFrsnVElG3iSjxCFg/zupfoySFhbvvr9JgudL+
         ziS3D584t1XJMJsfHjhVU3BW49pkFrqAA09KyN7YkM08iO4+1ZE2Y/GvtKVEzghnbIuU
         hnkgnUO4k8Pmxirn6eJPFm3WUNz4/ip56SGOcwdc573u3LhiJgygBzRlHtmmvl+B4aOq
         HBaHLO8I7VFYKSMz7h0j8+NB9glc2a4zaOu/kHv0ysTwk7yBO/btWI9O3KhDg6NLj1tJ
         L1qiyyan+Z4p9ZXU2SuYTm4I640D1KSkzX7Snj8FKYQjyJSCVeOCC+7+ZEy+fohMfsy/
         CmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709821839; x=1710426639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8P1mBSrOoIVSHEGheJp8MwxcULnyxkEnlFR21hL/im4=;
        b=Do5UY8gnFEmy4nrK7JQo/mdD5iQBsl75iIG81T11EUbpdfbnzlLtQL8zU4VTwXehr1
         jglUAR+UI67pUuUHbWS7vLNZnIpB/WfTP1virWsFf7hM5pxUlAdB7k7jTt2HgEHsZmWK
         7AMPggW44zSN1g7i3D7LjJmRKQf96A2Z0fZ06qFceGkzTI+dzgMe1uhRze2OsSeUBL07
         hh8YWueG+PAt43kdvIoo69e4Z9BOde4S558FtXG+RJSPsTkpJKjksx+vR0t73fjlcXmJ
         /UTV/HCGdUkzeGYCDz+hGHY6Y183omXBo+aXFI3RO3AtubeuIrF1EFe2N/qYEV4bqthf
         MJOA==
X-Forwarded-Encrypted: i=1; AJvYcCXlRHRK31gOVAbjPUYQpDUNV7j2kkDqAau+CU+AA2q/39Thh829qrA0pjr/U0dLqSIB62zQ10NzF/mAJF0nX7oCPcctknLJb3vpyeG5
X-Gm-Message-State: AOJu0YwOhSgH0aigH6p2Kjf9svXIS2d18psHde7KZo2stXdaTeNubo+5
	IA4S371kfDEtVntqImJ1JWlOij858Z6xApseemY61aZXHMKk46eld4kt3dwVlhnTMYFd0Q==
X-Google-Smtp-Source: AGHT+IHBAP8nZR+LI55py+Enj+t1KGe7SiGRIR4gN5obS3gdpi362iGNd0ZKBFPGq0+jQGXK43y5j5l6
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:3399:b0:413:7d2:8083 with SMTP id
 o25-20020a05600c339900b0041307d28083mr11532wmp.4.1709821838673; Thu, 07 Mar
 2024 06:30:38 -0800 (PST)
Date: Thu,  7 Mar 2024 15:30:29 +0100
In-Reply-To: <20240307143027.206179-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307143027.206179-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=ardb@kernel.org;
 h=from:subject; bh=gVi3s0MJcgql3dMa58qEjYPoBJuuf1L0R/DsGieHEDs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXl+dYM9Rwlt5tbV+nwWna8jEoM8RVduHeZgrEwb/DSR
 ff7/37oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZFMfIcHHPUu01n7h14u/5
 GbRtSt++yFf65rfp/2LLbX/UpZVX1jEydGttssucMF+qyC9h6/Oj/qfz2ba5WF1+XS9mvuCL4eX HLAA=
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307143027.206179-7-ardb+git@google.com>
Subject: [RFC PATCH v6.10 1/4] x86/sev: Avoid WARN()s in early boot code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@google.com
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Using WARN() before the kernel is even mapped is unlikely to do anything
useful: the string literals are passed using their kernel virtual
addresses which are not even mapped yet. But even if they were, calling
into the printk machinery from the early 1:1 mapped code is not going to
get very far.

So drop the WARN()s entirely.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 33c14aa1f06c..fc1b7b331815 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -700,7 +700,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		if (op == SNP_PAGE_STATE_SHARED) {
 			/* Page validation must be rescinded before changing to shared */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -713,21 +713,16 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 
 		val = sev_es_rd_ghcb_msr();
 
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
+		if (GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP)
 			goto e_term;
 
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+		if (GHCB_MSR_PSC_RESP_VAL(val))
 			goto e_term;
 
 		if (op == SNP_PAGE_STATE_PRIVATE) {
 			/* Page validation must be performed after changing to private */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, true);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -760,7 +755,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
-- 
2.44.0.278.ge034bb2e1d-goog


