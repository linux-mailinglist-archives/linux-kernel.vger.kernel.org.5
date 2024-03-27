Return-Path: <linux-kernel+bounces-121484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121C888E8B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552002A263A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D803137C34;
	Wed, 27 Mar 2024 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lLM/tA/h"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AEF13777E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552291; cv=none; b=WemwK99xwJmxruDxuZ8Q6/v8avM+D7ZKJUnoDW8LiZqMgs5C1dsRNZyE5Iw09ktTqoS2EciwZZG0gjFvKfHqqIRON7TF5Is++Tg3rD5UgsEeU5H9W8TXKGvoMK8AVVd/3xKxEPqQkuq0FK6ysvekUHgHS9k9EJCd/gA2hDaoQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552291; c=relaxed/simple;
	bh=rHdGLzexNCAF+drC6I8ecNiYnNaGkLBGs7Eesg7GYz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fl9Q1G9PkFAEQ5D3XFsTRnExVov8tjqDnsbd4FbbkZGBScyy0jy4CAK/2sXd+qMt3rjgb1mYMyo4rhEiB/xECUr80kLghP++QHllxiiIx3o0FdO9vr5nk0MQR79EwEX3tbqqcdtq/J0yhPP9ZEqH6vK3HxYVmuNGkVuQ8k4aiB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lLM/tA/h; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3668fd6952bso24873305ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711552289; x=1712157089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=enmbwQt8iez2R++PImRAw04TnXUHxgzDT/qGPQRyPOw=;
        b=lLM/tA/h8l11B0MOiVTZXIWkx3rNA0oS0SIGnAiH2brruLuSTwv6w/NwCdMO0RC9lk
         XLhduEIzkn2rg/f40LIy/OVmGg8q3mpS+oZ+k11jweHrueySO08IuQ9VmzpAHgkd/PzM
         anfE9Qb56Itllxi8B9hlx0j65abQwKW7H5/5ZX/J8lN8JWA5q5+wd/iSdeQvTrdiLnY5
         o9U1Vso/x42MK2IfTE60G8+HMotQekwtcmG76cpMwwyI6lwhdg8H7AutU3ycfJfsQ6VU
         Aprtungs6Maddk6Pgrldm0X1kkdYtuLqc0TDy361cRozwMV7546WQhl+4tzbpUzCRoNt
         m37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552289; x=1712157089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=enmbwQt8iez2R++PImRAw04TnXUHxgzDT/qGPQRyPOw=;
        b=OJITKJw4mSLx7KEcFSupECUXNrrRstwiBaXCAucb9h6OUUAjCNrs6oChpCOBNRaM+l
         0RpUXHEmn578BuuA8pqGR5pvvg0r8DJ1Wu8d3fE6T2DGJHn/x+TsErwfiqmlLC6ys9zS
         m9oWP3BA2uMObRTcZXEdKTdDLbaIy5xfD4VVwXXjv6iZE5B9d7PX/vVGzvXLBlT59En6
         q4GfC9tMoO+ZMZJn4g6nfacFiCZqAqzRAzMISIozNmvXnp9YKu9TJFSRorcyGArUKWeP
         QN81XRqmqc3Zya84r9DEU7PIMoXQWV5LH9oHfIlOd+gPVbPlmovV3RWo+dUJDZA4/7a/
         /A3g==
X-Forwarded-Encrypted: i=1; AJvYcCWQDIfeK2KVonY7GwNVoAJr6qlb7olGzdoJVbAajztMk2ZGq1nQiDmzRViENy/Ca2B+pXX3ULzfpd0OFKgoZUfm30wZHXKJ1pYSYzeZ
X-Gm-Message-State: AOJu0YyocrvctdpD54kVrrWKcSjP6egB9W8v4fdW7Of+jZSiAAjpREFa
	eWJrrGWse453w7vBkLnhPIQkD/MUNuYpp6tBTMO9tpxAfCCiHSkVooN1LyyQbsOGnDdzM49Kxnp
	4
X-Google-Smtp-Source: AGHT+IGN0kOBk5+Qq+4kRQhtbh2sJKJZj4esj2LAa5z3oPar2gagxLrLEqUx6m32iS0LEAqiUOOuhw==
X-Received: by 2002:a05:6e02:ec1:b0:368:a898:c824 with SMTP id i1-20020a056e020ec100b00368a898c824mr276546ilk.1.1711552289093;
        Wed, 27 Mar 2024 08:11:29 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id y9-20020a92c989000000b0036898bfb975sm1420171iln.0.2024.03.27.08.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 08:11:28 -0700 (PDT)
Message-ID: <8bff47cf-659e-4344-b235-72b17ed0f37a@sifive.com>
Date: Wed, 27 Mar 2024 10:11:26 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] riscv: Simplify text patching loops
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240212025529.1971876-1-samuel.holland@sifive.com>
 <20240212025529.1971876-5-samuel.holland@sifive.com>
 <874je4fvxl.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <874je4fvxl.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Björn,

On 2024-02-19 7:03 AM, Björn Töpel wrote:
> Samuel Holland <samuel.holland@sifive.com> writes:
> 
>> This reduces the number of variables and makes the code easier to parse.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/kernel/patch.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index bccd9ed04a05..7f030b46eae5 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -155,7 +155,6 @@ NOKPROBE_SYMBOL(__patch_insn_write);
>>  
>>  static int patch_insn_set(void *addr, u8 c, size_t len)
>>  {
>> -	size_t patched = 0;
>>  	size_t size;
>>  	int ret = 0;
>>  
>> @@ -163,11 +162,12 @@ static int patch_insn_set(void *addr, u8 c, size_t len)
>>  	 * __patch_insn_set() can only work on 2 pages at a time so call it in a
>>  	 * loop with len <= 2 * PAGE_SIZE.
>>  	 */
>> -	while (patched < len && !ret) {
>> -		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
>> -		ret = __patch_insn_set(addr + patched, c, size);
>> +	while (len && !ret) {
>> +		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
>> +		ret = __patch_insn_set(addr, c, size);
> 
> While you're at it, do:
>   ret = __patch_insn_set(addr, c, size);
>   if (ret)
>           return ret;
>   ...
> return 0;
> }
> 
> and simplify the while-loop predicate?

Yes, this looks better and reduces the code size as well. I'll make this change
in v2.

Regards,
Samuel

>>  
>> -		patched += size;
>> +		addr += size;
>> +		len -= size;
>>  	}
>>  
>>  	return ret;
>> @@ -190,7 +190,6 @@ NOKPROBE_SYMBOL(patch_text_set_nosync);
>>  
>>  int patch_insn_write(void *addr, const void *insn, size_t len)
>>  {
>> -	size_t patched = 0;
>>  	size_t size;
>>  	int ret = 0;
>>  
>> @@ -198,11 +197,13 @@ int patch_insn_write(void *addr, const void *insn, size_t len)
>>  	 * Copy the instructions to the destination address, two pages at a time
>>  	 * because __patch_insn_write() can only handle len <= 2 * PAGE_SIZE.
>>  	 */
>> -	while (patched < len && !ret) {
>> -		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr + patched), len - patched);
>> -		ret = __patch_insn_write(addr + patched, insn + patched, size);
>> +	while (len && !ret) {
>> +		size = min_t(size_t, PAGE_SIZE * 2 - offset_in_page(addr), len);
>> +		ret = __patch_insn_write(addr, insn, size);
> 
> Same comment as above.
> 
> 
> Björn


