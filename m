Return-Path: <linux-kernel+bounces-97904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C4687715F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0533B20C5F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956523BBF0;
	Sat,  9 Mar 2024 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dkmZvcOJ"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2CB3BBD9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709990983; cv=none; b=VdJ8Wj8VRT7nYZ/N8X6RG3FEXd6YzbXxYLPEejhRjqNETgr+RkJroJ9bANuEuQRWmKX9on0YRb914W5JOltJ0evPJQHhYPbQ8L2wWNDGbMP5damwUKK3CLT1JgfiWem4acFiKf1DIBSFZbwEFxovTxNvSu6MnhRIXefBLUcqCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709990983; c=relaxed/simple;
	bh=wpeTafZoG+IWibX3z4YnnI9yy1jUzKvTPGkS7+ekOfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYxZrGpPuA+HKreJ4KJr9VRNjU5ZVWX8CaN+L6IQ++Kps4MzLGfMkdT3AHIijD7Rb17JP52n1hQFS0KbKwK7WtFUPlzmn8Azehu9BxCnxd4vpQ6mhhmF/cKDPQ3VDeREKtyiSu1qWeFokoC1+t7FomQ1B9tb1qM6/hejx2etQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dkmZvcOJ; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1752752276.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 05:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709990981; x=1710595781; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7Taks8J4Q9sFVLRwiypdMlNYDVyNw9PbFVLyOKOfmc=;
        b=dkmZvcOJFAg6Ho4FRj973t6eDHy+M6De98udIoVZZI+IVx7weRcfEWBH0ZS82uztYz
         smElu04+O60KrwRFvJYJnPppB7E0QPOHUA38bAO9nGc28suW4jV8sUra8sWv3PtKRvk/
         2lNelZgoP+DB3vnrM9a1qzcfhhq8MSXFaHS1dArb9244BnO5c5Z/UovcGmKqkORLg9Pw
         G1dftDmg2jMIcCa3px9WjGkJndKbA6IAUF6tbk6mV4qk83JujGxbdP8XW7LdBHnuvSn7
         tfRrbkYCig0z6L8wCT4UWoKCRri87WQa07/9I78lo2IrmXOK3MwzTmPWeXisK/ZF3s/v
         EGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709990981; x=1710595781;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7Taks8J4Q9sFVLRwiypdMlNYDVyNw9PbFVLyOKOfmc=;
        b=qdvu/Zw1V/DoHssP7ad026GRNUAaV9m/eIDgwBk+4HoMSnuf04CxQRNS/XVui9KKBs
         AuFhXtB6HzmfqVETxxcvPhLhrHPZObOTCwnjMoWCjU0/aSANCINeDFSagZ/nFk0YPdQ7
         7iqYSSXop8GGfyjl9sZWonU/rnW5TyVHp792yFXfn70pHY7PARktCJdJW1s5L4IpSquJ
         cutRf4pV2soSEJc2X+wIMw7NeQE/o7Y7fQFmogF9wIeoO9xNOho1IG/1uTrD8tyTqVgH
         E31WX8TT//Q4sE5yZMn5H1vedKZ28zejItFBJEcnc1ZtDx1rZRXSLoVOV0qymE2lHffy
         DKuw==
X-Forwarded-Encrypted: i=1; AJvYcCUvD7yxeFXYbw5etle+C9MzlNOrz6qL9q+G9/GgdHPOcvf7ARGxeQzulmdzcOrc3B4aDpa5AT4wfT+e91FA/I7jn/RG9So1LiwSmHTI
X-Gm-Message-State: AOJu0YxeVkydZ4H1SQrrsxXiZxOs6Q6hGnqgKe06j0wlc8xldHOM/M8X
	u+y5n6dFKWbQUiNAp/P4KHfdmZ/ak9yyJz4vu/Hgie0uvrOnJ1pOLIxjj3vQC3s7ir+k9Ss5GQP
	iUlH8Q14R2t3itHnwLVgJpyZEW6CqkKbtYoaw2w==
X-Google-Smtp-Source: AGHT+IEU99pr/n1rIb3maLzCnZ8v4EqdMm5b+eo+nyeZpNwNODRAEJabBbvcmArDjxlPH5orGzupS8f8fkVQ6IaybiE=
X-Received: by 2002:a25:aa84:0:b0:dd0:467:2e48 with SMTP id
 t4-20020a25aa84000000b00dd004672e48mr984517ybi.40.1709990981142; Sat, 09 Mar
 2024 05:29:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev> <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev> <CAA8EJpqq1-cEke6wEFZFDnpz4tFBcL6HF3=Qtf-8Q3WbogLS8A@mail.gmail.com>
 <c84fcdba-af50-4212-a8e3-f492c2b02ce4@linux.dev> <CAA8EJppTcPO3j7GpGcGbKPUjQ=3rTMMOrU1SYR3mtkWLztf2qQ@mail.gmail.com>
 <7535b3ba-6bbb-411c-82a4-cd4ac45de1a6@linux.dev> <CAA8EJpp3yd33pYweL_exrXMJ3g-m7-yjJrjiVMVMevOadBtt8g@mail.gmail.com>
 <28492cfb-5327-46d5-8c08-233f1786ff44@linux.dev>
In-Reply-To: <28492cfb-5327-46d5-8c08-233f1786ff44@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 9 Mar 2024 15:29:29 +0200
Message-ID: <CAA8EJpphapGxz9ztD7FUE5y_CVuuz=gySbOJquNXSw29vexKgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Mar 2024 at 14:03, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> Hi,
>
>
> On 2024/3/9 18:39, Dmitry Baryshkov wrote:
> >> The code path of "creating a connector" plus the code path of "not creating a connector"
> >> forms a 'side-by-side' implementation imo.
> >>
> >> Besides, I have repeated many times: the DT already speak everything.
> >> Device drivers can completely know if there is a display connector OF device created and how many
> >> display bridges in the whole chain. If there are connector device node in the DT, then it should
> >> has a device driver bound to it(instead of create it manually) for a perfect implementation. As
> >> you told me we should not*over play*  the device-driver model, right?
> > Please, don't mix the connector node in DT and the drm_connector. If
> > you check the code, you will see that the driver for hdmi-connector,
> > dp-connector and other such devices creates a drm_bridge.
>
>
> OK, I'm not mixed them, I'm very clear from the very beginning. I have checked
> the code years ago. Let's make it clear by iterating one more time:
>
> If DT contains one or more HDMI connector node, then there will be one or
> more display connector platform devices created by OF core, Then, according to
> your "don't overplay device-driver model" criterion or modern drm bridge standard,
> we shouldn't create a display connector instance in the drm birdge driver, right?

Yeah, if the platform is updated, yes, we do. If there is an
hdmi-connector node, I can only assume that the DRM driver also has
been updated to pass the DRM_BRIDGE_ATTACH_NO_CONNECTOR. In such case
the lt9611uxc driver will not create the drm_connector and everything
works as expected. If this is one of the legacy platforms, the DRM
driver will not pass the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag, but at
the same time the DT will not have the connector node.

>
> As otherwise we will have two display connector driver (or code) for a single entity,
> right?
>
> Another side effect is that
> when you create a hdmi display connector instance manually without reference to the
> DT, then *you made an assumption!*. But there are users who have don't a different
> need(or  different typology), for example, they need to read edid directly from the
> KMS driver side. This may because the i2c bus is directly connected to the connector
> part, but the display bridge's I2C slave interface. sii9022, it66121 and tfp410 support
> this kind of usage.
>
> So the real problem is that it is a policy level code  when you creating a hdmi
> display connector instance manually without reference to the DT in a common drm bridge
> driver, not a mechanism.

Only if requested by the DRM driver itself.

--
With best wishes
Dmitry

