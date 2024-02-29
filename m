Return-Path: <linux-kernel+bounces-85919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65EF86BCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC11C218D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FF4437C;
	Thu, 29 Feb 2024 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxX3sTBd"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA728E7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166142; cv=none; b=sVLtbEoRrcdXBbJXPzjWW22Ez1bPx3aCRwqVtuoSM8e3e3ye5IC7e9p9ZS1DWx+N0V/j4+56KbeBiGuNQqK8EdG4yr7p4np1+dZ0O5uAhwsr4RZCsCBlj5SzgfGNeU+t2RIIAN3ZY3AXR35UMQmQ1vFAhAsfKt9xTPykcopAwtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166142; c=relaxed/simple;
	bh=yamBG7+SHLm8jN6q8a3z+79alQVKKcGp6W7stVf6DoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rdrr8K3lU6gSTyHVXFyFKCukCsu3IagNIuEzU/0ygyqn2M6c1sdTzVe5OjKMLl7oHPEj52spsAEshwqGGKduhXZbn9DdbbHPrKkDDLmHfrUdUGINdSB+DR3CAkEuJBoIr8C9FdyGnpc82uDyIq6oj7IXG/M8ZaobQh5w6D9YwZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YxX3sTBd; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a43dba50bb7so50084066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709166137; x=1709770937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mE5RQXDNdhEusYdLETG+sg8aAl7cMprUY6xe9cmq2GU=;
        b=YxX3sTBdljv0+awxzR4RzY5OnM3Z6hDPgnWMAGGGxFd6ZP/tG0Rie+CgjSwrvkwVtJ
         cP8eBs8yOjK/cx5JxnuwsRQSTOXdnboMRLchTW53CTKv1pv2v1nrHEqGVvqHHrkV1Ecb
         qZYES/pagbTf2KqhShOwvfX9L++MjRgjxZNb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166137; x=1709770937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mE5RQXDNdhEusYdLETG+sg8aAl7cMprUY6xe9cmq2GU=;
        b=A63oMsK9vsM0YttPbHoTKO1nOHuDGQNbLktkPSR6GBv+zPJwu/tc4RU1KXlnrMKRWi
         lmhyNcWw7TrvCKsZdASxVpB+xXSUDJFIaedsC6qsixTluNWWlLE7+mOprhoFhCM1/Yc7
         NNCREzljmhTsRNDHEgZu/4nLwuWrFaWBY6HAuPGfCfs2aXC1q08N42D1OOH96E17dTNM
         Zh/MnjOMyJCUPzezKPygT4/JC3P7cKkb1DEzeK3SMKzaCGl0axeuz4iEnvVOcUPD/3Nd
         T98EV+l4EM+7ECXlagRD6ny+1Rz6H3e+FJCuTp6+wIdaeGQEvVFXmHncoVAyYG+uWeig
         uXDA==
X-Forwarded-Encrypted: i=1; AJvYcCWkLWyKNH8E8XDBMhHnmR5j8Z3ZZoiooUwOpi2SVSS8xeES20rRFXfVPijUB8ZSEbPAqFxWuslJTxSXFITg+PzIfN1iCJOtHQvQ3s9V
X-Gm-Message-State: AOJu0YyNbmvTMqp6GPEX4w9iTduysLhMqcev74TWCx3gkdKu6KdthWnw
	UZ+ROX8E57JwHPFMWEuP5q1tGPlLdMLYKKTlEXaKKn2a9CNoVtSlVdqWRhm0qmsGqF1Z8jMtDKZ
	O+v0O
X-Google-Smtp-Source: AGHT+IHjY4tTka+NgHo9/CeqUFHojulcG74KKxPoDgdTIeML8dIIrcDuxs4X+UCO68CQ9q4bIiCMgw==
X-Received: by 2002:a17:906:884:b0:a43:68b:6a3a with SMTP id n4-20020a170906088400b00a43068b6a3amr227887eje.65.1709166136925;
        Wed, 28 Feb 2024 16:22:16 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id ot7-20020a170906ccc700b00a43c3e5e008sm65407ejb.205.2024.02.28.16.22.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:22:16 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so15685e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:22:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUOt+DDDtRUsB1F38tRAjw08Z+hUAOSdqOuqT2BQKC+3JydWtn8/A8IDCosnwoy7hBWEH5NeJOZasWQc+u9FET89d1gOkRIHcK8MRNm
X-Received: by 2002:a05:600c:5185:b0:412:a039:945b with SMTP id
 fa5-20020a05600c518500b00412a039945bmr43892wmb.0.1709166135473; Wed, 28 Feb
 2024 16:22:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-4-hsinyi@chromium.org>
In-Reply-To: <20240228011133.1238439-4-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 16:22:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
Message-ID: <CAD=FV=VV6fprky=v9koiVGmWcXKL3V4F2LOu7FriPbT_zT6xyA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel: panel-edp: Fix AUO 0x405c panel naming
 and add a variant
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> There are 2 different AUO panels using the same panel id. One of the
> variants requires using overridden modes to resolve glitching issue as
> described in commit 70e0d5550f5c ("drm/panel-edp: Add auo_b116xa3_mode").
> Other variants should use the modes parsed from EDID.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2: new
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

The previous version of this patch that we reverted also had an
override for AUO 0x615c. Is that one no longer needed?


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
6XAN04.0 "),
> +       EDP_PANEL_ENTRY2('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B1=
16XAK01.0 ",
> +                        &auo_b116xa3_mode),

The name string now has a space at the end of it. I _guess_ that's OK.
Hmmm, but I guess you should update the kernel doc for "struct
edp_panel_entry". The name field is described as "Name of this panel
(for printing to logs)". Now it should include that it's also used for
matching EDIDs in some cases too.

