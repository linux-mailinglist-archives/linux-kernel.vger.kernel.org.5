Return-Path: <linux-kernel+bounces-158501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA608B2154
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040C728906B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45C12BF22;
	Thu, 25 Apr 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mqh6DGJP"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500F12BE89
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046675; cv=none; b=nU5hBJOYsr6wVaoaTUPE5aHZa/qfSCIj+nTuAQQy4f2cXLN64Zzp97GmYw7dN4x/SZVj/82rHGlGNGMGRBE/G6Q6cYnzhD3Lj3LIVt2XxqIGUYKqcfMuY+CcK27vu/BbCZkeHCBwsb43Wlcehlenw2V7G6Qsz5usI6aAfXuO61U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046675; c=relaxed/simple;
	bh=xB/u3s8S3T1IKgqC6u8KUWKSRQdV5bZ5gXMpZZCOHLM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pZRWXaAsQdStVmYYJrDSy3i8mFkTbU7af4uRVCmpzs8UA5pdCtIOQzdU4HUUZd/x0UvU0PXRzCuYEFL/ebTvVfVrVAhdaBM7CqrU6Z4BFEPKQFCuBM17GAT6w3EizIRIa1sAgD5JIKJmGJQy6ibdUJHwQBNeurq9wiA8xTuq6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mqh6DGJP; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-416ac21981dso4727465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714046672; x=1714651472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8akamN8H2fCd/XiP05RGvYAImcl40m0IUyP0E7BzIt4=;
        b=Mqh6DGJPNhNdUZ+/K0fk6P5LFoTflkDWC2KgLYvyCdQgkrlTnjvLgaoo+of0jHJ0Im
         PmDsjdgj2RHlVARS3cQrvFVQ6uQlOBKc7GB5CQmJBcPB7O0KlEsFUiuxIqYIvqPOJF2C
         pkTbJKnM7BdO2grBrjVlPvOPWPC9DMfkolqcj+Lzn/qWcACGKAmIpfpCTbqwcubRS8Gm
         y4TiNg+AtMEgMtSFJVoeJAkjgDH7Zyo2JgZPdyKzPMahQvWL1cneRbdknkIuCt7DV/bZ
         as6KaphZWdeXnzCU3Gh0p0NKizTM8jthiHrj3CmomeqBP+9OUzl86nfSh2qNDWD6MVGE
         YBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714046672; x=1714651472;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8akamN8H2fCd/XiP05RGvYAImcl40m0IUyP0E7BzIt4=;
        b=KczY0v990ypTlWZZqvG503w0Dzl3dCfyRCz5e6n1jq76zaor6ZUxH6qUbJHWXrsMvl
         za4cHmxbFH/jPmrxdmP4fs6gJAPbevE+2E3Ejj2hhMkKGGV/+AqFXsZxfHYkD9TRC0c6
         ktbdzVRtPKKoWej6qBVU906VKvjFaZrRsdPSFrKUqgFTH2PH1jUk/QfjMwxzp91guzq3
         BiYmxr9W9Px6VHQl3gg2uttfrkBsh0aLSVoIgZdHgnH7iE0V7IqFvWZgjzAZKgKTKrqM
         ClRtwdrHwzTw02aJGfI3B83LJ9ApfVscKmn36buoaJAFEOKWRO+ISXzjKVgVluPvyQQx
         3qZw==
X-Gm-Message-State: AOJu0YzlMk8tpFvU7mrUK78e1PhFCJlGMxulNFrAVES6Kkgq458xlY0S
	PEuxhDSbTpshm6fpxkGxSV8fYWtvfVvJx8+g4jYriu/UzcqzoNSoPlLwVrcFr3P3keZpnBpUbgc
	Ej52lfD1674zZMguxXZcXwnLLoQSLCtVpg2qYmr+Mpj5saGCgDMWuK6RB0ljWNAQ4aCsY9CuomW
	GdRrUSQSGg9Zyj6mszGSBnyjgMbqeiwQ==
X-Google-Smtp-Source: AGHT+IEwrNhI7GuAN3Y2JJ0TMUZeshLaV6URxBToDvPomkFUhkeVhH495cxM086PyyIHuXg+E1eNG1Ga
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:600c:1d18:b0:418:f770:3216 with SMTP id
 l24-20020a05600c1d1800b00418f7703216mr61242wms.1.1714046671823; Thu, 25 Apr
 2024 05:04:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 14:04:18 +0200
In-Reply-To: <20240425120416.2041037-6-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240425120416.2041037-6-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=ardb@kernel.org;
 h=from:subject; bh=PvaxtPqIBzGmQAhUg+/lL22jj0S5lyyb5ES94EuVLJs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIU3L7VCTlrWZ2rkPjTtsfiz4vLaofPYVRvXPZv/rvZ6+S
 FN4l9zQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACay/jDDL+ZpsaueHvVItXsw
 92ZxWQLj4W4edZkPsc/uiWSsX7SA8x7D/8SV1w4UMjJ+vd9af7Eoyd7YSuOx5m3x7vfl0R9PyFa LMAIA
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240425120416.2041037-7-ardb+git@google.com>
Subject: [PATCH v2 1/4] x86/sev: Avoid WARN()s in early boot code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>
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
index 38ad066179d8..d18e10eaf839 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -720,7 +720,7 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		if (op == SNP_PAGE_STATE_SHARED) {
 			/* Page validation must be rescinded before changing to shared */
 			ret = pvalidate(vaddr, RMP_PG_SIZE_4K, false);
-			if (WARN(ret, "Failed to validate address 0x%lx ret %d", paddr, ret))
+			if (ret)
 				goto e_term;
 		}
 
@@ -733,21 +733,16 @@ early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 
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
 
@@ -780,7 +775,7 @@ void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long padd
 	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
 }
 
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+void __head early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
 					unsigned long npages)
 {
 	/*
-- 
2.44.0.769.g3c40516874-goog


