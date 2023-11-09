Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1E87E7490
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjKIWwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjKIWwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:52:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B9A422E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 14:52:18 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so16918a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 14:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699570337; x=1700175137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxqH4FtJRovfKhN1Doxka0q1j+3qJN1a7cs4m8DTYUA=;
        b=X88YwnP6nAjw1nHtNN8iFCPzi89s9xHGT8JAIrFjPqzKk8CQBoUtEHHAHDX5Z8Bx9O
         YxaPkCzJRnD4WCg/Xgu8vRLaGKAGc762MAPN8iq3HlEbY808sbqTHs1jo62Vf7Brmzvg
         0LUYAxK9dRZa2RfpVIXxOlA1Ejbqpt57scdkm/Ze+12r78/ceal42kmAwLULyB3x3+Yr
         mjQZXNOEA2dhPa4TnGx5zfNQeGvTR1bHAzAPZYH/SOikj+SJMq/Icv3EVfaWeojUc32t
         R5deeIRquwtFPOx0DpTeKlbPK9izJZQYSSvmbivwUyfeJkITkuIVnsLlKg0H39TaOtzM
         1a7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699570337; x=1700175137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxqH4FtJRovfKhN1Doxka0q1j+3qJN1a7cs4m8DTYUA=;
        b=WCum21soU8mf3zAgO2nmhzGcnQndSvdm0+G/aO+tf9hrYbjtbDojuzmwEfIj3YyAFc
         k1dmJiwRzpkHPgwR/GilerbDrfYbDIV3Ry0akBebjqbFJgCSCilM9Iz0j8FFTmOYVMLX
         /tIgudPfMaRNf2dUU6R2y+fxAiL6XsyajHmmeh1kO2Fh71lJBIq3sZrYknAGiK3PEcge
         O73RSDcTdE0fyQDT0q8qkI+fkssjMP8WBQkwlA5CQukOBYk5vgFCF15qQI53htg4oEPH
         uDCTjoNur9Fwj1H471wdnZCWyATMbyghPs5Svz/8QOykLsTJm1dkccPe4wDbzZxfAvxp
         B3SA==
X-Gm-Message-State: AOJu0Ywgc2x2Zr807koXLFaquqArdWeNG/RLfnYJaxXjHKoSux0OemW1
        DKAKaZr/bbhpPvUiPMA/T/4IwBtf26S7quQd0V7QAA==
X-Google-Smtp-Source: AGHT+IFfpgI4oc69D+zRN+BrD4Rejzen8Z66z0NNfhJtPXkl/FH6gpXISpQnZOLdrD6zjX6vrYYitxg55EOamva3ogo=
X-Received: by 2002:aa7:d34a:0:b0:543:fb17:1a8 with SMTP id
 m10-20020aa7d34a000000b00543fb1701a8mr261168edr.3.1699570337024; Thu, 09 Nov
 2023 14:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20231109180646.2963718-1-khorenko@virtuozzo.com> <be70080d-fe76-4bd1-87b9-131eca8c7af1@virtuozzo.com>
In-Reply-To: <be70080d-fe76-4bd1-87b9-131eca8c7af1@virtuozzo.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Nov 2023 14:52:04 -0800
Message-ID: <CALMp9eSg=DZrFcq1ERGMeoEngFLRFtmnQN6t-noFT8T596NAYA@mail.gmail.com>
Subject: Re: KVM: x86/vPMU/AMD: Can we detect PMU is off for a VM?
To:     Konstantin Khorenko <khorenko@virtuozzo.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Denis V. Lunev" <den@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 10:18=E2=80=AFAM Konstantin Khorenko
<khorenko@virtuozzo.com> wrote:
>
> Hi All,
>
> as a followup for my patch: i have noticed that
> currently Intel kernel code provides an ability to detect if PMU is total=
ly disabled for a VM
> (pmu->version =3D=3D 0 in this case), but for AMD code pmu->version is ne=
ver 0,
> no matter if PMU is enabled or disabled for a VM (i mean <pmu state=3D'of=
f'/> in the VM config which
> results in "-cpu pmu=3Doff" qemu option).
>
> So the question is - is it possible to enhance the code for AMD to also h=
onor PMU VM setting or it is
> impossible by design?

The AMD architectural specification prior to AMD PMU v2 does not allow
one to describe a CPU (via CPUID or MSRs) that has fewer than 4
general purpose PMU counters. While AMD PMU v2 does allow one to
describe such a CPU, legacy software that knows nothing of AMD PMU v2
can expect four counters regardless.

Having said that, KVM does provide a per-VM capability for disabling
the virtual PMU: KVM_CAP_PMU_CAPABILITY(KVM_PMU_CAP_DISABLE). See
section 8.35 in Documentation/virt/kvm/api.rst.
