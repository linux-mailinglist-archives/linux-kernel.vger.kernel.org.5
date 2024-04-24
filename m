Return-Path: <linux-kernel+bounces-157378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBCA8B10CC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7F51C230DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EFF16D338;
	Wed, 24 Apr 2024 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hUc+bY7X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cq0zlA4j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700616C86A;
	Wed, 24 Apr 2024 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979186; cv=none; b=hUxkrzs7LdyeZTsPKNJydPXf//5Tfvca1FydAZvQNobnsNVQI4P0G6Nbnxnua2S8HnnemHI2lO+kSy+CSSJwzyGj286g9DOF8cqXebTWvBcNFVD4+z53MqchorYUZlaKLOmQ1XLQ16MK66Cz8G27ORXHjEkdt2357/GHqn3eHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979186; c=relaxed/simple;
	bh=x7Ce+dUogthNuO8t6VNBi8u+MSlVwOVR1CCnQ/MIrsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWU0rlmMgtvKRfTd1dpYd5ZF0/bXuPTrFbD0n2eZ57m8IJ1RM70Tt/sXUHXCckySUVHBdQXLMd1s55UYNIIpuP86dKlkGfuaC/GeZZh1sAmsl5B0jbaseYA9gd62QklvAvjXDIGUo79+F/pA57HHvqomsEcpm2DYfu1TP8tVdTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hUc+bY7X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cq0zlA4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713979182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIgX8hYJKedlWpKZHCISbN03B7+KCkzESKI9X941yRc=;
	b=hUc+bY7XdaUe4i2b4TqKGtx9lDylLSmzldzEvAn8mQPtvdDYs0v5kWtB3Nm+Vu8JpW93Vg
	gGUat+XkI/WTRN1zIU/3ouPh047NwBu6a8uufa1eNllk7BZumEazzM5tJEfP08+VOaHHk0
	b2pSU387zODGqcMMv+7Dzzsy9CkqGTdg/QXNNJZ0r0tSUv6IdVSQgc3oN4/3hciLoDZi0C
	Tjl1UwBQWMlIEHh4VniIZaHY/kzWdUoQUHfQMoPpnK8rB7LOemzTxp5tYcpR4cqsvg3387
	6OY2gH33HcmtgCgw4jQZYeYWASq0HYq41H11rgELbVTmshv6Wz04FMkdsyZcng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713979182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OIgX8hYJKedlWpKZHCISbN03B7+KCkzESKI9X941yRc=;
	b=cq0zlA4jo7geFavqDooN7ZB8M5yDubfi1Jxg4xvuyaqXGVTXw2TP9zlz2YlfTN80nG7xIi
	w1fmOJpSR2WXIxDg==
To: Florian Fainelli <f.fainelli@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com, Tim Ross <tim.ross@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, "open
 list:BROADCOM BMIPS MIPS ARCHITECTURE" <linux-mips@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
In-Reply-To: <f98dffd7-bb1c-4023-9a73-fdf2107160d1@gmail.com>
References: <20240416194343.469318-1-florian.fainelli@broadcom.com>
 <87le55ulw5.ffs@tglx> <958c27b1-26d7-4927-976b-4502f33f31f7@gmail.com>
 <87il09ufl4.ffs@tglx> <f98dffd7-bb1c-4023-9a73-fdf2107160d1@gmail.com>
Date: Wed, 24 Apr 2024 19:19:18 +0200
Message-ID: <87mspiu19l.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 24 2024 at 09:50, Florian Fainelli wrote:
> On 4/22/24 16:45, Thomas Gleixner wrote:
>> On Mon, Apr 22 2024 at 15:26, Florian Fainelli wrote:
>>> On 4/22/24 14:29, Thomas Gleixner wrote:
>>>>> +	if (save)
>>>>> +		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
>>>>
>>>> what's the conditional actually buying you except more complex code?
>>>
>>> Not much this is an optimization that is simple to carry out. There can
>>> be dozens of such L2 interrupt controllers in a given system and the
>>> MMIO accesses start adding up eventually.
>> 
>> I'm impressed by saving ~12 microseconds per one dozen of interrupt
>> controllers on system shutdown :)
>
> I know, right? More seriously are you willing to take that patch, should 
> I write a better justification?

I don't have real objections other than rolling my eyes, but a better
justification would be useful.

