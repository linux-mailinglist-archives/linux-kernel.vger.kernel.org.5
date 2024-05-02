Return-Path: <linux-kernel+bounces-166231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E06408B97D7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E0EB248CA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4405D55C0A;
	Thu,  2 May 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oG5pnS/g"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E732C60
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642439; cv=none; b=nxC9R338OnpcSsP/H49J46HQR24aA1v4bumaBHidXI89eCqiAJQJvjkx24HLMHH/phlKkfhC0Y4djAOVd6wA7ojWkTXKkXGwCI7tBqrYi6Dras/1ezr7gZw5tIZaqVuFDUqiZWU+mrU61Z93/yMJLwEgBQbsyI3xH6BzRmrUscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642439; c=relaxed/simple;
	bh=nkEb1cGpxGhnxIo11VL8ruy9enHJYVmsxY5j3gtXE/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD089HIGrXcYG/m9HqATi6O0+3ekzJUrzjqTh3+w6jOoe66i+3viU8UXDTNyYcEmM9tB9Se9HfDUmbQ2mfJdpPWhb7NX+Z0ldeZlY45WUjD1+UM/43BghwfADBOz9xS/hxG1IqanmFWYI86cQdIJEX0Qz6CeqND7ZNqi52NLG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oG5pnS/g; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2db17e8767cso92982251fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714642436; x=1715247236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUPIZkrFl6BEjtW1yyE61WicVfg6hOSYbd+LAsiXxyM=;
        b=oG5pnS/gE7OtIXwozrCCBErGDyeCovH0iy2Ld/keNJvPpOwSfe0k4rzt3UvjWGSxvt
         g2gCaID4xXaqM64okiTwi8n5w31N46EKd02+1OgoD4ZcVYejmmfIqk6S7nlYzeH/6vhW
         bCMUnslX3QBc3uk1lGG5sW9s5Em4sFAL20H0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714642436; x=1715247236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUPIZkrFl6BEjtW1yyE61WicVfg6hOSYbd+LAsiXxyM=;
        b=nlg5gSIPKaihnteYkC1YkRc9HtDKJl0vhU2KCzZ/IPsD9/jDE4IExmufPBB/wuI3FZ
         yq2WZfck4mUddQzaCwxFLQDKM1JuztBS1b9M2soy+SoGSOmkbgvnzk9eicbC2BpGGrgl
         noVTfCbLRgHsc/dJZIbdF1/h0M2bIlSAm3Jv1u9ZAVRghbCfbx+JuHLGupWJJtiK3Md9
         jj+aYDoXbmiEuUrnpkJhXSYvpnZXv/VOmeV1eiLW/i74A9N7Aw8lI03idslbXlPEWvVf
         LLWbiMj29df9Efd4rhnRS8WyB/ki1AVOahLtBf3yGqcCDGsDXixQ8j0xmoW7gN0nA+2f
         KKjg==
X-Forwarded-Encrypted: i=1; AJvYcCWnhmQRl6n4JwQaeSYU9vy9RHCruw5Qqk6TzR5NXdO813k2zlLVekGj7M+qBHfFysW7xwj9PEAvSmonhFvBoqg79+tIkuu6H219cZvT
X-Gm-Message-State: AOJu0YyyIR2uwdxYsbq36yMOPzus9hcgA0QAEHgo2rv7n64WQ3owO8ee
	mbzGV8ud/dnXEQ0scpAfPyh6sxg7gGqiU50ciI1nqGlai7CzdhN+6BOwCjHi8DmBYwB0J32MgbQ
	K8OeGwmzWpoNcSHXBSG4JU82udqj7zfDimMwF
X-Google-Smtp-Source: AGHT+IGq4dmzHxgktFLM5a2WhXUqq3A67gAwjMdqjX26QYOxX34ttC61CkVRyaFFQXyx2u2V5502HE2Ng9PF3eBB1oM=
X-Received: by 2002:a2e:994e:0:b0:2e1:fa3f:6165 with SMTP id
 r14-20020a2e994e000000b002e1fa3f6165mr481449ljj.8.1714642436155; Thu, 02 May
 2024 02:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
In-Reply-To: <20240502-anx-tdm-v1-0-894a9f634f44@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 2 May 2024 17:33:45 +0800
Message-ID: <CAGXv+5FS1UwFiGYh-qZDau0yok3Gwf7g7GdRi=qJAG51ZDXD1Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add TDM setting support
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:03=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.or=
g> wrote:
>
> The anx7625 supports two different TDM settings, which determine whether
> or not the first audio data bit should be shifted. This series adds the
> support for configuring TDM setting through a property in the device
> tree.

As mentioned offline, this shouldn't need a DT property. Instead the
machine driver dictates which format is used to the DAIs, and the
DAIs set their respective settings accordingly. It would seem that
one of the drivers is misbehaving.

ChenYu

> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Hsin-Te Yuan (2):
>       dt-bindings: drm/bridge: anx7625: Add a perporty to change TDM sett=
ing
>       drm/bridge: anx7625: Change TDM setting accroding to dt property
>
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml      | 4 ++=
++
>  drivers/gpu/drm/bridge/analogix/anx7625.c                         | 8 ++=
++++++
>  drivers/gpu/drm/bridge/analogix/anx7625.h                         | 1 +
>  3 files changed, 13 insertions(+)
> ---
> base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
> change-id: 20240430-anx-tdm-7ce41a0a901d
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>

