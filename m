Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 021357BA7E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjJERYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjJERYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:24:01 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9877126A5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 10:18:57 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50444e756deso1683288e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696526336; x=1697131136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4qtwUC5OWXLWsxsdHc8Vyp8jChtnD5xWpTwtPZAf1Y=;
        b=aufTk7WgCjA2W81VlyHK3EPYXITg2dkKoyqNTSQCb9iKg/joGncbf3BUNz+NZgnVso
         H/gj+LxUhFqnfqGMWxuUkkfh/jIMY+h0DEd3JCckTTqEaXNBqfKBZ2qYtmBf/yRBhGZt
         oNqV4s6KCKVZpEDu7JKlyb0us1/JU43HH2SpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696526336; x=1697131136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K4qtwUC5OWXLWsxsdHc8Vyp8jChtnD5xWpTwtPZAf1Y=;
        b=gkm2V9esKuO6qzqEvaYWMOIAsEb3Tu25KUc7FHydXh0I09+HtLZjoF/ztE7Dy9doUy
         4zWf7fU8IRA2/ksiqN+UXMO9rYonCpq6OzZ+d2JzSvXVU4MGFAyKGOnLqyHk1KRjrCFY
         c0bwHE4GYFOg7o8/5aMeZJPWz4NnTic/nUNJFwNJhfNDINrtqUtCGxtj+Td7mdrGtrM5
         lORf338tUp6N3mlMZht21w93KqgTHo+xOGpNl/dcmlIEmxjqONl8q0sX7kf5K8W4P0wa
         SOGCAVoJVJ16mBBvunAT6Mu4McU0UK++4mUgNv17CifpygOn+BMC8p2YJT7s1MY2yid5
         HhfQ==
X-Gm-Message-State: AOJu0Yy84NmDpLHhuVRHttIwdBbrXt2yDEioQluMSP5eBz5ypQBCaWwA
        avRjNP25mx9fVI1TwQ7F5TlMBCW1f6sn+7eIzuMXSg==
X-Google-Smtp-Source: AGHT+IGz3dfXxzyBA3mj6bpkuScOj2CsByPZVzGVOuypWZVASQXSq77oLaNIiQZy12jlFuvTXd6MBb+9Nrb2xXw8Z0k=
X-Received: by 2002:a05:6512:2030:b0:503:258f:fd15 with SMTP id
 s16-20020a056512203000b00503258ffd15mr4793359lfs.20.1696526335763; Thu, 05
 Oct 2023 10:18:55 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Oct 2023 12:18:55 -0500
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U2dza-rxV=YtcfJwUY-gZw5FrCyn0NahOxvXJW2J2-vg@mail.gmail.com>
References: <20231002235407.769399-1-swboyd@chromium.org> <CAD=FV=U2dza-rxV=YtcfJwUY-gZw5FrCyn0NahOxvXJW2J2-vg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 5 Oct 2023 12:18:55 -0500
Message-ID: <CAE-0n51LJDgop-Nh+Aq1CTiu7xJZOqOsdSvHMmXzshkRKM3dgg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Associate DSI device lifetime
 with auxiliary device
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2023-10-02 17:31:41)
> Hi,
>
> On Mon, Oct 2, 2023 at 4:54=E2=80=AFPM Stephen Boyd <swboyd@chromium.org>=
 wrote:
> >
> > The kernel produces a warning splat and the DSI device fails to registe=
r
> > in this driver if the i2c driver probes, populates child auxiliary
> > devices, and then somewhere in ti_sn_bridge_probe() a function call
> > returns -EPROBE_DEFER. When the auxiliary driver probe defers, the dsi
> > device created by devm_mipi_dsi_device_register_full() is left
> > registered because the devm managed device used to manage the lifetime
> > of the DSI device is the parent i2c device, not the auxiliary device
> > that is being probed.
> >
> > Associate the DSI device created and managed by this driver to the
> > lifetime of the auxiliary device, not the i2c device, so that the DSI
> > device is removed when the auxiliary driver unbinds. Similarly change
> > the device pointer used for dev_err_probe() so the deferred probe error=
s
> > are associated with the auxiliary device instead of the parent i2c
> > device so we can narrow down future problems faster.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DS=
I device at probe")
>
> Even before that commit I think it was using the main "dev" instead of
> the auxiliary device's "dev" for some "devm" stuff. I guess the
> difference is that it wouldn't mess with probe deferral? Searching
> back, I think the first instance of a case that was using "devm_" with
> the wrong device was commit 4e5763f03e10 ("drm/bridge: ti-sn65dsi86:
> Wrap panel with panel-bridge")? Would it make sense to use that as a
> Fixes, you think?

The problem for me is that the dsi device is registered twice. That
happens because probe for the auxiliary device happens twice. I was
cautious about the fixes tag here because it didn't look like probe
deferral was happening before commit c3b75d4734cb.

>
> In any case, this looks reasonable to me:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll give it a week and then apply to "-fixes" if everything is quiet.

Thanks!
