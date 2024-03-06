Return-Path: <linux-kernel+bounces-93462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF026873031
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F891C22A47
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF25D492;
	Wed,  6 Mar 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BK0GBPG7"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4C5D460
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 08:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709712409; cv=none; b=P1KD0ynkhaAXxorFK5C4D82EHfTkhV5As6rOQvE4nwE2XQ25JJ22nk8d/7B+t24DnDi8OBfIFB5BETmThOxQMugWf7IFeIaFQz5BLqPUoElEf+g0+ycQU0yZe3K8nUYK5rMX3W19WsZwA5TicK1f3PMHrkKURoV1YPF40HhLk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709712409; c=relaxed/simple;
	bh=C3Ztksq1l7A04RRMglZnwFlXOXmS/C199y+UaIehcFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiXq/qPm3lxGnjVxFhhG5Td/C4F5/0ZThGAM5kyfrWQVHRsOzhjkVIOsG99anLWljNuGmtXfflear0fu9cV1kM9H1YWpcDjN7jrvOut6rhrpeEO0K1jMjdqoq0V/XByTaTDkxgGbmbpsxiRd9qnPwDAD2xSo/WN0WcG6BGAyN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BK0GBPG7; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60821136c5aso47830587b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 00:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709712407; x=1710317207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3Ztksq1l7A04RRMglZnwFlXOXmS/C199y+UaIehcFU=;
        b=BK0GBPG7OKWL/gD8vUSphQZygf4GLgV2PXxaKfknezU9NNkMjJO72bXETo9MVuaxpO
         gwPvHIohexDdtpE4r8ICpjsUWlnP75Oez7gdNhtg6cWnGeGUoV2gfOiuCjUOgJs0zHnB
         5rfYldlgq97HIalIjn89NdWBj0o2/8qFgjF2oVuroq9qx3ReJ1lD4lPZkGcHYPyetv+D
         L6CzIGSsJZq18SryxieYyt4l8ACelMGCnk1Jt3a2/uiZTKZAWr/n2w/UQfVBhnAJLwVY
         1xCEOwVcmo8CBiQjtrY+K/cngtdbTnBSxzMl4d/SPPRNMU0ouV4MTdmoE/WGFoFHLV25
         ezkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709712407; x=1710317207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C3Ztksq1l7A04RRMglZnwFlXOXmS/C199y+UaIehcFU=;
        b=N2/jcpuu9OhNgyymCtwe3nO+hLpmW5+jucMy7UZKWCtwWtpROx/NnF+EU3SrCl1N7v
         AWXmFKLZzVunja0AykamlrBNkmwHVHo81ek0ZhQ+ZzOhoJ4E6t+Uj3ucnrKHGD0ZqEi0
         EfnEROyWZbicMm9e6XsNoyXvaMhcFIyiDCCllLskK7tYLfc1DHdpi4xWTnd1ZDMM/f2w
         RzgsIEHd3oVBqfgttLWtLMPiwpOHmKCQDO2eDDwd+9vyrV1idOwdTWaSPAkLgtb0l8ph
         e8NsvI8OgikrGLSKsfsg6sH0JOTPIKlQDeRLEcVXcc6AJVPugqyLLl2usBaxCl6+usiJ
         AiXA==
X-Forwarded-Encrypted: i=1; AJvYcCUc1XOJ2vfV3BrnrPwuDvdezqiW/lM6C8RR5G/K6OY9s4yowr1YKZwS3gBnopGzINYrTLGWd2uvN6vpe+ULcY0Yff5Aml6n4g+UalP4
X-Gm-Message-State: AOJu0YwMd+xslv4u1oeZDJ4YhiffL8X8ubzcIsbuOz08EtnNtBmk+f17
	Nh4w+JzH+tCy9eTIZzCbDJa/Hec8pbVbsDDBwLE+mKgzbec8V3KnFwH3gJO3PlfKaYTNTnXkFHr
	Z9/2DWAP3hXe07f+N3O4Yd4u/2IZVkUyV4V7JwA==
X-Google-Smtp-Source: AGHT+IHRtBIwm6wvaDL3JJRC+EtkHRhtg1Rh8XMi8YL4NhEOPx0wbM1EIpmo39CJmntE7XTva7TagCxU7j3w4z2FMIA=
X-Received: by 2002:a25:361e:0:b0:dc6:d093:8622 with SMTP id
 d30-20020a25361e000000b00dc6d0938622mr12231100yba.15.1709712407155; Wed, 06
 Mar 2024 00:06:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118-ep93xx-v7-0-d953846ae771@maquefel.me> <20240118-ep93xx-v7-3-d953846ae771@maquefel.me>
In-Reply-To: <20240118-ep93xx-v7-3-d953846ae771@maquefel.me>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 09:06:36 +0100
Message-ID: <CACRpkdYKeQYvDma0NvrryETZdC5Tp__XNqFtw6TULOK2RSEPyg@mail.gmail.com>
Subject: Re: [PATCH v7 03/39] ARM: ep93xx: add regmap aux_dev
To: nikita.shubin@maquefel.me
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Thierry Reding <thierry.reding@gmail.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 9:23=E2=80=AFAM Nikita Shubin via B4 Relay
<devnull+nikita.shubin.maquefel.me@kernel.org> wrote:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>
> The following driver's should be instantiated by ep93xx syscon driver:
>
> - reboot
> - pinctrl
> - clock
>
> They all require access to DEVCFG register with a shared lock held, to
> avoid conflict writing to swlocked parts of DEVCFG.
>
> Provide common resources such as base, regmap and spinlock via auxiliary
> bus framework.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

This looks like a reasonable solution.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

