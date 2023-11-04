Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B733D7E0F75
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjKDMn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjKDMny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:43:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164E2D49
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:43:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so20875e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699101828; x=1699706628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbIEH4ph4/jvif3GCNEs8KORozbdKHBhVu/10X9I7Fs=;
        b=xyrZGiRvdlazQ5BL4jz3ppifkAekTbrvAjPHWuItVrHbhMuLRTv7DyYZ3cmPFRP/7g
         2uW6Tu3fDL2Olin/49rky1S1k/CMSmcnESobwl930SA9bWWa9iOJ9ra5n/z020a/cZjU
         RRGS6NmVCVwPDFXPTc/Qs663TdmuxKyCA+7h9CfxitkQ6PDcszLid1VGdN81Y0CxzwN+
         uNZd2Rp3WHb2KF1DYGQ8NGYRpQxkf/eaV9FDo9/CzlzpbIV10oOOmcYFOtxc58xWkVic
         rUvnDsXGKNYmGBQDp+KsJoMfKDxi8TfwyHIG5UVHhHGpN5KQQ2xLor91ae5r6n87uU4I
         LYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699101828; x=1699706628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbIEH4ph4/jvif3GCNEs8KORozbdKHBhVu/10X9I7Fs=;
        b=qSo8GfVI5Q2AaLwq2hVMXrGGYSn2pfS+If1RMyIxjvV3NvIXClmsLZwH5pWX2rBa/1
         ecc1/5dCppYdGvfuswAvbUCMEINM4X7IEgee2hbxoZ58uSsODFwW2E+SUhFaH1nuvksg
         GPIf7/vjDr4x7WwSBwiT23yWMRwOEwoT+7O/8+h2oDPTl63Ej4Zrzm0QMOa9ttvFiqtL
         yWEbYpK8wpd/FTu+a4eGqqQvg4jzEEgW6Drv2QUoOB77UoGUHIKZ/2Ds4qMoOwTx+5e0
         C3KEWN1gnHvsOnqprTbjvhNAzp6Q3AK7ekIO/2dN/P2uQs8wDBzcnbLe0c3p2JjU4Zsw
         4t5Q==
X-Gm-Message-State: AOJu0YzNyfheHUYHZDk3qprI4D09qr92P1zkg5QI9EWckcgfCrlS05cC
        G08dbQBs5g5HzQD2hh1duiJlpfD7A3RCmO/Qtke8kQ==
X-Google-Smtp-Source: AGHT+IGLGHHq0SttNbIHReSh6obdY2PYHzv710kE6QJ4nedl4WiGuaWljshu9yIAK0oN7TWww7Z07qn4ZoVgfQEZRmA=
X-Received: by 2002:a05:600c:929:b0:3f7:3e85:36a with SMTP id
 m41-20020a05600c092900b003f73e85036amr43847wmp.7.1699101828191; Sat, 04 Nov
 2023 05:43:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-5-seanjc@google.com>
In-Reply-To: <20231104000239.367005-5-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:43:36 -0700
Message-ID: <CALMp9eTWNpOH8YP35So9X-+TaSOGe2ye6J+MRXut=f6bwyjUYw@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] KVM: x86/pmu: Always treat Fixed counters as
 available when supported
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Like Xu <likexu@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Now that KVM hides fixed counters that can't be virtualized, treat fixed
> counters as available when they are supported, i.e. don't silently ignore
> an enabled fixed counter just because guest CPUID says the associated
> general purpose architectural event is unavailable.
>
> KVM originally treated fixed counters as always available, but that got
> changed as part of a fix to avoid confusing REF_CPU_CYCLES, which does NO=
T
> map to an architectural event, with the actual architectural event used
> associated with bit 7, TOPDOWN_SLOTS.
>
> The commit justified the change with:
>
>     If the event is marked as unavailable in the Intel guest CPUID
>     0AH.EBX leaf, we need to avoid any perf_event creation, whether
>     it's a gp or fixed counter.
>
> but that justification doesn't mesh with reality.  The Intel SDM uses
> "architectural events" to refer to both general purpose events (the ones
> with the reverse polarity mask in CPUID.0xA.EBX) and the events for fixed
> counters, e.g. the SDM makes statements like:
>
>   Each of the fixed-function PMC can count only one architectural
>   performance event.
>
> but the fact that fixed counter 2 (TSC reference cycles) doesn't have an
> associated general purpose architectural makes trying to apply the mask
> from CPUID.0xA.EBX impossible.  Furthermore, the SDM never explicitly
> says that an architectural events that's marked unavailable in EBX affect=
s
> the fixed counters.
>
> Note, at the time of the change, KVM didn't enforce hardware support, i.e=
.
> didn't prevent userspace from enumerating support in guest CPUID.0xA.EBX
> for architectural events that aren't supported in hardware.  I.e. silentl=
y
> dropping the fixed counter didn't somehow protection against counting the
> wrong event, it just enforced guest CPUID.
>
> Arguably, userspace is creating a bogus vCPU model by advertising a fixed
> counter but saying the associated general purpose architectural event is
> unavailable.  But regardless of the validity of the vCPU model, letting
> the guest enable a fixed counter and then not actually having it count
> anything is completely nonsensical.  I.e. even if all of the above is
> wrong and it's illegal for a fixed counter to exist when the architectura=
l
> event is unavailable, silently doing nothing is still the wrong behavior
> and KVM should instead disallow enabling the fixed counter in the first
> place.
>
> Fixes: a21864486f7e ("KVM: x86/pmu: Fix available_event_types check for R=
EF_CPU_CYCLES event")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 8d545f84dc4a..b239e7dbdc9b 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -147,11 +147,24 @@ static bool intel_hw_event_available(struct kvm_pmc=
 *pmc)

As discussed (https://lore.kernel.org/kvm/ZUU12-TUR_1cj47u@google.com/),
this function should go away.

>         u8 unit_mask =3D (pmc->eventsel & ARCH_PERFMON_EVENTSEL_UMASK) >>=
 8;
>         int i;
>
> +       /*
> +        * Fixed counters are always available if KVM reaches this point.=
  If a
> +        * fixed counter is unsupported in hardware or guest CPUID, KVM d=
oesn't
> +        * allow the counter's corresponding MSR to be written.  KVM does=
 use
> +        * architectural events to program fixed counters, as the interfa=
ce to
> +        * perf doesn't allow requesting a specific fixed counter, e.g. p=
erf
> +        * may (sadly) back a guest fixed PMC with a general purposed cou=
nter.
> +        * But if _hardware_ doesn't support the associated event, KVM si=
mply
> +        * doesn't enumerate support for the fixed counter.
> +        */
> +       if (pmc_is_fixed(pmc))
> +               return true;
> +
>         BUILD_BUG_ON(ARRAY_SIZE(intel_arch_events) !=3D NR_INTEL_ARCH_EVE=
NTS);
>
>         /*
>          * Disallow events reported as unavailable in guest CPUID.  Note,=
 this
> -        * doesn't apply to pseudo-architectural events.
> +        * doesn't apply to pseudo-architectural events (see above).
>          */
>         for (i =3D 0; i < NR_REAL_INTEL_ARCH_EVENTS; i++) {
>                 if (intel_arch_events[i].eventsel !=3D event_select ||
> --
> 2.42.0.869.gea05f2083d-goog
>
