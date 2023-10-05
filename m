Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8C37BA8CE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjJESMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjJESLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:11:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615331A3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:11:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9936b3d0286so242151666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696529475; x=1697134275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1eAmFswOZzw3jH3oWLXVAcDuqGgICG6iPkOHsm6WtUk=;
        b=nQEuUKf49LJCS/U8P9SeaGkuUPWON4esVwLhUFKG/3OOwu7/7kwOPe/0xq0TaFsp/5
         6BJMkRdtlkSafdmYVjw2jKvQehzkz+RIwuIndz8/xMrhgm9o0/twtg8Yi6WgWYL4qfVz
         3nmkoVt0PumfUJOdEzrnGlIDD7EUCkEu95FC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696529475; x=1697134275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1eAmFswOZzw3jH3oWLXVAcDuqGgICG6iPkOHsm6WtUk=;
        b=umHIgYgNNeApMjW8EtFzCjFmExs2EQ9ub+txG8BTqtXjUgmLKhUkG/4HM1/dUnOhCi
         rMiBCZOSGwREWIuju6g+Gq72dOcWsCSjxkB2iU9c5/w4YMpaEWctC2Piksy+tuyTeDV4
         8ePIbesEHWP6g5B4V8Kc4mhOxf3lLh295SsQo+tDcLITaNVJrLjNS/S+2h0/yWg8PwgV
         zCCRd3gkgtHKrz6RZUrmvgl4jRETnzTDPhuOXX+sOEw/vLv9OnBpbRSoiq4+lG2m+AU4
         p+5VqtjUu9sHBSCxAABMP+KN7DEhGMoCgjVqXQBKzthSIBYwrhGxtaWLDlwxxvHvXdU8
         kobg==
X-Gm-Message-State: AOJu0Yxhdc/ucY4VZiGUAC3zIBK4zqD6RXRsnmP2nVH2a4AqfpTgwQES
        ZPE7t+axI9IEozXIZAAT7sTHFx7ls+EtpsBeDhJzfyjR
X-Google-Smtp-Source: AGHT+IELGeB78CaAuRk6KalyAoAxiBHRJ1QLH+gr6obWZY9Wz9EWa8f/Z7ZIlc8ZXQ8e4tMtHzvTLg==
X-Received: by 2002:a17:907:2cf6:b0:9b2:ccd8:2d3d with SMTP id hz22-20020a1709072cf600b009b2ccd82d3dmr5065912ejc.26.1696529475198;
        Thu, 05 Oct 2023 11:11:15 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id la8-20020a170906ad8800b0099cce6f7d50sm1553261ejb.64.2023.10.05.11.11.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 11:11:14 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4063bfc6c03so13455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:11:14 -0700 (PDT)
X-Received: by 2002:a1c:4b18:0:b0:405:320a:44f9 with SMTP id
 y24-20020a1c4b18000000b00405320a44f9mr82899wma.5.1696529473685; Thu, 05 Oct
 2023 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230925150010.1.Iff672233861bcc4cf25a7ad0a81308adc3bda8a4@changeid>
 <b0037c9f-588b-4eb8-6415-0fe75bed264f@collabora.com> <CAD=FV=UWQgLLfU4X+6OUR5AWOkJKwG9J7BbKGRCgze6LTY6JNw@mail.gmail.com>
In-Reply-To: <CAD=FV=UWQgLLfU4X+6OUR5AWOkJKwG9J7BbKGRCgze6LTY6JNw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 5 Oct 2023 11:10:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UqG6DiAyjcLKeoUWKutepGd46Zx=8O-NWKoYC-fZEG6g@mail.gmail.com>
Message-ID: <CAD=FV=UqG6DiAyjcLKeoUWKutepGd46Zx=8O-NWKoYC-fZEG6g@mail.gmail.com>
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
        quic_jesszhan@quicinc.com, sam@ravnborg.org,
        Anton Bambura <jenneron@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 26, 2023 at 7:01=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Sep 26, 2023 at 1:06=E2=80=AFAM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
> >
> > Il 26/09/23 00:00, Douglas Anderson ha scritto:
> > > In commit 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of
> > > panel-simple") I moved a pile of panels out of panel-simple driver
> > > into the newly created panel-edp driver. One of those panels, however=
,
> > > shouldn't have been moved.
> > >
> > > As is clear from commit e35e305eff0f ("drm/panel: simple: Add AUO
> > > B116XW03 panel support"), AUX B116XW03 is an LVDS panel. It's used in
> > > exynos5250-snow and exynos5420-peach-pit where it's clear that the
> > > panel is hooked up with LVDS. Furthermore, searching for datasheets I
> > > found one that makes it clear that this panel is LVDS.
> > >
> > > As far as I can tell, I got confused because in commit 88d3457ceb82
> > > ("drm/panel: auo,b116xw03: fix flash backlight when power on") Jitao
> > > Shi added "DRM_MODE_CONNECTOR_eDP". That seems wrong. Looking at the
> > > downstream ChromeOS trees, it seems like some Mediatek boards are
> > > using a panel that they call "auo,b116xw03" that's an eDP panel. The
> > > best I can guess is that they actually have a different panel that ha=
s
> > > similar timing. If so then the proper panel should be used or they
> > > should switch to the generic "edp-panel" compatible.
> > >
> > > When moving this back to panel-edp, I wasn't sure what to use for
> > > .bus_flags and .bus_format and whether to add the extra "enable" dela=
y
> > > from commit 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash
> > > backlight when power on"). I've added formats/flags/delays based on m=
y
> > > (inexpert) analysis of the datasheet. These are untested.
> > >
> > > NOTE: if/when this is backported to stable, we might run into some
> > > trouble. Specifically, before 474c162878ba ("arm64: dts: mt8183:
> > > jacuzzi: Move panel under aux-bus") this panel was used by
> > > "mt8183-kukui-jacuzzi", which assumed it was an eDP panel. I don't
> > > know what to suggest for that other than someone making up a bogus
> > > panel for jacuzzi that's just for the stable channel.
> > >
> > > Fixes: 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight wh=
en power on")
> > > Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-si=
mple")
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > > I haven't had a snow or peach-pit hooked up for debugging / testing
> > > for years. I presume that they must be broken and hope that this fixe=
s
> > > them.
> >
> > We could avoid backport breakages by avoiding to backport this to any k=
ernel
> > that doesn't contain commit 474c162878ba ("arm64: dts: mt8183: jacuzzi:=
 Move
> > panel under aux-bus")... because creating a dummy panel to get two wron=
gs
> > right is definitely not ok.
>
> Sure, except that leaves us with ... a breakage. :-P
>
> Although I haven't tested it, I have a hard time believing that
> exynos5250-snow and exynos5420-peach-pit will work properly with the
> panel defined as an eDP panel. That means that they will be broken. If
> someone cared to get those fixed in a stable backport then we'd be
> stuck deciding who to break. If you have any brilliant ideas then I'm
> all ears.
>
> ...then again, I presume this has been broken since commit
> 88d3457ceb82 ("drm/panel: auo,b116xw03: fix flash backlight when power
> on"). That was a little over 3 years ago. Maybe I'm wrong and somehow
> things still limp along and sorta work even though the panel is
> defined incorrectly?

I dug out a exynos5250-snow out of my pile and booted postmarket OS on
it, which was shockingly easy/pleasant (kudos to those involved!). I
found that it was booting a kernel based on 6.1.24. Digging into
sysfs, I found that indeed it appeared to be using the "panel-edp"
driver, so I guess it is limping along with the wrong driver and wrong
flags...

It wasn't totally clear for me how to build a new kernel and deploy it
for postmarket OS, so I wasn't able to confirm this change. I've CCed
the person listed on the postmarket OS wiki though to see if they have
any insight.

In any case, it sounds as if things are working well enough on older
OSes, so maybe we can just skip trying to do any stable backport on
this. It still seems like we should land it, though, since the current
state of the world seems pretty broken. Anyone willing to give a
Reviewed-by or Acked-by tag?

-Doug
