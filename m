Return-Path: <linux-kernel+bounces-141635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3910D8A20FD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 23:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C43E1C21DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2222239FFD;
	Thu, 11 Apr 2024 21:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cV6397BP"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30243717B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871349; cv=none; b=l8lE9+suLjSfIsn/ABG7Ke4aunjrDtLBeqybF8bKCO+B3+ph42rTLxoZFp5ZIx7PWA2j698UlQ0gLektGOmZdaqik94mkiAOCV3J/N3r+YXpBxnO93Dj7iWFsLbW1i7jHku/H+56Cy34gy0Ss6aQYLq6y6X5k8bOQWmwx4tutrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871349; c=relaxed/simple;
	bh=v3LeDlsw4fd8KemXMGl/9RHF7axUWT3DS7QRxveZaQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPTHE8T4aS/AOF8Nz9NejyzPggeN20SakP+JmNuhlcl1ACaFbjt8ljflhOTf5kt76+uQatUbRcJyvD2J+6lb3KUcFZstNp4eoSy/5yYlyd2YqwTmEnvSW1C2pXz05D/fwV1x5cNXPTi/Q+jCH6eilefgLdE2XcfpM+NxieWzWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cV6397BP; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d0161e13so361830e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712871346; x=1713476146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T4iIVALzwPejh7d3S8enGWCx89OQW+dXm19IHXNjAc=;
        b=cV6397BPh82Y+brjJR0wOpAYAyFVGPZJKbyxp/UXiggum72apciI+zRZajujY5QRV7
         OgT7V5dXxibyUhBM06MxxDf4d8n6S3aHxYzHWODlO+hICIWIOTftZvd3abJHFLFbD8+o
         YbfQgT1sxvoF5wla/GuU1OUbY9KUk9G7WBzYYwvTKBRNw1txRZtzZRpsFiMApAHmDxdo
         NGmQaB2m3II1FqFCOtLMKic6lZnIVW+a5xhaSzkATdIcrmugn/AkzCN6NJtI4ABPqVmq
         TlIKYLQC2Zf6RIyVU4yyuNRQjrxHvoYghs8PuowTxs6wFZC13FPF8VXTSf3PuIrsJHSH
         Qxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712871346; x=1713476146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T4iIVALzwPejh7d3S8enGWCx89OQW+dXm19IHXNjAc=;
        b=mYRHVn95LhYHIiHbwSr7iBnsH/1ijVtK1uW+YG76E3cl0HuM8PaAV1PvaOyvanw1Fi
         Ih+y81WyK5B3MbAh1JsYk0PNj2BkER3UTg935kVSvzK6oRqf1M/ml58X49TWtCGmJV5A
         VfGk6FRH5KzzUOcKqv5Pn1xJ22FFfzCR2JSVwTcDywv5QFaw3LsTft+bYgdJDBbbAldK
         h9N4FHBCsv3xbRMldzQxujdAGVTGEjsnZ5+WPrNgx8NzgILKpb5OPl29d6lLV/xQqtwV
         n0IvV8Zd/VxJHrJmdaqS043CdxUrssw0fl3t/rzCykMmZ+SAZVQE7+DLYHRXDPhR1Lyf
         wLAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnM8DS/aExaOLXqG6Scqn1kIXzZdKc2SZHf6t1d3pHYYcm+oOOLd8BTlkwzAieVLTmT69dL0K3j55tG4LKVS0oXdPtck0CZ3MufWIO
X-Gm-Message-State: AOJu0Yz4Ui9x0hzMN4jRxwwrbBw4/pWvoINm3caolizBFzVLDLdE4QrI
	ZGd/aaxl3ri4vI63skhsUr5H0vvOZYm5Ati+6fUcqPM66q4JxQoQt0RgAZxu4X0=
X-Google-Smtp-Source: AGHT+IHhPtTM6MDSSMKdH0nmnBGG027XDSi/RtJTrsfiuHSI3CqYwZHdp/t6eiZd5QJ+PqzWtrodtQ==
X-Received: by 2002:a2e:8084:0:b0:2d8:5af3:bb43 with SMTP id i4-20020a2e8084000000b002d85af3bb43mr511195ljg.41.1712871345700;
        Thu, 11 Apr 2024 14:35:45 -0700 (PDT)
Received: from [172.30.204.35] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e8e84000000b002d8e42c1b5fsm314682ljk.42.2024.04.11.14.35.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:35:45 -0700 (PDT)
Message-ID: <321aa524-ab64-458a-b4c0-70294cc5467d@linaro.org>
Date: Thu, 11 Apr 2024 23:35:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/msm/adreno: Implement SMEM-based speed bin
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-4-ce2b864251b1@linaro.org>
 <scvwfj44z3wpp7phvesfwjuv5awtlkwby2vvrpaq4i5fircrt3@i3ebya4iymf3>
 <730d6b9e-d6b4-41fd-bef3-b1fa6e914a35@linaro.org>
 <33qyr6cfruczllvavvwtbkyuqxmtao4bya4j32zhjx6ni27c6d@rxjehsw54l32>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <33qyr6cfruczllvavvwtbkyuqxmtao4bya4j32zhjx6ni27c6d@rxjehsw54l32>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 21:26, Dmitry Baryshkov wrote:
> On Wed, Apr 10, 2024 at 01:42:33PM +0200, Konrad Dybcio wrote:
>>
>>
>> On 4/6/24 05:23, Dmitry Baryshkov wrote:
>>> On Fri, Apr 05, 2024 at 10:41:32AM +0200, Konrad Dybcio wrote:
>>>> On recent (SM8550+) Snapdragon platforms, the GPU speed bin data is
>>>> abstracted through SMEM, instead of being directly available in a fuse.
>>>>
>>>> Add support for SMEM-based speed binning, which includes getting
>>>> "feature code" and "product code" from said source and parsing them
>>>> to form something that lets us match OPPs against.
>>>>
>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> ---
>>
>> [...]
>>
>>>
>>>> +	}
>>>> +
>>>> +	ret = qcom_smem_get_product_code(&pcode);
>>>> +	if (ret) {
>>>> +		dev_err(dev, "Couldn't get product code from SMEM!\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	/* Don't consider fcode for external feature codes */
>>>> +	if (fcode <= SOCINFO_FC_EXT_RESERVE)
>>>> +		fcode = SOCINFO_FC_UNKNOWN;
>>>> +
>>>> +	*speedbin = FIELD_PREP(ADRENO_SKU_ID_PCODE, pcode) |
>>>> +		    FIELD_PREP(ADRENO_SKU_ID_FCODE, fcode);
>>>
>>> What about just asking the qcom_smem for the 'gpu_bin' and hiding gory
>>> details there? It almost feels that handling raw PCODE / FCODE here is
>>> too low-level and a subject to change depending on the socinfo format.
>>
>> No, the FCODE & PCODE can be interpreted differently across consumers.
> 
> That's why I wrote about asking for 'gpu_bin'.

I'd rather keep the magic GPU LUTs inside the adreno driver, especially
since not all Snapdragons feature Adreno, but all Adrenos are on
Snapdragons (modulo a2xx but I refuse to make design decisions treating
these equally to e.g. a6xx)

> 
>>
>>>
>>>> +
>>>> +	return ret;
>>>>    }
>>>>    int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>>> @@ -1098,9 +1129,9 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
>>>>    			devm_pm_opp_set_clkname(dev, "core");
>>>>    	}
>>>> -	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
>>>> +	if (adreno_read_speedbin(adreno_gpu, dev, &speedbin) || !speedbin)
>>>>    		speedbin = 0xffff;
>>>> -	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
>>>
>>> the &= 0xffff should probably go to the adreno_read_speedbin / nvmem
>>> case. WDYT?
>>
>> Ok, I can keep it, though realistically if this ever does anything
>> useful, it likely means the dt is wrong
> 
> Yes, but if DT is wrong, we should probably fail in a sensible way. I
> just wanted to point out that previously we had this &0xffff, while your
> patch silently removes it.

Right, but I don't believe it actually matters.. If that AND ever did
anything, this was a silent failure with garbage data passed in anyway.

If you really insist, I can remove it separately.

Konrad

