Return-Path: <linux-kernel+bounces-83888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1AC869FEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA132B2D69E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C981482FC;
	Tue, 27 Feb 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="irQNWFEo"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916B51021
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 19:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060535; cv=none; b=k7v/f0LGrlL8oDkHugsc00CqqvgU5zqyVBT+gWZ+nG/Lu3YouvJAsWX5MwuCswVdf84adufRXHsre4a8TMpJktwAaTN22htoy8ZQi7Vz0vwDqMzsrCWSJUKyUmHj9J+gcnkbMhHK+j7yqO5Q22AgD6isCQpzInRSZKS/gSlPmWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060535; c=relaxed/simple;
	bh=OsYvzHtYJs8UyH6QzhhdhTaVbCu1IPB2JAIf4rNii00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujuJN6U72571hz3Soc/4oh9Lq2Xv/WlDnsJcQn9ka5knAn5H933Nya8s6XKw7RuHsikZwsYS/wLlO3QhJPBiLJMsDmQaU8r3PUE6LwukN8ZdYZDTC38Aax6wqye4uGqtkf7oGpASQuB+ryNjFEJWxZrOljZEoX8mNNgvadRAO1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=irQNWFEo; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3650b558a8cso14455015ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1709060533; x=1709665333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCMYN1p2M2SlsOhGzE1chvN/98rPlLh7qBG5ujmIAMc=;
        b=irQNWFEoXSa//woICHW8fscv/rH3JP0YjEmEgCsSa9jHf5x47jqUFIrg48uq4ThnHP
         0UpsQvGUmdjCLmQ5kjXpIEUfIIxL3u/joiwEFosE12PzvkLwwJLRfkCBEx2G4XDQ+afD
         OFJnYJG+mR+EHe0lhuG5glVQn+2FvZax0/vtAQhEXym4oVLzu2lq24CXK4UX4YDlBmfk
         zFoTUwfpDfHHpAxCM+0PKC2eK9KL2Ao67XpMNkRbDQYFo2smgtEAbMvlxNtpApl5VQwj
         D5BRPMwKVIb5GoVTeTjoznAYjqrKaTuBwCqHTEFKgdogagNjZu//EO2/vMKlN+kjzRY2
         IJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060533; x=1709665333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCMYN1p2M2SlsOhGzE1chvN/98rPlLh7qBG5ujmIAMc=;
        b=Xjn8/6pkDZJx975cmpsgCQS/eaZMqyQL/hVsLVACAQC/hbDUjCPfn/dtBPaYAPK3N/
         PAuW8CpgvtoqGcswF6PgmdZpVIo09TX5tHDp5nqeojG543HJzFrsxoT/anQA4JrxG2pd
         ihrvCLO7fdQnIZwxPyCIAlxBu7lrMIr19rzY/tYy7rnhnwh4chAES7L92RfDmdxcOB8W
         OFGxl65tZdxI1ANacxlnOcbT8seO3s5i/Mfwz3Q9mBklx8PnArZ+Y9ABpoFBkEnhhoWD
         0iacM7R+aGiqRg3vmw4rWMHeXPli0Fhmc1pOAhvPz7mA3QZlrF14tlWZmZb+5xGeEPQs
         WbAA==
X-Forwarded-Encrypted: i=1; AJvYcCWuZ/L9ZkQH1H/1kZc2QbIz7d4u5k7QxXahDmwnvYXUZ2Cf4SDBOT7O2X/Ukh5XCBurBiNzINWurjCPKvveck0ZYh8xWATINErsjLG4
X-Gm-Message-State: AOJu0Yz46x9qSGSaoyEzq5yHPltat4GIkIYP0PKB7i7PsICxxsJtKXjG
	HIj8X3Z9j0bsrfyDKvI/WOSDNh1HQiK9tG/SLgHJsYrChFRd/p49wdNXYTsKIlOXfkwjTTpNWNP
	7
X-Google-Smtp-Source: AGHT+IEBkkgRMWT0jvgdj6J7NYZBL6lVbNpeKSR44IxOtrxSzlkRKO8z8Kxh72ZfSDwXXvoS+D6FIQ==
X-Received: by 2002:a05:6e02:20c7:b0:365:c8:7a15 with SMTP id 7-20020a056e0220c700b0036500c87a15mr13956481ilq.20.1709060533327;
        Tue, 27 Feb 2024 11:02:13 -0800 (PST)
Received: from [100.64.0.1] ([170.85.6.200])
        by smtp.gmail.com with ESMTPSA id l4-20020a922804000000b00364f14861ffsm2248458ilf.76.2024.02.27.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 11:02:12 -0800 (PST)
Message-ID: <21e03db9-efb7-4e26-9b0d-4931afd62194@sifive.com>
Date: Tue, 27 Feb 2024 13:02:11 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] riscv: Allow NOMMU kernels to run in S-mode
Content-Language: en-US
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
 <20240227003630.3634533-5-samuel.holland@sifive.com>
 <20240227-seventh-overgrown-2fa453e8a775@wendy>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240227-seventh-overgrown-2fa453e8a775@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

On 2024-02-27 6:24 AM, Conor Dooley wrote:
> On Mon, Feb 26, 2024 at 04:34:49PM -0800, Samuel Holland wrote:
>> For ease of testing, it is convenient to run NOMMU kernels in supervisor
>> mode. The only required change is to offset the kernel load address,
>> since the beginning of RAM is usually reserved for M-mode firmware.
>>
>> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
>> ---
>>
>>  arch/riscv/Kconfig | 15 ++++++++++-----
>>  1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index ef53c00470d6..0dc09b2ac2f6 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -64,7 +64,7 @@ config RISCV
>>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>>  	select BUILDTIME_TABLE_SORT if MMU
>> -	select CLINT_TIMER if !MMU
>> +	select CLINT_TIMER if RISCV_M_MODE
>>  	select CLONE_BACKWARDS
>>  	select COMMON_CLK
>>  	select CPU_PM if CPU_IDLE || HIBERNATION || SUSPEND
>> @@ -220,8 +220,12 @@ config ARCH_MMAP_RND_COMPAT_BITS_MAX
>>  
>>  # set if we run in machine mode, cleared if we run in supervisor mode
>>  config RISCV_M_MODE
>> -	bool
>> -	default !MMU
>> +	bool "Build a kernel that runs in machine mode"
>> +	depends on !MMU
>> +	default y
>> +	help
>> +	  Select this option if you want to run the kernel in M-mode,
>> +	  without the assistance of any other firmware.
>>  
>>  # set if we are running in S-mode and can use SBI calls
>>  config RISCV_SBI
>> @@ -238,8 +242,9 @@ config MMU
>>  
>>  config PAGE_OFFSET
>>  	hex
>> -	default 0xC0000000 if 32BIT && MMU
>> -	default 0x80000000 if !MMU
>> +	default 0x80000000 if !MMU && RISCV_M_MODE
>> +	default 0x80200000 if !MMU
>> +	default 0xc0000000 if 32BIT
>>  	default 0xff60000000000000 if 64BIT
> 
> The first default seen with a passing condition is the default chosen,
> right?

Yes, exactly. It's not required for the conditions to all be disjoint.

Regards,
Samuel


