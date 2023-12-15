Return-Path: <linux-kernel+bounces-588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8E9814350
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01FA91F231EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D281111723;
	Fri, 15 Dec 2023 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iwBKYcOe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9hEZ2LQE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDB111AC;
	Fri, 15 Dec 2023 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702627750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AKmof5pAW7TygmISaKPbmc1WQ+QTmQUNzaEDz3+MJQ=;
	b=iwBKYcOePY/PIKs2unMPsHlz3R+dUDYoLE1figBqNWbfWsOoCzF30QnfsVjQRzxF8T6shR
	w53E318yFG+DcehygZ8me4hJ2eo5+mcoJx6/0Fssn+HFeD/X5V/AeTP8iyk2vDcD7tklK4
	vT9DjjugLCv6bGF1dzUelKDMTucw26MFIxsNwHDwbD/wMk7Jqu+kjKcUzUnO8Z4MdqUEPd
	lHuQ3nMWpwmWSGM3AIsX81J6j185VGswW42GrtI4hjQwtQq1wvyyEYTovwLMZDWILkyCge
	EzRM4+7Z2dQj65xTgpdcbmgJIcnCSioXr3Y+exhXnoiikd6I/knuOqN4ovhTpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702627750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4AKmof5pAW7TygmISaKPbmc1WQ+QTmQUNzaEDz3+MJQ=;
	b=9hEZ2LQEPvY+/KJlITL6lVCiFbwgmlZsjemy/hqdRAb0ph0FMAfUYs+0+o56YKqTHn6yds
	3uNN7p3K4AO0UHBQ==
To: Linus Walleij <linus.walleij@linaro.org>, Luo Jiaxing
 <luojiaxing@huawei.com>, Marc Zyngier <maz@kernel.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Serge Semin
 <Sergey.Semin@baikalelectronics.ru>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, "open list:GPIO SUBSYSTEM"
 <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v1] gpio: dwapb: mask/unmask IRQ when disable/enable it
In-Reply-To: <CACRpkdYHAecm3ygaze80SsXzNMYSA9p+p6JY4BKO2D+vArb-WA@mail.gmail.com>
References: <1606728979-44259-1-git-send-email-luojiaxing@huawei.com>
 <CACRpkdYHAecm3ygaze80SsXzNMYSA9p+p6JY4BKO2D+vArb-WA@mail.gmail.com>
Date: Fri, 15 Dec 2023 09:09:09 +0100
Message-ID: <87fs03opju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Dec 05 2020 at 22:58, Linus Walleij wrote:
> Sorry for top posting but I need the help of the irqchip maintainer
> Marc Z to hash this out.
>
> The mask/unmask/disable/enable semantics is something that
> you need to work with every day to understand right.

The patch is correct.

The irq_enable() callback is required to be a superset of
irq_unmask(). I.e. the core code expects it to do:

  1) Some preparatory work to enable the interrupt line

  2) Unmask the interrupt, which is why the masked state is cleared
     by the core after invoking the irq_enable() callback.

#2 is pretty obvious because if an interrupt chip does not implement the
irq_enable() callback the core defaults to irq_unmask()

Correspondingly the core expects from the irq_disable() callback:

   1) To mask the interrupt

   2) To do some extra work to disable the interrupt line

Same reasoning as above vs. #1 as the core fallback is to invoke the
irq_unmask() callback when the irq_disable() callback is not
implemented.

Thanks,

        tglx

