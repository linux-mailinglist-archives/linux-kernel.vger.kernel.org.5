Return-Path: <linux-kernel+bounces-89883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C086F6D9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC932818FD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C115079DAC;
	Sun,  3 Mar 2024 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pDabq1Fo"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CED79B6C
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494899; cv=none; b=aVBdF5dk24M2GHe0gzbFccZ7JJsdUb/bnV8ZqYOZtg6FV84O43o9HZCz1G5FRnnNsos91/73Bq9mwRG2p2E2vuItlMbQsMUix3NQIQNiMacJkJf9uxiSpMGeEy6z/EuCVaTZWir+2mnXWv7XAVcdcd3V5CPnLYt46Q6Du0raHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494899; c=relaxed/simple;
	bh=yH8Iyl/clwz7ah3TSa82CMm2zdGUdQJuFN+sjwh1jTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5AH4AWcVo8YfzxvLMN6NZ+6mY/7ExhURbRaMNiV9a+IzkOt9aTBRFvKE4acZ/f91KgrIFITErIs7q4VPH+nNr93bmi6TDHQ/lW5FK4LLBJMy7+P+m6TLbRUeOj/rI39Sogkelq2skSi7+d97kWHwqtGKT6OSNu2YOzJIeIMGng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pDabq1Fo; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso3955160276.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709494896; x=1710099696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yH8Iyl/clwz7ah3TSa82CMm2zdGUdQJuFN+sjwh1jTU=;
        b=pDabq1Fo/E/uxjkEV8Ab4n1p8htShtGbdpCEQpAZ4qWBViqsPV4MLX4pa5O5WwEzPj
         UntQzmeeJRL0ZidY/8TjHrrSHK61norratjQHq7pFdSN+4ZkEZaKZ5vuAEBaVXMbQreP
         tZrY5xrxymzDdUUiDk40Z4NAmLo4ftk82iz5I7qlIa3E3K9QtbcPu+Lpb18uoQVFAO8J
         IHJ7ZTogFFjFQgBRwPKSsSmQmrOjUdACHEL22mtbOKgSVHvd4EGpPnROhqYN71+6Sapz
         7pHRHs4j8+rHIgHrocvKl/PZ4cwN1eYpyPITfk6auMTznadsej7bb03FuQzOzTfLynDM
         Jr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709494896; x=1710099696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH8Iyl/clwz7ah3TSa82CMm2zdGUdQJuFN+sjwh1jTU=;
        b=fjA6qkR4jMCMiikK5y8gLRV3k/oPJnfot41F3dDqP6HlHKEVESVRGHeEQkpHVx3bA1
         ipKiqneLOe1+OJzam9HwS8ILGCz9y5rzxfsQ92qRX4NEdDEN4ozR9soBqOvbP1KXSXqV
         U8E46wzF7wMLPUuLfd42EVwXHQTRy0xRYYWVF2u+QgKdads+wEb8YRuXJ73gTOefTLj4
         Fit2yCzDdhTIWWYsP/EoC+ScwDfu9axcB4o1G4+ojybnohh9Y15V9zrvRFCjCbTusfKr
         Jrl/nEHa9DpOlJdXGBas6j9tU0eQdzIYz+dxzSaQj5VC8aId76fSQ+GShnkFKm9Zsnw3
         /vEA==
X-Forwarded-Encrypted: i=1; AJvYcCXe2cVJsqXD5+Iek7pl6BxdcDzGBgTNHmmBpOYweHFtZjSkPikTJ3hZlVkgU3E/U6aI+6KYUTN5nLa0uVCFWraNbT4BGt2YgNnf8B/C
X-Gm-Message-State: AOJu0YzoSE/pkmccTyVGSdjU9gC/52PcfHWs7/7S0dokQ9q1VMic3Rp8
	crkM+rWG2KzKZe19fgyJ9Rv0/W3yjfegEpjhvL0ou/auVZh+oaWmWcHSk1CrMRss0sVL1v1I711
	G+pofOzbQqnvY9Mg35506eLB96hFrnAEy9KEciA==
X-Google-Smtp-Source: AGHT+IHW0/nslv9u7HI0yXnFPSD2Ds4CD4VUyxbU3QrHmEzNEYwVNoNeNJMBdXZvU06WqbJKs8wj2rVhJ6JRSfpVQwA=
X-Received: by 2002:a25:824a:0:b0:d80:68d1:b826 with SMTP id
 d10-20020a25824a000000b00d8068d1b826mr4576752ybn.6.1709494896554; Sun, 03 Mar
 2024 11:41:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223112223.1368-1-zajec5@gmail.com>
In-Reply-To: <20240223112223.1368-1-zajec5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sun, 3 Mar 2024 20:41:25 +0100
Message-ID: <CACRpkdbAjJQbAnB3E5HYkd-Bmb3NhBR_p5K=BHtRy+DhRFa6Pw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for
 Internet access
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:22=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gm=
ail.com> wrote:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> It's common for routers to have LED indicating link on the WAN port.
>
> Some devices however have an extra LED that's meant to be used if WAN
> connection is actually "online" (there is Internet access available).
>
> It was suggested to add #define for such use case.
>
> Link: https://lore.kernel.org/linux-devicetree/80e92209-5578-44e7-bd4b-60=
3a29053ddf@collabora.com/T/#u
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>

That looks helpful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

