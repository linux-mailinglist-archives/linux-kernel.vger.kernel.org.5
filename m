Return-Path: <linux-kernel+bounces-136591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200689D5E6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CBE1C23073
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4BF8004F;
	Tue,  9 Apr 2024 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cUzAzBlW"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE267F7EE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656019; cv=none; b=GT9qCziN74ZP0MvSlbKUAzBbP7KES/5JWgMKB6LAjGscn6thqpVc2ce5JYi5Pe1fjG/QMpB6dPzcaI/n6lTIYeMn72zE+tx2JO/JUJ4JPTE0+P5n7+N5DPQ/xzMozgkwMgwdBI/h4CKxSid1DBFqr3cWmWRJnqOhzwc/l6USqyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656019; c=relaxed/simple;
	bh=h4Ugpl9OHksfpfJDvdTrn3K+DiBJv47pZiz5snVRGdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWon2KjjHmOIkL9qEezaV9rYIb3J73ku5C/l6TDsHCzrXvN/e9TMi2HKHRWsTgNmqs3/JDLXrZElvhT9CbhVCuhTLRyk0W9bNBNk5DRsVpPGer3wlrUiLHmJgHPCPOtEa6wCrxxblCehggSn0SkF0umTgwZFYsITJY/Md+Sdnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cUzAzBlW; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d264d0e4so4220390e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 02:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712656016; x=1713260816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9X+m1NulIHzLqOYNJdjYOA3GaPHU+l9nnEo+uGxO7bk=;
        b=cUzAzBlWQ4RH/cA2XfDUsNFPPgLuik4GCgFNsmjUUqwvZ++6asVYjJSbK8j/jyfyxg
         xgsAkgfr7vwRF7w60nMr0UnHVzHH4VoMy8wRyrxlQqnKCbSGuNeOGLHtC5xaEiKH/Rvy
         L93T00YCqRKVZR/wxv3Sowja8o84aIzd/BvxqhvFEx8ckWZHp+t5DIUhv/8OC0Y5mEA2
         IiaXlXzb1MdO4+QyKK+gKGDFWrBMNZyqcvfTE279tn08PBGY3+++64eWxwmRsvSl6d2q
         60ObRO+pA5Fxp6IPyK8C+ePSwK1uc0rm6+kvZ0c1/djFHiHfCriQnHYoIatePObZkJka
         +mMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656016; x=1713260816;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9X+m1NulIHzLqOYNJdjYOA3GaPHU+l9nnEo+uGxO7bk=;
        b=h5wEV4IawYHFREzZZU+dVJHDoMv1CUb/fekKWEEnuqJy4DNogJQsSPNG0TQQLiUqaG
         qoNvBIetbSMZr2rmZAXz9yMkM9qD7ZllrtSAnMxa8Ap4lut9loWND2FPNBmLJM1Lkdml
         aNOtD8Hy+F1KXm4zlf8NZnV1/2qeRhNOc18CmJOZuQ+r09kKNRGxQuib4oU2mOsuX5vB
         +OrBF3l8Q4nnm/KmY/jwoEvwpj+np+l/zGDyOF3IXXqCZsHvDxPoItDap+0zEOX+SFt7
         YAd5CjLwWqXzc77pfOcyl7Zg3r5GaDKCVBHM7qgCDhD4TFbHisHItfok41BV1Fnt9LBl
         jkIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgyY1eE2oRWP9yxFzZeu2BcBf0KRQ+MZvi7wCxX2jiW8y8RJKsFi9KRf9YHTBVDlC1fPXj+e5zbZot4JQ/D9x10MO/eOYxKf57Mv/z
X-Gm-Message-State: AOJu0YyLRLQKfppA3QcZ8E2YVyOUTUtG8F6s/hlkZ7QAKeWQCI7QFIGs
	t0qi88KZEVFq1vLArU19y+20KjjsBVD5EiXVk4AQ1DW26dOasIDSZi8pr/YyTIs=
X-Google-Smtp-Source: AGHT+IEp4l3/XxmKHxdPDqVh0cgGe6jqbyxyVvpocCmKQG4aTF3bVBuPATCVinYLs2AVBrElIXAcPA==
X-Received: by 2002:a19:f609:0:b0:516:cddf:ef87 with SMTP id x9-20020a19f609000000b00516cddfef87mr718173lfe.1.1712656016381;
        Tue, 09 Apr 2024 02:46:56 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a22-20020a056512201600b00515b216a5basm1482591lfb.304.2024.04.09.02.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 02:46:56 -0700 (PDT)
Message-ID: <17e8d392-f14e-405d-b27d-0f425dc0f5c1@linaro.org>
Date: Tue, 9 Apr 2024 11:46:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: qcom: Add Motorola Moto G 2015 (osprey)
To: Nikita Travkin <nikita@trvn.ru>, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Martijn Braam <martijn@brixit.nl>,
 Stephan Gerhold <stephan@gerhold.net>
References: <20240405-msm8916-moto-init-v1-0-502b58176d34@trvn.ru>
 <20240405-msm8916-moto-init-v1-4-502b58176d34@trvn.ru>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240405-msm8916-moto-init-v1-4-502b58176d34@trvn.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 16:06, Nikita Travkin wrote:
> From: Martijn Braam <martijn@brixit.nl>
> 
> Motorola Moto G 2015 is an msm8916 based smartphone.
> 
> Supported features:
> 
> - eMMC and SD;
> - Buttons;
> - Touchscreen;
> - USB;
> - Fuel Gauge;
> - Sound.
> 
> Signed-off-by: Martijn Braam <martijn@brixit.nl>
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [Nikita: Use common dtsi]
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

