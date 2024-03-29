Return-Path: <linux-kernel+bounces-125149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB689210F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB21B1C22649
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3857E575;
	Fri, 29 Mar 2024 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cyoa8nM4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5801EB2D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711727906; cv=none; b=GSJ2gc6LEnkVlklkfr0wCLpTZi040x+sv4BTDdbYohLb0V25/F2HhqN6QybnP2xSEEHmQysxCFQZkx9xQFbHwab7dAM9yo3RlSiIyhTwc2MKgwMB47P6qUulmoKaVccp57P1hgDNfdPGGxaLdXsf6KwLiYwFbKkinL+wFTrt+EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711727906; c=relaxed/simple;
	bh=A1bgOcngoGNeuXrg9Irwhjmy26htvQefZYRFRk1Yg1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0ibo8KXXejULdXO1gQ9yf4jNf6ilfd46ITUQJFq5WUa20L9wiEsyFXnOBivmr6ycxIpWflEzImKYn/icpcl8QO3Z3fWRDKu6DWioNfIgeL5j5jf/mwXQgu3htE9czkA8BnC0Fxon7XCMmihI2q0MIBFi6ssaky0od1ptUhQwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cyoa8nM4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-415482308f8so10091935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711727903; x=1712332703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5iRY6WBaoFR3Ut7RsgjjeOP69wD4aIaTAzv0eG7uu5Q=;
        b=cyoa8nM4+fUVBbW9yu39VPN8k3q8rGk/wj2XCjkfaEPRx9UL2jWppO7hT7QRWEGZMM
         3Y8V8bpa/keWDvqP7CBgBuDDZ4bN/K24YpWbBeW3t+AdvlsZ8WkoYkYC/OrN6mZ4DLE+
         G2G4hlks0AFHZ296QA8oBYDwMRJc/YibIE1gx7DvmOVPCXjNLdJX0qFDTD+woG1rOcLB
         R2oQE78EFZEcsjT7GJlI0SndWmniQuIdtxY6dSHAUqLddKeUZLe/zDu0oiJqU/dSnivk
         Zlffc1wQAlLecGbwlpcVoONn2n4wZVOMKuKoOXVf9q3PaV23tubvN8W0zqUdOeVtSWje
         MCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711727903; x=1712332703;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iRY6WBaoFR3Ut7RsgjjeOP69wD4aIaTAzv0eG7uu5Q=;
        b=hjui6HrJ+kc0xZTpvsJq1dnMfkiHAC6VfVA1kDRVc0qso4AKsZwj5USrxzhz1mNHoK
         ni9z3nervkT2q4B6A3UO4u1xmlrFu7FazyKkwByj0qrek4q6YJJIlmY0QWMqDywFgaC+
         MPa7sWwjX7P1vu9euH53sfwMrMt+EmQ2wrmSLEp3E22XKPtjPaaEudKbzw4/RXly7wCC
         tDL/yrxkyNVXa+6m9xta+lNHNQ3CFmwd9STu7hBgxIHxDV4zHklf8toBBwi2UOa1b3HJ
         iHh0Jtc+sOZclyaRxnLMkAERBM6qX7+gDXJtVw3WYvos60ISA+F5za4qJNkMHm4cK1Az
         Besg==
X-Forwarded-Encrypted: i=1; AJvYcCW9vYejZP7mSqdumO+xlfuuDKauZ2ZsOJP3bIfjb4Bbrf/4p6NluBJA1CF3bY2Ghx6S8seQq8ELANXhe8jTgC5Q8Asi+m7dEwBynZJM
X-Gm-Message-State: AOJu0YxlJi/VvB1Rvu1YUzKvrZJntEJT//1DTva+vUdsigHkwVi0YK6h
	vDlslNWE7TZ6QBIcNdrnohAgXNsJRRexsyWu9MVq1jeDVSj1n1HkbzBCOstWIN0=
X-Google-Smtp-Source: AGHT+IGs8uMaED9NrwRWp6VqyH2obfV07nqS2HtPgQn6vsGCO8x4AzJBZmyKgceC6bz9Fi5is28FOw==
X-Received: by 2002:a05:600c:3ba7:b0:414:8938:70ec with SMTP id n39-20020a05600c3ba700b00414893870ecmr2089688wms.27.1711727902900;
        Fri, 29 Mar 2024 08:58:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600c450c00b004154853f778sm4681379wmo.48.2024.03.29.08.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 08:58:22 -0700 (PDT)
Message-ID: <a42c41aa-cbaa-463c-ade9-5083930dec64@linaro.org>
Date: Fri, 29 Mar 2024 16:58:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: qcom: qcm6490: Add machine driver for
 qcm6490
To: Mohammad Rafi Shaik <quic_mohs@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, broonie@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, lgirdwood@gmail.com, tiwai@suse.com,
 quic_rohkumar@quicinc.com, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20240327113228.1706975-1-quic_mohs@quicinc.com>
 <20240327113228.1706975-3-quic_mohs@quicinc.com>
 <CAA8EJpqh0emOFUPSj8rPaKr2hZRWwOh9NNTco8fyJCtwXe9sSA@mail.gmail.com>
 <92b449da-1569-40f9-d8c9-48949c986853@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <92b449da-1569-40f9-d8c9-48949c986853@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 16:19, Mohammad Rafi Shaik wrote:
> 
> On 3/27/2024 6:39 PM, Dmitry Baryshkov wrote:
>> On Wed, 27 Mar 2024 at 13:34, Mohammad Rafi Shaik<quic_mohs@quicinc.com>  wrote:
>>> Add machine driver for qcm6490 SoC.
>>>
>>> This initial supports which includes WSA883x Speakers with onboard DMIC
>>> connected to internal LPASS codec via VA macros respectively and also
>>> WCD937x based headset.
>>>
>>> Add compatible for sound card on Qualcomm qcs6490 boards.
>> Granted that qcm6490 is similar to sc7280, is there any reason why you
>> can not use one of the existing sound card drivers? Like sc7280.c or
>> sc8280xp.c?
> 
> The qcs6490/qcm6490 has additional interfaces like MI2S, which requires 
> additional machine driver modification.
> 
> Example : Required new DAPM widget change in machine driver for MI2S 
> interface which is specific to qcs6490/qcm6490.
> 
> So, using new qcm6490 machine driver.
> 
> Will try to use existing sc8280xp.c machine driver.

In that case, if it does not fit into sc8280xp, it looks fine for a new
driver. Maybe just mention this in commit msg.

Best regards,
Krzysztof


