Return-Path: <linux-kernel+bounces-38658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A9383C3C1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058A81C237A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748F55C36;
	Thu, 25 Jan 2024 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KU6f/2uy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jV7+hHCL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1C55C07;
	Thu, 25 Jan 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189691; cv=none; b=iZWrAwnh8JFS8ksoOB1LNYKAccCv02lEF0eqQsVv669lGUnVLEJxzrgjyC1KfLTVOIM4iOAdTvSdFXO5XA5wDM3/p8EJwUysryCGNqQhIJc8F7CKapW1jaJ2JIPG8gpEcaDxtz/tuq9xOOBcrxo1JxYsuhR5oyQgBDEeFY0t2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189691; c=relaxed/simple;
	bh=fodR/wINVlR/J76ojNUVdVoAQKjYqindKu3aLYvmAQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KkNHgoRWrLNnkFbwrbMhbMO8ONgHnjNvChq9l7u/80KKfo3wTUJCcXwKE6uTaTvHCPdlkBJdRwR12fJkimtR3fwDafXryX8r0UVFT7EcWFwD3U6nFU8zU2446m4oS9iPuaLiXEj8A7kjAxbsWUdfbC4dWx8Y0N8TUHH6PjMeKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KU6f/2uy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jV7+hHCL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706189688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fodR/wINVlR/J76ojNUVdVoAQKjYqindKu3aLYvmAQE=;
	b=KU6f/2uyUXAUz+h3s3pzDn1XEn+eXpn90a2OkdCm80BAy9R8NZbDulD0vKUYbpAawnZroV
	YS8Ft2RGpcCqI1+9kZniuiWa03AXNVG/aaxTZREMeK20fvuBjwiogZDQrTADUVRh8664ex
	qOYV5F2Xl2OTl0DBE7WNHmdy0T6/7r77jtaqSNRqrEDBVQQ1ZHO/ai9+zYr4EHppUXd56D
	eBQe2VTUlgesOW4puavhdVuHjAtabWAwSVOITklvHsp67ovn31h1xfGCun1gw0oWTCo4FI
	YhF4o/jYOQXl09tb1q3heof8RN07k3Ff53x1GIB2fWaPtKaAKJ/XiAb5ZO/leQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706189688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fodR/wINVlR/J76ojNUVdVoAQKjYqindKu3aLYvmAQE=;
	b=jV7+hHCLc99hIZ63WCMbdZMBFzVMNrTFbamWq4pZfZesYTsw0CyCHk0jXsLit6VG+ZNFPH
	K59kafS6CNlQA/DA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar
 <mingo@kernel.org>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Clemens Ladisch
 <clemens@ladisch.de>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/8] include/hrtimers: Move hrtimer base related
 definitions into hrtimer_defs
In-Reply-To: <87h6j1d2ol.fsf@somnus>
References: <20240123164702.55612-1-anna-maria@linutronix.de>
 <20240123164702.55612-2-anna-maria@linutronix.de> <87plxpkesh.ffs@tglx>
 <87h6j1d2ol.fsf@somnus>
Date: Thu, 25 Jan 2024 14:34:47 +0100
Message-ID: <87wmrxh6yw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 25 2024 at 13:20, Anna-Maria Behnsen wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
>
>> On Tue, Jan 23 2024 at 17:46, Anna-Maria Behnsen wrote:
>>> hrtimer base related struct definitions are part of hrtimers.h as it is
>>> required there. With this, also the struct documentation which is for core
>>> code internal use, is exposed into the general api. To prevent this, all
>>> core internal definitions and the related includes are moved into
>>> hrtimer_defs header file.
>>
>> Shouldn't this simply move to kernel/time/... ? Nothing outside of it
>> needs hrtimer_base
>
> hrtimer_expires_remaining() which is defined in include/hrtimer.h
> dereferences hrtimer_clock_base; hrtimer_is_hres_active() also defined
> in include/hrtimer.h needs hrtimer_base.

Duh, yes.

