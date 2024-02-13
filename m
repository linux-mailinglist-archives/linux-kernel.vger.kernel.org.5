Return-Path: <linux-kernel+bounces-64545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C50854027
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BEA1C22206
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB3763105;
	Tue, 13 Feb 2024 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Buqv5oDt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrTzMJIu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38B963103
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 23:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867129; cv=none; b=j0OOFETEy+E00MfDrCVN2Y4gD4iZeDH8BBG5ycU34YR2LFuxdLOxLz+hTG2GNUFMFXijR7oFdWreFDmjhOH0HIfCXLYd3a4DCDLAUrKzh2gtdsjjLJtP7HPkByg6xmARlePxIeyzbZ/jnWFntjMs27iVBJpX4LYaw9UfK6M7CHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867129; c=relaxed/simple;
	bh=FXv/Vo1WmMGv7AFSR6AVe33vs054JP6t/z3Pasq2Av4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5QkiBs5PnRElJEGi9lISxV3Fa6QpitQaz2ZhfV92jB4bIcEvNz0/R0GkB53icSDQboN6a1GEVuorEQnK1m6t0xM+d/PKzduyx0FW6ZvYECESK+UCC8XxkFcTRroUYu4LEaBUxJrtg5NtIuyXBNSRZJQCE+JIWyvEuylTN74g7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Buqv5oDt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrTzMJIu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707867125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rU1FgLsKHAJWf7CpAomdWuiPOAofXzn8IOSddAMdtG8=;
	b=Buqv5oDtIzARJ+pHYK5j1F/pjwRYnFB0SQEsFR/fcGXtcPuiNOUur5fkFcXvFmspx24SkH
	7C8cR/Ums7FFjC3axtlc9jT34096Ul3rb4PhooOEQjMJm6k6ayMndGoSUP4Fo9EL2HMH5u
	4N/FQJTSRhwNljeF6x2XEOUwJk5gAoAxtJBTtnRmp+m4b2EqZoLpals+KBjN6XuodJtCMT
	gxZb7PCwPJRK8Rx+DBGonH+MKdUs6LhKAxFqHIL25ZZoKTKdmo/E/IeJjn949ejTXW6zND
	NOJRmP6Kq+lmjKexKpqdsBcVYE10rG3NHTDDPoLMJh+uBsHMPKZi8sEZkjvqcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707867125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rU1FgLsKHAJWf7CpAomdWuiPOAofXzn8IOSddAMdtG8=;
	b=DrTzMJIuT/de4iUpRBFmLXj1J29CdpEOLZz06FYaNFW4L3ep2tEofYYDzdMIyH16hDd4nV
	YCfhqP4307rJO3Dg==
To: Borislav Petkov <bp@alien8.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Wang Wendy <wendy.wang@intel.com>
Subject: Re: [patch V6 01/19] x86/cpu: Provide cpuid_read() et al.
In-Reply-To: <20240213213650.GEZcvg8uvjPXTVhmHv@fat_crate.local>
References: <20240212153109.330805450@linutronix.de>
 <20240212153624.516965279@linutronix.de>
 <20240213213650.GEZcvg8uvjPXTVhmHv@fat_crate.local>
Date: Wed, 14 Feb 2024 00:32:05 +0100
Message-ID: <87v86seya2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13 2024 at 22:36, Borislav Petkov wrote:

> On Tue, Feb 13, 2024 at 10:04:00PM +0100, Thomas Gleixner wrote:
>> +static inline void __cpuid_read(unsigned int leaf, unsigned int subleaf, u32 *regs)
>> +{
>> +	regs[CPUID_EAX] = leaf;
>> +	regs[CPUID_ECX] = subleaf;
>> +	__cpuid(regs, regs + 1, regs + 2, regs + 3);
>
> Yeah, 
>
> 	__cpuid(regs, regs + CPUID_EBX, regs + CPUID_ECX, regs + CPUID_EDX);
>
> explains what those numbers are.

Oops. Sorry, I missed that part of your previous reply and just
responded to the u32 *regs part. I'll send an update tomorrow.

Thanks,

        tglx

