Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13427FDB80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjK2Pcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjK2Pcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:32:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E6D43
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701271970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c3387qfPfXm+g0pMLYkMv/0wyAPiCJAWj1+T8eitCfc=;
        b=FMNTwDHz4cnHrbYX8GOXVzWtFHVpKTqVVpcb8JUxOEXKnv/cogLPTZguTdhmBOPyUlceEW
        EzHklf/0tRmI5g/7gqPcktF1ZT8p93Xm394pdoamcBfjAFCHKpG89yGhmmduna61Izg9t9
        oc6+QTVrv4mv4wj4FFRkZIC/O4v0pzI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-zsKqSByaMK62zCMhGDAEGA-1; Wed, 29 Nov 2023 10:32:48 -0500
X-MC-Unique: zsKqSByaMK62zCMhGDAEGA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a0dd9f85966so309974466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701271967; x=1701876767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3387qfPfXm+g0pMLYkMv/0wyAPiCJAWj1+T8eitCfc=;
        b=W28bkYApdYZZOj6VbW1d0/ZTLa176SGWqBN5eb854GcaetorUdQZv9uToRuOr+81RB
         nYpHp+Uv1q8+RgET1JB0mwqw3R/7jqCdAuSCULf6WqZn5jtJRfma/ogRyLd2byvkSkOA
         aoD2UuTVy+jXAaTWy84lqYRVA4uiFi/PJELk0S0G/Glm6gG5TcRX5rh891FPnYSEvKA9
         4YrJzV9+XjJDanTPGCtQteOx24yCbqhE4TqbukmZVJHT44q3xcOjqsMQ5fFt1fqU7uLY
         sKAhOJoImoY/eYhwk5VJ5NuzhsLqgC5hE5T4AEMhU9Vw1D2qT7rcqlGhsrQpDE6S7n42
         rgSw==
X-Gm-Message-State: AOJu0YyZLsH/i2MeaaiwABfBoVVZsbCtJMGKjU+sl0eitV1w4mYgonL+
        o23nGZHqohPyfTbLuy0d6Pm6VtaxQzrvbiw6ElPpXqQoKIonNA0vjJTru/gdFnMNDoTj0KEgxQv
        /oyMl4Wci30Y+qLZvRJCgIX29eZ0cXQfNlGk0PPC9
X-Received: by 2002:a17:906:b299:b0:a03:ad29:a00b with SMTP id q25-20020a170906b29900b00a03ad29a00bmr15845242ejz.36.1701271967180;
        Wed, 29 Nov 2023 07:32:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF//q5FXxTAp8adi5LJ+D0HPbO6HOH3cigesLXgVgkQ91LeNpz+7S1wR2LStOyHoRSOoyqdOegv0lo22ckK7bA=
X-Received: by 2002:a17:906:b299:b0:a03:ad29:a00b with SMTP id
 q25-20020a170906b29900b00a03ad29a00bmr15845221ejz.36.1701271966815; Wed, 29
 Nov 2023 07:32:46 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.2311012033290.29220@cbobk.fhfr.pm>
 <_DEF7tHL1p_ExY7GJlJvT5gRA7ZvNnVMJuURb8_WCV-0fbYXkLN2p5zHloi6wiJPNzGEjFAkq2sjbCU633_eNF_cGm0rAbmCOOIOfwe1jWo=@protonmail.com>
 <CAO-hwJ+zm=R7NwrALaLVmfPDtMNXpj0eoQgLkiS1wa6wd+hu+A@mail.gmail.com>
 <CAO-hwJKJW5jGDdaaS8eB7kcLQUvWO_1XkOzJG4HAcaRzw1cGnQ@mail.gmail.com>
 <7wmtNlKuYResf5cFQ7M2QTalzIUtw0I6ohvPcz69Jo1c8flezyIlnJu1IwAgXhJ-u0NlRL3IV7HnL0Kza6fVBqd7X7jhc-Z6QCi3oqHEvpY=@protonmail.com>
 <CAO-hwJJ+nx72_TPfxcWRPBDZdDaPrO5yMNH4Y_mj6ej651Mesw@mail.gmail.com>
 <nFHw6XePiH5p60JsbQSbssRkiuABiTiR_n5fIYFZjPgkV3ObjjZuwTC84BJ_1vXYVufPbG3UvZ1L7ODSrrGlq9CrI7BTKhsV5QeAQoakV18=@protonmail.com>
 <CAO-hwJ+jwmTE-v7FsPi3f70mB8SqUha7Ek9DtptZ0auiFpGM7w@mail.gmail.com>
 <CAO-hwJJoCp0_kxf_HHN9n9EWy9YDSY4rP8ysYNrNg2xTUYtKEQ@mail.gmail.com>
 <evHI05gyKuWwynY1WdyVvXqKPUaPE8W34cc3tFfp9FWh94TWfA9FWfHun7AAscF9lqfbiYsLKGC7kTSZ9xWNZg88-PTpbGTLcFMc9D3P2HE=@protonmail.com>
 <CAO-hwJLinACPsk=mEHrEz_YJroknmm=9PcX8byHiqEDxqOConQ@mail.gmail.com>
In-Reply-To: <CAO-hwJLinACPsk=mEHrEz_YJroknmm=9PcX8byHiqEDxqOConQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 29 Nov 2023 16:32:34 +0100
Message-ID: <CAO-hwJKnH=Brhq7Jv020qQLROarvFiewnRb__0ZF9WVqDuqxLQ@mail.gmail.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 6:18=E2=80=AFPM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi David,
>
> On Thu, Nov 23, 2023 at 11:12=E2=80=AFPM David Revoy <davidrevoy@protonma=
il.com> wrote:
> >
> > Hi Benjamin,
> >
> > Sorry for late reply.
> >
> > > So it would be nice if you could try the artifacts of job 51600738[4]=
.
> > > Again, download them (udev-hid-bpf_0.1.0-4-g5ab02ec.tar.xz), unpack,
> > > sudo ./install --verbose, then unplug/replug the artist Pro 24.
> >
> > Ok, the main change I experienced after installing is xsetwacom
> > listing the ID name of the device with twice the name Stylus on
> > "UGTABLET 24 inch PenDisplay Stylus stylus". Before it was only
> > "UGTABLET 24 inch PenDisplay stylus".
> >
> > $ xsetwacom --list
> > UGTABLET 24 inch PenDisplay Stylus stylus       id: 10  type: STYLUS
> >
> > Not a big deal, but I thought it was worth to mention it.
>
> Oh, this might be because I added a debug device. Given that there are
> 2 devices on the HID node, then one is tagged as Stylus by the kernel.
> Nothing to worry about.
>
> >
> > > Then, I'll need the following sequence (ideally repeated twice or
> > > three times, given that your last record show a slight difference in
> > > the first and second attempt):
> > >
> > > - outside of the proximity of the sensor, press the upper button
> > > - approach the stylus to the surface keeping the upper button pressed
> > > - touch the surface with the tip while holding the upper button press=
ed
> > > - release the upper button while keeping the tip pressed (like previo=
usly)
> > > - press once again the upper button while keeping the tip touching th=
e
> > > surface (like previously)
> > > - lift of the pen, keeping the upper button pressed, and still in
> > > range of the sensor
> > > - remove the pen from the proximity of the sensor entirely (move away
> > > 20 cm or so), while still keeping the upper button pressed
> > >
> > > It's actually longer to describe than to execute :)
> > >
> >
> > Thank you for the detailed steps. True, it makes sens once
> > practising it. I made the gesture three time on:
> >
> > https://www.peppercarrot.com/extras/mailing-list/hid-records/XPPEN-Arti=
st-24-Pro/2023-11-23_XPPEN-Artist-24-Pro_pen_tip-contact-and-press-release-=
upper-stylus-button-while-pressed-x3.txt
>
> Thanks a lot. And of course this device doesn't react in the way I expect=
ed :)
>
> Transitions from/to the tip touching the surface while the second
> button is pressed are normal, there are no extra events...
>
> But this also showed that the previous filter was better when pressing
> the upper button while touching the tip on the surface, because now we
> get another spurious event that was filtered before (and because it
> was filtered, I thought it was not there).
>
> Anyway, I couldn't rewrite the filter today, but I'll work on it next
> week for sure.


I've updated the HID-BPF filter, and you can find it in the latest pipeline=
[0].
I've removed the extra "Stylus" and you should have a better
experience with the upper button now.


>
>
> >
> > > But I would also totally understand that you had enough debugging and
> > > you would rather focus on using the tablets, instead of debugging
> > > them. In which case, someone else from the community might help me.
> >
> > No problem for continue testing, I'm around! Thank you again
> > for improving the behavior of the tablets.
> >

I think we are done with the XP-Pen Pro 24. But now I wonder if the
Pro 16 (gen2) doesn't also have those glitches.

Could you send me the same debug sequence as the last time
(transitions from/to touching the surface while holding the upper
button) but on the 16 now?

There is a chance I'll need the same filter to remove the extra left
click that might appear when you press the upper button while touching
the surface.

Cheers,
Benjamin


[0] https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/jobs/52148274

