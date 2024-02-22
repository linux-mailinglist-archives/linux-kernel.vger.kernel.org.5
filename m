Return-Path: <linux-kernel+bounces-77391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC09B8604AF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD431F26527
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC7A73F1D;
	Thu, 22 Feb 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrroWcgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJHIQTO+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE073F02
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708637003; cv=none; b=STkcdTGHbZRj6gyLIPW/Gp/JF0igbE5iVgd9yK/sdR5W5sssp3UDczp6AD/Z/sIhhxncsLC1ZZFSbhygL2CHuRMdEe38UxZH7xEauy/x2w+PFwzbvSAB9yHrqOdbvIpQlimJ9gMDPSlrU97X5frHmlWyAxkYFJ+mgsJSjZAvSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708637003; c=relaxed/simple;
	bh=hd/2DrIJNQb2gXbopBHtbShixqqmuNZg+HJ3S0fh/w8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPw+m8hDSdFH9SKvPwL5vetYzC7ZgVcFwGWeXmvrSdppkjqzEDrnWOD8xLVRBLoFrnrIdG1kOqfyjz+NIvGzE0MxIfQPZfDLdF4CYdTeAIxg1KdYzbbxYZ4quiFSukMcHXWvM9il/AuT1p42cP/4WYE6lwFZYcG7OK8lKKBp7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrroWcgS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vJHIQTO+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708637000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIRPIZxG9t+ahGgrtreJ9bofsQ3dY+aVAetq13EaR9Q=;
	b=DrroWcgS6mZp6vRnICkmO6dYyRmb46nuqZEAy8GLs1K78adXZDcBKxiz5BpaZynW5bs6U4
	KJP+V5nUH22Y1hs5MiGC7X7mJSCn7OrWrQE2P1SRa+4vLKYyuPU24KwHYf39Hj8V9gSMmw
	c1Xp0+KBgHKuG/oOtcSqj8wXKDDmWrguAdwOGbsYyq4HpbNX+4+oQG7RuUg1rsK1Fm9nXw
	4wHo8JP0qUQAHemiQYp9StBKkPplSI3CEQUChkTlS0ZzzQD5drCXkHLCgE1nGzI7gg/9y3
	X3WrFpplJ5QxQYT6HHi3iBCc3JXJ08sqasLYWn/q0/0d1pMaVnnqh/AjoaSAww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708637000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lIRPIZxG9t+ahGgrtreJ9bofsQ3dY+aVAetq13EaR9Q=;
	b=vJHIQTO+7AwFhSVRrMa0bRDXsEfPdU0bL6TvjmjmjpgjeUHmMAqqKajEFlZKPg5v2tSBfo
	TgtDmaYzcUrYdxBw==
To: Raghavendra K T <raghavendra.kt@amd.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org
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
 jon.grimm@amd.com, bharata@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-Reply-To: <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com>
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <15fcf98c-58c5-fa08-2e21-f3b0baf058e6@amd.com> <87zfvtg2mh.ffs@tglx>
 <f1a5fe09-f4bc-0dc5-edda-6b3e690bc0e3@amd.com>
Date: Thu, 22 Feb 2024 22:23:19 +0100
Message-ID: <87ttm0dwhk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 21 2024 at 22:57, Raghavendra K T wrote:
> On 2/21/2024 10:45 PM, Thomas Gleixner wrote:
>> On Wed, Feb 21 2024 at 17:53, Raghavendra K T wrote:
>>> Configuration tested.
>>> a) Base kernel (6.7),
>> 
>> Which scheduling model is the baseline using?
>> 
>
> baseline is also PREEMPT_DYNAMIC with voluntary preemption
>
>>> b) patched with PREEMPT_AUTO voluntary preemption.
>>> c) patched with PREEMPT_DYNAMIC voluntary preemption.

Which RCU variant do you have enabled with a, b, c ?

I.e. PREEMPT_RCU=?

Thanks,

        tglx

