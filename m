Return-Path: <linux-kernel+bounces-72048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B6985AE38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688EC1C217F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E209654F8B;
	Mon, 19 Feb 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nD+lwICU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IShX35FE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71181535C6
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380918; cv=none; b=Nc8zcTyA73/+yQ7ycx2EoRolRLtrSgKQeI3Bo8m3Q0hpBIjww7fVpg+MM2myxtC0zXkcjc2VT93g3htJUgA1cMbLMt54bNgdCyXLcShsFMRIcjjLBAMa/BXEGm4wA3Ixqek7bR/3Czm4ofPcnBoa/iro2Iv2tpRwfkS02k/kQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380918; c=relaxed/simple;
	bh=PQglBkR3rLv47oc/aLGA+N7REgcT5RVpd2W7+0BOZEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGhpE1UB5F+a344NMfRcBINcfgr8bep6Zk47Zx5JoY5ewgB2mgT6S8IHF6MXL3YsjBeqdG4sz7CETwZDc8UJDygjOKWLrlupufX1TgHBhlVJXT3Tgc9X3hdMLkB/WKBDzgBfHdm28NhyQULZE2GftvBLe/C4T2PgpmxOVvHLXag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nD+lwICU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IShX35FE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708380914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12EwYtoovs7N+bPhOenXccMlj0F0605/jt1k8W4RoP4=;
	b=nD+lwICUPrIdUVZIBsvdd179b7ERiQFMYGY7KASvsbo8bU0LDIna7FP3FvQxige9rFMxMf
	yjuivj42XoIwKhLRn26nS/2NI0B3DPBHGAhTwRjgjGwtltmDmab6vsj+a52B069rbggPQb
	uK9ahrEY0VGkzRJumTZkSbUZ2xw3GEZR6f/vVyOcGUUfFngnBxPA8UKGJ2PKHYQQhQVsDh
	90Vc0ccLuHUlCgs+m0poOsehwDKIx75UXQWUdx1FvEe9pE7yIaZxWsmaHbGKXPf9Vno1cc
	QCG5CdNbfs36iZRt0S6D++B90G7S7L0XurB+rS6na1dRfoXdl2faw7lUKNWayQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708380914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=12EwYtoovs7N+bPhOenXccMlj0F0605/jt1k8W4RoP4=;
	b=IShX35FE+WPZy8e7MqjilIjJncIzQ1u3g6z83VWr2VLTWTyqZXah/FlmZfd5jTc8MNr0Zq
	hAzxdo2ySdb+vtCQ==
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>,
 akpm@linux-foundation.org, Petr Mladek <pmladek@suse.com>,
 kernelfans@gmail.com, Liu Song <liusong@linux.alibaba.com>,
 yaoma@linux.alibaba.com
Subject: Re: [PATCHv7 2/2] watchdog/softlockup: report the most frequent
 interrupts
In-Reply-To: <a7dd72c5-ed0a-4270-b3a7-5775037703e4@linux.alibaba.com>
References: <87mss2dkxo.ffs@tglx>
 <a7dd72c5-ed0a-4270-b3a7-5775037703e4@linux.alibaba.com>
Date: Mon, 19 Feb 2024 23:15:13 +0100
Message-ID: <87wmr0hzim.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 19 2024 at 17:12, Bitao Hu wrote:
> On 2024/2/15 19:30, Thomas Gleixner wrote:
>> On Wed, Feb 14 2024 at 10:14, Bitao Hu wrote:
>>> +		for (i = 0; i < NUM_HARDIRQ_REPORT; i++) {
>>> +			if (irq_counts_sorted[i].irq == -1)
>>> +				break;
>>> +
>>> +			desc = irq_to_desc(irq_counts_sorted[i].irq);
>>> +			if (desc && desc->action)
>>> +				printk(KERN_CRIT "\t#%u: %-10u\tirq#%d(%s)\n",
>>> +				       i + 1, irq_counts_sorted[i].counts,
>>> +				       irq_counts_sorted[i].irq, desc->action->name);
>> 
>> You cannot dereference desc->action here:
>> 
>>      1) It can be NULL'ed between check and dereference.
>> 
>>      2) Both 'action' and 'action->name' can be freed in parallel
>> 
>> And no, you cannot take desc->lock here to prevent this. Stop fiddling
>> in the internals of interrupt descriptors.
>
> Thanks for your analysis. However, I have a question. 'action->name'
> cannot be accessed here, and it seems that merely outputting the
> irq number provides insufficient information?

That's what you can access without risk. It's better than nothing, no?

>> and the analysis boils down to:
>> 
>>          u64 cnt, sorted[3] = {};
>>          unsigned int irq, i;
>> 
>>      	for_each_active_irq(irq) {
>>          	cnt = kstat_get_irq_since_snapshot(irq);
>> 
>> 		if (cnt) {
>>                       	for (cnt = (cnt << 32) + irq, i = 0; i < 3; i++) {
>>                  		if (cnt > sorted[i])
>>                          		swap(cnt, sorted[i]);
> Hmm, I think the approach here isn't optimal. If some interrupts
> have the same count, then it effectively results in sorting by the
> irq number. Is my understanding correct?

Sure, but what's the problem? If two interrupts have the same count then
the ordering is pretty much irrelevant, no?

Thanks,

        tglx

