Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C94757709
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjGRIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGRIuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:50:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C9CF7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:50:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7F7F614C4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47336C4339A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689670201;
        bh=tRxUGjHzdMRNxsqtXPPmao2+Um7MzStinRn6vhwmK3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SdlRtdnP07pYXVTobZi7HP7g1NB8VokGrWO7PlSJZsF+qmStOKBTwFXr8as7ZbxyG
         H8/+SPqmBWoKH0KIpfX0BYU14DGGhrW9gGnX9pHYTSJgZXPLjsXP2vHn6duJB5xw6t
         J9Vvw57KBeXJScAaZ3o0mqjByTU3FK5lcihj3rkOiZaY6LmVynlmFlrJEPb0s0UYq8
         gW86z68am/npar1tNII5wRJw0Qqabl4Yo73ZTZip3ma1rG09hgLR0wMsXubDWsaLfz
         kry0FiEJQOmaALaPQN0RR4noqs1v6xkJMUNsyuljF+qIv8sbwCf3lMiJ+sOmbptl8+
         4Fy1SlGewrnLQ==
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3476c902f2aso26670755ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:50:01 -0700 (PDT)
X-Gm-Message-State: ABy/qLYgL+en1JDr2kGWNMSm6BwUCjjkROgD6gNts6GWmK+5dfl+8/H3
        tRpETKISAESOzrxQv4rejo811i6dJO0fnkTycFfOBg==
X-Google-Smtp-Source: APBJJlEjrkMkL6YQW10tWpvyxtSYCpxBJXwE+BKX6MekUeQHTyOoNhFQ1KzzT238MsAy1riC4d4HryxNeIhtdivNCYQ=
X-Received: by 2002:a05:6e02:1bae:b0:348:1a1d:79a5 with SMTP id
 n14-20020a056e021bae00b003481a1d79a5mr2270153ili.15.1689670200374; Tue, 18
 Jul 2023 01:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190716131005.761-1-bogdan.togorean@analog.com> <20230718084215.12767-1-alex@shruggie.ro>
In-Reply-To: <20230718084215.12767-1-alex@shruggie.ro>
From:   Robert Foss <rfoss@kernel.org>
Date:   Tue, 18 Jul 2023 10:49:48 +0200
X-Gmail-Original-Message-ID: <CAN6tsi5+WV65FSpuzjJY46beHU8SkOMYfZNS3DnXiVft_6MG4A@mail.gmail.com>
Message-ID: <CAN6tsi5+WV65FSpuzjJY46beHU8SkOMYfZNS3DnXiVft_6MG4A@mail.gmail.com>
Subject: Re: [PATCH v3] drm: adv7511: Fix low refresh rate register for ADV7533/5
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bogdan.togorean@analog.com, nuno.sa@analog.com, daniel@ffwll.ch,
        airlied@gmail.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
        andrzej.hajda@intel.com, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:42=E2=80=AFAM Alexandru Ardelean <alex@shruggie.=
ro> wrote:
>
> From: Bogdan Togorean <bogdan.togorean@analog.com>
>
> For ADV7533 and ADV7535 low refresh rate is selected using
> bits [3:2] of 0x4a main register.
> So depending on ADV model write 0xfb or 0x4a register.
>
> Fixes: 2437e7cd88e8 ("drm/bridge: adv7533: Initial support for ADV7533")
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>
> Changelog v2 -> v3:
> * https://lore.kernel.org/dri-devel/1c3fde3a873b0f948d3c4d37107c5bb67dc9f=
7bb.camel@gmail.com/T/#u
> * Added my S-o-b tag back
>
> Changelog v1 -> v2:
> * https://lore.kernel.org/dri-devel/20190716131005.761-1-bogdan.togorean@=
analog.com/
> * added Fixes: tag
> * added Reviewed-by: tag for Nuno
>
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index ddceafa7b637..09290a377957 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -786,8 +786,13 @@ static void adv7511_mode_set(struct adv7511 *adv7511=
,
>         else
>                 low_refresh_rate =3D ADV7511_LOW_REFRESH_RATE_NONE;
>
> -       regmap_update_bits(adv7511->regmap, 0xfb,
> -               0x6, low_refresh_rate << 1);
> +       if (adv7511->type =3D=3D ADV7511)
> +               regmap_update_bits(adv7511->regmap, 0xfb,
> +                       0x6, low_refresh_rate << 1);
> +       else
> +               regmap_update_bits(adv7511->regmap, 0x4a,
> +                       0xc, low_refresh_rate << 2);
> +
>         regmap_update_bits(adv7511->regmap, 0x17,
>                 0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
>
> --
> 2.41.0
>

This looks good, but I'm seeing some checkpatch style warnings, with
those fixed feel free to add my r-b.

CHECK: Alignment should match open parenthesis
#32: FILE: drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:791:
+        regmap_update_bits(adv7511->regmap, 0xfb,
+            0x6, low_refresh_rate << 1);

CHECK: Alignment should match open parenthesis
#35: FILE: drivers/gpu/drm/bridge/adv7511/adv7511_drv.c:794:
+        regmap_update_bits(adv7511->regmap, 0x4a,
+            0xc, low_refresh_rate << 2);

total: 0 errors, 0 warnings, 2 checks, 15 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplac=
e.

Commit 1955dfe734e4 ("drm: adv7511: Fix low refresh rate register for
ADV7533/5") has style problems, please review.

NOTE: If any of the errors are false positives, please report
