Return-Path: <linux-kernel+bounces-155805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 480548AF761
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C740328FBED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919331420A8;
	Tue, 23 Apr 2024 19:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bejwwv9B"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732071411DE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900678; cv=none; b=OKBuDY97FpEw4OyvVIWF6pOJQr3X1aeBHr7Pq3Cgf+TTWkQQxhfLHvxWgP/D7XM5j3+NtlleO4y5PNdPsxwJuZEnBZ/K/qWknJpD8Yp4L8KTBQofD/vehd1YdKxvqcTtkDn0vnDrtjJSQ6h0UnEcqx/1ScpJWrr8aWipA3a786k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900678; c=relaxed/simple;
	bh=pX57Y6XlFKZYwd03wMkqJ+QIFxH0zXzVOyC6BvIPIOg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TBdT4eXq9yBDWbx4rlINRk2qFmA4Bf2H8EQKQAHvCj+06vwhDFyjKdsrqLKS48M5TSFc9WBCPwt5IhjrdsehtRnxZY+I2mCp9xQP/yqx/cRummRDw4SxwO+MN21nlSQVm7VqkgCBWy0VR93cJxTfPwuwFWrAQSmCDKPcPHsbvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bejwwv9B; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5dbddee3694so101256a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713900677; x=1714505477; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33HaUK27eQEsf0SwhUwMOu7mNxxUSSq/moN8WNrpJ54=;
        b=Bejwwv9BznF5OtcvXaZQuWkDtQV13RMrI0azYPJrNNfP+07DWv0M/sixTj+qSIuvE/
         IkJHNe74EanEiIPIs2VmcpnEfMwnfH/FM1PwK83Dwrmz1tuNlYlCZdaquwP21oBCRmFL
         KGwxKw5dFct6k9nikF1aox3GUVPa7ponAqb7DZG/S0V0rHRcEzHgH8rkJ6+giWUoG78q
         d1Ub8kbdfoqrVwohWP7PG0dGhsir0Xl1Q6+NklFrebVvxdPtvxz7LgLoNdbYPWQ0UIww
         OqL/2F2RlR220F3w37r0RU52V8aPKhpBl2Un9QKkvQs3+dkndxLMk8cy4tLucQlYxNGo
         gWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713900677; x=1714505477;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33HaUK27eQEsf0SwhUwMOu7mNxxUSSq/moN8WNrpJ54=;
        b=LBUCajHo8jkf2HMjNoyKqlxZTRvjp9LnGrau7QEI0M2oAxEDM2RxmKyz8PSWsdCfqL
         nGaorlu/H4Px1Bh1QSgs9YreGh1PZwQ0F9Iyck6gFGA3yHqPFixDKejQkR1hCQGEFSC5
         R8+o5yPV41PETneJWUF06gZd0wWh98imw3FVzwCgEjaqkwmEYHk7Q6j+nU+azZLTXGe9
         46kdQF7S/HIl2uzUDm3UjVF9zJmOYg4UC4z4N7l8Jo8FXNJc9y9p6T6hBesODVBo0w1U
         b5lljlSwkAc6suHLG745xCAv3jsLAx/LZOLtfMoqeKlDSFyBwC6wxdz2AMG21pKdOjgq
         J4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgQ/7Bo9gwuFw6UjI+9JQQMQjk8NNoDe2gkS7hESku63Umd/2myEtceAy2EgXgqKDQsSjzxWnsnF64rR3yZGPv5tyHn8mg2iEdTMLi
X-Gm-Message-State: AOJu0YwVklQBnmeB3KQdVBRcM7+LAzn9KenZCmrVhaNOxR1RpCeXNe85
	iuqQInsChaFQFmAIaZrL+oXOQoBBGbbLSBtbB58atGn6n4VfH9MLv7uXYCuz4tHH6pwTV4K6aSX
	MsQ==
X-Google-Smtp-Source: AGHT+IGajo1z1hyCxrLAaW0IAfe0Kram4cyrHU/I1JCRjlYjK5WQaguvtSBAlhl2K75/G/JqNjnZUC7hBMg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:fd8:b0:5dc:8880:57cb with SMTP id
 dr24-20020a056a020fd800b005dc888057cbmr2068pgb.3.1713900676660; Tue, 23 Apr
 2024 12:31:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 23 Apr 2024 12:31:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240423193114.2887673-1-seanjc@google.com>
Subject: [PATCH v3] KVM: x86/mmu: Fix a largely theoretical race in kvm_mmu_track_write()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add full memory barriers in kvm_mmu_track_write() and account_shadowed()
to plug a (very, very theoretical) race where kvm_mmu_track_write() could
miss a 0->1 transition of indirect_shadow_pages and fail to zap relevant,
*stale* SPTEs.

Without the barriers, because modern x86 CPUs allow (per the SDM):

  Reads may be reordered with older writes to different locations but not
  with older writes to the same location.

it's possible that the following could happen (terms of values being
visible/resolved):

 CPU0                          CPU1
 read memory[gfn] (=Y)
                               memory[gfn] Y=>X
                               read indirect_shadow_pages (=0)
 indirect_shadow_pages 0=>1

or conversely:

 CPU0                          CPU1
 indirect_shadow_pages 0=>1
                               read indirect_shadow_pages (=0)
 read memory[gfn] (=Y)
                               memory[gfn] Y=>X

E.g. in the below scenario, CPU0 could fail to zap SPTEs, and CPU1 could
fail to retry the faulting instruction, resulting in a KVM entering the
guest with a stale SPTE (map PTE=X instead of PTE=Y).

PTE = X;

CPU0:
    emulator_write_phys()
    PTE = Y
    kvm_page_track_write()
      kvm_mmu_track_write()
      // memory barrier missing here
      if (indirect_shadow_pages)
          zap();

CPU1:
   FNAME(page_fault)
     FNAME(walk_addr)
       FNAME(walk_addr_generic)
         gw->pte = PTE; // X

     FNAME(fetch)
       kvm_mmu_get_child_sp
         kvm_mmu_get_shadow_page
           __kvm_mmu_get_shadow_page
             kvm_mmu_alloc_shadow_page
               account_shadowed
                 indirect_shadow_pages++
                 // memory barrier missing here
       if (FNAME(gpte_changed)) // if (PTE == X)
           return RET_PF_RETRY;

In practice, this bug likely cannot be observed as both the 0=>1
transition and reordering of this scope are extremely rare occurrences.

Note, if the cost of the barrier (which is simply a locked ADD, see commit
450cbdd0125c ("locking/x86: Use LOCK ADD for smp_mb() instead of MFENCE")),
is problematic, KVM could avoid the barrier by bailing earlier if checking
kvm_memslots_have_rmaps() is false.  But the odds of the barrier being
problematic is extremely low, *and* the odds of the extra checks being
meaningfully faster overall is also low.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---

v3:
 - More explicitly show the race in code. [Paolo]
 - Insert the barrier *after* elevating indirect_shadow_pages. [Paolo]
 - More confidently state that there is indeed a race. [Paolo]

v2:
 - This patch was new in v2 (the other 3 got merged already).
 - https://lore.kernel.org/all/20240203002343.383056-5-seanjc@google.com

v1: https://lore.kernel.org/all/20230605004334.1930091-1-mizhang@google.com

 arch/x86/kvm/mmu/mmu.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 67331ce6454f..fea623e75cd1 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -831,6 +831,15 @@ static void account_shadowed(struct kvm *kvm, struct kvm_mmu_page *sp)
 	gfn_t gfn;
 
 	kvm->arch.indirect_shadow_pages++;
+	/*
+	 * Ensure indirect_shadow_pages is elevated prior to re-reading guest
+	 * child PTEs in FNAME(gpte_changed), i.e. guarantee either in-flight
+	 * emulated writes are visible before re-reading guest PTEs, or that
+	 * an emulated write will see the elevated count and acquire mmu_lock
+	 * to update SPTEs.  Pairs with the smp_mb() in kvm_mmu_track_write().
+	 */
+	smp_mb();
+
 	gfn = sp->gfn;
 	slots = kvm_memslots_for_spte_role(kvm, sp->role);
 	slot = __gfn_to_memslot(slots, gfn);
@@ -5807,10 +5816,15 @@ void kvm_mmu_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 	bool flush = false;
 
 	/*
-	 * If we don't have indirect shadow pages, it means no page is
-	 * write-protected, so we can exit simply.
+	 * When emulating guest writes, ensure the written value is visible to
+	 * any task that is handling page faults before checking whether or not
+	 * KVM is shadowing a guest PTE.  This ensures either KVM will create
+	 * the correct SPTE in the page fault handler, or this task will see
+	 * a non-zero indirect_shadow_pages.  Pairs with the smp_mb() in
+	 * account_shadowed().
 	 */
-	if (!READ_ONCE(vcpu->kvm->arch.indirect_shadow_pages))
+	smp_mb();
+	if (!vcpu->kvm->arch.indirect_shadow_pages)
 		return;
 
 	write_lock(&vcpu->kvm->mmu_lock);

base-commit: f10f3621ad80f008c218dbbc13a05c893766a7d2
-- 
2.44.0.769.g3c40516874-goog


