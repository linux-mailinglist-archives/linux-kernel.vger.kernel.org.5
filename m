Return-Path: <linux-kernel+bounces-71576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1C385A73F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAA6B223F4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74049383A2;
	Mon, 19 Feb 2024 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNFedXtT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g7i+1UYB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6445A37704
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708356067; cv=none; b=MyU4KRoWnO1yW6k6Puszsllx2N76Q176vRj+H/QVteNF9xP1eBSU3wemEZZrQ6DvwkLZaNuWd2YzYJqFMmgr6brSYr0omSEBA0xEe/l1VmAKx/TVny3GKnd3NwpI21E87bBj6VXmb3bM+m5AC/HKDqcy/xFNIjK4g2DNp9hBNH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708356067; c=relaxed/simple;
	bh=SO9EJRPc2OtG7Aa3cZxhtWPvr0nrr4GX1mvW13IYFmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLTRbs/qu1JbrJ1A6qtfdUdydstWCaENGuKMiwFdljZe/8guWhWEHAtJxQJTI2v8DTXTOLDdZZiFfXboI1ncLxO9lBZKdBx/F9nBO59rPQFklDxuidnoC0tML7N4XrHqb/hvesz0RiRHhZwE1BGXgWrLxYdqErGZ6OR4M38MhMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNFedXtT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g7i+1UYB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708356064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRgF3/J0XN5JqGy2f1p48BuFm4HrR7Wm2czCxwJLcQs=;
	b=KNFedXtThPCfebDXZNu8meVtnIB8qcuXnlRiDWFQjvkdEFBWIAEeBD4gDTrCxHKoZ4DgRS
	xKI+uIkqY8F6uUwhgyTEFdkQKlR4+PESsAEH/D2KZBQOcICaEtB2/7j5WlI20hQwt/VCkY
	1MmXEgeobx6yRIQj4lP0suhPILrmrR9AUh3djaYph9oUKUFcJrO7O9xc27s6JMUtMosGNg
	EljGKK4ga4zXgnZHDxMTSOb2oSHw5IRXdXd88Ili7j5ibcYgQoo6+niRjBSBjuLgbW/HKM
	aQ+Tp0mYfq51aSMbuUKLCPevkDOhlutLicCCK1wtK57KQh37zOpM9nDOmpokwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708356064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dRgF3/J0XN5JqGy2f1p48BuFm4HrR7Wm2czCxwJLcQs=;
	b=g7i+1UYB/bPe+pNxkFbhq1JV4LIKQz6KpbFYzjmIstITVC7EMCSyMEiHoHdbiEziFloHP0
	fyjD62PD/kFJAWCw==
To: Mark Rutland <mark.rutland@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, Arnd Bergmann
 <arnd@arndb.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 03/30] thread_info: tif_need_resched() now takes
 resched_t as param
In-Reply-To: <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N>
Date: Mon, 19 Feb 2024 16:21:04 +0100
Message-ID: <87v86k8opr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14 2024 at 14:08, Mark Rutland wrote:
> On Mon, Feb 12, 2024 at 09:55:27PM -0800, Ankur Arora wrote:
>>  
>> -static __always_inline bool tif_need_resched(void)
>> +static __always_inline bool __tif_need_resched(int nr_flag)
>>  {
>> -	return test_bit(TIF_NEED_RESCHED,
>> -			(unsigned long *)(&current_thread_info()->flags));
>> +	return test_bit(nr_flag,
>> +		(unsigned long *)(&current_thread_info()->flags));
>>  }
>>  
>>  #endif /* _ASM_GENERIC_BITOPS_INSTRUMENTED_NON_ATOMIC_H */
>>  
>> +static __always_inline bool tif_need_resched(resched_t rs)
>> +{
>> +	/*
>> +	 * With !PREEMPT_AUTO tif_need_resched(NR_lazy) is defined
>> +	 * as TIF_NEED_RESCHED (the TIF_NEED_RESCHED_LAZY flag is not
>> +	 * defined). Return false in that case.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) || rs == NR_now)
>> +		return __tif_need_resched(tif_resched(rs));
>> +	else
>> +		return false;
>> +}
>
> As above, I think this would be a bit simpler/clearer if we did:
>
> static __always_inline bool tif_need_resched_now(void)
> {
> 	return __tif_need_resched(TIF_NEED_RESCHED);
> }
>
> static __always_inline bool tif_need_resched_lazy(void)
> {
> 	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
> 	        __tif_need_resched(TIF_NEED_RESCHED_LAZY);
> }

Yes please.

