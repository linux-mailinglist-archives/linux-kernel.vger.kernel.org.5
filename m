Return-Path: <linux-kernel+bounces-30418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813E1831E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B462E1C232C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21AF2D045;
	Thu, 18 Jan 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L1WgNdyJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CED2C6BD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599021; cv=none; b=RLAwHFucJRcUBmALJaIuVEHxn1lLI4Qw6S266ptSr3E4zFjExQEL/A9GzOA6MiQYuU3+FIG++IKbLVKpBfB6iKIXV/3svyM42Gf0upZuO7cMCQNS163QXW+O9tm9hW4SVKsM1aeya8OiWiEXiIMCwANPT9MDsu5XgkgEtgqvT/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599021; c=relaxed/simple;
	bh=jwgOhtKY/5lR8g/lQzQolBnGggAkSyhlgpnhMHHbS7s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=s2lKLFEnqKpJi8uEpxCTcQCNUchGPzLwQBLs2ecW75dwtqAxPq4B5zJ3GmeXOUl832kj1vhLtX4sx6on5bdWTFtkOgtWz2A0r+lTxvpUZYfSTJF3LYnv+wkzlHHCSyqBVi7q7wsDRRkXDgPOEEkWKd+YMUi56pO8byb6MWFjoak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L1WgNdyJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a298accc440so1527813066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705599017; x=1706203817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwNcp/1wsK+xewFwI+40R4Zgg1iQ0Qp0zna44R/fhyE=;
        b=L1WgNdyJaC+W3XHhCrCG0Lm1t9gp53OMhSR7qP7uAgijzTJH2Me0m9lNyc+l6rDLqY
         uBk450+FB0PaAPTvQd1R9iImhCYclsjDFRAFNEJyoCGS9bpTu58SbfEHmd8h42ccOTcx
         +F9tdejdfTQi2xhL4u4BLcRtvgA8F0IOm1Dok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599017; x=1706203817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwNcp/1wsK+xewFwI+40R4Zgg1iQ0Qp0zna44R/fhyE=;
        b=Fx4J37ch5agskQ9zdiW3/dZNx4pAsIHyQ82qNGNPzcfKUcl8gTwE8atWCwawGm9xsK
         kcDc3GyULEpKwFNdBvS0iLoADkaVkyn4a0GN1k0Tc2cfBVzLKL9wc6wcrzRALcE9q4sb
         JYKbbNlRno7BGJ0+ily4mM1arTLuELhwUIlfuHG0A2RfmAGiKZjwGuc37TfoMOj2Ypp4
         hlQNTTpnQkGQRCzL9lVTzVloMejaU/Aq6bR8erXkDhrodS3eud3nh4FHlBkrpSgUI2Eo
         0hsOGssa1EtVF2eHZ8lSZQ4Ha4x0eFoOVbdmZc4oqr+YQmYAJBvXZKqf2kEU6BhCeY6X
         +oHQ==
X-Gm-Message-State: AOJu0Yx17OdRtlWkhBPYhWVNWqyKkt/BjiU9HacVb1ptVa7d8rP7mYou
	gWUDxtnovN7IAn6ipcbTYq/IZ7FO0IL8oLwF4GWxGczZAVli83pawIkHgpHkq2Qw086NndMbg7h
	M1eDz
X-Google-Smtp-Source: AGHT+IEZpyWlW+1dvxdp1cfjoSSgGEFRQQKEs5Ch38x4fCvFhxLj0P0YIit67Nz/IhF/npa1WPNvCw==
X-Received: by 2002:a17:906:6d19:b0:a2c:e148:e2d7 with SMTP id m25-20020a1709066d1900b00a2ce148e2d7mr750134ejr.2.1705599017714;
        Thu, 18 Jan 2024 09:30:17 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id wb3-20020a170907d50300b00a2cc6398083sm8307071ejc.10.2024.01.18.09.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 09:30:16 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5097150fso41425e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:30:16 -0800 (PST)
X-Received: by 2002:a05:600c:1c10:b0:40d:839b:7844 with SMTP id
 j16-20020a05600c1c1000b0040d839b7844mr119323wms.6.1705599016285; Thu, 18 Jan
 2024 09:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118015916.2296741-1-hsinyi@chromium.org>
In-Reply-To: <20240118015916.2296741-1-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 18 Jan 2024 09:30:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYm0=uyQMf8yZpqaCWN2dympTt_bUVPOe+nafBLdS_DQ@mail.gmail.com>
Message-ID: <CAD=FV=WYm0=uyQMf8yZpqaCWN2dympTt_bUVPOe+nafBLdS_DQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Ensure bridge is suspended in disable()
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Xin Ji <xji@analogixsemi.com>, Pin-yen Lin <treapking@chromium.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 5:59=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Similar to commit 26db46bc9c67 ("drm/bridge: parade-ps8640: Ensure bridge
> is suspended in .post_disable()"). Add a mutex to ensure that aux transfe=
r
> won't race with atomic_disable by holding the PM reference and prevent
> the bridge from suspend.
>
> Also we need to use pm_runtime_put_sync_suspend() to suspend the bridge
> instead of idle with pm_runtime_put_sync().
>
> Fixes: 3203e497eb76 ("drm/bridge: anx7625: Synchronously run runtime susp=
end.")
> Fixes: adca62ec370c ("drm/bridge: anx7625: Support reading edid through a=
ux channel")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Tested-by: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 7 ++++++-
>  drivers/gpu/drm/bridge/analogix/anx7625.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)

This looks good to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I guess this started showing up more because of commit 49ddab089611
("drm/panel-edp: use put_sync in unprepare"), right? Since that's a
recent commit then that means there's probably a little more urgency
in getting this landed. That being said, it feels like it would be
most legit to allow this to hang out on the list for a few days before
landing. I'll aim for early next week unless someone else has any
comments.

I guess we should see if we need to do something similar for
ti-sn65dsi86 too since I could imagine it having similar problems.

