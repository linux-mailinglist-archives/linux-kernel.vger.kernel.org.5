Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F2E7E0F4C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjKDMIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:08:33 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18445112
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:08:31 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so6737a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699099709; x=1699704509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfHji7Ga58BYl+g/DnM6ZF6YFg3Y4ct5ZcRCVcclsa0=;
        b=16bLiGuNtm2pLOltuMFhujZdhB12OuYSmsU+F5+gLrl5XuUEg2Ru76iCwe5bYCnxxu
         j0BuAP9iU2JET7nboMABSfNschuolaHSioA0NJ6OhZfCGlS1dxV7pxFix8ukGfkaI8AQ
         J6vwhxIWap0KFagS2YCyDKursmjunTkojCBks0aKcz044D6pgh/oRwwsRHkq9GwRgTre
         inR3n/jTRsHaK2yMjg2dmwBmV4GPQoLFfaIRsysE91rWzjT0fmT7rJKStXrtW7fyuQSr
         bG09aW4uawwnJAE4/dHED3aaWHLejdAedr8xtPRibhKojZIiBVVLi9evEXFIDgn64Nd2
         r49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699099709; x=1699704509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfHji7Ga58BYl+g/DnM6ZF6YFg3Y4ct5ZcRCVcclsa0=;
        b=kRAIscq4GxyNqejt5Jqbbu9z+8VwesZfWSnRp2t/4RCDGsrAKavqeSm06hOesg774e
         8ejKexRVgD2chIds4Pz1S5SzjbR/SR7U5B5yr+ims/G6slZMEk9hNHhEYXrOtaD9Tq9x
         ctjcg6gbTjFkmpCnFY2IV7kqaOcETdC8WY0v1WsEonYGYOBGpyJDkIZZXjT3MDZ6eO07
         InreswROQ/ewfNnCl/57wv1a28FwmRMkBIe07gSoR2+25Nd7RgPThKGxJ0QfTq5Kw+O1
         aSyTCyxCDkcRHJAetm/xWGCnPPcww3dAAeJOdr3lp2TLpx9cU5gPvVZu64cVIAEFqa2h
         LKww==
X-Gm-Message-State: AOJu0YxqU6tuxDMcofJ+t9ai9CSE7XLsIhBGqRHYLBcaSoCMwTG8dJvO
        APUc8mGWwnfAj8/crX8vmVxYGHlVHd9yiInyhrcXCA==
X-Google-Smtp-Source: AGHT+IHPg5/XVMOqndhPMvOwkRuTH8dEV9/UWaHArRzbPx6nONEweJZJJocBsz4HHR2fp8EOzm7d+FMX1UPwYPi/1xk=
X-Received: by 2002:a50:9ecc:0:b0:543:faac:e135 with SMTP id
 a70-20020a509ecc000000b00543faace135mr54281edf.3.1699099709343; Sat, 04 Nov
 2023 05:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-2-seanjc@google.com>
In-Reply-To: <20231104000239.367005-2-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:08:13 -0700
Message-ID: <CALMp9eSgvq1zOZ4KFnsPHQWk62AGYj560SvVops-bmtpyLGPRQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/20] KVM: x86/pmu: Don't allow exposing unsupported
 architectural events
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 5:02=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> Hide architectural events that unsupported according to guest CPUID *or*
> hardware, i.e. don't let userspace advertise and potentially program
> unsupported architectural events.

The bitmask, pmu->available_event_types, is only used in
intel_hw_event_available(). As discussed
(https://lore.kernel.org/kvm/ZUU12-TUR_1cj47u@google.com/),
intel_hw_event_available() should go away.

> Note, KVM already limits the length of the reverse polarity field, only
> the mask itself is missing.
>
> Fixes: f5132b01386b ("KVM: Expose a version 2 architectural PMU to a gues=
ts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/vmx/pmu_intel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 820d3e1f6b4f..1b13a472e3f2 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -533,7 +533,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>         pmu->counter_bitmask[KVM_PMC_GP] =3D ((u64)1 << eax.split.bit_wid=
th) - 1;
>         eax.split.mask_length =3D min_t(int, eax.split.mask_length,
>                                       kvm_pmu_cap.events_mask_len);
> -       pmu->available_event_types =3D ~entry->ebx &
> +       pmu->available_event_types =3D ~(entry->ebx | kvm_pmu_cap.events_=
mask) &
>                                         ((1ull << eax.split.mask_length) =
- 1);
>
>         if (pmu->version =3D=3D 1) {
> --
> 2.42.0.869.gea05f2083d-goog
>
