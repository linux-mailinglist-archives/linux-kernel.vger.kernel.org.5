Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415D77E0F7D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjKDMwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 08:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 08:52:01 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7548D1B2
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 05:51:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so3721a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Nov 2023 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699102317; x=1699707117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2AIE4p4WRtdyGEtqiMMAREra62fDWl2hz5iPPeenLI=;
        b=RXPhzG7kV/uuD1QgBw6ZDyEWL0RwPFIZpJiZSmZ46uBbvuIzkOS57NXghzaj3JwJts
         BescPL0P3Sx7Xny3ryiDZqP/tA33oFLm3OKDXgfrLnrsLwA0ThZ7CyGco332boEhTtg+
         kxP6i/CRrCz9MwvW6MnXxzd6Xd9kePkBQICze7lib4xRMKVBVOo/kJRFDN3UiMtTo2x1
         YZs5rzsbEmggHyxNBgXUOc5rbpq8V632gh83ZraoWiJankFRM4QE9S27qMq3vmWGtgMJ
         rrbSRguQK46GcVzDz99A6KM0fDsbdmzrXh17VZyjCbT0//3KH3RwH9CQ9c+n8y6XdiOY
         Gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699102317; x=1699707117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2AIE4p4WRtdyGEtqiMMAREra62fDWl2hz5iPPeenLI=;
        b=TN2dQfxNajY35rf2LrO9n4RXc4nZVgkjBtbeJooEbECyJHWaU86N/tLPqQvKavWQmq
         Y61itRJ26Qd6aNYqKpAZWbZA5wtz3jtxCP2xm7xIEHyYuOSajpJJ+pjprZqZX3EoK6Ur
         GrlAxHEvYD96Oa0uvCasOhMsMILvQC/CDaCw1fqWqD/YppgoPvN8K4hutjLWGbsFeSrT
         ldjif3pjtmmvar7RzPZDrSeaOAwsGRiqShmSrN0gF+E2krkHg4WjyHr7geMtYJGL+433
         kGybEI2UvJSf2zxY75P4tPawc58s1F0t4kRjOvwZ6XIGv5SvC6saLAJNn6RIX0hbXkq3
         ZD/A==
X-Gm-Message-State: AOJu0Yxq24vDYMWVYQZv55Q9fmIbPXEK48UOTgal9LmyRVcurC9R6ERr
        Srnt5Ux1cx3dyAdNWuug1EV3mDgioRKbTsd805LbmZPQNmwCNuCCy/NhuA==
X-Google-Smtp-Source: AGHT+IEEGLyii3aUasxcuPocdOK0Vspj4P9pjJ/spYgKztqFYT3Mr3ycE6hYjTmsTLqbwlPPNX+TJ0UKeNgWANwRlcc=
X-Received: by 2002:a50:9b07:0:b0:543:fc4f:b7ac with SMTP id
 o7-20020a509b07000000b00543fc4fb7acmr56154edi.7.1699102316747; Sat, 04 Nov
 2023 05:51:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231104000239.367005-1-seanjc@google.com> <20231104000239.367005-7-seanjc@google.com>
In-Reply-To: <20231104000239.367005-7-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Sat, 4 Nov 2023 05:51:45 -0700
Message-ID: <CALMp9eTQiom+0b5qPP_0u2tGqw9GcWbJVMNGeNZms8MTH8byuQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/20] KVM: selftests: Add vcpu_set_cpuid_property() to
 set properties
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
> From: Jinrong Liang <cloudliang@tencent.com>
>
> Add vcpu_set_cpuid_property() helper function for setting properties, and
> use it instead of open coding an equivalent for MAX_PHY_ADDR.  Future vPM=
U
> testcases will also need to stuff various CPUID properties.
>
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  .../testing/selftests/kvm/include/x86_64/processor.h |  4 +++-
>  tools/testing/selftests/kvm/lib/x86_64/processor.c   | 12 +++++++++---
>  .../kvm/x86_64/smaller_maxphyaddr_emulation_test.c   |  2 +-
>  3 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/too=
ls/testing/selftests/kvm/include/x86_64/processor.h
> index 25bc61dac5fb..a01931f7d954 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -994,7 +994,9 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vc=
pu)
>         vcpu_ioctl(vcpu, KVM_GET_CPUID2, vcpu->cpuid);
>  }
>
> -void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr=
);
> +void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
> +                            struct kvm_x86_cpu_property property,
> +                            uint32_t value);
>
>  void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
>  void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/t=
esting/selftests/kvm/lib/x86_64/processor.c
> index d8288374078e..9e717bc6bd6d 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -752,11 +752,17 @@ void vcpu_init_cpuid(struct kvm_vcpu *vcpu, const s=
truct kvm_cpuid2 *cpuid)
>         vcpu_set_cpuid(vcpu);
>  }
>
> -void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr=
)
> +void vcpu_set_cpuid_property(struct kvm_vcpu *vcpu,
> +                            struct kvm_x86_cpu_property property,
> +                            uint32_t value)
>  {
> -       struct kvm_cpuid_entry2 *entry =3D vcpu_get_cpuid_entry(vcpu, 0x8=
0000008);
> +       struct kvm_cpuid_entry2 *entry;
> +
> +       entry =3D __vcpu_get_cpuid_entry(vcpu, property.function, propert=
y.index);
> +
> +       (&entry->eax)[property.reg] &=3D ~GENMASK(property.hi_bit, proper=
ty.lo_bit);
> +       (&entry->eax)[property.reg] |=3D value << (property.lo_bit);

What if 'value' is too large?

Perhaps:
         value <<=3D property.lo_bit;
         TEST_ASSERT(!(value & ~GENMASK(property.hi_bit,
property.lo_bit)), "value is too large");
         (&entry->eax)[property.reg] |=3D value;

> -       entry->eax =3D (entry->eax & ~0xff) | maxphyaddr;
>         vcpu_set_cpuid(vcpu);
>  }
>
> diff --git a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulat=
ion_test.c b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulatio=
n_test.c
> index 06edf00a97d6..9b89440dff19 100644
> --- a/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_tes=
t.c
> +++ b/tools/testing/selftests/kvm/x86_64/smaller_maxphyaddr_emulation_tes=
t.c
> @@ -63,7 +63,7 @@ int main(int argc, char *argv[])
>         vm_init_descriptor_tables(vm);
>         vcpu_init_descriptor_tables(vcpu);
>
> -       vcpu_set_cpuid_maxphyaddr(vcpu, MAXPHYADDR);
> +       vcpu_set_cpuid_property(vcpu, X86_PROPERTY_MAX_PHY_ADDR, MAXPHYAD=
DR);
>
>         rc =3D kvm_check_cap(KVM_CAP_EXIT_ON_EMULATION_FAILURE);
>         TEST_ASSERT(rc, "KVM_CAP_EXIT_ON_EMULATION_FAILURE is unavailable=
");
> --
> 2.42.0.869.gea05f2083d-goog
>
