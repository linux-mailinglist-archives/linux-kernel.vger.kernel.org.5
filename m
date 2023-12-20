Return-Path: <linux-kernel+bounces-7524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A31B81A946
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A1228227A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 22:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F9C4AF79;
	Wed, 20 Dec 2023 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G5VcnGyH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988D4AF64
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cc61d4e5aeso1466031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1703112199; x=1703716999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEFY4if4/679Rdgt31ROtX+FDj3QF5c4Pc3cIpXt5aY=;
        b=G5VcnGyHIvJWml74XZI05MCS/yCivYqqdCoMyDpaSTkBcWtfx/HfX7CDnYlCHy6Jhd
         QlKTZkoVMmJ1Armxd+8/2QDbiPk+EZxJHeqq2jMQRqaWMXTmWVnJaVHfRgVz9u7/zWna
         S51K1hPDzWhUm/Up+VtYvtF9Bmv3HvJZS0LW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703112199; x=1703716999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEFY4if4/679Rdgt31ROtX+FDj3QF5c4Pc3cIpXt5aY=;
        b=QFdJls+R2Ur76/ZsEKKn6d4XxDwp+zVOsT5dMPMDjIJcXLDp6bUuaNJ7/ngZHf/f5X
         uZstXjB1eoaakn3ayn/5WeDwKSpqI49jJauAAe2B9VeSALxkgKCIyKbIrEfj6+WVd6ZV
         sVDkn8MmF2Bhml+7NrEdStBDjle8C1dCps/y277z10E/ZBn9d7+UuYbSjE5Ybuismtf4
         NNREHx5Be/ehuIXEPimBq2Aow48S2MiMYU03orODr2gqYxLxX3neS5foarG0MuC1B9bz
         4nF3dUooTBh1Gfo8KYE/SCxYm10/LWgWoz/eokH2wKdjOJEQhXixdrP1SOnn9l5++ACL
         UuQg==
X-Gm-Message-State: AOJu0Yxv4ZQGUvtMVbFP3yyUa2h9xN4MnFT7FuEaMJxRcUOh02Ted9Z5
	il9vIssAe3e2XUmStNK0B66KnUPa9ndSwBVZImGzMg==
X-Google-Smtp-Source: AGHT+IGWTMKjtbhdzsZQv59nKYGt071ixoQikmivPdm629hisybFoUtuIKS9g2Rwbxj8Nrm1fVM0qQ==
X-Received: by 2002:a2e:2c1a:0:b0:2cc:5611:9507 with SMTP id s26-20020a2e2c1a000000b002cc56119507mr4068201ljs.12.1703112199052;
        Wed, 20 Dec 2023 14:43:19 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id d3-20020a056402000300b00553772c2968sm347735edu.82.2023.12.20.14.43.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 14:43:18 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d3b2c8517so5025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:43:18 -0800 (PST)
X-Received: by 2002:a05:600c:1c27:b0:40c:256f:756b with SMTP id
 j39-20020a05600c1c2700b0040c256f756bmr50610wms.2.1703112197939; Wed, 20 Dec
 2023 14:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220221418.2610185-1-hsinyi@chromium.org>
In-Reply-To: <20231220221418.2610185-1-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 20 Dec 2023 14:43:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VdO=V51jbK5Ym9g9m2naJ4tfC-vKFCnfbpT+F-pNM_OA@mail.gmail.com>
Message-ID: <CAD=FV=VdO=V51jbK5Ym9g9m2naJ4tfC-vKFCnfbpT+F-pNM_OA@mail.gmail.com>
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

On Wed, Dec 20, 2023 at 2:14=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Some edp panel requires T10 (Delay from end of valid video data transmitt=
ed
> by the Source device to power-off) less than 500ms. Using autosuspend wit=
h
> delay set as 1000 violates this requirement.
>
> Use put_sync_suspend in unprepare to meet the spec. For other cases (such
> as getting EDID), it still uses autosuspend.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Fixes: 5f04e7ce392d ("drm/panel-edp: Split eDP panels out of panel-simple=
")

Probably instead:

Fixes: 3235b0f20a0a ("drm/panel: panel-simple: Use runtime pm to avoid
excessive unprepare / prepare")

...you could send a new version or I could just fix it up when I apply it.


> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Yeah, it's really unfortunate but I think we have to do this. It will
add big delays any time we need to turn the panel off and quickly back
on again, but I don't think we can reliably meet T10 without it. Even
turning down the autosuspend delay won't really help since someone
could do something like read the EDID while the delay was happening to
reset the delay. At least we can still use "autosuspend" to avoid
powering off between reading the EDID and powering up the panel since
the EDID grabs runtime_pm itself and still uses autosuspend.

I don't remember this particular problem before and nobody has yelled
about it in the past. ...and the requirement seems crazy, but it
certainly is in the spec sheets so we should be good citizens and
honor it. On the plus side, this means that we will always fully power
cycle the panel whenever we turn video off and that means that if any
other panels out there have weird issues like "samsung-atna33xc20"
this will also fix them since this is the same fix I had to do in that
driver.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm about to go on vacation, so I won't apply this until January.
Other drm-misc maintainers are free to apply sooner than that if
they're comfortable with it.

