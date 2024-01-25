Return-Path: <linux-kernel+bounces-38657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D231083C3BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744181F26B64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A35A58226;
	Thu, 25 Jan 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f20jIc0g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mVvRVXEn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974958214
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189650; cv=none; b=gc1l5qxr/0kHRxt4oc5lvYN9W8L5C+KRHtuVreT9bUNkay3YXh1RYlZ4TtL7BNoagce6f11qBcrbf1hBWGjqQ+H83JaQ31ICKdgLIWyFJBwPPF8B7cZKqH5+XVQKZaQQavD4w4zNejD/T3qkWWzfqHoBqmdvusbUTCHTKg70zdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189650; c=relaxed/simple;
	bh=WFLSxR41qxI01BTnGbZrDFaFl3SEY/bnaqmjWh3tbes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d4SC8QHxoD0jPueQaioJXgNp6LTKtLmm/J8mDWG/TOBLBX+EMYeCZN67peYdWh72qU/vJgZz0tA++1ASeSRgH83XNLL9mTmgIShwIl+eAkJQgaN9mGu547tsdCAnT2rl0vczlpEqPimke3rpRu+r6cQwJjkmXTGL/7xYP6tVRc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f20jIc0g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mVvRVXEn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706189647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai6q29s+US5Xx9sEBiO5CtLGzgW8po0CI21s/P9UkFs=;
	b=f20jIc0gIMcE1pW6MwjjeFcFv7RDnmw0NDhat0wSyYGRkCJ3RpuS361QogkHSjWkZkaqI3
	aHOGGmkUWcjWpcC3GCgH3jOnDPlb/kUfAMLezDWYTlGS71+qYsbSmsj8XcP2blbdGs3WDB
	PPxzH2oC1SFNvEC350Jo46Z2MW0rm1Gu+SIiBZEtqRw6/UZxX7o2TDyyt30Ynb53wcGXbB
	YKu/Smdmgx1z5BCUDsqWUEOe0U892blM7Qou5p5XR73q2hFSR7n42KxeJP9OqtTskvMZLa
	3RTfY6nPEygwjVwMPq2KsciPyLsJ6zzFeqO5YBQLQMr4lbaCt4y9b0DFczAPhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706189647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai6q29s+US5Xx9sEBiO5CtLGzgW8po0CI21s/P9UkFs=;
	b=mVvRVXEnWBND3RUw4JqgrG3ahfCVznJbr22FiE91+uf+Gx9xFqlYSSufsMuOGbRMS90LNO
	pvYFuQ+UWUDUuLCg==
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Liu <liupeng17@lenovo.com>,
 Ingo Molnar <mingo@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 01/15] tick/nohz: Remove duplicate between
 tick_nohz_switch_to_nohz() and tick_setup_sched_timer()
In-Reply-To: <ZbJMkautxpj1sQEJ@lothringen>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-2-frederic@kernel.org> <87h6j1kc97.ffs@tglx>
 <ZbJMkautxpj1sQEJ@lothringen>
Date: Thu, 25 Jan 2024 14:34:06 +0100
Message-ID: <87zfwth701.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 25 2024 at 12:57, Frederic Weisbecker wrote:
> On Thu, Jan 25, 2024 at 10:12:20AM +0100, Thomas Gleixner wrote:
>> Adding
>> 
>> #define tick_nohz_highres_handler NULL
>> 
>> for CONFIG_HIGH_RES_TIMERS=n somewhere allows you to write that as:
>> 
>> 	if (IS_ENABLED(CONFIG_HIGH_RES_TIMERS) && mode == NOHZ_MODE_HIGHRES)
>> 		ts->sched_timer.function = tick_nohz_highres_handler;
>
> So the next patch does:
>
> if (mode == NOHZ_MODE_HIGHRES)
>     ts->sched_timer.function = tick_nohz_highres_handler;
>
> Because that condition only happens in CONFIG_HIGH_RES_TIMERS anyway
> and the function field exists in any case.

Right, but the function does not exist for HRES=n, so you need the
#define ... NULL. The IS_ENABLED() allows the compiler to eliminate the
code for HRES=n completely.

Thanks,

        tglx

