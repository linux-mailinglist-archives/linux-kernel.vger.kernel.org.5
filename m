Return-Path: <linux-kernel+bounces-59354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9B284F5BD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A981284D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA4381DF;
	Fri,  9 Feb 2024 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wkOQyAU7"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD51B374F6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484920; cv=none; b=uBR/OqzA8ApHbCFPDzdw17Aoohz8rYb1WGBPkhoYA+9zVPrBGtQ6sY4acbsANzijtNTjB2mQlYv6/0D+XW8t6UlwHAqGRiDTsoRorm+FNuzv5kNZZrpfwxA59EwvXgwdoatm1xIwij/Ha3oivKNQcT3MwYnC1htV3B8KPx+4zFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484920; c=relaxed/simple;
	bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8UMelnTTocD5sn+mFIT86YS5e8u7mYhh3a64EPiVHLUJJP6WSjozCnBhbHgRtT9yJ72FyAuPGCODXKqGv9jwUvFVCnM40nwRtESuvNR1AVnvuZ95wlCziCIQ+LQgASl6/ZY+CaNjjzCPxRiHv4V0QQN0+dcUt7UyyFXzcsUTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wkOQyAU7; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60498c31743so9358147b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484917; x=1708089717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
        b=wkOQyAU7m/ysIU9IrkUlYRBbRDZLaRzdMGbnPURlOwhyb6EIGc0G1+rCMssgnIQz7M
         EWy1JxlzVPVlfcxKsYq311uKbHTgwj409iNdoNNKsnEtVU8zyIayfEi2eUq8joSsIUtv
         CxWMS6hfkomUcGrgLqrO0uE3bQNMfXNoWuFar1NQXh1yV/dG+mqaT8lAu1EhfQZ3dKcD
         ZC6Xz87SBz9LYV0IZuPPqO6PSqxrDsS7U96gqTebBoFWEFpwQsusAA7xETz5c+lsFvOM
         Hft/lRistIN/QlTcTjWfTEcpJe70rMXBT//Vjbs9p8jLFVMrNsTNc4f987PJJZakKXcL
         D9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484917; x=1708089717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=449r/RUz6LocfxD8zQc0jYXaYXqGJOsiyBdFbqy3Nuc=;
        b=V7tfATl0EK0oLvr831J2GwSKWYvMmvLH3ltGDZUbhs5zG38jxJgsBjO1l5sY/u8pE9
         QAFTryrWQSiNj+36zUPP8pYmByT6EhF6KKK4M7S9DNaVhFiI/Bpq1Z6zEQjY5H/4Hg4w
         +8iEVXUcxG8DqlEjXdJtm+IuFspcx56UTYdsykBhzAIRCDlu+n0kCjvqw2ZUHKou+HFb
         oJeKdGUc7HmL/gTMej0iM5u27UIdBNZFTK2r+24g4Y7Lhkw2dqBo53qlWtrEaXqhiltr
         mbKYF5X31HFeGL+80C4rDj/1r1l6i2Qm6Om8D+QOCByCII5VqCg/68PeHLINNQRQFu7V
         JO3w==
X-Forwarded-Encrypted: i=1; AJvYcCWMMXs/1jSXp9pw6B/gQF+M+zD7aEPbmIuCyXrhcFqljJC6PSinfOflNwrykNxNuZnrPv3uqKsk/zo5/XmmPNHzj/5gbbZcSctJ9RO8
X-Gm-Message-State: AOJu0YyO+H3dAlN+ALTIpg6eqbd/xseFk0wz/uxEj2xrXBG8MdijmcDg
	MOqHYhisdonDr25OrpPJKpWpMSJE6p80HZ7kb989B94KoGocSzckM7J/42DBz80Vx4sdtfQLolD
	HwLqxvgaIZ9qpqcaG2QcA+EinugAqUpkSK7M+cw==
X-Google-Smtp-Source: AGHT+IFvU7fTM/tIDF5Rn3dZ8AMfk0ncd2+G5oiHKN54Jzli80+CClnsvwFyIhmwrOkcVxv1gLIUpyarXk8Jx3YeKN8=
X-Received: by 2002:a0d:db4a:0:b0:600:39bf:495f with SMTP id
 d71-20020a0ddb4a000000b0060039bf495fmr1606509ywe.2.1707484917624; Fri, 09 Feb
 2024 05:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-8-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-8-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:21:46 +0100
Message-ID: <CACRpkdbD72P+eR+GjVEfTtJab3iO-K2khyVLQhxa2_snED+Xxg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/11] net: dsa: realtek: clean user_mii_bus setup
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> Remove the line assigning dev.of_node in mdio_bus as subsequent
> of_mdiobus_register will always overwrite it.
>
> As discussed in [1], allow the DSA core to be simplified, by not
> assigning ds->user_mii_bus when the MDIO bus is described in OF, as it
> is unnecessary.
>
> Since commit 3b73a7b8ec38 ("net: mdio_bus: add refcounting for fwnodes
> to mdiobus"), we can put the "mdio" node just after the MDIO bus
> registration.
>
> [1] https://lkml.kernel.org/netdev/20231213120656.x46fyad6ls7sqyzv@skbuf/=
T/#u
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

