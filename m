Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A27B579A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbjJBPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjJBPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:48:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66EB93;
        Mon,  2 Oct 2023 08:48:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86986C433C7;
        Mon,  2 Oct 2023 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696261709;
        bh=rFA173u7TYSSDdMiO8zMnnvXrhNdNsDs7EeyJiXp5SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNn2CsXENcCuXB0l7pfRk1AHPhE9B5i3OL6CajMgO6oipyPQcW3EFZjDSbGpRtreA
         ZsghJsMFo4FunNaGoaNP2aus9jKDiV05cInibJ6bzCMYYLeOzme746dD9HBliMbFCw
         Dh50CNFM0FAF0orjaLK/BZZ0AFuOAmpgEUYqFFiDDt0zOuXxAPLpkWleQCJRKygeIK
         VtYBqZAYgxiaqemoK36acKkWaHVVa8vhJ3+H0IVC/t7vg6hyTyd4XqKFdMykXKKmDQ
         UUvmJpHx4p6Gcz7pIPeNJ4/Os02Jd7CEB83ujSFTQ+ihm0NGCWljsH9kN4NWytRK4k
         rJ/84ulmyrkYA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qnL9w-0005a9-2L;
        Mon, 02 Oct 2023 17:48:37 +0200
Date:   Mon, 2 Oct 2023 17:48:36 +0200
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
Message-ID: <ZRrmVN3Rbz9PY8FW@hovoldconsulting.com>
References: <20230918125851.310-1-johan+linaro@kernel.org>
 <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
 <ZQlIveJVdvyV2Ygy@hovoldconsulting.com>
 <CAD=FV=XBG7auVVyHn5uvahSZZxp5qBfp4+A9NwFqahdN6XrbZA@mail.gmail.com>
 <ZQqemN8P2VKgxhsV@hovoldconsulting.com>
 <CAD=FV=XK87TZuPy+d2r2g5QhowmghE-m9pGHe9-X7jnXAw9z1g@mail.gmail.com>
 <ZQ1Zm6ec9NuBvqpl@hovoldconsulting.com>
 <CAD=FV=USBJRzqxX9kBP8pp4LKRGpBee+jkHL=KmeQvyfBk2CVQ@mail.gmail.com>
 <ZRqzGA1F6JV-mlRL@hovoldconsulting.com>
 <CAD=FV=UHEeu3crTFEZDY+LDQZk07H8un7gCSs0jyCQJrGYkV=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UHEeu3crTFEZDY+LDQZk07H8un7gCSs0jyCQJrGYkV=Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 07:35:06AM -0700, Doug Anderson wrote:
> On Mon, Oct 2, 2023 at 5:09 AM Johan Hovold <johan@kernel.org> wrote:

> > Out of curiosity, are there any machines that actually need this
> > "panel-follower" API today, or are saying above that this is just
> > something that may be needed one day?
> 
> Yes. See commit de0874165b83 ("drm/panel: Add a way for other devices
> to follow panel state") where I point to Cong Yang's original patch
> [1]. In that patch Cong was trying to make things work by assuming
> probe ordering and manually taking some of the power sequencing stuff
> out of some of the drivers in order to get things to work.
> 
> [1] https://lore.kernel.org/r/20230519032316.3464732-1-yangcong5@huaqin.corp-partner.google.com

Ok, thanks for the pointer.

> > > > Don't you need to keep the touchscreen powered to support wakeup events
> > > > (e.g. when not closing the lid)?
> > >
> > > No. The only reason you'd use panel follower is if the hardware was
> > > designed such that the touchscreen needed to be power sequenced with
> > > the panel. If the touchscreen can stay powered when the panel is off
> > > then it is, by definition, not a panel follower.
> > >
> > > For a laptop I don't think most people expect the touchscreen to stay
> > > powered when the screen is off. I certainly wouldn't expect it. If the
> > > screen was off and I wanted to interact with the device, I would hit a
> > > key on the keyboard or touch the trackpad. When the people designing
> > > sc7180-trogdor chose to have the display and touchscreen share a power
> > > rail they made a conscious choice that they didn't need the
> > > touchscreen active when the screen was off.
> >
> > Sure, but that's a policy decision and not something that should be
> > hard-coded in our drivers.
> 
> If the touchscreen and panel can be powered separately then, sure,
> it's a policy decision.
> 
> In the cases where the touchscreen and panel need to be powered
> together I'd say it's more than a policy decision. Even if it wasn't,
> you have to make _some_ decision in the kernel. One could also argue
> that if you say that you're going to force the panel to be powered on
> whenever the touchscreen is on then that's just as much of a policy
> decision, isn't it?

I get your point, but with runtime pm suspending the touchpad after a
timeout it seems that would still be the most flexible alternative
which allows deferring the decision whether to support wakeup on
touch events to the user.

> In any case, the fact that there is a shared power rail / shared power
> sequence is because the hardware designer intended them to either be
> both off or both on. Whenever I asked the EEs that designed these
> boards about leaving the touchscreen on while turning the panel power
> off they always looked at me incredulously and asked why I would ever
> do that. Although we can work around the hardware by powering the
> panel in order to allow the touchscreen to be on, it's just not the
> intention.

I hear you, but users sometimes want do things with their hardware which
may not have originally been intended (e.g. your kiosk example).

> > > > But the main reason is still that requesting resources belongs in
> > > > probe() and should not be deferred to some later random time where you
> > > > cannot inform driver core of failures (e.g. for probe deferral if the
> > > > interrupt controller is not yet available).
> > >
> > > OK, I guess the -EPROBE_DEFER is technically possible though probably
> > > not likely in practice. ...so that's a good reason to make sure we
> > > request the IRQ in probe even in the "panel follower" case. I still
> > > beleive Benjamin would prefer that this was abstracted out and not in
> > > the actual probe() routine, but I guess we can wait to hear from him.
> >
> > I talked to Benjamin at Kernel Recipes last week and I don't think he
> > has any fundamental objections to the fix I'm proposing.
> 
> Sure. I don't either though I'm hoping that we can come up with a more
> complete solution long term.
> 
> 
> > I prefer it as it makes the code easier to reason about and clearly
> > marks the code paths that differ in case the device is a "panel
> > follower". And since you said it also makes the code look more like what
> > you originally intended, then I guess you should be ok with it too?
> 
> It looks OK to me. The biggest objection I have is just that I dislike
> it when code churns because two people disagree what the nicer style
> is. It just makes for bigger diffs and more work to review things.

Ok, but this isn't just about style as that initial_power_on() function
which does all the magic needs to be broken up to fix the regression
(unless you want to convolute the driver and defer resource lookups
until panel power-on).

I'll respin a v2 with that panel-property lookup change I mentioned and
hopefully we can get this fixed this week.

> > > One last idea I had while digging would be to wonder if we could
> > > somehow solve this case with "IRQF_PROBE_SHARED". I guess that doesn't
> > > work well together with "IRQF_NO_AUTOEN", but conceivably we could
> > > have the interrupt handler return "IRQ_NONE" if the initial power up
> > > never happened? I haven't spent much time poking with shared
> > > interrupts though, so I don't know if there are other side effects...
> >
> > Yeah, that doesn't seem right, though. The interrupt line is not really
> > shared, it's just that we need to check whether the device is populated
> > before requesting the interrupt.
> 
> I'm not convinced that marking it as shared is any "less right" than
> extra work to request the interrupt after we've probed the device.
> Fundamentally both are taking into account that another touchscreen
> might be trying to probe with the same interrupt line.

If you need to start to thinking about rewriting your interrupt handler,
I'd say that qualifies as "less right". ;)

Johan
