Return-Path: <linux-kernel+bounces-29407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A885830DDB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EEF61C23E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 20:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A6724B2D;
	Wed, 17 Jan 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="St78sYYf"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CBE24B25
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 20:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705522678; cv=none; b=IKMwvd5TIJ0esDU2OHCnkErEgOGzyXrL8BpiAah8slisK7+qk8Fc23geXX5Cyq4DNoXDSPIUZx/E/jcc3EbWZ6omO42mbOYuL1VXpRyJXu97nr3sCBFpgVMYomYnpfY2w8oXI2B+HXA4dWX+7247wZFlJaucPNzgc0aS4NuJ0pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705522678; c=relaxed/simple;
	bh=9EN9U2M6WcTO4kvqAssI2USJeGX9gxivbYmkNOhif20=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=WWA5xEUe2x+NosCwMByOsdXPMhIBxaXd6ycYKKkJCM5JSK1GPN54KzqBEBuWUbnOmyrVWs40jwWZPM+PLeem9XEjpti3izdAwHQMGUfSe4mqm31jXC7iGsswafTrylK+0vG0iXSHIWto1oWVS0gzBwA4KLo47eW67CDOUqmXKQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=St78sYYf; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a28a997f3dfso864075366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705522674; x=1706127474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EN9U2M6WcTO4kvqAssI2USJeGX9gxivbYmkNOhif20=;
        b=St78sYYf3ILU3GQR9LqxMbrE0QhHcjeCHivVbu0oX7sWqNidUXdE09uUHvi5d99qR4
         pDL40J0lPiMADN4f1u03r0nIss6ePtvf0l1H9fc9pGmU3+4WxB+OVezYnxcQtMsx/LeG
         76ji4WGMr8SjOAlvt9iBdP41swiCpBbm4W7zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705522674; x=1706127474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EN9U2M6WcTO4kvqAssI2USJeGX9gxivbYmkNOhif20=;
        b=dz0umTT5A8R74xmOvFjpfzr/8S2GvdGCLy+tsmwNEwETL+IOvplPngWkKeRrzOVeYG
         bpPtNVxsmsB9Ljo1UrvSBQXKy2nnfu7oTUUywGtYIZpriYM/7WqfrkBZpifoqxhK7x6+
         TG2uKccuUlHB2r/B/CSgLplV4QkAnOdKU+B4wMj+JMu7lRp6XlFRlAAMQgbzsRrZS2Gy
         fJZX0x3Ag8P1e1cQKwxnF9h+2rjwv9JFjV5qDIYXpkxwF/jd+8I+D9Wl0FinWy1yF8q7
         PR/kIG23wmUjCGeq/Q6h8huTWwzVEyMLJvuR9VQZb8SctEZ516vU2PjBo5B3eSDLVnqk
         dCPg==
X-Gm-Message-State: AOJu0YzT6G4EagjuXUSL+J80kQOUNv/7VerdtioH5S0CWjyEHQ9m6N4A
	R8m/HK9hHCWBHcrJVsKQ8j23Lbn6qx2+CrMDgVgt/fJ/ddOZhXM=
X-Google-Smtp-Source: AGHT+IH353QRO7qw3HlbylERf9j5uvgCiirmvwurmPRjqbfVQnRKfu79CuIQdqq7COL7ZVKQUWOJ6g==
X-Received: by 2002:a17:906:fd55:b0:a28:e3e9:bc8f with SMTP id wi21-20020a170906fd5500b00a28e3e9bc8fmr4074896ejb.32.1705522674547;
        Wed, 17 Jan 2024 12:17:54 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b00a2c34d90a48sm8152309ejr.138.2024.01.17.12.17.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 12:17:54 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e43e55b87so70615e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 12:17:54 -0800 (PST)
X-Received: by 2002:a05:600c:1c8d:b0:40e:5274:e2ba with SMTP id
 k13-20020a05600c1c8d00b0040e5274e2bamr205912wms.4.1705522191757; Wed, 17 Jan
 2024 12:09:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117103502.1.Ib726a0184913925efc7e99c4d4fc801982e1bc24@changeid>
 <CAJMQK-j_gEfZqWppG3oVNWBopH9uVK-NrzXvoSr=ijF2pMycDA@mail.gmail.com>
In-Reply-To: <CAJMQK-j_gEfZqWppG3oVNWBopH9uVK-NrzXvoSr=ijF2pMycDA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 17 Jan 2024 12:09:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UsnDMx+TV3JCAmboTdFRtpOQzQ1V0cw70PadCoXVNJ_w@mail.gmail.com>
Message-ID: <CAD=FV=UsnDMx+TV3JCAmboTdFRtpOQzQ1V0cw70PadCoXVNJ_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Make sure we drop the AUX
 mutex in the error case
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Pin-yen Lin <treapking@chromium.org>, 
	Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 11:39=E2=80=AFAM Hsin-Yi Wang <hsinyi@chromium.org>=
 wrote:
>
> On Wed, Jan 17, 2024 at 10:35=E2=80=AFAM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> >
> > After commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
> > is suspended in .post_disable()"), if we hit the error case in
> > ps8640_aux_transfer() then we return without dropping the mutex. Fix
> > this oversight.
> >
> > Fixes: 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge is suspe=
nded in .post_disable()")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Sorry for missing this in my review! :( Given that this is really
> > simple and I'd rather the buggy commit not be there for long, if I can
> > get a quick Reviewed-by tag on this patch I'll land it without the
> > typical stewing period.
> >
>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

Thanks! I've pushed this to avoid the breakage. If any additional
follow up comes up I'm happy to post additional patches.

a20f1b02bafc drm/bridge: parade-ps8640: Make sure we drop the AUX
mutex in the error case


-Doug

