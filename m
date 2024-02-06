Return-Path: <linux-kernel+bounces-55247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7170984B9B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2039F281400
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F54134747;
	Tue,  6 Feb 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4hE3Pks"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418481332BC
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233651; cv=none; b=IZZZ/PORb1jEIEhoBVMX/gWyGtYoB+pWpLsHniwsrmJKDmuyh4OvQzIlQOILBDICoxHzrYNN8odtLFDWxRh6fdXn4t9QBI4fiEWKJYRX8ZKratbDabdNxXBmd+HybBaHGSxT+4mw0djzn9O4EkkdaPx/yNAy9SskAcwLIZ4+g7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233651; c=relaxed/simple;
	bh=djwHBFF/6b+JEsRyw/WpDuQJ81TX0FL0FrPWy97PCxU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JMaiLEFcKIl4o4Vqe68NPT5S3pcOyvSISZK0UseedvAPLyQCxxgNwZ/gvjFl/O0150vy/JejaRIOszo5w5N++HZX8I3SeLxS+3/g+klZCirPHAVRwpGwNleCox8kw60gjBa4LM8ZIJxQO9K0OURpJNio6goR4g+ymtGe/jKfNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4hE3Pks; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d9742bff20so6646235ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 07:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707233649; x=1707838449; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9JcuRLrkl5NZZWE8bXJY3ZHXnBfo6fG9Pt/Z+TQuz88=;
        b=E4hE3PksQ41EAJqXzSQgXKktSjTubQyrhUQKpKSp1sy5A/feuK7XHlDNm7a7GmReJs
         3FtKfcM2OkJqpE30SdJh/VEEQ8gG7uBscTotnmQWTlztbJRQFde8etLcFdWcQJcS/rid
         enpnhkC2rwM+td1X7ddW001kOkiMmYA5uf1zG7kgm+oUEexVS/wjx59vi4ofBE9H4Y6W
         7Hbgn/QM+3tVhNVEFyZmeMoZtO/uloekBjnW9SXUvSn+EfQgtYzI5K8e5r0RUWNuuHxS
         soRtzMy0Ihjv5s9qiefN7Gzj+sMMwtzQVcpkuHRHzkbiw5pUCF7w32lVoCfsSXNnlIYz
         xVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707233649; x=1707838449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9JcuRLrkl5NZZWE8bXJY3ZHXnBfo6fG9Pt/Z+TQuz88=;
        b=wuwJdbP1GzKzBtlVm5sGFjczn9E21fLRb912DSEn1TOpr782o2hcu59dKQ7CTxcomo
         hmGnNNUm989MoVRcAyueCkF70lSIE0vawHGQA+BPtpFfO0ulwOsjjmUrystL3rXBhJeZ
         Y3oqPxu0vzEiV7m/7Fi5cJFkqu7PbDAwyrIB+IxSSoCwtr75uFLWf0+Y2dedu+qXvvmX
         KUIAkHbWeqOPQauX7q4ZqKHpP0JlyijT0PsXZFDPSA/t3h6uAwLuRMIPsH/jj18OqGwm
         6MjL0/dW7Jjcv61QQyb8ebdurxSo6xQCTgl33Uor3F4pbiuEkmv987xRhjjx1Z3SjeXk
         Wqlg==
X-Gm-Message-State: AOJu0YwwmsRrmmUWjHCFQCDp11sIy7AurMYyBmt0+1U2CLphLx6eUWcE
	SbUJijWEaf/NU50dgC7qw33alHLMuVwfYpQrTgkpA2eP4T8WxquH/Z6OcGezYIhcsgb0q18Gw6t
	log==
X-Google-Smtp-Source: AGHT+IGnVe8/AUYKWmmNmbjqGjxjNUoELEKOek2cIdx4iS37voI2OGUByDeYLeoszBKZ90KF5ix5pUAeSGw=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:34a4:546d:dbbd:8cab])
 (user=avagin job=sendgmr) by 2002:a17:903:1cd:b0:1d9:3f82:497d with SMTP id
 e13-20020a17090301cd00b001d93f82497dmr71878plh.1.1707233649437; Tue, 06 Feb
 2024 07:34:09 -0800 (PST)
Date: Tue,  6 Feb 2024 07:34:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206153405.489531-1-avagin@google.com>
Subject: [PATCH v2] kvm/x86: allocate the write-tracking metadata on-demand
From: Andrei Vagin <avagin@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	Andrei Vagin <avagin@google.com>, Zhenyu Wang <zhenyuw@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

The write-track is used externally only by the gpu/drm/i915 driver.
Currently, it is always enabled, if a kernel has been compiled with this
driver.

Enabling the write-track mechanism adds a two-byte overhead per page across
all memory slots. It isn't significant for regular VMs. However in gVisor,
where the entire process virtual address space is mapped into the VM, even
with a 39-bit address space, the overhead amounts to 256MB.

This change rework the write-tracking mechanism to enable it on-demand
in kvm_page_track_register_notifier.

Here is Sean's comment about the locking scheme:

The only potential hiccup would be if taking slots_arch_lock would
deadlock, but it should be impossible for slots_arch_lock to be taken in
any other path that involves VFIO and/or KVMGT *and* can be coincident.
Except for kvm_arch_destroy_vm() (which deletes KVM's internal
memslots), slots_arch_lock is taken only through KVM ioctls(), and the
caller of kvm_page_track_register_notifier() *must* hold a reference to
the VM.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
v1: https://lore.kernel.org/lkml/ZcErs9rPqT09nNge@google.com/T/
v2: allocate the write-tracking metadata on-demand

 arch/x86/include/asm/kvm_host.h |  2 +
 arch/x86/kvm/mmu/mmu.c          | 24 +++++------
 arch/x86/kvm/mmu/page_track.c   | 74 ++++++++++++++++++++++++++++-----
 arch/x86/kvm/mmu/page_track.h   |  3 +-
 4 files changed, 78 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d271ba20a0b2..c35641add93c 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1503,6 +1503,8 @@ struct kvm_arch {
 	 */
 #define SPLIT_DESC_CACHE_MIN_NR_OBJECTS (SPTE_ENT_PER_PAGE + 1)
 	struct kvm_mmu_memory_cache split_desc_cache;
+
+	bool page_write_tracking_enabled;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2d6cdeab1f8a..e45fca3156de 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3755,29 +3755,29 @@ static int mmu_first_shadow_root_alloc(struct kvm *kvm)
 	 * Check if anything actually needs to be allocated, e.g. all metadata
 	 * will be allocated upfront if TDP is disabled.
 	 */
-	if (kvm_memslots_have_rmaps(kvm) &&
-	    kvm_page_track_write_tracking_enabled(kvm))
+	r = kvm_page_track_write_tracking_enable(kvm);
+	if (r)
+		goto out_unlock;
+
+	if (kvm_memslots_have_rmaps(kvm))
 		goto out_success;
 
 	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
 		slots = __kvm_memslots(kvm, i);
 		kvm_for_each_memslot(slot, bkt, slots) {
 			/*
-			 * Both of these functions are no-ops if the target is
-			 * already allocated, so unconditionally calling both
-			 * is safe.  Intentionally do NOT free allocations on
-			 * failure to avoid having to track which allocations
-			 * were made now versus when the memslot was created.
-			 * The metadata is guaranteed to be freed when the slot
-			 * is freed, and will be kept/used if userspace retries
+			 * This function is no-ops if the target is already
+			 * allocated, so unconditionally calling it is safe.
+			 * Intentionally do NOT free allocations on failure to
+			 * avoid having to track which allocations were made
+			 * now versus when the memslot was created.  The
+			 * metadata is guaranteed to be freed when the slot is
+			 * freed, and will be kept/used if userspace retries
 			 * KVM_RUN instead of killing the VM.
 			 */
 			r = memslot_rmap_alloc(slot, slot->npages);
 			if (r)
 				goto out_unlock;
-			r = kvm_page_track_write_tracking_alloc(slot);
-			if (r)
-				goto out_unlock;
 		}
 	}
 
diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index c87da11f3a04..a4790b0a6f50 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -20,10 +20,14 @@
 #include "mmu_internal.h"
 #include "page_track.h"
 
-bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)
+static bool kvm_page_track_write_tracking_enabled(struct kvm *kvm)
 {
-	return IS_ENABLED(CONFIG_KVM_EXTERNAL_WRITE_TRACKING) ||
-	       !tdp_enabled || kvm_shadow_root_allocated(kvm);
+	/*
+	 * Read page_write_tracking_enabled before related pointers. Pairs with
+	 * smp_store_release in kvm_page_track_write_tracking_enable.
+	 */
+	return smp_load_acquire(&kvm->arch.page_write_tracking_enabled) |
+	       !tdp_enabled;
 }
 
 void kvm_page_track_free_memslot(struct kvm_memory_slot *slot)
@@ -32,8 +36,8 @@ void kvm_page_track_free_memslot(struct kvm_memory_slot *slot)
 	slot->arch.gfn_write_track = NULL;
 }
 
-static int __kvm_page_track_write_tracking_alloc(struct kvm_memory_slot *slot,
-						 unsigned long npages)
+static int __kvm_write_tracking_alloc(struct kvm_memory_slot *slot,
+				      unsigned long npages)
 {
 	const size_t size = sizeof(*slot->arch.gfn_write_track);
 
@@ -51,12 +55,7 @@ int kvm_page_track_create_memslot(struct kvm *kvm,
 	if (!kvm_page_track_write_tracking_enabled(kvm))
 		return 0;
 
-	return __kvm_page_track_write_tracking_alloc(slot, npages);
-}
-
-int kvm_page_track_write_tracking_alloc(struct kvm_memory_slot *slot)
-{
-	return __kvm_page_track_write_tracking_alloc(slot, slot->npages);
+	return __kvm_write_tracking_alloc(slot, npages);
 }
 
 static void update_gfn_write_track(struct kvm_memory_slot *slot, gfn_t gfn,
@@ -153,6 +152,50 @@ int kvm_page_track_init(struct kvm *kvm)
 	return init_srcu_struct(&head->track_srcu);
 }
 
+/*
+ * kvm_page_track_write_tracking_enable enables the write tracking mechanism.
+ * If it has been already enabled, this function is no-op.
+ *
+ * The caller must hold kvm->slots_arch_lock.
+ */
+int kvm_page_track_write_tracking_enable(struct kvm *kvm)
+{
+	struct kvm_memslots *slots;
+	struct kvm_memory_slot *slot;
+	int r = 0, i, bkt;
+
+	lockdep_assert_held(&kvm->slots_arch_lock);
+
+	if (kvm_page_track_write_tracking_enabled(kvm))
+		return 0;
+
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		slots = __kvm_memslots(kvm, i);
+		kvm_for_each_memslot(slot, bkt, slots) {
+			/*
+			 * This function is no-ops if the target is already
+			 * allocated, so unconditionally calling it is safe.
+			 * Intentionally do NOT free allocations on failure to
+			 * avoid having to track which allocations were made
+			 * now versus when the memslot was created.  The
+			 * metadata is guaranteed to be freed when the slot is
+			 * freed, and will be kept/used if userspace retries
+			 * KVM_RUN instead of killing the VM.
+			 */
+			r = __kvm_write_tracking_alloc(slot, slot->npages);
+			if (r)
+				goto err;
+		}
+	}
+	/*
+	 * Ensure that page_write_tracking_enabled becomes true strictly after
+	 * all the related pointers are set.
+	 */
+	smp_store_release(&kvm->arch.page_write_tracking_enabled, true);
+err:
+	return r;
+}
+
 /*
  * register the notifier so that event interception for the tracked guest
  * pages can be received.
@@ -161,12 +204,21 @@ int kvm_page_track_register_notifier(struct kvm *kvm,
 				     struct kvm_page_track_notifier_node *n)
 {
 	struct kvm_page_track_notifier_head *head;
+	int r;
 
 	if (!kvm || kvm->mm != current->mm)
 		return -ESRCH;
 
 	kvm_get_kvm(kvm);
 
+	mutex_lock(&kvm->slots_arch_lock);
+	r = kvm_page_track_write_tracking_enable(kvm);
+	mutex_unlock(&kvm->slots_arch_lock);
+	if (r) {
+		kvm_put_kvm(kvm);
+		return r;
+	}
+
 	head = &kvm->arch.track_notifier_head;
 
 	write_lock(&kvm->mmu_lock);
diff --git a/arch/x86/kvm/mmu/page_track.h b/arch/x86/kvm/mmu/page_track.h
index d4d72ed999b1..f8984d163b2c 100644
--- a/arch/x86/kvm/mmu/page_track.h
+++ b/arch/x86/kvm/mmu/page_track.h
@@ -7,8 +7,7 @@
 #include <asm/kvm_page_track.h>
 
 
-bool kvm_page_track_write_tracking_enabled(struct kvm *kvm);
-int kvm_page_track_write_tracking_alloc(struct kvm_memory_slot *slot);
+int kvm_page_track_write_tracking_enable(struct kvm *kvm);
 
 void kvm_page_track_free_memslot(struct kvm_memory_slot *slot);
 int kvm_page_track_create_memslot(struct kvm *kvm,
-- 
2.43.0.594.gd9cf4e227d-goog


