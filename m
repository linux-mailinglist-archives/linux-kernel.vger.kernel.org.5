Return-Path: <linux-kernel+bounces-146711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551D8A69B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649391C212D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B9129A67;
	Tue, 16 Apr 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RSaCR/kS"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8691292DE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713267370; cv=none; b=cE5Vn+3NWaCbELhDAEfYtw0XjLBCWvbYln8RAqITcHD3GGjzu16gX4RBpsep7pkI8gVHR0vkHZNeDStNbiM2NQ8P1zUrMIeKXe6ybTMk0G/S96cG8hY/ueJtRLrr/+nmZshhF2akWwmQbUGssbAHxTgqrBtAWEA1K3nqO9lHU/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713267370; c=relaxed/simple;
	bh=dMQSx8CCJTZi0c0vMxyWRS6E0AI8Ut2Td+Fzfj3dowg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4faS+2st+c8lPobfbb2R2GZZ4++vMh8Ic6mkChqaNg7f1CAoxGkmyvodJcqlq6q69eMah/zVxnLEOXLeAGk4bA0f6IToZISbN9yJlPlB+7nhvZm0bU2R+siechODYtq+DQjrJ84dqYKty6U3fKltKBhSwe6crybi9laLeS/MFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RSaCR/kS; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d717603aa5so52231451fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713267367; x=1713872167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=okFG0DnwE5R50C1UP70PPaJXyomv8+BdqCRrBYX27h0=;
        b=RSaCR/kSZybnVrUMDAh5QrYXEt3EtmACW303bCHj+nrSRUuFjNyemCtWUThQ5jh/AS
         OHRXjx9GRd1kdocOELO7TYC/XUMylG/Lqc7Ot7pa2xiEA2ernr4xt08izGJYMfkz49/U
         mSwj/L+1HweRBdxjp6Svkr9yrP/NkcBRMPndugLAIL52r+g8A5ReXecrR2/gm5LNwYuy
         Adl13fhL47ClJLhqUdhM1Lw8znXWmNhDxu//fIzsD/jXUcXVbOA1ZsOZQWFq6Zs/0Nbu
         qkygo2ZChb9XnxxpgXi9BRCYnXNMiRENQcZHS9Lsy0PKjLwFKP1F4GP+EfCLpYo8advq
         mlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713267367; x=1713872167;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=okFG0DnwE5R50C1UP70PPaJXyomv8+BdqCRrBYX27h0=;
        b=nywaRmxMR3T90LQnZwQSOv60nPIlqcCyVo/CnoQ7oIJi3yMgXtPxYbk+isqszDQsXa
         42agPv6pIBmFu/lW+l3zc8VuHtIbchRsOP3HTU0Nj49yz0YCJ5AD4aQbKA2r7PVv9uyD
         j4UUOGIKZUuuOVgabIjALT7z53h3f5ALdweNjTzaeS3pODInhPFMFecCamjSpLFl0F/7
         HzPuMV4WZrP4QA0bOha/QAGOXQYRld15STkmG6SoE0Xw58dmov06lHPndEz17AP9uPyi
         bDTM81xeYdCyUJPxD7yLDfECUWGhUzPjvllMkS1xNynEl9zceNXOexkL4+YGEi7xx1Ei
         skMg==
X-Forwarded-Encrypted: i=1; AJvYcCVQQTuscCkcvwuHRa38O8yLdbSil4oL+ywI1ge8ehDo9q8C+BrRLhMnvP6puP7IT0RqxFcmm/dcEts/LTtoDFqxsXZoH1x+O7uFviPF
X-Gm-Message-State: AOJu0YyzBumMTlOD8beB0E8TIRoUKeuZld64SA+UrvFq/Xdf8ZJOXoHM
	mzfV8RdCWMgV5krpg4f3d7u+d2GLeE/qhmHcYPkJ/wjRFZgsNbgob0BCWzPy1W8=
X-Google-Smtp-Source: AGHT+IFuxrJYpKT46xpDoYSQlh9kRKqJVNyvZUvf2JQsE9jM/VsfStjJqR7Leh9rvEkjKCCzelhBJg==
X-Received: by 2002:a2e:91c9:0:b0:2d9:b2be:bc7 with SMTP id u9-20020a2e91c9000000b002d9b2be0bc7mr9463931ljg.4.1713267367375;
        Tue, 16 Apr 2024 04:36:07 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004171f151a5csm19556794wmo.16.2024.04.16.04.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:36:06 -0700 (PDT)
Message-ID: <e50bb9c1-e094-4868-9403-fb7430195ad9@tuxon.dev>
Date: Tue, 16 Apr 2024 14:36:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] clk: renesas: rzg2l: Add support for power domains
Content-Language: en-US
To: Ulf Hansson <ulf.hansson@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFr405qt58wrqNdSn8bQPRqPKJ1omUZHS_VpQrX5zxUJug@mail.gmail.com>
 <CAMuHMdXRwcYMt7p+xT3svo1RmJ2Tvbamrx4++iYQ-mffKb6ZQQ@mail.gmail.com>
 <CAPDyKFoMiseXbSEK4ANOeWSuVhREibm0v0zg46Q3kJHX8jYpgQ@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAPDyKFoMiseXbSEK4ANOeWSuVhREibm0v0zg46Q3kJHX8jYpgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ulf,

On 16.04.2024 14:14, Ulf Hansson wrote:
> On Mon, 15 Apr 2024 at 09:28, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>
>> Hi Ulf,
>>
>> On Fri, Apr 12, 2024 at 1:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> That said, maybe we should start separating and moving the
>>> power-domain parts out from the clk directory into the pmdomain
>>> directory instead, that should improve these situations!?
>>
>> The clk and pmdomain functions are tied rather closely together on
>> Renesas SoCs, that's why the clock drivers are also pmdomain providers.
>>
> 
> I understand, it's your call to make!
> 
> Anyway, I just wanted to help with reviews and to make sure genpd
> providers get implemented in a nice and proper way.

I'll keep in mind to also add you and PM domain list for future patches, if
any. Would you prefer to re-send this series and cc you and pm domain list?

Thank you,
Claudiu Beznea

> 
> Kind regards
> Uffe

