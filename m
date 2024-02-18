Return-Path: <linux-kernel+bounces-70615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF0C8599D8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFEAA1C20C1F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D236BFD9;
	Sun, 18 Feb 2024 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tl4CWvPs"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1FA1DFFA
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297152; cv=none; b=Og3OBpLvypNp861TcRUPBvpKKJmwXPxA5FCGhbAljvbIkdfj93D3iMPY0FjQ+/yndkl+QOrGH9qK0wI5VbwLzqsQldC9USXsqHT7nFkQVMasvB2eBHPIedOBDuXxCJ8SnV2+vRMBRc1juHF9Zqi6nNY28QD0QRwZb1dkQ51WUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297152; c=relaxed/simple;
	bh=w+M+kqtnLpU+INH8uxs5/WFptnY58bdV8JJK1Yvr1ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5xcqIyxNxUu3pS/ThzjFDDD50NRy54Zc2bef0i5geyToPKITtnQKfA0wg/U6D62OlJMgXIWp6Z5J3S9HRRb5exZ47ECkRepUJtVShhHIRB9lHjo1ZLFZw2kA7cT/YK5v0xB/fDE7gMSjbeUXQp4VWiw6vKJTNm8oSG+N1J2RoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tl4CWvPs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d509c5706so136356f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 14:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708297148; x=1708901948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQQ2o/VIHyGxkFM7utx97JYZDFKZ38CN7sWDsc4f9qI=;
        b=tl4CWvPskpPcEhw5D3a7syh9tH4bDM76LbNhvA/xPCsnZGPIPRVZDHCF1jIvIVq2pK
         0uJICs+uVoPhNQNQDeH2h5u+P+FTPNNaxgb1PPxQI1KcjI3tYE0d/N5YucuuJn/m1T/G
         JWzRT07sqT1huB3YhIREOjFsmheixVkig1I1JXoIvzb6ZZ+MQY0vIdYwL0hJG9Soiilz
         tWCEe1mWBgj5u/OYtfevwUrNuG6RizwD5/z/xAdm62lgBKBsvAdmaJHv4tlWKyJp8M57
         B1BhAgWx9LdkKpabjeFlrGLIunORxgWgF/f0amY43EPXwlykiL5vVYLVG3oWe2jOaytg
         ul0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297148; x=1708901948;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQQ2o/VIHyGxkFM7utx97JYZDFKZ38CN7sWDsc4f9qI=;
        b=VAC4Z+NWPzQix0CwA768ThIP7QKjyMO7tsqIEkDYWvvHouBYYEwwPO57Wr5kjRV0hp
         ttuv2IIztVP+60qXMawpn3yO4YHtXeKbxs5Lf4Zi9TgwCA8e6dlK+HbZV48gA5iyDnL9
         mVzVONQFpV1c2QIf6sb7AIADx5IHlNLqHWnS77uUqO7agW6GQSqWHGJb8xaue+CSeV+c
         AKdDO73QQXD2coHyVstpfI56Z7WTGZPgsejoFtBNy2x7kO55cNRVHizluKPcid1EZOYh
         x4qa/4Cnom5NZczNX08L74nRK4d74xTSQfzsV9bVRyNhGEJQnmaO1ZYlIhy8Kb3+VFrq
         sdYg==
X-Gm-Message-State: AOJu0YwI76ISpVLSDnAAvrE4jTzCb1MQWHnTm+4cnpY7tS8HqeeWSyzt
	xtgDcN2DSCkJwdfi4A4IOLxL4WqnwPuWr5yycOFOhXgPHj5Y4/bR+UvNiA+z2ZY=
X-Google-Smtp-Source: AGHT+IHeIJpIVjXPkhSQ8GhS6dd+ec6VWCACvhZGppCrUdq2BjsMWx2siRd1nRn9MmkDNotK0sVyHQ==
X-Received: by 2002:a5d:45c2:0:b0:33d:1596:d916 with SMTP id b2-20020a5d45c2000000b0033d1596d916mr4831372wrs.50.1708297148290;
        Sun, 18 Feb 2024 14:59:08 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ay3-20020a5d6f03000000b0033d1b760125sm8742879wrb.92.2024.02.18.14.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 14:59:07 -0800 (PST)
Message-ID: <ec0b3dfb-3ce2-43f2-9cd4-042c3aca4cf7@linaro.org>
Date: Sun, 18 Feb 2024 23:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] clocksource/drivers/arm_global_timer: Fix maximum
 prescaler value
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 andrea.merello@gmail.com, patrice.chotard@foss.st.com,
 linux-amlogic@lists.infradead.org
References: <20240218174138.1942418-1-martin.blumenstingl@googlemail.com>
 <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240218174138.1942418-2-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/02/2024 18:41, Martin Blumenstingl wrote:
> The prescaler in the "Global Timer Control Register bit assignments" is
> documented to use bits [15:8], which means that the maximum prescaler
> register value is 0xff.
> 
> Fixes: 171b45a4a70e ("clocksource/drivers/arm_global_timer: Implement rate compensation whenever source clock changes")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>   drivers/clocksource/arm_global_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> index 44a61dc6f932..e1c773bb5535 100644
> --- a/drivers/clocksource/arm_global_timer.c
> +++ b/drivers/clocksource/arm_global_timer.c
> @@ -32,7 +32,7 @@
>   #define GT_CONTROL_IRQ_ENABLE		BIT(2)	/* banked */
>   #define GT_CONTROL_AUTO_INC		BIT(3)	/* banked */
>   #define GT_CONTROL_PRESCALER_SHIFT      8
> -#define GT_CONTROL_PRESCALER_MAX        0xF
> +#define GT_CONTROL_PRESCALER_MAX        0xFF
>   #define GT_CONTROL_PRESCALER_MASK       (GT_CONTROL_PRESCALER_MAX << \
>   					 GT_CONTROL_PRESCALER_SHIFT

Good catch!

IMO the initial confusion is coming from the shift and the mask size.

But should GT_CONTROL_PRESCALER_MAX be 256 ? so (0xFF + 1)

The following may be less confusing:

#define GT_CONTROL_PRESCALER_SHIFT	8
#define GT_CONTROL_PRESCALER_MASK	GENMASK(15,8)
#define GT_CONTROL_PRESCALER_MAX	(GT_CONTROL_PRESCALER_MASK >> \
					 GT_CONTROL_PRESCALER_SHIFT) + 1


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


