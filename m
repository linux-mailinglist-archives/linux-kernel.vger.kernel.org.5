Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D56756741
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjGQPNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGQPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A0110E0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689606746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Z1R60E2ZDa1sZtOt0a5TFflX73Adcu3YIcOrKAojsE=;
        b=hSx9Su2fh/GvYHkATFRGKqppEF6sFwOVULJP/nfFudEzPV2wonYM0kIK6m/YtG32dknbXd
        /yAfAaTxnkQNMqBzh3zzL6vuZlY0Vq4FT5SRiuYkS1/US9FjzhkNkhW82p1hV0CU6ea6qM
        oZJhZchyRTNLnq0fgef+5naMjMbjSTg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-soopOn3zPy6Ovv2W4tZ76A-1; Mon, 17 Jul 2023 11:12:25 -0400
X-MC-Unique: soopOn3zPy6Ovv2W4tZ76A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-98e1085308eso663018066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606744; x=1692198744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Z1R60E2ZDa1sZtOt0a5TFflX73Adcu3YIcOrKAojsE=;
        b=ex5X5GRvnOGj6iVbJ6VYsUk0Ek2IkiPVGKMv1ddzlV2zSE1fM3RiYclBv8I4ayGT6R
         lyZHAfv+cPR+bfMdRnC6WuqYVIbid1HC8WgDXij6uP0EUrodWZccX6Q7PunzUjBClJ9b
         rLEYh0MhGG+0LH/lcLv/z5HBP/eP4qdaISO96az+QOwCymDNmoFTOtpyKQK/zmtA4IDQ
         l9BL78qTAsqkp5YXN9GR8vUFvXbjVWy9xclXx/zE7mvmMt4xz1q/DQ2vjrm3pW0hZbHy
         VurOUFa7m3anca3nw0IYJq3E29akApQl0KKgZk0k/6gWAPYGUFEfj7znryBmpqRfJOo/
         Gh3Q==
X-Gm-Message-State: ABy/qLaSPmxxyGaQw6Yt5I4kMXg41qNI4oi1N6z1jGOMkqo1DLUB5iWv
        Gem1qCUV2r7DmfBlkF0l1eeV7+8W8IliiJJhWf0Cw3KerZzJrCpOgrhYB2lpjFcV4+wHkDxoU2N
        qReAp2pjrhAk/+BlBsAnhBVyAXn7SO1ycdRZwKLDy
X-Received: by 2002:a05:6402:42cc:b0:51f:e0f0:f2cd with SMTP id i12-20020a05640242cc00b0051fe0f0f2cdmr11664865edc.3.1689606744291;
        Mon, 17 Jul 2023 08:12:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGMNX9yof2GWE8oz7jVoRRWAHmk/1Oqwuutxcg20comIaY6zdK6uBSjv18bFjD3A2v1Cwtu2PrDMhARChVQIo0=
X-Received: by 2002:a05:6402:42cc:b0:51f:e0f0:f2cd with SMTP id
 i12-20020a05640242cc00b0051fe0f0f2cdmr11664844edc.3.1689606744027; Mon, 17
 Jul 2023 08:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230713100459.GEZK/MS69XbphJa+tN@fat_crate.local>
 <CAO7dBbVMNKTSDi5eP4BseEUexsk0Mo0GWJpyHfOcp+tHs6cSUw@mail.gmail.com> <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
In-Reply-To: <CAMj1kXGEFr+E3pKLrJJq=FXv9ZhDg0zSEw7sewumPZkwtd3P5Q@mail.gmail.com>
From:   Tao Liu <ltao@redhat.com>
Date:   Mon, 17 Jul 2023 23:11:48 +0800
Message-ID: <CAO7dBbXhF36vCgVMOM2H83H34OqsA6J3KmsBMvYcs_p9_5pa4Q@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:57=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Mon, 17 Jul 2023 at 15:53, Tao Liu <ltao@redhat.com> wrote:
> >
> > Hi Borislav,
> >
> > On Thu, Jul 13, 2023 at 6:05=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > > >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++=
----
> > > >  1 file changed, 31 insertions(+), 4 deletions(-)
> > >
> > > Ok, pls try this totally untested thing.
> > >
> > > Thx.
> > >
> > > ---
> > > diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compresse=
d/sev.c
> > > index 09dc8c187b3c..fefe27b2af85 100644
> > > --- a/arch/x86/boot/compressed/sev.c
> > > +++ b/arch/x86/boot/compressed/sev.c
> > > @@ -404,13 +404,20 @@ void sev_enable(struct boot_params *bp)
> > >         if (bp)
> > >                 bp->cc_blob_address =3D 0;
> > >
> > > +       /* Check for the SME/SEV support leaf */
> > > +       eax =3D 0x80000000;
> > > +       ecx =3D 0;
> > > +       native_cpuid(&eax, &ebx, &ecx, &edx);
> > > +       if (eax < 0x8000001f)
> > > +               return;
> > > +
> > >         /*
> > >          * Setup/preliminary detection of SNP. This will be sanity-ch=
ecked
> > >          * against CPUID/MSR values later.
> > >          */
> > >         snp =3D snp_init(bp);
> > >
> > > -       /* Check for the SME/SEV support leaf */
> > > +       /* Recheck the SME/SEV support leaf */
> > >         eax =3D 0x80000000;
> > >         ecx =3D 0;
> > >         native_cpuid(&eax, &ebx, &ecx, &edx);
> > >
> > Thanks a lot for the patch above! Sorry for the late response. I have
> > compiled and tested it locally against 6.5.0-rc1, though it can pass
> > the early stage of kexec kernel bootup,
>
> OK, so that proves that the cc_blob table access is the culprit here.
> That still means that kexec on SEV is likely to explode in the exact
> same way should anyone attempt that.
>
>
> > however the kernel will panic
> > occasionally later. The test machine is the one with Intel Atom
> > x6425RE cpu which encountered the page fault issue of missing efi
> > config table.
> >
>
> Agree with Boris that this seems entirely unrelated.

Agree, I will have a retest based on Boris's suggestions.

>
> > ...snip...
> > [   21.360763]  nvme0n1: p1 p2 p3
> > [   21.364207] igc 0000:03:00.0: PTM enabled, 4ns granularity
> > [   21.421097] pps pps1: new PPS source ptp1
> > [   21.425396] igc 0000:03:00.0 (unnamed net_device) (uninitialized): P=
HC added
> > [   21.457005] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
> > (5.0 GT/s PCIe x1 link)
> > [   21.465210] igc 0000:03:00.0 eth1: MAC: ...snip...
> > [   21.473424] igc 0000:03:00.0 enp3s0: renamed from eth1
> > [   21.479446] BUG: kernel NULL pointer dereference, address: 000000000=
0000008
> > [   21.486405] #PF: supervisor read access in kernel mode
> > [   21.491519] mmc1: Failed to initialize a non-removable card
> > [   21.491538] #PF: error_code(0x0000) - not-present page
> > [   21.502229] PGD 0 P4D 0
> > [   21.504773] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [   21.509133] CPU: 3 PID: 402 Comm: systemd-udevd Not tainted 6.5.0-rc=
1+ #1
> > [   21.515905] Hardware name: ...snip...
>
>
> Why are you snipping the hardware name?

Sorry for the inconvenience here... The machine is borrowed from our
partner, which may not be officially released to the market. I haven't
discussed the legal issue with them. In addition, I think the stack
trace is more useful, so I snipped the hardware name. Sorry about
that...

>

