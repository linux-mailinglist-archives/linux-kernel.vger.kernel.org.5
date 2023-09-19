Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9107A5A89
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjISHHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjISHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:07:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FD1116;
        Tue, 19 Sep 2023 00:07:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A10C433C8;
        Tue, 19 Sep 2023 07:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695107249;
        bh=hk6MTSg2w6vRJMTSQbUVxxO4PouQtMWRgz7EPaXFfhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tByPkdImFal9VUGiAJG0v4DB3+eTkbIARCBO22fNE8S1MiU529opNX4DXDb0heUly
         Yh1TS4hWzdTuvqhECYgg9KWuDdZg+l6JwaPE9oYe6wknLybJS4VhG89ACI8ueE7bWP
         tTpsUX0+ur4zhpcRkBeO1IIZ9AuQ+cYfTi64h1qVX+2vFEeaWck178Fp1+9SX9Q/cZ
         jFVeyxw3/qlWxeP14c/iejtQwFFL8tahguPeaAwwjBvGc3WkDXhYSXJ/YWORlYrkwW
         8h0EHIbU7MBl0fKmRh2c44YF4o/xnuxOHhhdHweIRtiv659jM/Z+RbDNjWvfdoADgL
         jiI5H94H1WASQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qiUph-0006Wl-3B;
        Tue, 19 Sep 2023 09:07:42 +0200
Date:   Tue, 19 Sep 2023 09:07:41 +0200
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
Message-ID: <ZQlIveJVdvyV2Ygy@hovoldconsulting.com>
References: <20230918125851.310-1-johan+linaro@kernel.org>
 <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:00:15AM -0700, Doug Anderson wrote:
> On Mon, Sep 18, 2023 at 6:00 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> > A recent commit reordered probe so that the interrupt line is now
> > requested before making sure that the device exists.
> >
> > This breaks machines like the Lenovo ThinkPad X13s which rely on the
> > HID driver to probe second-source devices and only register the variant
> > that is actually populated. Specifically, the interrupt line may now
> > already be (temporarily) claimed when doing asynchronous probing of the
> > touchpad:
> >
> >         genirq: Flags mismatch irq 191. 00082008 (hid-over-i2c) vs. 00082008 (hid-over-i2c)
> >         i2c_hid_of 21-0015: Could not register for hid-over-i2c interrupt, irq = 191, ret = -16
> >         i2c_hid_of: probe of 21-0015 failed with error -16
> >
> > Fix this by restoring the old behaviour of first making sure the device
> > exists before requesting the interrupt line.

> Ugh, sorry for the regression. :( It actually turns out that I've been
> digging into this same issue on a different device (see
> mt8173-elm-hana). I hadn't realized that it was a regression caused by
> my recent change, though.
> 
> I haven't yet reviewed your change in detail, but to me it seems like
> at most a short term fix. Specifically, I think the way that this has
> been working has been partially via hacks and partially via luck. Let
> me explain...
> 
> Currently, to make this work the `sc8280xp-lenovo-thinkpad-x13s.dts`
> file has a hack in it. You can see that the `tpad_default` pinctrl
> entry has been moved up to the i2c bus level even though it doesn't
> belong there (it should be in each trackpad). This is because,
> otherwise, you would have run into similar type problems as the device
> core would have failed to claim the pin for one of the devices.

Ḯ'm well aware of that and it was mentioned in the commit message for
4367d763698c ("arm64: dts: qcom: sc8280xp-x13s: enable alternate
touchpad") as well as discussed briefly with Rob here:

	https://lore.kernel.org/all/Y3teH14YduOQQkNn@hovoldconsulting.com/

> Currently, we're getting a bit lucky with
> `sc8280xp-lenovo-thinkpad-x13s.dts` that there are no other shared
> resources between the two devices besides the interrupt. Specifically
> a number of trackpads / touchscreens also have a "reset" GPIO that
> needs to be power sequenced properly in order to talk to the
> touchscreen. In this case we'll be stuck again because both instances
> would need to grab the "reset" GPIO before being able to confirm if
> the device is there.

Right, this will only work for fairly simple cases, but we do have a few
of those in tree since some years back.

> This is an old problem. The first I remember running into it was back
> in 2015 on rk3288-veryron-minnie. We had a downstream hack to make
> this work with -EPROBE_DEFER. https://crrev.com/c/266224. By the time
> we shipped, though, we decided not to do the 2nd sourcing. After that
> I always NAKed HW designs like this, but I guess that didn't help with
> Mediatek hardware I wasn't involved with. :( ...and, of course, it
> didn't help with devices that aren't Chromebooks like the Thinkpad
> X13S.
> 
> FWIW: as a short term solution, we ended up forcing synchronous probe
> in <https://crrev.com/c/4857566>. This has some pretty serious boot
> time implications, but it's also very simple.
> 
> 
> I'm actively working on coming up with a better solution here. My
> current thought is that that maybe we want to do:
> 
> 1. Undo the hack in the device tree and have each "2nd source" have
> its own pinctrl entry.
> 
> 2. In core pinctrl / device probing code detect the pinctrl conflict
> and only probe one of the devices at a time.
> 
> ...that sounds like a nice/elegant solution and I'm trying to make it
> work, though it does have some downsides. Namely:
> 
> a) It requires "dts" changes to work. Namely we've got to undo the
> hack that pushed the pinctrl up to the controller level (or, in the
> case of mt8173-elm-hana, that just totally skipped the "pinctrl" entry
> altogether). Unfortunately those same "dts" changes will actually make
> things _worse_ if you don't have the code change. :(

Right, a proper solution will likely require an updated DT.

> b) It only handles the case where the resources shared by 2nd sourcing
> are expressed by pinctrl. In a practical sense this seems to be most
> cases, but conceivably you could imagine running into this situation
> with a non-pin-related shared resource.

Indeed.

> c) To solve this in the core, we have to make sure we properly handle
> (without hanging/failing) multiple partially-conflicting devices and
> devices that might acquire resources in arbitrary orders.
> 
> Though the above solution detecting the pinctrl conflicts sounds
> appealing and I'm currently working on prototyping it, I'm still not
> 100% convinced. I'm worried about the above downsides.

Yes, I agree that we'd need to take a broader look at this and not just
focus on the immediate pinctrl issue.
 
> Personally, I feel like we could add information to the device tree
> that would help us out. The question is: is this an abuse of device
> tree for something that Linux ought to be able to figure out on its
> own, or is it OK? To make it concrete, I was thinking about something
> like this:
> 
> / {
>   tp_ex_group: trackpad-exclusion-group {
>     members = <&tp1>, <&tp2>, <&tp3>;
>   };
> };
> 
> &i2c_bus {
>   tp1: trackpad@10 {
>     ...
>     mutual-exclusion-group = <&tp_ex_group>;
>   };
>   tp2: trackpad@20 {
>     ...
>     mutual-exclusion-group = <&tp_ex_group>;
>   };
>   tp3: trackpad@30 {
>     ...
>     mutual-exclusion-group = <&tp_ex_group>;
>   };
> };
> 
> Then the device core would know not to probe devices in the same
> "mutual-exclusion-group" at the same time.
> 
> If DT folks are OK with the "mutual-exclusion-group" idea then I'll
> probably backburner my attempt to make this work on the pinctrl level
> and go with that.

I expressed something along these lines in the thread above:

	It seems we'd need some way to describe the devices as mutually
	exclusive...

but given that we had prior art for handling simple cases and due to
lack of time, I left it on the ever-growing todo list.

But regardless of what a long-term proper solution to this may look
like, we need to fix the regression in 6.6-rc1 by restoring the old
behaviour.

Johan
