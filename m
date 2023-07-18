Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DD75758A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 09:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjGRHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRHlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:41:32 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBF1706
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:41:14 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id ada2fe7eead31-4435508cff9so1434524137.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 00:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689666073; x=1692258073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W72tr0tg9BiWIz3zCp+YxWdsN0glxdmB5ZEHeCtkS6M=;
        b=i/hUMfu6HepcuHQ3zMsNlYXHoSo72/58+cK5AnuBtfhXhy8QCdRW4QXVJ2B66zYIU4
         1e2W0j1ei7QEnvHIXXzDT5HLuXgasDXiHazBEe+3+R+Plv5JcfZQ+a7667v4y8+Lt07S
         4Yl1pgfH28CSY9nZFFz6Y3ZC25FNhR5xmQnFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689666073; x=1692258073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W72tr0tg9BiWIz3zCp+YxWdsN0glxdmB5ZEHeCtkS6M=;
        b=CNrN1YOKzdkQOWzpop+RTtSs0LmYAOGVbPmkh3WIaVZuuS6JjGLlJx38FXZByco8Hx
         dYGc04HJyCNxV+lL0OJ1oc2e4RWl/+FmVQ7DlMbD5bVKjugbihLajHbkBJRaSjyfj4VI
         eCRfHpHw8YP76qTqBkhgAn8XlsThMt8l/dONuK06ebneCXCmiy5pQhAUl3QPeq0V3HPV
         n1FMFmOISNAarY6LZOpywz/BABOOl/JOERN2K6PTsRk0ZyfZHphw4/yQhmoCk+Pj2kgz
         Z2p3pw3JRpzeQUvb14Mdo21EoMrNxJcckMHtlcFSFTMFxfc6pPg4Irnhp5JXOSJgYwN3
         xN9Q==
X-Gm-Message-State: ABy/qLb5KiYG/RpARv/w5KBqRDXUwilchKqDk+K+ChaotTclk4+c7IxR
        yHaWGLIizPiq+T1mPgofuI2Uqphf4mKsLdO/lKsg3w==
X-Google-Smtp-Source: APBJJlE9uS2QtTlCAm7Z6lCr5REH2fuUUfHsmmkyKOVMYvSCBg65YttmdObOYTuNF4oYeVP9mxLHWObTwXcmPy2TfaU=
X-Received: by 2002:a67:e3d1:0:b0:445:2154:746b with SMTP id
 k17-20020a67e3d1000000b004452154746bmr791821vsm.4.1689666073558; Tue, 18 Jul
 2023 00:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230713090152.140060-1-angelogioacchino.delregno@collabora.com>
 <20230713090152.140060-2-angelogioacchino.delregno@collabora.com> <827cc3730c949e38eafd3786631135bcc7c7591c.camel@mediatek.com>
In-Reply-To: <827cc3730c949e38eafd3786631135bcc7c7591c.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 18 Jul 2023 15:41:02 +0800
Message-ID: <CAGXv+5Gj85Fnski5g9dssF+BQH27VVKwG+KXQkJRUCWozGnMeQ@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] drm/mediatek: dp: Move AUX and panel poweron/off
 sequence to function
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK,

On Tue, Jul 18, 2023 at 3:40=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89)=
 <ck.hu@mediatek.com> wrote:
>
> Hi, Angelo:
>
> On Thu, 2023-07-13 at 11:01 +0200, AngeloGioacchino Del Regno wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Everytime we run bridge detection and/or EDID read we run a poweron
> > and poweroff sequence for both the AUX and the panel; moreover, this
> > is also done when enabling the bridge in the .atomic_enable()
> > callback.
> >
> > Move this power on/off sequence to a new mtk_dp_aux_panel_poweron()
> > function as to commonize it.
> > Note that, before this commit, in mtk_dp_bridge_atomic_enable() only
> > the AUX was getting powered on but the panel was left powered off if
> > the DP cable wasn't plugged in while now we unconditionally send a D0
> > request and this is done for two reasons:
> >  - First, whether this request fails or not, it takes the same time
> >    and anyway the DP hardware won't produce any error (or, if it
> >    does, it's ignorable because it won't block further commands)
> >  - Second, training the link between a sleeping/standby/unpowered
> >    display makes little sense.
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

There is a v6 already.

> >
> > Signed-off-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dp.c | 76 ++++++++++++-----------------
> > --
> >  1 file changed, 30 insertions(+), 46 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c
> > b/drivers/gpu/drm/mediatek/mtk_dp.c
> > index 64eee77452c0..8b7ded1746f3 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> > @@ -1251,6 +1251,29 @@ static void mtk_dp_audio_mute(struct mtk_dp
> > *mtk_dp, bool mute)
> >                          val[2], AU_TS_CFG_DP_ENC0_P0_MASK);
> >  }
> >
> > +static void mtk_dp_aux_panel_poweron(struct mtk_dp *mtk_dp, bool
> > pwron)
> > +{
> > +     if (pwron) {
> > +             /* power on aux */
> > +             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > +                                DP_PWR_STATE_BANDGAP_TPLL_LANE,
> > +                                DP_PWR_STATE_MASK);
> > +
> > +             /* power on panel */
> > +             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D0);
> > +             usleep_range(2000, 5000);
> > +     } else {
> > +             /* power off panel */
> > +             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D3);
> > +             usleep_range(2000, 3000);
> > +
> > +             /* power off aux */
> > +             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > +                                DP_PWR_STATE_BANDGAP_TPLL,
> > +                                DP_PWR_STATE_MASK);
> > +     }
> > +}
> > +
> >  static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
> >  {
> >       mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
> > @@ -1936,16 +1959,9 @@ static enum drm_connector_status
> > mtk_dp_bdg_detect(struct drm_bridge *bridge)
> >       if (!mtk_dp->train_info.cable_plugged_in)
> >               return ret;
> >
> > -     if (!enabled) {
> > -             /* power on aux */
> > -             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -                                DP_PWR_STATE_BANDGAP_TPLL_LANE,
> > -                                DP_PWR_STATE_MASK);
> > +     if (!enabled)
> > +             mtk_dp_aux_panel_poweron(mtk_dp, true);
> >
> > -             /* power on panel */
> > -             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D0);
> > -             usleep_range(2000, 5000);
> > -     }
> >       /*
> >        * Some dongles still source HPD when they do not connect to
> > any
> >        * sink device. To avoid this, we need to read the sink count
> > @@ -1957,16 +1973,8 @@ static enum drm_connector_status
> > mtk_dp_bdg_detect(struct drm_bridge *bridge)
> >       if (DP_GET_SINK_COUNT(sink_count))
> >               ret =3D connector_status_connected;
> >
> > -     if (!enabled) {
> > -             /* power off panel */
> > -             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D3);
> > -             usleep_range(2000, 3000);
> > -
> > -             /* power off aux */
> > -             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -                                DP_PWR_STATE_BANDGAP_TPLL,
> > -                                DP_PWR_STATE_MASK);
> > -     }
> > +     if (!enabled)
> > +             mtk_dp_aux_panel_poweron(mtk_dp, false);
> >
> >       return ret;
> >  }
> > @@ -1982,15 +1990,7 @@ static struct edid *mtk_dp_get_edid(struct
> > drm_bridge *bridge,
> >
> >       if (!enabled) {
> >               drm_atomic_bridge_chain_pre_enable(bridge, connector-
> > >state->state);
> > -
> > -             /* power on aux */
> > -             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -                                DP_PWR_STATE_BANDGAP_TPLL_LANE,
> > -                                DP_PWR_STATE_MASK);
> > -
> > -             /* power on panel */
> > -             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D0);
> > -             usleep_range(2000, 5000);
> > +             mtk_dp_aux_panel_poweron(mtk_dp, true);
> >       }
> >
> >       new_edid =3D drm_get_edid(connector, &mtk_dp->aux.ddc);
> > @@ -2010,15 +2010,7 @@ static struct edid *mtk_dp_get_edid(struct
> > drm_bridge *bridge,
> >       }
> >
> >       if (!enabled) {
> > -             /* power off panel */
> > -             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D3);
> > -             usleep_range(2000, 3000);
> > -
> > -             /* power off aux */
> > -             mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -                                DP_PWR_STATE_BANDGAP_TPLL,
> > -                                DP_PWR_STATE_MASK);
> > -
> > +             mtk_dp_aux_panel_poweron(mtk_dp, false);
> >               drm_atomic_bridge_chain_post_disable(bridge, connector-
> > >state->state);
> >       }
> >
> > @@ -2178,15 +2170,7 @@ static void mtk_dp_bridge_atomic_enable(struct
> > drm_bridge *bridge,
> >               return;
> >       }
> >
> > -     /* power on aux */
> > -     mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
> > -                        DP_PWR_STATE_BANDGAP_TPLL_LANE,
> > -                        DP_PWR_STATE_MASK);
> > -
> > -     if (mtk_dp->train_info.cable_plugged_in) {
> > -             drm_dp_dpcd_writeb(&mtk_dp->aux, DP_SET_POWER,
> > DP_SET_POWER_D0);
> > -             usleep_range(2000, 5000);
> > -     }
> > +     mtk_dp_aux_panel_poweron(mtk_dp, true);
> >
> >       /* Training */
> >       ret =3D mtk_dp_training(mtk_dp);
> > --
> > 2.40.1
