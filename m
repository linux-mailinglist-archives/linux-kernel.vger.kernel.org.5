Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33047B26AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjI1UiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1UiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:38:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD119C;
        Thu, 28 Sep 2023 13:38:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7EEC43395;
        Thu, 28 Sep 2023 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695933485;
        bh=+5tm2Vd5PKOmhpMKfm+sC2xHmtcyWlmwAkVhsJfRFw0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n63WiHtfofc346V9vtx/DsCnBYGahYnj2S+HLeMCkLBw216CHsJ/WzIQvH7+iyMls
         EZT7sesiHWrTgLJinM/eWLLCExnsTeJZZ4ILnFDkjH06VFgaLcv8pdJHaUeNQBRAcc
         KIrGVK28GbbizxatTODb6UPzFDZrUb9nZv5t1OgKVBuFmjA9n4tIUoGRF0TIZh+JtP
         QFuYzfWbJvlcb2NdrHlhLTLgFQrmHGEw3EXowU5N7ta3vePJwBlwcGrt46uIDsF+0/
         yYyVIl+/KKBWCcUz/I7JELXNHYfluV5viStxbRyPr/dktIoGJKIfky5Jffan58FLBK
         U6te9YPrLrvrw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50481a0eee7so3981693e87.0;
        Thu, 28 Sep 2023 13:38:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz9/zEpNb5ZLzL0h2zTxcxlZuIRtnfgiReQy09dJKi5zmrxpqJ+
        mAH149N/wc7E0U7L7WDryDUPAze8CDTqCqGEKA==
X-Google-Smtp-Source: AGHT+IF2xXsg9U14M/m2PALWfFu6neDsTAAfB5nDPcr7c8bpvgDMo+9Xq+F3rz+3PE6s6CbUxi5ERC8vfRjpc67el2s=
X-Received: by 2002:a05:6512:3083:b0:504:3464:b4a1 with SMTP id
 z3-20020a056512308300b005043464b4a1mr1864702lfd.22.1695933482981; Thu, 28 Sep
 2023 13:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230921102420.RFC.1.I9dddd99ccdca175e3ceb1b9fa1827df0928c5101@changeid>
 <CAL_Jsq+noP32-m5xdUCLFPFBXLxX9Ys1BNFM+9sga6KYTmDzqQ@mail.gmail.com>
 <CAD=FV=WXxGhX0Fw2nSS7PxYb1O-LUewAhoUVPn=2EpbSD2OeHQ@mail.gmail.com>
 <CAL_JsqKJyRJmwJzB1yew71Ld7BeMMat+rzhX9XtDtiFE8Dbvcw@mail.gmail.com>
 <CAD=FV=UgFzT0TW2WEV0Wmk05EXUad2EYhN2DcckAxE_Lw5gV1Q@mail.gmail.com>
 <ZROVSAoKF9bimnSP@nixie71> <CAD=FV=UR47x+t37B2+Myv0qvvOJMFxVe-Fj7js=-Ez2GWuDySg@mail.gmail.com>
In-Reply-To: <CAD=FV=UR47x+t37B2+Myv0qvvOJMFxVe-Fj7js=-Ez2GWuDySg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 28 Sep 2023 15:37:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLohA20q4TpWQ=67Am-dwP43RXm-PPw5Crc4AdzBhTVoA@mail.gmail.com>
Message-ID: <CAL_JsqLohA20q4TpWQ=67Am-dwP43RXm-PPw5Crc4AdzBhTVoA@mail.gmail.com>
Subject: Re: [RFC PATCH] of: device: Support 2nd sources of probeable but
 undiscoverable devices
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jeff LaBundy <jeff@labundy.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 6:50=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Sep 26, 2023 at 7:37=E2=80=AFPM Jeff LaBundy <jeff@labundy.com> w=
rote:
> >
> > Hi Doug,
> >
> > On Fri, Sep 22, 2023 at 05:11:10PM -0700, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Fri, Sep 22, 2023 at 12:08=E2=80=AFPM Rob Herring <robh+dt@kernel.=
org> wrote:
> > > >
> > > > > > This seems like overkill to me. Do we really need groups and a =
mutex
> > > > > > for each group? Worst case is what? 2-3 groups of 2-3 devices?
> > > > > > Instead, what about extending "status" with another value
> > > > > > ("fail-needs-probe"? (fail-xxx is a documented value)). Current=
ly, the
> > > > > > kernel would just ignore nodes with that status. Then we can pr=
ocess
> > > > > > those nodes separately 1-by-1.
> > > > >
> > > > > My worry here is that this has the potential to impact boot speed=
 in a
> > > > > non-trivial way. While trackpads and touchscreens _are_ probable,
> > > > > their probe routines are often quite slow. This is even mentioned=
 in
> > > > > Dmitry's initial patches adding async probe to the kernel. See co=
mmit
> > > > > 765230b5f084 ("driver-core: add asynchronous probing support for
> > > > > drivers") where he specifically brings up input devices as exampl=
es.
> >
> > Ideally, all but one driver in a group should bail out of probe quickly=
 if
> > the device is not populated. If not, I would consider that to be a bug =
or at
> > least room for improvement in that driver.
> >
> > The reason input devices can take a while to probe is because they may =
be
> > loading FW over I2C or performing some sort of calibration procedure; o=
nly
> > one driver in the group should get that far.
>
> Hmm, that's not my experience. Specifically I've seen i2c-hid devices
> whose datasheets say that you're not allowed to talk i2c to them at
> all for hundreds of milliseconds after you power them on. See, for
> instance, "i2c-hid-of-goodix.c" which has a "post_gpio_reset_delay_ms"
> of 180 ms and "i2c-hid-of-elan.c" which has one of 300 ms.
>
> As I understand it these touchscreens have firmware on them and that
> firmware can take a while to boot. Until the firmware boots they won't
> respond over i2c. This is simply not something that Linux can do
> anything about.
>
> About the best you could do would be to add a board-specific driver
> that understood that it could power up the rails, wait the maximum
> amount of time that all possible touchscreens might need, and then
> look for i2c ACKs. I'm still hoping to hear from Rob about how I would
> get a board-specific driver to load on a DT system so I can
> investigate / prototype this.

foo_initcall()
{
  if (of_machine_is_compatible(...))
    platform_device_create();
}

That chunk would have to be built in and if that's part of the driver
module, autoloading wouldn't work.

We could have a match table of board compatibles and driver names. I'm
not worried about that list being big, so I'm happy to stick that in
drivers/of/.

> > > > We could add information on the class of device. touchscreen and
> > > > touchpad aliases or something.
> > >
> > > Ah, I see. So something like "fail-needs-probe-<class>". The
> > > touchscreens could have "fail-needs-probe-touchscreen" and the
> > > trackpads could have "fail-needs-probe-trackpad" ? That could work. I=
n
> > > theory that could fall back to the same solution of grabbing a mutex
> > > based on the group ID...
> > >
> > > Also: if having the mutex in the "struct device" is seen as a bad
> > > idea, it would also be easy to remove. __driver_probe_device() could
> > > just make a call like "of_device_probe_start()" at the beginning that
> > > locks the mutex and then "of_device_probe_end()" that unlocks it. Bot=
h
> > > of those calls could easily lookup the mutex in a list, which would
> > > get rid of the need to store it in the "struct device".
> > >
> > >
> > > > > That would lead me to suggest this:
> > > > >
> > > > >   &i2c_bus {
> > > > >     trackpad-prober {
> > > > >       compatible =3D "mt8173-elm-hana-trackpad-prober";
> > > > >
> > > > >       tp1: trackpad@10 {
> > > > >         compatible =3D "hid-over-i2c";
> > > > >         reg =3D <0x10>;
> > > > >         ...
> > > > >         post-power-on-delay-ms =3D <200>;
> > > > >       };
> > > > >       tp2: trackpad@20 {
> > > > >         compatible =3D "hid-over-i2c";
> > > > >         reg =3D <0x20>;
> > > > >         ...
> > > > >         post-power-on-delay-ms =3D <200>;
> > > > >       };
> > > > >     };
> > > > >   };
> > > > >
> > > > > ...but I suspect that would be insta-NAKed because it's creating =
a
> > > > > completely virtual device ("mt8173-elm-hana-trackpad-prober") in =
the
> > > > > device tree. I don't know if there's something that's functionall=
y
> > > > > similar that would be OK?
> >
> > This solution seems a bit confusing to me, and would require more edits
> > to the dts each time a second source is added. It also means one would
> > have to write a small platform driver for each group of devices, correc=
t?
>
> No matter what we need to add something to the dts each time a second
> source is added, right?

That was my thought. There is the case of the devices are almost the
same, so we lie. That's what you are doing for displays IIRC.

> While it's true that we'd end up with some extra drivers, if we do it
> correctly we don't necessarily need a driver for each group of devices
> nor even a driver per board. If several boards have very similar
> probing requirements then, even if they have unique "compatible"
> strings they could still end up using the same Linux driver.
>
> I've actually been talking offline with folks on ChromeOS more about
> this problem as well. Chen-Yu actually pointed at a patch series (that
> never landed, I guess) that has some similar ideas [1]. I guess in
> that case Hans was actually constructing device tree properties
> manually in the driver. I was thinking more of having all of the
> options listed in the device tree and then doing something that only
> causes some of them to probe.
>
> If Rob was OK with it, I guess I could have some sort of top-level
> "hwmanager" node like Hans did and then have phandle links to all the
> hardware that are managed by it. Then I could just change those to
> "okay"?

That's really just making the mutex node link the other direction. The
devices link to the common mutex node vs. the hwmanager node(s) links
to all the devices. That's really just picking the paint colors.

> Ideally, though, this could somehow use device tree "overlays" I
> guess. That seems like almost a perfect fit. I guess the issue here,
> though, is that I'd want the overlays bundled together with the
> original DT and then the board-specific "hardware prober" driver to
> actually apply the overlays after probing. Does that seem sensible?

BTW, there was an idea long ago from maintainer emeritus Likely to
append overlays to the base DTB for the kernel to apply.

How would that help you here? Are you going to have an overlay for
each device that enables it? It's much easier to just call
of_update_property() to change "status".

Rob
