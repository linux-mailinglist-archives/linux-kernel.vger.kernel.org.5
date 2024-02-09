Return-Path: <linux-kernel+bounces-60107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A578184FFF0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B19B286B14
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81739AC3;
	Fri,  9 Feb 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4rSD36P0"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F538DFB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517749; cv=none; b=Rz+R5B4+UIIHd1+Ezs7A+T0Un0g/Q1d/9CKzoTMIrG/vMawWcrI2jCjQGZZ6osUMeUDDUN8JQCyf6gU0gklTV+ILVM8BGkLAFnkJVRcCuHcT2u7BCQV+jrvLKqeAjSRTfAjNR2hvQf/Vo9wzhwayInuQh0gXDSzN3Rl/WJ7bsRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517749; c=relaxed/simple;
	bh=MzdZYOJ8bcmLxbBzxayTEgk/rh3FciY0A5qDjUGjyCw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ntacnGQiG1ekRnE3tf3O3EuNeIe2Xth6isdswpLtDLHWcAxWvc+sbv0PQlDvC/6Ok0ODH5faNl1GfUVptgiB5/IpjwhRW5hUOXYTJUketMjSgZHSPWV4HAzhC/p4KmsZXqYFgoUby2Xz57srYGvkWujcDTqYZD/oIo1kjfS0++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4rSD36P0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604acd1d164so28997387b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707517746; x=1708122546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=a9w16DkYUKNtIq1BB7P1j7ef4bijSTE+8L2OPdx5r88=;
        b=4rSD36P0XAQFuAK/Nms2+vP/iKlh4jKw3co2K416l19tvRWVQfYeGHrwdHSTAhdK+V
         vGF9bF9x4tJqT2Fs/aqmNcVD0wXXTcDxm7laxOjZP7vNf3K/+EY/1JkAS/hEG8k2RgLa
         JHCZ9zLtIv7REH4uXprpSVNI0BoLlo6WxA/tQ7XEqSbQBBC7cyPybdbbWUkck9TiZv44
         h8Fz5VxXWXB4n9XVi+0mnMNelaXL/z2HNk60TcvyrGScblw4s2uLylza8BBd93AKCTQE
         4W/livcJRfn51On7TIWf2oyfMuCVPC6MIL7oUlONZAuCYCp+UsGJ3+qwPSTJ7NV+LLVy
         abhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707517746; x=1708122546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9w16DkYUKNtIq1BB7P1j7ef4bijSTE+8L2OPdx5r88=;
        b=R0oI4DM42f+Tud2U6PN9HDLDDxtDJEdHHaM4jQiARG36DyNesWRS2jBKWYGWMsSaNn
         tHaSb0L18aO2UZcnMCvM/nMFYmKWrVPW0OQs+Wqw9sRbY1LRNAwjJgQRFvOKOx5YNGNF
         sZ/V37EtwhUqI+3XuvjunL3uQ7hT8J5N2BbpXnGo0mCrUpCnZXEkGA1XW+mWqtH/ToEX
         g4m8VDWLoGD84Y6FimR/AL5Hl/ZLM4+2CK9j1iOChYJbhlXF7Trw1vn4nG9TTeR+NzWf
         KRQlqpRzBCrLCANsHyZP1O0O6elsaimnVj9U01ylZ8Axd2BtUJUixUdvuiiVN6395ZWP
         +NoQ==
X-Gm-Message-State: AOJu0YwOq+Hs+XripXVp7mlsG3YO7O+lskk98T+OaekYcH5LoxDca9X0
	MrBvuK0KwztRotj2XdyhDQD2AYdyz2la6nmIZNycfE5/YWJoP8t2eqJLYdjl1WBKYI/E/TCBiio
	bzw==
X-Google-Smtp-Source: AGHT+IGt9DDAWDOXh5rWqR7Wdjp1ZBHAe0u2NWCLrJsGzRUa6H3IIUWBVD5SKU6jmY1bLJzmP6LW2pBAIEA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:ec9:b0:604:648:6dc0 with SMTP id
 cs9-20020a05690c0ec900b0060406486dc0mr161009ywb.10.1707517746491; Fri, 09 Feb
 2024 14:29:06 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  9 Feb 2024 14:28:57 -0800
In-Reply-To: <20240209222858.396696-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209222858.396696-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209222858.396696-4-seanjc@google.com>
Subject: [PATCH v4 3/4] KVM: x86/mmu: Move slot checks from
 __kvm_faultin_pfn() to kvm_faultin_pfn()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Friedrich Weber <f.weber@proxmox.com>, 
	Kai Huang <kai.huang@intel.com>, Yuan Yao <yuan.yao@linux.intel.com>, 
	Xu Yilun <yilun.xu@linux.intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	Michael Roth <michael.roth@amd.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the checks related to the validity of an access to a memslot from the
inner __kvm_faultin_pfn() to its sole caller, kvm_faultin_pfn().  This
allows emulating accesses to the APIC access page, which don't need to
resolve a pfn, even if there is a relevant in-progress mmu_notifier
invalidation.  Ditto for accesses to KVM internal memslots from L2, which
KVM also treats as emulated MMIO.

More importantly, this will allow for future cleanup by having the
"no memslot" case bail from kvm_faultin_pfn() very early on.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 62 ++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 50bfaa53f3f2..505fc7eef533 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4333,33 +4333,6 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	struct kvm_memory_slot *slot = fault->slot;
 	bool async;
 
-	/*
-	 * Retry the page fault if the gfn hit a memslot that is being deleted
-	 * or moved.  This ensures any existing SPTEs for the old memslot will
-	 * be zapped before KVM inserts a new MMIO SPTE for the gfn.
-	 */
-	if (slot && (slot->flags & KVM_MEMSLOT_INVALID))
-		return RET_PF_RETRY;
-
-	if (!kvm_is_visible_memslot(slot)) {
-		/* Don't expose private memslots to L2. */
-		if (is_guest_mode(vcpu)) {
-			fault->slot = NULL;
-			fault->pfn = KVM_PFN_NOSLOT;
-			fault->map_writable = false;
-			return RET_PF_CONTINUE;
-		}
-		/*
-		 * If the APIC access page exists but is disabled, go directly
-		 * to emulation without caching the MMIO access or creating a
-		 * MMIO SPTE.  That way the cache doesn't need to be purged
-		 * when the AVIC is re-enabled.
-		 */
-		if (slot && slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT &&
-		    !kvm_apicv_activated(vcpu->kvm))
-			return RET_PF_EMULATE;
-	}
-
 	if (fault->is_private)
 		return kvm_faultin_pfn_private(vcpu, fault);
 
@@ -4406,6 +4379,37 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	fault->mmu_seq = vcpu->kvm->mmu_invalidate_seq;
 	smp_rmb();
 
+	if (!slot)
+		goto faultin_pfn;
+
+	/*
+	 * Retry the page fault if the gfn hit a memslot that is being deleted
+	 * or moved.  This ensures any existing SPTEs for the old memslot will
+	 * be zapped before KVM inserts a new MMIO SPTE for the gfn.
+	 */
+	if (slot->flags & KVM_MEMSLOT_INVALID)
+		return RET_PF_RETRY;
+
+	if (!kvm_is_visible_memslot(slot)) {
+		/* Don't expose KVM's internal memslots to L2. */
+		if (is_guest_mode(vcpu)) {
+			fault->slot = NULL;
+			fault->pfn = KVM_PFN_NOSLOT;
+			fault->map_writable = false;
+			return RET_PF_CONTINUE;
+		}
+
+		/*
+		 * If the APIC access page exists but is disabled, go directly
+		 * to emulation without caching the MMIO access or creating a
+		 * MMIO SPTE.  That way the cache doesn't need to be purged
+		 * when the AVIC is re-enabled.
+		 */
+		if (slot->id == APIC_ACCESS_PAGE_PRIVATE_MEMSLOT &&
+		    !kvm_apicv_activated(vcpu->kvm))
+			return RET_PF_EMULATE;
+	}
+
 	/*
 	 * Check for a relevant mmu_notifier invalidation event before getting
 	 * the pfn from the primary MMU, and before acquiring mmu_lock.
@@ -4427,10 +4431,10 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 	 * *guaranteed* to need to retry, i.e. waiting until mmu_lock is held
 	 * to detect retry guarantees the worst case latency for the vCPU.
 	 */
-	if (!slot &&
-	    mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn))
+	if (mmu_invalidate_retry_gfn_unsafe(vcpu->kvm, fault->mmu_seq, fault->gfn))
 		return RET_PF_RETRY;
 
+faultin_pfn:
 	ret = __kvm_faultin_pfn(vcpu, fault);
 	if (ret != RET_PF_CONTINUE)
 		return ret;
-- 
2.43.0.687.g38aa6559b0-goog


