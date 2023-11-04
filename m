Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5297E0F53
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjKDMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:25:52 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A0019D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:25:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso1238e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699100748; x=1699705548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5HDM/kMANYSHmWA+0ee6/FQ7sAYRigJq4+6ccpg/KU=;
        b=TJM16SweCACKQVC1/4lHHgO4DsP9Z5w9SqilfukLgZXHvrefOlZgrcDKssFYsx/A9T
         PJX0UE+FwBzgpMMT5NnasiTJFZm88gQEEiqGKW/DGPL+TAdVTtx2yhyF4p7CGlYq+moX
         8bzJYZY1okldrP1WX4WcSwy5L1+hWZas8KW7wKsOCWhz0ZjWhQYd3ItnB+gh9Nzb7C//
         58gN2K/Rg5stFioAdiAm9IMt5p4TIXlX05mrUro+xeUikG4Qxw1QDC9kk3jWmCRuLoKe
         CayCWX0VWb0Vqm2Rjghx0xdX7D7RYxoiL+jucq1eA2fU+3DtTomR/7ydAMHbzFB0LYaC
         +uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699100748; x=1699705548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5HDM/kMANYSHmWA+0ee6/FQ7sAYRigJq4+6ccpg/KU=;
        b=db3X6eQyNRj2xqIzuOD3yq75ELoFOZfJaWVGnd/KjAjj5odjNp+UVg66RGKzVqArMg
         IXNmdZbkwjX6E2GCSGPsSzNvQKuzZlRWChepOoqbd/bIKtN9du5buEV4ILfcndfHVBbW
         IJY+pq8CyF1+255oTLTjCBtKkKuOOctkX7cUZFFN7/CrmJbF1tjSYKwvtNog+K68RaEa
         NSIKq84huExJlxbAbm8nzCyLhLSa5wLKHSJaoLfc/0FSrQVv7gNXYpKbr3jQaoOSanbo
         F8KiXnJTQM87Ze3OQXY4u2ra8mMHwnzttjbmxt8blquBsxFH0bAnALJks1F53LCjDkpx
         Gf4A==
X-Gm-Message-State: AOJu0YzRTSzS6KE1h9BeyNEmbzLulSUNYCg10tIzx/medEj8fXroZg3y
        COjZQFhWwlWnz0BlxifV5yQ8yFcAQRxO68pIa+/Bng==
X-Google-Smtp-Source: AGHT+IGo6RtvkSz4dTDqX99fEep2IQ+AJozEaQSBSdwjI1scwrWwPk5qZjMLajoFekJgVQOwAg2zFO9WL8dV9PoUl1Y=
X-Received: by 2002:a05:6512:b89:b0:501:b029:1a47 with SMTP id
 b9-20020a0565120b8900b00501b0291a47mr41070lfv.1.1699100747484; Sat, 04 Nov
 2023 05:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-3-seanjc@google.com>
In-Reply-To: <20231104000239.367005-3-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:25:30 -0700
Message-ID: <CALMp9eS+kNYYK_1Ufy5vc5PK25q-ny20woxbHz1onStkcfWNVw@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] KVM: x86/pmu: Don't enumerate support for fixed
 counters KVM can't virtualize
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
> Hide fixed counters for which perf is incapable of creating the associate=
d
> architectural event.  Except for the so called pseudo-architectural event
> for counting TSC reference cycle, KVM virtualizes fixed counters by
> creating a perf event for the associated general purpose architectural
> event.  If the associated event isn't supported in hardware, KVM can't
> actually virtualize the fixed counter because perf will likely not progra=
m
> up the correct event.

Won't it? My understanding was that perf preferred to use a fixed
counter when there was a choice of fixed or general purpose counter.
Unless the fixed counter is already assigned to a perf_event, KVM's
request should be satisfied by assigning the fixed counter.

> Note, this issue is almost certainly limited to running KVM on a funky
> virtual CPU model, no known real hardware has an asymmetric PMU where a
> fixed counter is supported but the associated architectural event is not.

This seems like a fix looking for a problem. Has the "problem"
actually been encountered?

> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a gues=
ts")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/pmu.h           |  4 ++++
>  arch/x86/kvm/vmx/pmu_intel.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
> index 1d64113de488..5341e8f69a22 100644
> --- a/arch/x86/kvm/pmu.h
> +++ b/arch/x86/kvm/pmu.h
> @@ -19,6 +19,7 @@
>  #define VMWARE_BACKDOOR_PMC_APPARENT_TIME      0x10002
>
>  struct kvm_pmu_ops {
> +       void (*init_pmu_capability)(void);
>         bool (*hw_event_available)(struct kvm_pmc *pmc);
>         struct kvm_pmc *(*pmc_idx_to_pmc)(struct kvm_pmu *pmu, int pmc_id=
x);
>         struct kvm_pmc *(*rdpmc_ecx_to_pmc)(struct kvm_vcpu *vcpu,
> @@ -218,6 +219,9 @@ static inline void kvm_init_pmu_capability(const stru=
ct kvm_pmu_ops *pmu_ops)
>                                           pmu_ops->MAX_NR_GP_COUNTERS);
>         kvm_pmu_cap.num_counters_fixed =3D min(kvm_pmu_cap.num_counters_f=
ixed,
>                                              KVM_PMC_MAX_FIXED);
> +
> +       if (pmu_ops->init_pmu_capability)
> +               pmu_ops->init_pmu_capability();
>  }
>
>  static inline void kvm_pmu_request_counter_reprogram(struct kvm_pmc *pmc=
)
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 1b13a472e3f2..3316fdea212a 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -68,6 +68,36 @@ static int fixed_pmc_events[] =3D {
>         [2] =3D PSEUDO_ARCH_REFERENCE_CYCLES,
>  };
>
> +static void intel_init_pmu_capability(void)
> +{
> +       int i;
> +
> +       /*
> +        * Perf may (sadly) back a guest fixed counter with a general pur=
pose
> +        * counter, and so KVM must hide fixed counters whose associated
> +        * architectural event are unsupported.  On real hardware, this s=
hould
> +        * never happen, but if KVM is running on a funky virtual CPU mod=
el...
> +        *
> +        * TODO: Drop this horror if/when KVM stops using perf events for
> +        * guest fixed counters, or can explicitly request fixed counters=
.
> +        */
> +       for (i =3D 0; i < kvm_pmu_cap.num_counters_fixed; i++) {
> +               int event =3D fixed_pmc_events[i];
> +
> +               /*
> +                * Ignore pseudo-architectural events, they're a bizarre =
way of
> +                * requesting events from perf that _can't_ be backed wit=
h a
> +                * general purpose architectural event, i.e. they're guar=
anteed
> +                * to be backed by the real fixed counter.
> +                */
> +               if (event < NR_REAL_INTEL_ARCH_EVENTS &&
> +                   (kvm_pmu_cap.events_mask & BIT(event)))
> +                       break;
> +       }
> +
> +       kvm_pmu_cap.num_counters_fixed =3D i;
> +}
> +
>  static void reprogram_fixed_counters(struct kvm_pmu *pmu, u64 data)
>  {
>         struct kvm_pmc *pmc;
> @@ -789,6 +819,7 @@ void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu=
)
>  }
>
>  struct kvm_pmu_ops intel_pmu_ops __initdata =3D {
> +       .init_pmu_capability =3D intel_init_pmu_capability,
>         .hw_event_available =3D intel_hw_event_available,
>         .pmc_idx_to_pmc =3D intel_pmc_idx_to_pmc,
>         .rdpmc_ecx_to_pmc =3D intel_rdpmc_ecx_to_pmc,
> --
> 2.42.0.869.gea05f2083d-goog
>
