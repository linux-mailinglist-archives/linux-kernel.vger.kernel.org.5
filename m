Return-Path: <linux-kernel+bounces-128174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FED895731
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD8E1F257AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A67A134406;
	Tue,  2 Apr 2024 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="msvQz2Od"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458712C530
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068804; cv=none; b=I4pQa9FyZv70OkeMPpElgdZDDtU9hWUYXeBoJxPUlCHI2HMN3a5OkykC/QzeSFgaKw+K6w0rmnmteowTfbO2rvoHVdXq2zEK1BWQmb+U7eXGSggRKVDJCe13U2WWasJN5JqJAqSZCfs0WjxA77C4UYIKAZ2EgwJ2BxFaKXBZ3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068804; c=relaxed/simple;
	bh=kO4N9ES/3iW+oA9a7S/ehIdGXLL7lsm3WYa3F+Au2x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtFj9zz+gRYr0qmkjyDYvKHfqW+B4h+zaDPpAFkqChTdD0SVQUwyB3GeSAQsvtil+qU/xfvsZM6tnRVapggJhTTne+LiG7zNeZWIToiQNTaGx6T4areGhGWeCZ+NkTetXqSIFn1iMjpQzKvrJALaJaIn/WA2lmUjkmchCezT7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=msvQz2Od; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4a393b699fso794910566b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 07:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712068801; x=1712673601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ffj4VWLTtk/LKnMfoL3JP09U0iuj4ba7SalXKikuUZg=;
        b=msvQz2OdFRhhbMMAhZSGvBo8IGPc5YwJZGHN8gy0ihyV4kQ4G/tXctAlbsjB5JAo9l
         L+jYQwfauUosL6c8P2SOXhO5MXwTZ9MXK/sTdWEiLphG+aGslueBSLYz4bmylr4gN+SX
         /77qaxAX661AiTBFLXnC5FMpzOzRJkLQylvbZ/NuxNNCuKBLISjTRXjTplM6YrXF1iUl
         EcRJJM3AqT4kgRnsG2cC65XBQsKsdNw+MmNGVy7Nff44gYNPmABBBbEEyim9pTrog1Iz
         +shBzKBOore58bTsIVtWV2uvYf5ROQsst8YTrz5LMiu+EkwTIuoghQOz9+BbGlSeVKDB
         eWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068801; x=1712673601;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffj4VWLTtk/LKnMfoL3JP09U0iuj4ba7SalXKikuUZg=;
        b=JYuC52HnpHonGg8zYzZHo6qJ31etPmYDgEdnOynPZ+pA3R3A9pKl/rXJEBhh8mASvr
         nmKjfAMsMtxXGrJdxU4TXX28K8RxsRt5TjBuoINKM/JNc1lHxm0f5qtBeiplUDz7X1eY
         Xg1aBS6s7BuIyoofUeJwH07aW/xrBCib1zVmHH9cMqhvde0oc4C6OYUPmTQjYwerHWVi
         0MrArN+8r6WnzUlLnj6eDv+ytyfRGo7Lm6Ozau5VGApHKVCgEvwwJ8bk7hzLIn4z3wRp
         0DifAGWLBxTCWa09fLTOSJgBgleYzSZQ30ilprJd1nXyK6BOsUecw17SpV+qeT2LYEUS
         +nog==
X-Forwarded-Encrypted: i=1; AJvYcCWffudqLbHsHiW57G9SDiJQQY9d6Msg2R1tAXrdi10Ox6FIfDZfcBDiSSAn4jWefdw8WTwZabyfwaI57lstluZ8pGAfsbu2Z3FCcmTN
X-Gm-Message-State: AOJu0YwcTP5r+0DBLFamfwJI5LDob/K4SrCuexBJe7ip/wKQq7gNLO2i
	9E9DonsAuz98EjqM3YVt23dXadZH4KN1E+PZLXQqRTAtfh0GvVTa0PyKarMhqFc=
X-Google-Smtp-Source: AGHT+IFjdh9nR2dmxOko0rIW2ozqY4pUkDKytWOIcf7+AouDBg4VA0CL4SNolMmokuZvFcX82K6/+A==
X-Received: by 2002:a17:906:1254:b0:a4d:f673:7f30 with SMTP id u20-20020a170906125400b00a4df6737f30mr10903063eja.11.1712068801129;
        Tue, 02 Apr 2024 07:40:01 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id an19-20020a17090656d300b00a4e58c74c9fsm3592413ejc.6.2024.04.02.07.39.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 07:40:00 -0700 (PDT)
Message-ID: <5fec8789-b970-466f-b319-23fb837cd1bb@linaro.org>
Date: Tue, 2 Apr 2024 16:39:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] arm64: dts: qcom: sc8180x: describe USB signals
 properly
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20240401-typec-fix-sm8250-v3-0-604dce3ad103@linaro.org>
 <20240401-typec-fix-sm8250-v3-6-604dce3ad103@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240401-typec-fix-sm8250-v3-6-604dce3ad103@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1.04.2024 10:33 PM, Dmitry Baryshkov wrote:
> Follow example of other platforms. Rename HS graph nodes to contain
> 'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

