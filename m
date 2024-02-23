Return-Path: <linux-kernel+bounces-77586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97AA8607CF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090061C22D65
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944D11198;
	Fri, 23 Feb 2024 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gzjk6sOZ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB34F9DE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708648993; cv=none; b=tQWlVTMCVI+yAcx2knzB2zYFSDt1N9+dfko3u7BBQz53w9qV+u1B+mhgWrjlBzf4rBKgbp9o3gewaQs+KJwqmSCUtUb0JHHy/SNPZLrEyaNZjM5u4HZtZ8phG4GP/W9xBKW4xf/TlL+oNsZgFgNzJEdLGoevNdkwuRylRvnOUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708648993; c=relaxed/simple;
	bh=S9zU+8ciTEx2zWEcC5twkkb3JnOr+rQWNF5dvxUiK+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NXE7b7bHg38rDNW/Y+vF73yeX4vsgifL+w8uKBk/5FNVF9SL12KyEtGkjommZSa3XrCtCey5JZ9WTnWCwXE5lnH3dgyFpUsYi4MvnYbCavtQsDVEO9HSbJ5SdfLNKGghnRmGo6aFwYvxUTek8RqmpVMAxXXpMnnwe5roorfYimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gzjk6sOZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so569050276.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708648991; x=1709253791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eb0yDEaAWass5g0hMAU4JrW6cOWG3HVfWM81wBHq82s=;
        b=Gzjk6sOZiNCZ+gpWeAbNxsPAJmORLYywRjriKDJIVWOFMOePX4r8wPkitBeF85XtUL
         d2c90JzwSr7L+t/qlEXwOzB7SSMBBM3Uq1ADnSXsK8CSAophyYC37JtIXsP2iud8hyI5
         TH6NUdyJvnEm0tT8O1O5EQm3YDn+Zse9HglRcoWGLEXnOTxmJYwM6dEWViDaFqnsiVYa
         tBItNqS5Yd1WR72MZU+cnBZi5kCSObGKthq3OXFjR5qu/34f4OQFV8wMv5ZPTQs5jiGH
         8uIpsiuCLZGQk5BVoFCh/CfaSYq4za3131D3qP84JJIzgXLxR6xT+XYy0kl/An0RB7e9
         EnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708648991; x=1709253791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eb0yDEaAWass5g0hMAU4JrW6cOWG3HVfWM81wBHq82s=;
        b=SpUs+dzT8GGK/dRoa9CXI0egpQZKljc56I+K5c6k2lWjYgS4WAYwhZaYzDYVw97IHN
         22VG0M2DtEZqKY+8Av/+sAtoYPoT+n7FCOJr1696jrYut1eEm+paS1yQydo1aMv10g7O
         MgmyE6B8gehVwPg8+lINoOwxulAWXsU1HRg6bS6eJ0CvtsPigFFYZ264XkoHZT9i18jL
         rbZBGlSyu9j0Jax9O1Z8Zuwgym9DJbVjmKn1GPJWnsxrNIs8MDjSq1mwzWzaRqg8ftin
         tZ6dty2RNnvMUPcWoAANFz0jUnUDGSISVfLUd+dlhc4M8DndR2B8JyLbxIbH0lnutO1e
         3d2g==
X-Forwarded-Encrypted: i=1; AJvYcCV2uEpchoPzH6XVCCrXtd9nKIxoXMjWvlFOt7ra687049/Qs5qpfMC1uMZrJFIQJhM1eOs0Pzrf03KMgq9QJbvsE779u3MJeHoxqIhy
X-Gm-Message-State: AOJu0Yw4GViqFKSFA3/kt1G8kMHPazC/jI8vQhFSXwioaxQNPUxFQOBE
	vmbaJJ7htuXKCIFUYhdrZH5353WoD1sl55J1xuREkC0ig3EAvRZqWTJdk6y96Y+C/B6gfoVEAMT
	gIA==
X-Google-Smtp-Source: AGHT+IEvW2bccUqWBEeaPsTnJwBxNY/mUnw/8/lv9jsw5DgwqMPifxEtIyNZjQiEUvn62uClAIUzEpQ2hsE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1007:b0:dc7:48ce:d17f with SMTP id
 w7-20020a056902100700b00dc748ced17fmr187858ybt.10.1708648991200; Thu, 22 Feb
 2024 16:43:11 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 Feb 2024 16:42:52 -0800
In-Reply-To: <20240223004258.3104051-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223004258.3104051-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240223004258.3104051-6-seanjc@google.com>
Subject: [PATCH v9 05/11] KVM: selftests: Add support for protected vm_vaddr_* allocations
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Vishal Annapurve <vannapurve@google.com>, Ackerley Tng <ackerleytng@google.com>, 
	Andrew Jones <andrew.jones@linux.dev>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Michael Roth <michael.roth@amd.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Peter Gonda <pgonda@google.com>, Itaru Kitayama <itaru.kitayama@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

From: Michael Roth <michael.roth@amd.com>

Test programs may wish to allocate shared vaddrs for things like
sharing memory with the guest. Since protected vms will have their
memory encrypted by default an interface is needed to explicitly
request shared pages.

Implement this by splitting the common code out from vm_vaddr_alloc()
and introducing a new vm_vaddr_alloc_shared().

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerly Tng <ackerleytng@google.com>
cc: Andrew Jones <andrew.jones@linux.dev>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Michael Roth <michael.roth@amd.com>
Reviewed-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
Tested-by: Carlos Bilbao <carlos.bilbao@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 +++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a82149305349..cb3159af6db3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -590,6 +590,9 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_mi
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 			    enum kvm_mem_region_type type);
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
+				 vm_vaddr_t vaddr_min,
+				 enum kvm_mem_region_type type);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t __vm_vaddr_alloc_page(struct kvm_vm *vm,
 				 enum kvm_mem_region_type type);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ea677aa019ef..e7f4f84f2e68 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1431,15 +1431,17 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	return pgidx_start * vm->page_size;
 }
 
-vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
-			    enum kvm_mem_region_type type)
+static vm_vaddr_t ____vm_vaddr_alloc(struct kvm_vm *vm, size_t sz,
+				     vm_vaddr_t vaddr_min,
+				     enum kvm_mem_region_type type,
+				     bool protected)
 {
 	uint64_t pages = (sz >> vm->page_shift) + ((sz % vm->page_size) != 0);
 
 	virt_pgd_alloc(vm);
-	vm_paddr_t paddr = vm_phy_pages_alloc(vm, pages,
-					      KVM_UTIL_MIN_PFN * vm->page_size,
-					      vm->memslots[type]);
+	vm_paddr_t paddr = __vm_phy_pages_alloc(vm, pages,
+						KVM_UTIL_MIN_PFN * vm->page_size,
+						vm->memslots[type], protected);
 
 	/*
 	 * Find an unused range of virtual page addresses of at least
@@ -1459,6 +1461,20 @@ vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
 	return vaddr_start;
 }
 
+vm_vaddr_t __vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min,
+			    enum kvm_mem_region_type type)
+{
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type,
+				  vm_arch_has_protected_memory(vm));
+}
+
+vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz,
+				 vm_vaddr_t vaddr_min,
+				 enum kvm_mem_region_type type)
+{
+	return ____vm_vaddr_alloc(vm, sz, vaddr_min, type, false);
+}
+
 /*
  * VM Virtual Address Allocate
  *
-- 
2.44.0.rc0.258.g7320e95886-goog


