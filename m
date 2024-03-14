Return-Path: <linux-kernel+bounces-103910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B55E87C674
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDC71C210A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C02B5B1F6;
	Thu, 14 Mar 2024 23:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4awMHOdE"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24425A4E9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710458837; cv=none; b=mOPmmPXPPeFiULOgIXsG3OHFcxcu9OdtPybR4SrY2nzRu6mGljhDOHV9JmR0bIj9AZGY0vLVE8HRR8uc5nrpC854HBYCw4SC/KMalUjUzTsFCSyePKYMFa1wMkeev4BupGMFbJSlpbjbw5tQhMADlDedBGtT2SbrSozgPzkC+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710458837; c=relaxed/simple;
	bh=U+2Hob5P6Gh09tf0pwrrrWPczRSLurLoqR4c4omlOk0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P+U/FCISn34oAijNTuFd3a6Fcd5ftcT8+zBnxDru5e/Z3OU5mfbwxwbB6t6asSXjN7TsBmiv1CaEWvMNcAnkY/Uh/dIEiqh7cOwU8FrO0XvTsqEBxZO3v3VArwlyMvGQp2q+eEeFkfDHxY+zqItd3Van+40wKcPGo28V69KcxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4awMHOdE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5dbddee3694so844978a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 16:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710458835; x=1711063635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fVWd/4nHkGU+RZSRNxZTIKvgC6ZcIUosAi3U9bNiK5o=;
        b=4awMHOdEM5CU5cY4i9cUIf9wA/SVdjmfateD64QYjKaJ9v4C4YyRBXLXKa/9CbN8M3
         /LGTGj1dKpQZNor85XGCrRA4tiufcSKOf8R8Qudw/fBYUkSEPPgAVknRIYfvnPcrDN7y
         kXJcMLIzhAFPlnUdYhzTdwZweRzs4RRw2RDJbs8EQWBBVpgXbVFejPtqaGlAro7CNY4d
         LI9QaOJ5HDI3Oz8HvDcR/bmD/ZUsBl9tiNV2TtzO6D97LAcx1BvIbETAnmtELBkQeWQN
         a+JCdYCRP0vyiRS/aGn1lACekjhtMd7EYi5SK6RJSagZrppg1ZwnMxHI5PP6b5ps9XOW
         DCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710458835; x=1711063635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fVWd/4nHkGU+RZSRNxZTIKvgC6ZcIUosAi3U9bNiK5o=;
        b=CUXNIiUWEsMeEzeek6VoM+P+fXjQ0AsijkDk8sIuqsVAaFcfx118wvz7LcEgcCkSTa
         5hP1LTC2jTVHCfNVjNrAy0684DYwpxpVuFq3U1QY4ev9sD8APaGOmHnO6x66Szt6rTPm
         riC89zZZzKnwyzlN0M4/M20XXV40u4uBACodUMC/aU+GxGYuuNdmGJ5S9Fh3l93IeRNe
         oTsJPlvbw7Vsn7k1QL38vtO7xHTM7PENdCfGzl1PxrC9U1V+st/qC0Bmx5PAhCaIP4jV
         vvp9SvXs6ezNnh6reymfqt+R0MnmM8pO2mAe+5H2GAVF7yDUv4x4qrQcWGBYfnLyZnsi
         KCDA==
X-Forwarded-Encrypted: i=1; AJvYcCXM3CYSbe4hMTpvLVPnuNIA2DRZyO3gUzEutbSUmVNAem8Ef4S0+IBu9j5LFM7TLq8JIiSDE2lc/Wj/Lf4L1i0m6k5IBF4dfw4KWFnJ
X-Gm-Message-State: AOJu0YwGVD6ISh3mRO6UyyOMhKU2dlYZBQazorc3Av+zWojvIcQ6hA+a
	3ejxQJ+uIrzVaxEc43f87HLC+eHhTHJvR+vksoA6WoDxqHNoWhFu4Or3bwZNE1laDKOHsga8jBB
	2ng==
X-Google-Smtp-Source: AGHT+IGRI5hc5CP3CR9IYz2Kmbchzln3C1e7PEoGzqGhInO36w6Nc4buOmgVEVYtprnFqx8Z8ErRa1R6iOg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:6483:0:b0:5dc:2a75:9a19 with SMTP id
 y125-20020a636483000000b005dc2a759a19mr12387pgb.2.1710458834658; Thu, 14 Mar
 2024 16:27:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Mar 2024 16:26:37 -0700
In-Reply-To: <20240314232637.2538648-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240314232637.2538648-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Message-ID: <20240314232637.2538648-19-seanjc@google.com>
Subject: [PATCH 18/18] KVM: selftests: Drop @selector from segment helpers
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Drop the @selector from the kernel code, data, and TSS builders and
instead hardcode the respective selector in the helper.  Accepting a
selector but not a base makes the selector useless, e.g. the data helper
can't create per-vCPU for FS or GS, and so loading GS with KERNEL_DS is
the only logical choice.

And for code and TSS, there is no known reason to ever want multiple
segments, e.g. there are zero plans to support 32-bit kernel code (and
again, that would require more than just the selector).

If KVM selftests ever do add support for per-vCPU segments, it'd arguably
be more readable to add a dedicated helper for building/setting the
per-vCPU segment, and move the common data segment code to an inner
helper.

Lastly, hardcoding the selector reduces the probability of setting the
wrong selector in the vCPU versus what was created by the VM in the GDT.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 29 +++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index dab719ee7734..6abd50d6e59d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -438,10 +438,10 @@ static void kvm_seg_fill_gdt_64bit(struct kvm_vm *vm, struct kvm_segment *segp)
 		desc->base3 = segp->base >> 32;
 }
 
-static void kvm_seg_set_kernel_code_64bit(uint16_t selector, struct kvm_segment *segp)
+static void kvm_seg_set_kernel_code_64bit(struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
-	segp->selector = selector;
+	segp->selector = KERNEL_CS;
 	segp->limit = 0xFFFFFFFFu;
 	segp->s = 0x1; /* kTypeCodeData */
 	segp->type = 0x08 | 0x01 | 0x02; /* kFlagCode | kFlagCodeAccessed
@@ -452,10 +452,10 @@ static void kvm_seg_set_kernel_code_64bit(uint16_t selector, struct kvm_segment
 	segp->present = 1;
 }
 
-static void kvm_seg_set_kernel_data_64bit(uint16_t selector, struct kvm_segment *segp)
+static void kvm_seg_set_kernel_data_64bit(struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
-	segp->selector = selector;
+	segp->selector = KERNEL_DS;
 	segp->limit = 0xFFFFFFFFu;
 	segp->s = 0x1; /* kTypeCodeData */
 	segp->type = 0x00 | 0x01 | 0x02; /* kFlagData | kFlagDataAccessed
@@ -480,13 +480,12 @@ vm_paddr_t addr_arch_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
 	return vm_untag_gpa(vm, PTE_GET_PA(*pte)) | (gva & ~HUGEPAGE_MASK(level));
 }
 
-static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp,
-				  int selector)
+static void kvm_seg_set_tss_64bit(vm_vaddr_t base, struct kvm_segment *segp)
 {
 	memset(segp, 0, sizeof(*segp));
 	segp->base = base;
 	segp->limit = 0x67;
-	segp->selector = selector;
+	segp->selector = KERNEL_TSS;
 	segp->type = 0xb;
 	segp->present = 1;
 }
@@ -510,11 +509,11 @@ static void vcpu_init_sregs(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 	sregs.efer |= (EFER_LME | EFER_LMA | EFER_NX);
 
 	kvm_seg_set_unusable(&sregs.ldt);
-	kvm_seg_set_kernel_code_64bit(KERNEL_CS, &sregs.cs);
-	kvm_seg_set_kernel_data_64bit(KERNEL_DS, &sregs.ds);
-	kvm_seg_set_kernel_data_64bit(KERNEL_DS, &sregs.es);
-	kvm_seg_set_kernel_data_64bit(KERNEL_DS, &sregs.gs);
-	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr, KERNEL_TSS);
+	kvm_seg_set_kernel_code_64bit(&sregs.cs);
+	kvm_seg_set_kernel_data_64bit(&sregs.ds);
+	kvm_seg_set_kernel_data_64bit(&sregs.es);
+	kvm_seg_set_kernel_data_64bit(&sregs.gs);
+	kvm_seg_set_tss_64bit(vm->arch.tss, &sregs.tr);
 
 	sregs.cr3 = vm->pgd;
 	vcpu_sregs_set(vcpu, &sregs);
@@ -588,13 +587,13 @@ static void vm_init_descriptor_tables(struct kvm_vm *vm)
 
 	*(vm_vaddr_t *)addr_gva2hva(vm, (vm_vaddr_t)(&exception_handlers)) = vm->handlers;
 
-	kvm_seg_set_kernel_code_64bit(KERNEL_CS, &seg);
+	kvm_seg_set_kernel_code_64bit(&seg);
 	kvm_seg_fill_gdt_64bit(vm, &seg);
 
-	kvm_seg_set_kernel_data_64bit(KERNEL_DS, &seg);
+	kvm_seg_set_kernel_data_64bit(&seg);
 	kvm_seg_fill_gdt_64bit(vm, &seg);
 
-	kvm_seg_set_tss_64bit(vm->arch.tss, &seg, KERNEL_TSS);
+	kvm_seg_set_tss_64bit(vm->arch.tss, &seg);
 	kvm_seg_fill_gdt_64bit(vm, &seg);
 }
 
-- 
2.44.0.291.gc1ea87d7ee-goog


