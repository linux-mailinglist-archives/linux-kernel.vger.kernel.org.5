Return-Path: <linux-kernel+bounces-91400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 381D68710F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5897B25288
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E47C6C0;
	Mon,  4 Mar 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VThtlmGx"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030A77BAE2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 23:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593823; cv=none; b=m1Ps+nWKJkdpd17zSWLg4h31XxDeBXcM2ekOt6samuqO0hqM5km9xWiVaj5HRO3GxcUyNBnJGQ87/g6whSaZKK1cDKEKQyRs12m3BMtSQltr/LnQGOD3r7Ri0hM4iUSm62jrl6fVXHoFQVyF0AIEbtZuNPh64Z3bFkhUCXX0qhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593823; c=relaxed/simple;
	bh=xD+RCUnKaiyIjhEEXDIXk61kThQxYInzrSJtpFucizM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muIVeX9nfzAa7mJSNGfMD4kYD97bc79P10Nc3nms62BcPXlXK/aXy9cYmw6eT04fyha1QqU8eQ8TjrGuWj5M8KLGMdIGY2/Ay9GXVAzzhl1M0XKZrscMqQjWluLaKSvTTRydiiYhI6oIPf1XU7Jxbt0UBW0tEPZ68oeTkuZ8QW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VThtlmGx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6098ba9959aso1479137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 15:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709593821; x=1710198621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDgkNYWU4DWfsyWb+GlMK9bHYQCTEtx1BFNrE0oEImA=;
        b=VThtlmGx3ojrJJJPjXO98sjyVsF6Ua/ednaHEIeMBXe7xVWFi/JTz0oxsoHUrz5QM6
         RAxXuQ7jgEpd6ZkxUCwwZgxXgAfQsySO9cC4pmLcPjbQq/+xXsqIb7jGPW5jqnJAlk8j
         B/JtoSm+KAsOqsdQCtB3O4ynGdxTwqdAdUsJv2Mr29SHHWqbjy6gSr7uGHosLBQl8ck1
         Dl5a8/q6Uma2hhIg1LF4+VSm6TDVvtafRCRSt1AldCPH2Ci7y4/hPPI1//mggoFqUb0p
         5dfzwnCbsOTpYtjZx2KQQ1fgSKxEM5Tcjpm8/ZcQ463v726e220L/LpuP3uyZBHlgNcH
         b5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709593821; x=1710198621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDgkNYWU4DWfsyWb+GlMK9bHYQCTEtx1BFNrE0oEImA=;
        b=VQ4cjmMz7ySnwJSFbXcKExwb2g/cBvXukWebiB4/PVjKeJh2IlsmD+prRmgzsVkkLZ
         uzGwwR/29tzYV89cNmbNmRu7jfP6NI2kMm8bUJ/qW65bPZo8VJ4Rphp/Fr9MCg+7pIbr
         NGZgldwNuAtu/SWBfIfY6EBY23a+jcKxGSA5cSQB2GTc397gDeX6aHUJW0hytWh+FwY4
         zxo3yD/WUXjZxW6V6JOTDq+Jht0whgvYv62TPWhmx9kyJdub4gLEItul+xDl4ZJnhlff
         9WU5hICBCktZYB+xoEk6u6oDE8jXaMLQD1U7cn07wJAnYO5WtAmmGs5Vri9pbkZXQ3Cl
         ljpA==
X-Forwarded-Encrypted: i=1; AJvYcCX6KEUBB6NiLLzCvgDLhyKHOWsBVN/hTiBIzcba0bM58Ehjskbs4caA6FUHY4K6iPJIWS8tUdOdEAUKvQ/C26+alOR/IdEsLW7fyl01
X-Gm-Message-State: AOJu0Yyd/IWW2oX2VvZOHIovKyGA4tLucMn4/Az4MCQQg8mrigCL0yU9
	2OvTeMNqEI15KSD20G8tP1kHCe4OyvnRcOI+PeibR5rBNJjPTce/7yQi9owxlYn2Y+yuYOE9fR0
	mt8Y+CeMu0p8hSVLMtNojQKr4pajo6t80Skv28w==
X-Google-Smtp-Source: AGHT+IGcubG2zCEwx0B1zfivsMQ7pWwmtzPaSlsXlK64sn8zBfoYfIkPKcZ6Ss3lt89bmQoRkMPn5GhXL+a/uIuio84=
X-Received: by 2002:a05:6902:544:b0:dcc:9e88:b15 with SMTP id
 z4-20020a056902054400b00dcc9e880b15mr8059955ybs.41.1709593820947; Mon, 04 Mar
 2024 15:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com>
In-Reply-To: <87a5nd4tsg.fsf@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Mar 2024 01:10:08 +0200
Message-ID: <CAA8EJprt=B94En8SuuEDcBGVAaZ842_=eMSeCwk_e1Sif3J6oQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 22:38, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> On Mon, 04 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > Add a function to check if the EDID base block contains a given string.
> >
> > One of the use cases is fetching panel from a list of panel names, since
> > some panel vendors put the monitor name after EDID_DETAIL_MONITOR_STRING
> > instead of EDID_DETAIL_MONITOR_NAME.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v2->v3: move string matching to drm_edid
> > ---
> >  drivers/gpu/drm/drm_edid.c | 49 ++++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_edid.h     |  1 +
> >  2 files changed, 50 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index 13454bc64ca2..fcdc2bd143dd 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -2789,6 +2789,55 @@ u32 drm_edid_get_panel_id(struct edid_base_block *base_block)
> >  }
> >  EXPORT_SYMBOL(drm_edid_get_panel_id);
> >
> > +/**
> > + * drm_edid_has_monitor_string - Check if a EDID base block has certain string.
> > + * @base_block: EDID base block to check.
> > + * @str: pointer to a character array to hold the string to be checked.
> > + *
> > + * Check if the detailed timings section of a EDID base block has the given
> > + * string.
> > + *
> > + * Return: True if the EDID base block contains the string, false otherwise.
> > + */
> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str)
> > +{
> > +     unsigned int i, j, k, buflen = strlen(str);
> > +
> > +     for (i = 0; i < EDID_DETAILED_TIMINGS; i++) {
> > +             struct detailed_timing *timing = &base_block->edid.detailed_timings[i];
> > +             unsigned int size = ARRAY_SIZE(timing->data.other_data.data.str.str);
> > +
> > +             if (buflen > size || timing->pixel_clock != 0 ||
> > +                 timing->data.other_data.pad1 != 0 ||
> > +                 (timing->data.other_data.type != EDID_DETAIL_MONITOR_NAME &&
> > +                  timing->data.other_data.type != EDID_DETAIL_MONITOR_STRING))
> > +                     continue;
> > +
> > +             for (j = 0; j < buflen; j++) {
> > +                     char c = timing->data.other_data.data.str.str[j];
> > +
> > +                     if (c != str[j] ||  c == '\n')
> > +                             break;
> > +             }
> > +
> > +             if (j == buflen) {
> > +                     /* Allow trailing white spaces. */
> > +                     for (k = j; k < size; k++) {
> > +                             char c = timing->data.other_data.data.str.str[k];
> > +
> > +                             if (c == '\n')
> > +                                     return true;
> > +                             else if (c != ' ')
> > +                                     break;
> > +                     }
> > +                     if (k == size)
> > +                             return true;
> > +             }
> > +     }
> > +
> > +     return false;
> > +}
> > +
>
> So we've put a lot of effort into converting from struct edid to struct
> drm_edid, passing that around in drm_edid.c, with the allocation size it
> provides, and generally cleaning stuff up.
>
> I'm not at all happy to see *another* struct added just for the base
> block, and detailed timing iteration as well as monitor name parsing
> duplicated.
>
> With struct drm_edid you can actually return an EDID that only has the
> base block and size 128, even if the EDID indicates more
> extensions. Because the whole thing is *designed* to handle that
> gracefully. The allocated size matters, not what the blob originating
> outside of the kernel tells you.
>
> What I'm thinking is:
>
> - Add some struct drm_edid_ident or similar. Add all the information
>   that's needed to identify a panel there. I guess initially that's
>   panel_id and name.
>
>     struct drm_edid_ident {
>         u32 panel_id;
>         const char *name;
>     };
>
> - Add function:
>
>     bool drm_edid_match(const struct drm_edid *drm_edid, const struct drm_edid_ident *ident);
>
>   Check if stuff in ident matches drm_edid. You can use and extend the
>   existing drm_edid based iteration etc. in
>   drm_edid.c. Straightforward. The fields in ident can trivially be
>   extended later, and the stuff can be useful for other drivers and
>   quirks etc.

That sounds perfect!

>
> - Restructure struct edp_panel_entry to contain struct
>   drm_edid_ident. Change the iteration of edp_panels array to use
>   drm_edid_match() on the array elements and the edid.
>
> - Add a function to read the EDID base block *but* make it return const
>   struct drm_edid *. Add warnings in the comments that it's only for
>   panel and for transition until it switches to reading full EDIDs.
>
>     const struct drm_edid *drm_edid_read_base_block(struct i2c_adapter *adapter);
>
>   This is the *only* hackish part of the whole thing, and it's nicely
>   isolated. For the most part you can use drm_edid_get_panel_id() code
>   for this, just return the blob wrapped in a struct drm_edid envelope.
>
> - Remove function:
>
>     u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>
> - Refactor edid_quirk_list to use the same id struct and match function
>   and mechanism within drm_edid.c (can be follow-up too).

I wonder if we can take one step further and merge edp_panels to
edid_quirk_list (as one of the follow-ups). Maybe just some bits of
it.


> - Once you change the panel code to read the whole EDID using
>   drm_edid_read family of functions in the future, you don't have to
>   change *anything* about the iteration or matching or anything, because
>   it's already passing struct drm_edid around.
>
>
> I hope this covers everything.
>
> BR,
> Jani.
>
>
> >  /**
> >   * drm_edid_get_base_block - Get a panel's EDID base block
> >   * @adapter: I2C adapter to use for DDC
> > diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> > index 2455d6ab2221..248ddb0a6b5d 100644
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -416,6 +416,7 @@ struct edid *drm_get_edid(struct drm_connector *connector,
> >                         struct i2c_adapter *adapter);
> >  struct edid_base_block *drm_edid_get_base_block(struct i2c_adapter *adapter);
> >  u32 drm_edid_get_panel_id(struct edid_base_block *base_block);
> > +bool drm_edid_has_monitor_string(struct edid_base_block *base_block, const char *str);
> >  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
> >                                    struct i2c_adapter *adapter);
> >  struct edid *drm_edid_duplicate(const struct edid *edid);
>
> --
> Jani Nikula, Intel



-- 
With best wishes
Dmitry

