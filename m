Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED8D7FC1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345310AbjK1SKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344975AbjK1SKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:10:18 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E562B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:10:23 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-6cbb6ff734dso6254009b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 10:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701195022; x=1701799822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOiYrhTklrC540+t5ukqyApuT4wG0jpTJi3hI0UhfFQ=;
        b=VGgjns+B3qlLDQMqpsTGbuGiYSuUeEej/LMCPGNVZ5XMofihHWB9bKjmePABcYmYou
         DMrFObCtH1YlAZ7ff0a1qxN1UylInoucoX9jpwEdhA6/V4pwpO0iOLIdKZPdp5TcP75g
         UcVL7ALaXACBNQ0nUTEsLsDLPIfyupuRU+Ftbsna5ZzIPzdn6wE6hlP+6rPaHkv/GQ2/
         JMFP4xlx4u+fVBxdFQIShuc9FLCWKhbCoz9bb9w2Ob4D4BqhuIXK2mRBxQvP3WQPDxtH
         f8AMwWq7ngg2lRazCMFGaei8dBvpxaYqvPE/Ga9gNO+ZuroNNtK05WBb162TKF5BzDAL
         mpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701195022; x=1701799822;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOiYrhTklrC540+t5ukqyApuT4wG0jpTJi3hI0UhfFQ=;
        b=E8X8htckU/eN0PEPCXqAG70ILhuxZt9My1XEpvpB+Dk81qJLnSp++Q6WrwcMfM58iL
         sWQdWbm1Du4sxUebZ8d7xVQMUXtB2vHjyau0wjruc0FgxuH6Ablk50eNCGF6Ptyya6jh
         VXKvhm7BFe/Yfzv7aoJfLn6IMUPg49mZjp8VGmmgl4AnereV7M+P452fmvNm+1z4qP6G
         Fm9s/UabOfy2VqNxxievOKL/lI8SEwHFT+oPAtBnFccTA5/6aV023Y0moYIQHLwJ+axK
         yuqqAwOGoDKAO5RSPzU9NfiyoeKpQ98Wyjv/C0xGIerg+Vz6e3sqmTsw2RixFEqXrTg/
         cYxA==
X-Gm-Message-State: AOJu0YwV8f0/rVPYNpkt2OxoT9BTzawuvvaH8EG14ya2jzfm+rLm4bE6
        HqHT0KDJXnccrg5VbPoprmwDdM2a7XA=
X-Google-Smtp-Source: AGHT+IHjIqdyme5cvmE+9a3rDtzHZcM7efoox+2SRXJe1b9Npk04rYqTs+Clo/bMnXFYVjpUy9ZwguCYWsc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1908:b0:690:d251:28b9 with SMTP id
 y8-20020a056a00190800b00690d25128b9mr3953437pfi.4.1701195022550; Tue, 28 Nov
 2023 10:10:22 -0800 (PST)
Date:   Tue, 28 Nov 2023 10:10:20 -0800
In-Reply-To: <CAJhGHyBtis3SkNZP8RSX5nKFcnQ4qvUrfTMD2RPc+w+Rzf30Zw@mail.gmail.com>
Mime-Version: 1.0
References: <20231107202002.667900-1-aghulati@google.com> <CAJhGHyBtis3SkNZP8RSX5nKFcnQ4qvUrfTMD2RPc+w+Rzf30Zw@mail.gmail.com>
Message-ID: <ZWYtDGH5p4RpGYBw@google.com>
Subject: Re: [RFC PATCH 00/14] Support multiple KVM modules on the same host
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Anish Ghulati <aghulati@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        peterz@infradead.org, paulmck@kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023, Lai Jiangshan wrote:
> On Wed, Nov 8, 2023 at 4:20=E2=80=AFAM Anish Ghulati <aghulati@google.com=
> wrote:
> >
> > This series is a rough, PoC-quality RFC to allow (un)loading and runnin=
g
> > multiple KVM modules simultaneously on a single host, e.g. to deploy
> > fixes, mitigations, and/or new features without having to drain all VMs
> > from the host. Multi-KVM will also allow running the "same" KVM module
> > with different params, e.g. to run trusted VMs with different mitigatio=
ns.
> >
> > The goal of this RFC is to get feedback on the idea itself and the
> > high-level approach.  In particular, we're looking for input on:
> >
> >  - Combining kvm_intel.ko and kvm_amd.ko into kvm.ko
> >  - Exposing multiple /dev/kvmX devices via Kconfig
> >  - The name and prefix of the new base module
> >
> > Feedback on individual patches is also welcome, but please keep in mind
> > that this is very much a work in-progress
>=20
> Hello Anish
>=20
> Scarce effort on multi-KVM can be seen in the mail list albeit many
> companies enable multi-KVM internally.
>=20
> I'm glad that you took a big step in upstreaming it.  And I hope it
> can be materialized soon.
>=20
>=20
> >
> >  - Move system-wide virtualization resource management to a new base
> >    module to avoid collisions between different KVM modules, e.g. VPIDs
> >    and ASIDs need to be unique per VM, and callbacks from IRQ handlers =
need
> >    to be mediated so that things like PMIs get to the right KVM instanc=
e.
>=20
> perf_register_guest_info_callbacks() also accesses to system-wide resourc=
es,
> but I don't see its relating code including kvm_guest_cbs being moved to =
AVC.

Yeah, that's on the TODO list.  IIRC, the plan is to have VAC register a si=
ngle
callback with perf, and then have VAC deal with invoking the callback(s) fo=
r the
correct KVM instance.

> >  - Refactor KVM to make all upgradable assets visible only to KVM, i.e.
> >    make KVM a black box, so that the layout/size of things like "struct
> >    kvm_vcpu" isn't exposed to the kernel at-large.
> >
> >  - Fold kvm_intel.ko and kvm_amd.ko into kvm.ko to avoid complications
> >    having to generate unique symbols for every symbol exported by kvm.k=
o.
>=20
> The sizes of kvm_intel.ko and kvm_amd.ko are big, and there
> is only 1G in the kernel available for modules. So I don't think folding
> two vendors' code into kvm.ko is a good idea.
>=20
> Since the symbols in the new module are invisible outside, I recommend:
> new kvm_intel.ko =3D kvm_intel.ko + kvm.ko
> new kvm_amd.ko =3D kvm_amd.ko + kvm.ko

Yeah, Paolo also suggested this at LPC.

> >  - Add a Kconfig string to allow defining a device and module postfix a=
t
> >    build time, e.g. to create kvmX.ko and /dev/kvmX.
> >
> > The proposed name of the new base module is vac.ko, a.k.a.
> > Virtualization Acceleration Code (Unupgradable Units Module). Childish
> > humor aside, "vac" is a unique name in the kernel and hopefully in x86
> > and hardware terminology, is a unique name in the kernel and hopefully
> > in x86 and hardware terminology, e.g. `git grep vac_` yields no hits in
> > the kernel. It also has the same number of characters as "kvm", e.g.
> > the namespace can be modified without needing whitespace adjustment if
> > we want to go that route.
>=20
> How about the name kvm_base.ko?
>=20
> And the variable/function name in it can still be kvm_foo (other than
> kvm_base_foo).

My preference is to have a unique name that allows us to differentitate bet=
ween
the "base" module/code and KVM code.  Verbal conversations about all of thi=
s get
quite confusing because it's not always clear whether "base KVM" refers to =
what
is currently kvm.ko, or what would become kvm_base.ko/vac.ko.
