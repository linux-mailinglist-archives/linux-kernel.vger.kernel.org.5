Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E54D7A2C74
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbjIPAdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238820AbjIPAdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:33:07 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A372D5B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59c12d31d04so12968117b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824323; x=1695429123; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=kZSgVl8Q+hmlGcu9E42B+6nCYbsSFCH4k+E/cwlLEa8=;
        b=bPv1OfhNBPdU0sr0XJk80Rkg5EW4P1gXiI2In4zbIY41ZlOFQYLOnz6HKhuHcRDqZH
         h0A0HVwECGR4XrRSThDKFML+RxobkgH0LoQLA3xy2rM/pEa/0gq/BQLNU+NqcpWWg33x
         8VIc1BFq9LgZv3B+EJD5EdoLiJ+4ulr0g9J6prUugANFkmRo+CDgD0zynjLtm1t24GY0
         xkDMUF55KabBZNnKiaK/9uoOcHm5/3lbOPXGA3a98soE/v3dJuZksD5HaUcOjAC/JwVh
         mLCLc5erjSCqqYTXKP6YaxPdzN4vsytcejG5rjU2sdPLHjLw45d/3OhXWuB52uGzMTbJ
         D1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824323; x=1695429123;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZSgVl8Q+hmlGcu9E42B+6nCYbsSFCH4k+E/cwlLEa8=;
        b=R5tz4brO8fxIrA1DZpgxHWbE0BPj1R82dkm6shdEGbARY7pX2PXm+xrL/ZSIwV3jsg
         PeU9HY8cLa9UyM6AVDNdHjAg496HA83Zxmsq4EQbpSFaP8HdqHb6jiaOp4O6yGcovYuB
         sAeaKOg9NWKPbRK+nEkg5ZWtwP/6MbsDkwRH+Bcwn1N8/dcY0MFl7XMEzZP4nxj6YwxR
         TKm4KLnXr5wOf4B80gr6Jciv2abLRP/uGY5G4tXr4ynaHMcURAjWvoJ2ySTCeMvCoaE7
         dBMj5ypkFnw6gVvechKmTFlcge4r2vjj708KlEDLoAw11+I1J1+eGXQfgYVn/Aij3EhM
         nCOg==
X-Gm-Message-State: AOJu0YxqH1gWqYWEtKZ0gArt819rk2nrIk93wPoGtgJlib2lL9dCQIdk
        dnZJqIwqdq5hJT7IG4vsWnVpFzJ7NFI=
X-Google-Smtp-Source: AGHT+IGvK90kPH1o5bQH0EPib2Mktorl92L52Xc3vYMLm3HoBq+aka+3/3i87f2Q/TuhX6d+6vnq3Y1BBZw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b60c:0:b0:586:a58d:2e24 with SMTP id
 u12-20020a81b60c000000b00586a58d2e24mr95790ywh.5.1694824323076; Fri, 15 Sep
 2023 17:32:03 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:13 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-22-seanjc@google.com>
Subject: [PATCH 21/26] entry/kvm: Drop @vcpu param from arch_xfer_to_guest_mode_handle_work()
From:   Sean Christopherson <seanjc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
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

Drop the "struct kvm_vcpu" parameter from
arch_xfer_to_guest_mode_handle_work() as a preparatory step towards
removing the vCPU parameter from xfer_to_guest_mode_work() as well.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/entry-kvm.h | 7 ++-----
 kernel/entry/kvm.c        | 2 +-
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 6813171afccb..e7d90d06e566 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -25,18 +25,15 @@ struct kvm_vcpu;
 /**
  * arch_xfer_to_guest_mode_handle_work - Architecture specific xfer to guest
  *					 mode work handling function.
- * @vcpu:	Pointer to current's VCPU data
  * @ti_work:	Cached TIF flags gathered in xfer_to_guest_mode_handle_work()
  *
  * Invoked from xfer_to_guest_mode_handle_work(). Defaults to NOOP. Can be
  * replaced by architecture specific code.
  */
-static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
-						      unsigned long ti_work);
+static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work);
 
 #ifndef arch_xfer_to_guest_mode_work
-static inline int arch_xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu,
-						      unsigned long ti_work)
+static inline int arch_xfer_to_guest_mode_handle_work(unsigned long ti_work)
 {
 	return 0;
 }
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 2e0f75bcb7fd..c2fc39824157 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -19,7 +19,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			resume_user_mode_work(NULL);
 
-		ret = arch_xfer_to_guest_mode_handle_work(vcpu, ti_work);
+		ret = arch_xfer_to_guest_mode_handle_work(ti_work);
 		if (ret)
 			return ret;
 
-- 
2.42.0.459.ge4e396fd5e-goog

