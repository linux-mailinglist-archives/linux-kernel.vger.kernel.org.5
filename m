Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B717AA0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjIUU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjIUU4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:56:11 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AF6C06B5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c43e6ba8d1so10908555ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328424; x=1695933224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=ooFkuvOD+X01OBgJAJRWL8fBqVSu8Kag+d9BzvqrsOA=;
        b=V30WBHyn02jX7zrORwjVf/opgyfac0giuBab24z168ORR6RfjRU3+sdMlHIDUzp6+Q
         GEFaeOzRwqrZDztBXnfHO4WJ8PkuAwHRZinBGYE3zKGTKo2Fb+osioFKh6xktbut6JTT
         5ynF5OnJLijZqWSQWpzsG4qhYQ06o2LkcCz/Brn7eDPGdhiSzX1TBsIOHTlup6XkvLh/
         ZBlRZpGCWG2Uz2L+ElIrKAu/HXtFlQV8ZBxI7qUE/E/K1KLk38MMM4Pmn7yY9f1/j9x6
         OYiH9wJVoKsWGfHjMGWYDqyXeKIPoEzZ6StluXAYO+lY+Ryyo4Pr/UHTRWHDZ0xLmJyJ
         iaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328424; x=1695933224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ooFkuvOD+X01OBgJAJRWL8fBqVSu8Kag+d9BzvqrsOA=;
        b=lnmYcXHI8RjOe8JNCfO+gm24DjzIb+7HEZ2KfF/ztyectMq6ZghfurPFqBBGx99HbO
         +fdfkuZud2VQeABOhjVHzDcGRTV0k+epVm7pFLXsyERZaF+QpAIPrwhLyJ3eH/MNs6Wj
         zkmKjJGSSiU7lAfSqdbRLgutZNqJlH4n+GYm8pnWMYfMNTX2PxkwdjS7Lhs22JleksfM
         2VkPebj/PbS7IaFy2B2Qa6fOTL7blBmYWk3tssT+8aQcKgTcQnKipeL9ZJB3d3rQ/EMF
         /qm4/N5EuFCwHdk4xqUkOMLdkcHS8/DjZM9DlOib8nYB0E0HgUaDdmJmJFBO+jemb8Y8
         kNGQ==
X-Gm-Message-State: AOJu0YzpOYg4+0A42TnQ7fbGOqQVpSQtYUnpr4GwGW5Th6zaCbNwhabX
        4L9PxI9hKtH1jDkyWBoeV+r4KFmlK30=
X-Google-Smtp-Source: AGHT+IEU5m4YoGaLYARxz6CkyfsMJNbrUD8SUx5Ubkh7a53+UYT0k7pUszgIuGSWr5rg40lyfuo4qcQeNaM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5d2:b0:1bf:cc5:7b53 with SMTP id
 u18-20020a170902e5d200b001bf0cc57b53mr91087plf.1.1695328423673; Thu, 21 Sep
 2023 13:33:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:22 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-6-seanjc@google.com>
Subject: [PATCH 05/13] KVM: Fix MMU invalidation bookkeeping in guest_memfd
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acquire mmu_lock and do invalidate_{begin,end}() if and only if there is
at least one memslot that overlaps the to-be-invalidated range.  This
fixes a bug where KVM would leave a danging in-progress invalidation as
the begin() call was unconditional, but the end() was not (only performed
if there was overlap).

Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
Fixes: 1d46f95498c5 ("KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for guest-specific backing memory")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/guest_mem.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/guest_mem.c b/virt/kvm/guest_mem.c
index 3c9e83a596fe..68528e9cddd7 100644
--- a/virt/kvm/guest_mem.c
+++ b/virt/kvm/guest_mem.c
@@ -88,14 +88,10 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
 				      pgoff_t end)
 {
+	bool flush = false, found_memslot = false;
 	struct kvm_memory_slot *slot;
 	struct kvm *kvm = gmem->kvm;
 	unsigned long index;
-	bool flush = false;
-
-	KVM_MMU_LOCK(kvm);
-
-	kvm_mmu_invalidate_begin(kvm);
 
 	xa_for_each_range(&gmem->bindings, index, slot, start, end - 1) {
 		pgoff_t pgoff = slot->gmem.pgoff;
@@ -107,13 +103,21 @@ static void kvm_gmem_invalidate_begin(struct kvm_gmem *gmem, pgoff_t start,
 			.may_block = true,
 		};
 
+		if (!found_memslot) {
+			found_memslot = true;
+
+			KVM_MMU_LOCK(kvm);
+			kvm_mmu_invalidate_begin(kvm);
+		}
+
 		flush |= kvm_mmu_unmap_gfn_range(kvm, &gfn_range);
 	}
 
 	if (flush)
 		kvm_flush_remote_tlbs(kvm);
 
-	KVM_MMU_UNLOCK(kvm);
+	if (found_memslot)
+		KVM_MMU_UNLOCK(kvm);
 }
 
 static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
@@ -121,10 +125,11 @@ static void kvm_gmem_invalidate_end(struct kvm_gmem *gmem, pgoff_t start,
 {
 	struct kvm *kvm = gmem->kvm;
 
-	KVM_MMU_LOCK(kvm);
-	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT))
+	if (xa_find(&gmem->bindings, &start, end - 1, XA_PRESENT)) {
+		KVM_MMU_LOCK(kvm);
 		kvm_mmu_invalidate_end(kvm);
-	KVM_MMU_UNLOCK(kvm);
+		KVM_MMU_UNLOCK(kvm);
+	}
 }
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
-- 
2.42.0.515.g380fc7ccd1-goog

