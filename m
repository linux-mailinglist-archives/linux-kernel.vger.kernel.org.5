Return-Path: <linux-kernel+bounces-99250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA0878592
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 426121C218CA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1584AEDE;
	Mon, 11 Mar 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AIayZp4I"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58E47F63;
	Mon, 11 Mar 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175023; cv=none; b=GJdolVtgrOcD7c5DQ54amzL9tobFihaF2yipRK1mcyOVS4ueuqXZUzjsbRhkvbykS43YmRdd5PGRrbV335iRv/3irZkcmy1nkT1BQzKb1N+WetNZC73Tm4CeGoVS3dJ3J6QPT836WfGtWjWt11dHiWGqsj2Aj6PfbLhf60vzFSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175023; c=relaxed/simple;
	bh=h+wrs8mN/gidPcVcygC1dOILI3yL134m+iHr8lFTiuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ1B86jp83fOuEvS4nlaLvSpYQ78hvuP6WFMfweKKQx/g7DKIqhUx0npP1Mlox9VvDeK5uuO6bz4tzJilU/BNddlaIh38bHqGm1jkXc4sJRe9F9DjpbDSZ2jPcrCKcaJ3xzNVuKmTGkaS0VzvFnZewMxNQY2xLLnkciIfxcYCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AIayZp4I; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-29baaf3c018so2264819a91.0;
        Mon, 11 Mar 2024 09:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710175022; x=1710779822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLct2U6boWbEoNTgr6S96SFwfFI2J0RwJN6ySSqRZHw=;
        b=AIayZp4Iod+BTPDSSJLQ4b5b8FgSocOCp7ErxIlZrnv153vINIkmtog/2ssa4iK9uf
         19++XJTtGHzlQ2YDWealwfek05Zh5mf3ZoYPeYetgRe+0TUMwGifpP3Pz4Fd4NEUdkFN
         wxAo6QIGC0FbwUlZDO6Vwv6Hh3+qJLYunrG5rxEo/tgnLRa4rTPdHLEt28pCSeMft8AV
         2vKpxGmY3wl2G9n3VyaC8doNqB18UskB9kQQjSMH0WN7HWiwswo8CaGOOD4aXUDSj+Kp
         4xXyGKgrPhTuK1pN/ZGVImE9bfidebFhsjZ+Qy3t+RYPUcNUpGqDnEuOXv1WboHtyiX8
         KUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175022; x=1710779822;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLct2U6boWbEoNTgr6S96SFwfFI2J0RwJN6ySSqRZHw=;
        b=FaP92kAdnomVuCXLb/V5bEcE63VEabtR5bzhvyt3B+ET0lqg6Nxeal9hmAtIi92hYJ
         3AvDyV/uwlFjhWf/Khsviti10V0DA/GYIhkgQr2SNozJSFPqUjhbFVZYxIXbBPjZ47c6
         Z9h+oQAmoa2rkTbvUt+XCOpzfwBHqWEWNi+ItEmOnNAU1hFkhe98N9DQEsfw3Wuoaq/+
         xbJ8lasX7Ph4JFQ/2rvCKutL8+wp1w+epXJx2aGquTM++q2WzGXHDn5QVE6UocEfu3xD
         Fjzfm+voZBasOOfXC5l2UFq7cyx49N3uR0x3YLt+vP5vnnSUQvY10XsMb1sqiHN3LDOe
         YiDA==
X-Forwarded-Encrypted: i=1; AJvYcCVxwdsh3Q96S/icGvWBwuSqr9BhJdJ9l6IQiFutZS42cvEkYdL76V3z/47gObynLbqsizCzNezacehb3oEzP7MXYvK1eEbHerCykMCSpDIngBlzgNjDnqvchgvOZtmalqLy9rq5
X-Gm-Message-State: AOJu0YzBzyueEUXJrPJfa1F3MwbABAnEgaOgc4t0xMQ+2VVe0AhBhaaO
	Yf418NtInjxlX2BhiIdN6e/Ql1SZeCA8AOwkBn/CB0FdF7SQXl1K
X-Google-Smtp-Source: AGHT+IH68NVLE/dYt1wUztBjce1ve0njmXShMJ3V/LApEFjZ0kHKgP3S8t0xTiFDUQbS/YYCdNAG5w==
X-Received: by 2002:a17:90b:1283:b0:29b:bf46:a32e with SMTP id fw3-20020a17090b128300b0029bbf46a32emr4917767pjb.39.1710175021704;
        Mon, 11 Mar 2024 09:37:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id z24-20020a17090ab11800b0029bacd0f271sm5879626pjq.31.2024.03.11.09.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:37:00 -0700 (PDT)
Message-ID: <10bb46be-b189-4a80-82ef-bf7934fe6c8c@gmail.com>
Date: Mon, 11 Mar 2024 09:36:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/1] net: dsa: microchip: add regmap_range for
 KSZ9563 chip
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240308105021.2552975-1-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240308105021.2552975-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/8/24 02:50, Oleksij Rempel wrote:
> Add register validation for KSZ9563.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/dsa/microchip/ksz_common.c | 121 +++++++++++++++++++++++++
>   1 file changed, 121 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 030b167764b39..2308be3bdc9d8 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -666,6 +666,125 @@ static const struct regmap_access_table ksz8563_register_set = {
>   	.n_yes_ranges = ARRAY_SIZE(ksz8563_valid_regs),
>   };
>   
> +static const struct regmap_range ksz9563_valid_regs[] = {

Missing comment to describe those are global registers, and not per-port 
registers?

> +	regmap_reg_range(0x0000, 0x0003),
> +	regmap_reg_range(0x0006, 0x0006),
> +	regmap_reg_range(0x000f, 0x000f),
> +	regmap_reg_range(0x0010, 0x001f),
> +	regmap_reg_range(0x0100, 0x0100),
> +	regmap_reg_range(0x0104, 0x0107),
> +	regmap_reg_range(0x010d, 0x010d),
> +	regmap_reg_range(0x0110, 0x0113),
> +	regmap_reg_range(0x0120, 0x012b),
> +	regmap_reg_range(0x0201, 0x0201),
> +	regmap_reg_range(0x0210, 0x0213),
> +	regmap_reg_range(0x0300, 0x0300),
> +	regmap_reg_range(0x0302, 0x030b),
> +	regmap_reg_range(0x030e, 0x031b),
> +	regmap_reg_range(0x0320, 0x032b),
> +	regmap_reg_range(0x0330, 0x0336),
> +	regmap_reg_range(0x0338, 0x033b),
> +	regmap_reg_range(0x033e, 0x033e),
> +	regmap_reg_range(0x0340, 0x035f),
> +	regmap_reg_range(0x0370, 0x0370),
> +	regmap_reg_range(0x0378, 0x0378),
> +	regmap_reg_range(0x037c, 0x037d),
> +	regmap_reg_range(0x0390, 0x0393),
> +	regmap_reg_range(0x0400, 0x040e),
> +	regmap_reg_range(0x0410, 0x042f),
> +	regmap_reg_range(0x0500, 0x0519),
> +	regmap_reg_range(0x0520, 0x054b),
> +	regmap_reg_range(0x0550, 0x05b3),
> +
> +	/* port 1 */
> +	regmap_reg_range(0x1000, 0x1001),

Seems like adding a macro that encapsulates all per-port register ranges 
would help a bit?

Other than that, LGTM!
-- 
Florian


