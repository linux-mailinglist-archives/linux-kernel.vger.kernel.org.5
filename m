Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533117B55A3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbjJBOfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjJBOfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:35:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F21A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:35:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4066241289bso26159285e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696257325; x=1696862125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsnuXrfTi/qDbbUf8n0tkWbx3RkfSxQRuLTOsgFTPoI=;
        b=DpJEVOWrSZ0uwXCbkjvr6FY7qO1jWXRa8dro5Of3jppcfGZHFnuVQFW3M7Lt5rnJS1
         x+fMnWNMi/1SMzGhMBtIVp64OPo1ZzglKF6+GCMNmaLpG3Fg569GnijglCQG0sxSkOnA
         h9M/fRCSxigGpO0dz/gxcUHI9o3Wb6t0tGId8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257325; x=1696862125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsnuXrfTi/qDbbUf8n0tkWbx3RkfSxQRuLTOsgFTPoI=;
        b=UT3VjQ4BRD+9CYM68UAvP8FQ0zZFVQsh8qAHDdWwqHb1/cZYApWEZzpUNfrrqMMPn9
         cyeYH2ByhkPOZUd1ii5ywC2z6AO+IYTgE7DKENNOUyjyazHXMq970aZJpluP1UQQkVg5
         gQL95RAajBEDeP4T3mJy9ga5UTeg7yZ2utenEpXrpwxDqrdr2ulR7pO8+WgrURNIcd+u
         rtMU4VqF/aQKP3abZHssnkCZmaFnU3jXk6IZPE6ZiiLqMq1x3ZG/cvJEpDb4NAsnEM31
         YxEoUd42gRPvfKXAAM1sIwYfH6vnaELCk36lHaLmEiwGfPVnoNzi6sQMWQn6agtlMrsO
         Zckw==
X-Gm-Message-State: AOJu0Yw298K2XWQ+8NRSV7IyLWrNX0tEGbdJeUxc2du0oqnGL5SAsdEA
        J2VR0oY0slGHcc9RgPwlMs5AJ0VF90NCyVisrDzy0A==
X-Google-Smtp-Source: AGHT+IF8/CP9pNM3WlkDLhQ7HxHYG0vc+UobFim6oUD5Pxrd7F/uNf3Ep8hHcw0f6ByWP95VfivBwA==
X-Received: by 2002:a5d:4cc3:0:b0:31f:ef77:67e4 with SMTP id c3-20020a5d4cc3000000b0031fef7767e4mr9549407wrt.37.1696257324760;
        Mon, 02 Oct 2023 07:35:24 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id cq7-20020a056402220700b00536159c6c45sm7117057edb.15.2023.10.02.07.35.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 07:35:23 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so118395e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:35:23 -0700 (PDT)
X-Received: by 2002:a05:600c:310c:b0:3fe:e9ea:9653 with SMTP id
 g12-20020a05600c310c00b003fee9ea9653mr123912wmo.4.1696257323564; Mon, 02 Oct
 2023 07:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230918125851.310-1-johan+linaro@kernel.org> <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
 <ZQlIveJVdvyV2Ygy@hovoldconsulting.com> <CAD=FV=XBG7auVVyHn5uvahSZZxp5qBfp4+A9NwFqahdN6XrbZA@mail.gmail.com>
 <ZQqemN8P2VKgxhsV@hovoldconsulting.com> <CAD=FV=XK87TZuPy+d2r2g5QhowmghE-m9pGHe9-X7jnXAw9z1g@mail.gmail.com>
 <ZQ1Zm6ec9NuBvqpl@hovoldconsulting.com> <CAD=FV=USBJRzqxX9kBP8pp4LKRGpBee+jkHL=KmeQvyfBk2CVQ@mail.gmail.com>
 <ZRqzGA1F6JV-mlRL@hovoldconsulting.com>
In-Reply-To: <ZRqzGA1F6JV-mlRL@hovoldconsulting.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 2 Oct 2023 07:35:06 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UHEeu3crTFEZDY+LDQZk07H8un7gCSs0jyCQJrGYkV=Q@mail.gmail.com>
Message-ID: <CAD=FV=UHEeu3crTFEZDY+LDQZk07H8un7gCSs0jyCQJrGYkV=Q@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid: fix handling of unpopulated devices
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        LinusW <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 2, 2023 at 5:09=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> > > > > I skimmed the thread were you added this, but I'm not sure I saw =
any
> > > > > reason for why powering on the panel follower temporarily during =
probe
> > > > > would not work?
> > > >
> > > > My first instinct says we can't do this, but let's think about it..=
.
> > > >
> > > > In general the "panel follower" API is designed to give all the
> > > > decision making about when to power things on and off to the panel
> > > > driver, which is controlled by DRM.
> > > >
> > > > The reason for this is from experience I had when dealing with the
> > > > Samsung ATNA33XC20 panel that's on "sc7180-trogdor-homestar". The T=
CON
> > > > on that panel tended to die if you didn't sequence it just right.
> > > > Specifically, if you were sending pixels to the panel and then stop=
ped
> > > > then you absolutely needed to power the panel off and on again. Fol=
ks
> > > > I talked to even claimed that the panel was working "to spec" since=
,
> > > > in the "Power Sequencing" section of the eDP spec it clearly shows
> > > > that you _must_ turn the panel off and on again after you stop givi=
ng
> > > > it bits. ...this is despite the fact that no other panel I've worke=
d
> > > > with cares. ;-)
> > > >
> > > > On homestar, since we didn't have the "panel follower" API, we ende=
d
> > > > up adding cost to the hardware and putting the panel and touchscree=
ns
> > > > on different power rails. However, I wanted to make sure that if we
> > > > ran into a similar situation in the future (or maybe if we were try=
ing
> > > > to make hardware work that we didn't have control over) that we cou=
ld
> > > > solve it.
>
> Out of curiosity, are there any machines that actually need this
> "panel-follower" API today, or are saying above that this is just
> something that may be needed one day?

Yes. See commit de0874165b83 ("drm/panel: Add a way for other devices
to follow panel state") where I point to Cong Yang's original patch
[1]. In that patch Cong was trying to make things work by assuming
probe ordering and manually taking some of the power sequencing stuff
out of some of the drivers in order to get things to work.

[1] https://lore.kernel.org/r/20230519032316.3464732-1-yangcong5@huaqin.cor=
p-partner.google.com



> > > > The other reason for giving full control to the panel driver is jus=
t
> > > > how userspace usually works. Right now userspace tends to power off
> > > > panels if they're not used (like if a lid is closed on a laptop) bu=
t
> > > > doesn't necessarily power off the touchscreen. Thus if the touchscr=
een
> > > > has the ability to keep things powered on then we'd never get to a =
low
> > > > power state.
> > >
> > > Don't you need to keep the touchscreen powered to support wakeup even=
ts
> > > (e.g. when not closing the lid)?
> >
> > No. The only reason you'd use panel follower is if the hardware was
> > designed such that the touchscreen needed to be power sequenced with
> > the panel. If the touchscreen can stay powered when the panel is off
> > then it is, by definition, not a panel follower.
> >
> > For a laptop I don't think most people expect the touchscreen to stay
> > powered when the screen is off. I certainly wouldn't expect it. If the
> > screen was off and I wanted to interact with the device, I would hit a
> > key on the keyboard or touch the trackpad. When the people designing
> > sc7180-trogdor chose to have the display and touchscreen share a power
> > rail they made a conscious choice that they didn't need the
> > touchscreen active when the screen was off.
>
> Sure, but that's a policy decision and not something that should be
> hard-coded in our drivers.

If the touchscreen and panel can be powered separately then, sure,
it's a policy decision.

In the cases where the touchscreen and panel need to be powered
together I'd say it's more than a policy decision. Even if it wasn't,
you have to make _some_ decision in the kernel. One could also argue
that if you say that you're going to force the panel to be powered on
whenever the touchscreen is on then that's just as much of a policy
decision, isn't it?

In any case, the fact that there is a shared power rail / shared power
sequence is because the hardware designer intended them to either be
both off or both on. Whenever I asked the EEs that designed these
boards about leaving the touchscreen on while turning the panel power
off they always looked at me incredulously and asked why I would ever
do that. Although we can work around the hardware by powering the
panel in order to allow the touchscreen to be on, it's just not the
intention.


> > > But the main reason is still that requesting resources belongs in
> > > probe() and should not be deferred to some later random time where yo=
u
> > > cannot inform driver core of failures (e.g. for probe deferral if the
> > > interrupt controller is not yet available).
> >
> > OK, I guess the -EPROBE_DEFER is technically possible though probably
> > not likely in practice. ...so that's a good reason to make sure we
> > request the IRQ in probe even in the "panel follower" case. I still
> > beleive Benjamin would prefer that this was abstracted out and not in
> > the actual probe() routine, but I guess we can wait to hear from him.
>
> I talked to Benjamin at Kernel Recipes last week and I don't think he
> has any fundamental objections to the fix I'm proposing.

Sure. I don't either though I'm hoping that we can come up with a more
complete solution long term.


> I prefer it as it makes the code easier to reason about and clearly
> marks the code paths that differ in case the device is a "panel
> follower". And since you said it also makes the code look more like what
> you originally intended, then I guess you should be ok with it too?

It looks OK to me. The biggest objection I have is just that I dislike
it when code churns because two people disagree what the nicer style
is. It just makes for bigger diffs and more work to review things.


> > One last idea I had while digging would be to wonder if we could
> > somehow solve this case with "IRQF_PROBE_SHARED". I guess that doesn't
> > work well together with "IRQF_NO_AUTOEN", but conceivably we could
> > have the interrupt handler return "IRQ_NONE" if the initial power up
> > never happened? I haven't spent much time poking with shared
> > interrupts though, so I don't know if there are other side effects...
>
> Yeah, that doesn't seem right, though. The interrupt line is not really
> shared, it's just that we need to check whether the device is populated
> before requesting the interrupt.

I'm not convinced that marking it as shared is any "less right" than
extra work to request the interrupt after we've probed the device.
Fundamentally both are taking into account that another touchscreen
might be trying to probe with the same interrupt line.

-Doug
