Return-Path: <linux-kernel+bounces-38287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A683BD84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D9BA294A05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E974A1BDD5;
	Thu, 25 Jan 2024 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3mceS/Fu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KR1LFLZC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E11BC5A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175474; cv=none; b=OD4+8c9qrM6q6pzp+liapCzqbn3aF82S1yrsK6oqhpz0GfImks3x75+V50NaxOULiliQerqBQAD36VRDavYhlT9jiFIQeuhneLhmuskeya76atTbs2kopNF0TZRSdsgMITwj491YOkjqPI13xLvv4PBWv90l4Q/r9Hl8NQZ3EBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175474; c=relaxed/simple;
	bh=PBY1HzrCSoOD+JiFNUnQfEDbKKGOkJwBNVfE16bj6ME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i1pWm5uqU1Xbywpv6ixcJ51pWY1nSONugJmMF2/1j/X0rNzuuSnBmLpRmAabldRfm8CxkeXnusQ99GXCvfUtomHTK007qw1Y8I0xFon32ov6v8jqAgFba7292Kh5rptXUeI3xVUNPqwqBvCgIHIxuUh1Mc89RDXFn5lDRvUbx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3mceS/Fu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KR1LFLZC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706175470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBY1HzrCSoOD+JiFNUnQfEDbKKGOkJwBNVfE16bj6ME=;
	b=3mceS/FuYm5i7LZw0+8Uwuap/NnjY9ZUSyPbiJvDsYnqLbmieZT2K3WG39fkPgVjaXLWMG
	hQO+3fAbcSJ38UfvojZpgjDbsv6oMybdlKuGCGkd9U7EEC4n69T3LDUKTF3K+El23k1aZJ
	Ry4WaeCHrT3vCvt33h4CSuL+opI1WQEgAxZSdHvaz3q1s6aFej6tOvWRj7/a1B6TkiP7lX
	s8V5XfMaNPwMqmubQYgMLKqAImkpc8jgMc5sSexh3N94sGIF0VmyZvx813bX7R1HHSMvbm
	JQ3AmBFuDbXc4ArjhZ6Rljm/F2a2lI5nmnrXlN022wDqbk67k4oCBv7MNsQ5XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706175470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBY1HzrCSoOD+JiFNUnQfEDbKKGOkJwBNVfE16bj6ME=;
	b=KR1LFLZCPxYuCATMDriGoIpuF4USzviK7/Jbc9h4ucl7/llQbpA7oyxOWvKQ5ZLd8B/5/v
	ynLPJJAWvEdDDHAw==
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Peng
 Liu <liupeng17@lenovo.com>, Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 08/15] tick: Move tick cancellation up to
 CPUHP_AP_TICK_DYING
In-Reply-To: <20240124170459.24850-9-frederic@kernel.org>
References: <20240124170459.24850-1-frederic@kernel.org>
 <20240124170459.24850-9-frederic@kernel.org>
Date: Thu, 25 Jan 2024 10:37:50 +0100
Message-ID: <87wmrxiwi9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 24 2024 at 18:04, Frederic Weisbecker wrote:

> The tick hrtimer is cancelled right before hrtimers are migrated. This
> is done from the hrtimer subsystem even though it shouldn't know about
> its actual users.
>
> Move instead the tick hrtimer cancellation to the relevant CPU hotplug
> state that aims at centralizing high level tick shutdown operations so
> that the related flow is easy to follow.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

