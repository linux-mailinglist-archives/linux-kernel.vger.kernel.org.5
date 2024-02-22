Return-Path: <linux-kernel+bounces-77469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C1D8605BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D91801C20C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C817BDA;
	Thu, 22 Feb 2024 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0JgyX/5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE0256A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708641269; cv=none; b=uMpQoqnAf7+3YBcbDUSh2JGPdvSxosWg+6e/KbHozbUDjPt6i+5EnpoVicmgct3ynWYYf69YWzjZ3ZM0IjO7vOPEkz0xT3aNaFrhOis5GRHPzOX7nxaAIhg5Q4A/iyrIlUe+MyL+GV14FFE6/anIZU9qEaG/ktImKek3rCZmcYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708641269; c=relaxed/simple;
	bh=MCKAzJkODWxYmV8TZ32QhnVjnX17oFGMm8t7tgMVJ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7l5y0bYCXT41gQTOv7EeF/xEAVRFk2VJWmjKDzlmvIYBNflOEoV2rA13yQs9xeH3q+ajLy0IcaIsS/l/g9lSJZptmIbbksz3bCmMJ3jilnSQI7/3ZSNZ9MEK4b4C1I8dt5oh3FrLX74T/E7bngIzlH++0vFzcpxFgGeNZUgPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s0JgyX/5; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4127700a384so1823685e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708641265; x=1709246065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09lVyCcePOUyzrMf3zM5yudHpd6QLbyHExpRDXktLiE=;
        b=s0JgyX/5oIadLkHPBMZtfCuV8c9dyJXaJPYIHoZtMGvH9a6AbrL2lu7z+4fKnJbwK1
         DDwHEh8HJRmWmvsNM3aV6JWFxXr7wRfAH2mll80qpSA+ygLaUQavu0TXF0kNB3rZ2i/s
         IJoBDVC4GGoKrGd9FEyo9IvnK/CmnbWRAAH8ic9meeBr1sbASByz1w23c6y1FUnHfNeD
         fai19z+WV1NVSq+Rvx/+Jbm6VBYSaUuoV1VfL3YLNleKrGGZX2rnkO+Jba3s/PSQK4CD
         o9N1xbYbYEXts3m1hglt/yBbPtDGXfMX/rj/SDTedw3Q4qmY5StWo89IZyW7GmUI6GGS
         1uYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708641265; x=1709246065;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09lVyCcePOUyzrMf3zM5yudHpd6QLbyHExpRDXktLiE=;
        b=ZdKDOtv87PhGpJYXvI2xS0WVl1zBjHCtDwDFpu9kVny5KR4AVkaLtLa5fITe9ztTvM
         sQA22l0NgbFXBPhHO9ZFEwazIPy1FwaOQKfBkIs9lu+fHyGeEhz3Y0IwT2Wr13O9pUMd
         i6u3J2g9LF6jdm+VE4Ijyq2vHFHulI+vRICpbab243KBpcrJOKubZWS79cVN96ejmLpC
         2oCZ1pDboVh9ZE+smN/UOEgX3dtHvSlkzNFnrqeEJQdJ4YscXkTItz5o6RYQSic4QJ2a
         dysUZbydfTPl6e4PhpTeSoPdstGDKirrBs+bUUzvK7wlLOl/KMINFdZu3VRRPO7Gk4mx
         nH8A==
X-Forwarded-Encrypted: i=1; AJvYcCXF3fjlXtanFjipjb+F9QgfEd3KKDVbXYINpRDHYg8le/NaJ5FtxAj/SKdV/RF8ZN6vWaiYFTopIejHWJpSYsPpZGzFtYBPNL7rTjqi
X-Gm-Message-State: AOJu0YyjJGR3XnhaQXznNO5Y7iQmKPWi1XnsnHH0eBYKcKmzpoTegOUh
	fnfFvlYYrgv/G5fIN6FeS+fLWGcgYMp05yaNkzMmxEZ7EbtXJ1TE4ZcQD4WnYzw=
X-Google-Smtp-Source: AGHT+IG0Aw76kDBEFqJvdIng205GCG4/BqVAcV/vcsWDMEjbwaeVF9V2EWvO2/qNNewu64aXqFRWIA==
X-Received: by 2002:a05:600c:1c9d:b0:412:8c96:b15f with SMTP id k29-20020a05600c1c9d00b004128c96b15fmr41566wms.37.1708641265629;
        Thu, 22 Feb 2024 14:34:25 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i4-20020adff304000000b0033d87f61613sm392857wro.58.2024.02.22.14.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 14:34:25 -0800 (PST)
Message-ID: <230587eb-dd68-414b-af15-47b1eb3d14e3@linaro.org>
Date: Thu, 22 Feb 2024 23:34:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] clocksource/drivers/arm_global_timer: Simplify
 prescaler register access
Content-Language: en-US
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, patrice.chotard@foss.st.com,
 linux-amlogic@lists.infradead.org
References: <20240221214348.2299636-1-martin.blumenstingl@googlemail.com>
 <a4f8fa60-7c03-4946-a135-a405d53f361b@linaro.org>
 <CAFBinCA3ho9fAb-iJhUEVw-=_Jbgd6UU8_9WEyvpt-+CL_V6ew@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAFBinCA3ho9fAb-iJhUEVw-=_Jbgd6UU8_9WEyvpt-+CL_V6ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/02/2024 22:57, Martin Blumenstingl wrote:
> Hi Daniel,
> 
> On Thu, Feb 22, 2024 at 11:02 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> [ ... ]
>>
>>>                /* prescaler within legal range? */
>>> -             if (psv < 0 || psv > GT_CONTROL_PRESCALER_MAX)
>>> +             if (psv < 0 || psv > FIELD_GET(GT_CONTROL_PRESCALER_MASK, ~0))
>>
>>                  FIELD_MAX() ?
> Oh, I was not aware of FIELD_MAX() - thank you!
> While researching that I found that there's also FIELD_FIT() which I
> think is perfect here. What do you think?

Ah yes, even better :)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


