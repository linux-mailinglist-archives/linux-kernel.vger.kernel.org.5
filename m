Return-Path: <linux-kernel+bounces-59353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75584F5BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF2E285411
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5A3381DA;
	Fri,  9 Feb 2024 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YYrILTYn"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817C37716
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484894; cv=none; b=Wq4Rw4YE0N4TU41oy2/iBO5jpvkWBBKlsLhYl7YYm7qXwhDh0e0DkAiLIfTa817pstGnCcZVdWEMWdWLeNqrwouGH7BKHjENAo5OCCB+SAenO5V+iLNazX6XZKpndR9tlBTqUm9Hz4Gyuj7luM6wP4TYalbnpWfbXkGVstTMmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484894; c=relaxed/simple;
	bh=ZtD+/WHeA1U9jv7rkjFYm3MAbEKfaDxtr89VERessTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tUqr0USF0rB8fqwmJ/n8TSiE/e2tmyye0aroehqk515hpdVJmyl10Fk9lKEiCH9JjWit7urvShjZ97pKQklDbMq5nUhBUWZheUB6F2R4J0Baxzjjl8sAaVcEB1TrSFJokqWcCc3oM2sWkAuVb5a+C8+I/+4WF1y6PnCwM2smVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YYrILTYn; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6049ffb9cedso11423497b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484892; x=1708089692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZtD+/WHeA1U9jv7rkjFYm3MAbEKfaDxtr89VERessTA=;
        b=YYrILTYnNPPEdJktOaghG+/wxvnh9wSr3H8objV4TzNhlfz8FcorBb0g3xXQmBcWxX
         iaR57LqWXJcJ+OITtUCslKs4x/tU+RCHapaJmEkl4Ovc/ytnBRBn1vv1lT9aUiGYx1jI
         Sh/YwGb2lDb33gkBUC/2Gxc+TI3e0+zLJri500f2OztF2NZaL2ssPfo5AgLT1fmsKtUz
         +ZNlB6poXU5Nep1/w+DoI+rHX+9xheSVHfAiQB6oYf8fy+x5t9Pfc3IDsjYsaziYgEAI
         P9IpcNWUYcYGw35QLJ4vHbQTPb9br50qOMLrGYCUs+HIGQguW1bpcg3H7UCYugQGgUGg
         YQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484892; x=1708089692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtD+/WHeA1U9jv7rkjFYm3MAbEKfaDxtr89VERessTA=;
        b=Gavj443YJt4J6TsfejQm77+MSx5yGbT/IudX8CGYzLOJXbZzTXSOH41sJqBmpKU8eI
         utjeT7yyS2vIy/De7KM/s+WK3FvgcjkIFiifCkE9uCKUpOWaq2CybSVzvouzhSOWSlIc
         yXPWFvQRgJPxEKfbcmvxfcFSo2gxAnXqyiFY1mPvdfB82E1stTpxVfyq19d9PZD7rQHo
         +Av/CfpunJjWmW499oig5wQkWf4AzsFBQ0cICEtAxJDMJoZ7OaDOhRpoxeDHDzj0NFqq
         LoS7qBcDMMzu2Z6ORljcwjJF7q9aqpwiqiqqQtJH+x67UQFiuJO58m8c27T2AoQ94C5B
         SwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUS70LGb7dwMgoaimsQkiJ7IIcLL4JQBXmwTfAs8fBxN0JSv7DigvgyJY8CLM5MGBGafw+pfPs1dRAPYr3M/qJCD0j2FEbOoZ2w/a9W
X-Gm-Message-State: AOJu0Yw1QyVZSrG6Uvem0+lKGlFVQc2nvp3GQgkbhddxK8MH8csj3l3G
	1r5izgbGk5JoS0QTnKwyflOn5CrGIZ5LV68QXP58HCgzMSelqNudtgvNbykJ4NgROrkAl0GyoWI
	GvoNLsXtT7MM620F0mYver6dpW+nMBJ1JExMioA==
X-Google-Smtp-Source: AGHT+IEjM7GgnjpcPtlUob1IS5iqQNw6vC73GQjBO21vdyKgj22u/bvKegfjbQSVpbPqky+RFIRp6rUxjS3Vfp7883s=
X-Received: by 2002:a81:c250:0:b0:5ff:981a:2aa5 with SMTP id
 t16-20020a81c250000000b005ff981a2aa5mr1481737ywg.46.1707484892357; Fri, 09
 Feb 2024 05:21:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-7-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-7-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:21:21 +0100
Message-ID: <CACRpkdaMBZyFoZZ22e3Th=Mw13BaQpWJ=VLMJR+xR=TYnETPtg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/11] net: dsa: realtek: get internal MDIO
 node by name
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> The binding docs requires for SMI-connected devices that the switch
> must have a child node named "mdio" and with a compatible string of
> "realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
> docs only requires a child node named "mdio".
>
> This patch changes the driver to use the common denominator for both
> interfaces, looking for the MDIO node by name, ignoring the compatible
> string.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

