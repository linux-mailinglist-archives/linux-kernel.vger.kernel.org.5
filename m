Return-Path: <linux-kernel+bounces-99273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5618785C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D061F2164D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E443D482E1;
	Mon, 11 Mar 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yzrZlCSo"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5A29CEC
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710175913; cv=none; b=iag4q9sqHk+3aARCCX3NcnwbRPr3A7s89kjKWxTj36IS49cyFoRZAT0VLg2JCBLGwf9edFhItmBr5yzghWF6XGDAA45rTj4R0qSyqbuFRfdiRmPYlaZtgMisHAHQT2L6tFuD2SjUyg9uxQunTOWdG/tC9bVXl4sFoSfU/mcTkrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710175913; c=relaxed/simple;
	bh=49+y5m27RCyoe17U51EUDKNyW02zM8Mw20eyErOpJuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHCqq9uBUKpQatdjgSn3rIoj3JNgXIP4xMHi5QW/pNyIXYPsC84JOPiwKKlaRJwxjVTHuRb2ZOu0B8IMQov//10upCuztaA6o0nJpV2tvZCh3QzraCKB/Gehj5Vja/zfnbsJNibXXRqOIvasffVxlSyk9xP/vHceEPL+Swc1Ees=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yzrZlCSo; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2466373f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710175909; x=1710780709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nGWDMH2x60hyneCb1kUzCFV/BMduGXXDP6atWi4xtk=;
        b=yzrZlCSooC7Oq9FuIHZbeOjbIUf49QSMTEr6LtyYiaAoat8lX7D/SG1zmYEYJ6Kfmc
         rrwkL8Hg1b9Z2LZ//hEWgHwcUPoWQQZ9MswV5ETrzpyrYR+ZQcR53b07gfUIOmfiFAz8
         Mwxj3jJpyHG+/UrjovwRnFKfKpaY0d8iBMlI2V4UU5y0UBwJdRHj2ibwun1aQq10LsQJ
         u2anIJI33amo8+GUQKsr5IwNKNZvtA2XARlJrva9LeLDZe1w2v7vk/sx8nc7G4hz/Oer
         A0tYPcvgpNbLpxGW088T0BO/gCVt/EBhDbIcVRZYKOUGaE2Ha91poCJ75J3iKNc4rT0c
         ZcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710175909; x=1710780709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nGWDMH2x60hyneCb1kUzCFV/BMduGXXDP6atWi4xtk=;
        b=SJw/I4E1UW0Z00CQuKt9y9X4ExlazCo2icLWzvuj9AEfNAY0eemh50U3lz/f4QZBqM
         99o4g6lDqYut7HcFApzowdPuyOxw3VaV4KYdQh/WMBneHm7+zzuyNWubJsqPQ1m2nc5r
         esO5p4Z/YXxalc7u9atTrZmWehfaCE1rPLl+YR+IeHCU+igTM1JFq4H+fMSKgCU5q+E9
         roj3UcEXetYuOmuDlM4P/P6r2g6E6DF8cxc/fXYO3EPWaDqirv3J2uLFNpiVrQV84Vb6
         aiOz2QuZT6rN4FWXMInbx9IeIULHT10oAinHvmDQWmXicDdeSOX/KHMjKY5MzbDStGH2
         bZ0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaD4SOoAvpbsR1A5pjGd++Gx4H9xonYLltLm6BInL51CvpUKJk1S8pVzuBdulDaShEtPXqWSdfLqkx7Hh4SbIpViGGcb1sCh9af394
X-Gm-Message-State: AOJu0YwK9/xDqzPL1dOgByPYjVbCld6KV/NEUruJ+sg3JpyPyM6el3Pp
	GhhPnk2FHNvBjMC/XCZoRu06aoRdOjtymKLBFpNvL7g/QGKOUsiqItpBYppulmw=
X-Google-Smtp-Source: AGHT+IHiN5Vb61E2Quzybogt6ckjwMxdNBVzC7lBYP+qYZnHtJqlHOemainzAurkywqLvJBtxuWpkg==
X-Received: by 2002:adf:e387:0:b0:33e:6833:8fa9 with SMTP id e7-20020adfe387000000b0033e68338fa9mr5947972wrm.44.1710175909141;
        Mon, 11 Mar 2024 09:51:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d6985000000b0033d6c928a95sm6895225wru.63.2024.03.11.09.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:51:48 -0700 (PDT)
Message-ID: <630b89a0-17c0-4706-8773-0fd1917997d7@linaro.org>
Date: Mon, 11 Mar 2024 17:51:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: clock: qcom: Fix x1e80100 camcc
 power-domain declaration
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Abel Vesa <abel.vesa@linaro.org>, Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240311-linux-next-camcc-fixes-v1-0-d126ae0b9350@linaro.org>
 <20240311-linux-next-camcc-fixes-v1-1-d126ae0b9350@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240311-linux-next-camcc-fixes-v1-1-d126ae0b9350@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 01:33, Bryan O'Donoghue wrote:
> camcc on x1e80100 requires two power domains MXC and MMCX. Define those as
> part of the schema.
> 

..

>  
>    required-opps:
>      maxItems: 1
> @@ -56,6 +52,35 @@ required:
>    - power-domains
>    - required-opps
>  
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sc8280xp-camcc
> +              - qcom,sm8450-camcc
> +              - qcom,sm8550-camcc
> +    then:
> +      properties:
> +        power-domains:
> +          description:
> +            A phandle and PM domain specifier for the MMCX power domain.

This does not narrow the number of items. You need items with
description, just like you have for x1e. And drop redundant parts. This
is just "MMCX power domain"

> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,x1e80100-camcc
> +    then:
> +      properties:
> +        power-domains:
> +          items:
> +            - description: A phandle and PM domain specifier for the MXC power domain.

Drop redundant parts of description:
MXC power domain

> +            - description: A phandle and PM domain specifier for the MMCX power domain.

MMCX power domain


Best regards,
Krzysztof


