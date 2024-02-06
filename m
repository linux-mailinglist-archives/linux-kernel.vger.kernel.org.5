Return-Path: <linux-kernel+bounces-55025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6C84B683
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F891F24884
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B27130E4A;
	Tue,  6 Feb 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IEdYksGM"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B4F13172D
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707226527; cv=none; b=HFXT2M8FB0nVogADrl0TsAPtLe3apxKM2QiCw4kGx0vDGuAZz9NaG1TBGIQS5+wGCE3FsJjkEyHb9CI+cLYa3MiK/4tgEDEdLEHWwJU/CjbpoUiIaIVdUPd2fviRY8uv6fD0zDjMa2/Pn3JuFvduwfKgqGowIjyZ1bL7MyMaJk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707226527; c=relaxed/simple;
	bh=p+OfDhPTU8aIRp2lfUmD23raHR9/ipQFZjR1AP4X+T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dVsomGUMUMIPFozxA+2XeJe4M1FvlBxS7bBODYjt7HOELdZ2vOI5pyc6SQnAkgoJ/Au9o304r/I9R0EZswBfWwcIPz+K+0daLZcYki+QQG4s/hHPFUC+7pISBsPEyt/IMw+9vIcKHUN1oKOxzRIEZ+tVtINI2X+tbq0k/herTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IEdYksGM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a2a17f3217aso751217166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 05:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707226521; x=1707831321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5OAI6HZF6A+v5DceKhvUJ83Vbu4EddAL1RlnqBsL38=;
        b=IEdYksGMT5Ic6JNTAa9HUeAtlFHOQwMXt+4IwCeRkUB0Ox+95SI0/EEE5X/MoO/Oog
         EbyGt3IdBZJTl3a22AnheJqx98g+0CEpoh6It1qIRbUge6oqIiDzag+jxJ9YMUW8fgG6
         E61fakavFfABPaMImF3ANev60we2ZpDDCcvnugNVdmkdI8CU7vjcNVct5n/VIzyCbDk+
         Oz9XrpDcGV6HS+t2ZrT1jks/ySYLMpzHO/04nFzRMQ0n6vYgHJ8FKLu0tzlK7Qae+RXO
         FpyAV35/wfZ3XlYqmo9L0JzwDqB++5AiysGjOm4lZCl5mZWvDaovuDWNpuRQdWlxrhz+
         NIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707226521; x=1707831321;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5OAI6HZF6A+v5DceKhvUJ83Vbu4EddAL1RlnqBsL38=;
        b=d+t5MVCfxOqlmGeXh3y1FMBlvpqC1rFe04ZpvfqwAIf9IvC2rTtMo9TEso0oH1gsar
         Ho8M+4ZYGZkBREHA4xqJ6HMaq9l9t6m1C474ytgRbeoSN4EhOBSrtQUx27ocbl/4KmFZ
         tq+2XaQoBAR8bh9if5hz3arGlmFylgXdjvO6j54549deckdwk4Ui0ho5L3UUdIysBvYl
         2zGGyG13wCO++fK1jgORC7tp/0z7FYKOaBAcZv0byeZwdF4bYRvUoMrtNsKiL+uPk3Jb
         pjJevjPGGVW5W/GItV39LCRBD80t6T9IrW7+ytIsWzVrJHD/ZTBoDz3w0jZ+5YDpIkeP
         jKoA==
X-Gm-Message-State: AOJu0YzHGQVjHqiAiCwqZI/bJLSxYoZ2XxHkKmmvtGwZ+TdmSPs/PedO
	e4zZ+KBNnZVKGA8z9VVgrEu6vBnJoAvmupRu+NbphdXgM+XKH59tsWsKE6FNf20=
X-Google-Smtp-Source: AGHT+IGDpxmSELvcZc8lP9XjrDzNiupLmVgUEVc1LQ+TuZCV+D30GC/kapRd+9cW+oMBqkGOH7ONEQ==
X-Received: by 2002:a17:906:131a:b0:a38:a2f:c12a with SMTP id w26-20020a170906131a00b00a380a2fc12amr1416268ejb.64.1707226521015;
        Tue, 06 Feb 2024 05:35:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2pysuXszpZ59eYVqN5JgOwGhLbzCxBbBaXC9kx9S3KtKx9H+LCpTt+J8XpyYNIbuPwfRMfQWr1hXVNJyNpJJefKa8v6NH/il0DTzQhYkmNobv5C981hT015F38IMMKaBDJfKA3VCiX0sTwx8ndZ7GoN4zabsKxPh/YjVu4OXyaFJyzSHXBYnAkMw3czvaXA/jTDQf+snUZES+wCy5JyqhvXhYTGNvzr/dSor8TJbhmLp8kYZTNBLrfGN/dFpS5+ES4fMcym2uSLQ5apRleJuAl2T4hsW0JxN4FendLZgZW0BA8FkhinwuMViF+F1gt6mi/SMrZbBTwl+4cC0LWc80rqs1mfZbyW8pgpWkquTg4ijh4TvRznG1p/mQSJk13p91pBLGF+5EvC92SrmY83zbkztS/csybkKLJgPWUWnZDg==
Received: from [192.168.50.4] ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id ig8-20020a1709072e0800b00a3758a1ca48sm1150753ejc.218.2024.02.06.05.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 05:35:20 -0800 (PST)
Message-ID: <63e1eabd-a484-48ee-b8db-1e460bce70ab@tuxon.dev>
Date: Tue, 6 Feb 2024 15:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Fix change point of data handling
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, ulf.hansson@linaro.org,
 yoshihiro.shimoda.uh@renesas.com, masaharu.hayakawa.ry@renesas.com,
 takeshi.saito.xv@renesas.com, linux-mmc@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240205112702.213050-1-claudiu.beznea.uj@bp.renesas.com>
 <ZcDdn2AVz8FIXzak@shikoro> <237bd5c8-184d-4e46-ba66-253e3ef0c895@tuxon.dev>
 <ZcD17mTRnfIaueAW@shikoro>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZcD17mTRnfIaueAW@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 05.02.2024 16:51, Wolfram Sang wrote:
> 
>>> According to my understanding, we should only mark this TAP good if it
>>> is in the range 5-7. I need to double check with Renesas, though.
>>
>> OK, my understanding is that it should be in the middle (beginning being
>> the tap that triggered change point of the input data, end being the next
>> tap with the same ID). This is what I understand from this: "As the width
>> of the input data is 1 (UI), select TAP6 or TAP7 which is
>>
>> *the median* of next TAP3 from TAP3."
> 
> Yes, I agree. With 0x0e, that means TAP1+2+3 are changing points and we
> should be far away from them, like 5-7.

As of my understanding the TAP where cmpngu = 0x0e and cmpngd=0x0e is not
considered change point of the input data. For that to happen it would mean
that cmpngu != cmpngd.

From this snapshot, datasheet and our discussions:

i=0, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=1, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=2, cmpngu=0000000e, cmpngd=0000000e, smpcmp=000e000e
i=3, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
*i=4, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002*
*i=5, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff*
*i=6, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000*
i=7, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=8, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=9, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=10, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
i=11, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
*i=12, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002*
*i=13, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff*
*i=14, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000*
i=15, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000

I understand that TAP4,5,6 are change point of the input data and
TAP8,0,1,2,3 are candidates for being selected, TAP 1,2 being the best
(please correct me if I'm wrong).

> 
> But: I am still waiting for Renesas to answer my questions regarding
> SMPCMP. I'd like to get that first, so we have clear facts then.
> 
>>> Boot failure is one test. Read/write tests should be another, I think.
>>
>> OK, I'll try also read/write. Do you have in mind something particular?
> 
> Nope. Just consistency checks.
> 
>>> Because if we select a bad TAP, bad things might happen later. To reduce
>>> the amount of testing, read/write testing could only be triggered if the
>>> new code path was excecuted?
>>
>> I'm not sure how to trigger that (or maybe I haven't understood your
>> statement...)
> 
> I thought something in the lines of:
> 
> - print out when you needed SMPCMP to select a TAP

On my device (RZ/G3S) that triggered initially "mmc0: tuning execution
failed" at probe, with this patch (when doing read/write tests) I have a
lot of moment when cmpngu == cmpngd and thus the smpcmp bitmask is populated.

With RZ/G3S+rootfs on eMMC and this patch I did the following read/write test:

root@smarc-rzg3s:~# dd if=/dev/random of=out bs=1024 count=1048576
1048576+0 records in
1048576+0 records out
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# dd if=out of=test bs=1024 count=1048576
1048576+0 records in
1048576+0 records out
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~#
root@smarc-rzg3s:~# md5sum out test
b053723af63801e665959d48cb7bd8e6  out
b053723af63801e665959d48cb7bd8e6  test

Do yo consider this enough?

Thank you,
Claudiu Beznea

> - check the log for that printout
> - if (printout) do read_write_tests
> 
> Dunno if that makes sense with your test setup.
> 

