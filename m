Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0247DBD8D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 17:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjJ3QM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 12:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3QM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 12:12:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73223C9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:12:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7be940fe1so45418717b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698682374; x=1699287174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tgkw7eW9dhnk+knrp7jJaqDTfZMev9xwF7TYvvMUsbc=;
        b=kNeNHzK1Sz8aeXqqKEvpbAb68aFVu1cPCqsiiJ2Dk5nqBE8kZYoB6bLegGvN5z67N3
         4vH+PUUME3MJxSCsJybvOeO8FPA2ANuh5XluvW0rg1Xj960dj7adVpAwWe9EK5qartPJ
         r64aSEzAT5AF/Rc1L5bixs6YJO9sxE1iqmJN5HGMCWRZGgQSEdF9b5hH10UiwIPd7S4Z
         ++c3NchvC+MXcwms1XNUJnfyFcVwnlxeaILjvLSb0G8GG+OWlPab7jKXg/kQVYfL4hkK
         0aVY1yD9qFv0DEHpuHcN17a34m0lJLVZ/jLuJUtpZpMsXmI5vAhZZwdNJvmC9aIaGOmV
         z2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698682374; x=1699287174;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tgkw7eW9dhnk+knrp7jJaqDTfZMev9xwF7TYvvMUsbc=;
        b=C1w5vyTAptkraVqSXbMXZFfrrkaONPSam009Dyx2Nxw5actO6iuTEDfKNKMgH7/wX6
         yUv1r9WmAMomZsB1+j8p3FQim33J9ULQRpwD898KE8awF58xGxFYL/NdeCMPgopbUCUt
         XvAx3SdQBYQ+Xu+XU8+wkwSuZ2cVTUwCUruKCuibUe05opwcoCSXIrT/CvimaeXRKMej
         ZCaehg+EqKjUyH97FL1qUMSy0ArYY0QdK5DNMC2TfV2iAm0sHAFKaQsZ2Vy2qyiSYUfA
         VPLfTuT1n8N1kCb3FZKJbmBDvt36nmJfp6o0vsqaEWQ3UMhZGo7GbRF/Qviy8feRYGsv
         ePGw==
X-Gm-Message-State: AOJu0Yxh2yrwkqX/x8AUeyss8jfwGscZ0mINTvkvYJnxWwqRaJxM4C9M
        iTpyXhrshfy3QTmf8ehabFw32ekiOjc=
X-Google-Smtp-Source: AGHT+IHXERmhF1p7ZLDX+e5zNpxMNE30YgXaemlxnBQEovmUJpclQzlFIZqH7J8ykW6OvSDZcwj8yNLtP1w=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:920b:0:b0:59b:f3a2:cd79 with SMTP id
 j11-20020a81920b000000b0059bf3a2cd79mr205625ywg.8.1698682374564; Mon, 30 Oct
 2023 09:12:54 -0700 (PDT)
Date:   Mon, 30 Oct 2023 09:12:53 -0700
In-Reply-To: <20231029093928.138570-1-jose.pekkarinen@foxhound.fi>
Mime-Version: 1.0
References: <20231029093928.138570-1-jose.pekkarinen@foxhound.fi>
Message-ID: <ZT_WBanoip8zhxis@google.com>
Subject: Re: [PATCH] KVM: x86: replace do_div with div64_ul
From:   Sean Christopherson <seanjc@google.com>
To:     "=?utf-8?B?Sm9zw6k=?= Pekkarinen" <jose.pekkarinen@foxhound.fi>
Cc:     pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com,
        skhan@linuxfoundation.org, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023, Jos=C3=A9 Pekkarinen wrote:
> Reported by coccinelle, there is a do_div call that does
> 64-by-32 divisions even in 64bit platforms, this patch will
> move it to div64_ul macro that will decide the correct
> division function for the platform underneath. The output
> the warning follows:
>=20
> arch/x86/kvm/lapic.c:1948:1-7: WARNING: do_div() does a 64-by-32 division=
, please consider using div64_ul instead.
>=20
> Signed-off-by: Jos=C3=A9 Pekkarinen <jose.pekkarinen@foxhound.fi>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 3e977dbbf993..0b90c6ad5091 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1945,7 +1945,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *=
apic)
>  	guest_tsc =3D kvm_read_l1_tsc(vcpu, rdtsc());
> =20
>  	ns =3D (tscdeadline - guest_tsc) * 1000000ULL;
> -	do_div(ns, this_tsc_khz);
> +	div64_ul(ns, this_tsc_khz);

Well this is silly, virtual_tsc_khz is a u32.

	unsigned long this_tsc_khz =3D vcpu->arch.virtual_tsc_khz;

struct kvm_vcpu_arch {=20

	...

	u32 virtual_tsc_khz;

}

I assume this will make coccinelle happy?

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 245b20973cae..31e9c84b8791 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1932,7 +1932,7 @@ static void start_sw_tscdeadline(struct kvm_lapic *ap=
ic)
        u64 ns =3D 0;
        ktime_t expire;
        struct kvm_vcpu *vcpu =3D apic->vcpu;
-       unsigned long this_tsc_khz =3D vcpu->arch.virtual_tsc_khz;
+       u32 this_tsc_khz =3D vcpu->arch.virtual_tsc_khz;
        unsigned long flags;
        ktime_t now;
=20

