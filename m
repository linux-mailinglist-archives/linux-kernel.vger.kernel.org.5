Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCCC80F1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346687AbjLLQDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346680AbjLLQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:03:30 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279EA1A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:03:35 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so81246041fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1702397014; x=1703001814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP8xfxj50VGqrIkZIkHug1SrPRuuFi/XxUsjHmRpfqM=;
        b=bKXm2MfwhdIl3ko9rMq6oi7NfeNZMUoYAgURZnBfxWhA9Oxv1lnHS/JPLHkUhZwlG9
         Z6kRLbx2c/XFI/FHYFfbsB2O9QKwEefyRODK/7WYLs6GqGlrYiVSf5cYF6sx70H/pC1Z
         IivaH6zhYVQ5QT/VkFwlctnhGYIU3jb080DWCVFsI4/++5Cl7EibRt8e4ZadTekr/hkb
         NUGYDeE1IZHpGIlLYfHXl8WWUYv3nac6FXzFS5/mu1l765MLDL3Nehl9AiDwrUNQLQgT
         V4O8w1/OjRyVm1BWLiEWPRfTmp3tMtC3V8UzsroEyly8yA/UnUS6FztHzqaV+I2GKsoN
         8I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397014; x=1703001814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QP8xfxj50VGqrIkZIkHug1SrPRuuFi/XxUsjHmRpfqM=;
        b=X5Z13HxywlF1HP0nFRomplQV3/SxpDk3WZUiOAoMPNp6QrI3sHk6WeqfVJY7yV4vDO
         AeIogef7fgmlvTZcWes4pKQi8eac4taIXBpBBup/vKPY+HLkbjm/CtdHhlAum8Y8xZKC
         ifNOQaUzif3ueqsGbwCNLWMbxQMx2jUF8I3XsjV/02VAlDzt3VB7kdk3Jat/ejDD7qRV
         Pzrdp51iK4LeQPxcxcVTfWRH3hjfcF95X0gYTUcQ3ikyoxbz9cdADCK67eAAi4caT8wO
         oHZBi1zov8XdNIotW4JcK8faadnArmMvZ2I52TmUeOq6Y2ilzEPc+GDtUNBMjbOtpVMQ
         ImpQ==
X-Gm-Message-State: AOJu0YzI9ytxW8iE24A4RvjSILw3y3FWX6GkGCa92L3XvmPc7HJ1P/jo
        iKg7E4EqW1kXnso0URAkdGno65n2ZUSJLJC3pabWKQ==
X-Google-Smtp-Source: AGHT+IEz0+50MDCsAQHZ+397Z3sl+6IBS7BadUyZHh4qtGCJPyOtz95wQCVulFs0PwkrFNz1kcnuxWiP/zSSNoxxtu8=
X-Received: by 2002:a2e:97c7:0:b0:2ca:24e0:f87f with SMTP id
 m7-20020a2e97c7000000b002ca24e0f87fmr2556071ljj.56.1702397013574; Tue, 12 Dec
 2023 08:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20231212053501.12054-1-yongxuan.wang@sifive.com>
In-Reply-To: <20231212053501.12054-1-yongxuan.wang@sifive.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 12 Dec 2023 21:33:22 +0530
Message-ID: <CAK9=C2VOXj5oCAZEPS24K98UmQycupoJCcATGDNr+HFr9aVCPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISCV: KVM: should not be interrupted when update the
 external interrupt pending
To:     Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:05=E2=80=AFAM Yong-Xuan Wang
<yongxuan.wang@sifive.com> wrote:
>
> The emulated IMSIC update the external interrupt pending depending on the
> value of eidelivery and topei. It might lose an interrupt when it is
> interrupted before setting the new value to the pending status.

More simpler PATCH subject can be:
"RISCV: KVM: update external interrupt atomically for IMSIC swfile"

>
> For example, when VCPU0 sends an IPI to VCPU1 via IMSIC:
>
> VCPU0                           VCPU1
>
>                                 CSRSWAP topei =3D 0
>                                 The VCPU1 has claimed all the external
>                                 interrupt in its interrupt handler.
>
>                                 topei of VCPU1's IMSIC =3D 0
>
> set pending in VCPU1's IMSIC
>
> topei of VCPU1' IMSIC =3D 1
>
> set the external interrupt
> pending of VCPU1
>
>                                 clear the external interrupt pending
>                                 of VCPU1
>
> When the VCPU1 switches back to VS mode, it exits the interrupt handler
> because the result of CSRSWAP topei is 0. If there are no other external
> interrupts injected into the VCPU1's IMSIC, VCPU1 will never know this
> pending interrupt unless it initiative read the topei.
>
> If the interruption occurs between updating interrupt pending in IMSIC
> and updating external interrupt pending of VCPU, it will not cause a
> problem. Suppose that the VCPU1 clears the IPI pending in IMSIC right
> after VCPU0 sets the pending, the external interrupt pending of VCPU1
> will not be set because the topei is 0. But when the VCPU1 goes back to
> VS mode, the pending IPI will be reported by the CSRSWAP topei, it will
> not lose this interrupt.
>
> So we only need to make the external interrupt updating procedure as a
> critical section to avoid the problem.
>

Please add a "Fixes:" line here

> Tested-by: Roy Lin <roy.lin@sifive.com>
> Tested-by: Wayling Chen <wayling.chen@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  arch/riscv/kvm/aia_imsic.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kvm/aia_imsic.c b/arch/riscv/kvm/aia_imsic.c
> index 6cf23b8adb71..0278aa0ca16a 100644
> --- a/arch/riscv/kvm/aia_imsic.c
> +++ b/arch/riscv/kvm/aia_imsic.c
> @@ -37,6 +37,8 @@ struct imsic {
>         u32 nr_eix;
>         u32 nr_hw_eix;
>
> +       spinlock_t extirq_update_lock;
> +

Please rename this lock to "swfile_extirq_lock".

>         /*
>          * At any point in time, the register state is in
>          * one of the following places:
> @@ -613,12 +615,17 @@ static void imsic_swfile_extirq_update(struct kvm_v=
cpu *vcpu)
>  {
>         struct imsic *imsic =3D vcpu->arch.aia_context.imsic_state;
>         struct imsic_mrif *mrif =3D imsic->swfile;
> +       unsigned long flags;
> +

Add a short summary in a comment block about why external interrupt
updates are required to be in the critical section.

> +       spin_lock_irqsave(&imsic->extirq_update_lock, flags);
>
>         if (imsic_mrif_atomic_read(mrif, &mrif->eidelivery) &&
>             imsic_mrif_topei(mrif, imsic->nr_eix, imsic->nr_msis))
>                 kvm_riscv_vcpu_set_interrupt(vcpu, IRQ_VS_EXT);
>         else
>                 kvm_riscv_vcpu_unset_interrupt(vcpu, IRQ_VS_EXT);
> +
> +       spin_unlock_irqrestore(&imsic->extirq_update_lock, flags);
>  }
>
>  static void imsic_swfile_read(struct kvm_vcpu *vcpu, bool clear,
> @@ -1029,6 +1036,7 @@ int kvm_riscv_vcpu_aia_imsic_init(struct kvm_vcpu *=
vcpu)
>         imsic->nr_eix =3D BITS_TO_U64(imsic->nr_msis);
>         imsic->nr_hw_eix =3D BITS_TO_U64(kvm_riscv_aia_max_ids);
>         imsic->vsfile_hgei =3D imsic->vsfile_cpu =3D -1;
> +       spin_lock_init(&imsic->extirq_update_lock);
>
>         /* Setup IMSIC SW-file */
>         swfile_page =3D alloc_pages(GFP_KERNEL | __GFP_ZERO,
> --
> 2.17.1
>
>

Regards,
Anup
