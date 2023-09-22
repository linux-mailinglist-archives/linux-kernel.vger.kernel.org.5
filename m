Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12237AB9DA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjIVTIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjIVTI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:08:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA73AF;
        Fri, 22 Sep 2023 12:08:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58817C433CA;
        Fri, 22 Sep 2023 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695409702;
        bh=gXlMQDEZcoZ7YEdGgWtE3RZREDwAT02Now/rm1ivZ38=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yn51I8olnoubAb0raQHBCIT/zuvl9y8bpUwUhW4/RuV1vBKOEJIHZExnNP74ixNNq
         5EMJNRRHOPZ9XNf4YH8gu7TPlZ6gRMATOpnrQrrQTTAcNlMVGU2VYGikwcO96OMKw/
         SwVHFIUtHDdgastpbwVyr0G0oKbcDgrRqW/Jep9PVc229s31lwYPV+FZEIrAqrW/xQ
         Wa7kmcEcWrQw2JYhOdVCP32VbZfQJkzERteI+UAjEboN9+9pq7xfA8c0fDzgd7kMtx
         u0aC5tt+HCeWDIs1QMlzZ2UDhqjXWmgoyJmYYjPfn722bKAp/Hc5bpFf7mbPdOajXb
         7gVLhp5zWmvmg==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5042f391153so3273150e87.1;
        Fri, 22 Sep 2023 12:08:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxNayVulqzNmFinVTXyOz5R8nWAiJD4U0Znunx8a6Gyh7qCB1FO
        5hNULuoem+2xPYvIDjE5zfd5SGhB/oO9WaLDjA==
X-Google-Smtp-Source: AGHT+IHu0zxikQTCNAWWLtZM6M/B76oAP9q2epBXI7C5s75wxgZ4+VhtdD2DumdDMnlj7lfdIFk8abWEObJNcfeeZ2E=
X-Received: by 2002:a05:6512:2356:b0:503:385d:611b with SMTP id
 p22-20020a056512235600b00503385d611bmr1315873lfu.30.1695409700475; Fri, 22
 Sep 2023 12:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com> <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Sep 2023 14:08:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
Message-ID: <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
To:     Doug Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        andriy.shevchenko@linux.intel.com, broonie@kernel.org,
        frowand.list@gmail.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, james.clark@arm.com, james@equiv.tech,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 12:40=E2=80=AFPM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Fri, Sep 22, 2023 at 7:14=E2=80=AFAM Rob Herring <robh+dt@kernel.org> =
wrote:
> >
> > > Let's attempt to do something better. Specifically, we'll allow
> > > tagging nodes in the device tree as mutually exclusive from one
> > > another. This says that only one of the components in this group is
> > > present on any given board. To make it concrete, in my proposal this
> > > looks like:
> > >
> > >   / {
> > >     tp_ex_group: trackpad-exclusion-group {
> > >     };
> >
> > Interesting way to just get a unique identifier. But it could be any
> > phandle not used by another group. So just point all the devices in a
> > group to one of the devices in the group.
>
> Fair enough.
>
>
> > >   &i2c_bus {
> > >     tp1: trackpad@10 {
> > >       ...
> > >       mutual-exclusion-group =3D <&tp_ex_group>;
> > >     };
> > >     tp2: trackpad@20 {
> > >       ...
> > >       mutual-exclusion-group =3D <&tp_ex_group>;
> > >     };
> > >     tp3: trackpad@30 {
> > >       ...
> > >       mutual-exclusion-group =3D <&tp_ex_group>;
> > >     };
> > >   };
> > >
> > > In Linux, we can make things work by simply only probing one of the
> > > devices in the group at a time. We can make a mutex per group and
> > > enforce locking that mutex around probe. If the first device that get=
s
> > > the mutex fails to probe then it won't try again. If it succeeds then
> > > it will acquire the shared resources and future devices (which we kno=
w
> > > can't be present) will fail to get the shared resources. Future
> > > patches could quiet down errors about failing to acquire shared
> > > resources or failing to probe if a device is in a
> > > mutual-exclusion-group.
> >
> > This seems like overkill to me. Do we really need groups and a mutex
> > for each group? Worst case is what? 2-3 groups of 2-3 devices?
> > Instead, what about extending "status" with another value
> > ("fail-needs-probe"? (fail-xxx is a documented value)). Currently, the
> > kernel would just ignore nodes with that status. Then we can process
> > those nodes separately 1-by-1.
>
> My worry here is that this has the potential to impact boot speed in a
> non-trivial way. While trackpads and touchscreens _are_ probable,
> their probe routines are often quite slow. This is even mentioned in
> Dmitry's initial patches adding async probe to the kernel. See commit
> 765230b5f084 ("driver-core: add asynchronous probing support for
> drivers") where he specifically brings up input devices as examples.

Perhaps then this should be solved in userspace where it can learn
which device is actually present and save that information for
subsequent boots.

> It wouldn't be absurd to have a system that has multiple sources for
> both the trackpad and the touchscreen. If we have to probe each of
> these one at a time then it could be slow. It would be quicker to be
> able to probe the trackpads (one at a time) at the same time we're
> probing the touchscreens (one at a time). Using the "fail-needs-probe"
> doesn't provide information needed to know which devices conflict with
> each other.

I would guess most of the time that's pretty evident. They are going
to be on the same bus/link. If unrelated devices are on the same bus,
then that's going to get serialized anyways (if bus accesses are what
make things slow).

We could add information on the class of device. touchscreen and
touchpad aliases or something.

> IMO this is still better than nothing, but it worries me
> to pick the less-expressive solution for the dts which means that the
> information simply isn't there and the OS can't be made better later.
>
> Thinking about this more, I guess even my proposed solution isn't
> ideal for probe speed. Let's imagine that we had:
>
>   &i2c_bus {
>     tp1: trackpad@10 {
>       compatible =3D "hid-over-i2c";
>       reg =3D <0x10>;
>       post-power-on-delay-ms =3D <200>;
>       ...
>       mutual-exclusion-group =3D <&tp1>;
>     };
>     tp2: trackpad@20 {
>       compatible =3D "hid-over-i2c";
>       reg =3D <0x20>;
>       post-power-on-delay-ms =3D <200>;
>       ...
>       mutual-exclusion-group =3D <&tp1>;
>     };
>   };
>
> With my solution, we'd power the first device up, wait 200 ms, then
> check to see if anything acks an i2c xfer at address 0x10. If it
> didn't, we'd power down. Then we'd power up the second device
> (presumably the same power rail), wait 200 ms, and check to see if
> anything acks an i2c xfer at 0x20. It would have been better to just
> power up once, wait 200 ms, then check for a device at either 0x10 or
> 0x20.
>
> I guess with more complex touchscreens this could be more important. I
> don't know if we need to try to solve it at this point, but I guess I
> could imagine a case where we truly need to take into account all
> possible devices (maybe taking the maximum of delays?) to ensure we
> don't violate power sequencing requirements for any of them while
> probing.
>
> That would lead me to suggest this:
>
>   &i2c_bus {
>     trackpad-prober {
>       compatible =3D "mt8173-elm-hana-trackpad-prober";
>
>       tp1: trackpad@10 {
>         compatible =3D "hid-over-i2c";
>         reg =3D <0x10>;
>         ...
>         post-power-on-delay-ms =3D <200>;
>       };
>       tp2: trackpad@20 {
>         compatible =3D "hid-over-i2c";
>         reg =3D <0x20>;
>         ...
>         post-power-on-delay-ms =3D <200>;
>       };
>     };
>   };
>
> ...but I suspect that would be insta-NAKed because it's creating a
> completely virtual device ("mt8173-elm-hana-trackpad-prober") in the
> device tree. I don't know if there's something that's functionally
> similar that would be OK?

Why do you need the intermediate node other than a convenient way to
instantiate a driver? You just need a flag in each node which needs
this special handling. Again, "status" could work well here since it
keeps the normal probe from happening. But I'm not saying you can't
have some board specific code. Sometimes you just need code to deal
with this stuff. Don't try to parameterize everything to DT
properties.

Note that the above only works with "generic" compatibles with
"generic" power sequencing properties (I won't repeat my dislike
again). If only the driver knows how to handle the device, then you
still just have to have the driver probe. If you *only* wanted to
solve the above case, I'd just make "hid-over-i2c" take a 2nd (and
3rd) I2C address in reg and have those as fallbacks.

You could always make the driver probe smarter where if your supply
was already powered on, then don't delay. Then something else could
ensure that the supply is enabled. I'm not sure if regulators have the
same issue as clocks where the clock might be on from the bootloader,
then a failed probe which gets then puts the clock turns it off.

Rob
