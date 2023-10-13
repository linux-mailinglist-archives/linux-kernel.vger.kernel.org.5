Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315467C9121
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjJMXC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMXCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:02:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D509BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:02:24 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c9e1b431d0so17974485ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697238143; x=1697842943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAwWWo5yCpMm0VPIPIUbjIfq+AMFyPJIitllLaC/0sI=;
        b=pgkO+lPiTSMhtLsGBVV07pL6H7tllVQ01A3bIAprRbyuPtcoiQD6w2jJSb+zdP4FjG
         QJsdmbsJxL31S7tdu2E0egSPw3Wxm6/NxWJGEdXo5RWrmHtsVLZs8zUbS/BsL6F/ARc1
         Bov9pn/nFqU7P7Y/BH/QxgT6oUOTFDZJOXoWTLCQh8fUKTsJ5FaLlFmf35plda+z0dZw
         dMGQ/qlS2WHna999PQaSC8wNeawgRfpxQDLC0Gu5XI4djayWPqTH9HF+L9fNFofyZ3wZ
         590GDSqzFKuH6IM5c/a5QcLfooLke1RjdO/MIgYaO4MhF6iDGseffNg8ERs8S/hNbFz9
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697238143; x=1697842943;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xAwWWo5yCpMm0VPIPIUbjIfq+AMFyPJIitllLaC/0sI=;
        b=MnmC3F1N4YcqLmbum/OlvLgUQGUn8cdBaOtUZp0Ew0GAwAiJvrZzMNlLq9buhaO4Ec
         aR76lh/VKJpusXdJ1Gx14x5lALDPmJcQgz33/xJp4sUVtHb7lQRewwbrxSQs4Bmznsxj
         7V+w+1NCJ6j2iDyNHfyHP3wD+UWCEXqRk08FdNU9JD//ZyY8xv0XRLYLRjEsJemtekRR
         RMp3GPTBTlWbivvKaaNzRuvVG1K8NXx7alvk6gbUDpjO1celY9j21OA/+eddkQaDjr1P
         L8DofL2Mbw11vKr+vaalus0X4LDK1PjLBYZCj9WRfCBp7Ux0E6gGkQVmLgQ4ZdPgFytK
         fzpQ==
X-Gm-Message-State: AOJu0Yw8H5qeZPvVHEViruGySC+nbQ6MCS5K1oI+ewD3nO7oG92SiwQP
        xcs/NmotsF1NokDWumA5HEH6SeV7bvg=
X-Google-Smtp-Source: AGHT+IEmF7wehjc+0lr3X1mW2L/k+r8dXqzMshwy5GxakXdmPKhV038eFDxDGAYs8qeIF8F0Q/RatJC3e64=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d490:b0:1c7:2bb4:54fb with SMTP id
 c16-20020a170902d49000b001c72bb454fbmr564456plg.4.1697238143467; Fri, 13 Oct
 2023 16:02:23 -0700 (PDT)
Date:   Fri, 13 Oct 2023 16:02:21 -0700
In-Reply-To: <ZSnIKQ4bUavAtBz6@google.com>
Mime-Version: 1.0
References: <20231006011255.4163884-1-vannapurve@google.com> <ZSnIKQ4bUavAtBz6@google.com>
Message-ID: <ZSnMfS9A9HgW--YE@google.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023, Sean Christopherson wrote:
> On Fri, Oct 06, 2023, Vishal Annapurve wrote:
> > TSC calibration for native execution gets the TSC frequency from CPUID,
> > but also ends up setting lapic_timer_period. When using oneshot mode
> > with lapic timer, predefined value of lapic_timer_period causes lapic
> > timer calibration to be skipped with wrong multipliers set for lapic
> > timer.
> >=20
> > To avoid this issue, override the TSC calibration step for TDX VMs to
> > just calculate the TSC frequency using cpuid values.
>=20
> This is a hack to workaround a KVM TDX bug.  Per Intel's SDM:
>=20
>   The APIC timer frequency will be the processor=E2=80=99s bus clock or c=
ore crystal
>   clock frequency (when TSC/core crystal clock ratio is enumerated in CPU=
ID
>   leaf 0x15) divided by the value specified in the divide configuration r=
egister.
>=20
> TDX hardcodes the core crystal frequency to 25Mhz, whereas KVM hardcodes =
the APIC
> bus frequency to 1Ghz.  Upstream KVM's *current* behavior is fine, becaus=
e KVM
> doesn't advertise support for CPUID 0x15, i.e. doesn't announce to host u=
serspace
> that it's safe to expose CPUID 0x15 to the guest.  Because TDX makes expo=
sing
> CPUID 0x15 mandatory, KVM needs to be taught to correctly emulate the gue=
st's
> APIC bus frequency, a.k.a. the TDX guest core crystal frequency of 25Mhz.
>=20
> I.e. tmict_to_ns() needs to replace APIC_BUS_CYCLE_NS with some math that=
 makes
> the guest's APIC timer actually run at 25Mhz given whatever the host APIC=
 bus
> runs at.
>=20
>   static inline u64 tmict_to_ns(struct kvm_lapic *apic, u32 tmict)
>   {
> 	return (u64)tmict * APIC_BUS_CYCLE_NS * (u64)apic->divide_count;
>   }
>=20
> The existing guest code "works" because the calibration code effectively =
discovers
> the host APIC bus frequency.  If we really want to force calibration, the=
n the
> best way to do that would be to add a command line option to do exactly t=
hat, not
> hack around a KVM TDX bug.
>=20
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index 15f97c0abc9d..ce1cec6b3c18 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -723,7 +723,8 @@ unsigned long native_calibrate_tsc(void)
>          * lapic_timer_period here to avoid having to calibrate the APIC
>          * timer later.
>          */
> -       lapic_timer_period =3D crystal_khz * 1000 / HZ;
> +       if (!force_lapic_timer_calibration)
> +               lapic_timer_period =3D crystal_khz * 1000 / HZ;
>  #endif
> =20
>         return crystal_khz * ebx_numerator / eax_denominator;
>=20
> But I would be very leery of forcing calibration, as effectively calibrat=
ing to
> the *host* core crystal frequency will cause the guest APIC timer to be w=
rong if
> the VM is migrated to a host with a different core crystal frequency.  Re=
lying
> on CPUID 0x15, if it's available, avoids that problem because it puts the=
 onus on
> the hypervisor to account for the new host's frequency when emulating the=
 APIC
> timer.  That mess exists today, but deliberate ignoring the mechanism tha=
t allows
> the host to fix the mess would be asinine IMO.

Gah, I had a brainfart.  tmict_to_ns() obviously converts TMICT to nanoseco=
nds,
and then converts nanoseconds into whatever frequency the underlying host t=
imer
runs at.

So it's really only TDX that is problematic, as TDX demands the APIC bus be
emulated at a frequency other than 1Ghz.
