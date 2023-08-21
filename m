Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986CB78288F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjHUMHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjHUMHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA7390
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692619594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QSAAa/hMYp89U1EDlmo0karZdp2ZmKwZOL2+v/7j1U=;
        b=GqSZLxDphmxTqAC0zBOCAbGgbDya+xeGz/Sef6lIo2LODbjJCtLgsuL+kPMuMIsDSWdFo/
        egZfSJyPwPcNSkyyTqEIJtf+HFZabYYj9RGjd9ux9xc2rvAmdNZgjvqUC7P5wJrFBD/YeD
        9ByP+DIGNSKY9o2JYiChCk7f67FfDWg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-YYDCick5MoOzbJ5JsUr1PA-1; Mon, 21 Aug 2023 08:06:32 -0400
X-MC-Unique: YYDCick5MoOzbJ5JsUr1PA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31ad77537ebso1941214f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692619591; x=1693224391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QSAAa/hMYp89U1EDlmo0karZdp2ZmKwZOL2+v/7j1U=;
        b=fl74RYtkg7lzM8Xh3xHEAQeagEp4DwMUDh/555XpDW7ecvZS0LUnNYCm6cdzLVayDw
         HUL94ALMTcV2am1Fg4joQecMqhNunS3cz5ikQTgCE927781pAUyEGKNh5X5uaArN7f3N
         nHr25KXjmyL6hBAAqCw8joZXWOpPIg1d5sEdcb7+86XDYxfanJrphRs0earu0Y9b7r/P
         4Y0q0AMSWNHY7gEh9oBPLhG1YROuGTFQH5KcTzhuiN3CWPu9AGQ/drZJcic5qdu6URcW
         zMV2cnuxtn1kOLu5bo7mMaH3ptfPW8TlKsQxJ6scJxuuYzLUasqUWDObmdZyKS3IAPfm
         Tifw==
X-Gm-Message-State: AOJu0YxJ8hx8Dot6UGInzc+MA4ZcwMJXOgbw8CGTBAT+OibuMe8bwytX
        OXkuGhhG0Qcv2xyHtI9pw0OSsKcZkhjybeOaoeeWCOyKu7uQju1cd034K7qF1sPmZhCrUeG74oh
        8rZKLDkH9DUFqd//Hq8Tir4+1itXPpKKKIPr4BMWp
X-Received: by 2002:adf:ef91:0:b0:317:cff4:7357 with SMTP id d17-20020adfef91000000b00317cff47357mr4737664wro.20.1692619591807;
        Mon, 21 Aug 2023 05:06:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH58LLzlTU5gEdiu40AT9vFc4WW8xCtVM1yBFGzym0AW6o47Dvx/FCXoPkJ3vQs3bw9CWtv8MWi9osUZgsbZPg=
X-Received: by 2002:adf:ef91:0:b0:317:cff4:7357 with SMTP id
 d17-20020adfef91000000b00317cff47357mr4737647wro.20.1692619591515; Mon, 21
 Aug 2023 05:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <ZMK60UphgVuj4Z+L@smile.fi.intel.com> <ZMydcGv8Dvu3Hje1@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308071319140.14207@cbobk.fhfr.pm> <ZND/8wd67YbGs8d5@smile.fi.intel.com>
 <nycvar.YFH.7.76.2308141128260.14207@cbobk.fhfr.pm> <ZOMcHQc8Em/s6C+y@smile.fi.intel.com>
 <ez2oewpi3yeaiejrvbe433ude75pgm3k3s5sh5gnn7pvnzm7b4@ajuopfgwocft>
 <ZOMvpmoWLCgcAyJR@smile.fi.intel.com> <ZOMv4VB0bZpupNlN@smile.fi.intel.com>
 <CAO-hwJ+Pa0yMV5taEc9+RXEWJzkotpyj4gz2qftyLV4G73F-mg@mail.gmail.com> <ZOM9SLLuWJzeHTiO@smile.fi.intel.com>
In-Reply-To: <ZOM9SLLuWJzeHTiO@smile.fi.intel.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 21 Aug 2023 14:06:20 +0200
Message-ID: <CAO-hwJJdztp_HCitHsp2CnK9N72oeHo-UiSm1Uz1_oZghuGLwQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Benjamin Tissoires <bentiss@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:32=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 21, 2023 at 12:19:39PM +0200, Benjamin Tissoires wrote:
> > On Mon, Aug 21, 2023 at 11:35=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Mon, Aug 21, 2023 at 12:34:30PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 21, 2023 at 10:51:04AM +0200, Benjamin Tissoires wrote:
> > > > > On Aug 21 2023, Andy Shevchenko wrote:
>
> ...
>
> > > > > Long story short, I'm not able to test it right now (and I got qu=
ite
> > > > > some backlog as you can imagine). IIRC the code was fine, so I th=
ink we
> > > > > can just take the series as is, and work on the quirks (if any) l=
ater.
> > > >
> > > > Thank you!
> > > >
> > > > The thing that might be broken is interrupts handling. If that work=
s,
> > > > I'm pretty confident with the rest.
> > >
> > > I.o.w. first 5 patches to test is already 98% of guarantee that every=
thing
> > > is fine.
> >
> > Actually I applied you series locally, and applied Danny's patches on
> > top, and I could run your series in qemu with the cp2112 as USB
> > passthrough.
> >
> > Everything is working fine, so I can take this one just now.
>
> Thank you! I assume you have some IRQ (like GPIO button) to test with tha=
t.

Yeah, binding a test i2c-hid touchpad on top of hid forces you to use
GPIOs. Otherwise you are polling, and it's not allowed in i2c-hid
anymore IIRC :)

> If no, it's easily to describe (in ACPI, see [1]) and use a wire to emula=
te
> the button presses. In that case the /proc/interrupts should show the
> different numbers.

Thanks, but again, the GPIO is tested just by checking if the touchpad
can send events when touched.

Now I need to update my CI to rely on danny's patches and a DSDT overwrite =
:)

Cheers,
Benjamin

>
> [1]: https://github.com/westeri/meta-acpi/blob/master/recipes-bsp/acpi-ta=
bles/samples/edison/buttons.asli
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

