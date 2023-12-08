Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329980AC39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574622AbjLHSj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjLHSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:39:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9946C6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702060770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xpi6oKeZnMTqEA1GU/S46QdXQaCqr8RrHilbjEq4XU=;
        b=YR7wyDa9riYA9msFbkr7TvyqH/HyMjM2oTp5HM8JHFU94cUhjXRTYVLSi8hqq05LSMsPuN
        BrDW9AfSo0L9Gn3l0jKubRyamanMLsdPSvtaNPLAmE4hEaD0bhwgm//myywsgPuiRO4VUU
        xDtyZWZW2545Cu8uygLnIkWfusFexb8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-NidrHa2oOa-jFs-wNpBhbg-1; Fri, 08 Dec 2023 13:39:29 -0500
X-MC-Unique: NidrHa2oOa-jFs-wNpBhbg-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7c410725a6cso397694241.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 10:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702060769; x=1702665569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xpi6oKeZnMTqEA1GU/S46QdXQaCqr8RrHilbjEq4XU=;
        b=dqqebttdNMgUHklDsJeQw25AN5cHRuB04VusMhcZ+i1ygFhJddGv2tgac73ibKPRVL
         GhY21FznSx5ZO8GJpolaambGIS+FJEAVsKCMlgSWlzvRPLgDwb9eZYpdRFwbzPok2bSK
         WDgleVn6GZIRql7U98sIIqwCicXNelPBu1ptslPncS24Sc40tNzXZic7PgSGE2jCJyNV
         MNdU9RDXkRjwbmt2mCQkzilCSuSVwdIwSEe+Rei/WiuLeOKhngMdnu1kiqCjMAirYmeu
         wR6sdr4MG0u2nTNFf81dgWluGYMCrmpsHo/STNDNmRqHFl0RSm2LU2O8QJ4cBvEdkiVy
         B+aw==
X-Gm-Message-State: AOJu0YxS862xU/ExVn1nreC1iaJFzuiDT63e+aYTZE+GP5stATXZSpkd
        7aWJzycrtp4/qdkD4ycQynyZykSu10eY9FFVhMhQjwHnCLo/Q0NeENKw+c5o8nQibGx2GueKhYu
        sz1+3eS/xwd7jquznySHUzDbgyHOJxDDB9rIUhdbO
X-Received: by 2002:a05:6122:3109:b0:4b2:f6a2:7736 with SMTP id cg9-20020a056122310900b004b2f6a27736mr649956vkb.28.1702060768853;
        Fri, 08 Dec 2023 10:39:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEV1aa0sxRQBUtb8Yg9bmtWfZ++LYpyWwYuXdMa4yWBmh1Kh+o1C5/hDc0PWIxzji4w5Q3kKRaFYRtPJHsE5OI=
X-Received: by 2002:a05:6122:3109:b0:4b2:f6a2:7736 with SMTP id
 cg9-20020a056122310900b004b2f6a27736mr649953vkb.28.1702060768633; Fri, 08 Dec
 2023 10:39:28 -0800 (PST)
MIME-Version: 1.0
References: <20231205234956.1156210-1-michael.roth@amd.com> <ZXCTHJPerz6l9sPw@google.com>
In-Reply-To: <ZXCTHJPerz6l9sPw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 19:39:16 +0100
Message-ID: <CABgObfb2AxwvseadmEBS7=VWLKKpYVeHkaecrPXG47sMfCKEZg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Fix handling of EFER_LMA bit when SEV-ES is enabled
To:     Sean Christopherson <seanjc@google.com>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 4:28=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Blech.  This is a hack to fix even worse hacks.  KVM ignores CR0/CR4/EFER=
 values
> that are set via KVM_SET_SREGS, i.e. KVM is rejecting an EFER value that =
it will
> never consume, which is ridiculous.  And the fact that you're not trying =
to have
> KVM actually set state further strengthens my assertion that tracking CR0=
/CR4/EFER
> in KVM is pointless necessary for SEV-ES+ guests[1].

I agree that KVM is not going to consume CR0/CR4/EFER. I disagree that
it's a good idea to have a value of vcpu->arch.efer that is
architecturally impossible (so much so that it would fail vmentry in a
non-SEV-ES guest).

I also agree that changing the source is not particularly useful, but
then changing the destination can be easily done in userspace.

In other words, bugfix or not this can and should be merged as a code
cleanup (though your older "[PATCH 1/2] KVM: SVM: Update EFER software
model on CR0 trap for SEV-ES" is nicer in that it clarifies that
svm->vmcb->save.efer is not used, and that's what I would like to
apply).

> So my very strong preference is to first skip the kvm_is_valid_sregs() ch=
eck

No, please don't. If you want to add a quirk that, when disabled,
causes all guest state get/set ioctls to fail, go ahead. But invalid
processor state remains invalid, and should be rejected, even when KVM
won't consume it.

> My understanding is that SVM_VMGEXIT_AP_CREATION is going to force KVM to=
 assume
> maximal state anyways since KVM will have no way of verifying what state =
is actually
> shoved into the VMSA, i.e. emulating INIT is wildly broken[2].

Yes, or alternatively a way to pass CR0/CR4/EFER from the guest should
be included in the VMGEXIT spec.

> Side topic, Peter suspected that KVM _does_ need to let userspace set CR8=
 since
> that's not captured in the VMSA[3].

Makes sense, and then we would have to apply the 2/2 patch from 2021
as well. But for now I'll leave that aside.

Paolo

> [1] https://lore.kernel.org/all/YJla8vpwqCxqgS8C@google.com
> [2] https://lore.kernel.org/all/20231016132819.1002933-38-michael.roth@am=
d.com
> [3] https://lore.kernel.org/all/CAMkAt6oL9tfF5rvP0htbQNDPr50Zk41Q4KP-dM0N=
+SJ7xmsWvw@mail.gmail.com
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2c924075f6f1..6fb2b913009e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11620,7 +11620,8 @@ static int __set_sregs_common(struct kvm_vcpu *vc=
pu, struct kvm_sregs *sregs,
>         int idx;
>         struct desc_ptr dt;
>
> -       if (!kvm_is_valid_sregs(vcpu, sregs))
> +       if (!vcpu->arch.guest_state_protected &&
> +           !kvm_is_valid_sregs(vcpu, sregs))
>                 return -EINVAL;
>
>         apic_base_msr.data =3D sregs->apic_base;
>

