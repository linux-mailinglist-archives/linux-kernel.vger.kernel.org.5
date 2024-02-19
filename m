Return-Path: <linux-kernel+bounces-70934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED993859E37
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5901F215BE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11A821350;
	Mon, 19 Feb 2024 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UgrZj6Ky"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738E121103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331369; cv=none; b=OVszWqwSgzdU+ELCX3ekYJBMB7k8cqwm5xTWgENXrPbDQ8WON5SjTqkuHRm42SMzDbkrNvZUSfop0QwLZsh3+ILrQ3dzkpoQUeVpulAkmwPy6qwmXs0HZo1YBm9mriglIfSq5EsJOrAnuupivUnistBezoFif+ImpUTGmy4l8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331369; c=relaxed/simple;
	bh=uhdC6JFPIGg+KsZnoOpAWCewl/MoAdPwQ2M0i3DpJNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y6jgq3DAGB50xuUR2hm/nT+ZM9UGttEzhqSKZxH0gBgMpz6/xNw+O+hkIWbzIJ9pyxDZV5sCPpvYIkh+qD/GI8INHLZhNgVGkosD07qFq/iCfdVyEVdCRS7ZgaLDaBU5okOVqpn9H5al7Niq+wYocWTVkeZptbEwGgrtcGUPr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UgrZj6Ky; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d23d301452so5975661fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708331365; x=1708936165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kWUWsnfwYVJB3NeJPGabmiQoX5d4BCcDZFFFL55Cbcc=;
        b=UgrZj6KyMkIoaNrtRt8adIqFsfchFQmxiPgEzEAZfss5rCWyQz8DPmeSQJx+lhag6k
         oCYw2YhOVynEz64c99AxdBZUSq9SB7eS8iwGgBDWzsLS8eiBhHACusWTSzvzZIXwNOma
         l0mhn52QL9uKoIUA0DYj/gMtQiYo0FZlwwrNGZnoApK0pe9S/JPbdI+fJqgFfyHQ42LM
         iDtTZF6Ryi2px9OlbcnGokaNnKqtHBRplEn7cArxAUK8/DaJsvyUG7n1fh0O5yseIE8M
         yiC6EJkzm+OOYsCSoG70aF8D9fVH7mQqDeFOpL65q3DolO+26L7F431domELyjncqnws
         0uAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331365; x=1708936165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWUWsnfwYVJB3NeJPGabmiQoX5d4BCcDZFFFL55Cbcc=;
        b=Wj7RjFy18l8AUhOBxzlix7apXhvdai2lgEWQqNPWuz8blnj+jvoiW/twYbjLSSZpJI
         WcY2AHx1RuK4roSzrKekUxz8jRIo0G+S+A5d3B0Cu30YUkxEKNuQzfBNzbzmzCturR5I
         rRv3Wa+4pK5fP1OUx64nFZ0gpMTcDKwJw2TGNSmIeObJMSWgnxslh56SOcIhKlmOKQW2
         Utky+e3YITg15FoLUO6JQayDUpMnX9vShVu769zPBw07zxZGxRPhj/A7SmOBGIR1L83N
         5z3PEQP1ZaNfvMMQmf6fVjLte/KdwFv1ifEBVuKLINa/++kdo251iDWc8wDaP2Mjo2at
         OLhw==
X-Forwarded-Encrypted: i=1; AJvYcCWMP/DLGxr+tr+ldcLk9sfWn48qt2HPJ+Kql9dJUz8jpBX0gbegogbTZdotdo8K5GJGj/Zd6tg2ZlQJaF3Qq6a/wWiI8RJ7Xb4bkK4t
X-Gm-Message-State: AOJu0YyA96lrPKdTEAB+GAumwMvuz/Cl6zVTuQ82Vr4aLnovnF7IeH8a
	erGUSx5+QNRnH/9ewUta1zVvr154girw1qsAxYydyuZZX4ezzkMhpLl0M+M//vk=
X-Google-Smtp-Source: AGHT+IGJbZ1oXtdXJ0tTWHvHxj794/54tKPc/gXozHxyRNAZCzrqi/Be9hQAFy18RTkyv7AzQAYNmA==
X-Received: by 2002:a05:651c:604:b0:2d2:4314:8c06 with SMTP id k4-20020a05651c060400b002d243148c06mr47798lje.15.1708331365518;
        Mon, 19 Feb 2024 00:29:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id g2-20020a2e9382000000b002d09bdb7e1fsm983394ljh.24.2024.02.19.00.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:29:24 -0800 (PST)
Message-ID: <3c47c45d-be37-415b-b38c-2185a2108d40@tuxon.dev>
Date: Mon, 19 Feb 2024 10:29:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] arm64: dts: renesas: rzg3s-smarc-som: Guard the
 ethernet IRQ GPIOs with proper flags
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com>
 <20240208124300.2740313-13-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdX3=KJ6=qOW__KxWisj7Fguwr=SdP7XGvFD+BKgZbRo9A@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdX3=KJ6=qOW__KxWisj7Fguwr=SdP7XGvFD+BKgZbRo9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 16.02.2024 16:17, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Feb 8, 2024 at 1:44 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Ethernet IRQ GPIOs are marked as gpio-hog. Thus, these GPIOs are requested
>> at probe w/o considering if there are other peripherals that needs them.
>> The Ethernet IRQ GPIOs are shared w/ SDHI2. Selection b/w Ethernet and
>> SDHI2 is done through a hardware switch. To avoid scenarios where one wants
>> to boot with SDHI2 support and some SDHI pins are not propertly configured
>> because of gpio-hog guard Ethernet IRQ GPIO with proper build flag.
>>
>> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch! (which was well-hidden between non-fixes ;-)

Sorry about that.

> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.9.
> 
> As Ethernet is enabled by default, I think there is no need to fast-track
> this for v6.8.

Right!

Thank you,
Claudiu Beznea

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

