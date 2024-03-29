Return-Path: <linux-kernel+bounces-124202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950D18913D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EFE1C244B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75843307B;
	Fri, 29 Mar 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Ay1mw+WD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768C8BFC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694192; cv=none; b=SW74n2eJwV7ORSPGyfGfcojO+B2JOSLMHmDSA4AktoJznLRD5RkyrSYFD8Ieuth6t/1+cU9A0sf4TZxjMlHI3tgQurczYz33ZN73oQG4jJoWPnkuOl+vXI39Iy/9TtHn77yEPBuBuFQD8XQBWne1/ZFFoeMrvrStFm6X9K7Geko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694192; c=relaxed/simple;
	bh=zvuXhVzKRKNmjsXHGNO71Xw7k2AL7GmRkRL9GC6fsuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEc1BP6QibBP2BNHFfzhdsBGstmCgDqQqPBSvQg/q+cLVcwLmU+cZPHYbTIe5r/xQvSvIDxUDDgZQBZsBrCo1lli2o0MFHdbTOefNxeAS9KD/I2dGhoruf1D1pGFyGxSWi6FfJgcNWTTU4bRLb+LPdNvByW0Jn+p09BzqOy7Y9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Ay1mw+WD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34175878e30so1240364f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711694189; x=1712298989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=43xZx60rfZWmX/MW6KInTEWOudBJZZMkJu12Y5dNCZU=;
        b=Ay1mw+WD5UM8yLaWezfd9y8AEU3ImzlCFbk9BuyIWsAoszrdlIGHbAG4JvrSGIhB22
         yZyZX1e6vyYmpuHsq6ZQlFcGZTZyQoWkBWYUJ+wBmfOjtIB8s+AB8GGpnXvkKf7V0ZOM
         Yv6baXkQH+CLCawSJodgtYPbwGMXtUh/T0p0jGRdgs9WTyVK1rdxHYEDT8E3WnnrOgcr
         0lOKi5pgcP6j01rXAB8IW5JE73tcTKWcPai+oZnZOluLmJueXvdKOTKqdVSTG8zbRVJ4
         nRqmRJLjqj7S6oV5O8pf/RVYP0rWaoF0aHvpHLJ5HzYuqi3InjUe/MDtxMltod2gbFiq
         xDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711694189; x=1712298989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=43xZx60rfZWmX/MW6KInTEWOudBJZZMkJu12Y5dNCZU=;
        b=eviEQuFS9RBa0nTicrekpWSx0r3XpqIyLSoeSN9ScaL9p+A+sjjanm6tiHhFFxK/Ry
         rciMMqPO9ZqIhu8KZ31fJfoKFkj9YhpQqPyg7GD9wlG79D4dSO47yog/uRhISPY4S6Ge
         l4h030E7ODbtjAkUrCsr0KJZft3+4MdMacbk+KaCVlKFzm0nZKYzvVK6LiimfSAd/54u
         OJPNPVlMSH119BLGyJcA0w0+gCKUSUdYz/2n4Q3IY/ihsqIDyJcm6D9KR/Pzt8IogDt4
         AZhaGWC2Vl7Q1UOUf0hwm6AIxXm8TWnn7zwUry31mkseDB8KISBoPKBcOgI5NUeK+bTT
         kCdA==
X-Forwarded-Encrypted: i=1; AJvYcCVk9nBqMF5Dp7xMBAkMnOZyIERmKXZ73AgMUEmhOlSuR0XOzDO2CV3OQs3ecM2H9rVpDurw95f5gPAlorTsXgmHTihEI24PqO0BJCZC
X-Gm-Message-State: AOJu0YxXBrWlDKrkVxI1jAs52mvNo3M/5rPDR8fQpu98FfAcL+nR3uzV
	fGtPovWNUbgT1n7el5w6D6uPoJKEzxnvEEiZwub67dUqSFolWGmZ58vvDefYKGI=
X-Google-Smtp-Source: AGHT+IEVLeAaHFiI4gvE43nlAphVjGnGp98O60VdyrE/01nb5Rcj1iSVPlTnLH+WsyKz1julrP/fFg==
X-Received: by 2002:a5d:4b8a:0:b0:33e:7f65:bb7b with SMTP id b10-20020a5d4b8a000000b0033e7f65bb7bmr820243wrt.5.1711694188839;
        Thu, 28 Mar 2024 23:36:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.147])
        by smtp.gmail.com with ESMTPSA id bp29-20020a5d5a9d000000b00341d28586afsm3494618wrb.2.2024.03.28.23.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 23:36:28 -0700 (PDT)
Message-ID: <16dc5bd3-9231-474d-8056-d7b0240716de@tuxon.dev>
Date: Fri, 29 Mar 2024 08:36:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/13] pinctrl: renesas: pinctrl-rzg2l: Add support
 for RZ/V2H SoC
Content-Language: en-US
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <25bc9ceb-c5cb-40a2-8c3d-d9666b88546c@tuxon.dev>
 <CA+V-a8uegButH84aUY1N+0GzZx2LkRBTxNtg7y1Y-cUvvFfJpw@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CA+V-a8uegButH84aUY1N+0GzZx2LkRBTxNtg7y1Y-cUvvFfJpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28.03.2024 21:51, Lad, Prabhakar wrote:
>>> +static void rzv2h_pinctrl_pm_setup_pfc(struct rzg2l_pinctrl *pctrl)
>> Have you managed to test this?
>>
> No S2R isn't tested and is just added for completeness, I wonder if we
> should have a SoC specific flag "pm_supported" for this, as apart from
> RZ/G3S  nothing has been tested I believe?

Yes, only RZ/G3S PM has been tested.

