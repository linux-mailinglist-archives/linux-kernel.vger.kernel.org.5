Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318907E4985
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbjKGUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKGUDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:03:51 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CF1E7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 12:03:48 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so2880a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 12:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699387427; x=1699992227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnEVKTaaLYxHM268Q5WdvdnJgEBuM9SDF2SNDc+ebdk=;
        b=KM/p+njyUtFO27uIWZWGef9Ymu1p/UQSfhiJE7O5WqhyNKuk++eQ7DFvcRXMxS2uNL
         3KzKupQsYlf/yRR44uPPwkXCjnlj4des/dK46bgR0fos3PRoinV5rlcO1tDzNDxKfUta
         EaSgXuTvstici8RK87tvy97t8Udu2gu72uJHstWHjQWi425t6wu21SU3OH8YeAyM3UU8
         uDpCpyOtNUPEBhwrJBUSy8NcRttzt9L4jBOw6XBXdqAzc3lmGXzpba64VF9ifihj2oBh
         aE4TwCbI2fptqVnrywQmZOnptX/gnHC9uHPNuCYTy845FF0vYAcyUZvKC28+XhGEv0yX
         V3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699387427; x=1699992227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YnEVKTaaLYxHM268Q5WdvdnJgEBuM9SDF2SNDc+ebdk=;
        b=o3yaJ4GM8G8U8rd5MpvCWq3DmVnqN0UHUvcle65gKK6SpUticHuSOe/f2yHBjYAnp7
         6lHdoYqH5o4sZyoB0nYY6+DN1igv3/qC5r02vgkuXRnxL+EAVFSmoA43IoqQ4/YbK9A+
         su8ovDKO7+tNYkgS1wfkrH3EKSU5J0FvONEl8UoK4J8MWYQdgaS/e/koZY6lBPu/27x5
         CLiWlf+7M9nqIXucF3VW+tUgF9dKzhrpdhAzuSUU3N+FagRITE6FGAruk9X9bUJ3Aq79
         T1gmc+/AEzk0Joc+SXAuBie1rc3L699NlwGVfa3esUVWxIbJ2lM53BholJNlVQtV5R/v
         WpXw==
X-Gm-Message-State: AOJu0YyRKWce1/8XW+bdTVKGa5HUjechUVN7yOwXElj67UAkX2ADF3qc
        DDLtbG00BiwFb67OB5i8ctr6KE6buQxOE4SpnULyug==
X-Google-Smtp-Source: AGHT+IH0rRs2clz95qXcyn4xwmyOugYn8RIEUiyHiBTf/rBVN1V8tzdQR7UDOCyjrHuD6xSlusqUHU+yHoCT/50WncU=
X-Received: by 2002:a50:d753:0:b0:542:d737:dc7e with SMTP id
 i19-20020a50d753000000b00542d737dc7emr222213edj.0.1699387426998; Tue, 07 Nov
 2023 12:03:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699383993.git.isaku.yamahata@intel.com> <20231107192933.GA1102144@ls.amr.corp.intel.com>
In-Reply-To: <20231107192933.GA1102144@ls.amr.corp.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 7 Nov 2023 12:03:35 -0800
Message-ID: <CALMp9eR8Jnn0g0XBpTKTfKKOtRmFwAWuLAKcozuOs6KAGZ6MQQ@mail.gmail.com>
Subject: Re: KVM: X86: Make bus clock frequency for vapic timer (bus lock ->
 bus clock) (was Re: [PATCH 0/2] KVM: X86: Make bus lock frequency for vapic
 timer) configurable
To:     Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 11:29=E2=80=AFAM Isaku Yamahata
<isaku.yamahata@linux.intel.com> wrote:
>
> I meant bus clock frequency, not bus lock. Sorry for typo.
>
> On Tue, Nov 07, 2023 at 11:22:32AM -0800,
> isaku.yamahata@intel.com wrote:
>
> > From: Isaku Yamahata <isaku.yamahata@intel.com>
> >
> > Add KVM_CAP_X86_BUS_FREQUENCY_CONTROL capability to configure the core
> > crystal clock (or processor's bus clock) for APIC timer emulation.  All=
ow
> > KVM_ENABLE_CAPABILITY(KVM_CAP_X86_BUS_FREUQNCY_CONTROL) to set the
> > frequency.  When using this capability, the user space VMM should confi=
gure
> > CPUID[0x15] to advertise the frequency.
> >
> > TDX virtualizes CPUID[0x15] for the core crystal clock to be 25MHz.  Th=
e
> > x86 KVM hardcodes its freuqncy for APIC timer to be 1GHz.  This mismatc=
h
> > causes the vAPIC timer to fire earlier than the guest expects. [1] The =
KVM
> > APIC timer emulation uses hrtimer, whose unit is nanosecond.
> >
> > There are options to reconcile the mismatch.  1) Make apic bus clock fr=
equency
> > configurable (this patch).  2) TDX KVM code adjusts TMICT value.  This =
is hacky
> > and it results in losing MSB bits from 32 bit width to 30 bit width.  3=
). Make
> > the guest kernel use tsc deadline timer instead of acpi oneshot/periodi=
c timer.
> > This is guest kernel choice.  It's out of control of VMM.
> >
> > [1] https://lore.kernel.org/lkml/20231006011255.4163884-1-vannapurve@go=
ogle.com/
> >
> > Isaku Yamahata (2):
> >   KVM: x86: Make the hardcoded APIC bus frequency vm variable
> >   KVM: X86: Add a capability to configure bus frequency for APIC timer

I think I know the answer, but do you have any tests for this new feature?
