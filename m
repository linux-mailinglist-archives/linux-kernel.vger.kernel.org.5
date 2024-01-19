Return-Path: <linux-kernel+bounces-31522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7B832F74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2146287264
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45ABC5789F;
	Fri, 19 Jan 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S9myda9Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6XSVaLBp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDB57881
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 19:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693098; cv=none; b=G1tpsMC+coNyaYmnZWSvhwK0muvtmPHcvtvf6WUKtu4t8h5vdSCNW+6qCiRFQY3phKpLwsclTXNqfYHsTrh6TyAk2OKIujG78JDqCEaPpy2gFuFHrxLehnstS6B27z0Bol0gYGcYsRj3/WWXgk5xtiLz4L1ioKeWE0Ixia8T1FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693098; c=relaxed/simple;
	bh=jPPZFFZi33mDDSUrFYgbZMLWbgZcEuqtjLsvdrEY/mI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Iq3UCy9jqQKgX6Sf1GyHN/x1S+b53a/ydmsFCj9fdg5UMqs9P+uo6mp3F7yq1ZDcpWXeeHK5U4mgG4I8ULil0IydwESXzM9Tz/xIQms5B7I2w1S7AYz+XX9WdxiYmqJrwIbSSiTYh7qyAku6esakPt2TVq2OSFeZaWZWOBk4v9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S9myda9Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6XSVaLBp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705693094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS/Cz7E66dmpGlXTZIlNFvN7PZ3LXC8YHR0LTyz+yfc=;
	b=S9myda9Q4QQKDHAXOgv2l30R0dU7thICuNyHuVLF2/q6Lhrhct6JmttrbPou5M1/fPTc2Z
	0m4el2NCOuf/4Sodvk21XcQfVnqMPuMHgO6HoZuaViQoHlz456i1t0iPZ2LaRUXuT6flkO
	HVi7N8lDGYkKFACvIQoyLExMdx+HuyHw05azzONmZSPR1EpZyKkcDt5flfnZvRvmzYZ1co
	9bIcWE45qlc183XnZyBifDeKfdAxMkRmJpuoispb9YfqegZTnXBFvvC17YT4kfrRadyIXa
	vn8KgekHwwAFVSU19LXFbfwMHdmRgKyg23FcSEsNsuo4ti6CEy50BgkZGac9RQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705693094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CS/Cz7E66dmpGlXTZIlNFvN7PZ3LXC8YHR0LTyz+yfc=;
	b=6XSVaLBporlkLVvcjBqv2dXk+MkOYB9Ka7tFZaRoKGt9VE1MncdixkCZVn4fnjaebs0btv
	cet4xUArA67o0WBA==
To: John Stultz <jstultz@google.com>, Pranav Prasad <pranavpp@google.com>
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org, Kelly Rossmoyer
 <krossmo@google.com>
Subject: Re: [PATCH] alarmtimer: Expose information about next alarm to
 userspace via sysfs
In-Reply-To: <CANDhNCqyugdsais9bzaL8RxTxyBgme4W2ZdfayaS8HbqBHJraw@mail.gmail.com>
References: <20240118181459.1663313-1-pranavpp@google.com>
 <CANDhNCqyugdsais9bzaL8RxTxyBgme4W2ZdfayaS8HbqBHJraw@mail.gmail.com>
Date: Fri, 19 Jan 2024 20:38:13 +0100
Message-ID: <87y1cldsgq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 18 2024 at 14:11, John Stultz wrote:
>   I'm always a bit cautious when exposing stuff to userland,
> particularly if it's potentially racy as you mentioned in your
> description. One thought I had was might adding a similar check
> earlier in the suspend path on the kernel side provide similar benefit
> (without requiring userland changes)?
>
> Basically, if I understand the problem:
> echo mem > /sys/power/state
> <kernel goes through suspending everything>
> alarmtimer_suspend()
>   if (next_alarm < TWO_SECONDS)
>       return -EBUSY;
> <kernel has to resume everything, and all that time was wasted>
>
> So if instead we did:
> echo mem > /sys/power/state
> enter_state()
>    if (alarmtimer_immenent())
>       retrun -EBUSY
>
> So the kernel would come back much faster if the suspend was going to abort.
>
> I suspect you all have considered this already but wanted to
> understand what issues that approach has.

It has the same race issues as the user space readout has as far as I
understand and it's much simpler.

Thanks,

        tglx

