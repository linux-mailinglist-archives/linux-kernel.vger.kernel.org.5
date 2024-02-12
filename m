Return-Path: <linux-kernel+bounces-61321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9948510FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45591F216B8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D962738F94;
	Mon, 12 Feb 2024 10:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwLY2a0d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1D383BF
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734089; cv=none; b=pgON9+sWTXkEKhCYz60D4NdO94xd6dv1bHcut0l3/Ua05A4VacQ4sjxQdreOaT+7l8RH4lrfpyCRYwHhFPCs+43y6+hnux5Y+2hhv6Ro3EUehWOckPmeKWy5j40RywyyzlV5Yj+XkZGo7Be7DQZm+4Hu/9ZvSKrMTtRQg4yKZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734089; c=relaxed/simple;
	bh=EoFkIvo0jVT7iACpJyA0SYfSyvqCf8/ZdX+R+C/HGAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBGtsF0dPSeTmT8K1BoM0D5f6c/Yh9nykuQiKjoFyLqY8aUUGMvWHhC+Zs47Ty47lKR+xr4IGGOKgfCJKr2jRm+/5KuvNDQAadYutq8rT1dUcPEVBhYUFoeX9jOJuFrTuRryIKwCznPPdLtJUzHbHtP96tfScOKtZCpiDbd8nc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwLY2a0d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707734086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tgpAN4/fM2uvng00mD2oqsBNpUIMHVV2+w/F9N6+DNQ=;
	b=NwLY2a0dbxPe24dtx9C+dRUCS+PbhIA9c5uUOUJkFLjNKFQgXpRwztyLLulFmGsQASW5Zx
	tsvxK38iSaxtmcIc4QtqgTjcv5CoIEDGBX3OEb5dydKAhsPw401tx6ctCF/Q6CX7GyDOfd
	gVusA3p6lGEYThIJUxWmDZ0W0Ki3EB8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-BU4U0hmZMRu1-TqgKjBO3Q-1; Mon, 12 Feb 2024 05:34:45 -0500
X-MC-Unique: BU4U0hmZMRu1-TqgKjBO3Q-1
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-7d326aa3f86so1725208241.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707734082; x=1708338882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgpAN4/fM2uvng00mD2oqsBNpUIMHVV2+w/F9N6+DNQ=;
        b=Gu6ZeyMIPmdJ/W/bngaE6cSZzhiSEwQ+3d17zXnrY2vPNxprkGPNhNqgrD9Z/QKJfl
         Kwm21jy+DowhtgzPUCjrhTIAjsU537FNTkjy+fdPlVbRD2NlbDgN/JuNgP8969nt/eb7
         omqkxNzfXZh2Vt6DoHVn3Ng/bKtgtA5b46oK32qni9IF8T1JM2ZuGH6YuZlKKnMJeDsC
         U1qgMw3N4OkdccJ+EgZW9JeDb4txTTD9E24/meKZ/lFUGaXl4kMlMavnOmM7vygJURNC
         IWW6q66Qb4zCwrDcuI1C8jFRs0nZop+5eHeeLoDMkMdVWSlH90NZ8Dsvjo+e7BWOp7VU
         d0lw==
X-Forwarded-Encrypted: i=1; AJvYcCVAxQTRdJyLRAkaDd4QF67PrqREhgAmrHgvjvtBsm1s12u8MJF4JdGmNeRb5srebwntUP2WpHYhi6U1K0JfbBHHdTP8yPba9cWCYrQk
X-Gm-Message-State: AOJu0YxS/gf+6xsNdDAIquMa9tM36Xi/cfsSySYJ486Jip6i4xN1PT/k
	HkHpIlPdFoAwdzxWwY5RfF5X/xGmW/pXLmA6pGxTuGmG1tYBR3Y6ai7fByIJJYx2Ghc+Vullr6C
	PLpGP4aZ0iwbY1rGilC9hBci2HXX9j6u5QVPoIJKn6Ib3lbLQer4HnhvOGFf68i4ySZ7uJaW92O
	qqN3HXB5edCND+HxPeTLd7lqdq0jzt3wpnLkip
X-Received: by 2002:a05:6102:116f:b0:46d:2d95:5c15 with SMTP id k15-20020a056102116f00b0046d2d955c15mr3800833vsg.13.1707734081984;
        Mon, 12 Feb 2024 02:34:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMKwEPA7aCJ3CTH/U8+IoQs6Vt+T3sXtGQG3F/44PHdppD0ZaTuixrHMSXjQ4m9T3C19OL3I7hoVosabGmzsI=
X-Received: by 2002:a05:6102:116f:b0:46d:2d95:5c15 with SMTP id
 k15-20020a056102116f00b0046d2d955c15mr3800789vsg.13.1707734080219; Mon, 12
 Feb 2024 02:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <d99863c474b8a3d9e413fbf940bf6891d2ce319e.1705965635.git.isaku.yamahata@intel.com>
In-Reply-To: <d99863c474b8a3d9e413fbf940bf6891d2ce319e.1705965635.git.isaku.yamahata@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 12 Feb 2024 11:34:28 +0100
Message-ID: <CABgObfbu1-Ok607uYdo4DzwZf8ZGVQnvHU+y9_M1Zae55K5xwQ@mail.gmail.com>
Subject: Re: [PATCH v18 041/121] KVM: x86/mmu: Allow per-VM override of the
 TDP max page level
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Sagi Shahar <sagis@google.com>, Kai Huang <kai.huang@intel.com>, 
	chen.bo@intel.com, hang.yuan@intel.com, tina.zhang@intel.com, 
	Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 12:55=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> TDX requires special handling to support large private page.  For
> simplicity, only support 4K page for TD guest for now.  Add per-VM maximu=
m
> page level support to support different maximum page sizes for TD guest a=
nd
> conventional VMX guest.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>

Please reimplement this on top of "KVM: x86: Add gmem hook for
determining max NPT mapping level" from the SEV-SNP series.

Paolo


> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/mmu/mmu.c          | 2 ++
>  arch/x86/kvm/mmu/mmu_internal.h | 2 +-
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 430d7bd7c37c..313519edd79e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1283,6 +1283,7 @@ struct kvm_arch {
>         unsigned long n_requested_mmu_pages;
>         unsigned long n_max_mmu_pages;
>         unsigned int indirect_shadow_pages;
> +       int tdp_max_page_level;
>         u8 mmu_valid_gen;
>         struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
>         struct list_head active_mmu_pages;
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 54d4c8f1ba68..e93bc16a5e9b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -6307,6 +6307,8 @@ void kvm_mmu_init_vm(struct kvm *kvm)
>
>         kvm->arch.split_desc_cache.kmem_cache =3D pte_list_desc_cache;
>         kvm->arch.split_desc_cache.gfp_zero =3D __GFP_ZERO;
> +
> +       kvm->arch.tdp_max_page_level =3D KVM_MAX_HUGEPAGE_LEVEL;
>  }
>
>  static void mmu_free_vm_memory_caches(struct kvm *kvm)
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_inter=
nal.h
> index 0443bfcf5d9c..2b9377442927 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -296,7 +296,7 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vc=
pu *vcpu, gpa_t cr2_or_gpa,
>                 .nx_huge_page_workaround_enabled =3D
>                         is_nx_huge_page_enabled(vcpu->kvm),
>
> -               .max_level =3D KVM_MAX_HUGEPAGE_LEVEL,
> +               .max_level =3D vcpu->kvm->arch.tdp_max_page_level,
>                 .req_level =3D PG_LEVEL_4K,
>                 .goal_level =3D PG_LEVEL_4K,
>         };
> --
> 2.25.1
>


