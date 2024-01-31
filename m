Return-Path: <linux-kernel+bounces-45940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D99843819
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E06A286A24
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8954FB1;
	Wed, 31 Jan 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKvc3wjV"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3090605DC
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686980; cv=none; b=HiXGZYp6wZbTyGWOyjEQS0RuwRdeuq7vuhVV5bXh9OZOXsHn4G1mEemJy6Rh8NYbIyltS1FTdMJJP5dytx7vVPi2y8VG2DIhW/bzf4pnwu9z2gNeyfbH/+kw3llOV1moCcf9BSlIgZxQ//IPDlx8mGNpveu6Z9dbajdHgYoAVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686980; c=relaxed/simple;
	bh=pKugPOpY04/DiyHgIqo5Kmzs80fKoyhDuxl3Cm5ZjaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OppiVp0dKGeaUwxOaJhZAlWK8qCznNhYY1C3KAFr1M0U+OhcfAB6rT59IgFLQ6CTvF7mRnsqWMyDLclvbID/0GOqZA6yyNpuXYb+Ow0vlmH2xstTYFWj7c8IUYz2mITJrbLzwJusqYsZsc6IPes2PCg6ZpHUSsH2z3lM4KgpaCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UKvc3wjV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a354fc17f24so443781466b.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686976; x=1707291776; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3MsvoJLPDJmzJceztupHh5xHVFDdzmY/ZbgHQRKQzrQ=;
        b=UKvc3wjVod1tLgjHYc2IsqbJEH57XrDxbYasP0h037Ue9SlskYO7GX+MDP65AqEi9B
         +CUzUcimFmyPR01u5ZZDrgCzn8KuJwH/d6H0TLZkYcjK5Io5Aeukt+dLXS1eT1ll1/cC
         U+eruIVzAVlD2EYTodhOxaa9C1oG4w7KsFXM2m6JfDg/5VbzlUgZ4Dt7Qf8cvjVqaHzF
         n5HY7ocW59ZpcWrpv8/x4g2h9Ghq96YIZ69n0W7HcWK4BH1plAq5avQczMKKhciJrYw1
         ZS1FWKXwwVWhnRMYSX2RP6wu3wIFnTey0ekeOYm2w1824SkV1lkCotuGkfvj7J5b11aF
         ZTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686976; x=1707291776;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MsvoJLPDJmzJceztupHh5xHVFDdzmY/ZbgHQRKQzrQ=;
        b=Ge8RA+jg/+8AWsS1FijODAi5jixHcCClbqXpeF1hw3XUpZJW98KtfVlmAkowmXtRZn
         EIENPZXsF30c6m9R1cYPrcq9lsbvOorYC0m9gqtqPBlEVHA88Pn/VPOfCvEILUfR7o2F
         DHz6/36pzY6qABwcaq0Xzxzv1aRVdIE78PdvF0MeIZxyUldVcIQpMlE3ieyWkq/pe0gn
         w+VKiErw5X/Io/rTygh+nmVZ7b73VSmEYyfCUlkEQz6VO0Xrw+24VWuAYd04yBhhB52g
         YqA0/fsP1NYSRgurTmNDWzwMZdgeFaSSzj5pVQFOm4nBwMgR15d5shCz6keRetpk+E5t
         RWfA==
X-Gm-Message-State: AOJu0YzFu09EnQDn8P0Ou24jDgcK3kuhccJ8wtHzkM+rePP+pWv1tiWB
	JIppsbHXf19yonVqP4DnGL8FnCL6lpmUMnYzjYQxG9ffSzvGR4MqhpG3OtZOBCs=
X-Google-Smtp-Source: AGHT+IG+PTdvYYjkkfX3QZLzmIWsLbrwU26k1BtEo61WenPzwml+9eF+0GBr0mrNJCQC6C6bivUJuw==
X-Received: by 2002:a17:906:4c48:b0:a35:d6c0:d2f9 with SMTP id d8-20020a1709064c4800b00a35d6c0d2f9mr518121ejw.14.1706686976278;
        Tue, 30 Jan 2024 23:42:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVjDTGxXnd0wgU3BL1W7lHthECvV7Z/of3IfhI3q8n2r1YoUt82BJKp30aMSSYtFfYY6rqka8orTqY4w3Zoqmqi47cvDW30+s6l9xn+rkdpPpbEm4FwhQN7brN/Y/hAQqgUX6jn83Ieu6zEiafyK5BMW3eHeeiGF8qKIwFTzoZeCjgonp9SstXohf3p4AbVHAWv7DbcPDV0+xHggwNyapeO+65vrB2+GtzCL0oDDgmdhDeAucj3KU0X+bfW+Y0PIdCtQQL9GMcund3pG917uxrnwEgoXMVaXajtgW4lKfN6ZWQgLaAatAnNMe3fATVQKdLjal1mqdIQy9JeuHzsgzzPRM3L/OeVpWUnmbNb3rUyoGsu/Qzmmv+nkZSlV3m9TzoF8yxGtwzugZeUi1bzvxHHLYp+fO8mfWr655Ni/wnjvFxSzQJmVAxxMpLXQDpedQOtW0+KW0n9wpRbw9h2OGfnRwPGuDnQoFg8yRhLn4Shc+kYzivHGWkDXiXbwvbQlPOyxQE/MWrbH7OzuhKNW4rmdPsEVBy3Xs9lVpioE1MC9jduASfrS1Ufy1IUSGPiPGZOcsCakLsn2GGBpL5df/6PEdSG8L770jW4d9oH3XMZnGdDDJCnMY9Pq46CicoN9lBGFalXAe4Lxz27MJ26D0tIhCdbi2mL1mtGxPbIgUfNiFfQ8NpSMqhA7W0v1xshXHApQCqDc5hgikVixuf+eQDt1wMReQlb18u3FpF4jGLJ9rTnS9y9
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id sf5-20020a1709078a8500b00a353bfdd411sm4774695ejc.59.2024.01.30.23.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 23:42:55 -0800 (PST)
Message-ID: <c1e9964b-5edc-46a6-bbd5-fd88aba66605@linaro.org>
Date: Wed, 31 Jan 2024 08:42:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] dt-bindings: arm: qcom,coresight-tpdm: Add
 support for CMB element size
Content-Language: en-US
To: Tao Zhang <quic_taozha@quicinc.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Konrad Dybcio <konradybcio@gmail.com>, Mike Leach <mike.leach@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Tingwei Zhang <quic_tingweiz@quicinc.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Trilok Soni <quic_tsoni@quicinc.com>, Song Chai <quic_songchai@quicinc.com>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-4-git-send-email-quic_taozha@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1706605366-31705-4-git-send-email-quic_taozha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 10:02, Tao Zhang wrote:
> Add property "qcom,cmb-elem-bits" to support CMB(Continuous
> Multi-Bit) element for TPDM. The associated aggregator will read
> this size before it is enabled. CMB element size currently only
> supports 8-bit, 32-bit and 64-bit. Because the existing example
> tpdm "tpdm@684c000" which only supports dsb sub-unit, I introduce
> a new example "tpdm@6c29000" to describe the usage of this new
> property.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../bindings/arm/qcom,coresight-tpdm.yaml     | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


