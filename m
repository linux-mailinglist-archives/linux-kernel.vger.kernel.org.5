Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDAA7AA10E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjIUU5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjIUU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:57:19 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42FD663D9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c456e605easo11973775ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328430; x=1695933230; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=9mpd9iMp7FZTg5cux5Hx9q8PM9e8tiNEMrk/Ih+mEqk=;
        b=RHwf1XNWOhKlI43Qfk0o7cRJi92EbxHj9Itmb1+AumnyYqJ+CsIG2cw6vS568G7aWl
         Of2yLVO2tZTIn8+klQSXK58GnxplQoq8xEZk+176754KxxATHFRGt7nSbAnYgANbYEZ1
         UJBVnhHN4DOvnCHGIVQ+SrNd1SAnrW2Sv7xUfX2tuIXDs5e2K08vsbT/QcqhXcQhU/bc
         N6l4BA02tMdH1urLf321sE9RjAw0CzRBvuObA1XHvToTM8OTiWncgxLMzEHC1bAoBD7j
         f9CZ30i6dN2F1Yd4nnVISBayRragA4nnfACdeGVFGbN0IGFfLJ/9Ptcl6T+dCaqhBUAJ
         VuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328430; x=1695933230;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9mpd9iMp7FZTg5cux5Hx9q8PM9e8tiNEMrk/Ih+mEqk=;
        b=RXTiAmezT30129Yb9Veupa5vKC+/GS1gVv/UBSf0+/ojtAV0W4BB8ROVz12WL3yC7x
         15LeQnZnNXC14tZq+TQnoWZI2b5hMfAVczKh4lFemwdHNWOz0D87op19FiDrusG9Uze3
         Dp/mdnhukBLCAV/EouyJY48LIL4JQrdjECAPfYH6uv2qtPoRH3MdkEQpPpr/pzzFCu2c
         3Pm7RuYeLqy5v78Fc0A0sdmzSjJSyCBqvKPrfatVunM16Bc1JBSJMHfELP9LUaQ2krcO
         kujw0gUliRL3rAyUyD6svtG8hgd39zRo0n+rxLhMPyuTEAAodb8TnQBHUIEGqLOCLnmd
         Df9Q==
X-Gm-Message-State: AOJu0Yyhdd/H6Mf0CIB65j6oOWP6Bw3pselK0JpNngonjdQgs9h3MtjC
        hW49oBNPdx0YpPqcSr9Um6J4gktNG48=
X-Google-Smtp-Source: AGHT+IFLipqB61WXOOTnqiKbb8bDJkmz/woVY4xbUtfSVXedRobcUBhHek7BiWx82eS717I7/ce8FiF8A/s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f0ca:b0:1c3:4d70:6ed9 with SMTP id
 v10-20020a170902f0ca00b001c34d706ed9mr63048pla.3.1695328430166; Thu, 21 Sep
 2023 13:33:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:26 -0700
In-Reply-To: <20230921203331.3746712-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921203331.3746712-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-10-seanjc@google.com>
Subject: [PATCH 09/13] KVM: Always add relevant ranges to invalidation set
 when changing attributes
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting memory attributes, add all affected memslot ranges to the set
of invalidation ranges before calling into arch code.  Even if the change
in attributes doesn't strictly require zapping, it's not at all obvious
that letting arch code establish new mappings while the attributes are in
flux is safe and/or desirable.  Unconditionally adding ranges allows KVM
to keep its sanity check that at least one range is added between begin()
and end(), e.g. to guard against a missed add() call, without needing
complex code to condition the begin()/end() on arch behavior.

Fixes: 9a327182447a ("KVM: Introduce per-page memory attributes")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 277afeedd670..96fc609459e3 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2529,6 +2529,25 @@ static __always_inline void kvm_handle_gfn_range(struct kvm *kvm,
 		KVM_MMU_UNLOCK(kvm);
 }
 
+static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
+					  struct kvm_gfn_range *range)
+{
+	/*
+	 * Unconditionally add the range to the invalidation set, regardless of
+	 * whether or not the arch callback actually needs to zap SPTEs.  E.g.
+	 * if KVM supports RWX attributes in the future and the attributes are
+	 * going from R=>RW, zapping isn't strictly necessary.  Unconditionally
+	 * adding the range allows KVM to require that MMU invalidations add at
+	 * least one range between begin() and end(), e.g. allows KVM to detect
+	 * bugs where the add() is missed.  Rexlaing the rule *might* be safe,
+	 * but it's not obvious that allowing new mappings while the attributes
+	 * are in flux is desirable or worth the complexity.
+	 */
+	kvm_mmu_invalidate_range_add(kvm, range->start, range->end);
+
+	return kvm_arch_pre_set_memory_attributes(kvm, range);
+}
+
 /* Set @attributes for the gfn range [@start, @end). */
 static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long attributes)
@@ -2536,7 +2555,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
-		.handler = kvm_arch_pre_set_memory_attributes,
+		.handler = kvm_pre_set_memory_attributes,
 		.on_lock = kvm_mmu_invalidate_begin,
 		.flush_on_ret = true,
 		.may_block = true,
-- 
2.42.0.515.g380fc7ccd1-goog

