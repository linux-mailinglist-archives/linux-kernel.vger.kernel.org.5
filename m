Return-Path: <linux-kernel+bounces-94716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C128743F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00761F21266
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30661CD39;
	Wed,  6 Mar 2024 23:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9NWqJ5m"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A41CD29
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767848; cv=none; b=FS/EfZ1J2634CzRyeYiBz/WHo/M1Ag8SuZAPiMHSrX4PHlGPhef/zGuNaq90jk6qejD7XPybcIdRx5+2nmlpMTooYEiD14E/rlJ7fa2CQAC/lHhaY3W1/7atMMdsJtjfWRWIlt6aVnUuemfLocZzkHVqjcZ++lYyGD5gGDOyQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767848; c=relaxed/simple;
	bh=ieEKZjdTWSiXB1Cq5DltRH5aYblKtMQdGVpzZK6y3e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXmgdQLZ6TS087GC0L5f9mtxi+r2nEBg2W5vvU7Qd5wmOMyTc5Ekf5DB1liOe0F5zAeQxxQ9HEnoZdc5QXUmK0kJIvdO663W7ikZ/lRteZMQd3dSo9Cac9yctaRLiEpegNqhY9B7sSSFR7UnS8n+mfFn8PrTmGwWTGhpffI0qZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j9NWqJ5m; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690a0c8a6a4so495226d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709767843; x=1710372643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9T8NOESVHEKZJ+Km+dtXiN45KTXenjEtsmbvdRzQv4=;
        b=j9NWqJ5maVs4MIH8tyDg1o02FX/xJSvtrrfxuQ/b8LxGVhX/ELnqkwOxE94QiEb9Ox
         ZVPwEK//u67FZeRJv0Icw6oAXreHbzHoV683cFvlX52HsXK2QB8iTIah5WgPs/OsK3vX
         myrH3nWMJPfOGqMS8FosnEyef93FMzGaMGRr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767843; x=1710372643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9T8NOESVHEKZJ+Km+dtXiN45KTXenjEtsmbvdRzQv4=;
        b=ZSCo/oYBsOIYGw3riGqGlnB6URu+EaiKpXvsZwswvX5gFsYjCYmgdd8x+Iw7lZ46+O
         lWAWEpD3PZW9XRDeuhM1MOLpU1UCqTZqWdmq5KAcgxymbj1ibQrmICobs4uNbhg4+FJq
         Y7Vo2yj7LC8VqTmC50R+2b0zu7j8ITUfkCib11MgrtAKLtRJPw6nMcu3WXGZovOajsj2
         16EIXfHcFsAcmHnK6z9TX2yzyusb7nbe6U5gE3vhdpk28Cj6DfE3tlg98UOl+m75KPOy
         DOiwnFo2MUYhJpH4Vr/CogSHKX2uB6ZsehRvJkE0ilVkMB/h6GJKx343GpcjI2Nd5NEL
         HmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCw1NTddWLfCNRhT016ccL8bXWd2uTheDStXsn8uugDft4a6uSmyMuMSQGF/dN7S3jt9TFddY/2Km0N9HOkHvEYE1kJ8Cctgv0UVXW
X-Gm-Message-State: AOJu0YzX6M64Ocw+0lM7RaVCsrxe5sfS1s0FG4UVaPeSENk1rmNhnHuz
	ADX1IsZpDgGY22zmmN7zBIV9wS12J8qZHgSYiLQNyIjo67cuKxPiPwhJuDZ54kMfxW6csecn/uY
	=
X-Google-Smtp-Source: AGHT+IHavaBnAjRfEe1r9T373mJ61nTj+24LegF7/1ZLk3k2ZGPg1YvKiWsUApmLnNO/2d9UA74Tmg==
X-Received: by 2002:a0c:aa97:0:b0:690:9d2d:52c9 with SMTP id f23-20020a0caa97000000b006909d2d52c9mr1406030qvb.25.1709767843708;
        Wed, 06 Mar 2024 15:30:43 -0800 (PST)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id pj19-20020a0562144b1300b006904c34d5basm7553659qvb.64.2024.03.06.15.30.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:30:32 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42ee0c326e8so119531cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUg+TS3/fivFMCwtX8m/ggXgjP/eQ2dR28clmBKGdh6BDeM7rylE0pv2ATpvfFRnpkiox9qDPhGphWuXr9ZM5jDPkO0yLxLMYMjpb8p
X-Received: by 2002:a05:622a:1190:b0:42f:a3c:2d4c with SMTP id
 m16-20020a05622a119000b0042f0a3c2d4cmr111258qtk.13.1709767832191; Wed, 06 Mar
 2024 15:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-7-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-7-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:30:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
Message-ID: <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and add
 a variant
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> @@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01 =3D {
>         },
>  };
>
> +static const struct drm_display_mode auo_b116xa3_mode =3D {
> +       .clock =3D 70589,
> +       .hdisplay =3D 1366,
> +       .hsync_start =3D 1366 + 40,
> +       .hsync_end =3D 1366 + 40 + 40,
> +       .htotal =3D 1366 + 40 + 40 + 32,
> +       .vdisplay =3D 768,
> +       .vsync_start =3D 768 + 10,
> +       .vsync_end =3D 768 + 10 + 12,
> +       .vtotal =3D 768 + 10 + 12 + 6,
> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> +};
> +
>  static const struct drm_display_mode auo_b116xak01_mode =3D {
>         .clock =3D 69300,
>         .hdisplay =3D 1366,
> @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B116X=
AN06.1"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B116X=
TN02.5"),
>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B140H=
AN04.0"),
> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAK01.0"),
> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B11=
6XAN04.0"),
> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAK01.0 ",

Remove the trailing space from the string above now?

Aside from that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

