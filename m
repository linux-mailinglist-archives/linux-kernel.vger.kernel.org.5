Return-Path: <linux-kernel+bounces-71622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FC85A7EA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F10C228250B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC263CF77;
	Mon, 19 Feb 2024 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SFxFmXSp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXGHXZOZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EA3B7A9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708358101; cv=none; b=qlMfRdL1jj0udBMtfTjeM681JRVJJvGIYZx7nFEJnOC1lE0uyjYg5qkJzquo4VhIOSuSAOZCBWJEQZkl/ndPmBJ9PPqWL4iRcej7f0i9ymCuOKdI0VjC/ERy0lAC8fhwH6eGihTq6XVDXTGqMHrIybXUEmeyTgOt2CvbgZXaDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708358101; c=relaxed/simple;
	bh=sDhgfWqSwRQP0W/gjqhUOncvH89HLXRCOuR9itr/o1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HxddxVPKLnsN7RC5xtv1M/4287h74aMxkiBFH8AbGv5Su37t/w+wxsVyBq6mGYxFgDQKMls2xcQUxrLA9xIufHEPAJJPNolTAcMMc985jfQe/2UvqVgEmjxzT1jiXLhpJ1o5XfsaeU4j/P+BV9PRA74MaJnYBXsrqhYn+Hlv1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SFxFmXSp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXGHXZOZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708358098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bEnlqSRlwvlrLkErx0rL1ZZTMmCapG/UfDxG/X7ObI4=;
	b=SFxFmXSpEl7aQTZMNvceDZ7h7/vZS5CR8TSXhAu661r9tggYc97Sq1q87htzcKOGbo6wBo
	NM7SMp/jQVVJYvrraxTbZOgbbgBvvUl0/b9VeVd2O5bc0f7eiZFxY03iNIzDHBIve+WNy7
	yIGS0q6QSEZYKwCv6RK1in+2DT1CmzVqbFym0uPebA60Rz2VODvbYGudBz0lrFL/igoesV
	aDoqVvIt0q4veJ7f7U/ZFyztgd1MEQbwoIpukEWcxtD3HZMbh4Evd85MlsuKL9dKFw2aAy
	QW5t339aBcfqzmtR+7g8NhfCYmLYeBiX11ppqTRofqgI9UUXuFewAdzvLT+47A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708358098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bEnlqSRlwvlrLkErx0rL1ZZTMmCapG/UfDxG/X7ObI4=;
	b=bXGHXZOZwMwVLUqWEUub/FScytsjczBSpZbgvf303K4doHWeBvHmjrd5id/6AnyonDbq0l
	hpHsA3qZZ3vL+eDA==
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, torvalds@linux-foundation.org, paulmck@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com,
 jgross@suse.com, andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, Ankur Arora
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-Reply-To: <draft-87a5o4go5i.ffs@tglx>
References: <draft-87a5o4go5i.ffs@tglx>
Date: Mon, 19 Feb 2024 16:54:58 +0100
Message-ID: <87msrw8n59.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 13 2024 at 20:27, Thomas Gleixner wrote:
> On Mon, Feb 12 2024 at 21:55, Ankur Arora wrote:
>
>> Hi,
>>
>> This series adds a new scheduling model PREEMPT_AUTO, which like
>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> preemption model. However, unlike PREEMPT_DYNAMIC, it doesn't depend
>> on explicit preemption points for the voluntary models.
>>
>> The series is based on Thomas' original proposal which he outlined
>> in [1], [2] and in his PoC [3].
>>
>> An earlier RFC version is at [4].

Aside of the nitpicks from me and Mark this really looks promising!

Thanks for working through this.

       tglx


