Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88025765202
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjG0LN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjG0LNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:13:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78AA0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690456328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzR/29ssKHTlIDAdd/Fjb9KFzV0w37Bkt3676oqfegA=;
        b=OOnKAvofLn2Lphy0hRSV3aV2CyZLYU3tjwTOCLh1jGfHCo/CwsLWHtJEzRBby7TN7KwhsR
        E+XX3ETZ1SJDcKtaDZVxt+fUjbVBhDTXwkdX1X1u5Qa9/0ED8wrNIkBSkroRR/4aCMAMoa
        WCLErkyuFM48Yknx+D0xntU0aYtemvQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-3TqGN0h5N7Gzy2deP26Zeg-1; Thu, 27 Jul 2023 07:12:07 -0400
X-MC-Unique: 3TqGN0h5N7Gzy2deP26Zeg-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9c548bc66so4211101fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456326; x=1691061126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzR/29ssKHTlIDAdd/Fjb9KFzV0w37Bkt3676oqfegA=;
        b=OS5+kUEZkobApSKo1IXuxX4RcrUYjEyqVOgrzaMBxNCpwH2NnKwvWakMicS+awa4jW
         tv1r0kZ3toK7HuGluuvhn18SWR7BmdT9Ep5arczxIOKbI15bT4j7PBQUyCYZ+sVmn4c9
         ui/RbEUsdt/8zj7CF3jmPAatWaF+QhtwBan7Jsz2iL5FQzxyGAbp3aQy34IuzoqlcxAV
         2S4SYgyX5tkXCn5sP9dd6QXYpfmF3Z2XEE/2G7hPSEhJ7x3g9qOfDOWaOjRVTHNnBykI
         zaFnq5e2ifj603cNNy0bQAWBQPCz5L1FUxcgBzu57orRexWsVEEhb/ZBlyv2llDrHwv/
         jZCA==
X-Gm-Message-State: ABy/qLar/8g+BID9gU33Zchru6edDOEpC93kk5IbmDSXl22Lpp6ZaJUZ
        FpD6aqwSiRGvtED6fvkZMf/3XyBFDZZMh2pmCEcVco4Kp++Zis/uWbQI/6303rPjVZkGUhxf0O4
        0zKcvCxnOf3yR5cw/WQruDNfb2Kalx5zKZ5NkKRBh
X-Received: by 2002:a05:6512:2386:b0:4fb:821e:2241 with SMTP id c6-20020a056512238600b004fb821e2241mr2053308lfv.23.1690456325983;
        Thu, 27 Jul 2023 04:12:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHVcSXFbTNHvChrljnKmKfUt/IbSL9KtTtcftDFpfX3hleE49JbqtNOhURn54n+68XPYFw909b0goEvLHGOH5s=
X-Received: by 2002:a05:6512:2386:b0:4fb:821e:2241 with SMTP id
 c6-20020a056512238600b004fb821e2241mr2053291lfv.23.1690456325651; Thu, 27 Jul
 2023 04:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com>
 <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com> <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
In-Reply-To: <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
From:   Tao Liu <ltao@redhat.com>
Date:   Thu, 27 Jul 2023 19:11:29 +0800
Message-ID: <CAO7dBbXN6hTbJVH8V5UCAxcOM4+-f0qACbd9n9HaP19F4mPEqw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, bhe@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Mon, Jul 17, 2023 at 11:11=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> On Mon, Jul 17, 2023 at 10:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >
> > On Mon, 17 Jul 2023 at 15:53, Tao Liu <ltao@redhat.com> wrote:
> > >
> > > Hi Borislav,
> > >
> > > On Thu, Jul 13, 2023 at 6:05=E2=80=AFPM Borislav Petkov <bp@alien8.de=
> wrote:
> > > >
> > > > On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > > > >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++=
++----
> > > > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > > >
> > > > Ok, pls try this totally untested thing.
> > > >
> > > > Thx.
> > > >
> > > > ---
> > > > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compres=
sed/sev.c
> > > > index 09dc8c187b3c..fefe27b2af85 100644
> > > > --- a/arch/x86/boot/compressed/sev.c
> > > > +++ b/arch/x86/boot/compressed/sev.c
> > > > @@ -404,13 +404,20 @@ void sev_enable(struct boot_params *bp)
> > > >         if (bp)
> > > >                 bp->cc_blob_address =3D 0;
> > > >
> > > > +       /* Check for the SME/SEV support leaf */
> > > > +       eax =3D 0x80000000;
> > > > +       ecx =3D 0;
> > > > +       native_cpuid(&eax, &ebx, &ecx, &edx);
> > > > +       if (eax < 0x8000001f)
> > > > +               return;
> > > > +
> > > >         /*
> > > >          * Setup/preliminary detection of SNP. This will be sanity-=
checked
> > > >          * against CPUID/MSR values later.
> > > >          */
> > > >         snp =3D snp_init(bp);
> > > >
> > > > -       /* Check for the SME/SEV support leaf */
> > > > +       /* Recheck the SME/SEV support leaf */
> > > >         eax =3D 0x80000000;
> > > >         ecx =3D 0;
> > > >         native_cpuid(&eax, &ebx, &ecx, &edx);
> > > >
> > > Thanks a lot for the patch above! Sorry for the late response. I have
> > > compiled and tested it locally against 6.5.0-rc1, though it can pass
> > > the early stage of kexec kernel bootup,
> >
> > OK, so that proves that the cc_blob table access is the culprit here.
> > That still means that kexec on SEV is likely to explode in the exact
> > same way should anyone attempt that.
> >
> >
> > > however the kernel will panic
> > > occasionally later. The test machine is the one with Intel Atom
> > > x6425RE cpu which encountered the page fault issue of missing efi
> > > config table.
> > >
> >
> > Agree with Boris that this seems entirely unrelated.
>
> Agree, I will have a retest based on Boris's suggestions.
>
> >
> > > ...snip...
> > > [   21.360763]  nvme0n1: p1 p2 p3
> > > [   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
> > > [   21.421097] pps pps1: new PPS source ptp1
> > > [   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized):=
 PHC added
> > > [   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
> > > (5.0 GT/s PCIe x1 link)
> > > [   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
> > > [   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
> > > [   21.479446] BUG: kernel NULL pointer dereference, address: 0000000=
000000008
> > > [   21.486405] #PF: supervisor read access in kernel mode
> > > [   21.491519] mmc1: Failed to initialize a non-removable card
> > > [   21.491538] #PF: error_code(0x0000) - not-present page
> > > [   21.502229] PGD 0 P4D 0
> > > [   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > [   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-=
rc1+ #1
> > > [   21.515905] Hardware name: ...snip...
> >
> >
> > Why are you snipping the hardware name?
>

Our partner said it is OK to discuss in public, so the hardware is:
Hardware name: LENOVO 11KL0FVT06/3334, BIOS M4XKT14A 05/17/2023

The machine is Lenovo ThinkEdge SE10.

Thanks,
Tao Liu

> Sorry for the inconvenience here... The machine is borrowed from our
> partner, which may not be officially released to the market. I haven't
> discussed the legal issue with them. In addition, I think the stack
> trace is more useful, so I snipped the hardware name. Sorry about
> that...
>
> >

