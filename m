Return-Path: <linux-kernel+bounces-155811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF58AF774
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76404283FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD38D1411F3;
	Tue, 23 Apr 2024 19:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtK8AuyF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmlmHlpc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5A313FD65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713901088; cv=none; b=hScK+mruW8U/S86uL5gQn2wCrraadPauiT64vA6KawGJuyRtr7E6QHlA4mMucOUwU+MC/QKD2pHK9gCPpT1r1ktlgP7FAwMdKgQsayCCs8AQSk1x3AGx9isFLPGEOTQ3uc7NxfuY2XvURf16/XCdXBQwRwANcbQayvWe5JiOD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713901088; c=relaxed/simple;
	bh=+YiCHdAPB572aSbjESH5KP8zB6n7UfdaywX5A5C+gjU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HKW1LR5HOVRuZbJ9kgMPr6F9HGkuv0mpZNQP5eRVQWkGdHG7HfD5ENhT8Pn33ADPB9lfPrzvGyw3P+pLc80bHPLH6D37QFccIdAlS7PCoyWu7Mgo4sr0dsaVPNOUR2SiLfm2WTMz1SLo6qSkVUx/dg2MZRcr0DZahBiGdl5wvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtK8AuyF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmlmHlpc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713901084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YiCHdAPB572aSbjESH5KP8zB6n7UfdaywX5A5C+gjU=;
	b=gtK8AuyF0MZyXAOwSEqKmYMzibxH4g7OpQZKwtxu/8kX4NuCS1Lcjfo3Be/GqMS5AVKEs0
	AYdEabUiSgDtY2/GKZ4wthQWKrh3W3pEK6uOnZf4GF5zuY6EkUHtsLYl4yJciJBNTN3Iad
	tva5Mzt0Kh/omSmDU9ICzhY9GPu2B0blRpLB8AG+z4jKaqbMe+dF8912tGYnnJuIslNA3z
	zmR/jCQ1tnzjFcZ9JgGz0hnYhoX+691vnzh6HHFsVadxv9akkOGVrKEIR1eoMBrpzbYbKy
	ibSUGuOrfWDTY+MFHNkHP4sH0jRho3nntxycLN8VgMMMr8J3OciseN7QRAeuiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713901084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YiCHdAPB572aSbjESH5KP8zB6n7UfdaywX5A5C+gjU=;
	b=gmlmHlpcSoXy3T6hYEd0HvM0k07lqvLFr+LcvJUe5p6Yjml8x3t95Hp7IOl9vjkYyw9PeJ
	gBi55cBNMI01yWAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, John Stultz
 <jstultz@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch V2 20/50] posix-timers: Consolidate timer setup
In-Reply-To: <87le5djng7.fsf@somnus>
References: <87le5djng7.fsf@somnus>
Date: Tue, 23 Apr 2024 21:38:00 +0200
Message-ID: <87v847uaxz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 16 2024 at 18:12, Anna-Maria Behnsen wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
>> hrtimer based and CPU timers have their own way to install the new interval
>> and to reset overrun and signal handling related data.
>>
>> Create a helper function and do the same operation for all variants.
>>
>> This also makes the handling of the interval consistent. It's only stored
>> when the timer is actually armed, i.e. timer->it_value != 0. Before that it
>> was stored unconditionally for posix CPU timers and conditionally for the
>> other posix timers.
>
> Shouldn't we do this similar to the gettime() and set it_interval
> unconditionally?

No. If it_value = 0 then the timer is disarmed, so it_interval is
irrelevant and just should be 0 for sanity sake.

