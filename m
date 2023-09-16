Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B97A2C6A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbjIPAdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbjIPAc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:32:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7E730CA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814a1f7378so7097536276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694824317; x=1695429117; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxp/wpw1LF0d8Fhe/2GDyJ/jS0kdkc80zXgNVrZkdeA=;
        b=2fbwrzwwcwMEdCJUr8RGBaUnDngKNB070PXZtyq30zQwjcm8IolGOgCF1XZmW1ompj
         IDBGVk8mkCcHAD4KXWzTkNV7Ai4zcL9LFKOqVR+Xrn3ZzRBGASphXPfjCS42L/CbasYL
         K1P6sVitcJCmYaiSyf0RbihIqVp7G7lJrQayuNjQMGiY9xwnVGQUE2V4qezFwn8FLTtm
         rsZHajwCTZ4KS+RQcnK4ZdWQULiNEGoZBZaSj6x/FhDkfbEN78LHV7ARbwSZ6RVVX/WF
         6/fbeE2lkm75SHXs7lvSMGcOS3cXdtqsvcFNQCwpmLq8JB9OpLH8mxuNlMEnGJT5l7kM
         UoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824317; x=1695429117;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fxp/wpw1LF0d8Fhe/2GDyJ/jS0kdkc80zXgNVrZkdeA=;
        b=CpbAGqVswEr8CiTl7oYjmAYEkKeSeGaVKEoKCAvqLE0GYs8Jiklj9lEVk5G8UnQCl3
         ODQoFw7mSpk1sKWFmNRNlMq2o8EAOl3NJ3tivenm7h92FysxnVgeUi92mgKt/3Ca35rD
         oJy7uEcS/TNTBk7wfdsljZ35mW+uAsJcdI+2DXuXTq2vuaoVnczUg8xOf/JA2bUsz/Xf
         j8RSu0vZtvbaTC9VIJhzt8JpWdQ2L+BTGBlyfQ6sDLcz/JgBMkBflqWQ92JQ+SnhRzdd
         2WjSdesmDz92Esf5fQarseRHmZ8bV8hUJ7Fmxef1dXEvaHFZhd+NVxgJzukliiTen3rc
         3HtA==
X-Gm-Message-State: AOJu0Yw/BKGf2p7vWcTTLQPPIp7G8UNguqSWqtNIbM5T4DbChsltOnNt
        Jtm0vw45d6lrvOpfCCBECattcdFPc20=
X-Google-Smtp-Source: AGHT+IEqdj0NaTPFhwcZwboCYWpv5WyTfAkaUyiX867J7n21mAe+KnDvjijo+FbZ8yrF1vPesmLGFCOD+Os=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:4444:0:b0:d80:8aa6:5ac0 with SMTP id
 r65-20020a254444000000b00d808aa65ac0mr190245yba.4.1694824316815; Fri, 15 Sep
 2023 17:31:56 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Sep 2023 17:31:10 -0700
In-Reply-To: <20230916003118.2540661-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230916003118.2540661-19-seanjc@google.com>
Subject: [PATCH 18/26] KVM: s390: Stop adding virt/kvm to the arch include path
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

Don't add virt/kvm to KVM s390's include path, the headers in virt/kvm are
intended to be used only by other code in virt/kvm, i.e. are "private" to
the core KVM code.  It's not clear that s390 *ever* included a header from
virt/kvm, i.e. odds are good the "-Ivirt/kvm" was copied from a x86's
Makefile when s390 support was first added.

The only headers in virt/kvm at the time were the x86 specific ioapic.h,
and iodev.h, neither of which shows up as an #include in the diff for the
commit range 37817f2982d0f..e976a2b997fc4.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/s390/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 02217fb4ae10..f17249ab2a72 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -5,7 +5,7 @@
 
 include $(srctree)/virt/kvm/Makefile.kvm
 
-ccflags-y := -Ivirt/kvm -Iarch/s390/kvm
+ccflags-y := -Iarch/s390/kvm
 
 kvm-y += kvm-s390.o intercept.o interrupt.o priv.o sigp.o
 kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
-- 
2.42.0.459.ge4e396fd5e-goog

