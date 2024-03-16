Return-Path: <linux-kernel+bounces-105260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAAA87DB27
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF521C218E7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79661C696;
	Sat, 16 Mar 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYkWlDX+"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7586B1C687
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611193; cv=none; b=o29T0A/GGaApMO5PTDJPNaBpEVBovDbZwApxmuwirSGOGD/Bse4WJIJERnL7EgZSRijOTKgsc81WvjaZP7+RPhhTNINrxsG28mZHs6B9R0O2mF6laAjmurij+quQ38Hn1nJexvC1ocDT7urLKfPLiF+tNs60rSu8n1ifPq7gdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611193; c=relaxed/simple;
	bh=Tjeo0x4QrIQ/euAPEVK0hiw3hiSjbTZ3YoUaL6PRStk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ap9Oji8bzNwEnSPNCx7gT6apz7beQUr7tc0oMfiAe7mdzjhHjkEeIOtKJes5Xkfx0chGzDre/35KOwoP69Wf1J3zEC1xO+IqJF988PyIY4AiK5f7ss5+O1AHo+Y0h2PiM4c4FkuHiT2XpwhDdfFjgjoPAoBJmuL1EddBijkzn8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYkWlDX+; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so2711060276.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710611189; x=1711215989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVStdoF6Kqgdul7UWe6zXz3Om24WcbkcnMH9dz6g3wg=;
        b=QYkWlDX+3NED+LuVQSx1c6yy3bOE92TJfwrakzJejI1HtL4CFsp1MHNSrpVHXJxIad
         aCUwRBMEB0pKCrGzJPm9p2N6qoUd7yT9Qcrkk5iDYWHEdOhlvk8AJ0hWa6XdF5O7ONFT
         MchpKR8PidvxuvjsDEN2wsAY8jOgZvhVKwcUQ0Aicp9wgUuLI1VWZayDnfJF47mQ9mvG
         5XlQCv+DL8QJwCc23XsWvUvb5gPy0qVTGJab1VUb73IDghroFMIh2Os6jJkHlor4KE+D
         S0ccVAjeUIhx8GnuT0X2K/DTG7vywEfEyI4UrwIioh5GAO5w0xo2MxiENDjsUx4GWTO/
         IoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710611189; x=1711215989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVStdoF6Kqgdul7UWe6zXz3Om24WcbkcnMH9dz6g3wg=;
        b=ukBcu/J1zqO+sScvDJvWsqINSg9JCc67k/vSIeOV7vhziGJF5ncQbT2Li40MIjstlA
         W8dP6lOIwsLy9lZfPSm9zx+EHLEdUxVQLr8aFnpy+opW820vWcPQpR3N8NLuJiM+NhKm
         vKB3T+R2lxaxM8Kj5OQQXFOEFxkvAaWL6dEI00iN7WkL5NBjtSgGaZTT6M4v8Tfu59r0
         dURv3OsPr41hk71j+WAno29Do1Jpop9vi3ZcHxV9RT9mTPa02RItQjiP3ZwVELEBz10N
         rhRY7BFq8biWmxnBKN8SCVnEYf7sA/umwLdXKsIvRsL5xhVvAc8l9OmeDC/ToQS+wO3W
         Ou7g==
X-Forwarded-Encrypted: i=1; AJvYcCXJwBoRNQrFz6t5qoLOcD+phV16rR+sgMClPMDcIDFCfhOQvOV8OlQkRlhr9nhatn708ZNATOntHglQ1JZje5ovZVTOKY0AtxoeFU9J
X-Gm-Message-State: AOJu0YynIhNBv37mpW5yepSUpD73KwtgDmu+mY0YFiPN09Qriz13Fi5I
	x8MQcb41cH+K/0g/LUyv+OndXodDDdmQevPIqSXsAuQZ62VBaDqrURT33GTH95hc5dMrjtUEYda
	v5atZAinO3H6d5e26MRsJwQE70YwmC3h0jBpFdA==
X-Google-Smtp-Source: AGHT+IH+FbDVsXI2MAe5r871J8YsdZsZXA8v1XklEFtC/WbQ31ONOyAwXRNZJQL5xDdmOMlI2uD0Nr+BBD8kdaNdarg=
X-Received: by 2002:a25:ad54:0:b0:dcc:d455:2abe with SMTP id
 l20-20020a25ad54000000b00dccd4552abemr5169444ybe.41.1710611189517; Sat, 16
 Mar 2024 10:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240316172800.1168390-1-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 16 Mar 2024 19:46:18 +0200
Message-ID: <CAA8EJpopkcYpek5M2+KJBKnKNV1u9cxMjtMyvU3XNPB2m2z3nw@mail.gmail.com>
Subject: Re: [PATCH] drm: bridge: thc63lvd1024: Switch to use of_graph_get_remote_node()
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 19:28, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> To reduce boilerplate, use of_graph_get_remote_node() helper instead of
> the hand-rolling code.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/thc63lvd1024.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

