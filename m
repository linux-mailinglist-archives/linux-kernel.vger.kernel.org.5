Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330D77718EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 06:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjHGEGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjHGEGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 00:06:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B901709
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 21:06:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so10807964a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 21:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20221208.gappssmtp.com; s=20221208; t=1691381174; x=1691985974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEWPXDn6LTbDwSYJWSCeD5wsbd77oZ0En+w/Ewq960U=;
        b=2oKzq3PvnrlaeNqLKhnUo2MXUv9/MUFGkm3uA4z3oAo6SBKvN7XBZdZXJ28PRMGbGm
         sqWefCy7NX/vo//66AZ0nuIB/WnPHsWNKEyBb42SVIgq95s8L6cIU0+5HSGVwTqLqyDz
         NJq1EpR44emE9nry9CPnlvZwg9sDNDcuR4u5UFnMrGcdL6uLVSrFDrKxkkveDlYQaU4B
         h9WdiRmRjndplp34la+HvmFdwvyI6fkXD7cwuzXnzWzRGsGSISAu4j1HZkev0lfT/1Jj
         pHSerMm6tcuUcU6vmrVPU7e0FxRSBRsmTeyGxtnA3vT8dd1tOgJV03W3vsnCNu/HaP8y
         yFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691381174; x=1691985974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEWPXDn6LTbDwSYJWSCeD5wsbd77oZ0En+w/Ewq960U=;
        b=BDfkmdsfOX1Elc8IMYTCimEcrnHqLka7Mznf7M+4JxdLAZTLAMRl5E7VZoon0bkrIB
         //2cKixzoXTx2AMNsqjW7X7R4IfzpNGrnY04AMjL01I/6SEQn/9qkr9tpCwslg4zmvuR
         fLUfQAlS0Kg7Q0SE49UqTsQAXGURdvPQD/GKk0dlVcLjSoaOVAda+b3xZWLCcIPeDwIk
         K/Wg+RjAq4M4OgSUw1h+w07J+xG9ClbRUMPVQsOPDzVLU2K+LJEEiPLbwxrR5w1+hLty
         iH/ebZ+r/U/Z1v+F8jAyKCwhHER2fzEDDcamu9cP+ZwZR+iY7v/emRPLe05dr/sbsxD7
         SRzg==
X-Gm-Message-State: AOJu0YyVm9YOgICJhtMJ+S4WygKQG1slc6FaVV6Up72/wyyZVGNx+5Lz
        ApMZ95kXfJneQ7Sp5cbnMO5sb6LJ1cIdPITXBJIqHA==
X-Google-Smtp-Source: AGHT+IHkJ8RMNVRzMULpDXQ0KtrFxg5bZylO+ADnFINQziij2vocykBLyKglTdT0sIkr8tWhhF0IS9jMJqoQlJalbxQ=
X-Received: by 2002:a17:907:2ccc:b0:994:1eb4:6896 with SMTP id
 hg12-20020a1709072ccc00b009941eb46896mr6675872ejc.25.1691381174183; Sun, 06
 Aug 2023 21:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230722022251.3446223-1-rananta@google.com> <20230722022251.3446223-5-rananta@google.com>
In-Reply-To: <20230722022251.3446223-5-rananta@google.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 7 Aug 2023 09:36:02 +0530
Message-ID: <CAAhSdy3X+vtKHoYhkJ-wQ9g3BWE4Zh9FTim_XoSqXTTLYpQ2hA@mail.gmail.com>
Subject: Re: [PATCH v7 04/12] KVM: Allow range-based TLB invalidation from
 common code
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Gavin Shan <gshan@redhat.com>,
        Shaoqin Huang <shahuang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 22, 2023 at 7:52=E2=80=AFAM Raghavendra Rao Ananta
<rananta@google.com> wrote:
>
> From: David Matlack <dmatlack@google.com>
>
> Make kvm_flush_remote_tlbs_range() visible in common code and create a
> default implementation that just invalidates the whole TLB.
>
> This paves the way for several future features/cleanups:
>
>  - Introduction of range-based TLBI on ARM.
>  - Eliminating kvm_arch_flush_remote_tlbs_memslot()
>  - Moving the KVM/x86 TDP MMU to common code.
>
> No functional change intended.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

For KVM RISC-V:
Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/mmu/mmu.c          |  9 ++++-----
>  arch/x86/kvm/mmu/mmu_internal.h |  3 ---
>  include/linux/kvm_host.h        |  9 +++++++++
>  virt/kvm/kvm_main.c             | 13 +++++++++++++
>  5 files changed, 29 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index a2d3cfc2eb75..08900afbf2ad 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1804,6 +1804,9 @@ static inline int kvm_arch_flush_remote_tlbs(struct=
 kvm *kvm)
>                 return -ENOTSUPP;
>  }
>
> +#define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u=
64 pages);
> +
>  #define kvm_arch_pmi_in_guest(vcpu) \
>         ((vcpu) && (vcpu)->arch.handling_intr_from_guest)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index ec169f5c7dce..eb88d25f9896 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -278,16 +278,15 @@ static inline bool kvm_available_flush_remote_tlbs_=
range(void)
>         return kvm_x86_ops.flush_remote_tlbs_range;
>  }
>
> -void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn,
> -                                gfn_t nr_pages)
> +int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn, u=
64 pages)
>  {
>         int ret =3D -EOPNOTSUPP;
>
>         if (kvm_x86_ops.flush_remote_tlbs_range)
>                 ret =3D static_call(kvm_x86_flush_remote_tlbs_range)(kvm,=
 start_gfn,
> -                                                                  nr_pag=
es);
> -       if (ret)
> -               kvm_flush_remote_tlbs(kvm);
> +                                                                  pages)=
;
> +
> +       return ret;
>  }
>
>  static gfn_t kvm_mmu_page_get_gfn(struct kvm_mmu_page *sp, int index);
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_inter=
nal.h
> index d39af5639ce9..86cb83bb3480 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -170,9 +170,6 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
>                                     struct kvm_memory_slot *slot, u64 gfn=
,
>                                     int min_level);
>
> -void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t start_gfn,
> -                                gfn_t nr_pages);
> -
>  /* Flush the given page (huge or not) of guest memory. */
>  static inline void kvm_flush_remote_tlbs_gfn(struct kvm *kvm, gfn_t gfn,=
 int level)
>  {
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e3f968b38ae9..a731967b24ff 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1359,6 +1359,7 @@ int kvm_vcpu_yield_to(struct kvm_vcpu *target);
>  void kvm_vcpu_on_spin(struct kvm_vcpu *vcpu, bool yield_to_kernel_mode);
>
>  void kvm_flush_remote_tlbs(struct kvm *kvm);
> +void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 pages);
>
>  #ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
>  int kvm_mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)=
;
> @@ -1486,6 +1487,14 @@ static inline int kvm_arch_flush_remote_tlbs(struc=
t kvm *kvm)
>  }
>  #endif
>
> +#ifndef __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
> +static inline int kvm_arch_flush_remote_tlbs_range(struct kvm *kvm,
> +                                                  gfn_t gfn, u64 pages)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +
>  #ifdef __KVM_HAVE_ARCH_NONCOHERENT_DMA
>  void kvm_arch_register_noncoherent_dma(struct kvm *kvm);
>  void kvm_arch_unregister_noncoherent_dma(struct kvm *kvm);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d6b050786155..804470fccac7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -366,6 +366,19 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>  }
>  EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
>
> +void kvm_flush_remote_tlbs_range(struct kvm *kvm, gfn_t gfn, u64 pages)
> +{
> +       if (!kvm_arch_flush_remote_tlbs_range(kvm, gfn, pages))
> +               return;
> +
> +       /*
> +        * Fall back to a flushing entire TLBs if the architecture range-=
based
> +        * TLB invalidation is unsupported or can't be performed for what=
ever
> +        * reason.
> +        */
> +       kvm_flush_remote_tlbs(kvm);
> +}
> +
>  static void kvm_flush_shadow_all(struct kvm *kvm)
>  {
>         kvm_arch_flush_shadow_all(kvm);
> --
> 2.41.0.487.g6d72f3e995-goog
>
