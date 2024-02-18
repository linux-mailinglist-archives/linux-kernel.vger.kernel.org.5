Return-Path: <linux-kernel+bounces-70429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5F38597A2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E93A9B20D91
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17606D1A9;
	Sun, 18 Feb 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Fc5/yTsJ"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AFF6BFB1
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708270156; cv=none; b=XaAWEK83rY5tkUBAsZSWV/+cNgMuNu6Gul7GqOGct9HuUbS/jrOTaUi4RwmjGCZw0qT18+6RSbdmB5nhzIOGA0Pt3kbejD8y4jRNeGyiK6c6Tv5/MHsM27xuJ7EF1lVbW1WOvMxP+ZGkuwnF7ZJXsQSqPRkkVGhBuYd8kvGwjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708270156; c=relaxed/simple;
	bh=9/2GDui5xVzR13Pfxw4J5DVBexEGAcZ8LxCEuKyJwhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzImZmNQxbIGlzoqlXoHQMjfVRZTtyRYlRZGUCnOk1uJ37Ye6iz9BRu/FP45DVnkyzeE0AVyW6E2ILwnDLv231qGoYmvw/lOWU8fkgtWdCSDVLoaS7KaI9ix+Oat9SoK1+dkz7ognQmxe+SYl3vDCAlndzRJuHLUiF6lBtvD4V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Fc5/yTsJ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6869e87c8d8so16323466d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 07:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708270153; x=1708874953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sA/SDVQnKOxW6UupKa+w/g4FZh2wW67n4R63yMQWkV0=;
        b=Fc5/yTsJ3GWa1Cy0OThCksjitqfmFGjb3OoOScWNYngPFKArf8536FR/AxRLkfLCSX
         cNvnZ2LH2xNt03MO9t3MPSaLZJGLhXqCC0nza2ZROJpjyi4xJTNFfQoP6AYQLKjc0CwY
         VD9CUGvKYMzjEhoK4vE+UgyIbUiFH22BZhRDCDiUbjHCI5fQoYn16AVo/YN4A4CsX5fA
         3ETb0/vJUFqwud88BTKelg9axsDOP7Y3sUo65Kqz0PmWdHQNiCSb51EQVSl7GqqccIuS
         l/EMBqeR4j9iwNG/cZHArOLwiN/gTvNfi5g9XGMaYmm7l12vArled+3seO4R1+9ePICT
         oobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708270153; x=1708874953;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sA/SDVQnKOxW6UupKa+w/g4FZh2wW67n4R63yMQWkV0=;
        b=OlQMQVs3rCiryOtmnGNQCOmpD7buvVdXWtVmmA/BHT8iYSvHtZsaZjsZBH4+aJztPn
         mPIQMklnDbd0Jy/7BvB62TzXoibJXSeVKQPQW9DxitVwaKCoQuY14d/mxZnr4r4hULK3
         8L2K6I3yJ/+IvDhvzfu1fOH7hwUr30ezy07TY0PT9IBFnoyF0dNdVPKPr47hx/p7VYWx
         Vr2vMZDU6bgZmGCCxWGr1dGcU2FrdhU+8CXNcxZ1RYfG8p0FOkqkCe/rLch4tPeYJ/IT
         vrm1VpVBlQOzu9HtWWVyc4BTUVN/dUA9NXVDuvcJKcCXjcXpgBmtoprO5ZmHJ7R3xrDA
         rSLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC0+57Nr0Z7slhmSs2T8no4+XkfPuUz/Fu4GTUjMZpu6CciuNE5VXGHME3Ku2cd4L1PrFqXfrsT7YKt6FZwSc/z08tHjwnqUcovhAo
X-Gm-Message-State: AOJu0YzTs4XkwAR5OAV0TSmmBtJZJ0MtLEfrZiPJUCH1unm6zRJeWWFu
	+BvxatUT0X19i+oSzs+2iP30ELPQA0D6q6zTCUfnHLInLVnmqA2qO2njwbd0Tfw=
X-Google-Smtp-Source: AGHT+IFYjEWHXZNGVIdDOUHife0DwAl47pjuT11DGcHdgJFzG89QSi8SN5G0rSimAf7gcq/tXvbxJw==
X-Received: by 2002:a0c:dd91:0:b0:68e:fcc4:cb22 with SMTP id v17-20020a0cdd91000000b0068efcc4cb22mr10908385qvk.35.1708270153536;
        Sun, 18 Feb 2024 07:29:13 -0800 (PST)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id lq2-20020a0562145b8200b0068f4659b8d0sm1741150qvb.107.2024.02.18.07.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 07:29:13 -0800 (PST)
Message-ID: <72221da1-4a1a-4947-a202-9de203032f5c@sifive.com>
Date: Sun, 18 Feb 2024 09:29:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] dt-bindings: cache: Document the
 sifive,perfmon-counters property
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Eric Lin <eric.lin@sifive.com>, Conor Dooley <conor@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240216000837.1868917-1-samuel.holland@sifive.com>
 <20240216000837.1868917-2-samuel.holland@sifive.com>
 <eeb2331d-10e6-4902-91ba-85896a8f0ee1@linaro.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <eeb2331d-10e6-4902-91ba-85896a8f0ee1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024-02-17 3:00 AM, Krzysztof Kozlowski wrote:
> On 16/02/2024 01:08, Samuel Holland wrote:
>> The SiFive Composable Cache controller contains an optional PMU with a
>> configurable number of event counters. Document a property which
> 
> Configurable in what context? By chip designers or by OS? Why this
> cannot be deduced from the compatible?

This parameter is configurable by the chip designers.

The information certainly can be deduced from the SoC-specific compatible
string, but doing so makes the driver only work on that specific list of SoCs.
When provided via a property, the driver can work without changes on any SoC
that uses this IP block. (None of the SoCs currently listed in the binding
contain a PMU, so there is no backward compatibility concern with adding the new
property.)

My understanding of the purpose of the SoC-specific compatible string is to
handle eventualities (silicon bugs, integration quirks, etc.), not to
intentionally limit the driver to a narrow list of hardware.

Regards,
Samuel

>> describes the number of available counters.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  Documentation/devicetree/bindings/cache/sifive,ccache0.yaml | 5 +++++
>>  1 file changed, 5 insertions(+)
>>  


