Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E637A507C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjIRRHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjIRRHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:07:36 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39788E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:07:30 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34fcc39fae1so4335ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695056850; x=1695661650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYA2c6obTkYF/X7G/B4Xb9ciRYUkDwbnPL4CtJ0MRDU=;
        b=YP10dzWBTrTiDMJKQS4XjPIR57MmjeQcxIYrHCDkz3hCRe0nh780JufaFBJQ8r6E0k
         psEiV+dMvP6PkvoPZHEx3u5DS8QUIvnyY/AZuxl0qiZHtUs16NF3nnJdBdpMMpu586Hf
         mmG11u5Rqz04kwGgsOQFLxihRuygJWfQGhzlJyr7zSEAxnhG4PuHstYA41EhvKcEWrGC
         0DQnmnzX35+CyoFrPze61wZnce08NbQbt9qazBjMhCiXsnFp0rhE2vf9agbzJ66qljH4
         4nfOFmOMcQO+un9ZaVwf9cix0EBcNgywmtX63ZCdMPQ11V2uzx2iMT5sudnqV/u0SJ2n
         /0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695056850; x=1695661650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYA2c6obTkYF/X7G/B4Xb9ciRYUkDwbnPL4CtJ0MRDU=;
        b=dEg7SHcVfUL7oAQKEXGgPqCkqFp9XL2Alj7SeRSAYGJsRvbiXE8K7YBCx+DSjoWiDf
         ZuwEw6H0iVudALziNs1hukM2leEfyLJeRn4rbMmNipogc7RBAld+x4RwqMHYPgfLAFsy
         5qrVrDXorD+nCnihQR2zGob6KPLQc38lbPR6uNl3hwXoX3pdz6Dy2bsT1OuyaeErCffO
         BAas/wKAhG6TBihNtxFvy2pywQ42N6zZxfOgMtRWdPTyaRs4Pw8ZPqHULU3pdEOgku2U
         MNGHjHM7gkdEkzkQvyqkfK2SASXnK14KJ1MW9mnlehXpNlYM3SVbkqwJqbvK2YYdBCSF
         LHZw==
X-Gm-Message-State: AOJu0YxJ0XIQjDs2RDkwFlha/OZfYNVNdL2NHBR23XPAGZ2b/dtUt3zn
        LuJwRpZXqmRi44Z/8Ujr4QGaMuxBtD7Tmu3BMxjCXQ==
X-Google-Smtp-Source: AGHT+IGVdeQMwoGs8//hYqXO7csKKsfJ0eIi9bZUpFtpSAzGyoAbEGyZpqkX1zVCm9RwmUqBlnWF0EA3iIlyCely84U=
X-Received: by 2002:a05:6e02:170f:b0:34d:f90f:d42a with SMTP id
 u15-20020a056e02170f00b0034df90fd42amr602937ill.1.1695056850063; Mon, 18 Sep
 2023 10:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230817003029.3073210-1-rananta@google.com> <20230817003029.3073210-9-rananta@google.com>
 <ZQTEN664F/5PzyId@linux.dev>
In-Reply-To: <ZQTEN664F/5PzyId@linux.dev>
From:   Raghavendra Rao Ananta <rananta@google.com>
Date:   Mon, 18 Sep 2023 10:07:18 -0700
Message-ID: <CAJHc60wUgvmXHajwV2cb+f1aLOu7Zb+VyckedENPzsPw2URBGA@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] KVM: arm64: PMU: Allow userspace to limit
 PMCR_EL0.N for the guest
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Marc Zyngier <maz@kernel.org>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shaoqin Huang <shahuang@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 1:53=E2=80=AFPM Oliver Upton <oliver.upton@linux.de=
v> wrote:
>
> Hi Raghu,
>
> On Thu, Aug 17, 2023 at 12:30:25AM +0000, Raghavendra Rao Ananta wrote:
> > From: Reiji Watanabe <reijiw@google.com>
> >
> > KVM does not yet support userspace modifying PMCR_EL0.N (With
> > the previous patch, KVM ignores what is written by upserspace).
>
> typo: userspace
>
Noted.
> > diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> > index ce7de6bbdc967..39ad56a71ad20 100644
> > --- a/arch/arm64/kvm/pmu-emul.c
> > +++ b/arch/arm64/kvm/pmu-emul.c
> > @@ -896,6 +896,7 @@ int kvm_arm_set_vm_pmu(struct kvm *kvm, struct arm_=
pmu *arm_pmu)
> >        * while the latter does not.
> >        */
> >       kvm->arch.pmcr_n =3D arm_pmu->num_events - 1;
> > +     kvm->arch.pmcr_n_limit =3D arm_pmu->num_events - 1;
>
> Can't we just get at this through the arm_pmu instance rather than
> copying it into kvm_arch?
>
Yeah, I suppose we can directly access it in set_pmcr().

Thank you.
Raghavendra
> >       return 0;
> >  }
> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 2075901356c5b..c01d62afa7db4 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -1086,6 +1086,51 @@ static int get_pmcr(struct kvm_vcpu *vcpu, const=
 struct sys_reg_desc *r,
> >       return 0;
> >  }
> >
> > +static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *=
r,
> > +                 u64 val)
> > +{
> > +     struct kvm *kvm =3D vcpu->kvm;
> > +     u64 new_n, mutable_mask;
> > +     int ret =3D 0;
> > +
> > +     new_n =3D FIELD_GET(ARMV8_PMU_PMCR_N, val);
> > +
> > +     mutex_lock(&kvm->arch.config_lock);
> > +     if (unlikely(new_n !=3D kvm->arch.pmcr_n)) {
> > +             /*
> > +              * The vCPU can't have more counters than the PMU
> > +              * hardware implements.
> > +              */
> > +             if (new_n <=3D kvm->arch.pmcr_n_limit)
> > +                     kvm->arch.pmcr_n =3D new_n;
> > +             else
> > +                     ret =3D -EINVAL;
> > +     }
>
> Hmm, I'm not so sure about returning an error here. ABI has it that
> userspace can write any value to PMCR_EL0 successfully. Can we just
> ignore writes that attempt to set PMCR_EL0.N to something higher than
> supported by hardware? Our general stance should be that system register
> fields responsible for feature identification are immutable after the VM
> has started.
>
> --
> Thanks,
> Oliver
