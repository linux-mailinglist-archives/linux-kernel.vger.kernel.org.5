Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1AF77BBBB9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbjJFP1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjJFP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:27:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D70A6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:27:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b95622c620so427318466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696606053; x=1697210853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jyuaGptoRI+XLyrpWhL7dysm7xTQHQIlC0lml8aK58Q=;
        b=jHb2VVu9r3WjWt/TEDutr+QVlyV7FNdowAPZoE9+uDSFBB14uwFZGW4kJbrGRdw4Lm
         lN0em/kRCEF+igJod2NIPTm5z/PCUglmgRuYDXLj50asxihz19SvBmhwhu51S20jXSew
         5CiXfaVli53tEBVgDiTCgo1v8mkQTEyd+2n7mXNyoq/3SvrGD0P/WqRaYNgtI0S0Osdx
         kYQqQDQDNk0RsCPFeLFr9sfwGNCGItaO+kkgSOPswZZrq9A0yMpBxwFhUZKemOWC8KtP
         ku/MT5k+fJMrLDCa13tKm+x109JGCIHhdGqFliw8vSZvVUykAbGpsESSQmVsUMM+48FR
         u4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696606053; x=1697210853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyuaGptoRI+XLyrpWhL7dysm7xTQHQIlC0lml8aK58Q=;
        b=EmnnGegs2HDFtREPF444N0oPEW67Gz7XHFZzxs2TZ610M12IpgxdAftgzvc2Bcz+GN
         DbflbUVdv1eJrq0Jerz1jUtEdJAXHv7GFylA6+mTzyezOjdKrDBO5K28oHKKzXz5kCGG
         aDBAlLKuzxzvuqHXdVxT5AIb9iTsO/uRea9pEjqrotihNzyoQWhsRTBtIsNyvqrvL2lv
         SYHXh8Ir7Oa83IVVIJtefPGy3MTRbNtOTC6tIspV6bmMIAklF7CDw51t2DrQT+GVJUFF
         jglTUzZvC+WpYseUzbCrJkf3TwIq26AMOTMOJR/9g8GQbI2pDYm+1rewxHxiPRpqKJo8
         97QA==
X-Gm-Message-State: AOJu0YwOzEsNhEeBYEWJKoG7D0/f7roRTBgc4emCRYDiNpDlOfsS+qU7
        zr9TzF2Mrps7PjBGH3lvsZp8qn7olJq2eqtBZ0Wy1A==
X-Google-Smtp-Source: AGHT+IFWMR0e0BE2h4rCvJRghurD9MT7szNiyzeDuK3b4I/m2kJGauI9sPdFm+a6lbFiCdDyB6XnSRDBnmFomvKXMcw=
X-Received: by 2002:a17:906:19b:b0:9a5:c9a8:1816 with SMTP id
 27-20020a170906019b00b009a5c9a81816mr7670611ejb.58.1696606052588; Fri, 06 Oct
 2023 08:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231006011255.4163884-1-vannapurve@google.com> <2d952c6b-2357-208b-e816-bca19c2a7ca6@intel.com>
In-Reply-To: <2d952c6b-2357-208b-e816-bca19c2a7ca6@intel.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Fri, 6 Oct 2023 08:27:19 -0700
Message-ID: <CAGtprH-_C28G1WEPqmgdpHJpo3_esqOnOYad6YiKQ6g4Z+s9wg@mail.gmail.com>
Subject: Re: [PATCH] x86/tdx: Override the tsc calibration for TDX VMs
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Sagi Shahar <sagis@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 6, 2023 at 7:03=E2=80=AFAM Dave Hansen <dave.hansen@intel.com> =
wrote:
>
> On 10/5/23 18:12, Vishal Annapurve wrote:
> > +/**
> > + * Determine TSC frequency via CPUID, else return 0.
> > + */
> > +static unsigned long tdx_calibrate_tsc(void)
> > +{
> > +     unsigned int eax_denominator =3D 0, ebx_numerator =3D 0, ecx_hz =
=3D 0, edx =3D 0;
> > +     unsigned int crystal_khz;
> > +
> > +     /* CPUID 15H TSC/Crystal ratio, plus optionally Crystal Hz */
> > +     cpuid(0x15, &eax_denominator, &ebx_numerator, &ecx_hz, &edx);
> > +
> > +     if (ebx_numerator =3D=3D 0 || eax_denominator =3D=3D 0)
> > +             return 0;
> > +
> > +     crystal_khz =3D ecx_hz / 1000;
> > +
> > +     /*
> > +      * TSC frequency reported directly by CPUID is a "hardware report=
ed"
> > +      * frequency and is the most accurate one so far we have. This
> > +      * is considered a known frequency.
> > +      */
> > +     if (crystal_khz !=3D 0)
> > +             setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
> > +
> > +     return crystal_khz * ebx_numerator / eax_denominator;
> > +}
> > +
>
> Would it be possible to do this by refactoring the existing code and
> calling it directly instead of copying and pasting so much?

One option is to call native_calibrate_tsc from tdx_calibrate_tsc and
undo the lapic_timer_period configuration after the call. Does that
sound reasonable?
