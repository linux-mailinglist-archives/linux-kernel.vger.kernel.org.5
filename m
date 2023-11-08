Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0197E4E98
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjKHB3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbjKHB3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:29:00 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57C10F6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:28:52 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so6554a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699406931; x=1700011731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnA6mDB+2g1i1w3tpZYM9LGAfchwHqjZLzHC1al8HTo=;
        b=pSneeyQbVmgFR1nZsHZnb/NdnHaLZRcjO8a2zEl1D9bdiMW3X74upcKqAaD60AA9+H
         ptKFtVjewDo/KWr9hmailfu1ph5JGZosVZi5yXHLiqiAo9sDB2gJ/9JIjFy3WVkMCcnJ
         sidS/58/f3fW365fYfmQ9AV4h/wth+g2bge+f8pyOW/yrYPDFstPgdV5Z0w2A3qvluEc
         nceSJ7HWxjozhQo+yQG/Ael646RlXGaAydEbG2NqyiX+Zak3igr2kJjMSvXaMSX3QNW/
         ESQuS8BZwiSRLxzfa18mnyL9L0tNCEMOIRjwuRGHSMY39SJbxCquFTOSqyjDc4QhmqtH
         8BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699406931; x=1700011731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnA6mDB+2g1i1w3tpZYM9LGAfchwHqjZLzHC1al8HTo=;
        b=uGjBs7bXEAb/xmiDHsWI0OCL1gZcAXPb8VfSbL2fx4xNBqYM3/F1PR0u5lDRAeMvb3
         jM5xhfupMkT81KVbEQbKi5aUKzNEOCfg/8bqjaTNPqKJC/zM5np1c7J7YrOfyDTxs2XN
         StUSeg6m4lPYXFhDIr5/RcNdTqBenjlgeaDI3ktwQOn4fLfpm52wzbK/uMc19xFT4YbW
         EGz7ZXJ0IPz7KUDbhSINPRz4u3K/Dk52SlYiyieoqRS1oyzG3WWR2kIbhxjoZ0FvgmcF
         6gIjkPrTk4nBAYq6ch/jr4ndTb9drDXML5hdzzVuZ1/kNKXUGoELU84YycsMH/0e0x/B
         m/og==
X-Gm-Message-State: AOJu0Yyz+NK8dvudaqD3hll4/9QS2+FE0GxbzTubnC1yYurW3xhCdsxU
        JFSYko/r946+iifRWR61WxtTiRk0BvZuEs8Zqxr3kQ==
X-Google-Smtp-Source: AGHT+IFeq5fiAU5OR4oonDboJaKhD8Mzu3qeCZ5YPAgE6wkVpUsKYKUm21CUvEEOxTQ3PXwbNgilU2VM4B36cqtcfKE=
X-Received: by 2002:a05:6402:3789:b0:545:279:d075 with SMTP id
 et9-20020a056402378900b005450279d075mr113343edb.1.1699406930497; Tue, 07 Nov
 2023 17:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-5-seanjc@google.com>
In-Reply-To: <20231108003135.546002-5-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 7 Nov 2023 17:28:38 -0800
Message-ID: <CALMp9eRcBi19yGS3+t+Hm0fLSB5+ESDGAygjwE_CYs-jWtU9Cg@mail.gmail.com>
Subject: Re: [PATCH v7 04/19] KVM: x86/pmu: Setup fixed counters' eventsel
 during PMU initialization
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 4:31=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Set the eventsel for all fixed counters during PMU initialization, the
> eventsel is hardcoded and consumed if and only if the counter is supporte=
d,
> i.e. there is no reason to redo the setup every time the PMU is refreshed=
.
>
> Configuring all KVM-supported fixed counter also eliminates a potential
> pitfall if/when KVM supports discontiguous fixed counters, in which case
> configuring only nr_arch_fixed_counters will be insufficient (ignoring th=
e
> fact that KVM will need many other changes to support discontiguous fixed
> counters).
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index c4f2c6a268e7..5fc5a62af428 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -409,7 +409,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, s=
truct msr_data *msr_info)
>   * Note, reference cycles is counted using a perf-defined "psuedo-encodi=
ng",
>   * as there is no architectural general purpose encoding for reference c=
ycles.
>   */
> -static void setup_fixed_pmc_eventsel(struct kvm_pmu *pmu)
> +static u64 intel_get_fixed_pmc_eventsel(int index)
>  {
>         const struct {
>                 u8 eventsel;
> @@ -419,17 +419,11 @@ static void setup_fixed_pmc_eventsel(struct kvm_pmu=
 *pmu)
>                 [1] =3D { 0x3c, 0x00 }, /* CPU Cycles/ PERF_COUNT_HW_CPU_=
CYCLES. */
>                 [2] =3D { 0x00, 0x03 }, /* Reference Cycles / PERF_COUNT_=
HW_REF_CPU_CYCLES*/
>         };
> -       int i;
>
>         BUILD_BUG_ON(ARRAY_SIZE(fixed_pmc_events) !=3D KVM_PMC_MAX_FIXED)=
;
>
> -       for (i =3D 0; i < pmu->nr_arch_fixed_counters; i++) {
> -               int index =3D array_index_nospec(i, KVM_PMC_MAX_FIXED);
> -               struct kvm_pmc *pmc =3D &pmu->fixed_counters[index];
> -
> -               pmc->eventsel =3D (fixed_pmc_events[index].unit_mask << 8=
) |
> -                                fixed_pmc_events[index].eventsel;
> -       }
> +       return (fixed_pmc_events[index].unit_mask << 8) |
> +               fixed_pmc_events[index].eventsel;

Can I just say that it's really confusing that the value returned by
intel_get_fixed_pmc_eventsel() is the concatenation of an 8-bit "unit
mask" and an 8-bit "eventsel"?
