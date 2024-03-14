Return-Path: <linux-kernel+bounces-103408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0913D87BF05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A879B234BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51815548F2;
	Thu, 14 Mar 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gMVq9Xp3"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438D58104
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426918; cv=none; b=tykjdq14VXcyiX3ydoGr9KwX11ZReYV5liIf5pgWl3AjQeoALZ0dxbpROS2BeHGIgEzf7egSd/w8tpqQZvKVGiaTeTQqGTxPg+KDKtF0BRvg8na9YYpculKpKOfU0mB8x/lo3oCTVtWr0T3pIxa4stTbWGhN03EydvoN3Mn/7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426918; c=relaxed/simple;
	bh=ADBh9YibRLgJRYob/1rW3aS+FG3zpqR0Xph5ndKNCAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZLuaLmZDyQxJR+zhVUYkpSxiVd7ItY1Mhr3/HjrRDFs6u9WouBgaRTwVpCsufoOYEWl55BAVfLtCj7VB3Mj1lig63kaHmRKUoKxJQyTbA7AGmqdIS70+R7LYv6CtM27bJOq/PHR7lX2NtKvNQqvJnKD4POgDkpVYz5FBPPokbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gMVq9Xp3; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so1378129a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710426915; x=1711031715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axdW4v18nIUnyQiLKKJXBxP/Lw0GVm9nBviRq+44A7A=;
        b=gMVq9Xp3iIOtVStc1Rk/uReG1wltgabzvEICElpxAXXYAKRd9y4fEn2ND89K4O6ImM
         CWMD8b76N22TwtEl3qgXfUl9iBD+fVYd99gCK90bqu7c4QCd85A0MEK/83G9VEuRQ/eH
         oUKPojfM1dArnOIVIRwLMtUuC5E20XnpBDkQF3N0zKSv9yMuG8RPQ9u6oPPhBhvbKRws
         iyXiJcUwqRC3tFvbBJWjctyVNoQ/5rgO6Cr1klxBEJY82KT6NKcfbjxHjiotpBMAt3ry
         EbexeL7MXJuiPg2xZAJ/sQwCEfaRCAxC3069dwO5UQ8e7Pxi4W3WhXPWO66tm+Mou0kv
         4l9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710426915; x=1711031715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axdW4v18nIUnyQiLKKJXBxP/Lw0GVm9nBviRq+44A7A=;
        b=LPhB7KZxM4xZn7CHSwFLT2ek1AWq8cmNS91z39DvA4zCOitJFqSYFlDlPzHbuIU5/n
         v2QuXo3hM3it/FDpesZatEeFmcAHoQiniU1aQceaS2MjyExwbDgvKGyUKDIJdR9TKQ9U
         rKiuWOluVSzRkkJVDaVDyVqTRn3G1Xr9mOR56hS0lnfUw+Q0MLc2AFcEEBW1PCeLe0QD
         T0nBIYZ2Oxax9ouVAwdtlQ/FRIt3vu5/AmuCB/U/OLgSH1k6PzFzgb9yExXgfs2qlWWq
         jUYuAe0bi1EYOQsJpR6tDSEsi9cp3tQaZRc7OsC67Ph0IL/fe1uhhRtCDll64JSseMKD
         h+lQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Dh3Hi00dWsNbVoPFSox5eM7sfckvKYI7v0nOBEDWRrMSRZeCLiG7ZGaUZQo/fC0cB41watjSa4/izkJTZDd2yquizqHCOYee9S6p
X-Gm-Message-State: AOJu0YzY727knEK68BfiU7x4GHx2/YLo7oDx+2PqNprxH3990JcWczwz
	4zcaM3jgiBzpbgUQMIIWfiya1A8xbnZqIsEVUa1i5ZB8m5BAKdc7G2l2uxVPFqE=
X-Google-Smtp-Source: AGHT+IFSlOL+Ts8Nmv1jHT+0qtRQeIM5wTh5Txsp0n0sk9VCn8HaKd8RKJDlwXgo0lwsxy5YcyQhBQ==
X-Received: by 2002:a05:6402:380b:b0:568:9b13:77fc with SMTP id es11-20020a056402380b00b005689b1377fcmr581261edb.36.1710426914916;
        Thu, 14 Mar 2024 07:35:14 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id y14-20020aa7ccce000000b005653c441a20sm766627edt.34.2024.03.14.07.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:35:14 -0700 (PDT)
Message-ID: <03d20c1a-cbdf-46ec-963f-6c5b8305e5f3@tuxon.dev>
Date: Thu, 14 Mar 2024 16:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Execute atomically the interrupt
 configuration
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linus.walleij@linaro.org, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240307112452.74220-1-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWwbfem71Q9FE40jqHM2pXWJW9u+w-+NKy3OffFkzu5SQ@mail.gmail.com>
 <da48838c-5043-4fff-99aa-2f75f0755609@tuxon.dev>
 <CAMuHMdU6fo0S0FOpvii8gksa=X=2o4BTCQOp2KS5SnErHeXLKg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdU6fo0S0FOpvii8gksa=X=2o4BTCQOp2KS5SnErHeXLKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 14.03.2024 16:31, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Thu, Mar 14, 2024 at 3:11 PM claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
>> On 14.03.2024 15:21, Geert Uytterhoeven wrote:
>>> On Thu, Mar 7, 2024 at 12:25 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Lockdep detects a possible deadlock as listed below. This is because it
>>>> detects the IA55 interrupt controller .irq_eoi() API is called from
>>>> interrupt context while configuration-specific API (e.g., .irq_enable())
>>>> could be called from process context on resume path (by calling
>>>> rzg2l_gpio_irq_restore()). To avoid this, protect the call of
>>>> rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore().
>>>> With this the same approach that is available in __setup_irq() is mimicked
>>>> to pinctrl IRQ resume function.
>>>
>>> You mean __setup_irq() in kernel/irq/manage.c?
>>
>> Yes!
>>
>>> That one uses the raw spinlock methods?
>>
>> Yes! Would you prefer to have raw spinlock here, too?
> 
> Most pin control driver needing protection in an irq_enable
> method use raw spinlock, so I think it makes sense to follow that.

Ok, I'll  update it, thanks!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

