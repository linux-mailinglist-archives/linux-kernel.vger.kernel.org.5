Return-Path: <linux-kernel+bounces-86767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 729EE86CA7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1540B1F22123
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCD086277;
	Thu, 29 Feb 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBWPyWQR"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34615D2;
	Thu, 29 Feb 2024 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709214067; cv=none; b=IgQy2gvnO3kFaTh+IXxch9+JuTaaN3H/mkb2IcIzL7331tMkI6Zj4cfKnGP6KUheeOIbF0an8+fANDxCeeOJ8Vjha5OyTvZ1GvgHZHIhdJN/fGBqjTM/4xtgNDdRRV66VLFs/8R10GSYBKeQQ5lZ5V1W2uMMLgUnjUo0fZXpxoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709214067; c=relaxed/simple;
	bh=6VAu8UJJsMqHGSePHtOlfK1tAHg2zY9bKGEb62JWBWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtKWNeR4FHGJrZTXJML5H57W4wdh8De3Fg/BK1fJhUhGKBh7xC1z9BLoYMhoSmhKeIoaRamGZLXSkF6r8UbDFWemG2soDPHesxPwqw0+HV18dQPkhH2JRvJ0FyYIvoC9poZRcoDH+PW7oGErBC6ru+7Ap7AVOHZAFrOxuqFk1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBWPyWQR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dccb2edc6dso8431785ad.3;
        Thu, 29 Feb 2024 05:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709214065; x=1709818865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3ymsgYG4aBAORTGyfhbOVk60gCsVYdmh6hNoB3rRG24=;
        b=IBWPyWQR5MxgPEVvYDXEK/Gm0tcFN+HzewRSHXguoPLTH4wc+jMEl/fIODS/jI8ryA
         i+FX5XQcXTAegSciPRp8p7ReaAJaeKwYPYQrNYH/id0YMcwJJOBvXU2k+P2PxEFVoOSi
         Edez+BE5BrAWE1pIXrJC/GMZZrx1OqNvVQ5Lr0BiSEX1F+gAzfYVRpkp1hHsUKfbGi8b
         wF8npQByJcmWxZei7XFCIIQ3Sk7EQw8jclJSO0cnok3CtD46jfDYKCmQnDA2FWVELSZn
         Gtgf3Roc5Ixq8/gfslLLV5BM+ygUvJameOxAPGaB8D4JlALHm1b4zPDC9RVqF02lmthR
         J4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709214065; x=1709818865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ymsgYG4aBAORTGyfhbOVk60gCsVYdmh6hNoB3rRG24=;
        b=vwJzeSOquibAKY3OWe0OPkuF7NPAux/5niukqwlah089iwYnV8Ba8DtHXRejhnPupN
         y219snj1HuVl6bRuopk29SuJ64dCReL2Ut+O1jR060oEPwIV3bd33HBx/fyfqyy+LrGY
         Mo34MvVaO2vkVfUI7912LoVzklU3IS7aI6VQRdJWl4pgG+z/I9sqQmwQlJwZ4yRomqeg
         HX8TjpIOC4kIQOLQw6iE5Xa92R77cqGYgf3B7qyjml9i7lyD+REY38b8a8l7QXsTPhdM
         MvyJ/cAyktnLejHsjhIMizK5ZF3KFOOv7veuaqYIFYoEizQujBfiQNPsm9KGUwZETUFC
         q4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUncHPUTwd9d42tro4BP6ANQsw+ZzuyeX3d4TdZWdyvqjKEoOG5xdo3W2JadHqYui89dH6T8zw8EPI04FXYdI6ZLDgZcgVBoisfrmoCx5dYBDhmKconbxxNadqWV/H+KI/WDuea2dbfzAsEvh0=
X-Gm-Message-State: AOJu0YxxqNc6jkNGqJWHfmkrRksewfLcenIB1rnwPe1WW5BiGOuLnTUr
	zFHZawu8U46iSl736HpCb97gN0NBtvtJrn6S1mtmLC3BRrgcFoG07BRa6ir1y2xnUr55PPp/fcd
	K3bF2DEg6kjuDMPCNBvt0teGHaOM=
X-Google-Smtp-Source: AGHT+IHH6ct/gXRfF7LT15aRQ5UzlIPj3NS3TbY30mUKbdta0IP6l2LrkbftasE8JU9OI5rOqnoRCZDzWZwlGhIGARk=
X-Received: by 2002:a17:902:e943:b0:1db:cea0:9d62 with SMTP id
 b3-20020a170902e94300b001dbcea09d62mr2311979pll.9.1709214065209; Thu, 29 Feb
 2024 05:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229093756.129324-1-rand.sec96@gmail.com>
In-Reply-To: <20240229093756.129324-1-rand.sec96@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Thu, 29 Feb 2024 14:40:53 +0100
Message-ID: <CAOiHx==hd09hfzgkthp+BUsTaUFPM0YyJOkPrBOzLL4wz8cQ7w@mail.gmail.com>
Subject: Re: [PATCH] ssb: Fix potential NULL pointer dereference in ssb_device_uevent
To: Rand Deeb <rand.sec96@gmail.com>
Cc: Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	deeb.rand@confident.ru, lvc-project@linuxtesting.org, 
	voskresenski.stanislav@confident.ru
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 29 Feb 2024 at 10:38, Rand Deeb <rand.sec96@gmail.com> wrote:
>
> The ssb_device_uevent function first attempts to convert the 'dev' pointer
> to 'struct ssb_device *'. However, it mistakenly dereferences 'dev' before
> performing the NULL check, potentially leading to a NULL pointer
> dereference if 'dev' is NULL.
>
> To fix this issue, this patch moves the NULL check before dereferencing the
> 'dev' pointer, ensuring that the pointer is valid before attempting to use
> it.

Might be worth pointing out that dev_to_ssb_dev() does dereference
dev, in contrast to most (dev_)to_*_dev() helpers that just calculate
a new pointer from an offset via container_of(), and thus are a-okay
with NULL pointers (but I think this would be UB), or even explicitly
return NULL if the passed dev is NULL.

Though I wonder if dev can even be NULL at this point, or if the NULL
check is actually bogus and could be dropped.

AFAICT the caller of this function would be dev_uevent(), and it does it here:

        /* have the bus specific function add its stuff */
        if (dev->bus && dev->bus->uevent) {
                retval = dev->bus->uevent(dev, env);

which can only be possible if dev is non-NULL.

I can't really tell if uevent_show() would also call this function,
but even that one dereferences dev before calling uevent().

So from a first glance I would think dev is guaranteed to be non-NULL.

> (snip)

Best Regards,
Jonas

