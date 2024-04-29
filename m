Return-Path: <linux-kernel+bounces-162099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA0A8B55D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189461F236E4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859F43BB43;
	Mon, 29 Apr 2024 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/QSWlVy"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3739AF1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387906; cv=none; b=VAc1dB7xMw8v0dFK8rc9v9ee9wUpp/LY04CIKojfN1zSlqU/pySQWBozzNwYioLlGB/v6mc1FhB8s4tCib/5sRO+rVxzvY+kQmV01KO+dEkF8ffx6iaZ9AjZyoLK7Ys7ZjFx8bcj+vWLbnyTMCCPXc7vQsqJ+fThdX8fRMUczys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387906; c=relaxed/simple;
	bh=4OFQmfmBaaiVFMtf3n+9BGYMCu4VhD/PO1uFErhL+cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJ73BMfKje1tQhpZxfln0vEqGaspdlNQEYvlzz6BFG0pV1yIDkk2kAMK59xjCtbdSP8OrIblxRhMJQ51sLJMZhokGMKM9a8JDNc1KdtvdCQ6GmmD5hCBmxXTCqtTYPWNiXzGnYsLShBJ08MT+4+YONCWckspb7dovWYDDsnTrEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/QSWlVy; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-47c5d6b9addso110729137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714387904; x=1714992704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXhEnLpZuSACRtLpCaCHyHe6X1epB7qL3alOjAjU9x8=;
        b=A/QSWlVyyX8g7NZFwagC3u0WSl7hW/jd1RkYaLlcWYaENhoNhqUp/l6TCyMnBi9+7M
         oW85Xz2VRyg/faeQSd5dBqplqPkB/JLs06qaj0d9BfFsZujRwBBHMM5vtyxbrz3LPQKN
         ysYtjdQPP7zgN/GzqQKWMcqGYhv8EyqmfxFPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387904; x=1714992704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXhEnLpZuSACRtLpCaCHyHe6X1epB7qL3alOjAjU9x8=;
        b=PS2ZWhp/eYUaSLYMnrRqEDhltXwCIgyoYRRdyqo++KeCSrY7eOE6PnlP/QcECw6pQY
         ONcHj6oafW5+WtqTnKkXMLHBrKw/59Jon8h3K1zjRfyZKDlGd3f8VzCt6mUmNQueyTQa
         vm9D4WdVIYtW80xe2peF4LklLjmGAUNHRD10hjL4m0gHA/lN7111CadceYznEAylb6nI
         pb1SJchdd1G8trqZiiLknljoMCCpw6/MGR2b/+tY91B3tRv+95zI6uNXcHuRQjbBYPOF
         1afMh+8dX0FwEoAipHrHx2YZu9fdSAhe4vibeSPO3zuMCkH38JyH4DJdtFfqj4UiizW/
         Ygiw==
X-Forwarded-Encrypted: i=1; AJvYcCUb5CoIS+xeLelrZhqnjeZRZusgkPHkcufoQX3MdrfCj6JXaZ8OxykL9MeEMGD+Dkul2ss/xsPlEt8PgbpReFe1ALPtu9A3o9GmJ8yw
X-Gm-Message-State: AOJu0YwNP7bkDYXACqhE/kNKICyWgc1/xIDNskvyeut/o44q4IR/Ly05
	XUKdmCbsIb/102kpcuI1zlMrs8aVmnxOta/lH8S8sNqdlHE1Ni/Og/Se5+XUp7lLDdWOLpuG774
	=
X-Google-Smtp-Source: AGHT+IEWA8sHU6HPlLBxHfhqFPEVTLXfnhZfgBYy7daIT4NAofGM3Hz8fkG/4P/d3yj9bKC625M2ag==
X-Received: by 2002:a67:f8cf:0:b0:47b:eb7f:4fd8 with SMTP id c15-20020a67f8cf000000b0047beb7f4fd8mr9898739vsp.11.1714387901862;
        Mon, 29 Apr 2024 03:51:41 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id if1-20020a0561022c8100b0047c36dda866sm842560vsb.22.2024.04.29.03.51.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 03:51:41 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-47c369e7fd3so772882137.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 03:51:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVSJqs97UQfZ2Hr0uyviVuQ3GgfFCRrakhV0qE2QHkstUfv9r2bLuuLFVFbOQIV87oodtV7PO1anNOMUc3DsUr+TV6gpPRcZ5es4b6s
X-Received: by 2002:a05:6214:27cd:b0:6a0:4d4f:9428 with SMTP id
 ge13-20020a05621427cd00b006a04d4f9428mr14947200qvb.32.1714387880813; Mon, 29
 Apr 2024 03:51:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-9-2119e692309c@chromium.org> <40b9c015-8ccf-4313-800a-ecae9aa8cc27@xs4all.nl>
 <ZilMu614pUAzEGTa@kekkonen.localdomain> <20240424184603.GA6282@pendragon.ideasonboard.com>
In-Reply-To: <20240424184603.GA6282@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 29 Apr 2024 12:51:08 +0200
X-Gmail-Original-Message-ID: <CANiDSCucvz=dQYDguzBZ-f95ZP84zuhvoKnmEYoJqAs1YnZ3ZA@mail.gmail.com>
Message-ID: <CANiDSCucvz=dQYDguzBZ-f95ZP84zuhvoKnmEYoJqAs1YnZ3ZA@mail.gmail.com>
Subject: Re: [PATCH v2 09/26] media: v4l: async: refactor v4l2_async_create_ancillary_links
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hugues Fruchet <hugues.fruchet@foss.st.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sergey Kozlov <serjk@netup.ru>, 
	Abylay Ospan <aospan@netup.ru>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Dmitry Osipenko <digetx@gmail.com>, Benjamin Mugnier <benjamin.mugnier@foss.st.com>, 
	Sylvain Petinot <sylvain.petinot@foss.st.com>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans

Your proposal is what I sent for v1:
https://lore.kernel.org/linux-media/20240415-fix-cocci-v1-9-477afb23728b@chromium.org/

I have no strong opinion for any of the two, please feel free to land
whatever version you prefer.


Regards

On Wed, 24 Apr 2024 at 20:46, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Wed, Apr 24, 2024 at 06:17:31PM +0000, Sakari Ailus wrote:
> > On Wed, Apr 24, 2024 at 12:55:20PM +0200, Hans Verkuil wrote:
> > > On 19/04/2024 11:47, Ricardo Ribalda wrote:
> > > > Return 0 without checking IS_ERR or PTR_ERR if CONFIG_MEDIA_CONTROLLER
> > > > is not enabled.
> > > >
> > > > This makes cocci happier:
> > > >
> > > > drivers/media/v4l2-core/v4l2-async.c:331:23-30: ERROR: PTR_ERR applied after initialization to constant on line 319
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/v4l2-core/v4l2-async.c | 7 +++----
> > > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
> > > > index 4bb073587817..915a9f3ea93c 100644
> > > > --- a/drivers/media/v4l2-core/v4l2-async.c
> > > > +++ b/drivers/media/v4l2-core/v4l2-async.c
> > > > @@ -316,9 +316,10 @@ v4l2_async_nf_try_all_subdevs(struct v4l2_async_notifier *notifier);
> > > >  static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > > >                                        struct v4l2_subdev *sd)
> > > >  {
> > > > - struct media_link *link = NULL;
> > > > + struct media_link *link;
> > > >
> > > > -#if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > > > + if (!IS_ENABLED(CONFIG_MEDIA_CONTROLLER))
> > > > +         return 0;
> > > >
> > > >   if (sd->entity.function != MEDIA_ENT_F_LENS &&
> > > >       sd->entity.function != MEDIA_ENT_F_FLASH)
> > > > @@ -326,8 +327,6 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > > >
> > > >   link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
> > > >
> > > > -#endif
> > > > -
> > > >   return IS_ERR(link) ? PTR_ERR(link) : 0;
> > > >  }
> > >
> > > I think I would prefer:
> > >
> > > static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
> > >                                          struct v4l2_subdev *sd)
> > > {
> > > #if IS_ENABLED(CONFIG_MEDIA_CONTROLLER)
> > >     struct media_link *link;
> > >
> > >     ...
> > >
> > >     return IS_ERR(link) ? PTR_ERR(link) : 0;
> > > #else
> > >     return 0;
> > > #endif
> > > }
> > >
> >
> > Me, too.
>
> I actually prefer Ricardo's proposal :-)
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

