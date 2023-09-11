Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AFB79A134
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjIKCSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjIKCR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:17:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99D10CA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:17:15 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c0a42a469dso2765221a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694398627; x=1695003427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUMMszyUeB8rBOIlzKvaWgoejhjaS1Q5X7ygUgKYL7o=;
        b=MHcv5bWJiXCkl/D4jVPSQS5ACW4awitYOVwdMY9IK4b9lRQEtvvBWt4NKADegwtt0v
         QADeq793DwQYt1AvSmqRQWV4kiR/sOumC3g0/KO3e0s91bLG41Wrov6sYxvIlZowq0Z6
         +6z38FQUhGVl+QECzHa5REOsA6mZ2DQImUjqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694398627; x=1695003427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUMMszyUeB8rBOIlzKvaWgoejhjaS1Q5X7ygUgKYL7o=;
        b=o80ng3cniYkYnvLnWlXYrNsyd/MoGGEECohnPyaFB3p7Y/tkK0fReQMTpK4Z3QCANg
         h+Mx+ac66AYu8NPbnyFC9nJC5pPK01x50DPkw9Jx+YmlDHNm7bjDP2EANO74fouzp7AC
         abqTv2paIyDMoHpmxPB3/an7Pz5gy+u5rHBbnQ4vzw6Yfc/gc5e/X5YwvAMbSfjACXmW
         pR+xyE4jdg5+G6iOJ/S9R23ug8PvqozcJdw4WQLZGuYr510M+rOKCAxPZjGtVUbqNO4U
         jMbNXYbeCz8FrovXgNgjBE/TztGuSSJcHdDSgQONpXDHyRFot0ZLEd1kkXjjlcXAo9kV
         yc1w==
X-Gm-Message-State: AOJu0YwJ+y8KDS/YKnS1yoOtUJ6cHdJAZTBeuj0CIdm8Y2h2RZwJc1Gt
        vU61EycvWsOJgNHqovC2I6LA6w==
X-Google-Smtp-Source: AGHT+IG+ZZgm9Jt+l/g4kcQ+fj/q9jDIvKCZ7VIBYEeNAcdfOlMNqp3Rov4gWnDJFtxXh/SnKOIYOQ==
X-Received: by 2002:a05:6830:1c3:b0:6bf:235c:41f4 with SMTP id r3-20020a05683001c300b006bf235c41f4mr10551348ota.3.1694398627544;
        Sun, 10 Sep 2023 19:17:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:282a:59c8:cc3a:2d6])
        by smtp.gmail.com with UTF8SMTPSA id a23-20020a056a001d1700b006889664aa6csm1295974pfx.5.2023.09.10.19.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 19:17:07 -0700 (PDT)
From:   David Stevens <stevensd@chromium.org>
X-Google-Original-From: David Stevens <stevensd@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        David Stevens <stevensd@chromium.org>
Subject: [PATCH v9 5/6] KVM: x86: Migrate to __kvm_follow_pfn
Date:   Mon, 11 Sep 2023 11:16:35 +0900
Message-ID: <20230911021637.1941096-6-stevensd@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230911021637.1941096-1-stevensd@google.com>
References: <20230911021637.1941096-1-stevensd@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/kvm/mmu/mmu.c | 43 ++++++++++++++++++++++++++++++++----------
 arch/x86/kvm/x86.c     | 12 ++++++++++--
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e1d011c67cc6..e1eca26215e2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4254,7 +4254,14 @@ void kvm_arch_async_page_ready(struct kvm_vcpu *vcpu, struct kvm_async_pf *work)
 static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	struct kvm_memory_slot *slot = fault->slot;
-	bool async;
+	struct kvm_follow_pfn foll = {
+		.slot = slot,
+		.gfn = fault->gfn,
+		.flags = fault->write ? FOLL_WRITE : 0,
+		.try_map_writable = true,
+		.guarded_by_mmu_notifier = true,
+		.allow_non_refcounted_struct_page = false,
+	};
 
 	/*
 	 * Retry the page fault if the gfn hit a memslot that is being deleted
@@ -4283,12 +4290,20 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 			return RET_PF_EMULATE;
 	}
 
-	async = false;
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, false, &async,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
-	if (!async)
-		return RET_PF_CONTINUE; /* *pfn has correct page already */
+	foll.flags |= FOLL_NOWAIT;
+	fault->pfn = __kvm_follow_pfn(&foll);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	/*
+	 * If __kvm_follow_pfn() failed because I/O is needed to fault in the
+	 * page, then either set up an asynchronous #PF to do the I/O, or if
+	 * doing an async #PF isn't possible, retry __kvm_follow_pfn() with
+	 * I/O allowed. All other failures are fatal, i.e. retrying won't help.
+	 */
+	if (fault->pfn != KVM_PFN_ERR_NEEDS_IO)
+		return RET_PF_CONTINUE;
 
 	if (!fault->prefetch && kvm_can_do_async_pf(vcpu)) {
 		trace_kvm_try_async_get_page(fault->addr, fault->gfn);
@@ -4306,9 +4321,17 @@ static int __kvm_faultin_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 	 * to wait for IO.  Note, gup always bails if it is unable to quickly
 	 * get a page and a fatal signal, i.e. SIGKILL, is pending.
 	 */
-	fault->pfn = __gfn_to_pfn_memslot(slot, fault->gfn, false, true, NULL,
-					  fault->write, &fault->map_writable,
-					  &fault->hva);
+	foll.flags |= FOLL_INTERRUPTIBLE;
+	foll.flags &= ~FOLL_NOWAIT;
+	fault->pfn = __kvm_follow_pfn(&foll);
+
+	if (!is_error_noslot_pfn(fault->pfn))
+		goto success;
+
+	return RET_PF_CONTINUE;
+success:
+	fault->hva = foll.hva;
+	fault->map_writable = foll.writable;
 	return RET_PF_CONTINUE;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6c9c81e82e65..2011a7e47296 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8556,6 +8556,7 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 {
 	gpa_t gpa = cr2_or_gpa;
 	kvm_pfn_t pfn;
+	struct kvm_follow_pfn foll;
 
 	if (!(emulation_type & EMULTYPE_ALLOW_RETRY_PF))
 		return false;
@@ -8585,7 +8586,13 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	 * retry instruction -> write #PF -> emulation fail -> retry
 	 * instruction -> ...
 	 */
-	pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(gpa));
+	foll = (struct kvm_follow_pfn) {
+		.slot = gfn_to_memslot(vcpu->kvm, gpa_to_gfn(gpa)),
+		.gfn = gpa_to_gfn(gpa),
+		.flags = FOLL_WRITE,
+		.allow_non_refcounted_struct_page = true,
+	};
+	pfn = __kvm_follow_pfn(&foll);
 
 	/*
 	 * If the instruction failed on the error pfn, it can not be fixed,
@@ -8594,7 +8601,8 @@ static bool reexecute_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	if (is_error_noslot_pfn(pfn))
 		return false;
 
-	kvm_release_pfn_clean(pfn);
+	if (foll.is_refcounted_page)
+		kvm_release_page_clean(pfn_to_page(pfn));
 
 	/* The instructions are well-emulated on direct mmu. */
 	if (vcpu->arch.mmu->root_role.direct) {
-- 
2.42.0.283.g2d96d420d3-goog

