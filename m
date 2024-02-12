Return-Path: <linux-kernel+bounces-61895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEA8517F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281CF1F231A4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA363C48D;
	Mon, 12 Feb 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sk0chBn7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Du8faCBH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F503C46E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751746; cv=none; b=t/RaL8+w6bM5P2XRYdE/U1S6/Jd4VGNBW+D0q7sEuKtwGVA71TCzJwG2BN4Wm6rZKxd0VC5oPHUs+Io/gu5QVh86IYr5SLwDx7Q7XL1Z3DgWe7z8aeR2EFIZ4zj2C7sBFDUo7WcaKuFa8CE7BrlXj0meYwCP79+F5c64G/DJfC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751746; c=relaxed/simple;
	bh=nrB0gDKCmX4hhmWjOWSE8Yzd5XrmRW9wIK9Swz1F3gY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a68XPdyjzNWgc2kS3sRyyOae5kYlXm8F3uVkcJgeZPN5jZ9eMsVtpgrk3al28KEwSk34AXQDqbvPeQdyzGc72XSvFgjCwdRniZEI3oUA8SnjOJv1rNUMaEz0uuac5d7VIuAvJgoFQ25ARH6Wdzoyt6RC52Xd4tqDn8CflnRl3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sk0chBn7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Du8faCBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707751743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfa+Vc3Opo+abjgP5jdi0ejQEzHaPAQ8vWcobW8B9C0=;
	b=sk0chBn7MhvFWWuDx7lrGGqw4N3jw3BQ3yDzRHTo33oscDHkQS9soRZzdu+AMhYSfFpdqe
	k4AQOIp6eT1+oX4LdzxC6wC/aByQE/Tg/Y3UxszBx5Y6xjjfvYYIZpXeXWIBeKVPawiH+p
	pTwCR7d98Rt9zaqmY5h18aMVNfPCKv4AtcJ5XiDS+tqvp4LphxGl7qR9d9BvzCmmVgZ9EZ
	bs84zPUjlrFj34YndxPZ2GQpvdFeqiAhwJhlbRTaNBNWrlZZEPZhotl5P9o3YpIQ7sctxx
	v+p75tCy3+ji8gP8hxGg1tehpaHaVaF2JTCVY7fJ8zNCB7GjDioK3xYwrChDWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707751743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qfa+Vc3Opo+abjgP5jdi0ejQEzHaPAQ8vWcobW8B9C0=;
	b=Du8faCBHRAe9eFDNxHmF6hsN2yqeRIq46phEXwJhMJoERpYoQ7JiLrFGMcOf/43bTlVPaA
	SlUO+MwYPzb+ZqAA==
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Leonardo Bras <leobras@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch 05/12] timekeeping_notify: use stop_machine_fail when
 appropriate
In-Reply-To: <ZcZFBp2TBSm/RfQi@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.955049547@redhat.com> <87h6ikmqqo.ffs@tglx>
 <ZcN+XM4223HS42LM@tpad> <87zfwbkmi9.ffs@tglx> <ZcZFBp2TBSm/RfQi@tpad>
Date: Mon, 12 Feb 2024 16:29:02 +0100
Message-ID: <87wmr9k8g1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 09 2024 at 12:30, Marcelo Tosatti wrote:
> On Thu, Feb 08, 2024 at 04:23:58PM +0100, Thomas Gleixner wrote:
> So while I understand your point that root can (and should be) 
> able to perform any operations on the system, this interface would 
> be along the lines of:
>
> "I don't want isolated CPUs to be interrupted, but i am not aware of
> which kernel interfaces can result in interruptions to isolated CPUs.
>
> Lets indicate through this cpumask, which the kernel can consult, 
> that we'd like userspace operations to fail, if they were going
> to interrupt an isolated CPU".
>
> Its the kernel that knows which operations might interrupt 
> isolated CPUs, not userspace.

Right, but you cannot just throw a CPU mask in and decide that it will
work for everything.

As I explained to you before, these interfaces cannot be treated in the
same way just because they might end up in a SMP function call.

You are definining a binary all or nothing policy which is the worst
thing you can do, because it prevents any fine grained decision and in
case an interface is needed for a particular operation it requires to
open up the gates for everything. Works for me and scratches my itch are
not really valid engineering principles.

Not to talk about the blind replacement of the SMP function call which
causes inconsistent state as I pointed out to you.

Thanks

        tglx



