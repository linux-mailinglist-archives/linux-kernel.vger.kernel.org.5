Return-Path: <linux-kernel+bounces-82931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694BA868BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CAAA1C223BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E517913666A;
	Tue, 27 Feb 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VwFNZ9b9"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2C136657
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709025118; cv=none; b=J6NVl4ftRFx18q9BcuBgfBnlCQhCtEUqlZgz12KG033UdnVQHGxg7SWgmUT3V9IYbTDdZC523w9GKG5NOarVAnQdFp8ey1hd/oxFuHjtTUJQZPwV0MJ7FOyMVbZpv1KnVMQurwpQoTWHQlxw4NadCX8ZGTXHnn8LLtcYAky9WCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709025118; c=relaxed/simple;
	bh=oDlesCYRQ+W+skiSLRxgDIQGbf/zMO64VKoY9TJLA2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTQ9Y7Yq3p3nX8fDl1RixS35JVhArLuOoU8GyADN+kBFAn1nEKeDbZgeS9WwpPhZJxlrQwArmHRK7aLzHg4vthnZCwNrX4O7bhA4DGyuhFYz/6VL07U0p7Mihub/V3bHXxaaFXGTtRx306jqdkzj0Kr+k/cthAXLBJOOGmUljEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VwFNZ9b9; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e495e7d697so771087a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 01:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709025115; x=1709629915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iqmg1xIpurv53FgVspQqGn5e7v8oRKUqp2bPRQGCv1w=;
        b=VwFNZ9b91bCyca8XnK+dkWiuaA2T0w8Nk+MGf+tXO2ckt98jsDsxj4IKGAsy7rVJOH
         W9k56OJhT7jW4brzlK5GDLINqHTSmizV1FTqtCKK9GKAXzorn+Y6ZN75ANLJWkcVkYWh
         vC08bZoP09jLCAd7k8Bb6+bTxcl1rB8bEeAgTuWfzODdST8W4laWKVqUjvxC872mi90D
         aopzQJtzi8Lhd6ELCBWMiYjPoUII0FVcu/JkwbSv7rUJxh4YQlUveZRO5qyMGwjqboPR
         Qc/6eWm7XPz5CxawYmQ2HEdLG/t73HWfn5/8OcX6WPqqyaSbiQfZ4DuDC4fQVNBr6zbE
         2mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709025115; x=1709629915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqmg1xIpurv53FgVspQqGn5e7v8oRKUqp2bPRQGCv1w=;
        b=NJQA1gYCN/O/K8sq0Hhins6LfGu3pLGakzCFuW+67tmU/QtLDx88rGYSBdRy2kjUaM
         4Ro4/uLx/4WX9wAsv2ORgtMdg6kODmS7vmVJhNY8N7yMIKIZrFwK9Hbtha9Z3pR/hi6U
         kqfUH4yHSvEMo6zVjFeH4tXgjJVmCV4x9h4PhmwdK/569pdixyHG+Lns/DjHLA+l4t0X
         8DVFyAZrTjwJMfA9UJPCG/TqEW8njTEBIsLy5CxTjc2ERGVaphmzj1mL23oYPhhpFS6y
         pnNzs2cREeVHD+QOECOYa6HcohYRfs8CY2e3o2z/H84psaXc42cyE6GYAhgRuIFd34h+
         RCGg==
X-Forwarded-Encrypted: i=1; AJvYcCV8XVrUDVPkqI+AkiVgWfRpJ89zkfaXO82K3vOqfv2qf/2Jeiqnmikug021VBP6nl16Iuu8Lp0nEzeBxuAn2opa8g0NB93yvqolGMtd
X-Gm-Message-State: AOJu0YwxbQY7dT7DU/9Ns17Qlc8TzNWIrwWlxLEh/Bf4mzKXaixV/nau
	Cw+AxbAv1RW/mQ3k4Dz6t0uYAb2fR/tZdDI2SPC53TAlDgGHQJ2/51D7vJ52oOM=
X-Google-Smtp-Source: AGHT+IHl56rwr930B3wadTCG40VLh8Pqx/IvnBbhnZLNnBMwNU6D0iq/HaPHH32q8T7UEoPk01A0xw==
X-Received: by 2002:a4a:d0d4:0:b0:5a0:3aeb:ae3f with SMTP id u20-20020a4ad0d4000000b005a03aebae3fmr9524072oor.0.1709025115072;
        Tue, 27 Feb 2024 01:11:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:999:a3a0:bf35:904f:7a0e:6c9a? ([2a01:e0a:999:a3a0:bf35:904f:7a0e:6c9a])
        by smtp.gmail.com with ESMTPSA id fa29-20020a056a002d1d00b006e47b5b67d1sm979347pfb.77.2024.02.27.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 01:11:54 -0800 (PST)
Message-ID: <a49546e8-6749-4458-98da-67fd37b7df18@rivosinc.com>
Date: Tue, 27 Feb 2024 10:11:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: deprecate CONFIG_MMU=n
To: Charles Lohr <lohr85@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Samuel Holland <samuel.holland@sifive.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>,
 Andrew Jones <ajones@ventanamicro.com>, Damien Le Moal <dlemoal@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>
References: <20240226140649.293254-1-cleger@rivosinc.com>
 <40dee2c1-ff24-40b2-a13c-6934139ba869@sifive.com>
 <ea356036-5a0b-47ea-aafb-f9813cc6ec9b@rivosinc.com>
 <20240226-pajamas-okay-51e16426b0f5@spud>
 <CAGu26P_v9FjYq9Bncvfd-dBhdHQevvN3HpO1nqjA2hYFCpG7hg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <CAGu26P_v9FjYq9Bncvfd-dBhdHQevvN3HpO1nqjA2hYFCpG7hg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/02/2024 20:00, Charles Lohr wrote:
> WOAH! Please DO NOT deprecate NOMMU. I use the NOMMU build constantly
> and NOMMU Linux on RISC-V is the avenue used by many FPGA soft cores
> for Linux, as well as some limited systems.
> 
> I get new copies of the kernel when there are releases and test them
> frequently to make sure everything is still working as expected.
> 
> For us we just don't care about XIP. I mean if someone did push it
> through to fruition, I'd also test and use it, but I urge you please
> do not deprecate this.  While it's sometimes needed a bit of a
> creative build to get everything working, I've never needed to patch
> anything in the kernel beyond patching in a custom console for serial
> output.
> 

Hey Charles,

No worries, we actually did not expected NOMMU to have *so many* users.
I guess deprecating stuff is a good way to have immediate feedback ;).
Having FDPIC psABI to be merged upstream could also probably be a
positive point toward a better NOMMU support.

> I am happy to discuss the possibility of me and or one of the other
> RISC-V soft (FPGA) core people stepping up to try to be more active,
> but so far we've just been very well serviced by the current NOMMU
> Linux setup.

It could probably be nice to have some feedback/Tested-by: from NOMMU
users for new releases then.

Thanks,

Clément

> 
> Charles
> 
> 
> On Mon, Feb 26, 2024 at 8:03 AM Conor Dooley <conor@kernel.org> wrote:
>>
>> On Mon, Feb 26, 2024 at 04:25:24PM +0100, Clément Léger wrote:
>>> I guess I could also mark XIP as deprecated.
>>
>> I'm not so sure, people recently added XIP support to QEMU (and sent
>> kernel fixes in December). XIP is also not nearly as much of a problem
>> to support, there's far less that it does differently, the main barrier
>> was the inability to test it which is no longer the case.
>> That said, XIP is gonna kill itself off I feel as it does not support
>> runtime patching and therefore is extremely limited on extensions, given
>> we use alternatives for all of that (although I suppose if someone has a
>> usecase they could make nasty macros worse and implement a compiletime
>> switch in the alternatives too).
>>
>> Cheers,
>> Conor.
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

