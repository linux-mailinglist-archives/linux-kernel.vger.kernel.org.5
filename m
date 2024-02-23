Return-Path: <linux-kernel+bounces-79104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF78861D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB381C24149
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83A146E66;
	Fri, 23 Feb 2024 20:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rW94okdR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5F143C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720045; cv=none; b=narzbbCAATVdmREWzlFolX4XkxIE8jp3EFgpR0Rl+cwNXpLHtBibnwBde1FTGfAlvlSZDYCtItZ1b45TQkJkZbNjjgN98hrIhFsHj7KfQM8oqXmzjtH1S4lv5nEP4xx44iYIElFK4BpBds8Vec0nIb/72RLra6sBONeEQ3n9i2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720045; c=relaxed/simple;
	bh=3YpEGeuhL8ubJmEesiwCMngORbDqOsSbQu4Bi2PiD98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PYzUYPv5SNBrXq0AmZWc09T1dAMU9eE711dohyszAY1VRdwjxORLW5gRXjuse0If3E73I4Vw4B+YjyBKaytrJ3r+KZCVf40pu1lhxdMEQ3y8DzBHDIy0cfkBkvIALWx2qKfkYOQBvuLIxZLsCedxdDzL0APE0qTi4r2mFY8B0GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rW94okdR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512ea6ce06aso1031998e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708720042; x=1709324842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2Et8H1DtwHnrSyv4ArO1u3yJYDVaQ44clIgnisl2H4=;
        b=rW94okdRQGsBErEYNste9kOAmY7aCUxzrW8Z2UK181ndRUllIa5wku4yth5BPjWJ2J
         1pVLn/04ygPt1Oghi6OusywmhBjnY9bFjr7lDgRxBbBVzP2WGAEwM2Py0EyUv01hI0Fo
         07mWNT2TMewdTS5XExOmMFGS5aWAGSw+D6BOsJmJ8nJDzlNZeclLJEbU+h5SOc+josD7
         v0T/TigHXJzAWFva35MCFb5Fq7IofxwOCAGc5U5FoIfCTbi5OwT/px9Ywhd9kCFnH4JT
         TDomTd1OCKtjoHG1ML/BNkHImfLYtNPcN26X1E2eFO61BZDNqagHjznoOSu1qOw/MOKX
         0JoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708720042; x=1709324842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2Et8H1DtwHnrSyv4ArO1u3yJYDVaQ44clIgnisl2H4=;
        b=SrtpzFMJKv3MiB6eLxNTLBVhWL4YeDswkrFsC+KzKw35rfIK0uVZpEOr6KxFCZ1dvu
         1Mvk0QyopZSbR3c2ljm1aHkmoFYxnFokq+fm7tgGK+OOqS4FVAhfV5Shw0HBv7IyTcoF
         Yiy/K6rmSwPVvOdXpdK+cKKp2gjWoLX0DTfzOj+c2Ut/wWl66KeM36KPmh8UEVRu8/Co
         ol4MuE4TTj9fH5J9w3re9w7h5S64r6lPi7mSEfdQuKz59qJjMC1wtxqd4V7taGL/MMhR
         Jqy21oykwksqG/GS/Sb4nPC6dcDnLI9DGBRR2oOfh4WR+y0q0PQZJKvzsdKycvG+Pjc4
         junQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS+Eg3Q2y5M7QJnPTXX2S2h8KGkXzmoDCqfSXzglC2df2woGOZXIhySNGkW42dIxesI8NRzu40GCSN5aznZQh6aE6jDyGjfJuoqB9I
X-Gm-Message-State: AOJu0Yyo0gegh++g/Qrb2ruVxpWrGKq3+4XZxOTueNA2HuK2Zr8JeXKd
	GgMD+HTGZQTAMF4XM+ZP415xsoTyDAQhg0WqqmUsfMMHKVGtmI2dFPamx+7wusI36FvtilD7vOl
	I
X-Google-Smtp-Source: AGHT+IEkDhFlL5nB07GkTiQuGx05uTfF0HxzH9d74rlmOmpM0jUr/IFa5TPMHf48Y4Z6h4KtKW8I1g==
X-Received: by 2002:a05:6512:3244:b0:512:df93:479c with SMTP id c4-20020a056512324400b00512df93479cmr492390lfr.36.1708720041614;
        Fri, 23 Feb 2024 12:27:21 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a3f04112c0csm3705544ejb.221.2024.02.23.12.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:27:21 -0800 (PST)
Message-ID: <0dac99e5-4ee0-4d55-a344-ae7bd627149e@tuxon.dev>
Date: Fri, 23 Feb 2024 22:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM: dts: microchip: few DT cleanups
Content-Language: en-US
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240218151353.3612621-1-claudiu.beznea@tuxon.dev>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240218151353.3612621-1-claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 18.02.2024 17:13, Claudiu Beznea wrote:
> Hi,
> 
> Series adds minor cleanups for sam9x60 and sama7g5.
> 
> Thank you,
> Claudiu Beznea
> 
> Claudiu Beznea (2):
>   ARM: dts: microchip: sama7g5: align dmas to opening '<'
>   ARM: dts: microchip: sam9x60: align dmas to opening '<'

Applied to at91-dt, thanks!


