Return-Path: <linux-kernel+bounces-85917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB7486BCCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375031F256BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92233CF5;
	Thu, 29 Feb 2024 00:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QUXX0qf7"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B672E62C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166089; cv=none; b=GGWJEmVP++bkJv+W2tBhNrLTfhss3foGoWgVfU2R17IvIFA6fDhhujlrh1ZJN+K2Ky5Lf5KUSbS0Jx015XJcX72jZG6Oglz8mlPwcHs9VmM4PEhr4MT/KhEOssi7m1N2k331cZRP8/TYHIl5RI4vjQxUKLwvwOrT2OEWsBrvGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166089; c=relaxed/simple;
	bh=we7L410hzlkE824k4ux/TaNifLOD0owphQTDsmcNOu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IeBzS6JgEJmOvyrLkBRPXc5oZyuEEaNLTH13PhWR5nTsV8yCGZ17jT27rUfKCfbiPoEx8i5mwC/K12H/BFfv2cSxVj7Q9kOl0tahvhTVJ51nVNnlldH88MJ9Debv6lid+YQQMLq1RnZhO+5w+RW7C1LndgUpYMeVv1jR4mal+DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QUXX0qf7; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56533e30887so480211a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709166084; x=1709770884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HVmQOCE5dsZxHVlTQMXFLciN4XwV4vxvdF0QHFS3GY=;
        b=QUXX0qf7DaiAOMHiJ0wciGxj0lBVnNzceqAZMeCywZqQ99cPGrV1YcesOslpXN5DrM
         piEKeUo/SS38oKNFaBbMtOG20Gh634/X2ZHnXQbao1LV8laMqWYGpv/XiC9UHrQX/8DO
         KlBiVKmN5ZZ2mm/ztpuaWiR6N2dH3c0RCCjKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166084; x=1709770884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HVmQOCE5dsZxHVlTQMXFLciN4XwV4vxvdF0QHFS3GY=;
        b=M9TWdKjfnTbYPfSdGFvk0f2faAarMP90bGYtrBOQFhYZMXQkwLRLMc4btz6Z0mI7r+
         2p+2Y+2VTv46gMFnOoZc40Q6QzZO8Sx64OPLLfnULuUmeRMMcEZ1eOuPBR4FrhNO392l
         aT3ZVINtWU9z0mdDodadw4QXhd+e5CfDqwwz2MZ7YOB+Xso/P6sr3XmcdJLAsiq/fOI6
         YSKiUoUPvpgcDEa0XVMMoV9pwIsRO/XIAI22Cu9ocRNg7HDi0aNAJ5Co/4+gZhjekb1m
         yfF6c/J6BHrvsMIpbNk1odMiPvXDRozhUkK9mUYrZ3Ktr52H4nL5H3dOqs6rD0j17T6q
         vTLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV6jjxLzZaOssXutil93rdb9s4cFoC4soDhZpyT4Y9nv9WAgxt12B/ktjFsSpsWCfKNkB+1viR3oqfM1UOToZ8MRWrUmMoO6XhDPNk
X-Gm-Message-State: AOJu0YxkzPed94ayZoIjtrzr5ud+x0GfIYtvX2fbt1/JBjC6NsSQwOEn
	hd7VFPgGa6rzAmNPa2okzxlcuLV9kOxDboS1r2qgKPFcbdSbfBFWgd4lMYYNjOor123c9bS0jT0
	x1s+o
X-Google-Smtp-Source: AGHT+IGbKN3NT4J5aTlC8degSjqnr6WafllYOPa2/sWlG8mkPIHF85R0xMETHckK5WnSgO7ijb7puQ==
X-Received: by 2002:a17:906:1b03:b0:a40:bff7:6e73 with SMTP id o3-20020a1709061b0300b00a40bff76e73mr264086ejg.36.1709166084385;
        Wed, 28 Feb 2024 16:21:24 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id d25-20020a17090648d900b00a4339b8b1bbsm64189ejt.212.2024.02.28.16.21.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 16:21:24 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4129a5f7b54so15445e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:21:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2AfhJT/q2E7oG6wZxdEnf3ZsHjo82i/P9hFoR7I+OrJz5lB8zB7HWdLn2sgmVp3/YT7LXqlnMknGFlf37Amdp9xAMI29rOceVZs2f
X-Received: by 2002:a05:600c:34c7:b0:412:acde:4839 with SMTP id
 d7-20020a05600c34c700b00412acde4839mr1564wmq.3.1709166083091; Wed, 28 Feb
 2024 16:21:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-2-hsinyi@chromium.org>
In-Reply-To: <20240228011133.1238439-2-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Feb 2024 16:21:11 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XCGCpLmCQhfTXfrOON99KLbR5pR59jaiD_V14szn6qsA@mail.gmail.com>
Message-ID: <CAD=FV=XCGCpLmCQhfTXfrOON99KLbR5pR59jaiD_V14szn6qsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm_edid: Support getting EDID through ddc without connector
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
> Some panels are interested in the EDID during early probe when connector
> is still unknown.
>
> Add a function drm_get_edid_no_connector() to get edid without connector.
> No functional change for existing usage.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2:
> add a function to return the entire edid without updating connector.
> ---
>  drivers/gpu/drm/drm_edid.c | 45 ++++++++++++++++++++++++++++----------
>  include/drm/drm_edid.h     |  1 +
>  2 files changed, 34 insertions(+), 12 deletions(-)

I'll respond in the discussion in v1 too, but overall I'm not a fan of
reading the whole EDID twice at bootup. Personally I'd love to see us
to back to just reading the base block like in v1, but I guess we can
see what Jani and others say.


> @@ -2385,18 +2385,20 @@ static struct edid *_drm_do_get_edid(struct drm_c=
onnector *connector,
>         if (status =3D=3D EDID_BLOCK_READ_FAIL)
>                 goto fail;
>
> -       /* FIXME: Clarify what a corrupt EDID actually means. */
> -       if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_BLOCK_VERSI=
ON)
> -               connector->edid_corrupt =3D false;
> -       else
> -               connector->edid_corrupt =3D true;
> +       if (connector) {
> +               /* FIXME: Clarify what a corrupt EDID actually means. */
> +               if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_BLO=
CK_VERSION)
> +                       connector->edid_corrupt =3D false;
> +               else
> +                       connector->edid_corrupt =3D true;
>
> -       if (!edid_block_status_valid(status, edid_block_tag(edid))) {
> -               if (status =3D=3D EDID_BLOCK_ZERO)
> -                       connector->null_edid_counter++;
> +               if (!edid_block_status_valid(status, edid_block_tag(edid)=
)) {
> +                       if (status =3D=3D EDID_BLOCK_ZERO)
> +                               connector->null_edid_counter++;
>
> -               connector_bad_edid(connector, edid, 1);
> -               goto fail;
> +                       connector_bad_edid(connector, edid, 1);
> +                       goto fail;

This "goto fail" is now only run "if (connector)" which means that
you're not properly checking if the EDID is valid when "connector =3D=3D
NULL", right? That seems like a bug unless I missed something...

