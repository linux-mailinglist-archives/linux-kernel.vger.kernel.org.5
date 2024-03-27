Return-Path: <linux-kernel+bounces-120219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A51F88D490
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F4A2E66D9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7498182A3;
	Wed, 27 Mar 2024 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ex8PUnFB"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18A21379
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506813; cv=none; b=XXq5153WleB28ddUIBvii8jEIVYrWiWbTex/OK6jpCKsvyNOba0qqTXbZ9Co3OG+Wp9UgDzvrA9xHxodqCzj3dBpjT4HJrcv9aoKIcjvNTOtLZwaAtvEhbvNyel2cGzhm6v8hvrHq70lwTtmJcL0trRFA1K1ocdDY514/E8sBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506813; c=relaxed/simple;
	bh=BMKyZlKB3p1BQxn1gas5mPKgS8lp7eykabBp8FQFVYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NjSNoHWFFWk4b/jkvMHCbIZhQ/qocxzdh1W9Z2WIxoe1j1EFSw4Q2y/TbIW9NAswkHQJnykgz3yyKQcgmcGApAoHtK3uS7NZt6RV6b/VWeo+Ii0v1aOrDbaWLs7yXEGmf8iz/KaPTfJ9T4ofY4TnU5qVh4+BZ0ZM41kHOLYHdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ex8PUnFB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e8f765146fso4783835b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506811; x=1712111611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUcA1YGuq4Y/fx9zQwckMTATKAUjIuuwUi478kUdPQk=;
        b=Ex8PUnFBNmG8vAMbRjoUYQYqSP0GqFFQf4vxtJd5RN92qmDqicddnyPtu3hjFFFwz4
         r/grhWjC9nG1XQjp84J9w6fIVDjgtKEcyUtYlre1S6JRx8n20jwwXOTZNYkuV9fPoUMU
         ToTDym+tKrkW2LJXR+CFAyWXOQCZPec0dL9S9TyFOZm4pLSSZya7GWzvWsQCygpjv44g
         nGzzZQZ8CtP2fwIaA9rLNQ6Me3aid4VlQUSc6PvlRql3jEUx6CJkoo9b766qXT5m0XUW
         kK7FuAkJBdkbk7BzcPGflps4X+ivCouqxraE+ZHvlcR1XGrp9hf2DWn92wYCk3XxM4CP
         KdKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506811; x=1712111611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUcA1YGuq4Y/fx9zQwckMTATKAUjIuuwUi478kUdPQk=;
        b=X8jDHH47PE/Xi26sA2W7P6O9pCEK4JF+Xj1aIO2L4JUFo8hVwgvKUEwK/IzG/A8k2i
         mM4j4dkMsEOpnVL/XGzORT077HKWYm40KvoQntwKHZnrQqmzfyPR2sSkERjzH69lxfsl
         K9wv1oQV4OxanLRDULOo+Bsy23GNlRsnPR2HNOohWvNn9pIKlCL2La82dQiEB3gehD4m
         IIdAG0yMLYqCpdSANYqxKT5N6lrjatdAncRlpXnuHnO3+Be+ILT0hEvN6a4qOfldU/6F
         xaQKkb8faR4MjDd8Pm/l5cPyOO/bz6urY+gy3q6E/Ny4JSWExB9flFdWymnb6JsMx8VO
         uM/w==
X-Forwarded-Encrypted: i=1; AJvYcCVMOOjTSCl/djfnxLF2gB+CMRtomVuWy+WrX9uKhZ7WEFxYkC5xk0sMDhU3rQUmYN3qGt1PoKtTJrWpfqT8c2PTkGC76sS0AFCws7bA
X-Gm-Message-State: AOJu0YzvWTdhnLXvoauWyttAYWuFTDVtb1fgxF0zc8fQh5bLS5Tq5L06
	yMISO3VIOvOkcPHIX5MH52zYwPczCskptXeXaVDXRbP2XEj0kbnn
X-Google-Smtp-Source: AGHT+IHns/rp8zh8tfRMJLhVM3v0c/Kp/kLhPCJxnNLk+eE4ji51HQIUBSDgxIsGP/4mT2AzYBSkTQ==
X-Received: by 2002:a05:6a20:4f0f:b0:1a3:5d2a:4003 with SMTP id gi15-20020a056a204f0f00b001a35d2a4003mr3457811pzb.49.1711506811026;
        Tue, 26 Mar 2024 19:33:31 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b001e0da190a07sm3215853plg.167.2024.03.26.19.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 19:33:30 -0700 (PDT)
Message-ID: <23e1665d-7500-4ecb-a208-59d1c5514e87@gmail.com>
Date: Wed, 27 Mar 2024 10:33:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/dumpstack: uniform die messages prompt
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, alexs@kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20240202074512.563274-1-alexs@kernel.org>
 <20240326104306.GBZgKmuqvLPzppFxyD@fat_crate.local>
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <20240326104306.GBZgKmuqvLPzppFxyD@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/24 6:43 PM, Borislav Petkov wrote:
> On Fri, Feb 02, 2024 at 03:45:12PM +0800, alexs@kernel.org wrote:
>> @@ -405,8 +407,8 @@ static void __die_header(const char *str, struct pt_regs *regs, long err)
>>  		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
>>  
>>  	printk(KERN_DEFAULT
>> -	       "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff, ++die_counter,
>> -	       pr,
>> +	       DIE_PROMPT "%s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
> 
> Why do you need this DIE_PROMPT if you can simply do:
> 
> 		"Oops: %s: %04lx... "
> 
> ?
> 
> And yes, I think I'd prefer having an "oops" in there as it is a lot
> more prominent. It is called a "kernel oops" everywhere.

Uh, 'Oops' is also a good preempt. If no other objection, I'd like to change this. :)

Thank a lot!

> 
> Thx.
> 

