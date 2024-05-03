Return-Path: <linux-kernel+bounces-167943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460D8BB169
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5991F21F1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCA8157A61;
	Fri,  3 May 2024 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8FLlKSg"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CBB15748E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755837; cv=none; b=a7F47YgPO0vorc+jjVZ4EpyFSD6W1HQJOmtDxygOTZOkTN0HEj5QttwXHULjxp8TssgYlRCntlWstiw/V3L8/UgyAh89W1HpzLRuKPy6Qz8Hf+kdvouu5PQT0WHyCjH/KHGJ6OBjSV+tKA+/arkW6w5lp1GIcBsMCJT8eZ4h1cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755837; c=relaxed/simple;
	bh=M/M9DK6x69gq9IrFL3EvliQhSNiVz2ig5naXalFUUzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJY/NddV1MlzqukROd1l6yUL8TlFSTHuVrjQdOTYwu1qHlhR/loc/JmONB9/nTcWZncrKawDjccYCxjQNyvf/QBnTBVVblYsP/n3uOtMAb+aQGPTpYualiUHB00tRrYM3EYbXozpZKZttva0Obth9y1CKQWzwha/kICzA6aJQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V8FLlKSg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-78f049ddd7dso719686185a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714755833; x=1715360633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVSe7pluKfDVQULV/YyS5WvGtcPrWiyKGEQwMLGF11s=;
        b=V8FLlKSgtW32O54YEsFjMwLbr3jhdrvZKfIMYR1pgMxsZydOqBocNf66UW5MWHRKS/
         Q9QnpoRPVILAy9K6Z/kWIrvo0ZvJctZsDfMSyEHtHgYgs8MfZ8A1EDqljCgUJWCqurDz
         LwphuVwlPFv33bG7QJmzsRQM5i2NGRg52Kmec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714755833; x=1715360633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVSe7pluKfDVQULV/YyS5WvGtcPrWiyKGEQwMLGF11s=;
        b=o52iZQALsi6GW7YHJybOhGvAdIuvaceBWNLJ9Na1IWDiJQ1qNPGzdxnssS9ejQfEqq
         mKdZGq5tnbaoGcksDvBfESijOTPKJWcr1FcUJxIgNtd0pYVto7iyh3bIAu0tHhRfPbPQ
         w+iO2oX7PTRJfMFqSep50S7EEm/qDtefj9mjuUVqXRXD3Ty1EsbI7rFhljRH8Z2ux8cq
         WwD0/3uM8ZNwZ4hQHw9BAVMZJ/LzveW3WdgJywF7SVScICCSy7fjDQMg1VV+4zfNYSo6
         /xeiHQAOaH3jnynH0dFaUN5p/Jf63B6yGNYsG6ois8EExaIxNipXyxlfHq5myYlkrk7S
         QvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGdTcXVuSLU7A9HLb67qmjYWoI7jNEBQdfGTK8edvhWqqL8TvOHo2r0lqvL5OwHBohLA511l0BkVYKm8KAohJWgMmiUtOR7QyPtB0D
X-Gm-Message-State: AOJu0YyzwtP+xd05nRuJbwK5b1K3x+PCPzuB2pc45XdvKjT+3g1g0QYr
	g+zVTUU3boMuEkgheYGfoAAzU2n580GSqlr3UBe4gVPhYIbCKYLOX2I491w12TPNpEGywGsvxJI
	b9Q==
X-Google-Smtp-Source: AGHT+IFBliCcie8F5Mx5Xk8B/aMBShUL6UyHOp15HyV5l0SY9z4NJ8zWAWr5Bnnv1Ev3Y0DHzLJL4g==
X-Received: by 2002:a05:6214:b6f:b0:69b:3661:6d34 with SMTP id ey15-20020a0562140b6f00b0069b36616d34mr3679230qvb.25.1714755833554;
        Fri, 03 May 2024 10:03:53 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id e3-20020ad442a3000000b006a0d72cd7fasm1359033qvr.86.2024.05.03.10.03.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 10:03:52 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43ae23431fbso1771cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 10:03:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhtRvVOVYXL3v+g3c+7Cf/uTCIqrex52+TOXcLAgq8qWHYoo3a8ewcXkBnGEyGr1v1j9IUtD4Cdt0KIln37TL3gvWFpj+Ez+bD+zPn
X-Received: by 2002:a05:622a:1a91:b0:43a:c278:83f9 with SMTP id
 d75a77b69052e-43cdbebd9ebmr3461811cf.3.1714755831481; Fri, 03 May 2024
 10:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org> <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
In-Reply-To: <20240404-drop-panel-unregister-v1-5-9f56953c5fb9@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 3 May 2024 10:03:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WVyRGevshhkhzuXht+ePm3BXVyMhDOPOkFs72wZS_s_A@mail.gmail.com>
Message-ID: <CAD=FV=WVyRGevshhkhzuXht+ePm3BXVyMhDOPOkFs72wZS_s_A@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/panel: novatek-nt36672a: stop calling
 regulator_set_load manually
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Kaehlcke <mka@chromium.org>, Harigovindan P <harigovi@codeaurora.org>, 
	Ritesh Kumar <quic_riteshk@quicinc.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 4, 2024 at 3:08=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Use .init_load_uA part of the bulk regulator API instead of calling
> register_set_load() manually.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-novatek-nt36672a.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu=
/drm/panel/panel-novatek-nt36672a.c
> index 33fb3d715e54..3886372415c2 100644
> --- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
> @@ -605,21 +605,16 @@ static int nt36672a_panel_add(struct nt36672a_panel=
 *pinfo)
>         struct device *dev =3D &pinfo->link->dev;
>         int i, ret;
>
> -       for (i =3D 0; i < ARRAY_SIZE(pinfo->supplies); i++)
> +       for (i =3D 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
>                 pinfo->supplies[i].supply =3D nt36672a_regulator_names[i]=
;
> +               pinfo->supplies[i].init_load_uA =3D nt36672a_regulator_en=
able_loads[i];
> +       }
>
>         ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(pinfo->supplies),
>                                       pinfo->supplies);
>         if (ret < 0)
>                 return dev_err_probe(dev, ret, "failed to get regulators\=
n");
>
> -       for (i =3D 0; i < ARRAY_SIZE(pinfo->supplies); i++) {
> -               ret =3D regulator_set_load(pinfo->supplies[i].consumer,
> -                                        nt36672a_regulator_enable_loads[=
i]);
> -               if (ret)
> -                       return dev_err_probe(dev, ret, "failed to set reg=
ulator enable loads\n");
> -       }

Thanks for the cleanup! I happened to notice this commit and I'm
curious why you didn't take the next step and move to
devm_regulator_bulk_get_const(). That would have allowed you to avoid
the "for" loop above that copies the data ;-)

-Doug

