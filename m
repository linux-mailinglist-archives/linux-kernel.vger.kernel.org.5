Return-Path: <linux-kernel+bounces-56089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427DD84C5D0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C015028470E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7A200AA;
	Wed,  7 Feb 2024 07:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZ8kCEd/"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395B1F944
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707292249; cv=none; b=e32N5mY+AzDmNrWphI1GVQ47whmD7E9qRDektCy//jX9O5Fg2JECok9yyfI+nnijKGgzo0UtKrHtX03cWjyqY7Yk4fOgDxJ9FfT1jOmPabq2iOXO2RZxN0Noz1a74kAJX4DuxGkrtZvz5UtECCO/BU627uNl48K00ZYCPcxwOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707292249; c=relaxed/simple;
	bh=x6KK4QkYkvOMVOs+K9M5jbzCwzwUWoBLH+sdqse1qIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrdcnqznR83tzrl5m3ewp5xW4BTD8l7lzZyQrLlpcZgNRy2J50YcOCDVoAuhbWljXXdZBXKTIVN6XpC05oOOTr8fYvyg9nERhuaDFrKTvIpiGi4J4KtF+6iWOIHW8iaO0CUSeLOPJeVFkT6Z84E5Ox6AIGi+qRQ3Q6LkrNqiO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZ8kCEd/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40fe03cd1caso2706105e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 23:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707292246; x=1707897046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scNYwzkSMzUIHctQWnXz0s40s03gWg3TFT3mJcCh9eI=;
        b=NZ8kCEd/iGHTaYgEf0bzEA/g6Bek27mXsPlIunNPpn74eu13iRxiUZONH1DRlLLw2L
         DXqOXjm09/7jIq1FZPO9OD6XLF0nTUB8dY68EHlMSa2TlOvogrnSWeaIexlRIqVdU6Ex
         LW7n81sZ2WbfsNwtPqUQvEUZ6SkAZQ00yda+xoUAAdD+sFVpTUls/V/Eua7icPIHrhCW
         GDQ3YDbtVRVFEhh/MuJpuM2LNJGK4zi/NO8w8TY6KTAWlUxgmX0M1HNxjosZAeTNIyqv
         8FDwLR+wZx3WwuifvIipbJyg8vNUf7EclqlgfsyKJUpJpXUOtTiTcMcT2lo9MTdChgJF
         aYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707292246; x=1707897046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scNYwzkSMzUIHctQWnXz0s40s03gWg3TFT3mJcCh9eI=;
        b=vTLqZ2tmFAROhQ38izlHxs+jXh7UaxbE/PRElADN/z7dZM35Yq04SSIMzKA7DcTamn
         gaa3sEnwY8EoJOrpWcrN2ezEBFutXy1aCv60V0C/DOpj/GkMneLQK1C1r7dAoSi9DC/n
         LaPyBTgQJZZPnwGQXRnOFSgZ0zeWJbKCk/HiCxy8tar7F3NJQYQD3qrOlI/bId8rFkDR
         WeErnpT6+78X9kuIWsdgo6bSH0QnxSd2WNeLz0CwBtkv2IffT1P1U/PQdvanb/GoGhcj
         uC8YhsOsYP1LYOAeQs/6rArbjRdtoIhPgjqm73uQwm+Xi9KNw45VJtbKwbE1f5Wkm8Vx
         3DJg==
X-Gm-Message-State: AOJu0Yz8vMzWUE/9JF5E5vkL0w1sLLiY/FGkGsMlzgnDK3fNHE8iDtsc
	s0Su5a0OvJUzMMNyKAMUIpakcV6U0EZFgnc2+Lyp92Czw/UsfBusGZT9X3xbfGk=
X-Google-Smtp-Source: AGHT+IHkIUmnUS1dfTW3vihBIy/8Rg4FAmON6JUFab2FY6bsdC0+Skiqilc1+aV+2gg2LKagT7r+Jg==
X-Received: by 2002:a05:600c:1e0c:b0:40f:dd70:14a with SMTP id ay12-20020a05600c1e0c00b0040fdd70014amr3813150wmb.39.1707292246036;
        Tue, 06 Feb 2024 23:50:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqfJdUqb20V2kpe4MzbFFbYrCiUCYPfWkYVQD1qlm7dH/iyjUKEiDJWHnYhdp/SzM3W6FQLiMut7LaQ34z2CfrSmlgwd8JyuudJSOm9WqVT/j1qusCL8uZwWrzj3m9sqrYkt8OVMxiy2wloiP2zrMl4pdMH+9QO0/YcXDg0aWw/E3VUR5gKbq8Q9jyQJpqoxpdThYB1B2Q3TNgulhQBJrQliIiP85sUBkLrzbL/ukZXmh3bpzOJHUcV2UrolsvtCNwPJioCxzy0LcUzz37lGKcQMl9yncRPGK9osUw5Xh1QDAfmmDlCUEOMwTp6fRQQbgIFFLoP1ykZrV44tnsOIHI/tQ1ZxfoekpU++Cr4QhGSMyk5cfVBVhcd3swOzIanR5U+0zLg/ikVJuglNZNkTGJ4/azflVjO+UG166+2VA1g2CekCcJkdUh6ni/eohkY/oOfEjs2gQyAfeHwi2ayEQIoZqYdlx8a1DAd8yioC3XJD1Pc/2SNorrSXLIA+nfyMjlImfrlXQ3mjwjvlcRJC4k747dOgz3Q7dmQbi4/TNd6jUfDm1Cl2Tsf0d7
Received: from [192.168.0.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l31-20020a05600c1d1f00b0040e3635ca65sm4354788wms.2.2024.02.06.23.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 23:50:45 -0800 (PST)
Message-ID: <1249bfa8-2a40-449a-897c-a862d3a8e65a@linaro.org>
Date: Wed, 7 Feb 2024 07:50:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] spi: s3c64xx: add support for google,gs101-spi
Content-Language: en-US
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com,
 willmcvicker@google.com, robh+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <CAPLW+4kPib_3MJeGL3bHT__rLoJOS=GS+gNZUbZ0dpyey9E-Hg@mail.gmail.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4kPib_3MJeGL3bHT__rLoJOS=GS+gNZUbZ0dpyey9E-Hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/6/24 18:59, Sam Protsenko wrote:
> On Tue, Feb 6, 2024 at 2:52 AM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>
>> Depends on the simple cleanup patches from:
>> https://lore.kernel.org/linux-spi/20240205124513.447875-1-tudor.ambarus@linaro.org/
>>
>> A slightly different version of the google,gs101-spi support was sent at:
>> https://lore.kernel.org/linux-spi/20240125145007.748295-1-tudor.ambarus@linaro.org/
>>
>> Let's add support for gs101-spi so that I have a testing base for the
>> driver rework patches that will follow.
>>
>> Tudor Ambarus (4):
>>   spi: s3c64xx: explicitly include <linux/types.h>
>>   spi: dt-bindings: samsung: add google,gs101-spi compatible
>>   spi: s3c64xx: add s3c64xx_iowrite{8,16}_32_rep accessors
>>   spi: s3c64xx: add support for google,gs101-spi
>>
> 
> Just a grumpy note: I wish this series (except for the [PATCH 1/4],
> which I'd argue doesn't belong here) was submitted before the rest of
> SPI cleanups and reworkings. Would've made reviewing much easier,
> because this series doesn't apply without SPI cleanup series that has
> to be applied prior to that. There are other benefits to that approach
> too, as was discussed earlier.
> 

I feel we're bike-shedding, it drains my energy. Your reasons were:
1/ easier review
2/ easier backporting of gs101 if that's ever wanted
3/ driver rework takes more review time and I risk not having gs101
integrated for next release

2/ is not true right now, I could cherry-pick the iowrite and gs101
patches on top of v6.7. With 1/ I don't agree as the gs101 patches are
the same with or without the simple cleanup.
3/ is my responsibility and I'm ok with it, I feel there's enough time
for all

What matters, as I specified in the cover letter, is to have the gs101
patches before the functional driver rework which will follow, so that I
can test each functional patch with gs101.

I give up however, I'll do as you want. Will respin all.

