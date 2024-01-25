Return-Path: <linux-kernel+bounces-38296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 203DC83BD94
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6C528C6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7011BF38;
	Thu, 25 Jan 2024 09:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vmyyic7S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Po1pHhTR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54331BC22
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175628; cv=none; b=L2TFmWpP91bJ38F6Cy9IupgFNd7X296HtkTikDWNUclJPCqjbm1ePIAUKRKAxEI6UiDbg0E2iqbcNlNRZDLC1BNl4wSHK6PJnu2Sdf3DviPu7QLx8+FQF/9QtaMn13DbYDMVNlzdtK+nAJSjf56Lrv1u2tUkDp/9NnuCjRVAmd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175628; c=relaxed/simple;
	bh=qWekMXGaQK39zDTcL7PmP47XrpVgN69sD1/oaIMhHmM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uaf8LLMtCofxMhqooEUfwzEXdNUsQ7TWalRotKMnBNTMw2G7nNYHkWC4YNr8kTXC+ZVLVxvuxJGdpeY9SrLFNgEVmkyjvegIHkMyKzDbYr/TnSqOK7MBRvkk0gZ92H4MTJghhW/4A4oWOHuHobttxk6l2+GnE8UDO15aTKQNUn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vmyyic7S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Po1pHhTR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWekMXGaQK39zDTcL7PmP47XrpVgN69sD1/oaIMhHmM=;
	b=vmyyic7SmDEZW/soglbW7ZGsbltzjrFewxgZ6sLT5mlGn8Qn7OEQ17BnopeO17QkE2S/5B
	42vYpbnrQjOVYwr0t0YQGXK2N1ry/mRMDEjpobll84RuBPLm44vluGpzhOmlywjeRwxmYv
	6rFq6l1+W1y8rVGDIqxD5oXK2UlXDlrmGgRqUC4q5BJqpVD+OkjUWg9Gq5fbGBJ0plDhDd
	L0+frOsiAlE+2yg0M+aCrgpJ81jofkMTSLhI2QD3D+DTOzqqzTqZPwHRQKS2eNFnLwpINo
	ydqmcDJg0n9KGDSzGBGqU0PkkzfX+IMDiHrMzXlTwV/vmlz83iWS0iUbJbysqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qWekMXGaQK39zDTcL7PmP47XrpVgN69sD1/oaIMhHmM=;
	b=Po1pHhTRqSqmQwXca1mAuEvp78kxfpm21tEcV+BRZlrjjETSTCCQ3TZWhov54R++qz9cjl
	9XmqrO8FWy2Ib/BQ==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 11/15] tick: Move got_idle_tick away from common flags
In-Reply-To: <20240124170459.24850-12-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-12-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:40:24 +0100
Message-ID: <87o7d9iwdz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:
> tick_nohz_idle_got_tick() is called by cpuidle_reflect() within the idle
> loop with interrupts enabled. This function modifies the struct
> tick_sched's bitfield "got_idle_tick". However this bitfield is stored
> within the same mask as other bitfields that can be modified from
> interrupts.
>
> Fortunately so far it looks like the only race that can happen is while
> writing ->got_idle_tick to 0, an interrupt fires and writes the
> ->idle_active field to 0. It's then possible that the interrupted write
> to ->got_idle_tick writes back the old value of ->idle_active back to 1.
>
> However if that happens, the worst possible outcome is that the time
> spent between that interrupt and the upcoming call to
> tick_nohz_idle_exit() is accounted as idle, which is negligible quantity.
>
> Still all the bitfield writes within this struct tick_sched's shadow
> mask should be IRQ-safe. Therefore move this bitfield out to its own
> storage to avoid further suprises.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

