Return-Path: <linux-kernel+bounces-787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A134814604
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD4681F23544
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E61C2B3;
	Fri, 15 Dec 2023 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jH4uR7W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jEgtJWt9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784591A729;
	Fri, 15 Dec 2023 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702637763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcJ8sEUJ5wj/9ROjAHSdD4NZ0BJCgYAH/QnOMV8p1BM=;
	b=4jH4uR7WEkvi3q9xmp3Pnfz/VZdVGzqrC2Ng0CQcqzJH+ptjFz5IOlXJ2cY3R0E8m02USo
	nWZvqcwY6YYDlpWLFfgGxvn4oZ+Qd532l8y8O7JrR/41lk7o/Psa0XhKWVCeI5pnvTGKB9
	VpUuZLvJlWw6dl4jQuGRqzQQikTGtt7bGTky50xZbdP/4lmgTMQCvvCdFs4q5YGAM6Hkqm
	BwBNsvrL/Q4/sMKASPFoikKwsPcRyLEcVQpb0yljADrCeihjHwQYoZOi+BqLdSWZ48fVAd
	rLDRi+LNSxHFLn28JcPrF4XSmJNYPsd5cDjWMeTI8NKuAYyR2O+C3QonbxTYAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702637763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AcJ8sEUJ5wj/9ROjAHSdD4NZ0BJCgYAH/QnOMV8p1BM=;
	b=jEgtJWt9e5Q0raTT/BlFzFleI+L8MrVj3EijjrRxmXWwtx4MX49POCfWHUlSiTmLEOxbGC
	CmtpR1Dee3bgPbDQ==
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Luo Jiaxing
 <luojiaxing@huawei.com>, Marc Zyngier <maz@kernel.org>, Bartosz
 Golaszewski <bgolaszewski@baylibre.com>, Serge Semin
 <Sergey.Semin@baikalelectronics.ru>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v1] gpio: dwapb: mask/unmask IRQ when disable/enable it
In-Reply-To: <cbgdeksaulqu65nbnz7l4wpuwensllkdlyi5babhpngclze4df@zxetbohgpfvg>
References: <1606728979-44259-1-git-send-email-luojiaxing@huawei.com>
 <CACRpkdYHAecm3ygaze80SsXzNMYSA9p+p6JY4BKO2D+vArb-WA@mail.gmail.com>
 <87fs03opju.ffs@tglx>
 <cbgdeksaulqu65nbnz7l4wpuwensllkdlyi5babhpngclze4df@zxetbohgpfvg>
Date: Fri, 15 Dec 2023 11:56:02 +0100
Message-ID: <87a5qbohtp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 15 2023 at 13:24, Serge Semin wrote:
> On Fri, Dec 15, 2023 at 09:09:09AM +0100, Thomas Gleixner wrote:
>> On Sat, Dec 05 2020 at 22:58, Linus Walleij wrote:
>> > Sorry for top posting but I need the help of the irqchip maintainer
>> > Marc Z to hash this out.
>> >
>> > The mask/unmask/disable/enable semantics is something that
>> > you need to work with every day to understand right.
>> 
>> The patch is correct.
>> 
>> The irq_enable() callback is required to be a superset of
>> irq_unmask(). I.e. the core code expects it to do:
>> 
>>   1) Some preparatory work to enable the interrupt line
>> 
>>   2) Unmask the interrupt, which is why the masked state is cleared
>>      by the core after invoking the irq_enable() callback.
>> 
>> #2 is pretty obvious because if an interrupt chip does not implement the
>> irq_enable() callback the core defaults to irq_unmask()
>> 
>> Correspondingly the core expects from the irq_disable() callback:
>> 
>>    1) To mask the interrupt
>> 
>>    2) To do some extra work to disable the interrupt line
>> 
>> Same reasoning as above vs. #1 as the core fallback is to invoke the
>> irq_unmask() callback when the irq_disable() callback is not
>> implemented.
>
> Just curious. Wouldn't that be more correct/portable for the core to
> call both callbacks when it's required and if both are provided? So
> the supersetness requirement would be no longer applied to the
> IRQ enable/disable callbacks implementation thus avoiding the code
> duplications in the low-level drivers.

We could do that, but there are chips which require atomicity of the
operations (#1/#2). Not sure whether it safes much.

Thanks,

        tglx

