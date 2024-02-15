Return-Path: <linux-kernel+bounces-66418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA2F855C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DCFB24065
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20B912B9C;
	Thu, 15 Feb 2024 08:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fN3IDMiz"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D17BA2D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985839; cv=none; b=YU4K+WX1s8LA9ufgzQr3nhLTeR4KRtKG7q3LM8cGdGrazQooQxAJrw1Zsia5KG6jHsPqRGda9w2QQJIdfBYTPbhPV8XQyMuYSIZUXqnwT/dm1jbU7o7Chapk7YXng8VSpP5bjFxVbT7kwX0lh3OEN/vJgOP/boGZ6XQd9HIJjwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985839; c=relaxed/simple;
	bh=1FErbeV7rDxJ3T33wNluzYc7xE7Yp3tChjafe08OaDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1mshGc/ncPMsPXt2U3VTAUL9S/6my5oh/MXn+OGtdF5Gc2WtMpP0vsJ5Ua1bhyyh/Q7CxuPdBzv/uImxxRAjI7NiUQk2cB1zxUg5Y0NK5HrlRFowKf81rBX8mcaY0RgYzwUHASqssELZIY2cBWp4Vc6kJ2d5jKEdFtoCZAD1iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fN3IDMiz; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d208be133bso4243021fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707985834; x=1708590634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u01OPchu6bUpfA6vVMG2NSsakOHo3YJiJaGyU+KJbK0=;
        b=fN3IDMizYF902kkXyJMzp+aNdOWJr2972TOkLKFdjuNTjY5bNHqFqEkakHrc+LwCM6
         N5t/Wf49u3wCQeSnr2w6XIunCAKRH7S2QlC9MfFBsIQXlAb1PXSUlsZ1P4h08xlrMrui
         CiqUoD4WxzWpt20uPHsaQN7knopOZ+KDX6R5Vi5ihmBbVbDYkoFFcaTdJIHWHxdfudq+
         L0bCV5/j5Y8dDQjaaC4y6Kuw/9Xx7o3oxIVeva4CDmxelU0jpEJEUilECI2AxLwYbdb7
         8G6L8J0nRzNgye9yA0JXupjLfR+8kUW537Nrv9RBSibqTkJfHI1DIWcs02xtPbVhJXbB
         zx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985834; x=1708590634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u01OPchu6bUpfA6vVMG2NSsakOHo3YJiJaGyU+KJbK0=;
        b=nstrfqbBmJJRTSmw3Kplj7wfrv6odbJWdKWV0YS9poMWEjkOKQONjucSU2c9Jt1E4E
         ec6FTka8ZF0YHfEbuwMKJGIdk+syWPmvIjy3rMtDql2yVWXmZ8whFjWH8ZMUaFTqKcdq
         qjUY3vRfslfNyUhzwR75zOcBofGzv783a6WWmZp62qqzAyhZnfSwseUX27l0AWgSoM9x
         1msnHVDqHI+CFYaz26mx9qJuYJuJZiKqEB6pUsdOg4BpBIJUdujg0Y6+lpW7p09XydGr
         7AzDJkcQPzvxC0KfT7MP+7GdJMWapoLqPSFdykog4Ob1aDXcLWujzHQSggw+GhsYUcQn
         2TDg==
X-Forwarded-Encrypted: i=1; AJvYcCUsHwmcan9TuXvv0U8sNNbcD9Sg9rE7w2HcF+qakJZXRxY0NAiBy9wyW82AzWdcjm0VlKysSr2aPj2cbf/ZWjRXr9R98A+2eMVFzWlm
X-Gm-Message-State: AOJu0Yz6oCt3DBZRRjRmEdF/vs4ycJ6GbnJeFB994HiHrzYDMr8eabzk
	shkSDdEaIFEX8JkxJfnPXOE5MDcQT1yop7+23XaywNw+ZSpqrmWEiGCjTZqoSzo=
X-Google-Smtp-Source: AGHT+IFI5uSgyr8F2pW+SOMbZvcJtu+xeGNnJO3cQtbYYUlBCoRjc8aOpVcvhcr3QwyGP0kUS/WNoQ==
X-Received: by 2002:a05:651c:198d:b0:2d0:b464:a9b1 with SMTP id bx13-20020a05651c198d00b002d0b464a9b1mr978863ljb.4.1707985833711;
        Thu, 15 Feb 2024 00:30:33 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.136])
        by smtp.gmail.com with ESMTPSA id w22-20020a2e3016000000b002d07edd950fsm178610ljw.121.2024.02.15.00.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:30:33 -0800 (PST)
Message-ID: <897ae219-d443-4154-86c2-a280fac93565@suse.com>
Date: Thu, 15 Feb 2024 10:30:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/bugs] x86/retpoline: Ensure default return thunk isn't
 used at runtime
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
References: <20231010171020.462211-4-david.kaplan@amd.com>
 <170774721951.398.8999401565129728535.tip-bot2@tip-bot2>
 <20240215032049.GA3944823@dev-arch.thelio-3990X>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20240215032049.GA3944823@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.02.24 г. 5:20 ч., Nathan Chancellor wrote:
> On Mon, Feb 12, 2024 at 02:13:39PM -0000, tip-bot2 for Josh Poimboeuf wrote:
>> The following commit has been merged into the x86/bugs branch of tip:
>>
>> Commit-ID:     4461438a8405e800f90e0e40409e5f3d07eed381
>> Gitweb:        https://git.kernel.org/tip/4461438a8405e800f90e0e40409e5f3d07eed381
>> Author:        Josh Poimboeuf <jpoimboe@kernel.org>
>> AuthorDate:    Wed, 03 Jan 2024 19:36:26 +01:00
>> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
>> CommitterDate: Mon, 12 Feb 2024 11:42:15 +01:00
>>
>> x86/retpoline: Ensure default return thunk isn't used at runtime
>>
>> Make sure the default return thunk is not used after all return
>> instructions have been patched by the alternatives because the default
>> return thunk is insufficient when it comes to mitigating Retbleed or
>> SRSO.
>>
>> Fix based on an earlier version by David Kaplan <david.kaplan@amd.com>.
>>
>>    [ bp: Fix the compilation error of warn_thunk_thunk being an invisible
>>          symbol, hoist thunk macro into calling.h ]
>>
>> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
>> Co-developed-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>> Link: https://lore.kernel.org/r/20231010171020.462211-4-david.kaplan@amd.com
>> Link: https://lore.kernel.org/r/20240104132446.GEZZaxnrIgIyat0pqf@fat_crate.local
> 
> This warning is now getting triggered for me in some of my builds,
> specifically from Alpine Linux's configuration. A minimal reproducer on
> top of defconfig:
> 
> $ echo 'CONFIG_X86_KERNEL_IBT=n
> CONFIG_UNWINDER_ORC=n
> CONFIG_UNWINDER_FRAME_POINTER=y' >arch/x86/configs/repro.config
> 


I was able to reproduce this and it seems to go away if KERNEL_IBT=y. 
When looking at the disassembly of do_one_initcall it seems the 2 return 
sites are not patched at all, I see:

    0xffffffff81001284 <+84>:	call   0xffffffff81f2d000 
<__x86_indirect_thunk_array+96>


    0xffffffff810012e7 <+183>:	jmp    0xffffffff81f2d760 
<__x86_return_thunk>

The former should be rewritten to an indirect call as per 
patch_retpoline and the latter should be rewritten altogether. I wonder 
if objtool ignores the function for some reason ...


