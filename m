Return-Path: <linux-kernel+bounces-85915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5C86BCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F6C2884AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016127447;
	Thu, 29 Feb 2024 00:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JnCOGwY/"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37C15C3
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166054; cv=none; b=f3RgmdPLSmC4vfM9sdpVO+b0ZDmKj/43RFMZQuVTF/9kivI0dgLyHcS+mMwCVOF4w2q2ixHcFcwaT7aIvDv+a4uYLeakk1nmEZ9/GNTVjVlmQRgN+FjUGEpg58ECgd728/cwlU3akBD3M5z8qVWOg2z2VV2PlalJfYK89CD5fAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166054; c=relaxed/simple;
	bh=vHrCJ54ZMhXBbaJsSkVO4G57dmkhBIGT/ize3+TH55Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C6Z3yrWXMUS92fKgMFIJ6Z2ORSOIxO9w0WpjcpnhPkvIgw/uacod7U+e+KPTj1lhDr5/H20CTh/NzPYFzScI7wTO8xWK3xd6pCRLpCSDJ5KIGApbuuplqMvxBcDx4ZhgM2B6PdOPHs0/8mueC+anmuKcxmiEk4aanA2jWJpHUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JnCOGwY/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a43488745bcso56266966b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709166048; x=1709770848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHrCJ54ZMhXBbaJsSkVO4G57dmkhBIGT/ize3+TH55Y=;
        b=JnCOGwY/oq4nNeK3RiGd5PUOh2iUVoUaLhMb1pPUU40j0Tt3DntX43MfmAF+uwWH7p
         kETyz3laAnMb7ke4BezV6+UhqJEoJgUynmE5/2V6zCEJUQ5VBHnFAeUEl9drZa/qfVsU
         VujG4vLL4jngPWnb3XVKTr0nbHDWD44ldG6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166048; x=1709770848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHrCJ54ZMhXBbaJsSkVO4G57dmkhBIGT/ize3+TH55Y=;
        b=T/6/DvXB5iXtGgiRBRG5jQF8e/sFdzVklrV3OVDHWuNh50kiqKZRxz28XPzlXjEwfJ
         f95bUsGRJDD0O4smt7hEFfdcZP/jC9jVQMg7JeufA7piKyXuD0dlmzvoucroXvGFMj79
         pCdWO9sLokM5m9tlnS8bODORBQ6h6A9Nf0cGYbypzUOrkEoixD8Ztd9o7CzmMjx0Anj2
         NDMedyuMSBq8l5cxhQm5fbhawTJXBr1JJ09BzDh0P/W3+5dOK1ugX1ME6Ecg3DOHiXcI
         tczG7Pw4z6Qw0rBsL978i8xnftuNrnNIUO+mJ0K1CQ6cQGuklfq1iHtn1sKA9ksw4rF0
         Uj+A==
X-Forwarded-Encrypted: i=1; AJvYcCVeU3og5CPkZZw3jQClqKSbEzU0snddOmFhDWy3WCcRVnQ1EqmYYplmF6/aPIz1Xm5CD2a1C8QENI8XWL0WEMMfafUhSRl8mwH49ktf
X-Gm-Message-State: AOJu0YygqJi86NOk/hFV18JAaYRFXzIUVqjCBdUJGs8Mg4ZNCzOlDRju
	ombbCEP43EhcJ6j4pXTOsa3ymvKpDGTzdBxeoNaaNCVhqI5TpZG4hqnuJR0Gq/WB0GbXIreox1I
	XKHCL
X-Google-Smtp-Source: AGHT+IGHfNHQAfXuWCiWNvi7Kw8fEDnZ9qpSMl0HS3bcs6jOAO9nNASyzl2SurK36DONw1rLPQ0DhQ==
X-Received: by 2002:a17:906:80c4:b0:a43:ff8c:6d9c with SMTP id a4-20020a17090680c400b00a43ff8c6d9cmr377562ejx.56.1709166048649;
        Wed, 28 Feb 2024 16:20:48 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id s8-20020a1709066c8800b00a442369a8d0sm63291ejr.223.2024.02.28.16.20.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:20:48 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4129a748420so34385e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:20:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2tKxiASJoZUaDqDG7U5QvoaFiV00WNvFMZ+cGvTOvQJfUOgx2a9CNblgClB/Dy145k9fIAiQGsx6y+BoEr9c0Rzp1h3/WzYDUHgDl
X-Received: by 2002:a05:600c:3d90:b0:412:ba6c:8067 with SMTP id
 bi16-20020a05600c3d9000b00412ba6c8067mr1256wmb.5.1709166047079; Wed, 28 Feb
 2024 16:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com> <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
In-Reply-To: <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 16:20:31 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
Message-ID: <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 5:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> On Tue, Feb 27, 2024 at 1:09=E2=80=AFAM Jani Nikula <jani.nikula@linux.in=
tel.com> wrote:
> >
> > On Fri, 23 Feb 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > > It's found that some panels have variants that they share the same pa=
nel id
> > > although their EDID and names are different. Besides panel id, now we=
 need
> > > the hash of entire EDID base block to distinguish these panel variant=
s.
> > >
> > > Add drm_edid_get_base_block to returns the EDID base block, so caller=
 can
> > > further use it to get panel id and/or the hash.
> >
> > Please reconsider the whole approach here.
> >
> > Please let's not add single-use special case functions to read an EDID
> > base block.
> >
> > Please consider reading the whole EDID, using the regular EDID reading
> > functions, and use that instead.
> >
> > Most likely you'll only have 1-2 blocks anyway. And you might consider
> > caching the EDID in struct panel_edp if reading the entire EDID is too
> > slow. (And if it is, this is probably sensible even if the EDID only
> > consists of one block.)
> >
> > Anyway, please do *not* merge this as-is.
> >
>
> hi Jani,
>
> I sent a v2 here implementing this method:
> https://lore.kernel.org/lkml/20240228011133.1238439-2-hsinyi@chromium.org=
/
>
> We still have to read edid twice due to:
> 1. The first caller is in panel probe, at that time, connector is
> still unknown, so we can't update connector status (eg. update
> edid_corrupt).
> 2. It's possible that the connector can have some override
> (drm_edid_override_get) to EDID, that is still unknown during the
> first read.

I'll also comment in Hsin-Yi's v2, but given Hsin-Yi's digging and the
fact that we can't cache the EDID (because we don't yet have a
"drm_connector"), I'd much prefer Hsin-Yi's solution here from v1 that
allows reading just the first block. If we try to boot a device with a
multi-block EDID we're now wastefully reading all the blocks of the
EDID twice at bootup which will slow boot time.

If you can see a good solution to avoid reading the EDID twice then
that would be amazing, but if not it seems like we should go back to
what's here in v1. What do you think? Anyone else have any opinions?



-Doug

