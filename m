Return-Path: <linux-kernel+bounces-90923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5368706D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262251F22531
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FA4C3C3;
	Mon,  4 Mar 2024 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KLjUj6a0"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AE18828
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569074; cv=none; b=chmR3aE+5RbrBxzrMNxbNDOf8qR5DZZmQDB4oZ37j+hY4wqfg/NA8sFZZUxxzD6eEg8VNUaUYMT/OgsdxzeyBRZMLqRNi3jrraiyobiDlootzZP/RvnIR88NjPrPcoIQzb7S4bgmt4YlAXeVJ8V4O/0UQnx+4sN0ioLVgc8i0r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569074; c=relaxed/simple;
	bh=fT9+RDjIMzx5jaeuwiRDUN+/FkIMCPj3JQcCA0Q/lds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxkgW6EFXTzd5NRwHbbnF55x55hBBOKZg/1+CSbrqBMszYYyrJlrariZm1Wmk55mcF8W07opgj2XOTCB0uTWe8Elex5UeFhp3xSojkB1OV7zUxn4QNTdI7X7t+7slcZ9Z1J8PWd/T9757nxx5YQdijdk/0Ida3FJQ6SwX4QTQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KLjUj6a0; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d28464c554so63952461fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709569070; x=1710173870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=km22joOP3BJvhNiKy5z6xew4BuTiJqbVYs51+71h3NQ=;
        b=KLjUj6a0573xRkbL3DIveS1aK9b1xc6fevSnfzXDiHlJvNsbuT4SMkZUm9wQ9+y/Bv
         VJxTnp1pcLrM5gOeqiW6eyrxLdpYlOY3OFNKRER5Uw8idRR0/Kv07MpD1Y1fY0zaot81
         dFGEhfmglc7+MpxrQaciJUzoWy5W24nubyqvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569070; x=1710173870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=km22joOP3BJvhNiKy5z6xew4BuTiJqbVYs51+71h3NQ=;
        b=Etm3MMik7qNT+LSqwy7zhRJlesWjFebEEQCqCx+2OnU8vFNZFSs363Ga2NEV6TuxWz
         lbTdD3wmk3vVEwS1p716C+V/8pEt117zazhGzWhm1CnRMUGn8hRLzNkTvzQW5F85exKN
         QZ/RfZhVJYJDHditYnl1FPdNN3j3o8C7lKpv+uH61FJaCLxfysFXG6d2zJ+ZkJ9ba/A5
         /TpotqKj0QNE/oQyw9fcVKR7WghjLZQF5mOH6u0At6iCYFalir19qfkugfu92TfuiGdb
         d+qHV1J1GVFAh5VuCMkO9/EZTqdWx8VLKGoL2kHvGWcaR1KNrcLk8HEBPfZ2qlr6tNHF
         TTsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdzudpi3zhYC0Y4E3GDyK4q6ZV9f8Wx6kQApmB3d+Edi2ANhZVadQJYk5M84c4zCI6WuglXhRgJFSbWCHZv+p6dNELGTw6emvXvX/i
X-Gm-Message-State: AOJu0Yz5pbrdMJM9HFSyn3pHUz5tAJzhHJhyJpuncGeIbe7AoqGwuyHJ
	PAyF6NnI6yCu33UlRvfA681M45Vis8k/SSmp88eqkZRoOCTyp8toPaJDkCt5ziLoDaZZD/h1pB5
	FRw==
X-Google-Smtp-Source: AGHT+IGbstSA4Wx0FDUzBvKvzzWMsRGaIimExiUVD+r43DtK8xEHuxYuQxrC4y5vYo6zPhyWOnhbfA==
X-Received: by 2002:a05:6512:360b:b0:513:256f:ef63 with SMTP id f11-20020a056512360b00b00513256fef63mr5981094lfs.20.1709569070277;
        Mon, 04 Mar 2024 08:17:50 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id d17-20020a056402517100b005671100145dsm2591182ede.55.2024.03.04.08.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:17:49 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso93945e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:17:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgUS/SmC8tmLQTkHH2PeLnxjhylI0wTtI2+4448NMFAK2cqhNdR2CNarRqnonCJO/yaXpCodZINvGiVE4RixZSflU4AJN3XIBG0ksN
X-Received: by 2002:a05:600c:518b:b0:412:e492:7e5 with SMTP id
 fa11-20020a05600c518b00b00412e49207e5mr156141wmb.1.1709569068931; Mon, 04 Mar
 2024 08:17:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223223958.3887423-1-hsinyi@chromium.org> <20240223223958.3887423-2-hsinyi@chromium.org>
 <87wmqqjmt9.fsf@intel.com> <CAJMQK-jSPg6vU3SLmRy7zwNHJ4yqO2hT6RaiYxA4ifZ7CzwD9Q@mail.gmail.com>
 <CAD=FV=WU-2yystd40e+g9VNDNTiv5c=nP0uQg-AR03o7UGMTdA@mail.gmail.com>
 <87bk7z6x1w.fsf@intel.com> <CAD=FV=Wzm9Y7m9Q6KqO7yWdnc1xToaRMb2f1s2TQMJqpqVYLOg@mail.gmail.com>
 <CAA8EJpqHJTbc+TCpkccjx_eQH36zaNgcQ9QssecNeQUQgfYApQ@mail.gmail.com>
In-Reply-To: <CAA8EJpqHJTbc+TCpkccjx_eQH36zaNgcQ9QssecNeQUQgfYApQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 08:17:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XyV=V-USfq8kp058=FzRQq=bPA5A4GDb1p0zO-KPbtwQ@mail.gmail.com>
Message-ID: <CAD=FV=XyV=V-USfq8kp058=FzRQq=bPA5A4GDb1p0zO-KPbtwQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm_edid: Add a function to get EDID base block
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 3, 2024 at 1:30=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> > The problem is that Dmitry didn't like the idea of using a hash and in
> > v2 Hsin-Yi has moved to using the name of the display. ...except of
> > course that eDP panels don't always properly specify
> > "EDID_DETAIL_MONITOR_NAME". See the discussion [1]. If you want to see
> > some of the EDIDs involved, you can see Hsin-Yi's post [2]. The panels
> > included stuff like this:
> >
> >     Alphanumeric Data String: 'AUO'
> >     Alphanumeric Data String: 'B116XAN04.0 '
> >
> > The fact that there is more than one string in there makes it hard to
> > just "return" the display name in a generic way. The way Hsin-Yi's
> > code was doing it was that it would consider it a match if the panel
> > name was in any of the strings...
> >
> > How about this as a solution: we change drm_edid_get_panel_id() to
> > return an opaque type (struct drm_edid_panel_id_blob) that's really
> > just the first block of the EDID but we can all pretend that it isn't.
> > Then we can add a function in drm_edid.c that takes this opaque blob,
> > a 32-bit integer (as per drm_edid_encode_panel_id()), and a string
> > name and it can tell us if the blob matches?
>
> Would it be easier to push drm_edid_match to drm_edid.c? It looks way
> more simpler than the opaque blob.

Yeah, that sounds reasonable / cleaner to me. Good idea! Maybe Hsin-Yi
will be able to try this out and see if there's a reason it wouldn't
work.

-Doug

