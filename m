Return-Path: <linux-kernel+bounces-42079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE25483FC0A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCCDB2296A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E7BEAF1;
	Mon, 29 Jan 2024 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6JDWFOS"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36089DF46;
	Mon, 29 Jan 2024 02:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494204; cv=none; b=aQWNiACggOyt/KuUdRXIj9vcISG8dfPWtX2YRxlF7jgXpNNnyOyqspO6UvVGf+YaWoAI9jO9mQIaFErX3I2lDPsd3bFGJpkxkmupaMvorn71Xy7K57Ntrd5Jr8RjcKgZJBUziDS+iHxXtAU58OvuhpatItjXWEtgHHYi5Nagk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494204; c=relaxed/simple;
	bh=k7tqqEHDQfhpdfeqK4PWeV1VnbOffVVRA0WzcBwzj3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9C4UoqtEkD/qEHmXLN7726NDZeC92/SX6wf//BI/VsXVJnM9inhVbC2gF1sVESSwIylIdMzZ8fi3BZqxhp2o7LUUrvXUChx4miea/4zQFicqtc42Xy3MkdlfHiAixR0cBNyLTRxYK9USAGzXgkfwIfz1BEHAtUGyvs6GLGepFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6JDWFOS; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2903498ae21so1137399a91.1;
        Sun, 28 Jan 2024 18:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706494202; x=1707099002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3mjiGLCZC5rtVXIMAirs+5VBtB3jcIfSuBZ8wAgAJ6E=;
        b=P6JDWFOSVNrv/s1PReyeNrj4GOBBmSGqQbug+mWUUJDgsKOLcE2of18hs10wSRwKMZ
         Ypspof71spA3AOHfkB6COkUQHlJYRYV2fKh03uSdKx5vEX2So643HAPZJINXcVJpwuME
         FX/fdcUTY8EmSj0ncdP85k7uv4nvGjZMXMmB2HRREX3XRYUlzqCpaFF3lH11zvc/+9LL
         e84PowPcuW2Okr6XyIBjmMhWsfbn9FCQmjJCU+RyBqxYvJ2XtyGYUCqNCcrHQDjRaxr7
         F1wDYeS1EWnINeu8+FolwlpyjgdtJN7SGZs1kFaPITVKmQ7RYsqZ4pMCWX2aNs2ai0Yf
         L+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706494202; x=1707099002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3mjiGLCZC5rtVXIMAirs+5VBtB3jcIfSuBZ8wAgAJ6E=;
        b=cpvf+I7dOO5bu7hYLCcmncaOeCS/Z0th3cRZW6B/uGrIE9Yb/EgmjFoCSzly0gN1+p
         yp//3xxl48w0bz+1C24/1PIMXSIYdkC0P8iTEwRZSvt1CpSLvpgptarT9i80sUA3E5nG
         c7WYud5F4vFl2sL7jskRPcssHyuRz0JoPzhQVhKCXiAiG+/rhuQ1HO47oeAE7yN2NFrY
         v5fKjj1PnmePlxL8fdKkYS0p09nk9l/XuXPPEnSwY+B37Dv0L7sxXQRwvcfuouYBPWJc
         bMHj4o/z6ro78u4JX4YRJcduW6a/yVLHTHFxB/UMSH6UBx6VRFWeNCs8iFjOOKjYo33T
         ZjCA==
X-Gm-Message-State: AOJu0YyoQp9z+VIGY58faYgTxCvopPOLUHM0vV/PDOR8zBVuOac2z8CJ
	7IX5B4QTZzz5+ulbA8QQ4g0Cgx374R8rDj4PdPHyoqMEfRacpHqK
X-Google-Smtp-Source: AGHT+IFvYo4Wt9EQYFDVRWdym6JuhCaS5Rmf9f2vKpfy2AU8wdOaJh9BcGLUl6hgG6/NTMed3ZU44g==
X-Received: by 2002:a17:90a:7f92:b0:293:bf6a:feae with SMTP id m18-20020a17090a7f9200b00293bf6afeaemr1246707pjl.18.1706494202319;
        Sun, 28 Jan 2024 18:10:02 -0800 (PST)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id g8-20020a17090a7d0800b0028bcc2a47e9sm6871980pjl.38.2024.01.28.18.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 18:10:01 -0800 (PST)
Message-ID: <1aff21ed-c185-4d23-8260-fa182a592d15@gmail.com>
Date: Mon, 29 Jan 2024 10:09:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO
 driver
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, j.neuschaefer@gmx.net,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240123080637.1902578-1-ychuang570808@gmail.com>
 <20240123080637.1902578-5-ychuang570808@gmail.com>
 <CACRpkdYi-y9zWAR71rQOtKVJOuGgE4n8Q47YXZW=Pt345UWDkw@mail.gmail.com>
From: Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <CACRpkdYi-y9zWAR71rQOtKVJOuGgE4n8Q47YXZW=Pt345UWDkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linus,

Thanks for your review.


On 2024/1/28 下午 11:49, Linus Walleij wrote:
> Hi Jacky,
>
> thanks for your patch!
>
> this caught my eye:
>
> On Tue, Jan 23, 2024 at 9:06 AM Jacky Huang <ychuang570808@gmail.com> wrote:
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Add common pinctrl and GPIO driver for Nuvoton MA35 series SoC, and
>> add support for ma35d1 pinctrl.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> (...)
>
>> +       if (ma35_pinconf_get_power_source(npctl, pin) == MVOLT_1800) {
>> +               for (i = 0; i < sizeof(ds_1800mv_tbl) / sizeof(u32); i++) {
> Isn't this equivalent to:
>
> for (i = 0; i < ARRAY_SIZE(ds_1800mv_tbl; i++) {
>
>> +                       if (ds_1800mv_tbl[i] == strength)
>> +                               ds_val = i;
>> +               }
>> +       } else {
>> +               for (i = 0; i < sizeof(ds_3300mv_tbl) / sizeof(u32); i++) {
> Dito
>
> Perhaps more cases, pls check!
>
> Yours,
> Linus Walleij


Yes, I will use ARRAY_SIZE instead.


Best Regards,
Jacky Huang



