Return-Path: <linux-kernel+bounces-158410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE258B1F77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B4F1F22B19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F7B22638;
	Thu, 25 Apr 2024 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXVOpYkI"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189BE20314
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714041824; cv=none; b=agzbUQQt8wiopCyoB/XmapCbSq1DJ5CeFIycYK5jvoB3OziXcnmJ3LxckGbjUP5LLbsHlYOhZ3RLVUW4N9vzT37zHnGftjMnDuhxmS/zMIsWLtkB/yTlGIBR/EnXXjiEpd3/OvaWP3VpZWOcVoJR8xGX1xzoFzCLrL8a+GEiU5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714041824; c=relaxed/simple;
	bh=fqFUdvZJzGZPWoyL4Hx08aIEoDNcY1pcvOTCZWhVoqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b61TI88VG80gNffIGGyvJmf3vx9sBp3UlDNy8mFpAZxRRSITSDG+fDj+k8Firko4QzsH14PTxqrZbcAsbdlSKEe/dKKxJ2JgbE2LVV1pLebYeWV5YV8DQDwlCplOJb0wT7plRAQpWHFS4T/1CCPN9oQTRw4bRNgKjqYhx9wG6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXVOpYkI; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4dabc6f141bso186513e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714041820; x=1714646620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7rLGiiPExNNew19pGqIBhjQqamOgwQ5bR+kzuGePys=;
        b=MXVOpYkIDTjao9DIGaMYgtYWUY41aIo97bY2uIiGfbcoQW2c+TR5zEAGM3GIiPMaln
         oDwh3OIiqpFiq+onKYVYv9EChOZ6X47fgjV18r+UwcJimC5jI/GWTrypyegLTBAf6JfD
         4mrycR4KskymRCK7qPEkZXm+3VLusAFots5aAUUn0X1b4og3j6o11pMILHq4Ehyh9LBd
         R/qeypa3AmV+ssCeaJ1WQ67nLQo4rYAEE7gTzId9ADDew1JYHX34i4t0IlXZC+tZ0OF5
         yGx85IE956x23Uk505KHlXOevmko54Iaf2NXIPp40ok/5Nkc+RLpb5El7MLglwvuh6hh
         Fjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714041820; x=1714646620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7rLGiiPExNNew19pGqIBhjQqamOgwQ5bR+kzuGePys=;
        b=mHyWqlMP0c4fHTsAF7yfkngpmQqbTqwM7DL0UdpsUW6lskMogwH15ZkJd9UqzFNrBO
         UhiRx1DoL20U/CN1iEPPht1UCsJ2NzfqQYgZByRYnzhMhQlGFOZK+V4KIGGREA/KqRoF
         +c32HcwF9L2zJJbrXMK98NqCFFjXHgRJ6oDp58PUb6MT0kdJHvO8121CyZ0oVSiaYw63
         wsl0fx2x7+wXr/HacanGiTHO1sPXi3hCnkifbCMRQaBSqKh9vVhzviTyx+fL5IZATUAd
         XUdLNatmlgJdC74psayk9UcHzbiDZFH5tYbyNPxJyCSHzMUSjhZi8ivEg6hjtfN0P9kc
         DEvg==
X-Forwarded-Encrypted: i=1; AJvYcCVr2/fbbPwGqSA6tzvoKv/TT14wjuraRMXfniNWTMOsc6SGuvhVIJbNiwXfO7QIBl4+1D4poO60iSeod9DVHRxkgEW5qwmYKDjPnr9H
X-Gm-Message-State: AOJu0YyFpJ66V1Fq97AUwhbYKzATCwzbDTRMiJMEjJuJmfjDtmFWS32b
	yXv1Ae4l7PS4kAadfQy7Nhu6Z5xQSxHTwX6FMevrT2toWpobPKinu+dJ562Fm1Uyk0unRG++7Ml
	1thsIpx0B4KUnBTersceJgSpEoREhWEiq3LJxkg/lw7yBxtbbTb2k
X-Google-Smtp-Source: AGHT+IEQNopBfH4UHuMt9CNIrGOvefcY71mESIetJvt0mNN3SQ+HA70eNwnXsXVjaMTeIkgW/ps8K2N9uekxp9gDLhU=
X-Received: by 2002:a05:6122:32c3:b0:4d3:1ef2:c97d with SMTP id
 ck3-20020a05612232c300b004d31ef2c97dmr6247607vkb.2.1714041819651; Thu, 25 Apr
 2024 03:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412084056.1733704-1-steven.price@arm.com>
 <20240412084309.1733783-1-steven.price@arm.com> <20240412084309.1733783-22-steven.price@arm.com>
In-Reply-To: <20240412084309.1733783-22-steven.price@arm.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Apr 2024 11:43:02 +0100
Message-ID: <CA+EHjTyr1swQ4ONE2oVnWU5uPkcq2WDNYDRA8eK29-4BQDcCLw@mail.gmail.com>
Subject: Re: [PATCH v2 21/43] arm64: RME: Runtime faulting of memory
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 12, 2024 at 9:44=E2=80=AFAM Steven Price <steven.price@arm.com>=
 wrote:
>
> At runtime if the realm guest accesses memory which hasn't yet been
> mapped then KVM needs to either populate the region or fault the guest.
>
> For memory in the lower (protected) region of IPA a fresh page is
> provided to the RMM which will zero the contents. For memory in the
> upper (shared) region of IPA, the memory from the memslot is mapped
> into the realm VM non secure.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  arch/arm64/include/asm/kvm_emulate.h |  10 ++
>  arch/arm64/include/asm/kvm_rme.h     |  10 ++
>  arch/arm64/kvm/mmu.c                 | 119 +++++++++++++++-
>  arch/arm64/kvm/rme.c                 | 199 ++++++++++++++++++++++++---
>  4 files changed, 316 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/as=
m/kvm_emulate.h
> index 2209a7c6267f..d40d998d9be2 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -629,6 +629,16 @@ static inline bool kvm_realm_is_created(struct kvm *=
kvm)
>         return kvm_is_realm(kvm) && kvm_realm_state(kvm) !=3D REALM_STATE=
_NONE;
>  }
>
> +static inline gpa_t kvm_gpa_stolen_bits(struct kvm *kvm)
> +{
> +       if (kvm_is_realm(kvm)) {
> +               struct realm *realm =3D &kvm->arch.realm;
> +
> +               return BIT(realm->ia_bits - 1);
> +       }
> +       return 0;
> +}
> +
>  static inline bool vcpu_is_rec(struct kvm_vcpu *vcpu)
>  {
>         if (static_branch_unlikely(&kvm_rme_is_available))
> diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/asm/kv=
m_rme.h
> index 749f2eb97bd4..48c7766fadeb 100644
> --- a/arch/arm64/include/asm/kvm_rme.h
> +++ b/arch/arm64/include/asm/kvm_rme.h
> @@ -103,6 +103,16 @@ void kvm_realm_unmap_range(struct kvm *kvm,
>                            unsigned long ipa,
>                            u64 size,
>                            bool unmap_private);
> +int realm_map_protected(struct realm *realm,
> +                       unsigned long base_ipa,
> +                       struct page *dst_page,
> +                       unsigned long map_size,
> +                       struct kvm_mmu_memory_cache *memcache);
> +int realm_map_non_secure(struct realm *realm,
> +                        unsigned long ipa,
> +                        struct page *page,
> +                        unsigned long map_size,
> +                        struct kvm_mmu_memory_cache *memcache);
>  int realm_set_ipa_state(struct kvm_vcpu *vcpu,
>                         unsigned long addr, unsigned long end,
>                         unsigned long ripas);
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index 8a7b5449697f..50a49e4e2020 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -325,8 +325,13 @@ static void __unmap_stage2_range(struct kvm_s2_mmu *=
mmu, phys_addr_t start, u64
>
>         lockdep_assert_held_write(&kvm->mmu_lock);
>         WARN_ON(size & ~PAGE_MASK);
> -       WARN_ON(stage2_apply_range(mmu, start, end, kvm_pgtable_stage2_un=
map,
> -                                  may_block));
> +
> +       if (kvm_is_realm(kvm))
> +               kvm_realm_unmap_range(kvm, start, size, !only_shared);
> +       else
> +               WARN_ON(stage2_apply_range(mmu, start, end,
> +                                          kvm_pgtable_stage2_unmap,
> +                                          may_block));
>  }
>
>  static void unmap_stage2_range(struct kvm_s2_mmu *mmu, phys_addr_t start=
, u64 size)
> @@ -340,7 +345,11 @@ static void stage2_flush_memslot(struct kvm *kvm,
>         phys_addr_t addr =3D memslot->base_gfn << PAGE_SHIFT;
>         phys_addr_t end =3D addr + PAGE_SIZE * memslot->npages;
>
> -       stage2_apply_range_resched(&kvm->arch.mmu, addr, end, kvm_pgtable=
_stage2_flush);
> +       if (kvm_is_realm(kvm))
> +               kvm_realm_unmap_range(kvm, addr, end - addr, false);
> +       else
> +               stage2_apply_range_resched(&kvm->arch.mmu, addr, end,
> +                                          kvm_pgtable_stage2_flush);
>  }
>
>  /**
> @@ -997,6 +1006,10 @@ void stage2_unmap_vm(struct kvm *kvm)
>         struct kvm_memory_slot *memslot;
>         int idx, bkt;
>
> +       /* For realms this is handled by the RMM so nothing to do here */
> +       if (kvm_is_realm(kvm))
> +               return;
> +
>         idx =3D srcu_read_lock(&kvm->srcu);
>         mmap_read_lock(current->mm);
>         write_lock(&kvm->mmu_lock);
> @@ -1020,6 +1033,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>         if (kvm_is_realm(kvm) &&
>             (kvm_realm_state(kvm) !=3D REALM_STATE_DEAD &&
>              kvm_realm_state(kvm) !=3D REALM_STATE_NONE)) {
> +               unmap_stage2_range(mmu, 0, (~0ULL) & PAGE_MASK);
>                 write_unlock(&kvm->mmu_lock);
>                 kvm_realm_destroy_rtts(kvm, pgt->ia_bits);
>                 return;
> @@ -1383,6 +1397,69 @@ static bool kvm_vma_mte_allowed(struct vm_area_str=
uct *vma)
>         return vma->vm_flags & VM_MTE_ALLOWED;
>  }
>
> +static int realm_map_ipa(struct kvm *kvm, phys_addr_t ipa,
> +                        kvm_pfn_t pfn, unsigned long map_size,
> +                        enum kvm_pgtable_prot prot,
> +                        struct kvm_mmu_memory_cache *memcache)
> +{
> +       struct realm *realm =3D &kvm->arch.realm;
> +       struct page *page =3D pfn_to_page(pfn);
> +
> +       if (WARN_ON(!(prot & KVM_PGTABLE_PROT_W)))
> +               return -EFAULT;
> +
> +       if (!realm_is_addr_protected(realm, ipa))
> +               return realm_map_non_secure(realm, ipa, page, map_size,
> +                                           memcache);
> +
> +       return realm_map_protected(realm, ipa, page, map_size, memcache);
> +}
> +
> +static int private_memslot_fault(struct kvm_vcpu *vcpu,
> +                                phys_addr_t fault_ipa,
> +                                struct kvm_memory_slot *memslot)
> +{
> +       struct kvm *kvm =3D vcpu->kvm;
> +       gpa_t gpa_stolen_mask =3D kvm_gpa_stolen_bits(kvm);
> +       gfn_t gfn =3D (fault_ipa & ~gpa_stolen_mask) >> PAGE_SHIFT;
> +       bool is_priv_gfn =3D !((fault_ipa & gpa_stolen_mask) =3D=3D gpa_s=
tolen_mask);
> +       bool priv_exists =3D kvm_mem_is_private(kvm, gfn);
> +       struct kvm_mmu_memory_cache *memcache =3D &vcpu->arch.mmu_page_ca=
che;
> +       int order;
> +       kvm_pfn_t pfn;
> +       int ret;
> +
> +       if (priv_exists !=3D is_priv_gfn) {
> +               kvm_prepare_memory_fault_exit(vcpu,
> +                                             fault_ipa & ~gpa_stolen_mas=
k,
> +                                             PAGE_SIZE,
> +                                             kvm_is_write_fault(vcpu),
> +                                             false, is_priv_gfn);
> +
> +               return 0;
> +       }
> +
> +       if (!is_priv_gfn) {
> +               /* Not a private mapping, handling normally */
> +               return -EAGAIN;
> +       }
> +
> +       if (kvm_gmem_get_pfn(kvm, memslot, gfn, &pfn, &order))
> +               return 1; /* Retry */

You don't need to pass a variable to hold the order if you don't need
it. You can pass NULL.

I am also confused about the return, why do you return 1 regardless of
the reason kvm_gmem_get_pfn() fails?

> +       ret =3D kvm_mmu_topup_memory_cache(memcache,
> +                                        kvm_mmu_cache_min_pages(vcpu->ar=
ch.hw_mmu));
> +       if (ret)
> +               return ret;

If this fails you should release the page you got earlier (e.g.,
kvm_release_pfn_clean()), or you could move it before
kvm_gmem_get_pfn().

> +       /* FIXME: Should be able to use bigger than PAGE_SIZE mappings */
> +       ret =3D realm_map_ipa(kvm, fault_ipa, pfn, PAGE_SIZE, KVM_PGTABLE=
_PROT_W,
> +                            memcache);
> +       if (!ret)
> +               return 1; /* Handled */

Should also release the page if it fails. Speaking of which,
where/when do you eventually release the page?

Cheers,
/fuad

> +       return ret;
> +}
> +
>  static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>                           struct kvm_memory_slot *memslot, unsigned long =
hva,
>                           bool fault_is_perm)
> @@ -1402,10 +1479,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, =
phys_addr_t fault_ipa,
>         long vma_pagesize, fault_granule;
>         enum kvm_pgtable_prot prot =3D KVM_PGTABLE_PROT_R;
>         struct kvm_pgtable *pgt;
> +       gpa_t gpa_stolen_mask =3D kvm_gpa_stolen_bits(vcpu->kvm);
>
>         if (fault_is_perm)
>                 fault_granule =3D kvm_vcpu_trap_get_perm_fault_granule(vc=
pu);
>         write_fault =3D kvm_is_write_fault(vcpu);
> +
> +       /*
> +        * Realms cannot map protected pages read-only
> +        * FIXME: It should be possible to map unprotected pages read-onl=
y
> +        */
> +       if (vcpu_is_rec(vcpu))
> +               write_fault =3D true;
> +
>         exec_fault =3D kvm_vcpu_trap_is_exec_fault(vcpu);
>         VM_BUG_ON(write_fault && exec_fault);
>
> @@ -1478,7 +1564,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, ph=
ys_addr_t fault_ipa,
>         if (vma_pagesize =3D=3D PMD_SIZE || vma_pagesize =3D=3D PUD_SIZE)
>                 fault_ipa &=3D ~(vma_pagesize - 1);
>
> -       gfn =3D fault_ipa >> PAGE_SHIFT;
> +       gfn =3D (fault_ipa & ~gpa_stolen_mask) >> PAGE_SHIFT;
>         mte_allowed =3D kvm_vma_mte_allowed(vma);
>
>         vfio_allow_any_uc =3D vma->vm_flags & VM_ALLOW_ANY_UNCACHED;
> @@ -1538,7 +1624,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, ph=
ys_addr_t fault_ipa,
>          * If we are not forced to use page mapping, check if we are
>          * backed by a THP and thus use block mapping if possible.
>          */
> -       if (vma_pagesize =3D=3D PAGE_SIZE && !(force_pte || device)) {
> +       /* FIXME: We shouldn't need to disable this for realms */
> +       if (vma_pagesize =3D=3D PAGE_SIZE && !(force_pte || device || kvm=
_is_realm(kvm))) {
>                 if (fault_is_perm && fault_granule > PAGE_SIZE)
>                         vma_pagesize =3D fault_granule;
>                 else
> @@ -1584,6 +1671,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, ph=
ys_addr_t fault_ipa,
>          */
>         if (fault_is_perm && vma_pagesize =3D=3D fault_granule)
>                 ret =3D kvm_pgtable_stage2_relax_perms(pgt, fault_ipa, pr=
ot);
> +       else if (kvm_is_realm(kvm))
> +               ret =3D realm_map_ipa(kvm, fault_ipa, pfn, vma_pagesize,
> +                                   prot, memcache);
>         else
>                 ret =3D kvm_pgtable_stage2_map(pgt, fault_ipa, vma_pagesi=
ze,
>                                              __pfn_to_phys(pfn), prot,
> @@ -1638,6 +1728,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>         struct kvm_memory_slot *memslot;
>         unsigned long hva;
>         bool is_iabt, write_fault, writable;
> +       gpa_t gpa_stolen_mask =3D kvm_gpa_stolen_bits(vcpu->kvm);
>         gfn_t gfn;
>         int ret, idx;
>
> @@ -1693,8 +1784,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>
>         idx =3D srcu_read_lock(&vcpu->kvm->srcu);
>
> -       gfn =3D fault_ipa >> PAGE_SHIFT;
> +       gfn =3D (fault_ipa & ~gpa_stolen_mask) >> PAGE_SHIFT;
>         memslot =3D gfn_to_memslot(vcpu->kvm, gfn);
> +
> +       if (kvm_slot_can_be_private(memslot)) {
> +               ret =3D private_memslot_fault(vcpu, fault_ipa, memslot);
> +               if (ret !=3D -EAGAIN)
> +                       goto out;
> +       }
> +
>         hva =3D gfn_to_hva_memslot_prot(memslot, gfn, &writable);
>         write_fault =3D kvm_is_write_fault(vcpu);
>         if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
> @@ -1738,6 +1836,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
>                  * of the page size.
>                  */
>                 fault_ipa |=3D kvm_vcpu_get_hfar(vcpu) & ((1 << 12) - 1);
> +               fault_ipa &=3D ~gpa_stolen_mask;
>                 ret =3D io_mem_abort(vcpu, fault_ipa);
>                 goto out_unlock;
>         }
> @@ -1819,6 +1918,10 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm_gfn_r=
ange *range)
>         if (!kvm->arch.mmu.pgt)
>                 return false;
>
> +       /* We don't support aging for Realms */
> +       if (kvm_is_realm(kvm))
> +               return true;
> +
>         return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
>                                                    range->start << PAGE_S=
HIFT,
>                                                    size, true);
> @@ -1831,6 +1934,10 @@ bool kvm_test_age_gfn(struct kvm *kvm, struct kvm_=
gfn_range *range)
>         if (!kvm->arch.mmu.pgt)
>                 return false;
>
> +       /* We don't support aging for Realms */
> +       if (kvm_is_realm(kvm))
> +               return true;
> +
>         return kvm_pgtable_stage2_test_clear_young(kvm->arch.mmu.pgt,
>                                                    range->start << PAGE_S=
HIFT,
>                                                    size, false);
> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> index 4aab507f896e..72f6f5f542c4 100644
> --- a/arch/arm64/kvm/rme.c
> +++ b/arch/arm64/kvm/rme.c
> @@ -606,6 +606,170 @@ static int fold_rtt(struct realm *realm, unsigned l=
ong addr, int level)
>         return 0;
>  }
>
> +int realm_map_protected(struct realm *realm,
> +                       unsigned long base_ipa,
> +                       struct page *dst_page,
> +                       unsigned long map_size,
> +                       struct kvm_mmu_memory_cache *memcache)
> +{
> +       phys_addr_t dst_phys =3D page_to_phys(dst_page);
> +       phys_addr_t rd =3D virt_to_phys(realm->rd);
> +       unsigned long phys =3D dst_phys;
> +       unsigned long ipa =3D base_ipa;
> +       unsigned long size;
> +       int map_level;
> +       int ret =3D 0;
> +
> +       if (WARN_ON(!IS_ALIGNED(ipa, map_size)))
> +               return -EINVAL;
> +
> +       switch (map_size) {
> +       case PAGE_SIZE:
> +               map_level =3D 3;
> +               break;
> +       case RME_L2_BLOCK_SIZE:
> +               map_level =3D 2;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (map_level < RME_RTT_MAX_LEVEL) {
> +               /*
> +                * A temporary RTT is needed during the map, precreate it=
,
> +                * however if there is an error (e.g. missing parent tabl=
es)
> +                * this will be handled below.
> +                */
> +               realm_create_rtt_levels(realm, ipa, map_level,
> +                                       RME_RTT_MAX_LEVEL, memcache);
> +       }
> +
> +       for (size =3D 0; size < map_size; size +=3D PAGE_SIZE) {
> +               if (rmi_granule_delegate(phys)) {
> +                       struct rtt_entry rtt;
> +
> +                       /*
> +                        * It's possible we raced with another VCPU on th=
e same
> +                        * fault. If the entry exists and matches then ex=
it
> +                        * early and assume the other VCPU will handle th=
e
> +                        * mapping.
> +                        */
> +                       if (rmi_rtt_read_entry(rd, ipa, RME_RTT_MAX_LEVEL=
, &rtt))
> +                               goto err;
> +
> +                       // FIXME: For a block mapping this could race at =
level
> +                       // 2 or 3...
> +                       if (WARN_ON((rtt.walk_level !=3D RME_RTT_MAX_LEVE=
L ||
> +                                    rtt.state !=3D RMI_ASSIGNED ||
> +                                    rtt.desc !=3D phys))) {
> +                               goto err;
> +                       }
> +
> +                       return 0;
> +               }
> +
> +               ret =3D rmi_data_create_unknown(rd, phys, ipa);
> +
> +               if (RMI_RETURN_STATUS(ret) =3D=3D RMI_ERROR_RTT) {
> +                       /* Create missing RTTs and retry */
> +                       int level =3D RMI_RETURN_INDEX(ret);
> +
> +                       ret =3D realm_create_rtt_levels(realm, ipa, level=
,
> +                                                     RME_RTT_MAX_LEVEL,
> +                                                     memcache);
> +                       WARN_ON(ret);
> +                       if (ret)
> +                               goto err_undelegate;
> +
> +                       ret =3D rmi_data_create_unknown(rd, phys, ipa);
> +               }
> +               WARN_ON(ret);
> +
> +               if (ret)
> +                       goto err_undelegate;
> +
> +               phys +=3D PAGE_SIZE;
> +               ipa +=3D PAGE_SIZE;
> +       }
> +
> +       if (map_size =3D=3D RME_L2_BLOCK_SIZE)
> +               ret =3D fold_rtt(realm, base_ipa, map_level);
> +       if (WARN_ON(ret))
> +               goto err;
> +
> +       return 0;
> +
> +err_undelegate:
> +       if (WARN_ON(rmi_granule_undelegate(phys))) {
> +               /* Page can't be returned to NS world so is lost */
> +               get_page(phys_to_page(phys));
> +       }
> +err:
> +       while (size > 0) {
> +               unsigned long data, top;
> +
> +               phys -=3D PAGE_SIZE;
> +               size -=3D PAGE_SIZE;
> +               ipa -=3D PAGE_SIZE;
> +
> +               WARN_ON(rmi_data_destroy(rd, ipa, &data, &top));
> +
> +               if (WARN_ON(rmi_granule_undelegate(phys))) {
> +                       /* Page can't be returned to NS world so is lost =
*/
> +                       get_page(phys_to_page(phys));
> +               }
> +       }
> +       return -ENXIO;
> +}
> +
> +int realm_map_non_secure(struct realm *realm,
> +                        unsigned long ipa,
> +                        struct page *page,
> +                        unsigned long map_size,
> +                        struct kvm_mmu_memory_cache *memcache)
> +{
> +       phys_addr_t rd =3D virt_to_phys(realm->rd);
> +       int map_level;
> +       int ret =3D 0;
> +       unsigned long desc =3D page_to_phys(page) |
> +                            PTE_S2_MEMATTR(MT_S2_FWB_NORMAL) |
> +                            /* FIXME: Read+Write permissions for now */
> +                            (3 << 6) |
> +                            PTE_SHARED;
> +
> +       if (WARN_ON(!IS_ALIGNED(ipa, map_size)))
> +               return -EINVAL;
> +
> +       switch (map_size) {
> +       case PAGE_SIZE:
> +               map_level =3D 3;
> +               break;
> +       case RME_L2_BLOCK_SIZE:
> +               map_level =3D 2;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       ret =3D rmi_rtt_map_unprotected(rd, ipa, map_level, desc);
> +
> +       if (RMI_RETURN_STATUS(ret) =3D=3D RMI_ERROR_RTT) {
> +               /* Create missing RTTs and retry */
> +               int level =3D RMI_RETURN_INDEX(ret);
> +
> +               ret =3D realm_create_rtt_levels(realm, ipa, level, map_le=
vel,
> +                                             memcache);
> +               if (WARN_ON(ret))
> +                       return -ENXIO;
> +
> +               ret =3D rmi_rtt_map_unprotected(rd, ipa, map_level, desc)=
;
> +       }
> +       if (WARN_ON(ret))
> +               return -ENXIO;
> +
> +       return 0;
> +}
> +
>  static int populate_par_region(struct kvm *kvm,
>                                phys_addr_t ipa_base,
>                                phys_addr_t ipa_end,
> @@ -617,7 +781,6 @@ static int populate_par_region(struct kvm *kvm,
>         int idx;
>         phys_addr_t ipa;
>         int ret =3D 0;
> -       struct page *tmp_page;
>         unsigned long data_flags =3D 0;
>
>         base_gfn =3D gpa_to_gfn(ipa_base);
> @@ -639,9 +802,8 @@ static int populate_par_region(struct kvm *kvm,
>                 goto out;
>         }
>
> -       tmp_page =3D alloc_page(GFP_KERNEL);
> -       if (!tmp_page) {
> -               ret =3D -ENOMEM;
> +       if (!kvm_slot_can_be_private(memslot)) {
> +               ret =3D -EINVAL;
>                 goto out;
>         }
>
> @@ -714,31 +876,36 @@ static int populate_par_region(struct kvm *kvm,
>                 for (offset =3D 0; offset < map_size && !ret;
>                      offset +=3D PAGE_SIZE, page++) {
>                         phys_addr_t page_ipa =3D ipa + offset;
> +                       kvm_pfn_t priv_pfn;
> +                       int order;
>
> -                       ret =3D realm_create_protected_data_page(realm, p=
age_ipa,
> -                                                              page, tmp_=
page,
> -                                                              data_flags=
);
> +                       ret =3D kvm_gmem_get_pfn(kvm, memslot,
> +                                              page_ipa >> PAGE_SHIFT,
> +                                              &priv_pfn, &order);
> +                       if (ret)
> +                               break;
> +
> +                       ret =3D realm_create_protected_data_page(
> +                                       realm, page_ipa,
> +                                       pfn_to_page(priv_pfn),
> +                                       page, data_flags);
>                 }
> +
> +               kvm_release_pfn_clean(pfn);
> +
>                 if (ret)
> -                       goto err_release_pfn;
> +                       break;
>
>                 if (level =3D=3D 2) {
>                         ret =3D fold_rtt(realm, ipa, level);
>                         if (ret)
> -                               goto err_release_pfn;
> +                               break;
>                 }
>
>                 ipa +=3D map_size;
> -               kvm_release_pfn_dirty(pfn);
> -err_release_pfn:
> -               if (ret) {
> -                       kvm_release_pfn_clean(pfn);
> -                       break;
> -               }
>         }
>
>         mmap_read_unlock(current->mm);
> -       __free_page(tmp_page);
>
>  out:
>         srcu_read_unlock(&kvm->srcu, idx);
> --
> 2.34.1
>

