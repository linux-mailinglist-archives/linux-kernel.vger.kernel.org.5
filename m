Return-Path: <linux-kernel+bounces-63458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 279EC852FCE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFEE1F23D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A411D381A1;
	Tue, 13 Feb 2024 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FszU3cEU"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B65F376E6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707824951; cv=none; b=ccFHosZ1R/Ysq9OTNrjSD0BXOGHOsqxOiqTMKCU76BMrY2Wd5JqAxmGjosvLaQrCuWctQxBk6U1CVVVf25DlTW9IMbzS0p2zwL9XbMB1hQzEotptlj5UZ8maeMw69HrjRfeALEDoaZ5vjRmGh509haNXJnvgJubbzuB4E2f4sPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707824951; c=relaxed/simple;
	bh=FYBm5VUOZNBLyP4qOZ4sPzIQloS1I0i/GF6hxRuLPW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGPMW45IgO7HfcPA3JdYTuhk6gt/cz4EsaVliah7EsnecqSCtm29kBczKtCTC1TdhnuDkeyiDySZBmEBA7eGYdnMTsLBMMdqk4dS1Ncv+LzlL8k5DmYBkpUT4oaX+38InuK4dhwNHJkHYEzfsI0zASxbVKwThET7Q43IwZJSS1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FszU3cEU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3394bec856fso3109611f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707824947; x=1708429747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLxYb8ulK3/+KD2RG1jbewIrsAiXBJRq0PO1rsmumS0=;
        b=FszU3cEUZnMMxQUKbanRKkWWdR+V6AZBVFZkZThY/3e0Ay511rGfJyzWh3mkz3wdb4
         kdOp780kVUs7Y/HhfOh4BVdkID864gNtPgZcH8YqzXUwP/jmC5dB3HKj7v0lWnl2GCz8
         Mzru2qAiVcoHwaPf0SO+Xixqu9GAay3LIQwSjdJxU5aoc6/+gR6gJ46ntl4rkE8GrTMo
         vSwLozOQHUrRVQtOR3QQ8GxbZkFzGZOyOXgzQFK4MDuT8lE3N3Naszw6MWIIHMlEU/ZC
         dJ6Yrw+cxuEucVNGTIvFu9WtRuwMtNUbEU4V0o/2zkCU9ORyOFJXVgtVuZfUjhk8w4LE
         mcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707824947; x=1708429747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLxYb8ulK3/+KD2RG1jbewIrsAiXBJRq0PO1rsmumS0=;
        b=bAQ1XQ9fW+CLIKS1PHOxGZeNJaPCfcwFSdTIfJFXqrnBbVZ6GDt6qiSvA/pUqnBllg
         bRlFvfoUi1BJ2/f3vGeyYexGSVe7jwL5x1fB/q5kdwqQnJy7ManxY/xYpuG+yT4JWB1q
         s3Q8n8PE9MoRfIWZAIdtjCUi8lOja120/HkTX4YfI83Rkw8hoMRHXELhSsVCCOofVeoE
         mVZ0CVIDL6QF1YajwhiuHW2u1VE/bo8mWP9Hy/BvPHDacySnOnDjIaErzYG4U4WWQK53
         c5PXehbdisQwG64Q5GEBSjgb6/sa6dx2RAXfW1pY/eY8biruCLTz06YAx6Y69A1TpSra
         F0jA==
X-Forwarded-Encrypted: i=1; AJvYcCVVoE/DJQsIbva9hLchKEc2p7xPSj3cw4F0bL4zE6hDM2vzd6HyAqgrPzdvHey5895mhBrSpBrUCmp9H7gnizir3ly2LT2ceg42U+01
X-Gm-Message-State: AOJu0YzLSLlKBUb5XYyTDUvP7GWsuoNaz0qviFI2bXCrT8enqIVR2Ixg
	H+/p1EUQ/JFEG/8xUQVUuhq+lLIbVE0PvRLFu/O2x7sFfuuvRrSq/Vb8TQAS8GY=
X-Google-Smtp-Source: AGHT+IHQGw8/XonnfpC633ywE2gwBWrQnwyRK1evZjZRcHekINMxQLs/ScJ0kylBjM6kxlH3CYkC2Q==
X-Received: by 2002:a5d:570d:0:b0:33c:df1c:8e18 with SMTP id a13-20020a5d570d000000b0033cdf1c8e18mr879713wrv.26.1707824947610;
        Tue, 13 Feb 2024 03:49:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXH49yLxdY/J4W1Z27yp6IOnBdU0EPBCFf501YQZ9g7s9fij4pchHE4EcG6saQrqzXJNKmw8N2a6bALghy7WDe1OJe89rjEkRe6QzoCoc3UPvY7bDwArtWirSnqCJBL6nbQy3CdtNwhfHfNTEko/nf3uCk2v8FDpDa+RYZIR0766q+KqWktcamx6VoR6KRG2hMdszY2s+VNKOwJ2Z8=
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.136])
        by smtp.gmail.com with ESMTPSA id bo26-20020a056000069a00b0033cd06387ddsm1920891wrb.82.2024.02.13.03.49.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:49:07 -0800 (PST)
Message-ID: <6678b65c-15ab-4bbf-b3cc-a3110dca97e1@suse.com>
Date: Tue, 13 Feb 2024 13:49:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Improve description of
 IA32_EMULATION_DEFAULT_DISABLED
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, =?UTF-8?Q?Hanno_B=C3=B6ck?=
 <hanno@hboeck.de>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240130104543.28840812.hanno@hboeck.de>
 <20240206145823.GGZcJJD8rDtPRNBkhe@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240206145823.GGZcJJD8rDtPRNBkhe@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 6.02.24 г. 16:58 ч., Borislav Petkov wrote:
> On Tue, Jan 30, 2024 at 10:45:43AM +0100, Hanno Böck wrote:
>> The description of the option disables a default, but does not mention
>> how to change that default. To make it easier to find out, mention boot
>> parameter ia32_emulation.
>>
>> Signed-off-by: Hanno Böck <hanno@hboeck.de>
>> ---
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 5edec175b..a65ff33e0 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -3006,8 +3006,10 @@ config IA32_EMULATION_DEFAULT_DISABLED
>>   	depends on IA32_EMULATION
>>   	help
>>   	  Make IA32 emulation disabled by default. This prevents loading 32-bit
>> -	  processes and access to 32-bit syscalls. If unsure, leave it to its
>> -	  default value.
>> +	  processes and access to 32-bit syscalls. If set, IA32 emulation can be
>> +	  re-enabled with the boot parameter ia32_emulation=true.
> 
> That sentence should say one can enable it *dynamically* with the cmdline
> param.
> 
> But this text reads weird: if I want to enable it, then I won't set
> IA32_EMULATION_DEFAULT_DISABLED in the first place and I won't have that
> problem.
> 
> So the use case must be something along the lines of, ia32 emu is
> default-disabled at build time but for certain cases where one wants it,
> one can still enable it per-boot with a cmdline param.
> 
> So what's the story here?

The use case is if a distribution wants to disable ia32 emu by default 
but at the same time wants to give users the ability to override it. 
Which is pretty much the use case you presented.

> 
> Thx.
> 

