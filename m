Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E097C906A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJMWn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:43:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB7B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:43:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a507eb61a6so38758757b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697237035; x=1697841835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxipDt6TGihxODuhMyyTMhWX2f2ccAuzIUgR7BlbguE=;
        b=oKhJpFAnEuKwHemVtQ+xiSksKNnvB1DTjooOIceS66JjykDm4mWOQ9mA8on6kQrXZc
         sPk6BvrLg/qdKgOtLvUG3eLfCTSOcaClHhaIzDDaVBBkp8mMF3XNTi9LVX916Fj4Bn1D
         ej+Q6zXPHsO/gbfFXUzZ9tvwPHlpkNKFITY64Op8QCSMFzjAqTuIbHXp+oCcM6WTjHZJ
         8GKoMlLIE6PlOquHF1BYS/8A57wnWBS4yAy1GSErI4/sG2lBhmXTmQ93eacjNSI0I0Yd
         1fHQHsb7YlGY56ZMPFRXKZ4M1Gov0+1Q+5mw4oCzd8Jb4mEaGMOQ0RFjWSw4xwbsvHGG
         Pj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237035; x=1697841835;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxipDt6TGihxODuhMyyTMhWX2f2ccAuzIUgR7BlbguE=;
        b=PBxa7sEzC5Oi8eUgdBS5iX034jqKujO/zYrpetD2CFRTfxjLk9AXU5AjMwt6RpX6oE
         GBzEvS0ffyQol+uE0mZZ84vcX16xwhyKzCHJOfX86moOYRMLu/fXbSS9XI5QS5IIXOeo
         BwFTzPk8T3yTYaUf5mNHTNC0J16xGYqxkFI9XzXLgAbUiVKSvHzVbEwVbFd2wcEKIGGA
         CU4vfm/3rNk5ENIVJpmA24BFezqPzTbb/4eJlRCqVsz+hRdd6HPuwTnzhfP1E+QhQTkb
         MTJv1eUkdN0G932DnTZ4SM/ZgNU6nqYV/4nsfD3h4j8zjBhwBFzpS/flYGOVGLG+pRgw
         YSuQ==
X-Gm-Message-State: AOJu0YwklX6xLAqoCwCJLike4qZlGTOfGXV4KKvkW4IKXOYNOQMQBhyr
        cs4FGcej+/1bGZsUOT018+QWxqTs2HU=
X-Google-Smtp-Source: AGHT+IE50jTlBFUYBMxQb+IStziCIDH4NSypI7Q2BF1zoaIsj3ggX3HEdFKv0JtOdtm/P1+O2GETQhCUR8g=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:838b:0:b0:5a8:170d:45a9 with SMTP id
 t133-20020a81838b000000b005a8170d45a9mr120408ywf.8.1697237035509; Fri, 13 Oct
 2023 15:43:55 -0700 (PDT)
Date:   Fri, 13 Oct 2023 15:43:53 -0700
In-Reply-To: <20231006011255.4163884-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20231006011255.4163884-1-vannapurve@google.com>
Message-ID: <ZSnIKQ4bUavAtBz6@google.com>
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Oct 06, 2023, Vishal Annapurve wrote:
> TSC calibration for native execution gets the TSC frequency from CPUID,
> but also ends up setting lapic_timer_period. When using oneshot mode
> with lapic timer, predefined value of lapic_timer_period causes lapic
> timer calibration to be skipped with wrong multipliers set for lapic
> timer.
>=20
> To avoid this issue, override the TSC calibration step for TDX VMs to
> just calculate the TSC frequency using cpuid values.

This is a hack to workaround a KVM TDX bug.  Per Intel's SDM:

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e crystal
  clock frequency (when TSC/core crystal clock ratio is enumerated in CPUID
  leaf 0x15) divided by the value specified in the divide configuration reg=
ister.

TDX hardcodes the core crystal frequency to 25Mhz, whereas KVM hardcodes th=
e APIC
bus frequency to 1Ghz.  Upstream KVM's *current* behavior is fine, because =
KVM
doesn't advertise support for CPUID 0x15, i.e. doesn't announce to host use=
rspace
that it's safe to expose CPUID 0x15 to the guest.  Because TDX makes exposi=
ng
CPUID 0x15 mandatory, KVM needs to be taught to correctly emulate the guest=
's
APIC bus frequency, a.k.a. the TDX guest core crystal frequency of 25Mhz.

I.e. tmict_to_ns() needs to replace APIC_BUS_CYCLE_NS with some math that m=
akes
the guest's APIC timer actually run at 25Mhz given whatever the host APIC b=
us
runs at.

  static inline u64 tmict_to_ns(struct kvm_lapic *apic, u32 tmict)
  {
	return (u64)tmict * APIC_BUS_CYCLE_NS * (u64)apic->divide_count;
  }

The existing guest code "works" because the calibration code effectively di=
scovers
the host APIC bus frequency.  If we really want to force calibration, then =
the
best way to do that would be to add a command line option to do exactly tha=
t, not
hack around a KVM TDX bug.

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..ce1cec6b3c18 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -723,7 +723,8 @@ unsigned long native_calibrate_tsc(void)
         * lapic_timer_period here to avoid having to calibrate the APIC
         * timer later.
         */
-       lapic_timer_period =3D crystal_khz * 1000 / HZ;
+       if (!force_lapic_timer_calibration)
+               lapic_timer_period =3D crystal_khz * 1000 / HZ;
 #endif
=20
        return crystal_khz * ebx_numerator / eax_denominator;

But I would be very leery of forcing calibration, as effectively calibratin=
g to
the *host* core crystal frequency will cause the guest APIC timer to be wro=
ng if
the VM is migrated to a host with a different core crystal frequency.  Rely=
ing
on CPUID 0x15, if it's available, avoids that problem because it puts the o=
nus on
the hypervisor to account for the new host's frequency when emulating the A=
PIC
timer.  That mess exists today, but deliberate ignoring the mechanism that =
allows
the host to fix the mess would be asinine IMO.

Even better would be for GCE to just enumerate support for TSC deadline alr=
eady,
because KVM already does the right thing to convert guest TSC frequency to =
host
TSC frequency.  KVM TDX would still need to add full support for CPUID 0x15=
, but
at least any problems with using one-shot mode will unlikely to impact real=
 guests.
