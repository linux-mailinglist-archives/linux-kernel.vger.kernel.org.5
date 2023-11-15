Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9C7ED716
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 23:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjKOWOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 17:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjKOWOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 17:14:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38569192
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:14:31 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so266396a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700086468; x=1700691268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7j0UAYPIEyb2tedNA0XGfDwr790N1opj1Plxr5EQ2oo=;
        b=YvTmRIqjfGYKKFRIZVsPI+NU3niiyeboFbWz9jDBBUPXp7kTsO1FF6+ZMnrBF+UztG
         3g0WCNVhLDKULc1cSodHGdv0wcgE/kihT7WuKuLxPGH7kgSCt6BCDIK9CBDh4eV3eU+B
         /cSSQ4nCl6aZsHNSR6baJcmxVvNJ9VBZ5oMMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700086468; x=1700691268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7j0UAYPIEyb2tedNA0XGfDwr790N1opj1Plxr5EQ2oo=;
        b=ZV4ksu36UV9JuopEPT6EknKHK3oAWTb33C7Hq/fGSK9mxoYJpk8Bf3aYBRq+mQ05yF
         XI3i9+Kx3spyn3b7e7/nGXiWWXMJxS6vvZYZo7F2leR7kj0p0D0KtGTYAi6DChQbI1y/
         E1P7T3bdQKnnvYM4LEjzopLtnsvyz8UzkiZKJfCIgKiLNhxK5Hx4G0WshSGKjkXKch7i
         +rZiJABptuN+/0GdV/qGN5AsRH0UkeD7Mq2t86DPPY1ZgLol5agdsgtg+/Rz8H+iRXmo
         KAI2x1IAN7vZLTRLX3bQAN4Ft52b9sWEcArJ6uaGXZpp1PyY0FWZfYFxG89soqVBj6qk
         LX1A==
X-Gm-Message-State: AOJu0YyvtkdE14d4HhU4CM39zWd+07OeSYAm2OBtOjrInZquE5vmVa3Q
        s7bpB9ZwgkSb1u7t1tfTbm5K2wDaLYOtZCsZ6k7xHR2a
X-Google-Smtp-Source: AGHT+IEbJEoQhwv6lt1uxxayksZ9CD6sodf41/9lGOlYe3HZweuWFiE/54EAgkQOGDThmwF8KuMrSA==
X-Received: by 2002:aa7:de09:0:b0:543:5cfa:ba41 with SMTP id h9-20020aa7de09000000b005435cfaba41mr11034590edv.25.1700086468591;
        Wed, 15 Nov 2023 14:14:28 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id k21-20020aa7c395000000b0053f10da1105sm6955832edq.87.2023.11.15.14.14.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 14:14:28 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so963a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 14:14:28 -0800 (PST)
X-Received: by 2002:a05:600c:260c:b0:404:7462:1f87 with SMTP id
 h12-20020a05600c260c00b0040474621f87mr21266wma.6.1700086447481; Wed, 15 Nov
 2023 14:14:07 -0800 (PST)
MIME-Version: 1.0
References: <20231109100606.1245545-1-wenst@chromium.org> <859ac058-c50a-4eb8-99b6-3011ef4e7529@collabora.com>
 <CAL_JsqK64w3+r_LJZoh50PzAUcsvH6ahSDCqgSiKrD3LBAXE9g@mail.gmail.com>
 <CAD=FV=VUZy9DaZgKafSpXXopD5k8ExGSR97BjAqC5tupPoxNfQ@mail.gmail.com>
 <CAL_Jsq+puq20EWkQg1RTs2zfmh4DGbqz1krp+19c=wPXnLT5dA@mail.gmail.com>
 <CAD=FV=X-17COQ2-tycV1bSuCrGy7MJ88Un8nA-a-ODexvgi9TQ@mail.gmail.com> <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
In-Reply-To: <CAL_JsqKR_YD6hm4Lv+OuCKms8Ha61BZRKUuiLYPgSkz3_3NCFA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 Nov 2023 17:13:50 -0500
X-Gmail-Original-Message-ID: <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
Message-ID: <CAD=FV=XO5VNuaVKwBHLQC1ukdpHQO0-XTaKnRM=rigbcdOytgQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] of: Introduce hardware prober driver
To:     Rob Herring <robh+dt@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 15, 2023 at 4:35=E2=80=AFPM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Wed, Nov 15, 2023 at 2:45=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Wed, Nov 15, 2023 at 2:28=E2=80=AFPM Rob Herring <robh+dt@kernel.org=
> wrote:
> > >
> > > > So if we're searching the whole device tree for "failed-needs-probe=
"
> > > > then we need to figure out which devices are related to each other.=
 If
> > > > a given board has second sources for MIPI panels, touchscreens, and
> > > > trackpads then we need to know which of the "failed-needs-probe"
> > > > devices are trackpads, which are touchscreens, and which are MIPI
> > > > panels. Do you have any suggestions for how we should do that? Mayb=
e
> > > > it was in some other thread that I missed? I guess we could have a
> > > > board-specific table mapping (compatible + node name + reg) to a
> > > > class, but that feels awkward.
> > >
> > > Node name is supposed to correspond to device class, so why not use
> > > that (no path or unit-address.) and nothing else (well, besides
> > > "status")?
> >
> > One problem is that I could imagine having two second source trackpads
> > that both have the same i2c address. That would give them the same
> > name, right? I guess you could maybe come up with some sort of suffix
> > rule? Like
> >
> > trackpad-1@10 {
> >   compatible =3D "elan,blah";
> >   ret =3D <0x10>;
> >   status =3D "failed-needs-probe";
> >   ...
> > }
> > trackpad-2@10 {
> >   compatible =3D "goodix,gt7375p";
> >   ret =3D <0x10>;
> >   status =3D "failed-needs-probe";
> >   ...
> > }
> >
> > Then I guess the class would be "trackpad"?
>
> That issue is somewhat orthogonal because it is not following the spec.

I'm not sure why you say it's orthogonal. The whole reason why we get
into the situation above is that we could have two devices, only one
of which is present (hence the status of "failed-needs-probe"), that
are the same type and have the same "reg" address.

Essentially the whole "failed-needs-probe" is extending the spec,
right? While extending the spec, we also need to talk about what to do
if some of the devices that we need to probe have the same class and
the same "reg".


> I'm not sure mixing the 2 styles of node names is a good idea. While
> not used too much, matching by node name does ignore the unit-address,
> but I'm not sure we could ignore a '-N'.
>
> I think our options are either add something to the unit-address or
> use i2c-mux binding. Adding to the unit-address is not unprecedented.
> I did that for some of the register bit level bindings where you have
> a node for different bits at the same address. The downside is
> unit-address is bus specific, so we'd have to add that for multiple
> buses. For the i2c-mux, it's perhaps a bit complex and I'm not sure
> what if anything you'd have to do to manage the mux that's not really
> there.

Somehow it feels weird to use an i2c-mux because there's no real mux
present, right? ...so this would be a virtual (bogus) device that
doesn't really exist in hardware.

...though I guess if the "mux" type binding is OK then maybe we just
use that as the HW prober, at least for i2c devices...

-Doug
