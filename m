Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352AD7AEEB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjIZOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjIZOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:02:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7052101
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:02:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c16757987fso60657031fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695736934; x=1696341734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBohR+UrQgBr4N5azTZZcBABGSeyKmANhNOajTqGdkY=;
        b=QlTIuPGJUwV+exApiZ4B2+QkGTPuWsRTgzqym1nUxd4dLovvz+OWg4TYKU1QBHAfBD
         TNmGVQHqibsyiekSR8WqmG3dg0e5qw34miSQFJx1uB5PgSm76iZcmZOZ/XbKpVqi4/oS
         KCAem1sYeHEAMqtEWQ8fnvDWF5THBJwNl2Dmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695736934; x=1696341734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FBohR+UrQgBr4N5azTZZcBABGSeyKmANhNOajTqGdkY=;
        b=WYebAhuXBK5AmEEQsX/TAN7Ge9RtekZpK309kn1n03hy/YidC+QoXyz9jBHgs3d6Pr
         Dax5y4RJVfIqatMRNO9P9na5L21E9wZ2mydQKwrGh9vb2TixF45nddbPPJQRdqbCJxaa
         oSRdhmpfhH83lrpLGV7U+holvDA7lHGi0ZWmvtmt3DMSJ8NPLlOJy3X9NDKdH11SB4p5
         c60VU9xe1ZSd9WCghzwzIOnKvr8JOQzY8NKCSbvLyRNUFDgZDBWlyMKYT3Sd5VeZUXY7
         sbd1ROxtKp7T+EH5rfoBVEhbi219cMS3buqljeL0CydiWeUWGFYG/nniQXNqeDYG5Jb4
         UvRw==
X-Gm-Message-State: AOJu0Yy+uLk/1H27ax9db+F0ECfFV7kyi9OmnBpjBZChYSKNoZJRAyxf
        SBDxEJ4xev2BekoS4Guyc+uR3/txZH05Vd/X01R8Mv1o
X-Google-Smtp-Source: AGHT+IHNu16fsFXhtDi014RGasWwe9oBFfwHFiO8gNlEssuXg3qSh7COgsJNTu4vFoDmTaJw8p/FlA==
X-Received: by 2002:a2e:740d:0:b0:2bc:d582:e724 with SMTP id p13-20020a2e740d000000b002bcd582e724mr8160358ljc.31.1695736933960;
        Tue, 26 Sep 2023 07:02:13 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id r4-20020a2e80c4000000b002bba9a4f715sm2664778ljg.11.2023.09.26.07.02.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 07:02:13 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50348c54439so4763e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 07:02:13 -0700 (PDT)
X-Received: by 2002:ac2:548e:0:b0:501:a2b4:8ff5 with SMTP id
 t14-20020ac2548e000000b00501a2b48ff5mr54282lfk.7.1695736932511; Tue, 26 Sep
 2023 07:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230925150010.1.Iff672233861bcc4cf25a7ad0a81308adc3bda8a4@changeid>
 <b0037c9f-588b-4eb8-6415-0fe75bed264f@collabora.com>
In-Reply-To: <b0037c9f-588b-4eb8-6415-0fe75bed264f@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 Sep 2023 07:01:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UWQgLLfU4X+6OUR5AWOkJKwG9J7BbKGRCgze6LTY6JNw@mail.gmail.com>
Message-ID: <CAD=FV=UWQgLLfU4X+6OUR5AWOkJKwG9J7BbKGRCgze6LTY6JNw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>, airlied@gmail.com,
        daniel@ffwll.ch, jitao.shi@mediatek.com, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, neil.armstrong@linaro.org,
        quic_jesszhan@quicinc.com, sam@ravnborg.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 26, 2023 at 1:06=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/09/23 00:00, Douglas Anderson ha scritto:
> > In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
> > panel-simple") I moved a pile of panels out of panel-simple driver
> > into the newly created panel-edp driver. One of those panels, however,
> > shouldn't have been moved.
> >
> > As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
> > B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used in
> > exynos5250-snow and exynos5420-peach-pit where it's clear that the
> > panel is hooked up with LVDS. Furthermore, searching for datasheets I
> > found one that makes it clear that this panel is LVDS.
> >
> > As far as I can tell, I got confused because in commit 88d3457ceb82
> > ("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
> > Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
> > downstream ChromeOS trees, it seems like some Mediatek boards are
> > using a panel that they call "auo,b116xw03" that's an eDP panel. The
> > best I can guess is that they actually have a different panel that has
> > similar timing. If so then the proper panel should be used or they
> > should switch to the generic "edp-panel" compatible.
> >
> > When moving this back to panel-edp, I wasn't sure what to use for
> > .bus_flags and .bus_format and whether to add the extra "enable" delay
> > from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
> > backlight when power on"). I've added formats/flags/delays based on my
> > (inexpert) analysis of the datasheet. These are untested.
> >
> > NOTE: if/when this is backported to stable, we might run into some
> > trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
> > jacuzzi: Move panel under aux-bus") this panel was used by
> > "mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
> > know what to suggest for that other than someone making up a bogus
> > panel for jacuzzi that's just for the stable channel.
> >
> > Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when=
 power on")
> > Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simp=
le")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I haven't had a snow or peach-pit hooked up for debugging / testing
> > for years. I presume that they must be broken and hope that this fixes
> > them.
>
> We could avoid backport breakages by avoiding to backport this to any ker=
nel
> that doesn't contain commit 474c162878ba ("arm64: dts: mt8183: jacuzzi: M=
ove
> panel under aux-bus")... because creating a dummy panel to get two wrongs
> right is definitely not ok.

Sure, except that leaves us with ... a breakage. :-P

Although I haven't tested it, I have a hard time believing that
exynos5250-snow and exynos5420-peach-pit will work properly with the
panel defined as an eDP panel. That means that they will be broken. If
someone cared to get those fixed in a stable backport then we'd be
stuck deciding who to break. If you have any brilliant ideas then I'm
all ears.

...then again, I presume this has been broken since commit
88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when power
on"). That was a little over 3 years ago. Maybe I'm wrong and somehow
things still limp along and sorta work even though the panel is
defined incorrectly?

-Doug
