Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8937A7400
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbjITH0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233602AbjITH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:26:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12229CA;
        Wed, 20 Sep 2023 00:26:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7C2C433C7;
        Wed, 20 Sep 2023 07:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695194761;
        bh=X9yOJUrjbWjEiTh3oxcVWNpA9x66namZO18j2DCtN20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+kD+g2qcMwNqpfEO7M07AvF7mj0L2bWq9J+lhxLXC5Zv1dIeob7kY1rrVuRwy2wn
         akDNc2Q9cWeWeMjfXM2O72qeESctR/xVOIH9600vNp05V0VFuT01QEtxIe7envji46
         Kug1Ox3t1DdD8ceidkDfa4WPtmuXz/G7qafrk9KhIoTDo/pQ51gpdXIMupjA4bRPk0
         RbClZGqhXy4LyHl20I5dugCOoGsgH/YclPT5NHpxUQmhUN7ls21L9qwrzYjxJlqyDT
         zDn3aaeJNv5rti4DuNoC/ED3BhxOTptixs4LOs9xMlszJrOSbinRxnAQlR2o33qmuR
         4Ed7283WVi2KQ==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qirbE-0002wI-2Q;
        Wed, 20 Sep 2023 09:26:17 +0200
Date:   Wed, 20 Sep 2023 09:26:16 +0200
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
Message-ID: <ZQqemN8P2VKgxhsV@hovoldconsulting.com>
References: <20230918125851.310-1-johan+linaro@kernel.org>
 <CAD=FV=Wfwvp-SbGrdO5VJcjG42njkApJPB7wnY-YYa1_-O0JWQ@mail.gmail.com>
 <ZQlIveJVdvyV2Ygy@hovoldconsulting.com>
 <CAD=FV=XBG7auVVyHn5uvahSZZxp5qBfp4+A9NwFqahdN6XrbZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=XBG7auVVyHn5uvahSZZxp5qBfp4+A9NwFqahdN6XrbZA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 11:15:46AM -0700, Doug Anderson wrote:
> On Tue, Sep 19, 2023 at 12:07 AM Johan Hovold <johan@kernel.org> wrote:

> > But regardless of what a long-term proper solution to this may look
> > like, we need to fix the regression in 6.6-rc1 by restoring the old
> > behaviour.
> 
> OK, fair enough. I'll take a look at your patch, though I think the
> person that really needs to approve it is Benjamin...
> 
> Style-wise, I will say that Benjamin really wanted to keep the "panel
> follower" code out of the main probe routine. Some of my initial
> patches adding "panel follower" looked more like the results after
> your patch but Benjamin really wasn't happy until there were no
> special cases for panel-followers in the main probe routine. This is
> why the code is structured as it is.

Ok, I prefer not hiding away things like that as it obscures what's
really going on, for example, in this case, that you register a device
without really having probed it.

As I alluded to in the commit message, you probably want to be able to
support second-source touchscreen panel followers as well at some point
and then deferring checking whether device is populated until the panel
is powered on is not going to work.

I skimmed the thread were you added this, but I'm not sure I saw any
reason for why powering on the panel follower temporarily during probe
would not work?

> Thinking that way, is there any reason you can't just move the
> i2c_hid_init_irq() into __do_i2c_hid_core_initial_power_up()? You
> could replace the call to enable_irq() with it and then remove the
> `IRQF_NO_AUTOEN` flag? I think that would also solve the issue if you
> wanted to use a 2nd source + the panel follower concept? Both devices
> would probe, but only one of them would actually grab the interrupt
> and only one of them would actually create real HID devices. We might
> need to do some work to keep from trying again at every poweron of the
> panel, but it would probably be workable? I think this would also be a
> smaller change...

That was my first idea as well, but conceptually it is more correct to
request resources at probe time and not at some later point when you can
no longer fail probe.

You'd also need to handle the fact that the interrupt may never have
been requested when remove() is called, which adds unnecessary
complexity.

Johan
