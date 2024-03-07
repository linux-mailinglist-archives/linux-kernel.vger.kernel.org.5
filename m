Return-Path: <linux-kernel+bounces-96178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4912875823
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C7E1C21A92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E21384A6;
	Thu,  7 Mar 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJSu/7BI"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411941332B3
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709842722; cv=none; b=snUMLq0tD26H8HSB+GHpdYQZPTR5dD0PCJWSQhNWlLh3w2K8REcSaWd8R1hioYr5I4LPuigPnEXgfjMcm69sSSAE+55XbL6+Ao+qsJD3kq8MnJJ+86JlWCIID8za9H2bzdLKLFZfqdtrxku6kWPcQJDuEhAyUe2EzvSyPVNzBEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709842722; c=relaxed/simple;
	bh=sUbCpYjNTBPADWmBmZOyBcxK/ihUSUaSQdgDSHI4MIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tr/kpExUG0+td9JvAV37upMMLRxg5wy47fpLL0gVPdvlSCVZJzOvw95Y8iOjaNVmdyJqcjDF+YTax8K3nfYNdv9mjgDvPYIJDmdHRDx5j95vGolu03Z6lRLN9VX0aPjbfivKoVgCG+CpEWAqCKV8aXjdb6i/aHNv2FXYJZqv4dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gJSu/7BI; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e4da29904eso694867a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 12:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709842720; x=1710447520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MCQxZzA+X4VwUId6l+G07DVSjCf5LO0NLL8gGAxMXc=;
        b=gJSu/7BIFCqsbycnRGE3G4cx0Y9tP1SSFkzKAkviVRH6mZiYpGvOkvdaX36hfXQZRL
         xdFAVNYW9X+KTo05mhIPhWUPaTnk/42SLGGtAfeIZjfAw96hapEu44Kth3knrkt63crE
         cM60faOXdOi05R0X6XfHhYm7wObjLQrdfozp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709842720; x=1710447520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7MCQxZzA+X4VwUId6l+G07DVSjCf5LO0NLL8gGAxMXc=;
        b=hFkH+8lymTWNIZwz7lcOLpOxAZWsnbs3HsqiTvJ6ZX4G/gi94zn6h/SgQxm0/d3o7i
         XcVugj9jTHjRvPvvLuTS/92Dm9EN6qiRDvNSPgj3w47I6Lei/kQiHAUok04xh7WLD5oG
         Uju9LHt97G+TqA5lq0YE9I4uNrCi7F2F0Lbw75vCt6frY47Zxn8MHdbGPJUN8jb5/IQj
         yppwT/A4QpNCl8w3FNaoeAaiBq1m3G8wcmaMKsynfjnqfDfL5x/2SlBboggQVPWSaqYb
         fBl/lGR2dQvozUT3gUyk+KmYE1W/zqJJmxNJpnMawxsctqzzAYJ/ygMltcPCymGdW2cD
         Y0sw==
X-Forwarded-Encrypted: i=1; AJvYcCUGVssCsDu1bfkqI0RJVHkNzk3ZIdLuVXYyS8Qk8FipdB5w43gtmwQA1VvObhYLRZ0ALy5zpqlZnDTVb7nTkiPMhTV7VxY4WW+5w6Nn
X-Gm-Message-State: AOJu0YxfbqQY+zJmFnrpyEqLf/Ni4AW45kRv7YNGQOx8YQYCUrxZiLq/
	S5tpIRJ88V/45OBLQXGI6HvdyXRvFCBZ5Al8Ofr6kB+bMUwXzSDGpvfF8kPWD5i8GU86AILIihR
	7ITKzNa58rykujYvt3qbElDfyPVa6QF+WtQdD
X-Google-Smtp-Source: AGHT+IHnQWZq5sTkoFgDP1OClhsVZQSs/T5a+/TDdaivOzpMFvr9a2x5ufdUSv5PqX6045dLB9IK5AV4mGBEBemRhEM=
X-Received: by 2002:a05:6830:2052:b0:6e4:8c94:bf6f with SMTP id
 f18-20020a056830205200b006e48c94bf6fmr8906984otp.37.1709842720376; Thu, 07
 Mar 2024 12:18:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-7-hsinyi@chromium.org>
 <CAD=FV=VvhKZHVzHQdOO=_p0E5m7ig1LY2s5MZRojRynKHbF1xw@mail.gmail.com> <87msraw4q6.fsf@intel.com>
In-Reply-To: <87msraw4q6.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 7 Mar 2024 12:18:14 -0800
Message-ID: <CAJMQK-izRv18V1o7_Q23vWFXQsFgaR74xxZ4Vby0FVtNn21TMg@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] drm/panel-edp: Fix AUO 0x405c panel naming and add
 a variant
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Doug Anderson <dianders@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:28=E2=80=AFAM Jani Nikula <jani.nikula@linux.intel=
com> wrote:
>
> On Wed, 06 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.o=
rg> wrote:
> >>
> >> @@ -1009,6 +1009,19 @@ static const struct panel_desc auo_b101ean01 =
=3D {
> >>         },
> >>  };
> >>
> >> +static const struct drm_display_mode auo_b116xa3_mode =3D {
> >> +       .clock =3D 70589,
> >> +       .hdisplay =3D 1366,
> >> +       .hsync_start =3D 1366 + 40,
> >> +       .hsync_end =3D 1366 + 40 + 40,
> >> +       .htotal =3D 1366 + 40 + 40 + 32,
> >> +       .vdisplay =3D 768,
> >> +       .vsync_start =3D 768 + 10,
> >> +       .vsync_end =3D 768 + 10 + 12,
> >> +       .vtotal =3D 768 + 10 + 12 + 6,
> >> +       .flags =3D DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> >> +};
> >> +
> >>  static const struct drm_display_mode auo_b116xak01_mode =3D {
> >>         .clock =3D 69300,
> >>         .hdisplay =3D 1366,
> >> @@ -1990,7 +2003,9 @@ static const struct edp_panel_entry edp_panels[]=
 =3D {
> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x239b, &delay_200_500_e50, "B1=
16XAN06.1"),
> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x255c, &delay_200_500_e50, "B1=
16XTN02.5"),
> >>         EDP_PANEL_ENTRY('A', 'U', 'O', 0x403d, &delay_200_500_e50, "B1=
40HAN04.0"),
> >> -       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "=
B116XAK01.0"),
> >> +       EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "=
B116XAN04.0"),
> >> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, =
"B116XAK01.0 ",
> >
> > Remove the trailing space from the string above now?
>
> Maybe it actually needs to be considered part of the name; see my other
> reply in the earlier patch.
>
I randomly checked 3 of the AUO panels that I had a datasheet with,
and all of them have a white space padding before \n.
The descriptor of that field is marked as "Reserved for definition",
unlike other characters, representing the name, which are marked with
"Manufacture P/N".

For this example, do we still want to consider the white space part of
the name? I know they didn't follow the spec exactly.

> >
> > Aside from that:
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> --
> Jani Nikula, Intel

