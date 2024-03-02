Return-Path: <linux-kernel+bounces-89608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7F486F2A3
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1031C20986
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4117544C6B;
	Sat,  2 Mar 2024 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ewgVKbLY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YirNMqNi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80B40C15;
	Sat,  2 Mar 2024 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709416808; cv=none; b=rpsmsw9UgnKG2wMUOG5t9uVLqVRpauNDONbxtCbPHpEHOegtkx+8+ErwrW4j2Ata0nRDU9zC1gKyDb2y/ttD3ZsPPX0Paw0k9bdqllch9Ax8huVgrB3l3H0oFbB9Bqi/apSD9TU1Y5L2UN75xLQEgZ2ekQu32Ut/dYGqqSvQV9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709416808; c=relaxed/simple;
	bh=zWKT+oNajnMzt9Fl6KPPxH36WSUCatc6JE36hWWiOck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLp4kRlvD3DZGG4wV1oKXU1Xu+6atJpiaLS4G72MxXeI7yS2RloJjNhm83UEbCXc7mhHW4aPXSb7OVkKcKYTMacZsySolbwoPkey3dN2HYWQZHxjlVjT1n3e8mEszcev8GYZcyJZ7HpwsX0BiLXQ7mBSRfDaWB3N1aL4iZ9VSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ewgVKbLY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YirNMqNi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709416804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0/udQZS8D3srIlBNduJy2BLkagOGri68M14lN+zuX8=;
	b=ewgVKbLYVjkNzCylZSIHHDavRx8w3P41dzwEhb5XOLx9mtrAzCOo98bo0EpJ1dyBGjRe42
	iYAfqCnOOHxTWcdXiC4Zx/d6bb0NLM2BBvSw6J7bPG76i1HFFV9U37mmN3zikVta3UCr23
	xcA0svRMG6aJakndl5GwvkBpJVsnAijEjXCicx94vtIFd6MDbAXH2SeCyyuwHD+W0aiGJ6
	N/XG7IEzTvxn8XDGrokM5wZIKigkDtRdCPPn5zLvjGSiyDwlQHLGqe1m3U4qeDs1uDAsl4
	mrtwyQU6noY+03mu4VsI25rQ6AV/05SsnYcP4T7iLBnwkFgQw4xzHIbogundyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709416804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H0/udQZS8D3srIlBNduJy2BLkagOGri68M14lN+zuX8=;
	b=YirNMqNin/MrKqMpeXOCvdk2XeOLGXb3z8Ioh8EqZIQWch31R99UJ0cGa/BKgJtAsW+FRq
	k4ETOoiUkjzOQ2Cg==
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Arjan van
 de Ven <arjan@linux.intel.com>, x86@kernel.org, Luc Van Oostenryck
 <luc.vanoostenryck@gmail.com>, Sparse Mailing-list
 <linux-sparse@vger.kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <87sf18vdsq.ffs@tglx>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
Date: Sat, 02 Mar 2024 23:00:03 +0100
Message-ID: <87le70uwf0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Mar 02 2024 at 16:44, Thomas Gleixner wrote:
> On Sat, Mar 02 2024 at 12:37, Thomas Gleixner wrote:
> The below addresses _all_ percpu related sparse warnings except
> the ones in arch/x86/cpu/bugs.o but that's a sparse problem:
>
>    The following is handled correctly:
>
> 	DECLARE_PER_CPU(u64, foo);
> 	this_cpu_read(foo);
>
>    But this is not:
>
> 	DECLARE_PER_CPU(u64, foo);
> 	DEFINE_PER_CPU(u64, foo);
> 	this_cpu_read(foo);
>
> arch/x86/kernel/cpu/bugs.c:71:9: sparse: warning: incorrect type in initializer (different address spaces)
> arch/x86/kernel/cpu/bugs.c:71:9: sparse:    expected void const [noderef] __percpu *__vpp_verify
> arch/x86/kernel/cpu/bugs.c:71:9: sparse:    got unsigned long long *
>
> Commenting out the DEFINE_PER_CPU(u64, x86_spec_ctrl_current) in that
> file makes sparse happy, but that's obviously not a solution :)

Correction. I found the real issue:

DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);

I had commented out both. But the real reason is the EXPORT_SYMBOL,
which obviously wants to be EXPORT_PER_CPU_SYMBOL_GPL...

So sparse was right. Nothing to see here.

Thanks,

        tglx


