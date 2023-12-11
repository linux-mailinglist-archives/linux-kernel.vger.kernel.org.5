Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D532680D4A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjLKRwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbjLKRvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:37 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA97182
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:51:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5de8c2081d1so38160847b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702317068; x=1702921868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b+QItwKYZkmQjKZfvnmL7h1+BIrbGG/qsUdX1MWn8c0=;
        b=2icDOyzUegWgAgAwSXZvNqptPy5tMC+DrrtpjSrpNdzf3rLtlpzIXKJxnWxNb/RUJa
         hGFRWiypqWddgbsnTKtHGPJd8kYFpOA5RDnYwPa5xTxRreYEPkTpdPxpIm9PNr0C579x
         fQlO51oERZNjgQsaiebHA36C3mYxoC/XdlKQJNEylIL6zXxlnKpYS1eL6C4qFUrvL5G3
         D7bgqO2bXPh2HLUz7B09VzDNRx84Lu3WKslpwFpBpNt/mIWhhcOrA9kAhXod7xuOI/Yj
         nM/p+PI5++Aap6NxXVFI/2YPFFJKy9qapTWqH+5pzESg/Kz4NtJs9f58uK9VhihRpj/c
         LoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317068; x=1702921868;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b+QItwKYZkmQjKZfvnmL7h1+BIrbGG/qsUdX1MWn8c0=;
        b=EzbeXMkuRvxS9kQ0rmBJ7cdy0BM8Irls3FIoDC4YCJzAJiljVjFl3y3nAzYyvJYPh/
         9+K+WE3y+zkVlbB6jPrAH6cxv9KU2r/7Q9rGauYLSMfatYVzj3CmcKiE6akZvo5LXVuT
         xCcK8PfPzGy1kOtfkJtBkAC0nUCiV51v2zpmQWxvndwZt8+6300BEOEkRexV6Y1c6F8K
         ZqtIGgmQaCDf5SvCa/2pjMSxjbuTG6Mgde9P9aolmGZvZlzP8gpEWVmgXsObUbsTX/IK
         sMZq7cTF6tE6rS8UfVTPh6WkHy76sx1+Hg0xcPCLGvlIFX5C6NkSNdpYhSAwwCualgBG
         lZvg==
X-Gm-Message-State: AOJu0Yx0+q0VK9HZnnPsNaIoxMYWiyiG/7j7rDUo9wnkS07aF4qR4FlS
        xgdLpFUf0AOgveT3Yn1ARL03Gl1TwRw=
X-Google-Smtp-Source: AGHT+IEJlbs6t42JuBe9Zaw8UIu5remsf7pFjNUwnZXA86IgYB4Hsz7JOVUF1FGFr+oR81Ahwo5DnMt1rK4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3381:b0:5d5:5183:ebdb with SMTP id
 fl1-20020a05690c338100b005d55183ebdbmr48534ywb.10.1702317068533; Mon, 11 Dec
 2023 09:51:08 -0800 (PST)
Date:   Mon, 11 Dec 2023 09:51:07 -0800
In-Reply-To: <ZXdIIBUXcCIK28ys@google.com>
Mime-Version: 1.0
References: <20230512233127.804012-1-seanjc@google.com> <20230512233127.804012-2-seanjc@google.com>
 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com> <ZXdIIBUXcCIK28ys@google.com>
Message-ID: <ZXdMC9rCHqAx2SfF@google.com>
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to
 hook restart/shutdown
From:   Sean Christopherson <seanjc@google.com>
To:     James Gowans <jgowans@amazon.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        Alexander Graf <graf@amazon.de>,
        "Jan =?utf-8?Q?Sch=C3=B6nherr?=" <jschoenh@amazon.de>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
        "atishp@atishpatra.org" <atishp@atishpatra.org>,
        "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
        "maz@kernel.org" <maz@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023, Sean Christopherson wrote:
> On Sat, Dec 09, 2023, James Gowans wrote:
> > Hi Sean,
> >=20
> > Blast from the past but I've just been bitten by this patch when
> > rebasing across v6.4.
> >=20
> > On Fri, 2023-05-12 at 16:31 -0700, Sean Christopherson wrote:
> > > Use syscore_ops.shutdown to disable hardware virtualization during a
> > > reboot instead of using the dedicated reboot_notifier so that KVM dis=
ables
> > > virtualization _after_ system_state has been updated.=C2=A0 This will=
 allow
> > > fixing a race in KVM's handling of a forced reboot where KVM can end =
up
> > > enabling hardware virtualization between kernel_restart_prepare() and
> > > machine_restart().
> >=20
> > The issue is that, AFAICT, the syscore_ops.shutdown are not called when
> > doing a kexec. Reboot notifiers are called across kexec via:
> >=20
> > kernel_kexec
> >   kernel_restart_prepare
> >     blocking_notifier_call_chain
> >       kvm_reboot
> >=20
> > So after this patch, KVM is not shutdown during kexec; if hardware virt
> > mode is enabled then the kexec hangs in exactly the same manner as you
> > describe with the reboot.
> >=20
> > Some specific shutdown callbacks, for example IOMMU, HPET, IRQ, etc are
> > called in native_machine_shutdown, but KVM is not one of these.
> >=20
> > Thoughts on possible ways to fix this:
> > a) go back to reboot notifiers
> > b) get kexec to call syscore_shutdown() to invoke all of these callback=
s
> > c) Add a KVM-specific callback to native_machine_shutdown(); we only
> > need this for Intel x86, right?
>=20
> I don't like (c).  VMX is the most sensitive/problematic, e.g. the whole =
blocking
> of INIT thing, but SVM can also run afoul of EFER.SVME being cleared, and=
 KVM really=20
> should leave virtualization enabled across kexec(), even if leaving virtu=
alization

*shouldn't*

> enabled is relatively benign on other architectures.
>=20
> One more option would be:
>=20
>  d) Add another sycore hook, e.g. syscore_kexec() specifically for this p=
ath.
>=20
> > My slight preference is towards adding syscore_shutdown() to kexec, but
> > I'm not sure that's feasible. Adding kexec maintainers for input.
>=20
> In a vacuum, that'd be my preference too.  It's the obvious choice IMO, e=
.g. the
> kexec_image->preserve_context path does syscore_suspend() (and then resum=
e(), so
> it's not completely uncharted territory.
>=20
> However, there's a rather big wrinkle in that not all of the existing .sh=
utdown()
> implementations are obviously ok to call during kexec.  Luckily, AFAICT t=
here are
> very few users of the syscore .shutdown hook, so it's at least feasible t=
o go that
> route.
>=20
> x86's mce_syscore_shutdown() should be ok, and arguably is correct, e.g. =
I don't
> see how leaving #MC reporting enabled across kexec can work.
>=20
> ledtrig_cpu_syscore_shutdown() is also likely ok and arguably correct.
>=20
> The interrupt controllers though?  x86 disables IRQs at the very beginnin=
g of
> machine_kexec(), so it's likely fine.  But every other architecture?  No =
clue.
> E.g. PPC's default_machine_kexec() sends IPIs to shutdown other CPUs, tho=
ugh I
> have no idea if that can run afoul of any of the paths below.
>=20
>         arch/powerpc/platforms/cell/spu_base.c  .shutdown =3D spu_shutdow=
n,
>         arch/x86/kernel/cpu/mce/core.c	        .shutdown =3D mce_syscore_=
shutdown,
>         arch/x86/kernel/i8259.c                 .shutdown =3D i8259A_shut=
down,
>         drivers/irqchip/irq-i8259.c	        .shutdown =3D i8259A_shutdown=
,
>         drivers/irqchip/irq-sun6i-r.c	        .shutdown =3D sun6i_r_intc_=
shutdown,
>         drivers/leds/trigger/ledtrig-cpu.c	.shutdown =3D ledtrig_cpu_sysc=
ore_shutdown,
>         drivers/power/reset/sc27xx-poweroff.c	.shutdown =3D sc27xx_powero=
ff_shutdown,
>         kernel/irq/generic-chip.c	        .shutdown =3D irq_gc_shutdown,
>         virt/kvm/kvm_main.c	                .shutdown =3D kvm_shutdown,
>=20
> The whole thing is a bit of a mess.  E.g. x86 treats machine_shutdown() f=
rom
> kexec pretty much the same as shutdown for reboot, but other architecture=
s have
> what appear to be unique paths for handling kexec.
>=20
> FWIW, if we want to go with option (b), syscore_shutdown() hooks could us=
e
> kexec_in_progress to differentiate between "regular" shutdown/reboot and =
kexec.
