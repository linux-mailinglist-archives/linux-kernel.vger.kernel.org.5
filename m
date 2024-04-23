Return-Path: <linux-kernel+bounces-155286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E77C8AE83D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C071F24954
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BC136643;
	Tue, 23 Apr 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXJB8wsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A112C7FD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713879148; cv=none; b=FgfSqKV414ypPrGK+Oa6zAU8tGtLbt88yxd6m9khCLnp//sDFRRiWlmxKMCYha9d1ApOZ03Alk3toeoePyt2yj1XCCcJlcXxsNKRp1cl3Yw20Xuim4yTslMFJPWyA9/jluzLLVH+2+iBOn4yS9rN0K7zIa/Hx5AbXOejqn1GQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713879148; c=relaxed/simple;
	bh=AP67NgULme2krqQcPsRIs+2ZN6mA5krVB1+iZidsmpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jghhh44a/zsucxodwTqdzq0C/Dh1kObhDcTYCkMp0Ak3imN2uLdoVYzqEaA+KeexTxPab4tnS/NIVqT2OyId6IWjKBXZnh/Pfavz6cVVOcLhPP3CVeT/giZwayWBpRa9x6+FzGDcIgrcgFKuQX3cmqmw4v+UACN3RRPCnEL/3w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXJB8wsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF1C32783
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713879148;
	bh=AP67NgULme2krqQcPsRIs+2ZN6mA5krVB1+iZidsmpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RXJB8wspxP8pk4Ow4/JgUdQxDYSuMWXtvwZcHMcygIfsV8CZfR5piUq+ffZvqfEf8
	 QaaKf3bHJBXR8vawtx32iwMO76Si+wymzaiCe6XIsb0qQN4qg6yOpwkVFwPNV5XJzz
	 w3QwhPpK1HIqxgI4nzYSjmrhJExmGY8HDD9LPiymmpo+Rc9iIGYzaXP46hW/p9JnmC
	 F7ENkaz77czs+clx3X06vxLdZusskiyvM8EZsWZiLYrN/BfDsp0h0KshKepGB/wZhq
	 i7VE5ACvBL2q/FXyyXhWltW+bwyXFIMkKY/KXY0At5eUGls3my/FvtWLlPMvg2Rzcf
	 dHMzq6OZow9ww==
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-618769020bcso60101517b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:32:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYt/H3lDKlh9NGYqzUukI4euP6OhWgCb7PhtYPJ25P/lXQMExCjZkcWLrarubBQ39WCemUzpN83Jsuu6bXb7782pKasjMuVnkPDBco
X-Gm-Message-State: AOJu0YxBtxyAPu+jKN+tqNfMoI+OG2662fBa5lYrlr+uDmdq+N4dNQY6
	VmafchPm2IH5kx5NMPVTjfffNsCqRMg75uhz7D6qA8g25uvTDWshvoNdPEWZ4l8M2MS9A/jpZCQ
	e/Bn9ZfYiE+blo25dofjzdzOUYe7IN0aU4UHaRw==
X-Google-Smtp-Source: AGHT+IFshLz5spQ5CQ8dKF+BBgEo+ryWs5tFujTBrjKdLYE1dJu8PqqxFbvK93HDcogCUI2Ar0hY5OF8o/XSbAfFJgs=
X-Received: by 2002:a25:6c0b:0:b0:de3:e1ea:d23 with SMTP id
 h11-20020a256c0b000000b00de3e1ea0d23mr2464770ybc.51.1713879146752; Tue, 23
 Apr 2024 06:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322104732.2327060-1-sean@geanix.com> <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
In-Reply-To: <lkrxoqhcitmvjvzslhx6mrdjaa6lpxtpmdjt7wwollm6z4h65q@jk5esjje6ppy>
From: Robert Foss <rfoss@kernel.org>
Date: Tue, 23 Apr 2024 15:32:15 +0200
X-Gmail-Original-Message-ID: <CAN6tsi40-gGgG3Bw-rS4TZBO+=JthWkPh-XqErGvkHdvhqx6tA@mail.gmail.com>
Message-ID: <CAN6tsi40-gGgG3Bw-rS4TZBO+=JthWkPh-XqErGvkHdvhqx6tA@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: relax mode_valid clock tolerance
To: Sean Nyekjaer <sean@geanix.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>, 
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
	Philippe Cornu <philippe.cornu@foss.st.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, dri-devel@lists.freedesktop.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:06=E2=80=AFPM Sean Nyekjaer <sean@geanix.com> wro=
te:
>
> On Fri, Mar 22, 2024 at 11:47:31AM +0100, Sean Nyekjaer wrote:
> > When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
> > to reguire the requested and the actual px clock to be within
> > 50Hz. A typical LVDS display requires the px clock to be within +-10%.
> >
> > In case for HDMI .5% tolerance is required.
> >
> > Fixes: e01356d18273 ("drm/stm: dsi: provide the implementation of mode_=
valid()")
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> Any feedback on this?
>
> >  drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/st=
m/dw_mipi_dsi-stm.c
> > index d5f8c923d7bc..97936b0ef702 100644
> > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > @@ -322,8 +322,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigne=
d int lane_mbps,
> >       return 0;
> >  }
> >
> > -#define CLK_TOLERANCE_HZ 50
> > -
> >  static enum drm_mode_status
> >  dw_mipi_dsi_stm_mode_valid(void *priv_data,
> >                          const struct drm_display_mode *mode,
> > @@ -375,9 +373,10 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
> >               /*
> >                * Filter modes according to the clock value, particularl=
y useful for
> >                * hdmi modes that require precise pixel clocks.
> > +              * Check that px_clock is within .5% tolerance.
> >                */
> > -             if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ |=
|
> > -                 px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
> > +             if (px_clock_hz < mult_frac(target_px_clock_hz, 995, 1000=
) ||
> > +                 px_clock_hz > mult_frac(target_px_clock_hz, 1005, 100=
0))
> >                       return MODE_CLOCK_RANGE;
> >
> >               /* sync packets are codes as DSI short packets (4 bytes) =
*/
> > --
> > 2.44.0
> >
>

Reviewed-by: Robert Foss <rfoss@kernel.org>

