Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E9B7B5331
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjJBM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237615AbjJBMRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:17:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3953B2116;
        Mon,  2 Oct 2023 05:10:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962B7C433C7;
        Mon,  2 Oct 2023 12:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696248593;
        bh=Q2dI86gLoM9qmguLVEYaXAHM2kQPybZFLgpNQ9YzSws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I/GZjwnZfS1nqGDGvcpErzbFDlZs3Uj7Zmp7kyW/+ORKIoNDC+W22qrTyWBMkhxDM
         RcjlDJYFJDlZTVgFBU4i4pobrCVEK2e6AI3Lx5GqbkdaYlwYqWwaIm56C8ivgVgasJ
         gLKrgAvEYzd6e2TZ4Y9Y416Ku2GqBADYRSykQi0vlhaBNyaMj/saePJHjANTg8nJxn
         LjQDKzeFYyp1duggbzAyN7kjQq4+IVwS9TWyZwOtX8YGxj6+vy85jCG0Ds18KC5kzA
         FzHK5BYNp/cnBmocWC6QkLHJ0aDZ5HnuLCEr9NJ0FpAuF4AQ4F1p2TvlpW0cx87/zW
         haB1RXBAUJVLg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnHkO-0005fO-1N;
        Mon, 02 Oct 2023 14:10:01 +0200
Date:   Mon, 2 Oct 2023 14:10:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
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
Subject: Re: [PATCH] HID: i2c-hid: fix handling of unpopulated devices
Message-ID: <ZRqzGA1F6JV-mlRL@hovoldconsulting.com>
References: <20230918125851.310-1-johan+linaro@kernel.org>
 <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
 <ZQlIveJVdvyV2Ygy@hovoldconsulting.com>
 <CAD=FV=XBG7auVVyHn5uvahSZZxp5qBfp4+A9NwFqahdN6XrbZA@mail.gmail.com>
 <ZQqemN8P2VKgxhsV@hovoldconsulting.com>
 <CAD=FV=XK87TZuPy+d2r2g5QhowmghE-m9pGHe9-X7jnXAw9z1g@mail.gmail.com>
 <ZQ1Zm6ec9NuBvqpl@hovoldconsulting.com>
 <CAD=FV=USBJRzqxX9kBP8pp4LKRGpBee+jkHL=KmeQvyfBk2CVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=USBJRzqxX9kBP8pp4LKRGpBee+jkHL=KmeQvyfBk2CVQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 09:37:43AM -0700, Doug Anderson wrote:
> On Fri, Sep 22, 2023 at 2:08 AM Johan Hovold <johan@kernel.org> wrote:
> > On Wed, Sep 20, 2023 at 08:41:12AM -0700, Doug Anderson wrote:
> > > On Wed, Sep 20, 2023 at 12:26 AM Johan Hovold <johan@kernel.org> wrote:
> > > > On Tue, Sep 19, 2023 at 11:15:46AM -0700, Doug Anderson wrote:
> > > > > On Tue, Sep 19, 2023 at 12:07 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > > > As I alluded to in the commit message, you probably want to be able to
> > > > support second-source touchscreen panel followers as well at some point
> > > > and then deferring checking whether device is populated until the panel
> > > > is powered on is not going to work.

> > > > I skimmed the thread were you added this, but I'm not sure I saw any
> > > > reason for why powering on the panel follower temporarily during probe
> > > > would not work?
> > >
> > > My first instinct says we can't do this, but let's think about it...
> > >
> > > In general the "panel follower" API is designed to give all the
> > > decision making about when to power things on and off to the panel
> > > driver, which is controlled by DRM.
> > >
> > > The reason for this is from experience I had when dealing with the
> > > Samsung ATNA33XC20 panel that's on "sc7180-trogdor-homestar". The TCON
> > > on that panel tended to die if you didn't sequence it just right.
> > > Specifically, if you were sending pixels to the panel and then stopped
> > > then you absolutely needed to power the panel off and on again. Folks
> > > I talked to even claimed that the panel was working "to spec" since,
> > > in the "Power Sequencing" section of the eDP spec it clearly shows
> > > that you _must_ turn the panel off and on again after you stop giving
> > > it bits. ...this is despite the fact that no other panel I've worked
> > > with cares. ;-)
> > >
> > > On homestar, since we didn't have the "panel follower" API, we ended
> > > up adding cost to the hardware and putting the panel and touchscreens
> > > on different power rails. However, I wanted to make sure that if we
> > > ran into a similar situation in the future (or maybe if we were trying
> > > to make hardware work that we didn't have control over) that we could
> > > solve it.

Out of curiosity, are there any machines that actually need this
"panel-follower" API today, or are saying above that this is just
something that may be needed one day?

> > > The other reason for giving full control to the panel driver is just
> > > how userspace usually works. Right now userspace tends to power off
> > > panels if they're not used (like if a lid is closed on a laptop) but
> > > doesn't necessarily power off the touchscreen. Thus if the touchscreen
> > > has the ability to keep things powered on then we'd never get to a low
> > > power state.
> >
> > Don't you need to keep the touchscreen powered to support wakeup events
> > (e.g. when not closing the lid)?
> 
> No. The only reason you'd use panel follower is if the hardware was
> designed such that the touchscreen needed to be power sequenced with
> the panel. If the touchscreen can stay powered when the panel is off
> then it is, by definition, not a panel follower.
> 
> For a laptop I don't think most people expect the touchscreen to stay
> powered when the screen is off. I certainly wouldn't expect it. If the
> screen was off and I wanted to interact with the device, I would hit a
> key on the keyboard or touch the trackpad. When the people designing
> sc7180-trogdor chose to have the display and touchscreen share a power
> rail they made a conscious choice that they didn't need the
> touchscreen active when the screen was off.

Sure, but that's a policy decision and not something that should be
hard-coded in our drivers.

> For the other hardware I'm aware of that needs panel-follower there is
> a single external chip on the board that handles driving the panel and
> the touchscreen. The power sequencing requirements for this chip
> simply don't allow the touchscreen to be powered on while the display
> is off.
> 
> One use case where I could intuitively think I might touch a
> touchscreen of a screen that was "off" would be a kiosk of some sort.
> It would make sense there to have two power rails. ...or, I suppose,
> userspace could just choose to turn the backlight off but keep the
> screen (and touchscreen) powered.

Right.

> > And if you close the lid with wakeup disabled, you should still be able
> > to power down the touchscreen as part of suspend, right?
> >
> > > The above all explains why panel followers like the touchscreen
> > > shouldn't be able to keep power on. However, you are specifically
> > > suggesting that we just turn the power on temporarily during probe. As
> > > I think about that, it might be possible? I guess you'd have to
> > > temporarily block DRM from changing the state of the panel while the
> > > touchscreen is probing. Then if the panel was off then you'd turn it
> > > on briefly, do your probe, and then turn it off again. If the panel
> > > was on then by blocking DRM you'd ensure that it stayed on. I'm not
> > > sure how palatable that would be or if there are any other tricky
> > > parts I'm not thinking about.
> >
> > As this would allow actually probing the touchscreen during probe(), as
> > the driver model expects, this seems like a better approach then
> > deferring probe and registration if it's at all doable.
> 
> Yeah, I don't 100% know if it's doable but it seems possible.
> Certainly it's something for future investigation.
> 
> Luckily, at the moment anything I'm aware of that truly needs panel
> follower also doesn't have multiple sources for a touchscreen.

Ok, so with the current panel-follower implementation you essentially
only waste a bit of memory in case of a non-populated touchscreen (e.g.
by keeping the platform and follower devices registered).

> > > > > Thinking that way, is there any reason you can't just move the
> > > > > i2c_hid_init_irq() into __do_i2c_hid_core_initial_power_up()? You
> > > > > could replace the call to enable_irq() with it and then remove the
> > > > > `IRQF_NO_AUTOEN` flag? I think that would also solve the issue if you
> > > > > wanted to use a 2nd source + the panel follower concept? Both devices
> > > > > would probe, but only one of them would actually grab the interrupt
> > > > > and only one of them would actually create real HID devices. We might
> > > > > need to do some work to keep from trying again at every poweron of the
> > > > > panel, but it would probably be workable? I think this would also be a
> > > > > smaller change...
> > > >
> > > > That was my first idea as well, but conceptually it is more correct to
> > > > request resources at probe time and not at some later point when you can
> > > > no longer fail probe.
> > > >
> > > > You'd also need to handle the fact that the interrupt may never have
> > > > been requested when remove() is called, which adds unnecessary
> > > > complexity.
> > >
> > > I don't think it's a lot of complexity, is it? Just an extra "if" statement...
> >
> > Well you'd need keep track of whether the interrupt has been requested
> > or not (and manage serialisation) yourself for a start.
> 
> Sure. So I guess an "if" test plus a boolean state variable. I still
> don't think it's a lot of complexity.

I never said "a lot", I used the word "unnecessary". But how much it
adds also depends on whether you need additional synchronisation.

But again, the main point is that the "panel-follower" feature should
not complicate and obfuscate the driver's probe implementation. And
looking up resources belongs in probe().

> > But the main reason is still that requesting resources belongs in
> > probe() and should not be deferred to some later random time where you
> > cannot inform driver core of failures (e.g. for probe deferral if the
> > interrupt controller is not yet available).
> 
> OK, I guess the -EPROBE_DEFER is technically possible though probably
> not likely in practice. ...so that's a good reason to make sure we
> request the IRQ in probe even in the "panel follower" case. I still
> beleive Benjamin would prefer that this was abstracted out and not in
> the actual probe() routine, but I guess we can wait to hear from him.

I talked to Benjamin at Kernel Recipes last week and I don't think he
has any fundamental objections to the fix I'm proposing.

I prefer it as it makes the code easier to reason about and clearly
marks the code paths that differ in case the device is a "panel
follower". And since you said it also makes the code look more like what
you originally intended, then I guess you should be ok with it too?

Looking at the patch again, I may do a v2 to only look up the "panel"
property once even if that's a really minor optimisation.

> One last idea I had while digging would be to wonder if we could
> somehow solve this case with "IRQF_PROBE_SHARED". I guess that doesn't
> work well together with "IRQF_NO_AUTOEN", but conceivably we could
> have the interrupt handler return "IRQ_NONE" if the initial power up
> never happened? I haven't spent much time poking with shared
> interrupts though, so I don't know if there are other side effects...

Yeah, that doesn't seem right, though. The interrupt line is not really
shared, it's just that we need to check whether the device is populated
before requesting the interrupt.

Johan
