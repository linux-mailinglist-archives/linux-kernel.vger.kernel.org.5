Return-Path: <linux-kernel+bounces-84333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CBE86A506
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E081B2443F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244141EA80;
	Wed, 28 Feb 2024 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l843C5OJ"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C41E86E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083679; cv=none; b=kLBY8ue2Xpks7KJrDYpjKImgp0OZztdzTzxFG0RNVaSUWk/SRwATGGNH7oEsk+PdaZkZ84gbuTMZgKrdyXubk/AxjtUcTq5Me5Bl/z2yr1QPevMHUVXFjD0rUgRZm9KeeanHAJNQHTHu5oH4R9IR52wi6A8OMiAddU4iXN7yqyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083679; c=relaxed/simple;
	bh=lOtY7IfEWQmiRwqZq9jDS7foUrISxKZVaO8TmjZqOs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU4vMBd4Yp4xvswrt/p+TDm9X2ZWPwsHr0Zhr0xbybxifEOjrCteEid35NKihVoc7Gc1b3hQCceczeF0YS/SHzN2PS8iQDeMIaDCmNNL4myUptV0GgiYn4/Oop7zTCHC6pTIl+KXthWtH2/+/UW5DLe2iNqvyDTcwWuxTsXtGSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l843C5OJ; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21f2f813e3bso169976fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709083676; x=1709688476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dxfTrIeGuxrLyxuOISFvFT3KpY95fspH4sv4tIhPI0=;
        b=l843C5OJzs8Z+Z/ownUCJwqq0CSkSSP0EMnNeoVLUhH4LYMtgiBSllrGpKRUVLqV2t
         5aBs6jBoRdNvaAOlpGDM3gbgIqh0908S5njXieVrXiXle1Hht/zrHOYOBF/XviO2NG44
         xR5yNm11K3fP7XNm6CtbCCIQ6LVTgUzF9lnIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083676; x=1709688476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dxfTrIeGuxrLyxuOISFvFT3KpY95fspH4sv4tIhPI0=;
        b=YO+a03D4gdufMgQZ0s57w3mTu4yHqwFRSO08srl2s7mZq/oZqlD7wZPsfcaiztQ/IL
         81hqpHM8I0cdB3oFVOLVqb5siGdgbQF4wquBYE5oLDBbxAsjgh+LGLpdPfGtskmc6CgC
         6lU+9QK/+JwxdcIXJpUNzV5JVNkbP+W3G26Z5EC+/YuFCa2RlpQYVAoqPypIW/FpOkmD
         QtpSFEs9OHbKZWRuFbaKr70sXV781wmWCwnnlj7n/AA+OLn9oTIe5vd1w4QnC4AVlV2b
         VbKZvlCJu1UN6/1xgPa2FpbbwCSevBF507n5uLApass358h0fSbXW/NVnLyw057jQIDX
         aQIA==
X-Forwarded-Encrypted: i=1; AJvYcCWb+Zv5Ola+3NMHLbWrY3UlNp4TRg+i5qRLTYekIl/04ObDOTc/favna8UcWB+kn2rofLaZXVIyzFfRFt6NER5B83t8Cql7y06jLflm
X-Gm-Message-State: AOJu0YyX5Qulfp+UizaBs1sTo3t0rJy/bkzxBHQNBcG3z6GjiWxmUOnv
	Jkx5EWTNmKlipKdS1dm8/N1AZCPEZemigTBOChsN2pP0xa9tYXpkunCaYTaxGO8ytu9pFTKInhF
	GAKOeeB6y47/17GU+hRV3Q6VY3Cd55f4cheU8
X-Google-Smtp-Source: AGHT+IHqTW+E+2DQPHcqL4YIkPCYB/B/51xhy690aev+KstBxVrO/Upt/E3fmt5OcYTiHRheu2KC8KpuQFsk7tVF8Ro=
X-Received: by 2002:a05:6870:5b9a:b0:21f:8eec:f19f with SMTP id
 em26-20020a0568705b9a00b0021f8eecf19fmr450959oab.12.1709083676221; Tue, 27
 Feb 2024 17:27:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com>
In-Reply-To: <87wmqqjmt9.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 27 Feb 2024 17:27:30 -0800
Message-ID: <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Douglas Anderson <dianders@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > It's found that some panels have variants that they share the same pane=
l id
> > although their EDID and names are different. Besides panel id, now we n=
eed
> > the hash of entire EDID base block to distinguish these panel variants.
> >
> > Add drm_edid_get_base_block to returns the EDID base block, so caller c=
an
> > further use it to get panel id and/or the hash.
>
> Please reconsider the whole approach here.
>
> Please let's not add single-use special case functions to read an EDID
> base block.
>
> Please consider reading the whole EDID, using the regular EDID reading
> functions, and use that instead.
>
> Most likely you'll only have 1-2 blocks anyway. And you might consider
> caching the EDID in struct panel_edp if reading the entire EDID is too
> slow. (And if it is, this is probably sensible even if the EDID only
> consists of one block.)
>
> Anyway, please do *not* merge this as-is.
>

hi Jani,

I sent a v2 here implementing this method:
https://lore.kernel.org/lkml/20240228011133.1238439-2-hsinyi@chromium.org/

We still have to read edid twice due to:
1. The first caller is in panel probe, at that time, connector is
still unknown, so we can't update connector status (eg. update
edid_corrupt).
2. It's possible that the connector can have some override
(drm_edid_override_get) to EDID, that is still unknown during the
first read.

> BR,
> Jani.
>
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_edid.c        | 55 +++++++++++++++++--------------
> >  drivers/gpu/drm/panel/panel-edp.c |  8 +++--
> >  include/drm/drm_edid.h            |  3 +-
> >  3 files changed, 38 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 923c4423151c..55598ca4a5d1 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -2770,58 +2770,63 @@ static u32 edid_extract_panel_id(const struct e=
did *edid)
> >  }
> >
> >  /**
> > - * drm_edid_get_panel_id - Get a panel's ID through DDC
> > - * @adapter: I2C adapter to use for DDC
> > + * drm_edid_get_panel_id - Get a panel's ID from EDID base block
> > + * @base_bock: EDID base block that contains panel ID.
> >   *
> > - * This function reads the first block of the EDID of a panel and (ass=
uming
> > + * This function uses the first block of the EDID of a panel and (assu=
ming
> >   * that the EDID is valid) extracts the ID out of it. The ID is a 32-b=
it value
> >   * (16 bits of manufacturer ID and 16 bits of per-manufacturer ID) tha=
t's
> >   * supposed to be different for each different modem of panel.
> >   *
> > + * Return: A 32-bit ID that should be different for each make/model of=
 panel.
> > + *         See the functions drm_edid_encode_panel_id() and
> > + *         drm_edid_decode_panel_id() for some details on the structur=
e of this
> > + *         ID.
> > + */
> > +u32 drm_edid_get_panel_id(void *base_block)
> > +{
> > +     return edid_extract_panel_id(base_block);
> > +}
> > +EXPORT_SYMBOL(drm_edid_get_panel_id);
> > +
> > +/**
> > + * drm_edid_get_base_block - Get a panel's EDID base block
> > + * @adapter: I2C adapter to use for DDC
> > + *
> > + * This function returns the first block of the EDID of a panel.
> > + *
> >   * This function is intended to be used during early probing on device=
s where
> >   * more than one panel might be present. Because of its intended use i=
t must
> > - * assume that the EDID of the panel is correct, at least as far as th=
e ID
> > - * is concerned (in other words, we don't process any overrides here).
> > + * assume that the EDID of the panel is correct, at least as far as th=
e base
> > + * block is concerned (in other words, we don't process any overrides =
here).
> >   *
> >   * NOTE: it's expected that this function and drm_do_get_edid() will b=
oth
> >   * be read the EDID, but there is no caching between them. Since we're=
 only
> >   * reading the first block, hopefully this extra overhead won't be too=
 big.
> >   *
> > - * Return: A 32-bit ID that should be different for each make/model of=
 panel.
> > - *         See the functions drm_edid_encode_panel_id() and
> > - *         drm_edid_decode_panel_id() for some details on the structur=
e of this
> > - *         ID.
> > + * Caller should free the base block after use.
> >   */
> > -
> > -u32 drm_edid_get_panel_id(struct i2c_adapter *adapter)
> > +void *drm_edid_get_base_block(struct i2c_adapter *adapter)
> >  {
> >       enum edid_block_status status;
> >       void *base_block;
> > -     u32 panel_id =3D 0;
> > -
> > -     /*
> > -      * There are no manufacturer IDs of 0, so if there is a problem r=
eading
> > -      * the EDID then we'll just return 0.
> > -      */
> >
> >       base_block =3D kzalloc(EDID_LENGTH, GFP_KERNEL);
> >       if (!base_block)
> > -             return 0;
> > +             return NULL;
> >
> >       status =3D edid_block_read(base_block, 0, drm_do_probe_ddc_edid, =
adapter);
> >
> >       edid_block_status_print(status, base_block, 0);
> >
> > -     if (edid_block_status_valid(status, edid_block_tag(base_block)))
> > -             panel_id =3D edid_extract_panel_id(base_block);
> > -     else
> > +     if (!edid_block_status_valid(status, edid_block_tag(base_block)))=
 {
> >               edid_block_dump(KERN_NOTICE, base_block, 0);
> > +             return NULL;
> > +     }
> >
> > -     kfree(base_block);
> > -
> > -     return panel_id;
> > +     return base_block;
> >  }
> > -EXPORT_SYMBOL(drm_edid_get_panel_id);
> > +EXPORT_SYMBOL(drm_edid_get_base_block);
> >
> >  /**
> >   * drm_get_edid_switcheroo - get EDID data for a vga_switcheroo output
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index bd71d239272a..f6ddbaa103b5 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -763,6 +763,7 @@ static const struct edp_panel_entry *find_edp_panel=
(u32 panel_id);
> >  static int generic_edp_panel_probe(struct device *dev, struct panel_ed=
p *panel)
> >  {
> >       struct panel_desc *desc;
> > +     void *base_block;
> >       u32 panel_id;
> >       char vend[4];
> >       u16 product_id;
> > @@ -792,8 +793,11 @@ static int generic_edp_panel_probe(struct device *=
dev, struct panel_edp *panel)
> >               goto exit;
> >       }
> >
> > -     panel_id =3D drm_edid_get_panel_id(panel->ddc);
> > -     if (!panel_id) {
> > +     base_block =3D drm_edid_get_base_block(panel->ddc);
> > +     if (base_block) {
> > +             panel_id =3D drm_edid_get_panel_id(base_block);
> > +             kfree(base_block);
> > +     } else {
> >               dev_err(dev, "Couldn't identify panel via EDID\n");
> >               ret =3D -EIO;
> >               goto exit;
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 7923bc00dc7a..56b60f9204d3 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -410,7 +410,8 @@ struct edid *drm_do_get_edid(struct drm_connector *=
connector,
> >       void *data);
> >  struct edid *drm_get_edid(struct drm_connector *connector,
> >                         struct i2c_adapter *adapter);
> > -u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
> > +void *drm_edid_get_base_block(struct i2c_adapter *adapter);
> > +u32 drm_edid_get_panel_id(void *base_block);
> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
> >                                    struct i2c_adapter *adapter);
> >  struct edid *drm_edid_duplicate(const struct edid *edid);
>
> --
> Jani Nikula, Intel

