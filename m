Return-Path: <linux-kernel+bounces-56190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B62784C72D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB09B23E11
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A67F20DF5;
	Wed,  7 Feb 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iqb8A6OP"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B06920DC1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297753; cv=none; b=Iyqa0aaMXexOGuzvW0S9gXccTgWEKCH3RUnQoXWrIOPYwcLXar33qS+L5zIfYXeWh+M4vf7s4SidseBBPilJqUGr+piFmcHLCa5PIhIWmZ4JSgZz2BgCq26Ab0VjJWaQo9Ho8SYcpsVrpn6Is19FA36lqKz3bZuoZHtd1qyVL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297753; c=relaxed/simple;
	bh=PYnCfQ2DugAyGQ5Ih8ootlOhTX0uijvK7/6Xdhv/W/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpg/XJpzDLKQKYEtR8E75nTqic2GEQhguMCKyRxBpi7HXUV7kbSXzE0IxpONmcki1AVQWwlqJDF2GhthKwwQMNigEzmoBnV9uz1Gel4Wb/ScA0blfoIubAPIxBI5iZ3KRkp7/annVpCxI6+MHgP/pACEtJoYXE+0/ilc4yk3ZeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iqb8A6OP; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2904c81f26eso69592a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707297751; x=1707902551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oat139wFLSjfVKIsAZBBlXueAqHNZFThp0IjSSQQnHk=;
        b=Iqb8A6OPrfvtTkwTMTjprNLSxPZM2vTsfdqvYFkvhiWjZQ9LoM7VJZOqldBXMsyZTO
         xu3QzhOUnHAmgFLhZnP3WxvbmZsxEa58Ss5PtX+CvP7E6or8mBwvf9pJPXGNA4D8f1Kv
         O/HDuaEvW+y1ZWJBTIIXSi3DsnxkjXl+O79C9MpaX8SfHbz9SppGndblUJRUaDLvBUin
         JCr0L8OVrc9d+95eByRdaaR/9K2sLTJoL50VqQfWnp2as94/Spxxod6xjVQEZ3Bv/7Xw
         gm7jYFV6FQxMaiDfMDzlum7njwei+N06BRt0E7Ow9/gUZpncFJfPOPGj3KN5zK3eqXkr
         A9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297751; x=1707902551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oat139wFLSjfVKIsAZBBlXueAqHNZFThp0IjSSQQnHk=;
        b=Id6qMAtU+44XwarymutVthT/PCSxu0P67hFgDBeRAMMW70oU2ogchyxrmeZ0cO7Cze
         WGFNqaa8Ay/u/chxm+T9uD/1NGOJM+W4V4MBK98OyicWw6jnM6BHpO5XJSz9Mh0PYtLm
         U+BqtIvjPwcSdtN5pywMAAllxU0+yCPcc6ja9h6eksRxySk8OqY6c+b5Rfq7d5oZ2U0x
         FJCKwRO3xewdMyDbYCVv08WensAxKHd9khcr1IFf6wNpx/K/9epfxduP7e0q1mMegwZz
         /rSDyKgtg7rvXtXPzqbJR/ygWHFJlISh+H+sQSQz2ddZdYgl3dib96w3yyJnJkk5gTMA
         M7bA==
X-Gm-Message-State: AOJu0Yx1XvcXwNHgFz/AG0tY4W61E2S6YCAz9oiVrNxaaEy9i+4sNZRq
	Q0ZxDTUDZISWBzNNvJlwqNJ64uZ6Z1D9umolYaIPu/RD6+cS5zsvZiVMSUURMpcueMVjLG8L+96
	7V+biQcSxB9/ce3LCbCOJ+Lwdtik=
X-Google-Smtp-Source: AGHT+IFr9zk9YPtcwwWeLlC+0qNDxpzGCms5VGzeQLl7LWlNxnnXxGzrAQ1FGf43ob5qq9Fq30A0i7bCdw+JtIWPFmA=
X-Received: by 2002:a17:90b:3a82:b0:296:e236:f69e with SMTP id
 om2-20020a17090b3a8200b00296e236f69emr946735pjb.4.1707297751332; Wed, 07 Feb
 2024 01:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207002305.618499-1-aford173@gmail.com>
In-Reply-To: <20240207002305.618499-1-aford173@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 7 Feb 2024 06:22:19 -0300
Message-ID: <CAOMZO5A1yiXiLOtR=H_4vJYAMGwjpqrErCzvSkmLoB_f6_rN_w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nathan@kernel.org, 
	kernel test robot <lkp@intel.com>, Liu Ying <victor.liu@nxp.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adam,

On Tue, Feb 6, 2024 at 9:23=E2=80=AFPM Adam Ford <aford173@gmail.com> wrote=
:
>
> Two separate build warnings were reported.  One from an
> uninitialized variable, and the other from returning 0
> instead of NULL from a pointer.
>
> Fixes: 059c53e877ca ("drm/bridge: imx: add driver for HDMI TX Parallel Vi=
deo Interface")
> Reported-by: nathan@kernel.org

The Reported-by line format can be improved:

Reported-by: Nathan Chancellor <nathan@kernel.org>

Thanks

