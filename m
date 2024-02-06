Return-Path: <linux-kernel+bounces-55555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F1184BE12
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0EC81F2548C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE49168DC;
	Tue,  6 Feb 2024 19:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZgETXBM"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F67C1427E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707247584; cv=none; b=AKgZJuhc5c0uKB3kqK8RwaC6AbVX4QP6uycB0WrBxbGx22CKHEL3xjUYGSkYBbibHrYDcDmtZr1zuPPSLfvWyL6zKNLHI1UEr4Elck/J/+mg+IPp5eQeZCNAuKBQm7Jng11cswh+7OaVLM0uxTtIfATM+JoBdyyE2vB6NBI/ThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707247584; c=relaxed/simple;
	bh=2IVNfTFN74V9QsXarcsI9Qa3mRL5DTVBDrkPHn2//J4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOZaiGSlzk33hXt1Pn0rW7TsVc1PtKrPhO9KAM0RXJ/ioXpyuBUdk9DV5sLprsHGygcqyXXx/WJJkkTDNMVi7ITCmNs592W7C8WofP3cZCodF43ihYoV/Hmojs50zw3RJXBDC7gwSJRqPI9LxyAOLcZnbzu7esqXLhZjae+5PPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZgETXBM; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511206d1c89so8678419e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707247580; x=1707852380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upl/2DpL4kPgGQe8I7dejnn2s278HRsnVm1Xw4wi8yc=;
        b=OZgETXBM/lPx2euz9TELUFVpp3POsjbLk11PxKNGTyFquQO6stNskdZ2drV6k3G9rc
         W+J2n2wnxdOE2wNE/HeaE9DR2kq9H7oLdesjSk59o0zUkHtAi9X6c7X0POk5jyQly3XE
         cvbFFa0buWVUcqhe7GWm4rdW0HHYnGPp2wzXKoCU2GDmlyonRQlsm9PtNjj2Klne+Yti
         zZiINkTYLKKCJFk7nAXNk/xiucTo6/g6Wl2mYn3Bby0QFitiir8A5vE7RIDtBYEKgy5C
         tB5fOdS4zzXF6H5snytgK7tyh+wxf2UDNCtqiosMIjITyoHlWZs6mFMZyQZ3I7nJaE+J
         6ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707247580; x=1707852380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upl/2DpL4kPgGQe8I7dejnn2s278HRsnVm1Xw4wi8yc=;
        b=hW3K9IiXTHIjGGI+dj0OEoRHWUqsoBr4l8o2M5s4bKlNvweb4UT+47QhLyTrLCIZI6
         wQ2nzL6KL6yP/1hG90w9hK3cuxe2Cjqjtlq/77/V6m7R3HbA5Z5YM4bh4hvQJGNIsrhQ
         qJjECq7Wp4dEZbG/6EuLMvOMs+4RbjkcxyxRnf2iuw6Ywnla75bdHZ29P8LvNWHw/1O8
         WIAT0oQnJMbX4ljnqWkZmNYsJ7sgNhNHoxGEmJE+zck2GuyFPNyV8JKa8PMVArt6Puo1
         uVYai3n5lS/fBgLOBz/Vpopnts2MuAly3PT8be7Lk8TCF9wmHPf6hZlIyEeM+BkN7r+i
         RHvA==
X-Gm-Message-State: AOJu0Yy3cWDJuCxHLnvPRlX0HUReXsEcTs1jhEy4Y7Jtob/S/NAknw+1
	QaSbjWyadpHAaE2GFe6CsRLTXYxcRjSucAnYixRfcLUF4GvmxIL/mui6EM6Kvd+0Z4CaJsoEGlu
	ZKMlIgPEMvTAaE+bUewvGidZnShYn47rbip0n
X-Google-Smtp-Source: AGHT+IG+tvKN/pRkaEnin+a71EeSaheXzc94ai9MnINUEVrkSa0dR8ilsgGoU4rIjkVl4x7PWjkGCyUxO5doIqdgicI=
X-Received: by 2002:a05:6512:480c:b0:511:6512:9d3e with SMTP id
 eo12-20020a056512480c00b0051165129d3emr9716lfb.33.1707247579889; Tue, 06 Feb
 2024 11:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705965634.git.isaku.yamahata@intel.com> <1a64f798b550dad9e096603e8dae3b6e8fb2fbd5.1705965635.git.isaku.yamahata@intel.com>
In-Reply-To: <1a64f798b550dad9e096603e8dae3b6e8fb2fbd5.1705965635.git.isaku.yamahata@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 6 Feb 2024 11:26:07 -0800
Message-ID: <CAAhR5DEpX1AMQ1EwFB9TsvRufZ5Cwvpx2u9xGtXU5gbQA67fxg@mail.gmail.com>
Subject: Re: [PATCH v18 063/121] KVM: x86/mmu: Introduce kvm_mmu_map_tdp_page()
 for use by TDX
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, chen.bo@intel.com, 
	hang.yuan@intel.com, tina.zhang@intel.com, 
	Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 3:56=E2=80=AFPM <isaku.yamahata@intel.com> wrote:
>
> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Introduce a helper to directly (pun intended) fault-in a TDP page
> without having to go through the full page fault path.  This allows
> TDX to get the resulting pfn and also allows the RET_PF_* enums to
> stay in mmu.c where they belong.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
> v14 -> v15:
> - Remove loop in kvm_mmu_map_tdp_page() and return error code based on
>   RET_FP_xxx value to avoid potential infinite loop.  The caller should
>   loop on -EAGAIN instead now.
> ---
>  arch/x86/kvm/mmu.h     |  3 +++
>  arch/x86/kvm/mmu/mmu.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index bad6a1e43a54..ebf91b605c37 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -184,6 +184,9 @@ static inline void kvm_mmu_refresh_passthrough_bits(s=
truct kvm_vcpu *vcpu,
>         __kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
>  }
>
> +int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_cod=
e,
> +                        int max_level);
> +
>  /*
>   * Check if a given access (described through the I/D, W/R and U/S bits =
of a
>   * page fault error code pfec) causes a permission fault with the given =
PTE
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7db152f46d82..26d215e85b76 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4635,6 +4635,63 @@ int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, stru=
ct kvm_page_fault *fault)
>         return direct_page_fault(vcpu, fault);
>  }
>
> +int kvm_mmu_map_tdp_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_cod=
e,
> +                        int max_level)
> +{
> +       int r;
> +       struct kvm_page_fault fault =3D (struct kvm_page_fault) {
> +               .addr =3D gpa,
> +               .error_code =3D error_code,
> +               .exec =3D error_code & PFERR_FETCH_MASK,
> +               .write =3D error_code & PFERR_WRITE_MASK,
> +               .present =3D error_code & PFERR_PRESENT_MASK,
> +               .rsvd =3D error_code & PFERR_RSVD_MASK,
> +               .user =3D error_code & PFERR_USER_MASK,
> +               .prefetch =3D false,
> +               .is_tdp =3D true,
> +               .is_private =3D error_code & PFERR_GUEST_ENC_MASK,
> +               .nx_huge_page_workaround_enabled =3D is_nx_huge_page_enab=
led(vcpu->kvm),
> +       };
> +
> +       WARN_ON_ONCE(!vcpu->arch.mmu->root_role.direct);
> +       fault.gfn =3D gpa_to_gfn(fault.addr) & ~kvm_gfn_shared_mask(vcpu-=
>kvm);
> +       fault.slot =3D kvm_vcpu_gfn_to_memslot(vcpu, fault.gfn);
> +
> +       r =3D mmu_topup_memory_caches(vcpu, false);
> +       if (r)
> +               return r;
> +
> +       fault.max_level =3D max_level;
> +       fault.req_level =3D PG_LEVEL_4K;
> +       fault.goal_level =3D PG_LEVEL_4K;
> +
> +#ifdef CONFIG_X86_64
> +       if (tdp_mmu_enabled)
> +               r =3D kvm_tdp_mmu_page_fault(vcpu, &fault);
> +       else
> +#endif
> +               r =3D direct_page_fault(vcpu, &fault);

Are we ever going to hit the direct_page_fault case? I thought TDX
only supported tdp_mmu?

> +
> +       if (is_error_noslot_pfn(fault.pfn) || vcpu->kvm->vm_bugged)
> +               return -EFAULT;
> +
> +       switch (r) {
> +       case RET_PF_RETRY:
> +               return -EAGAIN;
> +
> +       case RET_PF_FIXED:
> +       case RET_PF_SPURIOUS:
> +               return 0;
> +
> +       case RET_PF_CONTINUE:
> +       case RET_PF_EMULATE:
> +       case RET_PF_INVALID:
> +       default:
> +               return -EIO;
> +       }
> +}
> +EXPORT_SYMBOL_GPL(kvm_mmu_map_tdp_page);
> +
>  static void nonpaging_init_context(struct kvm_mmu *context)
>  {
>         context->page_fault =3D nonpaging_page_fault;
> --
> 2.25.1
>

