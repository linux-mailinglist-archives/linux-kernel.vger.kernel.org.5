Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19407F7A44
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 18:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbjKXRSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 12:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjKXRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 12:18:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E326C19A7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700846326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SHbzOtA4hzteJQDcB8FFU+7O7arSeNmceXHgvsMd7BI=;
        b=Ke/XXKsVPFtRk4uQ0/S1CQW+hTNLUS59AUhtXXo7PDkfo55ygQiQ1gea8p7/82wmapeNMS
        yrsM0k6qrFFCUI1pokY+oQW5U+2E4ztN4diFpqjtg2hbjmrmxGiw2zxCzGWTGzzsLcfXxR
        xqR2sMDDA2ljGoyYKeX8OivEDnLDLyY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-33Dps7vVN92s7NQHVM8l1A-1; Fri, 24 Nov 2023 12:18:45 -0500
X-MC-Unique: 33Dps7vVN92s7NQHVM8l1A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a02cc56af16so145787466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:18:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700846324; x=1701451124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHbzOtA4hzteJQDcB8FFU+7O7arSeNmceXHgvsMd7BI=;
        b=mDnRLOQSgqu8r/fo9iMoffupUKJy36/qP2BLn2ktZaUYakFcMOBMfnai+IS46SZ7OJ
         KDZWLVjgaf1uoOYx0pGBWxfUjUKEE2pqGQa3YN9fKJTXMbEuUA4ppGnnxzx3R1aPa7lN
         86ZDR+BSO5F6zbmz63UV056NcfDbblFOWrA6X2m+wih7MNtFVmHSFsX68TGrWu5jbxKG
         l1jpVFVs+DQTiiXQTJeAxhsdISsHAjOvIj+pOOMYvo3vZi9ueMTAj1tOWzkWi3stz1XP
         SlLgaa4bRZehsGEGSUHBVWAQa5dMIvjvUchDHT0m85qw5cc9ruw9MOPE8l+cxfYVpVMF
         Bp+A==
X-Gm-Message-State: AOJu0Yxk8FZLYXSQ7tuxJ/dQUnU6KRsRYWHHFFfpN1FyKfxrxsA8KLy1
        oaDgndHVwAWCnY1w7zVr056Fir90j8mtjIQVhUJGFMqOiksb1c1dXgCjtbQQiKRmrsutltdpWGc
        S0uf7VKb4gypKUMUSxFEOSM/2V5wSU0WX/ZB3WAo3
X-Received: by 2002:a17:907:b00a:b0:9fe:5afc:bd3e with SMTP id fu10-20020a170907b00a00b009fe5afcbd3emr2306083ejc.22.1700846324376;
        Fri, 24 Nov 2023 09:18:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0BQ9ZSpmBE+CVwJFWzPye++8Z1ZHU4yOXjYYGEwtuxkE958vjctmeNuZA99dXe4VUxWBl2CoTRLdtdTAS6Lc=
X-Received: by 2002:a17:907:b00a:b0:9fe:5afc:bd3e with SMTP id
 fu10-20020a170907b00a00b009fe5afcbd3emr2306074ejc.22.1700846324107; Fri, 24
 Nov 2023 09:18:44 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
 <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
 <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
 <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
 <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
 <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
 <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com>
 <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com> <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com>
In-Reply-To: <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 24 Nov 2023 18:18:31 +0100
Message-ID: <CAO-hwJLinACPsk=mEHrEz_YJroknmm=9PcX8byHiqEDxqOConQ@mail.gmail.com>
Subject: Re: Requesting your attention and expertise regarding a Tablet/Kernel issue
To:     David Revoy <davidrevoy@protonmail.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Eric GOUYER <folays@gmail.com>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        jkosina@suse.cz, jason.gerecke@wacom.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Thu, Nov 23, 2023 at 11:12=E2=80=AFPM David Revoy <davidrevoy@protonmail=
.com> wrote:
>
> Hi Benjamin,
>
> Sorry for late reply.
>
> > So it would be nice if you could try the artifacts of job 51600738[4].
> > Again, download them (udev-hid-bpf_0.1.0-4-g5ab02ec.tar.xz), unpack,
> > sudo ./install --verbose, then unplug/replug the artist Pro 24.
>
> Ok, the main change I experienced after installing is xsetwacom
> listing the ID name of the device with twice the name Stylus on
> "UGTABLET 24 inch PenDisplay Stylus stylus". Before it was only
> "UGTABLET 24 inch PenDisplay stylus".
>
> $ xsetwacom --list
> UGTABLET 24 inch PenDisplay Stylus stylus       id: 10  type: STYLUS
>
> Not a big deal, but I thought it was worth to mention it.

Oh, this might be because I added a debug device. Given that there are
2 devices on the HID node, then one is tagged as Stylus by the kernel.
Nothing to worry about.

>
> > Then, I'll need the following sequence (ideally repeated twice or
> > three times, given that your last record show a slight difference in
> > the first and second attempt):
> >
> > - outside of the proximity of the sensor, press the upper button
> > - approach the stylus to the surface keeping the upper button pressed
> > - touch the surface with the tip while holding the upper button pressed
> > - release the upper button while keeping the tip pressed (like previous=
ly)
> > - press once again the upper button while keeping the tip touching the
> > surface (like previously)
> > - lift of the pen, keeping the upper button pressed, and still in
> > range of the sensor
> > - remove the pen from the proximity of the sensor entirely (move away
> > 20 cm or so), while still keeping the upper button pressed
> >
> > It's actually longer to describe than to execute :)
> >
>
> Thank you for the detailed steps. True, it makes sens once
> practising it. I made the gesture three time on:
>
> https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Artist=
-24-Pro/2023-11-23_XPPEN-Artist-24-Pro_pen_tip-contact-and-press-release-up=
per-stylus-button-while-pressed-x3.txt

Thanks a lot. And of course this device doesn't react in the way I expected=
 :)

Transitions from/to the tip touching the surface while the second
button is pressed are normal, there are no extra events...

But this also showed that the previous filter was better when pressing
the upper button while touching the tip on the surface, because now we
get another spurious event that was filtered before (and because it
was filtered, I thought it was not there).

Anyway, I couldn't rewrite the filter today, but I'll work on it next
week for sure.

>
> > But I would also totally understand that you had enough debugging and
> > you would rather focus on using the tablets, instead of debugging
> > them. In which case, someone else from the community might help me.
>
> No problem for continue testing, I'm around! Thank you again
> for improving the behavior of the tablets.
>

great!

Cheers,
Benjamin


> Cheers,
> David
>

