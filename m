Return-Path: <linux-kernel+bounces-43283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8678411BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E932888C6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8D06F06E;
	Mon, 29 Jan 2024 18:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbwiJPND"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1715B0F2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551570; cv=none; b=A1k5sqPFbf80CKEnCWZbxE2xCcFTavcfU0CDsfxzpQHnBbMCF75Ni9SFCUx3fJNfKUSW1MacOHcRbAl0nAdY4ZIJhp1NB9l3+Nc5hBBhF/dNaBb1A1LmOefZHJVpJcZH1uu/+8kr+qbmU8hTKGVepoRuw+tA3E9bYeool6Zx6tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551570; c=relaxed/simple;
	bh=hGhdgMicSLDQ/VaHKkAj5Vre9mOZCJGZnI0ycPa0ctU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3FtkDgtyL8ziuPTzbJIOGE1uaDsdrKdbNE2pLIDw+wiN8U1fKkqqX7/2l6vCMpG0xd6gf3sTwt56Axp4rWKln2iXhPfllQ3u5BA9V3FTnBhaOdpfmrqzE24miIjaZqnSP+cLzEQA/g0Z7SlHybS058v7yq7qDWFNxK8Q+yq//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbwiJPND; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffa2bb4810so34296907b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551568; x=1707156368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmdeW4/5l6h8clue2msSF5I8s+RaqVbElGLLzTfnIk=;
        b=XbwiJPNDWyHGc0IWoPOI2a1jWrHMXMQS1H/JWBiNiYH+ict5AV8k82cpOEu1tpYesX
         12KLaUwS8JU1bFVHdiHtVkT3bCCzxp+pfg5kuCAdCk+773zEVlcAdtuUUlN+vzO2k2O5
         3voCXta68R6WV5uQ784mD0UhhJg39VuC5AVjdzQTzwoOFFe95F9wzNfAlWFshxInDXQ5
         EG/45KSqnS1t8ltyl0mNIX9fSEJWp4BJEaKJNH5L5K7JloaRrV3LN5n3yw/1MeaLtOdA
         b1wurvtFRzczj2Q9q7AMtdNL10K14wZ0ixelo2twZbggzqamVE2LRV1ZQmfTb3/HJKcK
         sGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551568; x=1707156368;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OvmdeW4/5l6h8clue2msSF5I8s+RaqVbElGLLzTfnIk=;
        b=Sq9bie5Aw3TKvxpab0miYY+JVrn0UFAcxYLv7ozrJsKV5EvAyHTsyayFIdYatsi1px
         qg+/xu6e0WbjchukTIPEQBO0rD2RP0vfVZAliOfrqpDlquHOfqBiwQwlFLBxiXeZBoem
         tTjQnxh8Kei2E1z2lwWSXhZ1he17K2ni1BbfuAvfeUenf0Gs7jmStWV3RaH6ICpduJh+
         Ar1qD/YE+gymSHKYE0VmzubHj4MEa59DsZb76t1toeJ/gOHgrWsSLb3+ys5VWfbnLZdW
         bUmmveIS1h5lp3Ibk4wB+yDzxGt6ZqI5AdQDAOqRjC3A9A409Ij9F05pbOCWU32xiFvM
         D/JQ==
X-Gm-Message-State: AOJu0Yy1B1gxifGg4MtktwSCsCKJHd6xXRmdIivFtdnMQ/KMGOxiwzSX
	jlwYfaS3z/2bjf1MyAW9uanCBymETH2RSEUV/Wv1e+oTUlKNOxFdFhpSq/+xdykItLGyx948fkx
	7j3Vami75I+Sj1wjc/vXgd2gXmIT0PGf6AJnb1bIwBcTnhwmcN6sTyvuyAQrq4lAZh5fd2xtTBz
	gACpOik3VWehEUtZiZWLc+encUdOsrDQ==
X-Google-Smtp-Source: AGHT+IEvm5tXIhZK0iVzSFxmZq0xz25L/Fykdz68esiBebN0gmjK2KT5a1HMeCysY/4pBr4f9cq1K466
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:2206:b0:dc2:42fc:1366 with SMTP id
 dm6-20020a056902220600b00dc242fc1366mr424438ybb.9.1706551567626; Mon, 29 Jan
 2024 10:06:07 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:19 +0100
In-Reply-To: <20240129180502.4069817-21-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240129180502.4069817-21-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=ardb@kernel.org;
 h=from:subject; bh=BAMQXD8G5KJ2RAZEnRCY7V9ynmVKgA6YQxKkMkZhfsc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7iwd2nB82KC89l5dabni8zdb++Mqo/SUlzOIzelh7A
 tI2J/Z2lLIwiHEwyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgImckGb4Z9S36tFe1cvVWzbu
 ayl98UOoXKWc18nAMa1us+c8oyMr0xn++2XGVlQoGddc37R5goyOv+bk+2UVzxwrL7hu8HNk3C/ PAwA=
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-37-ardb+git@google.com>
Subject: [PATCH v3 16/19] x86/sev: Avoid WARN() in early code
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

Drop uses of WARN() from code that is reachable from the early primary
boot path which executes via the initial 1:1 mapping before the kernel
page tables are populated. This is unsafe and mostly pointless, given
that printk() does not actually work yet at this point.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/sev.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 62981b463b76..94bf054bbde3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -698,7 +698,7 @@ static void __pitext early_set_pages_state(unsigned long vaddr, unsigned long pa
 		if (op == SNP_PAGE_STATE_SHARED) {
 			/* Page validation must be rescinded before changing to shared */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -711,21 +711,16 @@ static void __pitext early_set_pages_state(unsigned long vaddr, unsigned long pa
 
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
 
-- 
2.43.0.429.g432eaa2c6b-goog


