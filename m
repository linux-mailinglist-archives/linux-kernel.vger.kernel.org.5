Return-Path: <linux-kernel+bounces-153034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B858F8AC823
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB36F1C21170
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C65578A;
	Mon, 22 Apr 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="CEMHhUch"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDF454FA0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775995; cv=none; b=RU/ZT27JI627SF06L5JDDy/jV0AYoCxjhG0HHmkHfiaYan/3vOL7ZKTWCFxlrkYLmQkp8/l9cmLIEQJ+E3EMMwBozLeGyRY0i+gRVv1vrq9b0E7lQRziEk8Ce6IY/MxTfnicSHJnpXSxfo64YPHL/M1R6YMlhN4Z4eaAJf306a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775995; c=relaxed/simple;
	bh=knFRrVHv/hXP0hrnXxi3FsPJj1U2CbJeo94T4pn0sEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVwiutFZ03BH0kXgVHEcpFRSLEjFZpd3fIpMCCwWZrPb5gONzrW0XxAaWogTIn8AZ3IqOD34ImCRkjAg51olb7mYizRVoDXiuEurrLMlWG5zmpOpv7VyM0lFXr5QDR7hZkF5Wm0In9GrXQ+CZzcou/GiSm3IpWLXQB0ue1JpAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=CEMHhUch; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34b39ecbcccso53132f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713775992; x=1714380792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSJifQLOOtjWe2caLguw5JxOp3zY6VKsL2huHk/+dLw=;
        b=CEMHhUchJNQvjTBZSnWxa7JlW45AdnicxGM+sHRNdpG1+LKLOPYb4xITd0rL0jIdHe
         S4pxZqdrFFzKGeGJib+2edypzIEAjo/0g3CDY1AhJUBklADPmPp6Jzh06Awlx65aDdjM
         XWGDJUW7MzDHZXbutnNghNLiyyjxxgZbrlqka6XzPcGVNXJ3J+vDQ9ImGQa033nDfE4x
         VUnDi2xDFhXEYq5EbhNg6uNixK5eBsiB/iNT2K8Qa2bTwp6sh5ao7QHTXhDiNK464lA0
         nlYs81raAp67lAo8YoA1e7ysTStznB7LSv597bPrlFWjE3zj0k7m6lOJ78E6Tuocs2JB
         KSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775992; x=1714380792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSJifQLOOtjWe2caLguw5JxOp3zY6VKsL2huHk/+dLw=;
        b=lHN+aGyMQW+csb4T6vbXmYjjSFwl4X/Ay6MXKeDs2xdQHwQf+4/MJaS1mOMm3GbfXn
         7xoJZ8ie1IQqq5nFzSit5ZFW/WBmfZcpqwZLpajQI056FS3Et3sznbd00E1su3M1YhPm
         KZ2FZckzwYwJSPijHYcWTRrSvQJw8DJriHOIT5TpBJFzRyKSszP8oMqdR9q46L+gz6uN
         92C9D7Qe+vKdoB7QzA0xiS/rqeRPFTz3ge4zb/j69w4bVmtwjmEKNKEloO3v/y1uEu/H
         Vve7UHePFIdj7dRVEBUuouGN43BXgpeeKYXHAzZQKM2OMEQWSWbb1qMOguCcwzv8JKRD
         /CTA==
X-Forwarded-Encrypted: i=1; AJvYcCXZhq5fTODV0pVaIJy29qqEEU7eQjrjAGWivhv8F5pjScPr+1BrzvvXnLeb3gRlhnWxiE5pLZ4rEx7A7KAcfMH2BYpdaYXjQ4w8iqmP
X-Gm-Message-State: AOJu0Yw2u2VaSpGYcgiiDGOlsIBH2ifXs7++sFz/ItlkvFCZYLe5SC3B
	5OuloHbVYl1ru2bjw+xhM7Nt4Mmi3hRcSrcnu5bPTppotvrBEVh4/pGe7/gQ8Wc=
X-Google-Smtp-Source: AGHT+IHRas3l39C/N5OldWvLjh8/Ocyg0dgZzgEEfR5deo9HXajPzyL+wuWZHMyf6dRNz3xpRu97wA==
X-Received: by 2002:a05:600c:3b09:b0:418:ef65:4b11 with SMTP id m9-20020a05600c3b0900b00418ef654b11mr7146190wms.2.1713775991653;
        Mon, 22 Apr 2024 01:53:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:dc65:11af:998:225e? ([2a01:e0a:999:a3a0:dc65:11af:998:225e])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c310700b0041a92bb0c10sm25826wmo.2.2024.04.22.01.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:53:11 -0700 (PDT)
Message-ID: <6ab9e591-f2f2-4267-8bdd-169ef0243e14@rivosinc.com>
Date: Mon, 22 Apr 2024 10:53:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] riscv: add ISA parsing for Zca, Zcf, Zcd and Zcb
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Anup Patel <anup@brainfault.org>, Shuah Khan <shuah@kernel.org>,
 Atish Patra <atishp@atishpatra.org>, linux-doc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <20240418124300.1387978-1-cleger@rivosinc.com>
 <20240418124300.1387978-5-cleger@rivosinc.com>
 <20240419-clinic-amusing-d23b1b6d2af2@spud>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20240419-clinic-amusing-d23b1b6d2af2@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 19/04/2024 17:51, Conor Dooley wrote:
> On Thu, Apr 18, 2024 at 02:42:27PM +0200, Clément Léger wrote:
>> The Zc* standard extension for code reduction introduces new extensions.
>> This patch adds support for Zca, Zcf, Zcd and Zcb. Zce, Zcmt and Zcmp
>> are left out of this patch since they are targeting microcontrollers/
>> embedded CPUs instead of application processors.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/hwcap.h | 4 ++++
>>  arch/riscv/kernel/cpufeature.c | 4 ++++
>>  2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
>> index 543e3ea2da0e..b7551bad341b 100644
>> --- a/arch/riscv/include/asm/hwcap.h
>> +++ b/arch/riscv/include/asm/hwcap.h
>> @@ -82,6 +82,10 @@
>>  #define RISCV_ISA_EXT_ZACAS		73
>>  #define RISCV_ISA_EXT_XANDESPMU		74
>>  #define RISCV_ISA_EXT_ZIMOP		75
>> +#define RISCV_ISA_EXT_ZCA		76
>> +#define RISCV_ISA_EXT_ZCB		77
>> +#define RISCV_ISA_EXT_ZCD		78
>> +#define RISCV_ISA_EXT_ZCF		79
>>  
>>  #define RISCV_ISA_EXT_XLINUXENVCFG	127
>>  
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 115ba001f1bc..09dee071274d 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -261,6 +261,10 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
>>  	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
>>  	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
>>  	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
>> +	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
>> +	__RISCV_ISA_EXT_DATA(zcb, RISCV_ISA_EXT_ZCB),
>> +	__RISCV_ISA_EXT_DATA(zcd, RISCV_ISA_EXT_ZCD),
>> +	__RISCV_ISA_EXT_DATA(zcf, RISCV_ISA_EXT_ZCF),
>>  	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
>>  	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
>>  	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> 
> Ye, this looks exactly like what I "feared".

Ok but for instance, Qemu actually set Zc* based on C/F/D. So the ISA
string containing theses dependencies should actually also be allowed.
So should we simply ignore them in the ISA string and always do our own
"post-processing" based on C/F/D ?

Thanks,

Clément

