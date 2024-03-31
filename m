Return-Path: <linux-kernel+bounces-126038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB3893143
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14552820F5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611E143C77;
	Sun, 31 Mar 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J866AfAt"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FA476F1D
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711882219; cv=none; b=UhSMfF7Pau8zgM/Q/vYVHpcvL3IxaLuaX7Mz/p/lp/48i90wlnVk3W3FoY1E4+RRI8xh0iCPOFSBAt/TD801xofCNwTf1BtqrQoFZRkZx2DIH5hDivNZxEZGI/+pohkvvaJotrZkfyEgVTlgzK7j5CdHwMCJdRrtca7kGm1zGLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711882219; c=relaxed/simple;
	bh=n52/TaY7VCE+/UjSpoZvuW/A5WwyBho/pE3jBvoUxD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vd7QDEH/oyEXEsjZOpsz8kU8xW8LTZhlTfTdT9UPCU9MXxaDw3CTELso0bA1YXMSc+O1TlirY7VQNYAL449zUWzV1eB+GXXRuFLXBll/waORIQJN4OD1cAyjNvq+d+iOMxICTbnEYNf2YhpphzGdqLVg8gglRqIq1Ot6VtV5r4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J866AfAt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-341ccef5058so2429237f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 03:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711882216; x=1712487016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Iw8cYxFNoNw77A6XLeJUnmwJS3BqDiKpqdroebaYF84=;
        b=J866AfAto/16CL8bJxb5vTS0gULBUz5C5WGu1rPcDdB1lNvjSb1AKQtB/22kUEbEUU
         GuvBSy0qaiwhkAs29MdEgcDY8dUzS0w7lnnv3McOmSdIMOP+CC2umo9NAjtDrcKzuTEv
         0F1JenKkgvtZYe1nURM/Ez1ROipI+/LB+OYpoXP39Imn3NoD1zN9bBhwiElrN3MWg6Vp
         lBFsXqM2jQhCIOCvADmRMhgWGb1KJZLhwFHcTW1DgfjPzpEg7MHs3nCTRPp2BF9hifwo
         zfcQtMJBCigKB5RRLjNpMYpnKGLUU4o8D90Zq5q6WhN96l2gHeMhjN+IfjVXOuk7z5wM
         rRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711882216; x=1712487016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iw8cYxFNoNw77A6XLeJUnmwJS3BqDiKpqdroebaYF84=;
        b=u/5D1vIx4FTahar+mtjcDQutTs+m8aGBZwyIGFzfdQVStigfN2FCRm/opNVIK6q1RI
         ClSYaktz12e23f2gBkMOOu3/FuDTmMPMRN4j+Uzp3QZMAoQvoNMm7f1ZKQySRoDJfz8Y
         vkT6tph2jp3nT9ih8oDcd8Ah3o2ppMUmq8oE8WDeGQsnW852HOTh82KrY7nlSuaH92Hc
         vWIN8QmGaHV9114A32CzTqu4w1BpebgEo9UvXUOySuiuvDaxsw/m74lCJcahOx8cPIjV
         v5XX2obBlrodQrhOSizPzs9RkkLDCwV0sD2wgKRYZ4o1FqgQveVlbnW2DetWJJsZz2Wb
         DNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPtt7sOIUYqPIPD55byVBs17S9XEmxDJhSdRDEjx9Kxw0tcrw1zxhg9OjSzDP3ilVlSksY9WUIyNZiHSA6QfWa4fHfreSJQPeUq2LU
X-Gm-Message-State: AOJu0Yx7dFd9+YaMwTwjmtalYNXUkoaon2LlmT3J/EiJg+l1UD4u0wGm
	hCz2xYVDwUbxtGuOZjgFCEy9m2XG3miQZboRmbc3g0d0d1EosE+xERRgFarso00=
X-Google-Smtp-Source: AGHT+IGUUgr6cBEnD2tCmXSr4pwM67vErUoxFoA+3T6ptqYl/6tb8BTV9jUL9ZHzS76Rs6JqQBzW8w==
X-Received: by 2002:a5d:5f49:0:b0:341:a63a:d253 with SMTP id cm9-20020a5d5f49000000b00341a63ad253mr4914259wrb.53.1711882216232;
        Sun, 31 Mar 2024 03:50:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id b14-20020adff90e000000b0033e745b8bcfsm8629606wrr.88.2024.03.31.03.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 03:50:15 -0700 (PDT)
Message-ID: <2d938d7d-74a3-43af-9de3-c8f584826d32@linaro.org>
Date: Sun, 31 Mar 2024 12:50:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] spi: cadence: Add Marvell IP modification changes
To: Witold Sadowski <wsadowski@marvell.com>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Cc: broonie@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, pthombar@cadence.com
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-3-wsadowski@marvell.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329194849.25554-3-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 20:48, Witold Sadowski wrote:
> Add support for Marvell IP modification - clock divider,
> and PHY config, and IRQ clearing.
> Clock divider block is build into Cadence XSPI controller
> and is connected directly to 800MHz clock.
> As PHY config is not set directly in IP block, driver can
> load custom PHY configuration values.
> To correctly clear interrupt in Marvell implementation
> MSI-X must be cleared too.
> 
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> ---
>  drivers/spi/spi-cadence-xspi.c | 311 ++++++++++++++++++++++++++++++++-

You already sent this patchset, so this is not v1. Please version your
patches correctly. b4 does it automatically.

You also received last time feedback which it seems you just ignored.
You did not respond to any of the feedback and I do not see it being
addressed here.

That's not how collaboration in upstream projects work. Don't just
ignore reviews you receive. Please carefully read:

https://elixir.bootlin.com/linux/v6.9-rc1/source/Documentation/process/submitting-patches.rst

There is also entire section about this particular issue - responding to
reviewers.

Best regards,
Krzysztof


