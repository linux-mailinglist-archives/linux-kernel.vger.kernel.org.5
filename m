Return-Path: <linux-kernel+bounces-83517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27909869A95
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E050B262E7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517FE146001;
	Tue, 27 Feb 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2SmpFKz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhZEy9ao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FEE145B15;
	Tue, 27 Feb 2024 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048384; cv=none; b=XamJ8lB59RAwwWAOOKMID+Cc+DIZFDbLcG8nT7yvMzgV20pTSrEW2OmotclpxiAUgeLWZhKiVbXIO+qKWZHSjiE20mDj6csJDV7ghYJa2s7ddeEGREGwkWWeyrb+Ap9NdS+tsMGWVGZD0xutiq8CZqE1rqZChF2Loy45VvGsoBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048384; c=relaxed/simple;
	bh=vaOJT+3H/y/38JTvBaPdIy4/VKhioCNN1HHrb3AU4V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PgdVSquSCRXIAaPl6n18oeOqYvf21hkwgRXWF2N/62W+WnP/fWFA6V0LeUQpjU7QdCNjHWRtI9oPRcHQige2oS7EVtw/iUPClMTE0NKBLicTNHUTcs7oAuqpIKyNUZ2Xnh5JHU6oOc550358iN4KZpe5pnwX0aGZxJv3DIvpKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2SmpFKz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhZEy9ao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709048381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJMEmPknjHVafP7auP6NstYIZApeLwl7NpSBBPTsJRw=;
	b=v2SmpFKzyLlxe1n8O3ssVGgCw9zIymjESWdlflsdtoIpFV9ck8Gh8f5Z5p76E0Wov9JppI
	pUympLPPwSdDUxSpTfJZ7W94UZ3YgkntkZcy5VnTvCUWuvfFbRCCoxuQaBrBeBzjhuMh0A
	Rw7TvUa8M14b/KRF/9ToCMGjDVMZctCYp+iRh1bz3RsEcHGvsg2XigCu+1QMJGJ5PvfPUr
	sewGURBL9sdJJp9sgM9RUP1QN6zwl+2XAcqYzpn6j1nMn8nAHbM0iciZY0IbJn4z+SbLyQ
	mO557zUUhekJSYxGLyFzf0mNLWWa7aKV3evVDYSH5Dpnaw3H2Zo5o1ZNfYEYLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709048381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cJMEmPknjHVafP7auP6NstYIZApeLwl7NpSBBPTsJRw=;
	b=IhZEy9ao54ToXTf1lT6k5ns9ArJc7ZXbJm66qT+o+NH7VygNsznWpxxr8KbIgROKCMTqGb
	NHYGdj3aYBjzzZAA==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 liusong@linux.alibaba.com, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv10 3/4] genirq: Avoid summation loops for /proc/interrupts
In-Reply-To: <e78357ae-7b00-446c-b010-3bd770892c9e@linux.alibaba.com>
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-4-yaoma@linux.alibaba.com> <87le769s0w.ffs@tglx>
 <e78357ae-7b00-446c-b010-3bd770892c9e@linux.alibaba.com>
Date: Tue, 27 Feb 2024 16:39:41 +0100
Message-ID: <87a5nlapc2.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 27 2024 at 19:20, Bitao Hu wrote:
> On 2024/2/27 17:26, Thomas Gleixner wrote:
>> 
>> and then let kstat_irqs() and show_interrupts() use it. See?
>
> I have a concern. kstat_irqs() uses for_each_possible_cpu() for
> summation. However, show_interrupts() uses for_each_online_cpu(),
> which means it only outputs interrupt statistics for online cpus.
> If we use for_each_possible_cpu() in show_interrupts() to calculate
> 'any_count', there could be a problem with the following scenario:
> If an interrupt has a count of zero on online cpus but a non-zero
> count on possible cpus, then 'any_count' would not be zero, and the
> statistics for that interrupt would be output, which is not the
> desired behavior for show_interrupts(). Therefore, I think it's not
> good to have kstat_irqs() and show_interrupts() both use the same
> logic. What do you think?

Good point. But you simply can have

unsigned int kstat_irq_desc(struct irq_desc *desc, const struct cpumask *mask)

and hand in the appropriate cpumask, which still shares the code, no?

Thanks,

        tglx

