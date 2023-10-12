Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB957C7355
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379542AbjJLQoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbjJLQoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:44:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F723C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:44:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a645e54806so183904366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697129055; x=1697733855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z24YZGqTCXcSjZw7pVvFeMUQZsyzVXoHF/bkKgAPfjE=;
        b=SHwx79G3UQqzyVKeli6auhjv9NNPiTFdyyE7DBEMjaTw5VO6E8GtEZysztWDc4lX9c
         HWVKp7XTYvTXLs17uy2HXZNEOIdpuxYdpbCZWKOxmVq0PNgCkwy/qLvusznTk/qdfyIF
         2WufDQOfkIFhfpWVsHrrgA5L9pGZB6iQxDZPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129055; x=1697733855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z24YZGqTCXcSjZw7pVvFeMUQZsyzVXoHF/bkKgAPfjE=;
        b=RRY4VlJHuu7FcPS9AkYbTeMmwcyoEbJK802i0yNKAf2pEJbOTeaN1qKaBmUPQ7AiSY
         wWkf6RHTSWiWH55OJtDBtNcKcMgHNSkxhKxq5uIC6hrsOqANyBmX+V3PcxvdfmaLXjD8
         pdP0tHEpzubuW1wGfmsIr6ZbmgSMYXqPNZKMfRuIf9YEQEbJHAu8xKkFval9xjbBJcdQ
         QUH2jxzNZ8QrZABdtFd2RJzn3hIL4JGcrZ7EsxQQNZOJbjByVU+twBu8aBkd9o8kh2Mo
         9/IsXg/PWoiyYnQ2c1QKEf+se5U0ewG6qW+QtdQICz56dNN8iblg67pY2wqr/K3nVvQT
         fhtA==
X-Gm-Message-State: AOJu0YwldyDINN6XkZXL7DdgLKf6EGB1IRHl41qOT4lw4DC7/3otrYQv
        bimI9BSSnR5jKptwDmpKGHfxlB7soYzgiT80ZiJ0Sw==
X-Google-Smtp-Source: AGHT+IFNhUVzZmoTaG2p3tfSXlhtC+Z9xwJeyS7ogJzXsZPBSod1NdgV76OJwD+Ydmz4bPy/kLLzNg==
X-Received: by 2002:a17:906:1d:b0:9ae:505d:310b with SMTP id 29-20020a170906001d00b009ae505d310bmr22063887eja.39.1697129055061;
        Thu, 12 Oct 2023 09:44:15 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id a24-20020a170906685800b009828e26e519sm11215406ejs.122.2023.10.12.09.44.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 09:44:14 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-405459d9a96so1855e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:44:14 -0700 (PDT)
X-Received: by 2002:a05:600c:1d10:b0:404:7462:1f87 with SMTP id
 l16-20020a05600c1d1000b0040474621f87mr293864wms.6.1697129053819; Thu, 12 Oct
 2023 09:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231002235407.769399-1-swboyd@chromium.org> <CAD=FV=U2dza-rxV=YtcfJwUY-gZw5FrCyn0NahOxvXJW2J2-vg@mail.gmail.com>
 <CAE-0n51LJDgop-Nh+Aq1CTiu7xJZOqOsdSvHMmXzshkRKM3dgg@mail.gmail.com>
In-Reply-To: <CAE-0n51LJDgop-Nh+Aq1CTiu7xJZOqOsdSvHMmXzshkRKM3dgg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Oct 2023 09:43:57 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UGP9L341iDd44rUPKf_jZ5Y6qodPKZ_BLgMq-HnkBmbQ@mail.gmail.com>
Message-ID: <CAD=FV=UGP9L341iDd44rUPKf_jZ5Y6qodPKZ_BLgMq-HnkBmbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
 with auxiliary device
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 5, 2023 at 10:18=E2=80=AFAM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Doug Anderson (2023-10-02 17:31:41)
> > Hi,
> >
> > On Mon, Oct 2, 2023 at 4:54=E2=80=AFPM Stephen Boyd <swboyd@chromium.or=
g> wrote:
> > >
> > > The kernel produces a warning splat and the DSI device fails to regis=
ter
> > > in this driver if the i2c driver probes, populates child auxiliary
> > > devices, and then somewhere in ti_sn_bridge_probe() a function call
> > > returns -EPROBE_DEFER. When the auxiliary driver probe defers, the ds=
i
> > > device created by devm_mipi_dsi_device_register_full() is left
> > > registered because the devm managed device used to manage the lifetim=
e
> > > of the DSI device is the parent i2c device, not the auxiliary device
> > > that is being probed.
> > >
> > > Associate the DSI device created and managed by this driver to the
> > > lifetime of the auxiliary device, not the i2c device, so that the DSI
> > > device is removed when the auxiliary driver unbinds. Similarly change
> > > the device pointer used for dev_err_probe() so the deferred probe err=
ors
> > > are associated with the auxiliary device instead of the parent i2c
> > > device so we can narrow down future problems faster.
> > >
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Cc: Maxime Ripard <maxime@cerno.tech>
> > > Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our =
DSI device at probe")
> >
> > Even before that commit I think it was using the main "dev" instead of
> > the auxiliary device's "dev" for some "devm" stuff. I guess the
> > difference is that it wouldn't mess with probe deferral? Searching
> > back, I think the first instance of a case that was using "devm_" with
> > the wrong device was commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86:
> > Wrap panel with panel-bridge")? Would it make sense to use that as a
> > Fixes, you think?
>
> The problem for me is that the dsi device is registered twice. That
> happens because probe for the auxiliary device happens twice. I was
> cautious about the fixes tag here because it didn't look like probe
> deferral was happening before commit c3b75d4734cb.
>
> >
> > In any case, this looks reasonable to me:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> >
> > I'll give it a week and then apply to "-fixes" if everything is quiet.
>
> Thanks!

Pushed to drm-misc-fixes leaving your existing "Fixes" line:

7b821db95140 drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
with auxiliary device

-Doug
