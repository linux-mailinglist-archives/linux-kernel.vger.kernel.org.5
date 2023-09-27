Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E977B0853
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjI0PfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjI0PfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:35:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC06126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:35:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50437f39c9dso16109214e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695828909; x=1696433709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVgwDObXb6UAmjjtbbeBb3r9BHG4gpzxjTumkUEWtbQ=;
        b=HZ6YhnBtXl2N3Q/NWoM0gZPTRclyABy512enPRFQLbcN9VSdlGhpnG/JWCBxepdIxl
         kthVL2Obo5n16XDwTI6KyWLbUiHHm6nnCnZjRy+HLUiXt9EDde6c/UgrcCOWeIPXFOeg
         nYSqN5uoUPUTtfTepPFi+NSsDiy8wE48CdOvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695828909; x=1696433709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVgwDObXb6UAmjjtbbeBb3r9BHG4gpzxjTumkUEWtbQ=;
        b=JQSKTuitjHkYTwTJT0IopKZL8Ri57ADHBjoPRL8seZ4tH3rKjvwk0iSD6Zt4pINJym
         W/3uqj6pgnxyVclf2wuG1mpekIQOoIKxevZUes7CMtpA8cx2Jnoe9WWN6YxXWk6zHjK2
         B3jLchK6wzYe8XRJ317/HQjMha8WsylQF8qV6OFmSLUxQSHaWRTsHdAUmskfDNO9dkfn
         7v+zSAkE4tGMVIezfOncJ8hiIJbQ7x1EQ5camQAk3v16E7Wf5uF53y35xoyfnsvj6KvN
         km0J37ZSaONIJl12mGj4bQKgpr+NbN2PWmWHvY6gU5s9eO3CKfMtIlByXMzcdpyNBFrh
         vFWA==
X-Gm-Message-State: AOJu0YzCBiwy8DSPzovj2s0Ep+VEItOr25WgdZvrAUxfAxqfppXVbzEl
        TPuP5txpYDUcYW8jLN96pZmPSPZ2Q3njKiy5ra8YeKN1
X-Google-Smtp-Source: AGHT+IEYgKz+lcerFDxrlMJbYwUK/Bpq3NBzNpdUHveYePTponQTfoIad507u+bRbAvScIwuYt/kKQ==
X-Received: by 2002:a19:5f16:0:b0:500:adbd:43e7 with SMTP id t22-20020a195f16000000b00500adbd43e7mr1696349lfb.8.1695828908817;
        Wed, 27 Sep 2023 08:35:08 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c609000000b00532c1dfe8ecsm8210295edq.66.2023.09.27.08.35.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 08:35:08 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-405459d9a96so122245e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:35:08 -0700 (PDT)
X-Received: by 2002:a50:d61c:0:b0:51e:16c5:2004 with SMTP id
 x28-20020a50d61c000000b0051e16c52004mr288987edi.6.1695828533058; Wed, 27 Sep
 2023 08:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230926212824.1512665-1-dianders@chromium.org>
 <20230926142724.2.I65ea4ac938a55877dc99fdf5b3883ad92d8abce2@changeid> <62fec09e-c881-498e-9ac0-d0a6de665f16@rowland.harvard.edu>
In-Reply-To: <62fec09e-c881-498e-9ac0-d0a6de665f16@rowland.harvard.edu>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 27 Sep 2023 08:28:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V4R9TAGH+cCG=YBgCFO5F9hniPV-ycZjk5=z5mSjFQ7A@mail.gmail.com>
Message-ID: <CAD=FV=V4R9TAGH+cCG=YBgCFO5F9hniPV-ycZjk5=z5mSjFQ7A@mail.gmail.com>
Subject: Re: [PATCH 2/3] r8152: Retry register reads/writes
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-usb@vger.kernel.org, Grant Grundler <grundler@chromium.org>,
        Edward Hill <ecgh@chromium.org>, andre.przywara@arm.com,
        bjorn@mork.no, edumazet@google.com, gaul@gaul.org,
        horms@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 27, 2023 at 6:43=E2=80=AFAM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Tue, Sep 26, 2023 at 02:27:27PM -0700, Douglas Anderson wrote:
> > +
> > +static
> > +int r8152_control_msg(struct usb_device *udev, unsigned int pipe, __u8=
 request,
> > +                   __u8 requesttype, __u16 value, __u16 index, void *d=
ata,
> > +                   __u16 size, const char *msg_tag)
> > +{
> > +     int i;
> > +     int ret;
> > +
> > +     for (i =3D 0; i < REGISTER_ACCESS_TRIES; i++) {
> > +             ret =3D usb_control_msg(udev, pipe, request, requesttype,
> > +                                   value, index, data, size,
> > +                                   USB_CTRL_GET_TIMEOUT);
> > +
> > +             /* No need to retry or spam errors if the USB device got
> > +              * unplugged; just return immediately.
> > +              */
> > +             if (udev->state =3D=3D USB_STATE_NOTATTACHED)
> > +                     return ret;
>
> Rather than testing udev->state, it would be better to check whether
> ret =3D=3D -ENODEV.  udev->state is meant primarily for use by the USB co=
re
> and it's subject to races.

Thanks for looking my patch over!

Happy to change this to -ENODEV. In my early drafts of this patch I
looked at -ENODEV but I noticed that other places in the driver were
checking `udev->state =3D=3D USB_STATE_NOTATTACHED` so I changed it. In
reality I think for this code path it doesn't matter a whole lot. The
only thing it's doing is avoiding a few extra retries and avoiding a
log message. :-)

I'll wait a few more days to see if there is any other feedback on
this series and then send a new version with that addressed. If
someone needs me to send a new version sooner then please yell.

-Doug
