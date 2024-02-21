Return-Path: <linux-kernel+bounces-75164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A911F85E407
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC7B1F25619
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2053783CB9;
	Wed, 21 Feb 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AfHVny/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pxzvz+ch"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181682D7B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708535273; cv=none; b=gaWeC9fGjeNkgCFRj7NBqyPkZhr/a/I7QhH7R/vZ69A61mqJ50IgEKKMi1vhswFJ08ZJDKfA0fLMxHoegrn6SMhxkZ7891qfLGUrZCumLrEBRPRYo9Ofw2itrzPydLM7mdxOXzo2ZIDtmSPrFW2bB62PcKFgVwZb5BKKOfgevtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708535273; c=relaxed/simple;
	bh=fckWMxHLvit0O87HGx/z25o2RsOGqnJm1n3h5O1gbSE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jyq/MrBzAIJFubbnKkyZEZ55oiLLT9h3RLHN8wmsWIy/rkzE7DXihBNPvntYbH7hUzVxfc99/xQqmpJt1yR2Id11yDWBK3fx3YO1kq9PbqKCDMUJ7SqckQDLUTTG/3U0b8PUuMh34yboGzRgKHvmBgUsmVecQPi26wov/FLO1pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AfHVny/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pxzvz+ch; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708535269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZsMDy/jG5/vdDx0X4qnPqXIs7mqMEGPe35pNUZZ6i0=;
	b=AfHVny/onjXAsWtmfUDoqPndvgWxRetZLd3EJex5XYd1EAFtRpusqxKNzpPXX6ZuHHkOBz
	fKNiE8gNoHuUoMrexkhd5mN8L8o9zW1C91U6539pgJjhXAoDl5I28iPYnRFIEAw9F4hd6H
	BRovGJxlux3gVyaUuSz2/gdngUjbOKd/CJRsdMYIz3qNxHQWhUJTYM85/l0aeB07OV7C6Z
	GK8vIBLPvN+EAGejfa4mEYSoj+O9H9lAMuIaXl0TalRDdPmT7UmFMaS0wfcFffdF+RRJI/
	12nH3h/UmCEvLrENBjijfreKQEV2omHQ01JI4AZqDMaQKNmh9vyaQarZP6EzRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708535269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wZsMDy/jG5/vdDx0X4qnPqXIs7mqMEGPe35pNUZZ6i0=;
	b=Pxzvz+chZw3vgn/qnWbDEOWXAebzZqoUN0vzCN2WR2iPi+v8L78eg2UTeelYbD6ELMwn6d
	YDXuc3bJoucVFzDg==
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
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
In-Reply-To: <877ciykc9v.fsf@oracle.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-4-ankur.a.arora@oracle.com>
 <ZczJU8uZdbRKvcAE@FVFF77S0Q05N> <87v86k8opr.ffs@tglx>
 <877ciykc9v.fsf@oracle.com>
Date: Wed, 21 Feb 2024 18:07:49 +0100
Message-ID: <875xyhhhju.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 14:21, Ankur Arora wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>>> static __always_inline bool tif_need_resched_lazy(void)
>>> {
>>> 	return IS_ENABLED(CONFIG_PREEMPT_AUTO) &&
>>> 	        __tif_need_resched(TIF_NEED_RESCHED_LAZY);
>>> }
>>
>> Yes please.
>
> As I wrote to Mark in the sibling subthread, I think exposing
> the lazy variants outside of the scheduler isn't really needed.

But having a proper wrapper inline in the scheduler code (local header)
makes still a lot of sense.

Thanks,

        tglx

