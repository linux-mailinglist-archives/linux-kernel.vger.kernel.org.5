Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D9381083A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378346AbjLMCZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378352AbjLMCZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:25:35 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0FDB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:25:40 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2866c800dd5so7494658a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702434339; x=1703039139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uToa4vWGRVyqvNFgMnA004x4lYo/i2CHkX+gzS+aQ5U=;
        b=IZKJMI6XpjJ5pzY3zpODomr7ey0c/FzlY9F0mtrBNv3aJI3CadHMYYPMn8FdcBRctm
         cchNyz5bEuAfAVBEyUEHqorQs3XMHu1PdHBpEGeLWPjvKsjNM6UROGaxJYVfxAavI0x9
         SkXIbMmf9p/Oq0K/+UE8Pxg+SzCitEL1WYkj+/4ZUN9EcWldJgWPW5LePYc/YKhsE/Oi
         yD07iI9jnRREjbXG7PuyE0bQLqhHzvboB/1Jd2Iq6XeUrrWtcp91phn8hQHv3VuD3tUi
         axah1yp4ojXscggSrB1+QbajQbTtTwPiNkeQH6Zzj6JDDauno0cRVybhCMhKqYi25Wd+
         W32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702434339; x=1703039139;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uToa4vWGRVyqvNFgMnA004x4lYo/i2CHkX+gzS+aQ5U=;
        b=cyVL9mHmVpa6EiwDamtIeeeZZZKDx9XKybptWU0PLMwmvyFr/TCXEeZqVXz5UexXJz
         4NIDD9nZASzIRLvo/SX/3barmNbpVFsAII0fGAm6NKv87K397LymlQvPGOMXGW1BgOFY
         dV/DXf9r0bpT1jSE5lWuhyI+rTO1uom6HhfBvTFGaJFyvdXuMIdF8D5EqZQfqxoZuCfR
         9MOQTavttQraVvOGeDNnqS6vZLHPCViesC0tXVEMjsmn4O0+5yKcRR2geDppWsa3nycK
         6IaUU3e/kckal0c+wG+EsHhOGT3lZDTqX7A1vb5rj14M/kbSL1rhWp8ENJvJWyED5bg1
         RIkw==
X-Gm-Message-State: AOJu0YxBsmlTgjePB3OFoC9WL3YAsAd6dwDYdmixZJyDThgmiqrXklFO
        JUqaUgmF7DKGW9mMv8nq/8ixEJdzTjU=
X-Google-Smtp-Source: AGHT+IGjOh77pJErMrAJlmF68uCB8WZKhfF3L0MvWcwu5DdcLA6O2G9co0lomVJzEXM1kfJKmMWCn26moNg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:a504:b0:1d0:54ff:da25 with SMTP id
 s4-20020a170902a50400b001d054ffda25mr50045plq.0.1702434339424; Tue, 12 Dec
 2023 18:25:39 -0800 (PST)
Date:   Tue, 12 Dec 2023 18:25:37 -0800
In-Reply-To: <CALMp9eSZdPyZChd1PwFy+PqFAM2Eg4zQS97LG1s2DOov5e_mUQ@mail.gmail.com>
Mime-Version: 1.0
References: <20231202000417.922113-1-seanjc@google.com> <20231202000417.922113-11-seanjc@google.com>
 <b45efe2f-1b99-4596-b33f-d491726ed34d@linux.intel.com> <CALMp9eSp_9J9t3ByfHfnirXf=uxvWVWVtLWO5KPoO0nDFJ-gtw@mail.gmail.com>
 <ZXeenJ6DAugGCaSN@google.com> <CALMp9eSZdPyZChd1PwFy+PqFAM2Eg4zQS97LG1s2DOov5e_mUQ@mail.gmail.com>
Message-ID: <ZXkWIY6WRcBiuLMd@google.com>
Subject: Re: [PATCH v9 10/28] KVM: x86/pmu: Explicitly check for RDPMC of
 unsupported Intel PMC types
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023, Jim Mattson wrote:
> On Mon, Dec 11, 2023 at 3:43=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > > > @@ -82,9 +85,13 @@ static struct kvm_pmc *intel_rdpmc_ecx_to_pmc(=
struct kvm_vcpu *vcpu,
> > > > >       /*
> > > > >        * Fixed PMCs are supported on all architectural PMUs.  Not=
e, KVM only
> > > > >        * emulates fixed PMCs for PMU v2+, but the flag itself is =
still valid,
> > > > > -      * i.e. let RDPMC fail due to accessing a non-existent coun=
ter.
> > > > > +      * i.e. let RDPMC fail due to accessing a non-existent coun=
ter.  Reject
> > > > > +      * attempts to read all other types, which are unknown/unsu=
pported.
> > > > >        */
> > > > > -     idx &=3D ~INTEL_RDPMC_FIXED;
> > > > > +     if (idx & INTEL_RDPMC_TYPE_MASK & ~INTEL_RDPMC_FIXED)
> > >
> > > You know how I hate to be pedantic (ROFL), but the SDM only says:
> > >
> > > If the processor does support architectural performance monitoring
> > > (CPUID.0AH:EAX[7:0] =E2=89=A0 0), ECX[31:16] specifies type of PMC wh=
ile
> > > ECX[15:0] specifies the index of the PMC to be read within that type.
> > >
> > > It does not say that the types are bitwise-exclusive.
> > >
> > > Yes, the types defined thus far are bitwise-exclusive, but who knows
> > > what tomorrow may bring?
> >
> > The goal isn't to make the types exclusive, the goal is to reject types=
 that
> > aren't supported by KVM.  The above accomplishes that, no?  I don't see=
 how KVM
> > could get a false negative or false positive, the above allows exactly =
FIXED and
> > "none" types.  Or are you objecting to the comment?
>=20
> You're right. The code is fine. My brain is not.
>=20
> But what's wrong with something like:
>=20
> type =3D idx & INTEL_RDPMC_TYPE_MASK;
> if (type !=3D INTEL_RDPMC_GP && type !=3D INTEL_RDPMC_FIXED) ...
>=20
> This makes it more clear what kvm accepts and what it doesn't accept,
> regardless of the actual values of the macros.

Because when I read the SDM, my reading was heavily colored by KVM's existi=
ng
implementation.  And the SDM using 4000H and 2000H for the non-zero types d=
oesn't
help (those scream "flags" to me).  But rereading things, the SDM clearly s=
tates
they are explicit, distinct types.  I'll massage this to have KVM treat the=
m as
such.
