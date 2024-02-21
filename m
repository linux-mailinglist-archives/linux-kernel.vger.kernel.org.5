Return-Path: <linux-kernel+bounces-74228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6658B85D156
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9471C238A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41DB3D965;
	Wed, 21 Feb 2024 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DIxWWSNp"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D33C3D56E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500386; cv=none; b=GyaNsjvh29XbZylvKgQGlx7/utffG2TfO4jijeNziyAuUON5hMY385HpqyLWEgnJOhCcXDKbGtPH4bOQDGYTxeU6GniaWF3EJ1mKKzk8rV9hmwFMOzbHbNYiYrF1eonlLaFDpRhUse6njRQZSsxiyZ2UyWu2PH1xJ3PtRfDDr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500386; c=relaxed/simple;
	bh=M3SuqSqPQHRRDSx0L7lAp5b3EfogWfgqYBhfsqO8LBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya0hXheJJH/FkzskhGdvF/IdFsRAsTaqD04j8cz3YILyeEu9fbWY9UjGOT09QFo2NJSspuRjkl+k0sNyAcQdIyHAA01bn5uWQGh/jUV/uj0MZX3CXnxd1sxUTKkpHifNKdUoXB4Ecwfsa+tmW6kxnQsbEE1wM0yOLuGfFuUE/tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DIxWWSNp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e4560664b5so266242b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708500385; x=1709105185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pih8sW3nLr8uR7cM0/SKyhPbmHZuIiN96AmunLzN/Xw=;
        b=DIxWWSNperUegeHmk0cqBQZvMH9DSPkSmScAcv+5AMSuD/JESzqTXvCpwk8yChNPNv
         E1OehFTMW7afK5/kKA2fA77k7AKcqTgxQzG7OH2dpJE6x37F5DcEyaXVH/WFRhzJbpud
         N8+I4LLPrWvbG8jftCY0dx3iURAQEUHXAuNPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500385; x=1709105185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pih8sW3nLr8uR7cM0/SKyhPbmHZuIiN96AmunLzN/Xw=;
        b=N15ofql2FInv2Vaci83J6H06b+EXNNowrXIRBzLJ4z1yqRQ2HJxe1QFb0XGRhPZw4a
         C91pM1EjJaWrcmkGqBMGdwXRgMaDyvCxVNv5KMcwEw+yxz684zp1Q0pTZKGpTaef3VQg
         V8vnl7P5RGrwnAQ9Dg/IYy8gZAvIhEfShFH1HQIQarmmblQzc3wNnWE1Eu8pPonqHELU
         vpMpz2F0SmIZAnYVw+R5142STHOAPyMSP1DjkVcr1FFnxbL3D+RQ8hWtUIZSxoSAhsVp
         qyj5ajyPUlHsl8aS07uNONWvoxU08OMUIXVYkLgFSi78bi9CouocTZsKmxhEVPKlBYME
         oMyA==
X-Forwarded-Encrypted: i=1; AJvYcCW2ufqT4l2W3HlDgTvobjzNdDpWunKq5QX2KRerCqWIveJOsuSkhz7JhcQYeJ9Gs4tQlGchN2KQFjTujjUbED3eOUkPD9DvG01fzeFT
X-Gm-Message-State: AOJu0YzjoXtMDQG0m+DP+z6xz2WDuql/T6Z8Os3Rx+N3l3W+6grczKsO
	XkW0fBVZpcUbojOgKaccYO1qNmRV8uprMmSQcyfhSqU4sROMuPt2uO+XMSxlWA==
X-Google-Smtp-Source: AGHT+IHyypm/T0rwoWlLJexgzLRY5m4jjHnGc2zjD25rHsn1YoHjqJ8mJQow4Yfp2IIZNcTX4qemYQ==
X-Received: by 2002:aa7:81d1:0:b0:6e1:4a02:6217 with SMTP id c17-20020aa781d1000000b006e14a026217mr14102447pfn.22.1708500384849;
        Tue, 20 Feb 2024 23:26:24 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:b417:5d09:c226:a19c])
        by smtp.gmail.com with UTF8SMTPSA id v184-20020a6389c1000000b005bdbe9a597fsm7933795pgd.57.2024.02.20.23.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:26:24 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v10 6/8] KVM: x86: Migrate to __kvm_follow_pfn
Date: Wed, 21 Feb 2024 16:25:25 +0900
Message-ID: <20240221072528.2702048-8-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240221072528.2702048-1-stevensd@google.com>
References: <20240221072528.2702048-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Migrate functions which need access to is_refcounted_page to
__kvm_follow_pfn. The functions which need this are __kvm_faultin_pfn
and reexecute_instruction. The former requires replacing the async
in/out parameter with FOLL_NOWAIT parameter and the KVM_PFN_ERR_NEEDS_IO
return value. Handling non-refcounted pages is complicated, so it will
be done in a followup. The latter is a straightforward refactor.

APIC related callers do not need to migrate because KVM controls the
memslot, so it will always be regular memory. Prefetch related callers
do not need to be migrated because atomic gfn_to_pfn calls can never
make it to hva_to_pfn_remapped.

Signed-off-by: David Stevens <stevensd@chromium.org>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 43 ++++++++++++++++++++++++++++++++----------
 arch/x86/kvm/x86.c     | 11 +++++++++--
 virt/kvm/kvm_main.c    | 11 ++++-------
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2d6cdeab1f8a..bbeb0f6783d7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4331,7 +4331,14 @@ static int kvm_faultin_pfn_private(struct kvm_vcpu *vcpu,
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
-	bool async;
+	struct kvm_follow_pfn kfp = {
+		.slot = slot,
+		.gfn = fault->gfn,
+		.flags = FOLL_GET | (fault->write ? FOLL_WRITE : 0),
+		.try_map_writable = true,
+		.guarded_by_mmu_notifier = true,
+		.allow_non_refcounted_struct_page = false,
+	};
 
 	/*
 	 * Retry the page fault if the gfn hit a memslot that is being deleted
@@ -4368,12 +4375,20 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	if (fault->is_private)
 		return kvm_faultin_pfn_private(vcpu, fault);
 
-	async = false;
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
-	if (!async)
-		return RET_PF_CONTINUE; /* *pfn has correct page already */
+	kfp.flags |= FOLL_NOWAIT;
+	fault->pfn = kvm_follow_pfn(&kfp);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	/*
+	 * If kvm_follow_pfn() failed because I/O is needed to fault in the
+	 * page, then either set up an asynchronous #PF to do the I/O, or if
+	 * doing an async #PF isn't possible, retry kvm_follow_pfn() with
+	 * I/O allowed. All other failures are fatal, i.e. retrying won't help.
+	 */
+	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
+		return RET_PF_CONTINUE;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4391,9 +4406,17 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * to wait for IO.  Note, gup always bails if it is unable to quickly
 	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
 	 */
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, true, NULL,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
+	kfp.flags |= FOLL_INTERRUPTIBLE;
+	kfp.flags &= ~FOLL_NOWAIT;
+	fault->pfn = kvm_follow_pfn(&kfp);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	return RET_PF_CONTINUE;
+success:
+	fault->hva = kfp.hva;
+	fault->map_writable = kfp.writable;
 	return RET_PF_CONTINUE;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 363b1c080205..f4a20e9bc7a6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8747,6 +8747,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 {
 	gpa_t gpa = cr2_or_gpa;
 	kvm_pfn_t pfn;
+	struct kvm_follow_pfn kfp;
 
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
@@ -8776,7 +8777,13 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * retry instruction -> write #PF -> emulation fail -> retry
 	 * instruction -> ...
 	 */
-	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
+	kfp = (struct kvm_follow_pfn) {
+		.slot = gfn_to_memslot(vcpu->kvm, gpa_to_gfn(gpa)),
+		.gfn = gpa_to_gfn(gpa),
+		.flags = FOLL_GET | FOLL_WRITE,
+		.allow_non_refcounted_struct_page = true,
+	};
+	pfn = kvm_follow_pfn(&kfp);
 
 	/*
 	 * If the instruction failed on the error pfn, it can not be fixed,
@@ -8785,7 +8792,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (is_error_noslot_pfn(pfn))
 		return false;
 
-	kvm_release_pfn_clean(pfn);
+	kvm_release_page_clean(kfp.refcounted_page);
 
 	/* The instructions are well-emulated on direct mmu. */
 	if (vcpu->arch.mmu->root_role.direct) {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index e617fe5cac2e..5d66d841e775 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3297,6 +3297,9 @@ void kvm_release_page_clean(struct page *page)
 {
 	WARN_ON(is_error_page(page));
 
+	if (!page)
+		return;
+
 	kvm_set_page_accessed(page);
 	put_page(page);
 }
@@ -3304,16 +3307,10 @@ EXPORT_SYMBOL_GPL(kvm_release_page_clean);
 
 void kvm_release_pfn_clean(kvm_pfn_t pfn)
 {
-	struct page *page;
-
 	if (is_error_noslot_pfn(pfn))
 		return;
 
-	page = kvm_pfn_to_refcounted_page(pfn);
-	if (!page)
-		return;
-
-	kvm_release_page_clean(page);
+	kvm_release_page_clean(kvm_pfn_to_refcounted_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_release_pfn_clean);
 
-- 
2.44.0.rc0.258.g7320e95886-goog


