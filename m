Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE977FB084
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjK1DR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjK1DR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:17:26 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE0B1A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:17:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507adc3381cso6784757e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 19:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701141451; x=1701746251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wp5HnTgZ7ZLaUo9Q/M6nPjzjSUwa62T1Maa/se+gxo=;
        b=GCE1tbom4VZVtXggtsvtDWpOcEnOtsgdvyX3yQ6ThIGTOahY7NdeIk+yeMDd4wxYs3
         SMyY7XM42bVAxISb/T84dVrZCDJnkuEzYNebwrGEvgEIh8c+wcRX1jAh3Izpwg63BRV1
         EiWYfu+vCWwzF5fguP8KDdNesyS7D+PQTRIaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701141451; x=1701746251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wp5HnTgZ7ZLaUo9Q/M6nPjzjSUwa62T1Maa/se+gxo=;
        b=ZBTV5mKV3ckliywIVC2+Ee42UbZEFZMjZyDMx4olKtzQvoRjWcM4z+YxtBXsLj7tJn
         deuogJ47P3hnc7PnWGqX0ajfJWDT/TANRLvNL8r0LO1jXIc7zMzHTLwrd/ZoIxKUKY4p
         IElRz/yiV7b8nPBaqkmdZ+PY5j0Cx6YybQJWBOKTCtmVwbSgsCtKvvKoOb7QY27jaw3I
         pec72ct53cd9e23g/bALDB9sVvwhCmCC70+D+KpBueKHwDbOcp3eVPyAZnQ9aDcAbht4
         8bRfENgj1l6jDMPCGmE0t5xxIAu+SrdafuAgHgSarK+SmZCG2WDNUQFhJX67lcKcdoQy
         BuIQ==
X-Gm-Message-State: AOJu0YwqKJoPrZU3KsFQxFA+T2Ul3HoMQDSFp7WRl/CunYNdOGYkMSWr
        XmXn2YW3tLfFNcdm2BXOk7q8U77auF/5E2UNB8KLgg==
X-Google-Smtp-Source: AGHT+IGSvCVqHokq1V085rudx0pq9tIghj1AHgkp2YjyyUW/OKHrDERsAUTAxkQUm4r6WUQntkQt94tB1L8sdCreRbM=
X-Received: by 2002:a05:6512:3585:b0:500:d4d9:25b5 with SMTP id
 m5-20020a056512358500b00500d4d925b5mr7469216lfr.56.1701141451084; Mon, 27 Nov
 2023 19:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20230730180803.22570-1-jiaxin.yu@mediatek.com>
 <20230730180803.22570-4-jiaxin.yu@mediatek.com> <c35ef2d8-ab40-484b-9a4c-38f2f3e7d99c@collabora.com>
In-Reply-To: <c35ef2d8-ab40-484b-9a4c-38f2f3e7d99c@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 28 Nov 2023 11:17:20 +0800
Message-ID: <CAGXv+5G2tP9i8VrUc6-xs2d72_nL9XH9iSCeixzA2AM7X5fXOQ@mail.gmail.com>
Subject: Re: [v3 3/3] drm/bridge: it6505: Add audio support
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com,
        kuninori.morimoto.gx@renesas.com, nfraprado@collabora.com,
        alsa-devel@alsa-project.org, chunxu.li@mediatek.com,
        allen-kh.cheng@mediatek.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        ajye_huang@compal.corp-partner.google.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 8:54=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 30/07/23 20:08, Jiaxin Yu ha scritto:
> > Add audio support for it6505
> >
> > 1. Bridge to hdmi-codec to support audio feature. At the same time,
> >     the function of automatically detecting audio is removed.
> > 2. It is observed that some DP-to-HDMI dongles will get into bad
> >     states if sending InfoFrame without audio data. Defer to enable
> >     it6505's audio feature when PCM triggers START or RESUME.
> >
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
>
> Hello Jiaxin,
> this patch doesn't apply anymore (and it won't build anymore) upstream.
>
> > ---
> >   drivers/gpu/drm/bridge/ite-it6505.c | 81 ++++++++++++++++++++++++++--=
-
> >   1 file changed, 75 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/brid=
ge/ite-it6505.c
> > index 504d51c42f79..1cfcb0731288 100644
> > --- a/drivers/gpu/drm/bridge/ite-it6505.c
> > +++ b/drivers/gpu/drm/bridge/ite-it6505.c
> > @@ -2162,7 +2162,6 @@ static void it6505_stop_link_train(struct it6505 =
*it6505)
> >
> >   static void it6505_link_train_ok(struct it6505 *it6505)
> >   {
> > -     struct device *dev =3D &it6505->client->dev;
>
> This is because this changed to `struct device *dev =3D it6505->dev;`
>
> >
> >       it6505->link_state =3D LINK_OK;
> >       /* disalbe mute enable avi info frame */
> > @@ -2170,11 +2169,6 @@ static void it6505_link_train_ok(struct it6505 *=
it6505)
> >       it6505_set_bits(it6505, REG_INFOFRAME_CTRL,
> >                       EN_VID_CTRL_PKT, EN_VID_CTRL_PKT);
> >
> > -     if (it6505_audio_input(it6505)) {
> > -             DRM_DEV_DEBUG_DRIVER(dev, "Enable audio!");
> > -             it6505_enable_audio(it6505);
> > -     }
> > -
> >       if (it6505->hdcp_desired)
> >               it6505_start_hdcp(it6505);
> >   }
> > @@ -2846,6 +2840,45 @@ static void __maybe_unused it6505_audio_shutdown=
(struct device *dev, void *data)
> >               it6505_disable_audio(it6505);
> >   }
> >
> > +static int it6505_audio_hw_params(struct device *dev, void *data,
> > +                               struct hdmi_codec_daifmt *daifmt,
> > +                               struct hdmi_codec_params *params)
> > +{
> > +     struct it6505 *it6505 =3D dev_get_drvdata(dev);
> > +
> > +     return it6505_audio_setup_hw_params(it6505, params);
> > +}
> > +
> > +static int it6505_audio_setup_trigger(struct it6505 *it6505, int cmd)
> > +{
> > +     struct device *dev =3D &it6505->client->dev;
>
> ...and because you'll have to change this one, and other occurrences of t=
hat
> as well.
>
> Can you please respin this series?

Please also add a patch adding #sound-dai-cells to the it6505 binding.
