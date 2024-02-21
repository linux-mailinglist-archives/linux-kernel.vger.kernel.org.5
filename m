Return-Path: <linux-kernel+bounces-75441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC185E8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D69283A36
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3295A86146;
	Wed, 21 Feb 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kxmP2EBj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuPK7wK6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CB42A8E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708545843; cv=none; b=T6lOthTiNmJzMX1dRsJZLHie0OS+ZxCqkYOd6+9vM492N7E5DcJ+bIyPxNWbds5SU8TUjnhMphlSELpMXSoE5eyZuDVilhL9Gq4FNhyAPIdLqyMuISY1yvNUONT2Nv4lXe66mZQnfwejDHDv16DfPofAZnkC6wiw2+kh6XdGzkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708545843; c=relaxed/simple;
	bh=n8fGNnznHfh77+sx3WW++XnwJfwz6VtbM6RKxG6zHIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KLNPVvpN0AqgtP/fVuUsppa8w2+GYJI92l9eLLs7NJf6J0yWRDXtWQYsNcnxSBRcJZ0sMSSxnOv9crZz7F9wNEZGybeWZ9gGinVsvjI3dTdoA+c2MK5nwhQfLVm96mPpyXxNoEyxVEm9mx5rRxJGIFC3yJ6yiF9I5mc9DcHrrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kxmP2EBj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuPK7wK6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708545839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJV7loMZTRQ0FhjaTpou0/RnFid/HWFLt2zWSAPq0Q0=;
	b=kxmP2EBje1EDqUZzrqw8lKEkIK2TY81EkS7MrcCiYeT1XQ09DOQz8GzxGwC4LnhHvadbH/
	JeLioIeKDtMJqFShP5JBmFHB++fMn9SVxTs+zAsxFu46uOqKaFwT+G98Fdk5ivg2MxALvP
	a9RJr5R/rAh7ZzKyscWFy5AEr9aJDAOBzYOUiGCcNsIbKULoqOi8f/HgYT2LNoLRKoIgjT
	DoqjB5OX41j2eJ0XgPbqJz8bf9bqpyuOYrKlY8HABpybQwlbSDFVR0eox9puk8adeHgBwl
	ojqazFnWHp6O0n719Gv2fDzIuG7/YAd4evdvGvOTSQLyGHbUPARHvAyf0QUOkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708545839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PJV7loMZTRQ0FhjaTpou0/RnFid/HWFLt2zWSAPq0Q0=;
	b=SuPK7wK6zrpRCiRcWfuNzn0f+Mc95S0Z8m4/MX3Rg2vbECjhD+GnKfz1mqMCyoDB9PPcgb
	tBYAns3+EoSTZyCg==
To: Steven Rostedt <rostedt@goodmis.org>, Ankur Arora
 <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, David.Laight@ACULAB.COM,
 richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com, bharata@amd.com,
 raghavendra.kt@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 02/30] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
In-Reply-To: <20240221132651.5d1b0a24@gandalf.local.home>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-3-ankur.a.arora@oracle.com>
 <20240221132651.5d1b0a24@gandalf.local.home>
Date: Wed, 21 Feb 2024 21:03:59 +0100
Message-ID: <87plwpfuts.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 13:26, Steven Rostedt wrote:
> On Mon, 12 Feb 2024 21:55:26 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
>> +/*
>> + * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
>> + *
>> + * With !CONFIG_PREEMPT_AUTO, both tif_resched(NR_now) and tif_resched(NR_lazy)
>> + * reduce to the same value (TIF_NEED_RESCHED) leaving any scheduling behaviour
>> + * unchanged.
>> + */
>> +static inline int tif_resched(resched_t rs)
>> +{
>> +	return TIF_NEED_RESCHED + rs * TIF_NEED_RESCHED_LAZY_OFFSET;
>> +}
>> +
>> +static inline int _tif_resched(resched_t rs)
>> +{
>> +	return 1 << tif_resched(rs);
>> +}
>> +
>
> This may have been mentioned in another thread (don't remember) but please
> make the above __always_inline, as that also matches tif_need_resched() as
> it is today.

It's required as this is used in noinstr sections.

