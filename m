Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679E7C8CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 20:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjJMSUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 14:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJMSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 14:20:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E810BE;
        Fri, 13 Oct 2023 11:19:57 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-536b39daec1so4038444a12.2;
        Fri, 13 Oct 2023 11:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697221196; x=1697825996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0exkzigYjCynzbnJQu8JnrQ0VCvKe1L1o155nHPvIQ=;
        b=Ju1hfa8puFQAzMpNXy58Bye+ScV0j7sZlgworBPyHFOvolYcY4K442ID2lbB4e6BuW
         /gXm8iuNNwcIIO1BzM509rlVDj1/eCvDnANnuDsIUqcGJge5ij4+1+wRh5ZUQmXfphy7
         k8X4N2flW40+wd7RwKpWrDIqOuWq3g69W/h5i5mrdbM9Y4NnDyQ/KAP9fIXq2UoR3vIn
         bEGXHRw34wvV4m7xqcJ2bbpQaZrqzGRK9oFNcO0Pr7JokHD2QZRpUutRQ+qVWlHErguR
         NeZh6SRCnssOfAm2PKPnGCCxsFlDtQwmeCXT7a97daHrYbgBWKOvT+Eo3+2JlukzJen8
         EDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697221196; x=1697825996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0exkzigYjCynzbnJQu8JnrQ0VCvKe1L1o155nHPvIQ=;
        b=pvWU+MlUxhFQgcRcVxbcFTWE85a8mgyD7XhLh80PRmLdU4CaGjKF8cWMsZSYRjXx/q
         OkEb9pkyHU7+ELQEN2yLePPr9WNVT9Fu710rCwNm8O0/TG96QYIkrDtQuixjzU1GImTM
         3iMJ/PSH4BJrsqXkQ++QE+3GfhXf/CcyaODI+DExqMRAlOw3HJRCh5OCm8Wm3fQYEmg8
         3OCbGgyllRE6Uh+0HOfchpgRpbPHg+sRbxgjTfqNeroyvm+J8u9nbmtySob1eNLf2x3H
         jC8bRsu0Opax6qZuKiOHfeJ6WnAuuuOMyzIqlM7HSuEeWUi7igSKAFpM+aGRE+3r82wP
         NZFg==
X-Gm-Message-State: AOJu0YzljIr6y96XwIW4BkrIyewwrhEJLWtLbk/kWqAGVV/ItQ8oCzYR
        Cr+sk4tnji5d2L+zy3yXq7K8lAFxT232DFtKqok=
X-Google-Smtp-Source: AGHT+IFbNiIX6/ULO8X8yCSIGnQtzYCarr/gXTjiNPfLhOCE4S5Pa/TiD8MBt0ZVpqRWb9UkYXbpAZR/Ltl2qGwUn8o=
X-Received: by 2002:a05:6402:f1c:b0:53d:e990:b8dc with SMTP id
 i28-20020a0564020f1c00b0053de990b8dcmr7329570eda.3.1697221195690; Fri, 13 Oct
 2023 11:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20231010173924.44167-1-jandryuk@gmail.com> <9cda7031-286f-42e6-a23f-80c284931696@intel.com>
In-Reply-To: <9cda7031-286f-42e6-a23f-80c284931696@intel.com>
From:   Jason Andryuk <jandryuk@gmail.com>
Date:   Fri, 13 Oct 2023 14:19:43 -0400
Message-ID: <CAKf6xpt1UdvJw7YZ5K6TBes_kXUv+7qm+gGW98=hPTu2p53eEg@mail.gmail.com>
Subject: Re: [PATCH v3] acpi/processor: sanitize _OSC/_PDC capabilities for
 Xen dom0
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Roger Pau Monne <roger.pau@citrix.com>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for taking a look, Michal.

On Fri, Oct 13, 2023 at 12:17=E2=80=AFPM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
> Hi,
>
> On 10/10/2023 7:39 PM, Jason Andryuk wrote:
> > From: Roger Pau Monne <roger.pau@citrix.com>
> >
> > The Processor capability bits notify ACPI of the OS capabilities, and
> > so ACPI can adjust the return of other Processor methods taking the OS
> > capabilities into account.
> >
> > When Linux is running as a Xen dom0, the hypervisor is the entity
> > in charge of processor power management, and hence Xen needs to make
> > sure the capabilities reported by _OSC/_PDC match the capabilities of
> > the driver in Xen.
> >
> > Introduce a small helper to sanitize the buffer when running as Xen
> > dom0.
> >
> > When Xen supports HWP, this serves as the equivalent of commit
> > a21211672c9a ("ACPI / processor: Request native thermal interrupt
> > handling via _OSC") to avoid SMM crashes.  Xen will set bit
> > ACPI_PROC_CAP_COLLAB_PROC_PERF (bit 12) in the capability bits and the
> > _OSC/_PDC call will apply it.
> >
> > [ jandryuk: Mention Xen HWP's need.  Support _OSC & _PDC ]
> > Signed-off-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
> > ---
> > v3:
> > Move xen_sanitize_pdc() call to arch_acpi_set_proc_cap_bits() to cover
> > _OSC and _PDC.
> > drivers/xen/pcpu.c is CONFIG_DOM0 && CONFIG_X86
> >
> > v2:
> > Move local variables in acpi_processor_eval_pdc() to reuse in both cond=
itions.
> > ---
> >  arch/x86/include/asm/acpi.h           | 13 +++++++++++++
> >  arch/x86/include/asm/xen/hypervisor.h |  9 +++++++++
> >  drivers/xen/pcpu.c                    | 21 +++++++++++++++++++++
> >  3 files changed, 43 insertions(+)
> >
> > diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
> > index c8a7fc23f63c..cc8d1669d6e8 100644
> > --- a/arch/x86/include/asm/acpi.h
> > +++ b/arch/x86/include/asm/acpi.h
> > @@ -16,6 +16,9 @@
> >  #include <asm/x86_init.h>
> >  #include <asm/cpufeature.h>
> >  #include <asm/irq_vectors.h>
> > +#include <asm/xen/hypervisor.h>
> > +
> > +#include <xen/xen.h>
> >
> >  #ifdef CONFIG_ACPI_APEI
> >  # include <asm/pgtable_types.h>
> > @@ -127,6 +130,16 @@ static inline void arch_acpi_set_proc_cap_bits(u32=
 *cap)
> >       if (!cpu_has(c, X86_FEATURE_MWAIT) ||
> >           boot_option_idle_override =3D=3D IDLE_NOMWAIT)
> >               *cap &=3D ~(ACPI_PROC_CAP_C_C1_FFH | ACPI_PROC_CAP_C_C2C3=
_FFH);
> > +
> > +     if (xen_initial_domain()) {
> > +             /*
> > +              * When Linux is running as Xen dom0, the hypervisor is t=
he
> > +              * entity in charge of the processor power management, an=
d so
> > +              * Xen needs to check the OS capabilities reported in the=
 _PDC
>
> I would argue the phrasing here is unfortunate - it's not really _PDC buf=
fer anymore,
> it's more processor capabilities buffer [1]. Your phrasing would indicate=
 that this
> buffer is somehow _PDC specific.

Ok.

> BTW this file is x86 specific code - are you sure it's appropriate to inv=
olve Xen
> hypervisor here ? I understand this case if x86 specific, but still.

The Xen hypercall is x86-specific.  I see
`arch_acpi_set_proc_cap_bits()` as a hook to set arch-specific bits.
Looking at Xen/x86 as the arch, it makes sense.  The other option
would be a Xen conditional back in the acpi code.  Keeping it with the
x86 code therefore made more sense to me.

> > +              * buffer matches what the hypervisor driver supports.
> > +              */
> > +             xen_sanitize_pdc(cap);
>
> Same here as in [1], I would call this function xen_sanitize_proc_cap_buf=
fer(),
> or something along those lines for better readability and correctness.

Ok.

> > +     }
> >  }
> >
> >  static inline bool acpi_has_cpu_in_madt(void)
> > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/a=
sm/xen/hypervisor.h
> > index 7048dfacc04b..c6c2f174fa30 100644
> > --- a/arch/x86/include/asm/xen/hypervisor.h
> > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > @@ -100,4 +100,13 @@ static inline void leave_lazy(enum xen_lazy_mode m=
ode)
> >
> >  enum xen_lazy_mode xen_get_lazy_mode(void);
> >
> > +#if defined(CONFIG_XEN_DOM0) && defined(CONFIG_ACPI)
> > +void xen_sanitize_pdc(uint32_t *buf);
> > +#else
> > +static inline void xen_sanitize_pdc(uint32_t *buf)
> > +{
> > +     BUG();
> > +}
> > +#endif
> > +
> >  #endif /* _ASM_X86_XEN_HYPERVISOR_H */
> > diff --git a/drivers/xen/pcpu.c b/drivers/xen/pcpu.c
> > index b3e3d1bb37f3..859bb6027105 100644
> > --- a/drivers/xen/pcpu.c
> > +++ b/drivers/xen/pcpu.c
> > @@ -47,6 +47,9 @@
> >  #include <asm/xen/hypervisor.h>
> >  #include <asm/xen/hypercall.h>
> >
> > +#ifdef CONFIG_ACPI
> > +#include <acpi/processor.h>
> > +#endif
> >
> >  /*
> >   * @cpu_id: Xen physical cpu logic number
> > @@ -400,4 +403,22 @@ bool __init xen_processor_present(uint32_t acpi_id=
)
> >
> >       return online;
> >  }
> > +
> > +void xen_sanitize_pdc(uint32_t *cap)
> > +{
> > +     struct xen_platform_op op =3D {
> > +             .cmd                    =3D XENPF_set_processor_pminfo,
> > +             .u.set_pminfo.id        =3D -1,
> > +             .u.set_pminfo.type      =3D XEN_PM_PDC,
>
> It would probably be best to rename this constant as well so it's
> not misleading.

That is a Xen constant, so we can't change it.

> > +     };
> > +     u32 buf[3] =3D { ACPI_PDC_REVISION_ID, 1, *cap };
> > +     int ret;
> > +
> > +     set_xen_guest_handle(op.u.set_pminfo.pdc, buf);
> > +     ret =3D HYPERVISOR_platform_op(&op);
> > +     if (ret)
> > +             pr_info("sanitize of _PDC buffer bits from Xen failed: %d=
\n",
> > +                     ret);
>
> Shouldn't an error be pr_err ?

Sure.

> > +     *cap =3D buf[2];
> > +}
> >  #endif

Thanks,
Jason
