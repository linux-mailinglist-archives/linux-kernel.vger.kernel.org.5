Return-Path: <linux-kernel+bounces-137466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8C89E284
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9361C21CAE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3EE156C76;
	Tue,  9 Apr 2024 18:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cq55X6x6"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A5156C52
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712687248; cv=none; b=u90p/33QEuqGOKjmvEWDqYlUffYVTXQU6/xDM27u+KGfkO25MxIrLEPCVmTXUNC/6PnCQFclGPeoYMGcAhkDM1FfNtvEtYnuDuxOr7U6r5Og8z2ai5f4mr+aRobKSejpYOUqicoqOrY/4oMBK/Nd1HnCvcUs0ti0Mt/mh0hbw4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712687248; c=relaxed/simple;
	bh=0JJDZcx+eKBXpMEkk77fdwILoU0kLYfp33XNimwQfac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJNE2cjM0ggfz4sGOlsa7vJqa/JAUyHPwy7UnXbrRk9HRI6HB6AMKyamGcIHwlKO4vVh+TqGTSc/xSk8pKADc20UD/kJdRs5QgMJ4BWWf3OPWTyQunBQ6c3qztOrfkZm/mBIUBFNnnytNo4wU7NpSW+L+21wkFUH/vpOVQ7rNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cq55X6x6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso3985573e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712687245; x=1713292045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDNDpKN5v2yIo8s3DyudTdW+0pg87u/NiQ3pUkTGC6c=;
        b=cq55X6x691gYbu0L53OJk1Rbn4fL9MM1Gi6M3l5yXYKJMe4H4wqSAw3OqiFu+hxMMM
         0tPrcpZk4hDcAINPzuWB/X5/NAe8Pz+vHr+g2ojxmcsDxgkl5/pVVQwQkNI3nkuaV9C0
         OUJnACQnbARlTg8blwxqOFpEduCta9Se9vIUmYoAfO5HCA9B2isMYQyZIhkTfkDytas8
         ur5HamHjr8kOiU0Fi+By5fKlMICEaRxT9L3q0mMDyNsLAf60Ahlnj0cfO9UsYl0j+jIv
         kCTjJqSp8E5ZaxBCb+aEco4+sbEYYL4CbuIV2LJONtpV1stClyrEtLK/ThhntkqXgWXP
         eM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712687245; x=1713292045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDNDpKN5v2yIo8s3DyudTdW+0pg87u/NiQ3pUkTGC6c=;
        b=JhXUfsohLGqh325V6ZJOYMrbY9h9+1adnlMo2PjwCy0NMGQRvMLla2FOxEO0GvMqMD
         y+HWsIMj7GWjggumNr5IKaUiQaOuka1dAkB/6UDS7az1p5i6IBlgvXSEdO55tOuqcMcY
         MfozVP7A8mkOSwFp9wijUTQEBS82nWq+SVFaXu5LTt4XsqPR9qlTMiBzkXMeFkkdhF1o
         RIEKH9FncD2ZJTgv8hkeUFhKW6Z6X5Y3yo6SPSvUBMmKukmirNRkGSN2ZNmTAKTTt0U4
         mMSt7x5WOAMg9lLAP2seR6d5pW7I8ZHWf9CbndWK9DOfyP2pDsdyQjYtbak8GoyYUtvm
         wztg==
X-Forwarded-Encrypted: i=1; AJvYcCXKBMwcAAHwmY0w9yZxFmS+VWy6EXUy7y9txG5R+lM3TkyA+TlWUup7OTPceivt44naQAtps/kzJGssq2yKqFuiH/6cnConoiwf/VdL
X-Gm-Message-State: AOJu0YxD3kmN9nt4L+lEaESHSaS0+0O72bsL3+oW1DAjAZ0Std7PZKgX
	7hl6UHceN4BfsHur0/qUgLCzgXfZHEAhhK3OhepL6zAhpQgKyUmt3JTelkHzGu8=
X-Google-Smtp-Source: AGHT+IGRKkADZsJNiIkww/uuH4jc36SsQcakLssDRn6++Y7zOSTbpO9G9O8NJi1Dv7B/S7r6n5ZnZg==
X-Received: by 2002:a05:6512:548:b0:517:30a3:d000 with SMTP id h8-20020a056512054800b0051730a3d000mr129934lfl.28.1712687245126;
        Tue, 09 Apr 2024 11:27:25 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c5-20020ac24145000000b00516c8826719sm1607013lfi.197.2024.04.09.11.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:27:24 -0700 (PDT)
Message-ID: <74ebd488-15c1-47a5-86f4-14263e3a914e@linaro.org>
Date: Tue, 9 Apr 2024 20:27:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/msm/adreno: Allow specifying default speedbin
 value
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-3-ce2b864251b1@linaro.org>
 <pncr7ecf4eir36skul3iwt2nf5bpuwd5zjfzzfwwnxjwe4hoes@6z2xe54crijp>
 <d8a2ef87-f29e-4bdb-a9b8-591b8bd5d2b2@linaro.org>
 <tkcbl2iwcy3feoggbk737gx32qsxe5p4ad6lfrujy2pazccrhm@kif3guuzay6h>
 <CAF6AEGsg2xCCC27t_Gqu=MMQ6tckVw=Zj90p4x7EuOm+VKA=ig@mail.gmail.com>
 <quil2y6tbilihgont2xekay4joxgnsanu3khgo77omtwkolslp@ozuaajpv5uon>
 <b77a3161-9a18-4523-8528-31c2f2f4f476@linaro.org>
 <x4sgmdodoacsu6culbjjsw52ucaylpqj2ll6tkeppllzhfqiqn@lysclxogvcfq>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <x4sgmdodoacsu6culbjjsw52ucaylpqj2ll6tkeppllzhfqiqn@lysclxogvcfq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/24 20:15, Dmitry Baryshkov wrote:
> On Tue, Apr 09, 2024 at 08:07:56PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/9/24 20:04, Dmitry Baryshkov wrote:
>>> On Tue, Apr 09, 2024 at 10:12:00AM -0700, Rob Clark wrote:
>>>> On Tue, Apr 9, 2024 at 8:23 AM Dmitry Baryshkov
>>>> <dmitry.baryshkov@linaro.org> wrote:
>>>>>
>>>>> On Tue, Apr 09, 2024 at 05:12:46PM +0200, Konrad Dybcio wrote:
>>>>>>
>>>>>>
>>>>>> On 4/6/24 04:56, Dmitry Baryshkov wrote:
>>>>>>> On Fri, Apr 05, 2024 at 10:41:31AM +0200, Konrad Dybcio wrote:
>>>>>>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>>>>
>>>>>>>> Usually, speedbin 0 is the "super SKU", a.k.a the one which can clock
>>>>>>>> the highest. Falling back to it when things go wrong is largely
>>>>>>>> suboptimal, as more often than not, the top frequencies are not
>>>>>>>> supposed to work on other bins.
>>>>>>>
>>>>>>> Isn't it better to just return an error here instead of trying to guess
>>>>>>> which speedbin to use?
>>>>>>
>>>>>> Not sure. I'd rather better compatibility for e.g. booting up a new
>>>>>> laptop with just dt.
>>>>>
>>>>> New speedbin can have lower max speed, so by attempting to run it at
>>>>> higher freq you might be breaking it.
>>>>
>>>> Usually there are some OPPs in common to all speedbins, so picking a
>>>> freq from that set would seem like the safe thing to do
>>>
>>> Well, the issue is about an uknown speed bin. So in theory we know
>>> nothing about the set of speeds itsupports. My point is that we should
>>> simplfy fail in such case.
>>
>> Or we could allow e.g. the lowest frequency (or 2) which if often shared
>> across the board to work, giving a compromise between OOBE and sanity
> 
> That's also an option. But we should not be using existing speed table for
> the unknown bin.

I derived this logic from msm-5.15 where it's "intended behavior".. I
suppose we can do better as you said though

There have been cases in the past where the default speed bin ended up
having a higher max freq than subsequent ones, and I don't think I can
trust this product/feature code approach to guarantee this never
happening again.

So. I think sticking to a single lowest freq and printing a big red line
in dmesg makes sense here

Konrad

