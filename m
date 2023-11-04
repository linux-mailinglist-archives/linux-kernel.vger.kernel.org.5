Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824027E0F87
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjKDNBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 09:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjKDNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 09:01:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B96D68
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 06:01:15 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53eeb28e8e5so3734a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699102873; x=1699707673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJ43cYUJbmaHy9KhuOyBng8oTn7RaE+LIvbyJpkPT/c=;
        b=ReLZWUY+qvDzlfzfcrs1HYwBbkv8KWnKAnL/rreNxYyy5FrOxpvOqqgkn/Qg+sCcBL
         JXPO4cb4r3a1sE426h7KPqf7OixMaInaneIFYzXMPx6uSiBVe2p67a/on16F/QUmiX0L
         pyr2urmwpqBlXQPN248y66OdDnXwv41SIqHfsb6J3gMoHvD6HxjRgIcdoTW605iP8EOh
         fQ2pmPlskX/a6BcxQIr+2vS8AKp5erfuHc4kd7MqXLB5xz+wGA2bahk2SokBu3vT1h+/
         RXmdeHrj9Aj+zK3vqWMOdSuCXWopDWXY4MJ/aMZsl9JqjSkSmthGrDJ31lHkT2sz8keM
         omzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102873; x=1699707673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJ43cYUJbmaHy9KhuOyBng8oTn7RaE+LIvbyJpkPT/c=;
        b=abAdKZzhZU8mgGB3gCAvD/iiSLq+WEcVeDBilAZCNQcrngA1ZDI7CuD1/Rg45PQ2xt
         aELu10MYTJMx108KSyr3vqqrOlfJYoLOB2p6dcQj09xMz6IfnaMNhdYgZJhdsCFWyDCT
         p2pmGQVXsuvYUX+wAxFclJxXEUZIzjxrfeXp2o4pa19DrL4t7jwQfanGY/lqWMWiG2xK
         mNpE0GeNKySuhebuh0JSTtYNGLgVXZJEHR+U/W4eSiA4URPwDLegn3VoiSkhQDHJzcxr
         OOIKFhOC+t8GFtNouKyuZtl91dr4DRVDW0wBq0ookdcV+dGynvZDFU5Pba16RL+9a5I8
         +PEg==
X-Gm-Message-State: AOJu0YySK89h4lixBcPHVFqfnnciheKBtcebUoF2eMYTPd1NZ+quEPN7
        6xSRvEEsTRLzWAApjsXPrDgY7SSRf2rdoqhx84xAdg==
X-Google-Smtp-Source: AGHT+IHfJeibkMc4b2hx2kpk1Qt4Igdys3wVFl1VIyVev+1tZl9L9tewu7Gvv5fYnw9uJlpi79LfPwlJOgTWwuYzuDE=
X-Received: by 2002:a50:8757:0:b0:540:e4c3:430 with SMTP id
 23-20020a508757000000b00540e4c30430mr84010edv.6.1699102872955; Sat, 04 Nov
 2023 06:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-9-seanjc@google.com>
In-Reply-To: <20231104000239.367005-9-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 06:00:58 -0700
Message-ID: <CALMp9eR2jWM3_4EPWS+EXY=7b-hJyZGg2nh1sq0iaVd0kDFjZg@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] KVM: selftests: Extend {kvm,this}_pmu_has() to
 support fixed counters
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
> Extend the kvm_x86_pmu_feature framework to allow querying for fixed
> counters via {kvm,this}_pmu_has().  Like architectural events, checking
> for a fixed counter annoyingly requires checking multiple CPUID fields, a=
s
> a fixed counter exists if:
>
>   FxCtr[i]_is_supported :=3D ECX[i] || (EDX[4:0] > i);
>
> Note, KVM currently doesn't actually support exposing fixed counters via
> the bitmask, but that will hopefully change sooner than later, and Intel'=
s
> SDM explicitly "recommends" checking both the number of counters and the
> mask.
>
> Rename the intermedate "anti_feature" field to simply 'f' since the fixed
> counter bitmask (thankfully) doesn't have reversed polarity like the
> architectural events bitmask.
>
> Note, ideally the helpers would use BUILD_BUG_ON() to assert on the
> incoming register, but the expected usage in PMU tests can't guarantee th=
e
> inputs are compile-time constants.
>
> Opportunistically define macros for all of the architectural events and
> fixed counters that KVM currently supports.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../selftests/kvm/include/x86_64/processor.h  | 63 +++++++++++++------
>  1 file changed, 45 insertions(+), 18 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index 2d9771151dd9..b103c462701b 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -281,24 +281,39 @@ struct kvm_x86_cpu_property {
>   * that indicates the feature is _not_ supported, and a property that st=
ates
>   * the length of the bit mask of unsupported features.  A feature is sup=
ported
>   * if the size of the bit mask is larger than the "unavailable" bit, and=
 said
> - * bit is not set.
> + * bit is not set.  Fixed counters also bizarre enumeration, but inverte=
d from
> + * arch events for general purpose counters.  Fixed counters are support=
ed if a
> + * feature flag is set **OR** the total number of fixed counters is grea=
ter
> + * than index of the counter.
>   *
> - * Wrap the "unavailable" feature to simplify checking whether or not a =
given
> - * architectural event is supported.
> + * Wrap the events for general purpose and fixed counters to simplify ch=
ecking
> + * whether or not a given architectural event is supported.
>   */
>  struct kvm_x86_pmu_feature {
> -       struct kvm_x86_cpu_feature anti_feature;
> +       struct kvm_x86_cpu_feature f;
>  };
> -#define        KVM_X86_PMU_FEATURE(__bit)                               =
               \
> -({                                                                      =
       \
> -       struct kvm_x86_pmu_feature feature =3D {                         =
         \
> -               .anti_feature =3D KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit)=
,        \
> -       };                                                               =
       \
> -                                                                        =
       \
> -       feature;                                                         =
       \
> +#define        KVM_X86_PMU_FEATURE(__reg, __bit)                        =
       \
> +({                                                                     \
> +       struct kvm_x86_pmu_feature feature =3D {                         =
 \
> +               .f =3D KVM_X86_CPU_FEATURE(0xa, 0, __reg, __bit),        =
 \
> +       };                                                              \
> +                                                                       \
> +       kvm_static_assert(KVM_CPUID_##__reg =3D=3D KVM_CPUID_EBX ||      =
   \
> +                         KVM_CPUID_##__reg =3D=3D KVM_CPUID_ECX);       =
   \
> +       feature;                                                        \
>  })
>
> -#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED   KVM_X86_PMU_FEATURE(5)
> +#define X86_PMU_FEATURE_CPU_CYCLES             KVM_X86_PMU_FEATURE(EBX, =
0)
> +#define X86_PMU_FEATURE_INSNS_RETIRED          KVM_X86_PMU_FEATURE(EBX, =
1)
> +#define X86_PMU_FEATURE_REFERENCE_CYCLES       KVM_X86_PMU_FEATURE(EBX, =
2)
> +#define X86_PMU_FEATURE_LLC_REFERENCES         KVM_X86_PMU_FEATURE(EBX, =
3)
> +#define X86_PMU_FEATURE_LLC_MISSES             KVM_X86_PMU_FEATURE(EBX, =
4)
> +#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED   KVM_X86_PMU_FEATURE(EBX, =
5)
> +#define X86_PMU_FEATURE_BRANCHES_MISPREDICTED  KVM_X86_PMU_FEATURE(EBX, =
6)

Why not add top down slots now?

> +
> +#define X86_PMU_FEATURE_INSNS_RETIRED_FIXED    KVM_X86_PMU_FEATURE(ECX, =
0)
> +#define X86_PMU_FEATURE_CPU_CYCLES_FIXED       KVM_X86_PMU_FEATURE(ECX, =
1)
> +#define X86_PMU_FEATURE_REFERENCE_CYCLES_FIXED KVM_X86_PMU_FEATURE(ECX, =
2)

Perhaps toss 'TSC' between CYCLES and FIXED?

And add top down slots now>

>
>  static inline unsigned int x86_family(unsigned int eax)
>  {
> @@ -697,10 +712,16 @@ static __always_inline bool this_cpu_has_p(struct k=
vm_x86_cpu_property property)
>
>  static inline bool this_pmu_has(struct kvm_x86_pmu_feature feature)
>  {
> -       uint32_t nr_bits =3D this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_V=
ECTOR_LENGTH);
> +       uint32_t nr_bits;
>
> -       return nr_bits > feature.anti_feature.bit &&
> -              !this_cpu_has(feature.anti_feature);
> +       if (feature.f.reg =3D=3D KVM_CPUID_EBX) {
> +               nr_bits =3D this_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VE=
CTOR_LENGTH);
> +               return nr_bits > feature.f.bit && !this_cpu_has(feature.f=
);

Ouch! Reverse polarity bits make 'this_cpu_has' non-intuitive.

> +       }
> +
> +       GUEST_ASSERT(feature.f.reg =3D=3D KVM_CPUID_ECX);
> +       nr_bits =3D this_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS)=
;
> +       return nr_bits > feature.f.bit || this_cpu_has(feature.f);
>  }
>
>  static __always_inline uint64_t this_cpu_supported_xcr0(void)
> @@ -916,10 +937,16 @@ static __always_inline bool kvm_cpu_has_p(struct kv=
m_x86_cpu_property property)
>
>  static inline bool kvm_pmu_has(struct kvm_x86_pmu_feature feature)
>  {
> -       uint32_t nr_bits =3D kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VE=
CTOR_LENGTH);
> +       uint32_t nr_bits;
>
> -       return nr_bits > feature.anti_feature.bit &&
> -              !kvm_cpu_has(feature.anti_feature);
> +       if (feature.f.reg =3D=3D KVM_CPUID_EBX) {
> +               nr_bits =3D kvm_cpu_property(X86_PROPERTY_PMU_EBX_BIT_VEC=
TOR_LENGTH);
> +               return nr_bits > feature.f.bit && !kvm_cpu_has(feature.f)=
;
> +       }
> +
> +       TEST_ASSERT_EQ(feature.f.reg, KVM_CPUID_ECX);
> +       nr_bits =3D kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +       return nr_bits > feature.f.bit || kvm_cpu_has(feature.f);
>  }
>
>  static __always_inline uint64_t kvm_cpu_supported_xcr0(void)
> --
> 2.42.0.869.gea05f2083d-goog
>
