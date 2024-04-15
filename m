Return-Path: <linux-kernel+bounces-145227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB728A511B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55111C21F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B678C66;
	Mon, 15 Apr 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UJm1CCqc"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C974612CD8E;
	Mon, 15 Apr 2024 13:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186489; cv=none; b=DDkZ97QzISFRyiQzHFsHjdlQvNUibcuoINN5Hgyz5URMEofjFW7d1GxQti4LEFwbRJoFtHUPrK1Qsto2JeV2Ra8ymraDTvtrsJOEPma85y/RQYFQ8Fd6YDoHnaI6FvKidf8d1uJph38PjEtLcEM6byK2Ww3e5nYvqkijWrFjDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186489; c=relaxed/simple;
	bh=87bTwsF4w8g4JFgeI7M+WPF4fLoAHZlVuKCfGMPRLeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOjrKjddTsBte0HkocHcFfgFBNSFrJ8hqpk7Z98zP/bZuJ1g8JZnqk12OuPKygm7UuNFUj/SC72b+eWNtbfD9y6QN/tfpGFoEdeh4uzCttA/nzOLzcDPZ11dm3OuPghD7toB32PDZxDC6yZnLT9IwyBTOvgxn8q9/2mevU/Cxdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UJm1CCqc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so3004088a12.0;
        Mon, 15 Apr 2024 06:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713186483; x=1713791283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EOVcyUHEG9Bub93WbTofMHZOaWndJooQSg5/AUTll90=;
        b=UJm1CCqcR8OL5nAP+WUaZM8LcUEHlUUXgMhxlC7aNsuRO6ba6uhJUUXLEG1AveB/Jg
         Q5xFo2LPpOg+4PMTs/fhJdgISObaL8Ofeu2P6uJvU/8I59t8h9nvDz2vRtRjbJwbhxjE
         SDGA74FHwJ0FbdP9M7+zODxcFviS/EvX+A5YCz1gQEVgr35syiAgTvA27wGcJTbK0Zry
         q2MEm2vMiNW2CWJSV66v6hp3XPWvh0tag2s84p9MNiqR2GLO588L6MEx/dqZ2tL3ZYhs
         GwpzdZL+xAajiJJExYzS423ylJ7zlkQ+D3Px3mntJCchyyFaWFeCKK5aDF5dngKblcaS
         5uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713186483; x=1713791283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EOVcyUHEG9Bub93WbTofMHZOaWndJooQSg5/AUTll90=;
        b=YtnkVniik+lV0z6nuH13a7NgDIcFo9jCJb9CUReIs/u+3UcyBunHoUdg3+IQA+DmLL
         aenHeTlTsXDMGRwCEUIXy1Avh9cFEZ29LcMU/1QMBT0rtyLHUn8x6DkG2fmxCGUEQ2cp
         yg6FS8KjrSAwBl5FbsMCTEN2dRjVjcHGcPQHU43RcxCkxubtl7Hjhh3SuCgAwG12bbL+
         AV43bX4dEhpT8Re/hLPvMVFHvSh7d/yqrk1DXrkrpkFPEbhb1frZliQ9P2+iimQjPBbe
         SVeWVh3/9yzZ/joNflLlyAPeF9zyvqtYa94PPAZLAujk/R2u9NxudSK9dtiZPFLElWDr
         Ey5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVX00zkc/gvMZE7+nM+5DlG5w6z+u8LbEfo8SxC2qxVYAVs/MiQPZEY/pzHUpxOVdN9t1lYANfMmiRySTPVazUqVpf6vy9merU8vxPDsHIoIMnli8Zon9+weHbS/L+dbsH9ehsUgENhxik7YaowIxn0U9fG8SyOLc3kkWIXhE+ta2QVg==
X-Gm-Message-State: AOJu0YxCGlTSByd4ga4bo/8bui98ejLBkxQnzD3qh+zxqLyz6D8/ipD5
	WJfFOFfsJBXzZ2Fdd4PRgwHjJv1rh++raoZUnis76PmR3L6mjEjY
X-Google-Smtp-Source: AGHT+IEnoBtkeYeATaHIBYVqrye4LXM5oKiAeXD3POM03pgS2yfGk+ty1Vt9AFH/3QTv52BE7d7ueQ==
X-Received: by 2002:a17:906:d1c5:b0:a52:5a74:13f4 with SMTP id bs5-20020a170906d1c500b00a525a7413f4mr2496136ejb.12.1713186482697;
        Mon, 15 Apr 2024 06:08:02 -0700 (PDT)
Received: from [172.27.138.193] (c7.campus.utcluj.ro. [193.226.6.226])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170906adca00b00a526fd6362asm922149ejb.117.2024.04.15.06.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 06:08:02 -0700 (PDT)
Message-ID: <105bd25b-e5ea-4649-b9b2-2547e94b103e@gmail.com>
Date: Mon, 15 Apr 2024 16:08:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: adc: ad7192: Add AD7194 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexandru.tachici@analog.com, lars@metafoo.de, jic23@kernel.org,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 lgirdwood@gmail.com, broonie@kernel.org, andy@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
 alisa.roman@analog.com, marcus.folkesson@gmail.com, schnelle@linux.ibm.com,
 liambeguin@gmail.com
References: <20240413151152.165682-1-alisa.roman@analog.com>
 <20240413151152.165682-5-alisa.roman@analog.com>
 <2ad06ea8-220f-4d09-bbe7-c4dd12d0d8bd@linaro.org>
Content-Language: en-US
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <2ad06ea8-220f-4d09-bbe7-c4dd12d0d8bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.04.2024 00:19, Krzysztof Kozlowski wrote:
> On 13/04/2024 17:11, Alisa-Dariana Roman wrote:
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The user can dynamically configure them in the devicetree.
>>
>> Also add an example for AD7194 devicetree.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
>> ---
>>   .../bindings/iio/adc/adi,ad7192.yaml          | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> index ba506af3b73e..855f0a2d7d75 100644
>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml

..

> 
>> +  "^channel@[0-9]+$":
> 
> Why restricting the pattern? If you have 256 channels, how are you going
> to encode it?

Hi Krzysztof,

Thank you for your feedback! I applied the rest, but as for this one 
isn't channel@1 -> channel@256 encoding sufficient?

Kind regards,
Alisa-Dariana Roman



