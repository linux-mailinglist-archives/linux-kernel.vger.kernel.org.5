Return-Path: <linux-kernel+bounces-154856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F27428AE20D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2304B1C218A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574F64CEC;
	Tue, 23 Apr 2024 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ns75qI6h"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9460EC3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867906; cv=none; b=P4HnPROWVv6GeHXjrlxJRYS0NtSjPxiBFbQ/38L4Di+eC7JijPUMMFP+CKRQRz+0fbBe4S5ePUlBYxflYpLJDx9GMkSPQeUF85wTvf7PEz4a1m7dBCgg+7aCf2uI5S7rTwnre3aQ1AvOaOE8Yo2EmlQmOxlV7M6pZOQDlErUWtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867906; c=relaxed/simple;
	bh=aNt5rtIvEm8GCWJ+OS79AptfbLk4tPM74iIMKdvJbcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q94WdwHhQ9PINGSS535txD1s0vnKJchVgj+qscEad6U5BI84PDCBddHvaU1KrxSjx9BPbA/jJamkOS2w5rohYzNlvDCGOeHVLaMGWNtkwWoKKfBGhHb7ddsQUuFCIipl1tXAZlYbHagDYH6OJtfHjbi5ZYUi0fV4FHhkAaHu7Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ns75qI6h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-34665dd7744so4131212f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 03:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713867903; x=1714472703; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UXV5A6S7Rshm2OvYc4yov8BE42HwuLP4N9TBL1mE9o4=;
        b=Ns75qI6hjILQ74fAKl5z9uYcdxUeMe4JoNhQfvC2mECiKHFnx+N18NgP+f1BxsFao0
         czBdEpjmRcUQLECo7TvpyNMeuwDHz31IMfNN5VDaaxuzobizaKsiFxC7Vji9mR+TE0Y2
         ydUgP1C/PpV22fuOVFMqGhr71EpJBllySmLD9mb0GUfa3xu3ltGi/Zifq844L6RlN4f4
         vUxdJgyvwRlyz4a/j7yPewpwdhLtN989erCdoVN2LvNDPI7ZKHYFbgSV/sx0CpajHPor
         V01X8oypG4H40WHPa2neXZzYW3zlZfFrI/JA87aWV/soq/awai+GeJEg2b3VDFl/nC81
         LK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867903; x=1714472703;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXV5A6S7Rshm2OvYc4yov8BE42HwuLP4N9TBL1mE9o4=;
        b=pRwDNLeeW09O9ZcZR1OdnR+w5jAQzuzUOyzUrXLSHRrMM+ZV1UKz6UF9hvqA2tMGEn
         xoiix+BdHEvh0D3UP3UO3mGrhE0p/camYO0ZuEEM3tVFR4dTOOa+KnUzHVOx1e2liAIf
         mOLPHNr7NTVmV+fo/ZAULkb+F7wgIob6QzUYqGkEA1Kk5frO5sgxVvv7sO2iRpE+6sOs
         dVVpxmBK/aAVDcTzqjo26x+YG0jAvoNwGXAjT398QVQ7MbxQziAw9Icxrw6tbH7tcaHq
         H+6G4i3oDa8jPsKRiyyi/0g1NBuwWTAqzeHKF4o65hXNVNZQ/nY+oI5ovmhdCo418s9M
         y75w==
X-Forwarded-Encrypted: i=1; AJvYcCV49PXOjSqQGKzzkJd0oHQA8VuZUHM4hWrmLYH8diEAz10o0kxiO6AAhlgWfOi6NwDq+jKKNON1v3hDbqy6ZVixmUSfS3HEB4lzJt+8
X-Gm-Message-State: AOJu0YyNaVyYNcvzOztd4DgsD1qC5MH26ZYNogwTdQ01c7W3mqZ33xoy
	Jrx8TZtDvJ0fZj64Vdeyt+58nKOR5Tj/iHJERpkao479kwGl7OQboWpkztyvUkQ=
X-Google-Smtp-Source: AGHT+IEZCv0aDOdAXWrQ7tOPTriI5duVdeDIoyKsV4MAGgCKJ/Oa7Jt8U6f4iLMYPvBCyMY6lXzaEg==
X-Received: by 2002:a05:6000:a8c:b0:349:9b7f:8df3 with SMTP id dh12-20020a0560000a8c00b003499b7f8df3mr8378545wrb.40.1713867903508;
        Tue, 23 Apr 2024 03:25:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f8-20020adff8c8000000b0033e7b05edf3sm14152618wrq.44.2024.04.23.03.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 03:25:02 -0700 (PDT)
Message-ID: <3f891794-0083-4245-bad7-518b1c48bb7c@linaro.org>
Date: Tue, 23 Apr 2024 12:25:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/9] spi: cadence-qspi: add Mobileye EyeQ5
 support
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20240410-cdns-qspi-mbly-v3-0-7b7053449cf7@bootlin.com>
 <171283699002.32012.7629247540689477794.b4-ty@kernel.org>
 <D0QT350IJHFH.36EXE1UT9QM10@bootlin.com>
 <ZidAefc0Ejrklopf@finisterre.sirena.org.uk>
 <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <D0RF1AKWAEAE.44N64GHMV2ZY@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 12:04, Théo Lebrun wrote:
> Hello,
> 
> On Tue Apr 23, 2024 at 7:00 AM CEST, Mark Brown wrote:
>> On Mon, Apr 22, 2024 at 06:52:47PM +0200, Théo Lebrun wrote:
>>> All commits tagged "(no commit info)" do not show up in your for-next
>>> branch. Is that expected and is there anything I can do? There was one
>>> pending -Wunused-variable compiler warning to be addressed for
>>> example, see [0].
>>
>> Please submit any patches you'd like to see included.  If there were
>> outstanding issues that need fixing then fixing those prior to
>> submitting would be sensible.
> 
> Seeing "Applied" followed by a list of commits, with some of those not
> being applied confused me.

That's a standard output of b4 and maybe also Patchwork, if some parts
are applied.

Best regards,
Krzysztof


