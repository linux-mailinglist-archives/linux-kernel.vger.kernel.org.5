Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B972762F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbjGZISG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjGZIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:17:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853D56199;
        Wed, 26 Jul 2023 01:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AD26617FE;
        Wed, 26 Jul 2023 08:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE039C433C7;
        Wed, 26 Jul 2023 08:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690358828;
        bh=02/BpPWpwcY6qGVMejurwI2MWG0QRmzw+p5vHPciA24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Si6mynfF/QLiJ9GIAhKKfRQiDSikeuZ873k10cyiYklhjlNSURbHevhJKwAb+l92S
         Uf8Kj9aLuzyIeNRdJEPYMETFNTeYV7p1dx2Vzj/Dhtu3ViQam7sFC8KYLXJu3pR/42
         z52VBElkQ3oAOQwDr5qrKtXFrBhQ9MGMVOlPQOvDKPv/oMiYspXZVkCwbnzcZIWT8a
         yJ6xNx9UpPdJr/UbbthJW4jj1UAcJzkJy3UJnijsHT3DOx8yCTvAlxetVeb0C+5c9P
         wfZPGkuZRxqTFUcenD3YoMUSuqJiBBFkMPKCv5urluIJDUJujg9A49V62hu32CLWhE
         vo4Y0h1mZcXdw==
Date:   Wed, 26 Jul 2023 10:07:00 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 08/10] HID: i2c-hid: Support being a panel follower
Message-ID: <wcilyqbh23xjscsvubxjnkwlctxuvyj5weix2opywkolg7udyb@gad2pmlazxx4>
References: <20230607215224.2067679-1-dianders@chromium.org>
 <20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
 <y3l4x3kv7jgog3miexati5wbveaynnryzqvj6sc4ul6625f2if@w7nqgojfavfw>
 <CAD=FV=VbdeomBGbWhppY+5TOSwt64GWBHga68OXFwsnO4gg4UA@mail.gmail.com>
 <CAD=FV=UUdc5xi-HoOye-a1Oki3brcX3V1+=zuxQKLAcrd3iTSA@mail.gmail.com>
 <CAD=FV=WmpH6cB0oZOxbL+TUxjLRf3PM+kKvuYRAZSiEhS4o37A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=WmpH6cB0oZOxbL+TUxjLRf3PM+kKvuYRAZSiEhS4o37A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25 2023, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jul 17, 2023 at 11:15 AM Doug Anderson <dianders@chromium.org> wrote:
> >
> > Benjamin,
> >
> > On Mon, Jun 26, 2023 at 3:49 PM Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Benjamin,
> > >
> > > On Thu, Jun 8, 2023 at 8:37 AM Benjamin Tissoires
> > > <benjamin.tissoires@redhat.com> wrote:
> > > >
> > > > > +static const struct drm_panel_follower_funcs i2c_hid_core_panel_follower_funcs = {
> > > > > +     .panel_prepared = i2c_hid_core_panel_prepared,
> > > > > +     .panel_unpreparing = i2c_hid_core_panel_unpreparing,
> > > > > +};
> > > >
> > > > Can we make that above block at least behind a Kconfig?
> > > >
> > > > i2c-hid is often used for touchpads, and the notion of drm panel has
> > > > nothing to do with them. So I'd be more confident if we could disable
> > > > that code if not required.
> > >
> > > Now that other concerns are addressed, I started trying to write up a
> > > v3 and I found myself writing this as the description of the Kconfig
> > > entry:
> > >
> > > --
> > > config I2C_HID_SUPPORT_PANEL_FOLLOWER
> > > bool "Support i2c-hid devices that must be power sequenced with a panel"
> > >
> > > Say Y here if you want support for i2c-hid devices that need to
> > > coordinate power sequencing with a panel. This is typically important
> > > when you have a panel and a touchscreen that share power rails or
> > > reset GPIOs. If you say N here then the kernel will not try to honor
> > > any shared power sequencing for your hardware. In the best case,
> > > ignoring power sequencing when it's needed will draw extra power. In
> > > the worst case this will prevent your hardware from functioning or
> > > could even damage your hardware.
> > >
> > > If unsure, say Y.
> > >
> > > --
> > >
> > > I can certainly go that way, but I just wanted to truly make sure
> > > that's what we want. Specifically:
> > >
> > > 1. If we put the panel follower code behind a Kconfig then we actually
> > > have no idea if a touchscreen was intended to be a panel follower.
> > > Specifically the panel follower API is the one that detects the
> > > connection between the panel and the i2c-hid device, so without being
> > > able to call the panel follower API we have no idea that an i2c-hid
> > > device was supposed to be a panel follower.
> > >
> > > 2. It is conceivable that power sequencing a device incorrectly could
> > > truly cause hardware damage.
> > >
> > > Together, those points mean that if you turn off the Kconfig entry and
> > > then try to boot on a device that needed that Kconfig setting that you
> > > might damage hardware. I can code it up that way if you want, but it
> > > worries me...
> > >
> > >
> > > Alternatives that I can think of:
> > >
> > > a) I could change the panel follower API so that panel followers are
> > > in charge of detecting the panel that they follow. Today, that looks
> > > like:
> > >
> > >        panel_np = of_parse_phandle(dev->of_node, "panel", 0);
> > >        if (panel_np)
> > >                /* It's a panel follower */
> > >        of_node_put(panel_np);
> > >
> > > ...so we could put that code in each touchscreen driver and then fail
> > > to probe i2c-hid if we detect that we're supposed to be a panel
> > > follower but the Kconfig is turned off. The above doesn't seem
> > > massively ideal since it duplicates code. Also, one reason why I put
> > > that code in drm_panel_add_follower() is that I think this concept
> > > will eventually be needed even for non-DT cases. I don't know how to
> > > write the non-DT code right now, though...
> > >
> > >
> > > b) I could open-code detect the panel follower case but leave the
> > > actual linking to the panel follower API. AKA add to i2c-hid:
> > >
> > >        if (of_property_read_bool(dev->of_node, "panel"))
> > >                /* It's a panel follower */
> > >
> > > ...that's a smaller bit of code, but feels like an abstraction
> > > violation. It also would need to be updated if/when we added support
> > > for non-DT panel followers.
> > >
> > >
> > > c) I could add a "static inline" implementation of b) to "drm_panel.h".
> > >
> > > That sounds great and I started doing it. ...but then realized that it
> > > means adding to drm_panel.h:
> > >
> > > #include <linux/device.h>
> > > #include <linux/of.h>
> > >
> > > ...because otherwise of_property_read_bool() isn't defined and "struct
> > > device" can't be dereferenced. That might be OK, but it looks as if
> > > folks have been working hard to avoid things like this in header
> > > files. Presumably it would get uglier if/when we added the non-DT
> > > case, as well. That being said, I can give it a shot...
> > >
> > > --
> > >
> > > At this point, I'm hoping for some advice. How important is it for you
> > > to have a Kconfig for "I2C_HID_SUPPORT_PANEL_FOLLOWER"?
> > >
> > > NOTE: even if I don't add the Kconfig, I could at least create a
> > > function for registering the panel follower that would get most of the
> > > panel follower logic out of the probe function. Would that be enough?
> >
> > I'd love to send a new version of this patch series, but I'm still
> > stuck with the above issue. I'm hoping you might have a minute to
> > provide your thoughts. If I don't hear anything, I'll try a v3 where I
> > don't have the Kconfig for "I2C_HID_SUPPORT_PANEL_FOLLOWER" but just
> > try to pull a little more of the code out of the probe function.
> 
> To provide breadcrumbs, I posted the v3 which pulls a bit more code
> out of the probe function but is otherwise largely unchanged. The
> cover letter for v3 can be found at:

Apologies for the delay. Given that you received feedbacks from other
folks I wanted things to settle down a little bit before returning to
this discussion. Sorry.

> 
> https://lore.kernel.org/r/20230725203545.2260506-1-dianders@chromium.org/

I like the 8th patch of this series much more. If there is a risk of
damaging the device, then we should not have the Kconfig to disable it.

I have some comments on that particular patch (v3 8/10), but I; ll reply
inline.

Cheers,
Benjamin
