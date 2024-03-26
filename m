Return-Path: <linux-kernel+bounces-119210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7388C5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20E3C1F616A1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E055113C80A;
	Tue, 26 Mar 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNus6lVf"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70913C3D9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711464516; cv=none; b=XQXlGTCxVDbZVI7KHyKASZEN4MEzd3KMPGKoSB6mgtA+ltEp046Rm7ADRzLVyqPnkYzocMqseZ3/I6PW/Jv0mVZV0qOhws9Lg3xTiUrTD4aXBCHI4fs+o+waBKsI4ea8IcTerO8ASoMMqm78cUBbliYSGZx3tJbYZ6D2ADVW0iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711464516; c=relaxed/simple;
	bh=nyOnMNk/fH+jvwDYAQaMxqpFfYbqHXAsFTWb8/syMtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCy2U/TtjP5Rv+26RxCw63nC/KQyhhDwXVmDsDfI92efMrgJcjcW6wK+3cZP9wEXoDtkwwcg6Edh7hgjJBkKogQBFx7SlDqmOCFaH5QAe7lDrk7eBn9c90404lLsqe+/pWZC0gC2KbU0Wv9lpupkscxdstRchpb+pPTC70RFPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNus6lVf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4715991c32so675486266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711464511; x=1712069311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOCj3XrpHETGc+HuQ9wDIhJINMgt8oBfNRGdhrPmFYQ=;
        b=eNus6lVfepjSGyrb1BtBtqvM/DPY4sigiqjLc3Lx9W8Mf2vLRUIqf5IM+y0jaWwRfz
         E4T0Bvd8HweyWt0Jtjorq6NfSAlw7RxxY/h/xpHGkWZthGtcK/wN8S5KQUYrCC1tj5y7
         mLj2fHefrsbxWb+UdJw7qTO1E8c43pp9FV2oe8yIRrf+gbTZyCs2kbgvPf0EtJdGF+aW
         2LRCMQk7ZRTOVpeDZ8YMemazTdVdRxy0ZSI7ExJYC63UwpEEjVgVsRW4plFn9fApl3b6
         UXLepsqLA72U1wxZl1OAVvzzzLvsjdkXphBEHb1zO8appWplaCn/rGtPMTcvtUpFdKRw
         n/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711464511; x=1712069311;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOCj3XrpHETGc+HuQ9wDIhJINMgt8oBfNRGdhrPmFYQ=;
        b=JYdg3SrCvqbJtnnFj0q9wl45qLK5MEHl4r3UiIz7MgpuqRKU8378CTVkdVODmJHs4S
         kqIr4QSM9XX4/TDX6ckbwNG7ja13a3or/HuCW3qJ9VcDKrxWpkoUS5iEoZaXxoGBIWLy
         OEizHUXJGq+6vh2VlGRl9B5Cx0u29DrpenXtlbWEiRHdrtn0Eg7UDaqtWUjD47IxYR5V
         G2w3d56RGnyvstFedADBKPynxTXk0Cm7ss4pcZvMNIYd6+PGKHP42MIulr+cNqhtV9NC
         LbKWtKJ33ulaVcD2G12UElE3o6UDQgs7RlmUXknOAhmcoZzs6/9FHdnnxUx+tGCmDjTo
         36Pw==
X-Forwarded-Encrypted: i=1; AJvYcCUP8p7UWjHVjqEoogI/+5S6IUU8krBUd1ZyVQrp87U9u1s/nO+O0h9/tosb7/M5cKj80hHSVaUc6R6wBl1JsPRvxJ2s5xL0v89TmFwV
X-Gm-Message-State: AOJu0YySDLusGpfrUGCchW9iNcEVvDjdjOqh3sl4WWisM//JN9679LpJ
	Jwq3dMpEOQmr3yX9q9tksABPJXMKjmXF1cH7w4+4j22JhQ+rTAdX9JN3TmjQ9m4=
X-Google-Smtp-Source: AGHT+IEn3F4qFSE2zRXD6YJGP/lgKIuAi+CKEx91s3sQzsBeykwMumuQvgV5xJhAddsJ/SVpuQ7/BQ==
X-Received: by 2002:a17:906:528c:b0:a46:5d40:eb97 with SMTP id c12-20020a170906528c00b00a465d40eb97mr6690728ejm.70.1711464511632;
        Tue, 26 Mar 2024 07:48:31 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a49856ae93asm2547723ejb.198.2024.03.26.07.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 07:48:31 -0700 (PDT)
Message-ID: <454b88d5-885d-4933-ae49-46eaee99d75d@linaro.org>
Date: Tue, 26 Mar 2024 14:48:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80
 chars
Content-Language: en-US
To: Alim Akhtar <alim.akhtar@samsung.com>, peter.griffin@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com
References: <20240326103620.298298-1-tudor.ambarus@linaro.org>
 <CGME20240326103631epcas5p37bc95c57becdeb63b0d8b01ffc6606fb@epcas5p3.samsung.com>
 <20240326103620.298298-4-tudor.ambarus@linaro.org>
 <001801da7f6e$40545650$c0fd02f0$@samsung.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <001801da7f6e$40545650$c0fd02f0$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/24 11:10, Alim Akhtar wrote:
> Hi Tudor

Hi, Alim!
> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Tuesday, March 26, 2024 4:06 PM
>> To: peter.griffin@linaro.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org
>> Cc: alim.akhtar@samsung.com; linux-arm-kernel@lists.infradead.org; linux-
>> samsung-soc@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; andre.draszik@linaro.org;
>> willmcvicker@google.com; kernel-team@android.com; Tudor Ambarus
>> <tudor.ambarus@linaro.org>
>> Subject: [PATCH v2 3/4] arm64: dts: exynos: gs101: join lines close to 80
> chars
>>
>> These lines fit 81 characters, which is pretty close to 80.
>> Join the lines.
>>
> Does this breaks checkpatch flow?

/scripts/checkpatch --strict does not complain
> 
>> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
>> ---
> For better readability, this looks good.
> 
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

Thank you for reviewing the series!

Cheers,
ta

