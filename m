Return-Path: <linux-kernel+bounces-52176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB88494FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626CD1C22C25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBD11184;
	Mon,  5 Feb 2024 08:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m18sBke1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F18210A17
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120180; cv=none; b=g3Q9yBh9upmQfDYL2vLCXSkS08fcWj1siAgkhw62fT13gqxKHPcer2tBd3WPudoOZRfEceAISy+91ySFlNJ9WIPlJQjjvJd/jtYjjQ7YkONe0Z/nXOctDSXjdHayjp2BqYu6JJoXKpcYs7/v1vVmhghvkP98uKpnnJ5ajV5cK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120180; c=relaxed/simple;
	bh=cbNFSMppZlR5QJyM9l0OCAXA/osEHdKoC9o90G7TMco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXcZSgL2PoaNZ5E1BNVdNrcclpvV0I8FhCZZqfyyVAlcgiGzZXmvmBVwHzpiyL+LaOQi2QgcFPu5WgfGSDdE/J1Gylv9iCzGdnnCuV/25Zw33cVGp6m85FkmCcigw/4o4z+FHj8WZLyG1bLTjOaqCme4qt00T/hlE8YsIveK4UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m18sBke1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a358ec50b7cso488957266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707120177; x=1707724977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdtPrBSkrs43J0XyyrvbKbwymC3Nws07mpLX2Y1fpYo=;
        b=m18sBke1oSP9Qzf7AkEzjnu5upqGj112JL9lufzDwa24o2wEpsvIIzxDi5V5veLKxL
         842/Jk+VW4XQK1t8IYuqXIEsfeUN57PZ+45dzC7FWf+DhPbutJSTWqbNRYjpBSik7j5a
         TDt8jZeliYT9QRnjOIwtdipTXV7BYvb1j4pR0laN3ClYZyLYUPPRk8CUGcKMQ0VWYHwV
         R++WY/Hxdknj9c8UAwykbqMOV9SPZC/nqu34n4WcsE0wif0rspQ+M+KYcSFC+R1h4WTn
         3RQVw2pzWtoFveQfexq/mqrACZMf61jb0QMCBEVySZpIoIMqodQcjcVfOQe7aZg890Kl
         QNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707120177; x=1707724977;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bdtPrBSkrs43J0XyyrvbKbwymC3Nws07mpLX2Y1fpYo=;
        b=YylaPS0uheKUOHwfETSHzSBCZd0Agnk3ACJjcOia7A9KUbs9loDXaauFMACEChFqWO
         doTwfDwWkr63yTyx1KM0MfzLq9kFSCBK0MY4xF7VUoudKNAyzCtpNjC4MkTZqVKDEocM
         V+KhaXf+6xaWw1KBoPJDqGx6B/HzHCp527OJDTDnoSBEo8UFiPWfR7jswySLDwLtrmVs
         Se80h+WmFBSiItF3GwwoUhkbDnOKzskzD7k3iV37uMbdOC+561ykZnhpK0Nsn8WziuNj
         Vh7bKdWi/clqwRuE2MJsKP5HiOCfxguk5NbWwKEvzbbwaa4G5CZemaF98oSo5YmqQsu5
         9fyg==
X-Gm-Message-State: AOJu0YzWvq5I7Us4pp60lU8jLmC9I3U4PpOCaiNCrRGGWvlYxf6oxyKo
	o8En1YodLDWUm+KlP8QOUUbfNwxjgjC0ysyq7feAGKvdHIbQLJReh4eyw4h3b4M=
X-Google-Smtp-Source: AGHT+IEQJtZRcY55LAcYm8J5+HEupDsu2xOtRJH90nReDIT3kbNutDrn0EiD33YutzW0AYXvDCqHsw==
X-Received: by 2002:a17:906:415a:b0:a37:aeab:76d0 with SMTP id l26-20020a170906415a00b00a37aeab76d0mr2060474ejk.3.1707120176718;
        Mon, 05 Feb 2024 00:02:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVNvfnS50iL6qkO9emmKM70pOrVTDvWiyDtLMCtE0KsuS2ynCaqB0oXJMhNSbMbtePNY+LcqPifbJdRa0oj3fDpqCIpdWRmvEpDWUerE0jUA05dfNk1LElLxwN7LgqBWt5nMKK2EPtG3nKrX4zk9RtWAR90a+vQSPi2zFdJn5ZMNytGLcryvd3kSyUcEczgyHAqIjnR8SK4AKLh42X38m1sJGABW7bCKYjbWSAnp6xQWr2GCCkYy37166mO3XNQg7E+5aqmeCemZ4OlC3yleAYA89Rp5RYY4gi+N5qb7DkxY3Oa5KNLPhN3oMAnLkodhS3OxtQL4jyvOFhTHiNkzf2XGCEHzwIrwsN1HmwOzIxm65859f5FlZ4=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id kq8-20020a170906abc800b00a30cd599285sm4004822ejb.223.2024.02.05.00.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:02:56 -0800 (PST)
Message-ID: <802c392d-7c3a-4805-ae02-ad12d42fad2c@linaro.org>
Date: Mon, 5 Feb 2024 09:02:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] dt-bindings: arm: qcom: Document QCM8550, QCS8550
 SoC and board
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-2-quic_tengfan@quicinc.com>
 <7e7bc8ba-f349-47f5-b6ba-6594edccaaa8@linaro.org>
 <CAA8EJpq8vvAeHuQYe2cp395m2K7VL46rrhALPySoFpYL5CXLbA@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAA8EJpq8vvAeHuQYe2cp395m2K7VL46rrhALPySoFpYL5CXLbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/02/2024 17:25, Dmitry Baryshkov wrote:
> On Fri, 2 Feb 2024 at 15:34, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 19/01/2024 11:06, Tengfei Fan wrote:
>>> Document QCM8550, QCS8550 SoC and the AIM300 AIoT board bindings.
>>> QCS8550 and QCM8550 processor combines powerful computing, extreme edge
>>> AI processing, Wi-Fi 7, and robust video and graphics for a wide range
>>> of use cases for the Internet of Things (IoT). QCS8550 is a QCS version
>>> for QCM8550. Modem RF only in QCM8550 but not in QCS8550.
>>> AIM300 Series is a highly optimized family of modules designed to
>>> support AIoT applications. The module is mounted onto Qualcomm AIoT
>>> carrier board to support verification, evaluation and development. It
>>> integrates QCS8550 SoC, UFS and PMIC chip etc.
>>> AIM stands for Artificial Intelligence Module. AIoT stands for AI IoT.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> I want to unreview it.
> 
> Well, you asked Tengei to drop this trailer in response to v3. But
> surprisingly got ignored.
> 

Indeed.
https://lore.kernel.org/all/30ecd718-4303-4380-8587-53c6f6b2a9bd@linaro.org/

This is just annoying.

Best regards,
Krzysztof


