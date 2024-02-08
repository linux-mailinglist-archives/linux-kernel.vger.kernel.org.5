Return-Path: <linux-kernel+bounces-58357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C16184E520
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3CF1F281B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6A27EF11;
	Thu,  8 Feb 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Zm041nd/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6110D7E57F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410315; cv=none; b=NsW22Ie8SSG4BTExe7D3AimrX4zqSbVPf33u0R5/ENl0w0ZE3yv2rUlqSZiVA572/rJdZnntDKUXdJSwq67vEPtFproCdx5jJRfiL07TQSIb1tyF9xDh+1HEOnXp0d9SOp8U1rmMXaxYiPl2fDtdPxVFaJ7Siv9EOGnN188oNzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410315; c=relaxed/simple;
	bh=9QGLWUnXjOEE0l9GehnJutnkj1I2sx1Pl8YobqZyvs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b37uIYwcUQttzuCXHGNvGNLfKmNPG6X9+38LjYL8IAy0GUxkWU0DetQMbgRzBja5JvJhwsNSvF1qJT4OrpGS4NzwkipncqbzbO6MN/kPddSta18G7SO6+Ol7qrj9NHiUQ4p5yGQM0pj5vEfcufDEe67xt0PquDgf8fyKYLBWsX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Zm041nd/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4101eb5a115so435695e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707410311; x=1708015111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d4jeruN/E/glf3Gv5XyYQqRCOQY8bjJkIw1GYmYaFgo=;
        b=Zm041nd/eXG42xD4I/4j8Ss6FQ4+DxhitSUvJLSg+bVxqWVhvfxYi/6iHjIyMZorRn
         D5PXmU7x7126T36sdR/DdL1K+/cVgYQrlroWGyePWOwn9Q353hlp6w97jsJDohCG2Boy
         GiHERUmFz6qEfXp5riKWdOB4vdnRRhfWyiihZM1BTtPXWhHkysgUNfu9tEwAklJlutV7
         RsMqXDwH8XAbntEMQMyLUbih1emjlXGXcj71qtZkluyIjUmWyYAW5TXPw31Rl8sCR5Ip
         DJ4F37P96ePlaPixeVAeVsf54YTaaCkzsHYrFYNGaK/jXmchwohg2DfLFvKsIyYhXNCX
         7vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410311; x=1708015111;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d4jeruN/E/glf3Gv5XyYQqRCOQY8bjJkIw1GYmYaFgo=;
        b=PXCX2uIv8Id9gGB5y9OZvsXHZvAKziqC2YivBV+TMbofklVh6MwjU1N7QTGxykWXRL
         IZb8uC7uJ2p+tg2kxpwiwNaChnd/WGpUKZq1mqTyfnCcyvCN5z/A0oGvWxTOcDPUMx3S
         nfS5mI0HXJyUCSJNudsmpAnbzr6uOkI0aHk/rvk0JmH23ymTB8ASYW+r89uJG80agUPk
         cM7GHuiHskrpcb+TGB2Hm84nQnZuSRsElcTZ8/4ehxkBEUu0e1Hciz/ulYPn8lcjxZvX
         gg/cwUVt5IS3mHP4Yj+K4j2buLSpLD2Hq9Eb17EjEaZGjZcT3y3TQ7mmQs7BM35fbRaF
         ouPA==
X-Forwarded-Encrypted: i=1; AJvYcCVOWel43nTXXfBQecrdvWKTxOaKcm9J06B5oHjdhxqCWuhK8mr5KzbrTaCyED3xmhPDnFzI+7ImPb0QHfSarEC7sGqCR90H9F0GAqNX
X-Gm-Message-State: AOJu0YySFdBG4xCauGs0BtwAT7KfH3I0egt6p9q+8GEjk6R7K68IHB+M
	+0avB85++Yq6IzIuxWuAov7kchl9t34kroKSn9dx4SB+QOX0b1nXZp9nw26fZQc=
X-Google-Smtp-Source: AGHT+IGeczzJ6ulNuOfDeAkZzD4h/YxsrbGq/4YU7wzrrzqbNExodvuxGuysdztEqknj6gCR0G9FoQ==
X-Received: by 2002:a05:600c:a384:b0:40f:e207:2e4f with SMTP id hn4-20020a05600ca38400b0040fe2072e4fmr5456881wmb.40.1707410311378;
        Thu, 08 Feb 2024 08:38:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPBRrzRZpG0QEm9u8butDqffuNPwzOAmIqysEx6IuG03LHiQbIbH/2HA3gxGXcduMd3NAB5mmYX8nfw324QhgXL+1BbocnqzTv8AwSH9m7Rvdmrts0acZtOW48ZJVqMj1hZ0Pkh1yWIe3HIruqy/jclQt6HcBUh1vBPEPgM4fufkV5qx+mWOqsV8vhWvg1aYi9ZTBBa3tIhk7RSr1QJke/j1XXaDUGM5eGj+YkVFAr8jyuB+Xwos0+fqIYnqRa15Tmfir5gLKg/MaJ5ZANQgZd4Ib7uvTR34TMVNXcqm7zilA8siPkeztgQRu20elP+k0SEBjN54PYNLr1iyg5F+wdThnUvPTHqd1vFihBDQ6MWwuZaXNAvQqCu5RyQSEFOxC/pf3zlX7tNoGG1jXUt+ksYyL19VXp0XtH6Ee7d3LAMw==
Received: from [192.168.50.4] ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id o30-20020a05600c511e00b0040ec8330c8asm2121522wms.39.2024.02.08.08.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 08:38:30 -0800 (PST)
Message-ID: <42b48f52-0d14-4f24-9eeb-38e68558eb8f@tuxon.dev>
Date: Thu, 8 Feb 2024 18:38:29 +0200
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
 <ZcD17mTRnfIaueAW@shikoro> <63e1eabd-a484-48ee-b8db-1e460bce70ab@tuxon.dev>
 <ZcQmoEkv_1PVURrT@shikoro>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <ZcQmoEkv_1PVURrT@shikoro>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 08.02.2024 02:56, Wolfram Sang wrote:
> Hi Claudiu,
> 
> I got more information about SMPCMP now. I had a misunderstanding there.
> According to your patch description, you might have the same
> misunderstanding? Let me quote again:
> 
> ===
> RZ hardware manual are similar on this chapter), at the time of tuning,
> data is captured by the previous and next TAPs and the result is stored in
> the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
> ===
> 
> It is not the previous and next TAP but the previous and next clock
> cycle using the *same* TAP. And the bits in the register describe if
> there was a mismatch in the data bits across these clock cycles.

That's something new for me, it's not described in HW manual (or at least I
haven't found it).

> 
> So, we really want SMPCMP to be 0 because the data should be stable
> across all three clock cycles of the same TAP.

So, it means issues should be somewhere else on my setup.

> 
>> As of my understanding the TAP where cmpngu = 0x0e and cmpngd=0x0e is not
>> considered change point of the input data. For that to happen it would mean
>> that cmpngu != cmpngd.
> 
> I am not sure you can assume that cmpngu != cmpngd is always true for a
> change point. I'd think it is likely often the case. But always? I am
> not convinced. 

That's was my understanding from HW manual and since it fixed my issue I
considered it valid at the point I wrote this statement. Maybe we need to
understand this?

> But I am convinced that if SMPCMP is 0, this is a good
> TAP because it was stable over these clock cycles.
> 
>> From this snapshot, datasheet and our discussions:
>>
>> i=0, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=1, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=2, cmpngu=0000000e, cmpngd=0000000e, smpcmp=000e000e
>> i=3, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> *i=4, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002*
>> *i=5, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff*
>> *i=6, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000*
>> i=7, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=8, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=9, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=10, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> i=11, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>> *i=12, cmpngu=00000000, cmpngd=00000002, smpcmp=00000002*
>> *i=13, cmpngu=00000000, cmpngd=000000ff, smpcmp=000001ff*
>> *i=14, cmpngu=000000ff, cmpngd=00000000, smpcmp=01ff0000*
>> i=15, cmpngu=00000000, cmpngd=00000000, smpcmp=00000000
>>
>> I understand that TAP4,5,6 are change point of the input data and
>> TAP8,0,1,2,3 are candidates for being selected, TAP 1,2 being the best
>> (please correct me if I'm wrong).
> 
> I agree that TAP4-6 are the change point. TAP2 could be a candidate. I
> dunno why SMPCMP is non-zero at i == 2, maybe some glitch due to noise
> on the board?

Hm... it worth considering it...

> 
> I do really wonder why probing failed, though? TAP1 sounds like a good
> choice as well. I mean we consider SMPCMP only if all TAPs are good. So,
> if probing fails, that means that SMPCMP was non-zero all the time?

Yes, that was my finding as well on my setup which leads to this patch.

If we're taking as example the snapshot I dropped here in a previous email,
and do not consider this patch, code at [1] should clear bit for TAP2 in
smpcmp mask because in the 1st round SMPCMP was not zero (but 0x000e000e)
and in the 2nd round it was zero.

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/renesas_sdhi_core.c#L629

> 
> That being said, our code to select the best TAP from SMPCMP is really
> not considering the change point :( It just picks the first one where
> SMPCMP is 0.

Hm... I thought code at [2] selects the TAP in the middle (in the snapshot
I pointed, TAP1).

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/mmc/host/renesas_sdhi_core.c#L656


> We are not checking where the change point is and try to be
> as far away as possible.
> 
>> root@smarc-rzg3s:~# md5sum out test
>> b053723af63801e665959d48cb7bd8e6  out
>> b053723af63801e665959d48cb7bd8e6  test
>>
>> Do yo consider this enough?
> 
> Yes, if done 100 times ;)

This may take a while...

> 
> I hope this mail was helpful?

The tuning procedure it's better understand now. But I'm not sure in which
direction should I dig further... :)

Thank you for details and patience,
Claudiu Beznea

> 
> Thanks and happy hacking,
> 
>    Wolfram
> 

