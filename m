Return-Path: <linux-kernel+bounces-103365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D380687BE9C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1181D1C20B89
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1E6CDD7;
	Thu, 14 Mar 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Bm2kzMFt"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D84D9ED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425469; cv=none; b=c9wqclOpQY0+1AnXYDSkdRMVsidAvxwfEqiluqTqEqz1NKFbtgFW/OSLGnynzR661VDnxLmWEMUkUPDszCd/VkoChkSTPHvrjfz/zMdUbEbg0vpNkgCyADpTTNKlzJ+0OB+pfHFCLQg8NykBuaD08jVHB/haoE26Ng0N5b9hISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425469; c=relaxed/simple;
	bh=EP0L4/as9nxE0lKi4we9oY73zQPhQ4YRmDCQOtvHWlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rfXHLz/V0wd7DWqPAA3pUjJTSFqhiO2ECoFyBtnXaulCkyeAKYQl2r58oYk8FnMVLThbF23S7RwM4t3y71rxsU8IDdQg0BqZrdCZB9upE5tj+6JekgdU/fjobtUH2uz9Hi+E1Ze2cnDYcYmGsCmuhlKRMoYdrXr+2bRoMy+H35o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Bm2kzMFt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d23114b19dso10880741fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710425464; x=1711030264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+jPZL+farhsuUuOhDhbQjn1BkC3HvW75LXDKYJuhfZE=;
        b=Bm2kzMFtkeX5MsH0cZFT1Q6A91s6nnffNUuMonwpsHo6jcvtCAvqk+bTZW6iTjmVIz
         I3A8JU08wzPAze+v/oN0To2oa0OHdHvwi4M3gU2Qs4Sl2U12PW2Jkq3zaYbKlneTnn8Z
         T0hoVFwatRr180E2bvXHB+btWsYYE2g0iSzYHGdUkgol5MyruDu/PRXwUFC6n+GImhCU
         uwnMZOqGe7TzvWPd6iBY0p4xV1N3LMG9350qit7ZA4fv2PW1P/6H3tRPEC/F3oaPDPVL
         TAvkgH6v64z96b1GOcRZeBf8j20cDbl0IjYamJkMzolNdDl/z035Ir3XAzTr1qHZbtzu
         8R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425464; x=1711030264;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+jPZL+farhsuUuOhDhbQjn1BkC3HvW75LXDKYJuhfZE=;
        b=uj/Zcw2vfu4Lt5GPDf/mgybMS9cT1wc8mcRA7uNMutFa+p3hxI5YP1gpUcBz5L2mtj
         I0CrDkTnajEp7G4gBufDa5rIf7oDSl0jNp12HTUXnD/bEr4VLaiVp2mubzyAEcZ/w9W1
         FZttOLdLVG8DS+JKASNqBTkV8DkbiDn66NZJKKk7cdZ1VPM1tU3Nk/NLqvRXbDiMylzw
         EI04B5WCX9feSGY+D3Jt7lqNA43iPaj331XLz0dm6OVU1YGBSgIqQVRz4RXSrndIDGXK
         Wh9SZd3V3FJhoO3gavWGtY0F1Zky+bXn0RHPi5wGt/vaxjexFANmtVYgv6zhL+elq5tn
         ICeg==
X-Forwarded-Encrypted: i=1; AJvYcCVMI4fk6FR8AWiZERqEpFKCBXbL90LVxiKEKlCBHh7KLxGXTljL8kwBbSF/YXwzp9D4wkao4fJ9Mfu5/AUXTl8SS+g8pNSYHMvFQzfd
X-Gm-Message-State: AOJu0YzHkVh/dWU2P50LWZOG1cKFIN2OU+fXKt5bHjq6Wq+yrSbZfv7K
	lkw/9SxrRWM03eyQ/P7HnztYQ3CC88FlmHkR/RMGmO7kcQEedRQ2f4PAC2VvS6w=
X-Google-Smtp-Source: AGHT+IHVfiIeAXikc9Ks7N3k/GJ46m7UIH56BHraaOQrJfI3Qn0+cQH3BrQvR/CW4f5cmuQuvMQYqg==
X-Received: by 2002:a2e:a716:0:b0:2d4:727c:94bf with SMTP id s22-20020a2ea716000000b002d4727c94bfmr1206970lje.31.1710425463910;
        Thu, 14 Mar 2024 07:11:03 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7d613000000b005686037bc12sm749129edr.29.2024.03.14.07.11.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 07:11:03 -0700 (PDT)
Message-ID: <da48838c-5043-4fff-99aa-2f75f0755609@tuxon.dev>
Date: Thu, 14 Mar 2024 16:11:02 +0200
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
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWwbfem71Q9FE40jqHM2pXWJW9u+w-+NKy3OffFkzu5SQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 14.03.2024 15:21, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> Thanks for your patch!
> 
> On Thu, Mar 7, 2024 at 12:25 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Lockdep detects a possible deadlock as listed below. This is because it
>> detects the IA55 interrupt controller .irq_eoi() API is called from
>> interrupt context while configuration-specific API (e.g., .irq_enable())
>> could be called from process context on resume path (by calling
>> rzg2l_gpio_irq_restore()). To avoid this, protect the call of
>> rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore().
>> With this the same approach that is available in __setup_irq() is mimicked
>> to pinctrl IRQ resume function.
> 
> You mean __setup_irq() in kernel/irq/manage.c?

Yes!

> That one uses the raw spinlock methods?

Yes! Would you prefer to have raw spinlock here, too?

Thank you,
Claudiu Beznea

> 
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -2063,8 +2063,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
>>                         continue;
>>                 }
>>
>> -               if (!irqd_irq_disabled(data))
>> +               if (!irqd_irq_disabled(data)) {
>> +                       unsigned long flags;
>> +
>> +                       /*
>> +                        * This has to be atomically executed to protect against a concurrent
>> +                        * interrupt.
>> +                        */
>> +                       spin_lock_irqsave(&pctrl->lock, flags);
>>                         rzg2l_gpio_irq_enable(data);
>> +                       spin_unlock_irqrestore(&pctrl->lock, flags);
>> +               }
>>         }
>>  }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

