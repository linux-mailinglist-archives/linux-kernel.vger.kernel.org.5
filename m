Return-Path: <linux-kernel+bounces-109126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6599E8814F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAFA284859
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E866052F72;
	Wed, 20 Mar 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZIHFm1y"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F7A54BFE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949994; cv=none; b=m5rgCebQhqIW874z222ZBgk0F208Z1cSOEF7L50mB38EcvtZkF39Rjmd4ZiOBCoj/GDMTJUv+z2Mp99bIVoOg1Pt0qn4DOHAOuPsfjPb5aPieMiGv+etHRdir0jzDNrHS0INSFR9SdyZRLsvrcM+UTCdbz+y1iMLRtFk0i01p8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949994; c=relaxed/simple;
	bh=MfcBgDfPvff0AWarnVaEuRLv0qFXgnBjoPJHUPjUFo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OehGgpGa5AiFGgWVrTh4ZehrhzZv69vsnS01q7ra08Nckk+STRDE3+nHc6YYPIxqlTwQbalYkwLJhUmTc++7Qk7xc4H3ZGuZLChb7+MipIFPMc+HZ286ql7eUw3zoOm5/yRblNwLYVCl6QOPHzAo29eAle68Siy3BixZ2fZoZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jZIHFm1y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4146e53d92eso4470265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710949991; x=1711554791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIWKVzwazGNc+LuikEYYEkUxdrkXemxYcbgcBcqPCCc=;
        b=jZIHFm1yHz+9JOS161pahJX3TXTU9y4LsKqeLTZhAFtfIMzAUExtrf7LEKYBZOLtNU
         Zb03jRcW25WU2o9EYoeAfVXVCRrDpvFoK7UMC7DQRjuAEBoC1yhhS8ptSW77N8Sw+ANL
         FBTda9OPXSM/dfPbE2/DtCjVSdbqvJ0NWYBaV1aVHI4K/VO3n8HEqAgqnZEQgWmH2HX7
         4ZyNOfqgHf7wE08fFIqYiBtCZ5GPaLI6tI7YlvBzFx12VMfatRFuzHM/vAkIMFOb6+zV
         XqXw1yTsv4VYNUNaWLD7pxEl32UFonAiTlmIwJOwoYuXOJ0D2GEnL1Y3OJipCv5YA77D
         QgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949991; x=1711554791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIWKVzwazGNc+LuikEYYEkUxdrkXemxYcbgcBcqPCCc=;
        b=JIhSe2m8BHWAXAPFGgQsWNx+9aPf9qdgz+KFDX2IvZ9gvkgPKFFfoCAEPCjo+Cf4Ub
         P+cGCWUhKxdkJQA7PSQayc6qXGtGz+pOKwn8EK2TViiLKM9BFkUS39xTP9lhSH3DzmQE
         3Fg9gSkcol94zBxA9BS309D9vG1N+qWxAC2FLTIyGQhOE1v54YThZIK0sUKq/a+nnVaG
         2leCKFWR2qNbAfm8l+Sf3PKlFzaudm8MKg+pxZGkIdnCst4qi8ERnbQIzKN7d4GWN2ce
         hOI1lo+T9by8lVLeEMJJzwiKEq932mu4UKGsNvWgrL3t8iJBrCTE7k/488u+1ySwsGGr
         aOoQ==
X-Gm-Message-State: AOJu0YwUaraspNqcd55PqB/f9QGYIaeK5E2209oGFnISKP52YIm2V4Y8
	txScuMJU/nS3TNsjcs/CJjkCIzZ1VPkvxzSGZXUccUFXPo4e/8rClrVBgUbuy3Y=
X-Google-Smtp-Source: AGHT+IFfMuzR4KHJ23h9jEnJ0HAxseLpTPp/jJ+UgXkwTsmnSYdXQFyHKchgjH73mFjGxjSbpHvsLg==
X-Received: by 2002:adf:db4a:0:b0:33e:7831:8f69 with SMTP id f10-20020adfdb4a000000b0033e78318f69mr4517054wrj.32.1710949990870;
        Wed, 20 Mar 2024 08:53:10 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bw11-20020a0560001f8b00b0033e7a204dc7sm4401564wrb.32.2024.03.20.08.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:53:10 -0700 (PDT)
Message-ID: <059af407-8c12-4773-810e-09dc66e31d39@linaro.org>
Date: Wed, 20 Mar 2024 15:53:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] media: qcom: camss: Add CAMSS_8550 enum
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, andersson@kernel.org, konrad.dybcio@linaro.org,
 mchehab@kernel.org, quic_yon@quicinc.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-2-quic_depengs@quicinc.com>
 <bef76969-17df-42d0-82aa-59a75a488cb0@kernel.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <bef76969-17df-42d0-82aa-59a75a488cb0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/03/2024 15:51, Krzysztof Kozlowski wrote:
> On 20/03/2024 15:11, Depeng Shao wrote:
>> From: Yongsheng Li <quic_yon@quicinc.com>
>>
>> Adds a CAMSS SoC identifier for the sm8550.
> 
> Why?
> 
>>
>> Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/camss/camss.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
>> index ac15fe23a702..2f63206a8463 100644
>> --- a/drivers/media/platform/qcom/camss/camss.h
>> +++ b/drivers/media/platform/qcom/camss/camss.h
>> @@ -78,6 +78,7 @@ enum camss_version {
>>   	CAMSS_845,
>>   	CAMSS_8250,
>>   	CAMSS_8280XP,
>> +	CAMSS_8550,
>>   };
> 
> What is the point of this patch alone? What does it change? Why adding
> enum? In the next patch, are you going to add one line to some
> kerneldoc? Another patch, one function?
> 
> Best regards,
> Krzysztof
> 

Yeah true enough, you could also add this enum where you use it..

---
bod

