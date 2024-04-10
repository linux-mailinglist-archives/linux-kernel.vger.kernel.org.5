Return-Path: <linux-kernel+bounces-139175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC6C89FF85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509BE1C22F3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F141802A6;
	Wed, 10 Apr 2024 18:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EADTuXU9"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B0317BB07
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 18:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772904; cv=none; b=lfQhBGIY9tBAiswA5wo2ieg84/P+c8Gsrg/BO2I6N0atRi+wxoTI4FdYL1N2U1FAnAtWfvZHAine4jLcLMHX3Wsa8soZGcLVpbOGcnfVx6irGwR430Yydky/WARJ3xGzJDlARaSttrFO/mgLSsBix2YetNL6/ds/UybNzRygff8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772904; c=relaxed/simple;
	bh=bgxBc5QL1EgrGNz1Nh0tisNL2vyofmodpiuIjwYsJhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9pgQ+hmvnenA0SvKI+0UgaEzXnrRGQ0vC3QshxKD0JONh55y9vMDvn/k7djGF1YjK5rOWausIRBsMk8eCADKiClEgOpuSPS0AqshBr4NLh3aFkb6ODHqjHiCF+n4bUrGSHeUxG7cBTLi6MW7B7W1SWIIev70BXn84ydgGlJOzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EADTuXU9; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d0162fa1so8457587e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712772901; x=1713377701; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5mElfgPubZ0c/8Pokd0nDZ//CRbTWxbvbOos9Zm32WI=;
        b=EADTuXU9LCDxn80s/DTc32NwUDCtZPjHalHbwK4eOl5wJ2EFUXfft/8N3VgxHT61af
         aI0xio9ys+iFOQUOueg6NiwHaYpw4JUm220DdLshcKOHY3kNTuOqJPLX5LhLJEMWN/Mu
         BfAcez8NFHX/sySDEj3ZcIoS1BKFBfYBsvNmcZF7qOfsTWlNQtgGRCWx+rdi/NwYe1dw
         nWy50PxeijJLym5pMECb1WQYo4TfV0+mJEbv0pfiZzNf0C4iW0n6VUUjuHDgLYN6fc/i
         tAUlV7HJTBx3RcwAUNBKUYdedghRGDr4u+5FVDpWkEZNWdmF0lvH8SlyLRgOBIC0XI8+
         AP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712772901; x=1713377701;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mElfgPubZ0c/8Pokd0nDZ//CRbTWxbvbOos9Zm32WI=;
        b=GwnOhke2nuCIebLr9sgAdE+OCC6v+EhXrHaM0VI7NWY4jsVgYm5md3rzkAi0vX+7kR
         a8tD/Ut7rRIUEsqffwPImwdyAQfeWeVuH3aXs/rG3UTN2D09sAx/FMf9NNpwet/OARfC
         g+x7h6p86mr9JtgbqOn5RJGdIrclLqUohwHZwGKfqOis0rfA3x+NV7kaSxO3WFkdml5F
         yYqmNps5SE+06exdpzQZOJAPdxm5oKEjH5dQZkz5x7fZFHUww0bThT7U07a6y9KzhXpq
         F/+9b0l9jv4RS9/uG24Gi/8Co7nRtkQ2s0na4IsPYF/1+xupIGinCqwNV3P728xQYp9Z
         dIhg==
X-Forwarded-Encrypted: i=1; AJvYcCVfAv8rN1be89JqiSDyP7L00ZmbXylg1jchKv799d2q9R1iJfLBHDAnOC53R+VresW5Uuc1bNRsIxXkmxVGBD6KwGG5BIqJiJ40nf2/
X-Gm-Message-State: AOJu0YxlTEzezD/ytIh8QHMBESVWcMPMlkK/f81iggjJodzJHY8tpVJF
	7ZO2jE8bubxyrn6eMMRyzWTHIKvHRVX8BqztqK689Bi8fQlwaKO7YHRqB+Gn/xA=
X-Google-Smtp-Source: AGHT+IEx+N42sULyWh0hFoGahD+v4vOuxraHP+O8zMLn+GdI27fRh0rSrMwRe1q9w/Amti/YHcM56w==
X-Received: by 2002:ac2:4289:0:b0:513:cf5e:f2ad with SMTP id m9-20020ac24289000000b00513cf5ef2admr2477386lfh.60.1712772900853;
        Wed, 10 Apr 2024 11:15:00 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b00515ce9f4a2bsm1912642lfc.35.2024.04.10.11.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 11:15:00 -0700 (PDT)
Message-ID: <3b457615-533d-40b6-a637-770eb9af8956@linaro.org>
Date: Wed, 10 Apr 2024 20:14:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: pmi8950: add pwm node
To: Gianluca Boiano <morf3089@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
 <20240402-pmi8950-pwm-support-v1-2-1a66899eeeb3@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240402-pmi8950-pwm-support-v1-2-1a66899eeeb3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/2/24 14:35, Gianluca Boiano wrote:
> This node is actually found on some msm8953 devices (xiaomi-mido) and
> allows irled enablement
> 
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

