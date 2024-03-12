Return-Path: <linux-kernel+bounces-100239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122718793E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440D01C21015
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C3379DD9;
	Tue, 12 Mar 2024 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRhgamOS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQWs82/o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8E456471
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245681; cv=none; b=e/DP7sK5duoOtfbqsdO2EoDF9kZWiVJXfUD2Ez4hFyskTjDr6XXZwGhYQb3Ucl/kb0B/ae/4bqBACdMtNTYd5Sg3JqgAWAqx0SSIRY234nR4t0C+3Ln/C/qX1PWODzfQf+MBo1eKI0s+GQtZd5HDmts0l3VsI9AtJLd1HhvLYpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245681; c=relaxed/simple;
	bh=bUrvALHjXh34etszRkPzF7BVGeHVSzCgLsjg21KCRPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxcdRufuZ+tDqS4RF3itpoKS7+XCkpSE9mDuRyXt7VMT5CUKrn04N6WugqVFvEJJ75wYDLI2x4ZKiVQvOPUWzdmAg2xG9y5lA/E+TT30cvKyApKLQr8GuBoG8jH5MJFZmEEEH/kbnLn4rcqgz/rCIjksmnQHE9+gjQKKPl24tkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRhgamOS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQWs82/o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710245678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y18eeX/Yx/yH4J1aJ3VViEIStJc/tQ3iaE0+3J4JX7g=;
	b=xRhgamOSDmcrpxbtk/VqIciRgKWBPzFtwjMcBdywFnWCvM9pk4eLv9F+r92obZ6PleJBVb
	I31tNry3LMbmtU56J+YOwg5wN2o3t59GyF/ew02ZQIijnEI7n8UQj2Fi5Ol5cg+X/bbID4
	/iNhJVBh29KTzZK/iMRPglpmcb+TF95nNAoFnHWVrclSq0hLjWA3Jtu7JntecLmeEo4Ir1
	eLqw752oyt02hO8CX74J1Jj5ef20zLN1RVgU23394pP581s765jL5skrAtBV/qYtk05DCE
	v6ze5O90JT3hiK5p1PQ5juT2N3uQIhMbP1ImqpjoXAM9+EizFFVUEUP1lvKb5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710245678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y18eeX/Yx/yH4J1aJ3VViEIStJc/tQ3iaE0+3J4JX7g=;
	b=SQWs82/onNtgNVF1BtyBWyjMp129gVAsojbwlusAoFjEbxPbk0m8R9JJdNk7PeZIEkgzT9
	mO2OB1ZuLOHqMgAA==
To: paulmck@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, Joel Fernandes
 <joel@joelfernandes.org>, linux-kernel@vger.kernel.org,
 peterz@infradead.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
 mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
 bristot@kernel.org, mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 26/30] sched: handle preempt=voluntary under PREEMPT_AUTO
In-Reply-To: <85cba8bd-5d2f-4da2-b4f9-93ae7c6a2a45@paulmck-laptop>
References: <12a20651-5429-43df-88d7-9d01ff6212c6@joelfernandes.org>
 <63380f0a-329c-43df-8e6c-4818de5eb371@paulmck-laptop>
 <d956c2e9-492d-4559-b9f9-400f37f523bf@joelfernandes.org>
 <6054a8e0-eb95-45a3-9901-fe2a31b6fe4e@paulmck-laptop>
 <87plw5pd2x.fsf@oracle.com>
 <e36b84bc-09c4-4b2e-bad0-f72530a9b15e@paulmck-laptop>
 <87wmq9mkx2.fsf@oracle.com>
 <36eef8c5-8ecd-4c90-8851-1c2ab342e2bb@paulmck-laptop>
 <87cys0il7x.fsf@oracle.com>
 <CAHk-=whgp+Az+rR4L3oAnmbpSq7QqUEjJUNRpeeqsJ3O+Z8-QQ@mail.gmail.com>
 <85cba8bd-5d2f-4da2-b4f9-93ae7c6a2a45@paulmck-laptop>
Date: Tue, 12 Mar 2024 13:14:37 +0100
Message-ID: <874jdbpryq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 11 2024 at 17:03, Paul E. McKenney wrote:
> On Mon, Mar 11, 2024 at 01:23:09PM -0700, Linus Torvalds wrote:
>> Because any potential future case is *not* going to be the same
>> cond_resched() that the current case is anyway. It is going to have
>> some very different cause.
>
> Fair enough, and that approach just means that we will be reaching out
> to Ankur and Thomas sooner rather than later if something goes sideways
> latency-wise.  ;-)

You can't make an omelette without breaking eggs.

