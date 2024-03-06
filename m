Return-Path: <linux-kernel+bounces-93511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103668730DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421AF1C22D08
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D722F5D753;
	Wed,  6 Mar 2024 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s2eDjqv7"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE14199DC
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709714214; cv=none; b=Nl8ieh3nVNgq3ebJPhsLYA+/iw2+z77X4FJMnBTLJegnfiy1c6G/b1RiElnDTZU+sAJnlXi/grjlX6U857GKP/0Ds5zXIBHG98PBWszLrJ476vaMqNyOPZm6uuCiA3IycYv8WcVuh1laII168rkxD1k1t4ySdlJw0dHdH784uCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709714214; c=relaxed/simple;
	bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHDiSzeM7W0OAP+v5/T0vbBG7JcpAUxRorv1EvhZc23dLWQQQe6Mm9wsffqOdTedvejh5FyGuQANsrg02rmSf4PQaOqUhahBBLoCFZoc29ZjrE9hjGDUrL+g8Oy9U0q8tBt8Y6j+m+UNXTbe4zHf+IzsclFASUpyj+dEUp+GkKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s2eDjqv7; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-60943ad307fso61443777b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709714211; x=1710319011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
        b=s2eDjqv7jqsJ4zBbZy7H4nbxPI3zMt1X+pz4RHClVdS1MZNJHO8R021QcnCTt+7A56
         QuVBa8fxzE63hnE4Ga43xbAxaL3g6MUznnbxNDl7slrxP4c+jxadnA7ljZIGTiYydPcU
         131GpF/Ca7ldFvE1G3ZzGEA5nytyXZuhNZj9g3wJpZlqbQjlHrzlIXbQ18sWsJlYmVzO
         c/ylnQ9ip8AEJYmx6pRPz6rpjRQyJwoFSIfZQm7Bn39iNZPeXNdyogx3Z5d8DOzI7yhH
         YM5nAHbPIpldnQ22DNxkG0LWYRKr5VCl0sJuQGWb21YfY4s0beZSO7iAVQODekk+Xo4z
         9Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709714211; x=1710319011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNDsCpgXUqnTVgldDCq7tpB4bN5RG3gam93XXun2jNA=;
        b=br/uEl64kNuqSGwQv0rFA06EYwlPcfBYkT1X6VAU34CL0q6xCk7/kaclU7YxFEWQyb
         5LrR7n5P0tFd3Byr909EPAp+iupDNT3jjAYEe08BhVl7krGPzY5mFSuAWLnV/xthTA/S
         mKP1UbPa8n2Tmk7WfV8N1U6EyanaMeP7xPrGj4FHydLOTJ3XjXrKk6s3DUFrKH3Ju161
         ytN5M01xT5L5QzonjGzYEw6/gjnXBBqQaDauIFLWrNtoMouKuEtkshwk+ITtI/I7Kl9K
         omi+mco9IE+9TI2Z+POh5Rk5nXiyfWDn97pAEhrf0YGMsBhnYw02/jR+EKT8z5+3Rwzu
         Hvrg==
X-Forwarded-Encrypted: i=1; AJvYcCWCzTN4KgaFR9my0CvRFjg7VdCL8Ltw0O02Mj3TcTbD/v1rI25x6LbN0oK3OG27XvpE8NXACBiLnRSRh4R4fkjyvDeQFk2cCoup8DHj
X-Gm-Message-State: AOJu0YyP8paROi0gl6uNP3yiHOVf3pfmZ8uS6zkzS4aQyCswOo2xYOpp
	dz0Zvx+XGhldL5tn0GudN/L8hcpYGENqJUCs/W0tfTiaymRjoToLoeKLte2Wp5hu5zDFop+oJR8
	ANwAXlFkubrdIRMP9HCWlCH4EfqLeRZ8RSvOULQ==
X-Google-Smtp-Source: AGHT+IGLhNjtxQWwYkQUglxPcEa+RvZcCcxoSRdy5ObAW+Xzq2pgWa2jlr2vpOMdsBIBcGp+Eq2YbuY3bzzRUpIAt6o=
X-Received: by 2002:a81:c211:0:b0:607:f4b9:11aa with SMTP id
 z17-20020a81c211000000b00607f4b911aamr14072266ywc.21.1709714211516; Wed, 06
 Mar 2024 00:36:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-17-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-17-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:36:40 +0100
Message-ID: <CACRpkdbRrnHtknbQV_CEpWu_bsaZEdOEa-AmXWXp2Rs4bKXxTA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 16/16] net: dsa: vsc73xx: start treating the
 BR_LEARNING flag
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:18=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This patch implements .port_pre_bridge_flags() and .port_bridge_flags(),
> which are required for properly treating the BR_LEARNING flag. Also,
> .port_stp_state_set() is tweaked and now disables learning for standalone
> ports.
>
> Disabling learning for standalone ports is required to avoid situations
> where one port sees traffic originating from another, which could cause
> invalid operations.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

This looks right to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I looked at all patches that I understand, the VLAN tag stuff needs to
be reviewed by Vladimir who I think has a clear idea of how that should
be done. You can add my Acked-by because I looked at them and they
look right but I can't claim to have made a thorough review on those.

Yours,
Linus Walleij

