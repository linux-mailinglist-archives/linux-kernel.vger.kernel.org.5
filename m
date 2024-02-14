Return-Path: <linux-kernel+bounces-65126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ADF854857
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24591B25CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55441AADC;
	Wed, 14 Feb 2024 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lk5MkD+w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weoa5/wF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CF1199BA
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910183; cv=none; b=QTWpzm+pZbKGrgDZHlvOWdQ/KYChbJFWlneKJb73+5tfww7S8UNfFSg/b/16xYKiONTljG7sCw68T2rB4uvo3GEOKdYxei1HCXmMHU+26EdAc5CTWC09Xr3D46XAAHdAMfu7dOx+aSRcexW7czq/T2Rnxagm+G7NhTio3ahJt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910183; c=relaxed/simple;
	bh=f8ggq14jVYuQQrAMubcEH8iyKz3Jg3aj+r85czftW7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WmfaKqoBWpvE3sMbltKBiTx9yHgK+Uh/9mtwGFp6sw7xSJqEpRyjlGxvf2e+/XHdCAn+4XsyD1dqE3LdbpdPYp0dC74YSM1c0HwYEkY22gy1oHjklK31GkSQ2m46158NJKokvwwmuQl5RkGTZ1BjPA8nSoelsBNIPcPjVgB/IpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lk5MkD+w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weoa5/wF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707910179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8s6CHToFBHYnZYfXO7kp5Ap94jmYkYkIJg/kOerPzD8=;
	b=Lk5MkD+wMhus0vMIdV/IQG0l3Qi8Qnq97uWx04fNdmYngnbVD+m+QRNxd7875uccAzy9b4
	3FxttNGVb+Vqt9Zlmj+elYpkUi/VMiSazXZB1tg/lRYeQm+nHK/4e5fcpWhQBrFxY644l1
	AmELuNJ6StMD4l4Nx65ofOm5Vwj3zPyRYPPNzXvWQXtD0fCCfsJ+VRjsNBQyH7+mkDlnLg
	+UjYFdWSbWr+g8OKR6n+bX+vPeilYV6amd1fnQFqVDvC73vHsTFb+UVz4dsWf5KneP7aXy
	gwMQqVhJTK7AlpsmrNx3OjH0nZjXAXfHbFfW5/g6icMdXLaGXiNbxUhyUbHwLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707910179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8s6CHToFBHYnZYfXO7kp5Ap94jmYkYkIJg/kOerPzD8=;
	b=weoa5/wF//9GIHPNbQ+v8nr+cMA2CCtYPaOMDPMvnMXZS91vz+Ue5M4yah/yObX34ACgmA
	ZHgd84BWYNRo0+Bg==
To: Pranav Prasad <pranavpp@google.com>, jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, krossmo@google.com, Pranav Prasad
 <pranavpp@google.com>
Subject: Re: [PATCH v3 1/2] alarmtimer: Add PM notifier to check early for
 imminent alarm
In-Reply-To: <20240214092902.1908443-2-pranavpp@google.com>
References: <20240214092902.1908443-1-pranavpp@google.com>
 <20240214092902.1908443-2-pranavpp@google.com>
Date: Wed, 14 Feb 2024 12:29:38 +0100
Message-ID: <87mss3ffml.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14 2024 at 09:29, Pranav Prasad wrote:
> +static int alarmtimer_pm_callback(struct notifier_block *nb,
> +				  unsigned long mode, void *_unused)
> +{
> +	struct rtc_device *rtc;
> +	ktime_t min, expires;
> +	int type;
> +
> +	switch (mode) {
> +	case PM_SUSPEND_PREPARE:
> +		rtc = alarmtimer_get_rtcdev();
> +		/* If we have no rtcdev, just return */
> +		if (!rtc)
> +			return NOTIFY_DONE;
> +
> +		/* Find the soonest timer to expire */
> +		if (!alarmtimer_get_soonest(&min, &expires, &type))
> +			return NOTIFY_DONE;

Brilliant. Instead of a NULL pointer dereference you decided to add
undefined behaviour this time.

As it survived your "testing" it is obviously correct, right?

I'm tired of your approach to throw stuff at the wall in a hurry and see
what sticks.

Stop this frenzy. Sit down, take your time and do proper engineering
before coming back with this to me.

Thanks,

        tglx


