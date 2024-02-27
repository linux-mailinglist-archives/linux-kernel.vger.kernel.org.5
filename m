Return-Path: <linux-kernel+bounces-83916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0725486A072
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE22B32132
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B72014A4DC;
	Tue, 27 Feb 2024 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Le3J0TTs"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093D94D107
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061736; cv=none; b=BUDA/rOispdEFUu05cjZslpZphergIIcv/12KEL6ywDjMCwbEQKJRZx9NM9V/AgJ/u0tvN8KTaiYKYzzwVayKNGhm+EPEMEbjWpVbvRJ1SL382BPmMTWgrZvIk/67umrD2b40s+vW3IQlAHziig96WhPqLOnNCBW9lB/UftNZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061736; c=relaxed/simple;
	bh=delkJb/DGlxmhXkRhTjoZjiLLkGbK0QvDQCUCXsVvEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AO3+R+5CwkFx5ACRGI7Kj9gMpUy+wAc0prVQutd9e8faIlJxcoOQzJuq9xQ6jjqEsgim543bkLbF0Daz+EJ3yXBEqlOMwQf/Eecr453FGPJMO378Fh5Gta/XWHtpIjDsR1c3z2hTT/GETVmCtA8H5mkJcCMOy9S6QoIRJRn9oIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Le3J0TTs; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c7229e85b5so167018739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709061734; x=1709666534; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daBiu+dTDOsAsy2yhxY8tXjMmdUYISpdMVSBjsClfNY=;
        b=Le3J0TTs04xWctf6/PYUlVEDdgTfFNjdZlPcNXW4jxUAM7JF6AuQElssknaKhMbtrU
         CdCG4dXFyYLUIUNhIQdM6lqcOLsnL+1hZypeuIoxLeuZ/Y4PFv5USYt9LSYqs9/+99Yo
         03zmd3UmKgbTx9Mg2htCv/IEmU2LdxCjJ34ygSdmI3EHUglrCS2boqdI85OD8n9f4gRF
         9zI3WUwFEpw/N4iiQkZCAJSRC1HJa44JWDwET8hRw2wZJJMGk/h9Xys8+yhtiwMq+g7B
         XHV/cvML1hxyDzkzCMJC9jvoC9ehaFWB6qxsAtd6HbPVjp/u8sfcltrDLabkOzSPlu1a
         ExKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709061734; x=1709666534;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daBiu+dTDOsAsy2yhxY8tXjMmdUYISpdMVSBjsClfNY=;
        b=cCm0jpTNoloHIP18hWF5lxnEw/70D6hG/Lqhqb4BT6iBRaADt7bjM4cvQm6xzB8etB
         r5E6xY25h6lvmYrcN+pyRbir9Dkl7BFniB6MJmURTxvdrJ7Gw3BmnzG6x4R8vo7vuTJR
         Nk1HsnTfOUko6CrN1Fq+ZJA6TgJB5CWWYh+fJhRYn/Zv5iosEqXraEzVEvtVhiSST6sW
         fZ+coh/neD5InunTI1T0CIY0UwONC2tCqBJbTzwpo9tkd0cIZPvMUGWtw1Kw61SLCKX6
         j8KLFYyQQvATGxc5qY5JSoRTLb2822ogpxNCAHIozCV0nesbyvvyLTqONY3zwtICVbcE
         2Kbg==
X-Forwarded-Encrypted: i=1; AJvYcCUVYoRZNWxFADzbUseXG03I2ebb+rGcsBt0fICL1jv8wbPi/W5cJt7Ui0wfy64cd4BOURuJbknuOKdgJqARXvh8MkhWywtnohbw/hnd
X-Gm-Message-State: AOJu0YwCnnWJtnAxoYK4kG0ZSpOKzWvbZQI3no85c7PLJsXuiueXCQ+m
	ch24pF/LgGFKWqedbYJbuMRyk7wjkarhidClIG/oeT0F9GAz4Mcit5intC7A2NOuKZPBBoJQS+s
	2
X-Google-Smtp-Source: AGHT+IE7+ucmoeU4TVIjogt9kPNfNJP4dPyAQIAV+r9O+fZrVXXrMhT/VTNnYBXqseweoo204evXfQ==
X-Received: by 2002:a92:650f:0:b0:365:c81:e02d with SMTP id z15-20020a92650f000000b003650c81e02dmr11843728ilb.14.1709061734132;
        Tue, 27 Feb 2024 11:22:14 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id o2-20020a056e02114200b00364187af517sm2269051ill.80.2024.02.27.11.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:22:13 -0800 (PST)
Message-ID: <9673cbe7-41ec-4261-9be8-fc5191ade56c@sifive.com>
Date: Tue, 27 Feb 2024 13:22:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] riscv: Fix loading 64-bit NOMMU kernels past the
 start of RAM
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-3-samuel.holland@sifive.com>
 <20240227-unfitting-rectangle-cd0f23a4f3f1@wendy>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240227-unfitting-rectangle-cd0f23a4f3f1@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2024-02-27 6:18 AM, Conor Dooley wrote:
> On Mon, Feb 26, 2024 at 04:34:47PM -0800, Samuel Holland wrote:
>> commit 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear
>> mapping") added logic to allow using RAM below the kernel load address.
>> However, this does not work for NOMMU, where PAGE_OFFSET is fixed to the
>> kernel load address. Since that range of memory corresponds to PFNs
>> below ARCH_PFN_OFFSET, mm initialization runs off the beginning of
>> mem_map and corrupts adjacent kernel memory. Fix this by restoring the
>> previous behavior for NOMMU kernels.
>>
>> Fixes: 3335068f8721 ("riscv: Use PUD/P4D/PGD pages for the linear mapping")
> 
> This commit was a year ago, why has nobody reported this as being an
> issue before?

I can think of a few reasons:
1) NOMMU users are likely to be using RV32, which is not affected.
2) Before patch 4 of this series, NOMMU implied M-mode, so there was nothing in
the way to prevent loading Linux at the very beginning of RAM. (U-Boot/SPL
relocates itself to the end of RAM, so it would not cause a problem.)
3) Platforms where RAM does not begin at exactly 0x80000000 would be affected,
there are several workarounds: change the start of RAM (for soft cores), change
PAGE_OFFSET, or change the memory ranges in the devicetree to exclude anything
below PAGE_OFFSET.

It's possible that nobody was affected, but it's still technically a regression
(a hypothetical platform with RAM from 0x40000000 to 0xc0000000 would crash
instead of only being able to use half its RAM), so I thought it still deserved
the Fixes: tag.

Regards,
Samuel

>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/include/asm/page.h | 2 +-
>>  arch/riscv/mm/init.c          | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
>> index 57e887bfa34c..94b3d6930fc3 100644
>> --- a/arch/riscv/include/asm/page.h
>> +++ b/arch/riscv/include/asm/page.h
>> @@ -89,7 +89,7 @@ typedef struct page *pgtable_t;
>>  #define PTE_FMT "%08lx"
>>  #endif
>>  
>> -#ifdef CONFIG_64BIT
>> +#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
>>  /*
>>   * We override this value as its generic definition uses __pa too early in
>>   * the boot process (before kernel_map.va_pa_offset is set).
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index fa34cf55037b..0c00efc75643 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -232,7 +232,7 @@ static void __init setup_bootmem(void)
>>  	 * In 64-bit, any use of __va/__pa before this point is wrong as we
>>  	 * did not know the start of DRAM before.
>>  	 */
>> -	if (IS_ENABLED(CONFIG_64BIT))
>> +	if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
>>  		kernel_map.va_pa_offset = PAGE_OFFSET - phys_ram_base;
>>  
>>  	/*
>> -- 
>> 2.43.0
>>


