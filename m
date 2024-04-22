Return-Path: <linux-kernel+bounces-154206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073F8AD946
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F66E1C21583
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAC45BFD;
	Mon, 22 Apr 2024 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SNo8ScRn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8WX9ZE1N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AE244C9C;
	Mon, 22 Apr 2024 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829534; cv=none; b=b5N9UHdvtLTtkFCZlOLX13MAbkYB/0sJ/S6nM3o19MP+6TqKzRH+YyHosu2Dx3hFNoplbmyaT5MunzsclCnXUv9ue8JhWAayeYBELxl2r7LhI7XR7jzZeNItA8xfNSnjGxAeAiIK/JfrPv3qtMr6yMTaWP8hUxl02wD+FQ4Vuuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829534; c=relaxed/simple;
	bh=z3h+VKrcZCpunIZDiKn9M9NtXfM5z6L0iGF/2eYIpDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLtO6L4XR9PFHpTrM2jxzdzHthWDwE0qF+iReF4yZYu91Ea7mkeyXcicrHSPiEGf7rR0wQrSVS5sFsOa0qIBVL60senPA4B6OGTLQpiOdQzkltW1xRPfFlf81BpPYW/RFVVmQ/pKOTkl/pWgwnvuVZwP7fEk37pZ4C3R+lkmWyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SNo8ScRn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8WX9ZE1N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713829531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3iuol9n0ncMFMx3ZU/0KzyHn3TSc5ypZiXe1W2A5oM=;
	b=SNo8ScRn/1GkRdN2RdGq8C0spZlkhHnRirTAe1ms3kV9ohl07WzEzX6H3DoNspRUYM0Ppt
	KfaVYeZA7x29ikRk9pTWR1oE56fQEveBnqlngTBAzDYMo5kk9T5jH2DPgwXMzxc5ZeQFTP
	g7Ld4hXuPNtVSzsC4dg0tnRQ49tgrPE5mCLXjrqQev4D9CJrKrtCXuabH+oYFYV0VVfVOf
	58ClO2hQYBGlfsKDDrpXYndvqWshr7bfyfdbr/tda5zoxwySbSY3Rz1x/a+QheZPGGRkUg
	R7V7UNaOqaQj7+6ZIef0Mme5uGSmAEae7IktutF9gpN7nRcOJra0k7JpgDu85A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713829531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3iuol9n0ncMFMx3ZU/0KzyHn3TSc5ypZiXe1W2A5oM=;
	b=8WX9ZE1N45eKmwx2FOtbDg26c+wW39hf9Ig69BrWHfZpNpLCaNB3vI0A2+vt5SPjIFekcq
	G1TB3/M3SVk0OyCA==
To: Florian Fainelli <f.fainelli@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com, Tim Ross <tim.ross@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, "open
 list:BROADCOM BMIPS MIPS ARCHITECTURE" <linux-mips@vger.kernel.org>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
In-Reply-To: <958c27b1-26d7-4927-976b-4502f33f31f7@gmail.com>
References: <20240416194343.469318-1-florian.fainelli@broadcom.com>
 <87le55ulw5.ffs@tglx> <958c27b1-26d7-4927-976b-4502f33f31f7@gmail.com>
Date: Tue, 23 Apr 2024 01:45:27 +0200
Message-ID: <87il09ufl4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 22 2024 at 15:26, Florian Fainelli wrote:
> On 4/22/24 14:29, Thomas Gleixner wrote:
>>> +	if (save)
>>> +		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
>> 
>> what's the conditional actually buying you except more complex code?
>
> Not much this is an optimization that is simple to carry out. There can 
> be dozens of such L2 interrupt controllers in a given system and the 
> MMIO accesses start adding up eventually.

I'm impressed by saving ~12 microseconds per one dozen of interrupt
controllers on system shutdown :)


