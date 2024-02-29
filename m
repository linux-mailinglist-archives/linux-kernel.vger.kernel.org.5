Return-Path: <linux-kernel+bounces-86070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C045986BF34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76229286201
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7802B44374;
	Thu, 29 Feb 2024 02:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMgLyVET"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6773041E4E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709175517; cv=none; b=FmfyUBtaEH8ZsKNRNIXqi8yWP3D2Flzth/egda5h3ydC9/VgDNZph2QFny9c5WMD7T/WNYvJgZPMJ5kY1qPw7OE14uY/BCeBHTabQx164TzgqXpxZMRRcdnKYgu2xnvICgghLELIsqQZV1JuScJFP4yFfyaMQYfR4zFaKWK/xGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709175517; c=relaxed/simple;
	bh=UIJzBxDI/Inn6eJziAqaeOpmUvLyyhxfpWjO2dCmE1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJJuXJc2pmJJspq+CveRvmU+9PuA4UvKtqLw290Py2NAOelHS2IHacFv+lHDCJYUsiKFJPfafBhkaQRodMaTi5cvUAP2I3xj7wsf4Z19tDAzlnMs4JCkenCbjAjN36ovc0W0fhbi12v2T8TJA0MOHKm+ruOtmJcLtvAFtGIAMwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iMgLyVET; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c1a172e46bso278921b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709175514; x=1709780314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rjuEwew1c9XXdIDCEsgjgWaQEbnELox0pWUx+WG8IvI=;
        b=iMgLyVETxWC8KRYKo/7f74QL9LDcZBAMlVPkBKvtTNYj/ZL14ZW7CKnWrEJVkO1PKA
         mBcVirTjXDxpOt84VuuDZLrF/Z3h5ayEsGwJvGsfhp0e9xPGn9eNwv7r2Kovve3L+KVF
         odJU3QEC08tnBddJm/oQYWU46oyOvELb6P/jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709175514; x=1709780314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rjuEwew1c9XXdIDCEsgjgWaQEbnELox0pWUx+WG8IvI=;
        b=WYNsuz0SNnKzH1buapCh8YPe5x0DjrceEhMh60nJz3RqZZsC3mYIGcmt0UuFsAgS5N
         nJ8gpa8yCiPkOt6fe/FUqgxpptMkeeHgnHuq+DisaDL/+R8k4o7OYUXL51I9igmvjSaK
         dPMT5HQfEQTRjA79b6KOGTb2owI9rczxv13WcHIhNOIz9LoKboJh/1eVH0OVa8w1JSVp
         sDxFhYI0KbuNuTfyMWlHIUzsT2pLlHBfW/MRokEx7fmv0jLRHkYlxcM6TIZXffKP+Ihr
         soAJe4nEK2YCjs9/4fcqseWFLyvGjjBGOS35VMeWt7cLgJcpHpy+SKtQg29PBot3nGOo
         ppEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAnnFbK2uHJAcQN8js+kzMwuijhUMYksxSKmUpp1UFpkytsffe8FF/VauUcWsAbpMbs56F3YPwxvm8lbROoAdYnVVLzZsGlfR4VKKX
X-Gm-Message-State: AOJu0YzbLEgKxpFMfuct5RDnzkrkbUc3bIM2rB243THkcWQCzib3p/7J
	8ynqrBp+fttUwxd3idF8wzb2SchdhCDzS2p0rPiOeSBDh9cvUvEYZYhCR1AW9UbqnZzGvmaQZqQ
	=
X-Google-Smtp-Source: AGHT+IHv5f1wWy5Mteh5mYoqzd0nZksGuXKcqFrO3o6Kt/eptOM26RonYJOAOu65xJX16drRYjcd3w==
X-Received: by 2002:a05:6808:2196:b0:3c1:acc3:99ce with SMTP id be22-20020a056808219600b003c1acc399cemr1050071oib.37.1709175514558;
        Wed, 28 Feb 2024 18:58:34 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f51:e79e:9056:77ea])
        by smtp.gmail.com with UTF8SMTPSA id e25-20020a62aa19000000b006e45dce37basm153830pff.220.2024.02.28.18.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 18:58:34 -0800 (PST)
From: David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Yu Zhang <yu.c.zhang@linux.intel.com>,
	Isaku Yamahata <isaku.yamahata@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	David Stevens <stevensd@chromium.org>
Subject: [PATCH v11 6/8] KVM: x86: Migrate to kvm_follow_pfn()
Date: Thu, 29 Feb 2024 11:57:57 +0900
Message-ID: <20240229025759.1187910-7-stevensd@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240229025759.1187910-1-stevensd@google.com>
References: <20240229025759.1187910-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Stevens <stevensd@chromium.org>

Migrate functions which need to be able to map non-refcounted struct
pages to kvm_follow_pfn(). These functions are kvm_faultin_pfn() and
reexecute_instruction(). The former requires replacing the async in/out
parameter with FOLL_NOWAIT parameter and the KVM_PFN_ERR_NEEDS_IO return
value (actually handling non-refcounted pages is complicated, so it will
be done in a followup). The latter is a straightforward refactor.

APIC related callers do not need to migrate because KVM controls the
memslot, so it will always be regular memory. Prefetch related callers
do not need to be migrated because atomic gfn_to_pfn() calls can never
make it to hva_to_pfn_remapped().

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
index 17bf9fd6774e..24e2269339cb 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3293,6 +3293,9 @@ void kvm_release_page_clean(struct page *page)
 {
 	WARN_ON(is_error_page(page));
 
+	if (!page)
+		return;
+
 	kvm_set_page_accessed(page);
 	put_page(page);
 }
@@ -3300,16 +3303,10 @@ EXPORT_SYMBOL_GPL(kvm_release_page_clean);
 
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
2.44.0.rc1.240.g4c46232300-goog


