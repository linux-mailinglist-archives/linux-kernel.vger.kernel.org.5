Return-Path: <linux-kernel+bounces-155273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C798AE7F9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821B8B27B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1A135A6D;
	Tue, 23 Apr 2024 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4XzY5FC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fEUVoteP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F099713540B;
	Tue, 23 Apr 2024 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713878527; cv=none; b=mAC2wKdyYX37LQ9ygKfIGDrt7YMXSjQ6aD+RJixSsb4XoJciQbCfDoS48aY53HjAYX1MZZBLjlRwcr2bNtHk3jvll/YWup3eIUtHPpCmzPI1kT3ttZxM188H021uKSc0kwPKSTsis4suguHJIy4vo1HsCqKI75Q8puesItx4Qkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713878527; c=relaxed/simple;
	bh=V3gsGptT/p6G36o7U4/7jd6cpZS627ebrpI08k2sDs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JNXgKjeJNUE4DZxZHIJF146JwSO8viYcQ+zjfa1xkFYtDEncIPg89J236TFnm891BHaIHfht61JMIN5tq/v4VwRc47pVYlwsWKYGE9tefq+X6EIKchWCVcp+IKsY7r7CQpE25f9IMbPj1HYzYjvTCBS1yoOyLPVtiFDpNJYW3go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4XzY5FC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fEUVoteP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713878523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F8WScoobWXTtBRZtrYdICKNugHPF5SmK3XsH1n+Ymc=;
	b=m4XzY5FCfbd9YzD0QWq6thD2I29dU5dUZUijd8hKfBmzwlypeVYo119Owo+ltIBvTJky3l
	y3XVXXzgGyS9JcFvV5zoG5Ib5X+x30HMBwRtPKJ4mUFvhQ6gIuU426hZi8ONZwP+xRlI7+
	YfNIRJe+hqpwj57IkiA5Q3++NgX3S7byZvCG5F1ajVPIjZAs5A4RbZkAvTZw6Nd+T1QbT8
	N3stnuWQuVe8owjbFhv9t0zUx797SABWbNcJoOTWk+zyXipl3MHXB1EdtACYDDy6H40Vsk
	epI4YE3PBz9Co4k3U767mEbqF92rXMIYfC+S3ddgvfFFqSbwQdonxpFyimvYtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713878523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1F8WScoobWXTtBRZtrYdICKNugHPF5SmK3XsH1n+Ymc=;
	b=fEUVotePRbJwjMxyVae5qz3FjkZBFRprreKVWLuHEJ4AVVFLnejBKkQJvTQUzeDAsOEK6Y
	K7fwToOh0tUPzTDA==
To: David Laight <David.Laight@ACULAB.COM>, =?utf-8?B?TWFoZXNoIEJhbmRld2Fy?=
 =?utf-8?B?ICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?=
 <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi
 Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: RE: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
In-Reply-To: <f2ac461445f44addb521ef79ecedc584@AcuMS.aculab.com>
References: <20240418042706.1261473-1-maheshb@google.com>
 <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
 <CAF2d9jj6H+jOfUbbw1ZEHmgqroXmn+oFV8NwTyKJ_P_T4G_5xg@mail.gmail.com>
 <87edaxudr8.ffs@tglx> <f2ac461445f44addb521ef79ecedc584@AcuMS.aculab.com>
Date: Tue, 23 Apr 2024 15:22:00 +0200
Message-ID: <875xw8uscn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 23 2024 at 09:22, David Laight wrote:
> From: Thomas Gleixner
>> The quantity of the initial frequency adjustments depends on the
>> accuracy of the initial clock frequency calibration which is on most
>> sane systems within +/- 500ppm.
>> 
>>      500ppm of 20ms == 10us
>> 
>> If the clock calibration is off by a larger margin then that needs to be
>> fixed.
>
> The initial adjustment depends on the accuracy of the initial RTC
> value read from the local hardware.

The initial value of CLOCK_REALTIME depends on the RTC value, but not
the initial frequency and the frequency is the only thing which matters
for CLOCK_MONOTONIC.

> This is unlikely to be more accurate than 1 second and can easily
> be a few seconds out.

Halfways sane RTCs drift in the range of +/- 5 seconds per day. But
that's not a problem if your NTP daemon is configured correctly because
it will step CLOCK_REALTIME right away when it's off more than 1 second.

Also correctly configured NTP daemons keep track of the drift and reuse
the last observed drift value which makes them stabilize quickly if the
initial frequency value which has been calibrated / determined by the
kernel is halfways accurate. It takes 5 seconds on my laptop from
starting chrony until it's stable.

Sure you can configure NTP in weird ways, but that's not a kernel
problem.

Thanks,

        tglx



