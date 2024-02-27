Return-Path: <linux-kernel+bounces-83384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1424869704
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A432D285C87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4384140391;
	Tue, 27 Feb 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fF2e2YxH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C49F78B61
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043444; cv=none; b=Jd7cTeD5Jssq5D+jwh//5+/GcxWQPsxZC+mTMuTNvCLhKPKKdX4vZp3F4joqN2uYLJ4fcc2N7xf+2Uy9M97+zcOs4RT12zTX6oAhiWmc45nmRXTyPUqNna/+yf/lwC6HZ6yy2ilIAdUslvjvZW6XEyp8a/pW1ah6hXp2yPubIJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043444; c=relaxed/simple;
	bh=dq3i5pWfZkS0+3JsHg2pVYG9X0QcZK6R4hXzTpTTz60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBYpb4SarzW24fqMrvXtPd5Gl8PSP2tAV7yRbFsi/XrzFkwiH9O9qh/6Ls0Is7et+4QM/VJrXZbVjnuLi1iB2P5gFXOCdzZMiYsXlSipzrlnTVA0FA0Sq35Fghd7pJXaQxkpXINdCFLHtkx2+YqFWaV6xMwOZFi5uGbPvCukn4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fF2e2YxH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e48eef8be5so2956081b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043442; x=1709648242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Rpqdky+ymjmxcqq01R5Avd+XHCiDpwZB+urDPB52CfQ=;
        b=fF2e2YxHrfFoP78pjok+wDtIwbZ9rx7X0bW7iTP5keVWMOBnIns9y1vr+9JP7TuJ4P
         hOmF0yIRSeLI8mwM5nRZ5gndz1/JMHbcxwzVvF95xanxdYpEyFr5y00X/M78KkGr5h6t
         wG1LjomBrxoK68YJ5w9QRCYW4ycDUunWiHEdh6ltkWVnlp24QN+oTfu492juyUlvq+3A
         6GiVcFTZOB/N9jmc8djq6I1HddNt7gR0bLnnGyP+De7Ygkcusr05y4NqovNoRVzwJTMD
         ufGjOcIT3jpD+BLo95l2oKwbNu0/sD5hKrIB6w8ELZFgFW7swYwVFP2nqpT9QNO73zbd
         YXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043442; x=1709648242;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rpqdky+ymjmxcqq01R5Avd+XHCiDpwZB+urDPB52CfQ=;
        b=My/lffG3Bgdih+1aWKy93QJGrmQm8CNc4jklfER3i+8uX94XYuluI1NkgO8QM6FU/g
         1ajv/ns/fqfQ972iYbtkCixmBisJvpcWXEFsoZoeQ0vzRhlZjguExvwB1gz+8S+Xq1Bc
         YOVmEAsBa4HPZ/i/JJu6i+K1UIqiGMkfzpwFcxqvY4oKb6empOq3aASOukjHvweMecHA
         rZLdX7tzzo+Js7W4kbYviSDJxyB8zCrqYzHDZ79DjBTBvNi0+OcX+IVeVslmyg6ifAig
         rVCpk4yWlaCRtFn1Eh3Da+wDPXkZnYO/gT2MWRZewMm2OSdE7LcQfX1EzwV22m80Wblb
         SO/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHWbZCrz2/M2NynVKhWELftJn+Ktm6FpV7DbRrs2jqN/HYFOHhLwqtRULmAwv7x8lXokgnO1PIYhGOhq+m2msd/fSzoP0FTiIaL+9T
X-Gm-Message-State: AOJu0Yy3wfOsBtqc4zQA0G/65hyLpOASY2oClH9+aaJ9bwQrmZGiRfKn
	DpuePhIBH20UzLLaNeY1ZeQAAULdc5uJD43/MB3Zxxy/MNNI0dE0/MSPnpnm
X-Google-Smtp-Source: AGHT+IG1v7ceazyU18i+/2jChnvhggqiuo8ODduGjqD2vinuS/E/Ez45WCZqTO4TcXVxa0gTdAyXsA==
X-Received: by 2002:a05:6a00:99b:b0:6e5:345a:dcaf with SMTP id u27-20020a056a00099b00b006e5345adcafmr6063934pfg.14.1709043442502;
        Tue, 27 Feb 2024 06:17:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gu5-20020a056a004e4500b006e31f615af6sm6141005pfb.17.2024.02.27.06.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 06:17:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8403d8e3-c8ac-476b-8b8e-2c8b6ed8f464@roeck-us.net>
Date: Tue, 27 Feb 2024 06:17:20 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.8-rc6
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
 <6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
 <CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdVYjw9CEBUzxuJ-10wudK_mvJZgqP3gR4kuv-FDYBZ-Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 23:41, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> CC Kees
> 
> On Mon, Feb 26, 2024 at 6:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> stackinit
>> ---------
>>
>> Seen with m68k:q800 emulation.
>>
>>      # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
>>      Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
>> stack fill missed target!? (fill 16 wide, target offset by -12)
>>
>>      # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
>>      Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
>> stack fill missed target!? (fill 16 wide, target offset by -12)
>>
>> Report:
>> https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net/
> 
> I don't think these have ever succeeded before, see
> https://lore.kernel.org/all/CAMuHMdX_g1tbiUL9PUQdqaegrEzCNN3GtbSvSBFYAL4TzvstFg@mail.gmail.com
> 
>> I suspect this may be caused by the test assuming that stack growth is
>> downward, but I don't really understand the test well enough to be sure.
>> I'll disable this set of tests for m68k going forward, so I am not going
>> to report the problem again in the future.
> 
> On m68k, the stack does grow downward.

Sorry, I meant to say upward, but apparently I was wrong.

> AFAIK only parisc has a stack that grows upward.
> 
.. and the tests work there, so that isn't the problem.

As mentioned, I stopped running those tests on m68k.

Thanks,
Guenter


