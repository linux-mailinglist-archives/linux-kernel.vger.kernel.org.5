Return-Path: <linux-kernel+bounces-82768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FA86896F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D281F2465C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AE65380E;
	Tue, 27 Feb 2024 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA4AB5KD"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4680537145;
	Tue, 27 Feb 2024 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017101; cv=none; b=mSZFi8GGeGT/D5tnE0mocV7XmiixRO6NAdPEJWTMdOg6yy5Ui+YJeQmNibC2SKkLvUr3tX0gKONfdpQngJFAO9HImHqz0gMZxJ+OnqMKQ3sp4Th4dXQz4PMGRfQ009WmRqqULBGe+iY2iCh8zUQyLxwityw9Iv4yLdiFkhbN8hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017101; c=relaxed/simple;
	bh=WtF19yLgcWljmZ+iyA1mPaSgemYf7xN//8nTZWsmsII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQ8YAq2wzFZZK0o2XgQb88BMWNlM1DugQa1NGivD91exmyvwTMPjFYWHqwpMH9rNLbngn3tbygtjBM23VZzBYGfwQN6ERQ4VjrXLgcMBtcKbY3FkfVIbZ3rQ5NFnMRLSl63hjV+qZB3kR0hIHC1iOL1KAmyYStM+weFAIQO+tpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA4AB5KD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so595892066b.0;
        Mon, 26 Feb 2024 22:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709017098; x=1709621898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6Wuj7eZKvpR0/h7AmWg9U26NtZOIIFRnTuYstw2M8A=;
        b=LA4AB5KDE4zANvxEIQBcJzeXX5CaaGV4McmZp8a95CJzo+1UPTnOjAuoteqiwzbc+k
         fQehdntBAv5aIwVKTIQ95X2Ag9QCZpl/C3KB2vg51Yf3I1gbilmZT7co1uZVLuhq8pHN
         KpoHThYeMtZLeU5Mg4QqTvfcxRj5QGzrzvi8DZY8loA8DabWRVHklgxX5VKqKjqJC0Ol
         ZHGIzA2IrcOQmAmns8o60TuwD2x7XNqa4BeM9Fx68c/68rV9InIAGiDokV9q5Zr1KTfD
         q4DboF5iaf3uBlgM5/+alYe8BszrAW/rqwA56czeHrhdYMxhHMQMJgEAmTg0jUoQlZQq
         zUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017098; x=1709621898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6Wuj7eZKvpR0/h7AmWg9U26NtZOIIFRnTuYstw2M8A=;
        b=QQC7HHOTFgYjnpZ12eZgFrKGevicpXKa+Kzm1m3cayE0yApm8f/gnLikk3wYu1Z4Db
         7uLY1hmYJxXsgpk+HepZu8rsKe54dqhYqlIeVezagGjMPR6O/OoclyWew+4XRduAymGy
         y7swZHyLsAHBK5WJFXt5vt5af1DmtLWjIDvtZ0f7mKXEjJ+5JV0RrDELy7v4yDKbtuM8
         +3C4un6WeZhqWi+h9T/+cv172aLjszuam8uogzxOZy06qxb5tEU/JP2aUaQJy0eSMwGn
         VvGbjQBOoYvyBIyIFOBr07M9gJY3i8Q8YzMYwd7TBSfUoJDkP+jzMEcahxy6kfRU5X1I
         tDYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAHutBPuki0TRtptzHB5ks28LrxYXKue3WtkDjg3cR3yu1M/VTeR0vMvV6VdThoSJVnqwdajJXAhd+zPQyiLx9A4JIMyHZBPh2X1E9WH0InZjYHMK7Vn5KMgW9wCXU8D06l07cwDN5YQ==
X-Gm-Message-State: AOJu0YwmLByWHK+jr7aL1j/w9CO9aiNMb7FTd9aaH9GYJgu0RI8h5cF/
	1LCPg9mT6yYzhXlcx2xVcHBqqa5KTBGDqxD1X8YTtFBTvhwNx6fL
X-Google-Smtp-Source: AGHT+IGpHfRMSHULnORjFlnpR1xNs3zY8fsQONJ/NXogsHFRrBuYKu2sEJmESEmUMGp1mUYjiifsVQ==
X-Received: by 2002:a17:907:9813:b0:a43:ab6f:ef6b with SMTP id ji19-20020a170907981300b00a43ab6fef6bmr910378ejc.32.1709017098442;
        Mon, 26 Feb 2024 22:58:18 -0800 (PST)
Received: from [192.168.3.110] (IN-84-15-189-254.bitemobile.lt. [84.15.189.254])
        by smtp.gmail.com with ESMTPSA id pw11-20020a17090720ab00b00a3f963c66a8sm454038ejb.121.2024.02.26.22.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:58:18 -0800 (PST)
Message-ID: <3f629079-6809-4cae-bd4d-8b0ee4860196@gmail.com>
Date: Tue, 27 Feb 2024 08:58:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: 74x164: Enable output pins after registers are
 reset
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, u.kleine-koenig@pengutronix.de,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
 <ZdyZnqS_jKelbs6G@smile.fi.intel.com>
From: Arturas Moskvinas <arturas.moskvinas@gmail.com>
In-Reply-To: <ZdyZnqS_jKelbs6G@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 2/26/24 16:01, Andy Shevchenko wrote:
> On Mon, Feb 26, 2024 at 03:46:56PM +0200, Arturas Moskvinas wrote:
>> Move output enabling after chip registers are cleared.
> Does this fix anything? If so, maybe elaborate a bit the potential behavioural
> changes on the real lines.

Chip outputs are enabled[1] before actual reset is performed[2] which 
might cause pin output value to flip flop if previous pin value was set 
to 1 in chip. Change fixes that behavior by making sure chip is fully 
reset before all outputs are enabled.

Flip-flop can be noticed when module is removed and inserted again and 
one of the pins was changed to 1 before removal. 100 microsecond 
flipping is noticeable on oscilloscope (100khz SPI bus).

For a properly reset chip - output is enabled around 100 microseconds 
(on 100khz SPI bus) later during probing process hence should be 
irrelevant behavioral change.

[1] - 
https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L130
[2] - 
https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L150

Arturas Moskvinas

