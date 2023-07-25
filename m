Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4029B7623BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjGYUlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjGYUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:41:35 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEFF1FDF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:41:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992ace062f3so1021595766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690317676; x=1690922476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDQQ0x4yX7qC7HV6JyhQDa1Oq53Li9ajB2nF2Gu9ICA=;
        b=kMf/RUV/HVIMsWp9I2NqzC2T8Fl3zRsCFJJi15uZ14B8Xj7X9N6IHquo6esnlNU7PU
         d7wEJsVnmBungsjtXEcrTFumBs+x5Unq7MN3dBEUeeAp/lq2DFa2vJ9VuJIW3v2gYV72
         JC99G+gxIb8x2GAXYhS/WH3mTANaApVV0UpSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690317676; x=1690922476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDQQ0x4yX7qC7HV6JyhQDa1Oq53Li9ajB2nF2Gu9ICA=;
        b=F+ZzF6AogGXHo9C3q/p+o39uNkSDCgygfrWcRT2H5ej1Ho/elqveG1wHzeKSO7pOuN
         KbHTCA8z/95DlW/b/7406rpw5ov9kv+FyK8h/930WLOom3hutxnxYtrDNdVXIUyYlEjg
         31J/9TtIURN+0sN+iX0ueLx0BRpitWF8MUPvfvmSoUq0qlKVn9jjJt/SCKM2/4WmSAcR
         pHJzLo1PV46esQe+D+Ayn/j/obTVbkoU3t4rR+t6262LLawYBNx3NcsF+QeMdoEL0uWz
         LdHjN0jICrtTabAsiRTiIYg9yNwtaduQX+X2L9M7P9oZpypANMa3eizNJXDbd9sHbQNX
         rAPA==
X-Gm-Message-State: ABy/qLbumCFb1HdXqEivZVL90Y8tW2SZNXFc9hQ80ZePpjjkbXvhQiLH
        vqO6Wm4foxm9bGXsjWy23GtNDrIicxSvkw456K/UVITm
X-Google-Smtp-Source: APBJJlHZxrEX+P5YocZS7V55mO8FtA91WTuF8H6BdSdXr0t/Lhdj3obBNi4g6UnxP1Gr2zWWHJAUCw==
X-Received: by 2002:a17:906:dc:b0:994:673:8af6 with SMTP id 28-20020a17090600dc00b0099406738af6mr14602440eji.29.1690317675769;
        Tue, 25 Jul 2023 13:41:15 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id d25-20020a170906345900b0099251a40184sm8755688ejb.99.2023.07.25.13.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 13:41:15 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so3614a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 13:41:14 -0700 (PDT)
X-Received: by 2002:a50:ccc4:0:b0:521:d274:fc81 with SMTP id
 b4-20020a50ccc4000000b00521d274fc81mr183614edj.2.1690317674563; Tue, 25 Jul
 2023 13:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230607215224.2067679-1-dianders@chromium.org>
 <20230607144931.v2.8.Ib1a98309c455cd7e26b931c69993d4fba33bbe15@changeid>
 <y3l4x3kv7jgog3miexati5wbveaynnryzqvj6sc4ul6625f2if@w7nqgojfavfw>
 <CAD=FV=VbdeomBGbWhppY+5TOSwt64GWBHga68OXFwsnO4gg4UA@mail.gmail.com> <CAD=FV=UUdc5xi-HoOye-a1Oki3brcX3V1+=zuxQKLAcrd3iTSA@mail.gmail.com>
In-Reply-To: <CAD=FV=UUdc5xi-HoOye-a1Oki3brcX3V1+=zuxQKLAcrd3iTSA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jul 2023 13:41:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WmpH6cB0oZOxbL+TUxjLRf3PM+kKvuYRAZSiEhS4o37A@mail.gmail.com>
Message-ID: <CAD=FV=WmpH6cB0oZOxbL+TUxjLRf3PM+kKvuYRAZSiEhS4o37A@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] HID: i2c-hid: Support being a panel follower
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 17, 2023 at 11:15=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Benjamin,
>
> On Mon, Jun 26, 2023 at 3:49=E2=80=AFPM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Benjamin,
> >
> > On Thu, Jun 8, 2023 at 8:37=E2=80=AFAM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > > +static const struct drm_panel_follower_funcs i2c_hid_core_panel_fo=
llower_funcs =3D {
> > > > +     .panel_prepared =3D i2c_hid_core_panel_prepared,
> > > > +     .panel_unpreparing =3D i2c_hid_core_panel_unpreparing,
> > > > +};
> > >
> > > Can we make that above block at least behind a Kconfig?
> > >
> > > i2c-hid is often used for touchpads, and the notion of drm panel has
> > > nothing to do with them. So I'd be more confident if we could disable
> > > that code if not required.
> >
> > Now that other concerns are addressed, I started trying to write up a
> > v3 and I found myself writing this as the description of the Kconfig
> > entry:
> >
> > --
> > config I2C_HID_SUPPORT_PANEL_FOLLOWER
> > bool "Support i2c-hid devices that must be power sequenced with a panel=
"
> >
> > Say Y here if you want support for i2c-hid devices that need to
> > coordinate power sequencing with a panel. This is typically important
> > when you have a panel and a touchscreen that share power rails or
> > reset GPIOs. If you say N here then the kernel will not try to honor
> > any shared power sequencing for your hardware. In the best case,
> > ignoring power sequencing when it's needed will draw extra power. In
> > the worst case this will prevent your hardware from functioning or
> > could even damage your hardware.
> >
> > If unsure, say Y.
> >
> > --
> >
> > I can certainly go that way, but I just wanted to truly make sure
> > that's what we want. Specifically:
> >
> > 1. If we put the panel follower code behind a Kconfig then we actually
> > have no idea if a touchscreen was intended to be a panel follower.
> > Specifically the panel follower API is the one that detects the
> > connection between the panel and the i2c-hid device, so without being
> > able to call the panel follower API we have no idea that an i2c-hid
> > device was supposed to be a panel follower.
> >
> > 2. It is conceivable that power sequencing a device incorrectly could
> > truly cause hardware damage.
> >
> > Together, those points mean that if you turn off the Kconfig entry and
> > then try to boot on a device that needed that Kconfig setting that you
> > might damage hardware. I can code it up that way if you want, but it
> > worries me...
> >
> >
> > Alternatives that I can think of:
> >
> > a) I could change the panel follower API so that panel followers are
> > in charge of detecting the panel that they follow. Today, that looks
> > like:
> >
> >        panel_np =3D of_parse_phandle(dev->of_node, "panel", 0);
> >        if (panel_np)
> >                /* It's a panel follower */
> >        of_node_put(panel_np);
> >
> > ...so we could put that code in each touchscreen driver and then fail
> > to probe i2c-hid if we detect that we're supposed to be a panel
> > follower but the Kconfig is turned off. The above doesn't seem
> > massively ideal since it duplicates code. Also, one reason why I put
> > that code in drm_panel_add_follower() is that I think this concept
> > will eventually be needed even for non-DT cases. I don't know how to
> > write the non-DT code right now, though...
> >
> >
> > b) I could open-code detect the panel follower case but leave the
> > actual linking to the panel follower API. AKA add to i2c-hid:
> >
> >        if (of_property_read_bool(dev->of_node, "panel"))
> >                /* It's a panel follower */
> >
> > ...that's a smaller bit of code, but feels like an abstraction
> > violation. It also would need to be updated if/when we added support
> > for non-DT panel followers.
> >
> >
> > c) I could add a "static inline" implementation of b) to "drm_panel.h".
> >
> > That sounds great and I started doing it. ...but then realized that it
> > means adding to drm_panel.h:
> >
> > #include <linux/device.h>
> > #include <linux/of.h>
> >
> > ...because otherwise of_property_read_bool() isn't defined and "struct
> > device" can't be dereferenced. That might be OK, but it looks as if
> > folks have been working hard to avoid things like this in header
> > files. Presumably it would get uglier if/when we added the non-DT
> > case, as well. That being said, I can give it a shot...
> >
> > --
> >
> > At this point, I'm hoping for some advice. How important is it for you
> > to have a Kconfig for "I2C_HID_SUPPORT_PANEL_FOLLOWER"?
> >
> > NOTE: even if I don't add the Kconfig, I could at least create a
> > function for registering the panel follower that would get most of the
> > panel follower logic out of the probe function. Would that be enough?
>
> I'd love to send a new version of this patch series, but I'm still
> stuck with the above issue. I'm hoping you might have a minute to
> provide your thoughts. If I don't hear anything, I'll try a v3 where I
> don't have the Kconfig for "I2C_HID_SUPPORT_PANEL_FOLLOWER" but just
> try to pull a little more of the code out of the probe function.

To provide breadcrumbs, I posted the v3 which pulls a bit more code
out of the probe function but is otherwise largely unchanged. The
cover letter for v3 can be found at:

https://lore.kernel.org/r/20230725203545.2260506-1-dianders@chromium.org/
