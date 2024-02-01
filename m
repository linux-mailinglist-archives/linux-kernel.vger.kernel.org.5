Return-Path: <linux-kernel+bounces-48769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4818460F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F726286005
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5E85278;
	Thu,  1 Feb 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IUJXBgqp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96448564F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 19:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706815801; cv=none; b=fg3MYukJSKzNIXQJIcTRSVNvDd+fYpg+tFGhR8XZ+vkpA78xfRc8nyj/qvV/A5SCLRq5hQJQZ7qe+SRKfOLFZMoF17G4f8ZNN+pDinowsDVNeuGReKlcdy2P/Yk3HKOf2NCnT1vqWXQord5Nwl5GO53pkaSRYKvnU4myrvAc8z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706815801; c=relaxed/simple;
	bh=funz4EuNzUsLBJVqGGzlyWeW+rcJfyhv+OVqOvlVYUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpWeOpKwsVfdG05nna31/4kLDk1BPeplJnIuPHbM8KvNJYToGXbfCG0nub4dImcqwIhCyyj2/ihEUypR1GH/lg5GIugJsIi6PubLhpQlC1Fou07cNrNg0m1vm/qf0f6AAyk4G8Yk+ermoXNjc6ya0eoyzNcH4Lbi/ezZvO/gzgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IUJXBgqp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55fbbfbc0f5so1639745a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 11:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706815797; x=1707420597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A1KyQOp/3y1hWrNiXk9aOAKhGkYsXZw+1Rkvig83Lk=;
        b=IUJXBgqph53zEuMZs14g3cwbXRhUqZtqc0VyB7TAkU2m0esPW2U5008wpBVWNfjqKF
         IoMSIl57XK0yyeZs1+pFiHe/tDll8ud+v3KAw3LGMEAvhyyhSkDdleDWxP8CCnZfC//V
         Eq7tUl9q0VZM7oJRjUfajsdCWocyqe39jKv0/LZkypj1WTMei0V0xRXB1mW9ia5XD+eG
         Px/0dnlSoas/VtjvlZciOzKjLYTEV2ziPx1ByUBvu6uJZXq/g9o+DJiavTfzBqDB77JV
         SedjIVgy0rksgDYN1rida73AVxV8xgInDO8G09qMH/V3EW+DrzzKnKlJbGrNLXIKOWY7
         McYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706815797; x=1707420597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A1KyQOp/3y1hWrNiXk9aOAKhGkYsXZw+1Rkvig83Lk=;
        b=hOeqwrcfYEBd4z37HQ+LtAd1dVrtOdd0j+SFw4C9k9rrZ+yl4WRBwQN+/Q+JYkhEDP
         LnOQuKpjjoe7aaByLywWNqpVHtUTdFAuTuf+tCAaHvRyQI1GE6ANbbP86vwBXgR2AbSB
         SU7aRQjYEPZKoeS8DdGHm0d9QVe2YI+Mx1JQcfT2ia9Am3V4qFHxov4M7Z4br2c0km/3
         pkU7QfY85TuZQpBHNge3Y+/ejiDrliZQwXrrJUg1H5MKbnDo9L5Z56SuN8tAF1rL3twi
         PfsZB74iRAZPxlU96MA4xocCk52u5yEz8KjBGDLHApHl+yB/sioG2hWbsmeEWM6Dd4Oa
         WEeg==
X-Gm-Message-State: AOJu0YzLZaQYwygcJMdRxfi8fhlUxOSGRhv+TNdSDsAq7a/kIiXDeGUS
	FnSRRfAK1VLYld/MAf1n4IY+EGMnxmSlk72+e6tLHfOVSWJD5hYIsBisBiIZQPE=
X-Google-Smtp-Source: AGHT+IHgkdXI0Rde0v5VFshCeRCELi+qZcot2ufALfHfUIIWwebMlQZMK6r0A2nlCYmiuNSnY02MaQ==
X-Received: by 2002:a50:aa92:0:b0:55f:cc6d:29b5 with SMTP id q18-20020a50aa92000000b0055fcc6d29b5mr1466802edc.21.1706815796932;
        Thu, 01 Feb 2024 11:29:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU2crn4p4ZqFoTc95OUY8AeqKz1jCBUw1MfCbqSW8G89pmMQTcdJHHE4XkWy9Ponme4wCA3pO4Vx+Gsrsg4FAwY7PIkFGTG6BWvSWMmMHZzlDkdsCOPsmiELxECDdle2w+9ff9fU2Ah9yr0KytzWrQHyLjwy774kyuSTnDTQz0C2Q/Hs7AUPhgyslD6Jg3p8TmyZ1WY1Mo8oT+DgjEJ6oGjZ9HZr2nhNIGS1aN/fmaU6/4MQopoitOwYhvJr6sXnXAAinUXsv1Hv5E9
Received: from [192.168.159.104] (178235179129.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.129])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e0200b0055eed9cac54sm110982edh.12.2024.02.01.11.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 11:29:56 -0800 (PST)
Message-ID: <00b4cf61-adb9-4db0-8beb-6fc597705901@linaro.org>
Date: Thu, 1 Feb 2024 20:29:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] arm64: dts: qcom: sc8180x-lenovo-flex-5g: Allow
 UFS regulators load/mode setting
Content-Language: en-US
To: Anton Bambura <jenneron@postmarketos.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240130202755.2289952-1-jenneron@postmarketos.org>
 <20240130202755.2289952-6-jenneron@postmarketos.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240130202755.2289952-6-jenneron@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.01.2024 21:27, Anton Bambura wrote:
> The UFS driver expects to be able to set load (and by extension, mode)
> on the supplied regulators. Add the necessary properties to make that
> possible.
> 
> Based on https://lore.kernel.org/r/20231214-topic-sc8180_fixes-v1-6-421904863006@linaro.org
> 
> Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

