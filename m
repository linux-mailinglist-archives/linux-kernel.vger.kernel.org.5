Return-Path: <linux-kernel+bounces-20129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461D0827A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE551C22567
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E956455;
	Mon,  8 Jan 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Le4dbqsK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3EB5644C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e4d64a3d8so2731135e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704749680; x=1705354480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWxsWguEo6oxPOkdBZrsX0wCrUXIc1xVbC/XTm3MrEA=;
        b=Le4dbqsK+GKThlFb6ufkz+taXOmfnCc8dVaJplSZqUL+NbxF876yKRDhnAf2aa9onO
         mUjjJwFREQl5gXmk0NTHaBhe12CKfrwnwdjTKxyW21apwEnm7WTLtLMrMAoj3yW3Bq5M
         PCdEKH5IVA0X0RKkH7RclBX0o+SZxwr1nBskY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704749680; x=1705354480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWxsWguEo6oxPOkdBZrsX0wCrUXIc1xVbC/XTm3MrEA=;
        b=WFyj4HzjRDgzp2GLtbRXL7LAEbKlXDKXE0bEb1UmwgiQ+nCCkaoCDsoAtleaMe4tYi
         vQRQcRVNOQLmal5DdBG6x5i3E7QwJHkQ0iAKjSEpzoU9c7PuAtvFRdTKSklF6O0nRX9C
         kvSOL7us1cgKE0ZknTiW0PUPURPC5q4agEyF+Y9AJ+m/sgBdJKYRQpFkpOfyRmYX+9My
         k2pPk26jBs1BZSZKDXk3fhSBsNgYBL6FMgIjq78hw1+mS3SJW0GcUjijZf/R+9m8F2vo
         ytWitjdyu/YOd1n6czy6vIssDvBPTL8W9mR1kTw6A9MycX8jbvKQ9V54TUBtAdnRtXZb
         BiYA==
X-Gm-Message-State: AOJu0YwxO2sRpblXDHC5C4CDlCPg8MYoWT2vPg984Jy9DjRMVv1WgXZo
	92sHypWrDmf8/TPoGaE4gxB63tsur+cpjUtMD3glzUpPV5Ex
X-Google-Smtp-Source: AGHT+IGs0Mdbtw6SbaRqr7MlOaoHyi9Kr+2nBVknT0QG+ECZnTVTY12az1YaKq42skPytm2lGTiqwg==
X-Received: by 2002:a05:600c:4504:b0:40d:9255:4aca with SMTP id t4-20020a05600c450400b0040d92554acamr2024256wmo.119.1704749680070;
        Mon, 08 Jan 2024 13:34:40 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id rh3-20020a17090720e300b00a26af6e4604sm274898ejb.107.2024.01.08.13.34.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 13:34:39 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so17385e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 13:34:39 -0800 (PST)
X-Received: by 2002:a05:600c:3b02:b0:40e:4990:d566 with SMTP id
 m2-20020a05600c3b0200b0040e4990d566mr36wms.4.1704749679036; Mon, 08 Jan 2024
 13:34:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220221418.2610185-1-hsinyi@chromium.org> <CAD=FV=VdO=V51jbK5Ym9g9m2naJ4tfC-vKFCnfbpT+F-pNM_OA@mail.gmail.com>
In-Reply-To: <CAD=FV=VdO=V51jbK5Ym9g9m2naJ4tfC-vKFCnfbpT+F-pNM_OA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 8 Jan 2024 13:34:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ws5M9_oFCMdakAN5YDQow=vkWg29_o6etmfC9XzOBDOQ@mail.gmail.com>
Message-ID: <CAD=FV=Ws5M9_oFCMdakAN5YDQow=vkWg29_o6etmfC9XzOBDOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: use put_sync in unprepare
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Linus Walleij <linus.walleij@linaro.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 20, 2023 at 2:43=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Wed, Dec 20, 2023 at 2:14=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > Some edp panel requires T10 (Delay from end of valid video data transmi=
tted
> > by the Source device to power-off) less than 500ms. Using autosuspend w=
ith
> > delay set as 1000 violates this requirement.
> >
> > Use put_sync_suspend in unprepare to meet the spec. For other cases (su=
ch
> > as getting EDID), it still uses autosuspend.
> >
> > Suggested-by: Douglas Anderson <dianders@chromium.org>
> > Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simp=
le")
>
> Probably instead:
>
> Fixes: 3235b0f20a0a ("drm/panel: panel-simple: Use runtime pm to avoid
> excessive unprepare / prepare")
>
> ...you could send a new version or I could just fix it up when I apply it=
.
>
>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Yeah, it's really unfortunate but I think we have to do this. It will
> add big delays any time we need to turn the panel off and quickly back
> on again, but I don't think we can reliably meet T10 without it. Even
> turning down the autosuspend delay won't really help since someone
> could do something like read the EDID while the delay was happening to
> reset the delay. At least we can still use "autosuspend" to avoid
> powering off between reading the EDID and powering up the panel since
> the EDID grabs runtime_pm itself and still uses autosuspend.
>
> I don't remember this particular problem before and nobody has yelled
> about it in the past. ...and the requirement seems crazy, but it
> certainly is in the spec sheets so we should be good citizens and
> honor it. On the plus side, this means that we will always fully power
> cycle the panel whenever we turn video off and that means that if any
> other panels out there have weird issues like "samsung-atna33xc20"
> this will also fix them since this is the same fix I had to do in that
> driver.
>
> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'm about to go on vacation, so I won't apply this until January.
> Other drm-misc maintainers are free to apply sooner than that if
> they're comfortable with it.

Things were silent and I'm back from vacation, so I've gone ahead and
pushed this to drm-misc-next.

Technically I could have pushed it to drm-misc-fixes, but from my
understanding of the issue it was not causing any actual problems
other than making someone upset who was staring at oscilloscope traces
and comparing them to a spec sheet. Given that this changes timings,
I'd rather have the extra bake time of going through drm-misc-next.

49ddab089611 drm/panel-edp: use put_sync in unprepare


-Doug

