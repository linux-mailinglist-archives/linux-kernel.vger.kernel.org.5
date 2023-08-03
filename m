Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2376ED44
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjHCOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjHCOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:55:47 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD91728
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:55:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94ea38c90ccso28556466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691074544; x=1691679344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mlirwl0bkHM2riavE8GsJIkOTqsTSTy4yuuyAhKnAo=;
        b=dXcMVKZ263XM80AEP96Op45kPHn2B0z7632FrqP2dpNskATpF+7o/TLVLGiZ9ATXYY
         OSXR6ZsnU8GpH6OYseVc7B4N/q9CQbm1By39X7X5z7a7wXau02SsGlaE3PBl4GFscQK6
         edH0MGrDaYySh3+zRj/OHNfHuICnMBm+1+Usc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691074544; x=1691679344;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mlirwl0bkHM2riavE8GsJIkOTqsTSTy4yuuyAhKnAo=;
        b=Lu60O72yBkqaQt+cmlI45btlWlfOKxxykCnSJdISXmww7v8PovvnbmRTuo2j9nq6bk
         6o6Lpy35ChzeQabazeg9CXQnC5oRLFb8/Vwhgsp2LbmSaQVKQh2PD0TmXtrOuZcfQg82
         pZG4923VoB+zIIQBcZIl2ADBPVsId+9kI2Or23j8aGeNluYu4BKrPeonVWoauLnc0wMn
         Dpcr1TRzUavpQ2uqg1EFLXbTut4p4TTmZfBQil54NpqShTmEQmGgKc3q12Wc17/PK/pZ
         +W3ZLCqQcZDiofOLZEBxjX5/FLzmgpmIkIZieDS1f25hdI4qE6Q5l581+qlgRrDNf82m
         faow==
X-Gm-Message-State: ABy/qLaV4B91N1JjTN58AUcnjAWGX912xwLwDwmKcw5ah95oQc7h1N4b
        dxXmXXiRV4+5wq6pJr6ScJPf0w==
X-Google-Smtp-Source: APBJJlHmkF1RcJMqyHh/L6fwZfWL4t0iAsi7uo+0RzF5aZvjdZDTsxLeQhB63n9BKAKqMFbVtvvGUw==
X-Received: by 2002:a17:906:10da:b0:987:115d:ba06 with SMTP id v26-20020a17090610da00b00987115dba06mr12074936ejv.4.1691074543899;
        Thu, 03 Aug 2023 07:55:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709067f8f00b00985ed2f1584sm10620124ejr.187.2023.08.03.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:55:43 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:55:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        David Airlie <airlied@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial
 mode
Message-ID: <ZMu/7MwflSHmQUQX@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sam Ravnborg <sam@ravnborg.org>, Sebastian Reichel <sre@kernel.org>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        David Airlie <airlied@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org>
 <ekmwiy3iuvtqtb6hwjbba2ia3aemt3dxmx6dj3zh6ljfmuim4w@4jzhqdenxth4>
 <ZMtqraOyGN9JvVj9@phenom.ffwll.local>
 <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
 <CAKMK7uFbQURKYvB2JWnwZDEeA-qURpx_GFqR1FxgtuvK7jX4TA@mail.gmail.com>
 <d2sgj2iap4ouu425buqkorx76kpdqh77k3z36vaegma67pciyv@n3mbiglfidxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2sgj2iap4ouu425buqkorx76kpdqh77k3z36vaegma67pciyv@n3mbiglfidxx>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 01:43:08PM +0200, Maxime Ripard wrote:
> On Thu, Aug 03, 2023 at 12:26:03PM +0200, Daniel Vetter wrote:
> > On Thu, 3 Aug 2023 at 11:22, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > On Thu, Aug 03, 2023 at 10:51:57AM +0200, Daniel Vetter wrote:
> > > > On Thu, Aug 03, 2023 at 10:48:57AM +0200, Maxime Ripard wrote:
> > > > > On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On 18/07/2023 17:31, Michael Riesch wrote:
> > > > > > > Hi all,
> > > > > > >
> > > > > > > This series adds support for the partial display mode to the Sitronix
> > > > > > > ST7789V panel driver. This is useful for panels that are partially
> > > > > > > occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> > > > > > > for this particular panel is added as well.
> > > > > > >
> > > > > > > Note: This series is already based on
> > > > > > > https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
> > > > > >
> > > > > > I understand Maxime's arguments, but by looking closely at the code,
> > > > > > this doesn't look like an hack at all and uses capabilities of the
> > > > > > panel controller to expose a smaller area without depending on any
> > > > > > changes or hacks on the display controller side which is coherent.
> > > > > >
> > > > > > Following's Daniel's summary we cannot compare it to TV overscan
> > > > > > because overscan is only on *some* displays, we can still get 100%
> > > > > > of the picture from the signal.
> > > > >
> > > > > Still disagree on the fact that it only affects some display. But it's
> > > > > not really relevant for that series.
> > > >
> > > > See my 2nd point, from a quick grep aside from i915 hdmi support, no one
> > > > else sets all the required hdmi infoframes correctly. Which means on a
> > > > compliant hdmi tv, you _should_ get overscan. That's how that stuff is
> > > > speced.
> > > >
> > > > Iirc you need to at least set both the VIC and the content type, maybe
> > > > even more stuff.
> > > >
> > > > Unless all that stuff is set I'd say it's a kms driver bug if you get
> > > > overscan on a hdmi TV.
> > >
> > > I have no doubt that i915 works there. The source of my disagreement is
> > > that if all drivers but one don't do that, then userspace will have to
> > > care. You kind of said it yourself, i915 is kind of the exception there.
> > >
> > > The exception can be (and I'm sure it is) right, but still, it deviates
> > > from the norm.
> > 
> > The right fix for these is sending the right infoframes, _not_ trying
> > to fiddle with overscan margins. Only the kernel can make sure the
> > right infoframes are sent out. If you try to paper over this in
> > userspace, you'll make the situation worse, not better (because
> > fiddling with overscan means you get scaling, and so rescaling
> > artifacts, and for hard contrasts along pixel lines that'll look like
> > crap).
> > 
> > So yeah this is a case of "most upstream hdmi drivers are broken".
> > Please don't try to fix kernel bugs in userspace.
> 
> ACK.
> 
> > > > > I think I'll still like to have something clarified before we merge it:
> > > > > if userspace forces a mode, does it contain the margins or not? I don't
> > > > > have an opinion there, I just think it should be documented.
> > > >
> > > > The mode comes with the margins, so if userspace does something really
> > > > funny then either it gets garbage (as in, part of it's crtc area isn't
> > > > visible, or maybe black bars on the screen), or the driver rejects it
> > > > (which I think is the case for panels, they only take their mode and
> > > > nothing else).
> > >
> > > Panels can usually be quite flexible when it comes to the timings they
> > > accept, and we could actually use that to our advantage, but even if we
> > > assume that they have a single mode, I don't think we have anything that
> > > enforces that, either at the framework or documentation levels?
> > 
> > Maybe more bugs? We've been slowly filling out all kinds of atomic kms
> > validation bugs in core/helper code because as a rule of thumb,
> > drivers get it wrong. Developers test until things work, then call it
> > good enough, and very few driver teams make a serious effort in trying
> > to really validate all invalid input. Because doing that is an
> > enormous amount of work.
> > 
> > I think for clear-cut cases like drm_panel the fix is to just put more
> > stricter validation into shared code (and then if we break something,
> > figure out how we can be sufficiently lenient again).
> 
> Panels are kind of weird, since they essentially don't exist at all in
> the framework so it's difficult to make it handle them or their state.
> 
> It's typically handled by encoders directly, so each and every driver
> would need to make that check, and from a quick grep, none of them are
> (for the reasons you said).

I think the panel bridge driver infra is the right spot to put this, and
then push drivers a bit more towards using that.

Because yeah if they hand-roll the panel integration, they'll probably
miss a lot of these details :-/
-Sima

> 
> Just like for HDMI, even though we can commit to changing those facts,
> it won't happen overnight, so to circle back to that series, I'd like a
> comment in the driver when the partial mode is enabled that if userspace
> ever pushes a mode different from the expected one, we'll add the margins.
> 
> That way, if and when we come back to it, we'll know what the original
> intent and semantics were.
> 
> Maxime



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
