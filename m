Return-Path: <linux-kernel+bounces-4095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3BA8177DF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB5728566D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBA4FF61;
	Mon, 18 Dec 2023 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gIHlwzk2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674671E520
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55365730863so1385131a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702918093; x=1703522893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6y3ll1JV4kECb7ETSXvUzgYXA9pzoacjYnpy2l56Ho=;
        b=gIHlwzk2OG6nGYkdTStHcjILMuQijdE9ppnAcueEX52QvBlMwAj9hcaGcxtqC6RlTN
         WVII5h+3uyN1jcisfLWrnHT4UwV/8opQoPae7VSyun9Jt0eIVf+Do5GZo/DtSeH4z7b8
         cGmyxuS6i17DKy9k0HKNvXw1gYZBOboaI+mWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702918093; x=1703522893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6y3ll1JV4kECb7ETSXvUzgYXA9pzoacjYnpy2l56Ho=;
        b=AxINYjA8KewIWVq6bR5PqHMwmU1kqVsRZhuYv1xH6daqDBv6s2gRvfCYGAa/yj0uAg
         SP7/owrTyOOUBMl6po68bNlvvcz5mtdfVks2i4ZwEzjxYS2+9+lM+IpCHIenroSTzXgX
         QE9hajJlchWP7t05awQjtgU+MFbCfUIHfXbGWnizYB9s+T6Mlicz/PSLVshjahUiNQfg
         prgsmRBYxS+lrg8ZrGRDdSDi/FpnYN7fu8fCMH97vpPUERa3pX9sganOyfAohHRjyYcd
         Bkk4+NmeLym2tqPnxh6awKse0pPEGGq7+Lyb/ao2Uh+RlvFSFtaO/MsBsVEQ7tFEz/Hm
         IaOQ==
X-Gm-Message-State: AOJu0YxSuFMUkIq+lvGY85IvdZohfOsuyx85U9EyCN+Y6L/bu0wmHMlY
	WRKx5QpoFkIi8WuAO+Zb5IlzPveeJWSrLVbNJn8Fv5f4
X-Google-Smtp-Source: AGHT+IEKeGWOlJl+q3xhM29JUVagW4nFrW6FepDbXLP0y8R44Wap+cWhG0oWy9tlXRUY66CNK1XOCA==
X-Received: by 2002:a17:907:944e:b0:a19:a1ba:da5f with SMTP id dl14-20020a170907944e00b00a19a1bada5fmr11747329ejc.134.1702918093543;
        Mon, 18 Dec 2023 08:48:13 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b00a23499cbb1asm2038976ejf.189.2023.12.18.08.48.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 08:48:13 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40c3963f9fcso92475e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 08:48:12 -0800 (PST)
X-Received: by 2002:a05:600c:1ca7:b0:40c:6557:733d with SMTP id
 k39-20020a05600c1ca700b0040c6557733dmr366346wms.0.1702918092382; Mon, 18 Dec
 2023 08:48:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123752.v3.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
 <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
In-Reply-To: <20231214123752.v3.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 18 Dec 2023 08:48:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U8eJ3J_zY2uaCYGcEjuxkNeTUd1ir33r1f0Xdk+nD3sQ@mail.gmail.com>
Message-ID: <CAD=FV=U8eJ3J_zY2uaCYGcEjuxkNeTUd1ir33r1f0Xdk+nD3sQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: ti-sn65dsi86: Never store more than
 msg->size bytes in AUX xfer
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Stephen Boyd <swboyd@chromium.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 14, 2023 at 12:38=E2=80=AFPM Douglas Anderson <dianders@chromiu=
m.org> wrote:
>
> For aux reads, the value `msg->size` indicates the size of the buffer
> provided by `msg->buffer`. We should never in any circumstances write
> more bytes to the buffer since it may overflow the buffer.
>
> In the ti-sn65dsi86 driver there is one code path that reads the
> transfer length from hardware. Even though it's never been seen to be
> a problem, we should make extra sure that the hardware isn't
> increasing the length since doing so would cause us to overrun the
> buffer.
>
> Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failu=
res")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Updated patch subject to match ps8640 patch.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Since the patch fixes a potential crash, has two Reviews (even if
they're both from @chromium), and doesn't seem controversial, I didn't
want a full week and just landed it in drm-misc-fixes. If anyone is
upset by this then please shout and we can revert or I can post a
followup patch.

Pushed to drm-misc-fixes:

aca58eac52b8 drm/bridge: ti-sn65dsi86: Never store more than msg->size
bytes in AUX xfer

