Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3137F6B76
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 05:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjKXEkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 23:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXEke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 23:40:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9561BE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:40:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50a6ff9881fso2265457e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 20:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700800838; x=1701405638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KekUES4QEaW3T6OzwXPRLAJ7BoFDfNAQJ2uK8ftZs4=;
        b=iJuQ7g9pO3pyAMTdoNiohx2rPgzJ+uAh6APvCqvv//PyFzM9+GbS8RkNNYkfpf+B9u
         aHKbk9ZumGVFXtXUmwCoieY2MNE6plnPK765dv8o4pXVlHF5eyvl/XIo6h73so+8QEba
         dTWnGWweeiWXBIb0ld8guyflYCSZRc+zERw9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700800838; x=1701405638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KekUES4QEaW3T6OzwXPRLAJ7BoFDfNAQJ2uK8ftZs4=;
        b=jIJdET2IXxWOki1Vc7m3SMUqWmpK7zNMt+eCs/suGByTJ6+h11KOAOlHM6iYOQAVDV
         ZMfEtk6aDbWi4nr8prigI8db+ITk5/zFJXSEdu3VtBac3DYzAYN8dg7y91mEWmtBoB92
         74SlTKPUOKPXqCquu90nDO2G//WO/fH8yhIW/WwQ7jYFEa4r5cDQ37EgOO2YEJLx7FU6
         jKjhqNAySmW6ikN/Opws0yKFVDKJzJVNMTd4qnnvDoR2IixbULhjw489fljKvULwowTE
         QHy66kx/LkdSTt+LxcD9xUYT2U6trZa6EOveNA5QpcY5mBFuWjJQ/zqAOgCmMClQS0kU
         K5ig==
X-Gm-Message-State: AOJu0YzJtVC3cAT5p58ZAsomQxWVQba8FdL9mklNG5X2Z9ILyj5MBCYh
        aCTC80MJJIg8kGFcmhmO/BJBxuFORwy6T4hxMoLYtQ==
X-Google-Smtp-Source: AGHT+IGdD+/8ruJjlhlvRhWd1o7YaLznxCb2y1AN3J4cYgMXWOthMIC6kIZi9F0WtwbcSOzhaUMLEFUIHM/mmVrW99g=
X-Received: by 2002:a05:6512:3b2c:b0:4fb:9f93:365f with SMTP id
 f44-20020a0565123b2c00b004fb9f93365fmr1155339lfv.38.1700800838386; Thu, 23
 Nov 2023 20:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20230920090658.31181-1-jason-jh.lin@mediatek.com> <4b55632a4cc92932384844f94a7d237aa3f471e3.camel@mediatek.com>
In-Reply-To: <4b55632a4cc92932384844f94a7d237aa3f471e3.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 24 Nov 2023 12:40:27 +0800
Message-ID: <CAGXv+5GvOCOPkjxyhv-Wwwbosp1KrL1aFzSyoU_FhqKPk=evPQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/mediatek: Add spinlock for setting vblank event in atomic_begin
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "fshao@chromium.org" <fshao@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 8, 2023 at 3:27=E2=80=AFPM CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) =
<ck.hu@mediatek.com> wrote:
>
> Hi, Jason:
>
> On Wed, 2023-09-20 at 17:06 +0800, Jason-JH.Lin wrote:
> > Add spinlock protection to avoid race condition on vblank event
> > between mtk_drm_crtc_atomic_begin() and mtk_drm_finish_page_flip().
>
> Reviewed-by: CK Hu <ck.hu@mediatek.com>

Please also merge this for fixes so it lands sooner.

> >
> > Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC
> > MT8173.")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > Suggested-by: AngeloGioacchino Del Regno <
> > angelogioacchino.delregno@collabora.com>
> > Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> > Reviewed-by: Fei Shao <fshao@chromium.org>
> > Tested-by: Fei Shao <fshao@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index b6fa4ad2f94d..cab4fe092f13 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -744,6 +744,7 @@ static void mtk_drm_crtc_atomic_begin(struct
> > drm_crtc *crtc,
> >
> >   crtc);
> >       struct mtk_crtc_state *mtk_crtc_state =3D
> > to_mtk_crtc_state(crtc_state);
> >       struct mtk_drm_crtc *mtk_crtc =3D to_mtk_crtc(crtc);
> > +     unsigned long flags;
> >
> >       if (mtk_crtc->event && mtk_crtc_state->base.event)
> >               DRM_ERROR("new event while there is still a pending
> > event\n");
> > @@ -751,7 +752,11 @@ static void mtk_drm_crtc_atomic_begin(struct
> > drm_crtc *crtc,
> >       if (mtk_crtc_state->base.event) {
> >               mtk_crtc_state->base.event->pipe =3D
> > drm_crtc_index(crtc);
> >               WARN_ON(drm_crtc_vblank_get(crtc) !=3D 0);
> > +
> > +             spin_lock_irqsave(&crtc->dev->event_lock, flags);
> >               mtk_crtc->event =3D mtk_crtc_state->base.event;
> > +             spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
> > +
> >               mtk_crtc_state->base.event =3D NULL;
> >       }
> >  }
