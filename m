Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A076E59F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234427AbjHCK1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjHCK0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:26:44 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4830CF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:26:15 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-56d0deeca09so102856eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691058375; x=1691663175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wmsqjYu8Hic2/c1lEsFgWL7MCohwxVWUEUlp/0nydPg=;
        b=LlG1FyIHjtgGtK1TV2Vjm/XFASEeQIgSeC3fIGrCJMNhXL8aulEoMxcM3C4GPNdv24
         BsYkaA/r/STR1NE8xmwlPZaHsYYwIn2EKf3E0vTJelBfMKm0YFkqPZw7IWm4liwID22+
         Q051xgqCIgNKCRGS4K+kjXd8Z5zboD8/oG+AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058375; x=1691663175;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wmsqjYu8Hic2/c1lEsFgWL7MCohwxVWUEUlp/0nydPg=;
        b=G93Y7iHSq40G+veBZjFajiamrLOmdtb9PsXHTIrU6C1gMb0L6YuVPtjASdGhUqIIn+
         c9yLrlNsd6vZG54dFAMeEHDoV9zOOTft22bPphbC2CcQGUe+96TK+M4T/zjYImFptYSA
         zc+IgYjuxZMGmffAbnIltSGFYOnLGBdPvmkuoZG22Vfjf+iUFhW4ZDCwzAqEjccCHfV/
         8HWVrqYDbkdzUvDw9AIz+iGvdiSX3wQpk0kbN7X2/F580Imayz9Fu44NXoxnSlkxeYcO
         FDl8NqXOUAXoJOOi45mXFKpLFXOBDujTiTGRBdJppgTJi1SKUEB0Yd9MRhBnyClLdK2N
         t8uA==
X-Gm-Message-State: ABy/qLarXXE+C7ve8O+YAB55kBFyQLlZcobYUZl/o4XtwZ13w/Xkme8C
        gjUCqidVKLHsODrc52K/yIb56PpH4lSNhpk2bpQdog==
X-Google-Smtp-Source: APBJJlFyz79omHdPpKsDB71EyTi2Dgqup+RBV1uEa9byNezWSasvQ/S/nF0uFWbYqihimOUk645zVciSHpSp73cDS0I=
X-Received: by 2002:a4a:cf14:0:b0:569:a08a:d9c5 with SMTP id
 l20-20020a4acf14000000b00569a08ad9c5mr11499116oos.0.1691058375079; Thu, 03
 Aug 2023 03:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230718-feature-lcd-panel-v1-0-e9a85d5374fd@wolfvision.net>
 <292c3e7d-82ea-2631-bd4b-ef747f56287c@linaro.org> <ekmwiy3iuvtqtb6hwjbba2ia3aemt3dxmx6dj3zh6ljfmuim4w@4jzhqdenxth4>
 <ZMtqraOyGN9JvVj9@phenom.ffwll.local> <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
In-Reply-To: <qmwtcungahbe2bhty7v2rso2kf3vai6k47muwipifbybmi7o6s@oj6lngnhyhtg>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 3 Aug 2023 12:26:03 +0200
Message-ID: <CAKMK7uFbQURKYvB2JWnwZDEeA-qURpx_GFqR1FxgtuvK7jX4TA@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panel: sitronix-st7789v: add support for partial mode
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 at 11:22, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Thu, Aug 03, 2023 at 10:51:57AM +0200, Daniel Vetter wrote:
> > On Thu, Aug 03, 2023 at 10:48:57AM +0200, Maxime Ripard wrote:
> > > On Thu, Aug 03, 2023 at 10:11:22AM +0200, Neil Armstrong wrote:
> > > > Hi,
> > > >
> > > > On 18/07/2023 17:31, Michael Riesch wrote:
> > > > > Hi all,
> > > > >
> > > > > This series adds support for the partial display mode to the Sitronix
> > > > > ST7789V panel driver. This is useful for panels that are partially
> > > > > occluded by design, such as the Jasonic JT240MHQS-HWT-EK-E3. Support
> > > > > for this particular panel is added as well.
> > > > >
> > > > > Note: This series is already based on
> > > > > https://lore.kernel.org/lkml/20230714013756.1546769-1-sre@kernel.org/
> > > >
> > > > I understand Maxime's arguments, but by looking closely at the code,
> > > > this doesn't look like an hack at all and uses capabilities of the
> > > > panel controller to expose a smaller area without depending on any
> > > > changes or hacks on the display controller side which is coherent.
> > > >
> > > > Following's Daniel's summary we cannot compare it to TV overscan
> > > > because overscan is only on *some* displays, we can still get 100%
> > > > of the picture from the signal.
> > >
> > > Still disagree on the fact that it only affects some display. But it's
> > > not really relevant for that series.
> >
> > See my 2nd point, from a quick grep aside from i915 hdmi support, no one
> > else sets all the required hdmi infoframes correctly. Which means on a
> > compliant hdmi tv, you _should_ get overscan. That's how that stuff is
> > speced.
> >
> > Iirc you need to at least set both the VIC and the content type, maybe
> > even more stuff.
> >
> > Unless all that stuff is set I'd say it's a kms driver bug if you get
> > overscan on a hdmi TV.
>
> I have no doubt that i915 works there. The source of my disagreement is
> that if all drivers but one don't do that, then userspace will have to
> care. You kind of said it yourself, i915 is kind of the exception there.
>
> The exception can be (and I'm sure it is) right, but still, it deviates
> from the norm.

The right fix for these is sending the right infoframes, _not_ trying
to fiddle with overscan margins. Only the kernel can make sure the
right infoframes are sent out. If you try to paper over this in
userspace, you'll make the situation worse, not better (because
fiddling with overscan means you get scaling, and so rescaling
artifacts, and for hard contrasts along pixel lines that'll look like
crap).

So yeah this is a case of "most upstream hdmi drivers are broken".
Please don't try to fix kernel bugs in userspace.

> > > I think I'll still like to have something clarified before we merge it:
> > > if userspace forces a mode, does it contain the margins or not? I don't
> > > have an opinion there, I just think it should be documented.
> >
> > The mode comes with the margins, so if userspace does something really
> > funny then either it gets garbage (as in, part of it's crtc area isn't
> > visible, or maybe black bars on the screen), or the driver rejects it
> > (which I think is the case for panels, they only take their mode and
> > nothing else).
>
> Panels can usually be quite flexible when it comes to the timings they
> accept, and we could actually use that to our advantage, but even if we
> assume that they have a single mode, I don't think we have anything that
> enforces that, either at the framework or documentation levels?

Maybe more bugs? We've been slowly filling out all kinds of atomic kms
validation bugs in core/helper code because as a rule of thumb,
drivers get it wrong. Developers test until things work, then call it
good enough, and very few driver teams make a serious effort in trying
to really validate all invalid input. Because doing that is an
enormous amount of work.

I think for clear-cut cases like drm_panel the fix is to just put more
stricter validation into shared code (and then if we break something,
figure out how we can be sufficiently lenient again).
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
