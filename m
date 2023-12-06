Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA118070DC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378489AbjLFN1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378484AbjLFN1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:27:01 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03315D42
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:27:08 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-dafe04717baso5207189276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1701869227; x=1702474027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fh65rB9m3zmcwI78gbdoma11sFPZlknVdRdIEejcOzk=;
        b=StLBLGldvzbX1YMDIMZV8ludW9xD6+RFI1hsP5belL0VxF/MjBZsR6XjBMVgZVOOv+
         5f18QgIXtjF6SriCBWRiqL7Zeap7Izgfk/LVgtJ+phMedxLYrWso7mLMSAYMR4CBs9DN
         w6KM58Owehsq+/WuuC/iRkTVaZCZMRA6P+Jh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701869227; x=1702474027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fh65rB9m3zmcwI78gbdoma11sFPZlknVdRdIEejcOzk=;
        b=tipC2YPe0iQnz4eZjmRdHKDKXNZ3zZUEQBn9LvhtT2geK2A4nLuky+TRFHEZSRdPVk
         z82CFphxkzkHd+4EbEuWpTusp54RJy+8KGnsIKd21SLm8Ykb+6bKux/h/p+z6rdGlwl6
         jm3BsUWDF2Ul05QKQG5CqLaU7OcN7xzLriEGdiHq5S8bNN2ltUcU86f6HQfNEfp/9Ryb
         sB25DpaE57POjmjoQZQEOnvjqT+rpkeiN3bKkzAhboZ2epU60KzWmFHbbdRX6pcyyBmo
         +NIklL49UJ2WBCAFW/W7W3F1ohg46h83Ga/qzrBIKUglsdvjdJToMuyBzYR0XVvT7ouB
         2R+w==
X-Gm-Message-State: AOJu0YyyDTBvJItEITVZKfQi83YWNejqqjfUGOQ8ZAqMWX3BWOncVYLU
        DCQRogMI98zcRWI+VTUQ4DQX+xmsZsYqE+IrZ9JeJA5pwojXHZbfpqUyJg==
X-Google-Smtp-Source: AGHT+IFZfIL6+W7s5pyxsZPYDOSlcNwPx1enVqhU/bXlRGWh1G3b6ooz5yL/Ne/H71992drIOEXBk1ppxWa2Qb/yRrw=
X-Received: by 2002:a25:2692:0:b0:db7:d9e2:f399 with SMTP id
 m140-20020a252692000000b00db7d9e2f399mr662560ybm.29.1701869226832; Wed, 06
 Dec 2023 05:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20231205105341.4100896-1-dario.binacchi@amarulasolutions.com>
 <20231205105341.4100896-3-dario.binacchi@amarulasolutions.com> <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com>
In-Reply-To: <CAPY8ntAALKiTEG6qyFO=qVqSLUW9x8AMfPMc_TUwC3z8tJ7Kzw@mail.gmail.com>
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date:   Wed, 6 Dec 2023 14:26:55 +0100
Message-ID: <CABGWkvq-fJTDFPB=389XbHW_SLt6BQr-BhjZqZ+01i3v8EaYwA@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] drm/bridge: Fix a use case in the bridge disable logic
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave and Jagan,

On Tue, Dec 5, 2023 at 4:39=E2=80=AFPM Dave Stevenson
<dave.stevenson@raspberrypi.com> wrote:
>
> Hi Dario
>
> On Tue, 5 Dec 2023 at 10:54, Dario Binacchi
> <dario.binacchi@amarulasolutions.com> wrote:
> >
> > The patch fixes the code for finding the next bridge with the
> > "pre_enable_prev_first" flag set to false. In case this condition is
> > not verified, i. e. there is no subsequent bridge with the flag set to
> > false, the whole bridge list is traversed, invalidating the "next"
> > variable.
> >
> > The use of a new iteration variable (i. e. "iter") ensures that the val=
ue
> > of the "next" variable is not invalidated.
>
> We already have https://patchwork.freedesktop.org/patch/529288/ that
> has been reviewed (but not applied) to resolve this. What does this
> version do differently and why?

My patches only affect drm_atomic_bridge_chain_post_disable(), whereas
Jagan's patch affects both
drm_atomic_bridge_chain_post_disable() and drm_atomic_bridge_chain_pre_enab=
le().
I tested Jagan's patch on my system with success and I reviewed with
Michael Trimarchi the
drm_atomic_bridge_chain_pre_enable() fixing and we think it's okay.
We also believe that our changes to post_disable() are better, as we
set the 'next' variable only when required,
and the code is more optimized since the list_is_last() is not called
within the loop.
Would it be possible to use Jagan's patch for fixing
drm_atomic_bridge_chain_pre_enable() and mine for
fixing drm_atomic_bridge_chain_post_disable()?

Thanks and regards,
Dario

>
>   Dave
>
> > Fixes: 4fb912e5e190 ("drm/bridge: Introduce pre_enable_prev_first to al=
ter bridge init order")
> > Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/gpu/drm/drm_bridge.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.=
c
> > index f66bf4925dd8..2e5781bf192e 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -662,7 +662,7 @@ void drm_atomic_bridge_chain_post_disable(struct dr=
m_bridge *bridge,
> >                                           struct drm_atomic_state *old_=
state)
> >  {
> >         struct drm_encoder *encoder;
> > -       struct drm_bridge *next, *limit;
> > +       struct drm_bridge *iter, *next, *limit;
> >
> >         if (!bridge)
> >                 return;
> > @@ -680,14 +680,15 @@ void drm_atomic_bridge_chain_post_disable(struct =
drm_bridge *bridge,
> >                                  * was enabled first, so disabled last
> >                                  */
> >                                 limit =3D next;
> > +                               iter =3D next;
> >
> >                                 /* Find the next bridge that has NOT re=
quested
> >                                  * prev to be enabled first / disabled =
last
> >                                  */
> > -                               list_for_each_entry_from(next, &encoder=
->bridge_chain,
> > +                               list_for_each_entry_from(iter, &encoder=
->bridge_chain,
> >                                                          chain_node) {
> > -                                       if (!next->pre_enable_prev_firs=
t) {
> > -                                               next =3D list_prev_entr=
y(next, chain_node);
> > +                                       if (!iter->pre_enable_prev_firs=
t) {
> > +                                               next =3D list_prev_entr=
y(iter, chain_node);
> >                                                 limit =3D next;
> >                                                 break;
> >                                         }
> > --
> > 2.43.0
> >

--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
