Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359D7786460
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238942AbjHXBBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbjHXBBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:01:11 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C60E4E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:01:09 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-26f591c1a2cso4374122a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 18:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692838869; x=1693443669;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TaNHUAMr9/QkZN8b2Wm3agEs7xBWPglfJYxpYZqwWLM=;
        b=wJo65TderJbBPGQj0Vh2yQmFIE9NyE0wgI/NLTtheTetFZcKV0WVtD9z2Ayqt2JrJ/
         EVOFkxrGj6iS/qYsauoXTrHU5EUA9J2/WL1T8Lxb9VEw8wGSJEUjY32A1tpuABKFTkOZ
         I+b5XopsKgD3BRq7r3WhikZJRRrCvoXgKq/8a7Ggd+FVqQzVSVzmlhbIwF6M1bXPd2YY
         Qv09+9nyKL01NwBCZ5tkqQ8zCF/zPVZ7X8QGjS+ihCrSE1hXPR0aRQCWF3tPsJhMNafs
         cMfPLBcYya6jIVthhBpBJ7p0p1JK94zdbZjfqxH6UVrVPYDM5yrOyid1KYRPKNPpp110
         boRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692838869; x=1693443669;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TaNHUAMr9/QkZN8b2Wm3agEs7xBWPglfJYxpYZqwWLM=;
        b=kxzLlH+TURJqnDaGWCX4O588ztXwhCucD94hsbYBryNX68v/MraRj2cuXgc7hS3U1r
         GiUyEn5GRJMjpOKfHHY7XwfxEB/70H6gn9sO5CyDOoXZ0KF0pnetqCnHV1w5qWpjcDQp
         93Ib+UhYSdta0jHI/5psxngMFbj0SEqiF02RQkM/4xj/3cI0K6/mYynBkZXxvrJLa58j
         2OuS6srJYzeKCL/AtLW7AmPxxuzKzFRPP503VN1VmlYgGRfE9iZxLHN5U8JNUHsGzUEj
         8mjdyqzudRe5nkuErQ9HX5aC7HJ594amSXBc/tm10nMe5dt/l7y3TI6TKqFAwL7yyNDm
         MbgQ==
X-Gm-Message-State: AOJu0YxwSjAxem9gvO7KUoQBmv2U1Ib38TfyV+Dw/5FET9WIvd9B5dsM
        AyCy6dTGKfYCb2tsMkuDFYFL2pJlA4s=
X-Google-Smtp-Source: AGHT+IGgIOmtZIhvB1b+7llCJX0kyUtNx3VP+anHzo4hHSAWMaEvFD92kxdlb0Nt2VbZKdU9frzyZPtWcw0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ca16:b0:262:f6f4:7173 with SMTP id
 x22-20020a17090aca1600b00262f6f47173mr3635119pjt.5.1692838868990; Wed, 23 Aug
 2023 18:01:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 23 Aug 2023 18:01:04 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230824010104.2714198-1-seanjc@google.com>
Subject: [PATCH 6.1] KVM: x86/mmu: Fix an sign-extension bug with mmu_seq that
 hangs vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the vCPU's mmu_seq snapshot as an "unsigned long" instead of an "int"
when checking to see if a page fault is stale, as the sequence count is
stored as an "unsigned long" everywhere else in KVM.  This fixes a bug
where KVM will effectively hang vCPUs due to always thinking page faults
are stale, which results in KVM refusing to "fix" faults.

mmu_invalidate_seq (n=C3=A9e mmu_notifier_seq) is a sequence counter used w=
hen
KVM is handling page faults to detect if userspace mappings relevant to
the guest were invalidated between snapshotting the counter and acquiring
mmu_lock, i.e. to ensure that the userspace mapping KVM is using to
resolve the page fault is fresh.  If KVM sees that the counter has
changed, KVM simply resumes the guest without fixing the fault.

What _should_ happen is that the source of the mmu_notifier invalidations
eventually goes away, mmu_invalidate_seq becomes stable, and KVM can once
again fix guest page fault(s).

But for a long-lived VM and/or a VM that the host just doesn't particularly
like, it's possible for a VM to be on the receiving end of 2 billion (with
a B) mmu_notifier invalidations.  When that happens, bit 31 will be set in
mmu_invalidate_seq.  This causes the value to be turned into a 32-bit
negative value when implicitly cast to an "int" by is_page_fault_stale(),
and then sign-extended into a 64-bit unsigned when the signed "int" is
implicitly cast back to an "unsigned long" on the call to
mmu_invalidate_retry_hva().

As a result of the casting and sign-extension, given a sequence counter of
e.g. 0x8002dc25, mmu_invalidate_retry_hva() ends up doing

	if (0x8002dc25 !=3D 0xffffffff8002dc25)

and signals that the page fault is stale and needs to be retried even
though the sequence counter is stable, and KVM effectively hangs any vCPU
that takes a page fault (EPT violation or #NPF when TDP is enabled).

Note, upstream commit ba6e3fe25543 ("KVM: x86/mmu: Grab mmu_invalidate_seq
in kvm_faultin_pfn()") unknowingly fixed the bug in v6.3 when refactoring
how KVM tracks the sequence counter snapshot.

Reported-by: Brian Rak <brak@vultr.com>
Reported-by: Amaan Cheval <amaan.cheval@gmail.com>
Reported-by: Eric Wheeler <kvm@lists.ewheeler.net>
Closes: https://lore.kernel.org/all/f023d927-52aa-7e08-2ee5-59a2fbc65953@ga=
meservers.com
Fixes: a955cad84cda ("KVM: x86/mmu: Retry page fault if root is invalidated=
 by memslot update")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 230108a90cf3..beca03556379 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4212,7 +4212,8 @@ static int kvm_faultin_pfn(struct kvm_vcpu *vcpu, str=
uct kvm_page_fault *fault)
  * root was invalidated by a memslot update or a relevant mmu_notifier fir=
ed.
  */
 static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
-				struct kvm_page_fault *fault, int mmu_seq)
+				struct kvm_page_fault *fault,
+				unsigned long mmu_seq)
 {
 	struct kvm_mmu_page *sp =3D to_shadow_page(vcpu->arch.mmu->root.hpa);
=20

base-commit: 802aacbbffe2512dce9f8f33ad99d01cfec435de
--=20
2.42.0.rc2.253.gd59a3bf2b4-goog

