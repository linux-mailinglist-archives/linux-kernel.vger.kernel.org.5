Return-Path: <linux-kernel+bounces-87660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE3286D71E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E2D1C21497
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89244F1F8;
	Thu, 29 Feb 2024 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kvuWiw4q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GW4SFNas"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656C200CD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247527; cv=none; b=EQiAd9F8iijtCwPWLxjZNhtoSNt5mGk0bCEkmbLaahI8rKBg6g2z0imrrERhNyVjVHLroQcN/Rv7kDK0Nbbwc4s7UeEseJTeUd1uqzpaUIvFMx993WKAmzHIZmAbOSuzQ/CviBivO9+LdArhdMf1ta08slhZa0HfQldxVS4kTkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247527; c=relaxed/simple;
	bh=YlCMniL2j7m7KOjztaKIUQVdmcVz5qZP8hxOza8LZkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bDVSy8NiuQT3yWdphLDvtkG6Sx3NEva8qCS4AAb2290ZliZeh/K0XeZqZk3cmdid9DI7iyEnMv8aOw4YoXz5cRPq99B7fFvwtud9pRXGqdbhuZb6qDDgDvOPdBoDJD5DD5EEG4k6qM9C9EQAY1mmrLoH5zNdg6fYyRVHSU7L+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kvuWiw4q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GW4SFNas; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709247522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsiEVeHV2nzMqVhTv3+HEYSQm7pTE35hi32YQp8T3KY=;
	b=kvuWiw4qLXP7cwRcLu3czY4bgveZB7KBdhHbwHtDaHIN+eAszfvAOtfd1wUK3czoH5cHXE
	FaxG6xRP51gNlMyTGu3Q2BCuFFUShImadjccCIfDKHKL9sUZvkkccra26jZcawZStaJF8z
	rbE4Cuq2lc19dM00Rbb7r9KEoJNcMSt9f4CVFM1TSktvfwtYnf8oWV9qiVDtRg3gbdmg/u
	xV4IZyj4s8useSGdJT9f3RO+PufUEBK2n5a0wCwZIG+fI/UP2Eruc3pbqtSi0+CU0wOYzS
	nA/5TqymmMarVF8qDmdhPJRbpRgvguxxzM3EKy/pYEMcsRD9EwPD+E2vgfZJkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709247522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xsiEVeHV2nzMqVhTv3+HEYSQm7pTE35hi32YQp8T3KY=;
	b=GW4SFNas9Mhmd3gUQh4OvqNQCAwwn44yFKG9BMwAEiDccUbSoU3UfPAJrDZ0e4ZBhZBklB
	I81BroEKVFnGPKAw==
To: Breno Leitao <leitao@debian.org>, peterz@infradead.org, bp@alien8.de
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Vincent
 Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>
Subject: Re: general protection fault, probably for non-canonical address in
 pick_next_task_fair()
In-Reply-To: <ZeCo7STWxq+oyN2U@gmail.com>
References: <ZeCo7STWxq+oyN2U@gmail.com>
Date: Thu, 29 Feb 2024 23:58:42 +0100
Message-ID: <87msri7u8t.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 29 2024 at 07:55, Breno Leitao wrote:
> I've been running some stress test using stress-ng with a kernel with some
> debug options enabled, such as KASAN and friends (See the config below).
>
> I saw it in rc4 and the decode instructions are a bit off (as it is here
> also - search for mavabs in dmesg below and you will find something as `(bad)`,
> so I though it was a machine issue. But now I see it again, and I am sharing
> for awareness.

The (bad) is after the faulting instruction, but gives an hint:

  2e:	0f 84 67 ff ff ff    	je     0xffffffffffffff9b
  34:	48 89 ef             	mov    %rbp,%rdi
  37:	e8 cf 70 76 00       	call   0x76710b
  3c:	e9                   	.byte 0xe9

That's an invalid opcode, which means that memory is corrupted.

Thanks,

        tglx

