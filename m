Return-Path: <linux-kernel+bounces-120473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737588D813
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974D51C26163
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8992C6AF;
	Wed, 27 Mar 2024 07:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEFYpdco"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0B1DA21
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526051; cv=none; b=s4LeHk7oWDBfH3bb48H4lNdv6wLBt09dfL07hnhfn/ymlAFGWjrwJrlJ8evHRcLxohU8KCSCgbqW/Gh/5CzAG0t7URbdxV709iQD5/L9ENlDAVJMic1JeK/GgQ/qpLU7XGvy6VgH7ksEwxV++4I0fesiyujqcZGcKtiYztMdL+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526051; c=relaxed/simple;
	bh=k2hKUHtmNw+3Nry+09PEpiWVfUC02KEaPbAqug7TAco=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ToLM6km/V6nCcVCIgW2mSFr3KnQNdmHDL71uLNfZ+A66gVgJbSsSHdtPHw5Vtz65eUO348t+kX4HMwBqk7Mm8wlaqlPGq5TVfIhlPFeyv3wt69bfJPERGi8/AvuNB1XIGq2d3+KW2GrXF7HvjgIoPlXTD8qYP2WAnfOxnx0u5uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEFYpdco; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a07b092c4fso1860081a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711526046; x=1712130846; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e8VEDc6X3vdP7dz2M9r9pk6H8tvft/oIARZVKpUkPM=;
        b=fEFYpdco0WVZPEO5jPet4utYDkvHLeSDcF9nIEDzssjc4A5uBzOYjyKkFcEdIGi5B+
         gTeZ6aXP1ZKSXs+vguRj76LCbrfKdxospTuA7PARA07TXAT56vaZbZ8FECIX1SK5xDKp
         tiY8gnY1GmpCDdM+N2Wn/jYXgoCq/jGq1w8sSEh8uhYlma5gLv2H7zZoACJ1mZM8UYEw
         9xPxbShwHF7p9VW9dJjpHFXqsKz4LpfHsB8L4xh3noF34zeNhBoJI4KaJuYsS8THzSgW
         L6ynFHqdSj9XuLMZMEF7Hc+QpG+atMk57Qdnzle8R3KwjYjT/Kj99b4vVVoXWSXywoyX
         LNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526046; x=1712130846;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5e8VEDc6X3vdP7dz2M9r9pk6H8tvft/oIARZVKpUkPM=;
        b=JktGYzJ5gjuiW0XKVOlDNqkqlTWi9ig6G9CnqXnDSvsRWkj6/nJIFSkJ9sCCYuyAQN
         0TT1+6uxl8tTCRbZd+Lgx5s86je5Yw9IrFtoH3bNEGEa5L8/Vijwr13AwIoY1iJb71dj
         KgI/B33uKV/+adqOojlfjRDhnnNPkqO8Pwqr+HkEpwfUbQK4axh8HgYt8TKihGJWjxpp
         lCPSa4Tgx4qhO4n8ZKUUi6gB0qD+z7sTeUDB1U1ku5A8/XJ3JYgoJ1PBmPBzM08YL2W4
         Afj1fqVRwEo6+qznB26fWVM1EFKKgGhQpaMyU2KbE8uClLh+GCEjvO2NWKyRmM5jCVuj
         AeVg==
X-Forwarded-Encrypted: i=1; AJvYcCX07/nayDAchFJHdXVhbtv/G4OdV99KQVuYtuQiX4hACxjaCJk5p7LRcNDFvuRh5fQ4fUONqUZtgYpiUjIodng/vnEFk68y+RGJkQZ7
X-Gm-Message-State: AOJu0Ywe8UZ8XSRoz8MxIA5PvP7wuZRSwQKya10c5I/dglaKS5X2aeJI
	LSfQqN7KPkQIy/CT4/122/Wbmb4/lyekHmeTEVdhjwY1bnyy/eRc0ZonKQyGbFQ=
X-Google-Smtp-Source: AGHT+IEnNz21hCUFzcc3BDrCXEP56Iio2L0jyNpy2CcYiYy/MtCouQUyfmpbI/NAqQ1TI46wKu7kCw==
X-Received: by 2002:a17:90a:f697:b0:2a0:4835:972 with SMTP id cl23-20020a17090af69700b002a048350972mr400982pjb.4.1711526045593;
        Wed, 27 Mar 2024 00:54:05 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id si13-20020a17090b528d00b0029fe0b8859fsm2531873pjb.1.2024.03.27.00.54.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 00:54:05 -0700 (PDT)
Subject: Re: [PATCH 1/4] riscv: Fix TASK_SIZE on 64-bit NOMMU
To: Jisheng Zhang <jszhang@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-2-samuel.holland@sifive.com>
 <ZgPE5e7FzB5H4MnK@xhacker>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <668ad9cf-08bf-92de-b70a-af36defda6e0@gmail.com>
Date: Wed, 27 Mar 2024 00:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgPE5e7FzB5H4MnK@xhacker>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/27/24 12:04 AM, Jisheng Zhang wrote:
> On Mon, Feb 26, 2024 at 04:34:46PM -0800, Samuel Holland wrote:
>> On NOMMU, userspace memory can come from anywhere in physical RAM. The
>> current definition of TASK_SIZE is wrong if any RAM exists above 4G,
>> causing spurious failures in the userspace access routines.
>>
>> Fixes: 6bd33e1ece52 ("riscv: add nommu support")
>> Fixes: c3f896dcf1e4 ("mm: switch the test_vmalloc module to use __vmalloc_node")
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> 

Reviewed-by: Bo Gan <ganboing@gmail.com>

Thanks for this patch! I'm doing something similar locally and it fixes the
linux nommu + musl libc build on my JH7110 S7 core.

Bo

>> ---
>>
>>   arch/riscv/include/asm/pgtable.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 0c94260b5d0c..a564a39e5676 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -882,7 +882,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>   #define PAGE_SHARED		__pgprot(0)
>>   #define PAGE_KERNEL		__pgprot(0)
>>   #define swapper_pg_dir		NULL
>> -#define TASK_SIZE		0xffffffffUL
>> +#define TASK_SIZE		_AC(-1, UL)
>>   #define VMALLOC_START		_AC(0, UL)
>>   #define VMALLOC_END		TASK_SIZE
>>   
>> -- 
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


