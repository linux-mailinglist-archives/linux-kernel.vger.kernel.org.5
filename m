Return-Path: <linux-kernel+bounces-154353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC28ADB1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E36828403B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BFB37147;
	Tue, 23 Apr 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pxqD9VHf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/Kxh1AP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03D23BE;
	Tue, 23 Apr 2024 00:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713831920; cv=none; b=q3tR88t1bNxKz/uhbSfZSTmWpJsd2uNQQ5VJsXrXpZFgnMN1w/Q4iKcaj6GNknybU3MSaKiU2TKEYEYNBDPV2UoQevDEMIdf220Ot83MEjQbGEHPbPjAauqTn29jqM/tbzaM04Vn6mmlLMaaXFevp6a561WshPD9GUlSK+WG0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713831920; c=relaxed/simple;
	bh=k6eRWwINhj0U1Xa3qi1OYa2d9LpF+aurYBLnHfRbNCU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fo4E4Mgz7tV8TIwloUN9gZfe0hEelCev3q7kWrqsKEx2YtUz1dnn7swc8UdR0501ruCy78d/eMvK/2HA7PXORDArM9TAYgH+L44CKvKIC2Bb49LJIqcH1ztX9tHHI0yfPjJTMKmnqBiqFwzVmtMvfDuGm09jkaTc4sFmxvQuZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pxqD9VHf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/Kxh1AP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713831917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjTLjvprvXko18egTeJSxFNpZDAMhMu8NQmFX6VjddQ=;
	b=pxqD9VHfQzMHm12zw5pgnOUaWT0va38KJ1b35SniTjYbk6JEIY2B2EhKzO9Zke0zbWgXEx
	JTjijvpgpBzA/erowJLczheT6y5tlxD1uDpLm6K9uJNgPIAt2qz7E7fbewoHaYXy4Mfqp+
	HftA9P57UWc9I76fBxnjmJJLhDPsYvitPgUb+bdKRbkVTZTU877uM6FhjWnP0jRAGL5GEJ
	RNsuOWZ2r9aEL0iaPHTtIN5U5L9QbZ66xrB+Lyjacyi6BmIymamxqLNQLpuFZMf/Zo8xTr
	1AUgHRtRxEio2APQR2NVg2XIsdcPLAFMCe/ncuqwMZgvJOjXZq3xdve8txqyTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713831917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjTLjvprvXko18egTeJSxFNpZDAMhMu8NQmFX6VjddQ=;
	b=1/Kxh1AP2LHbLo74FfgDon0/dMkzAGGnhYuXAl8+2i5y1NkQSjwVELm75F9hCdutR7wJ7k
	ucRJYclIUzulmdAA==
To: =?utf-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
 =?utf-8?B?4KS+4KSwKQ==?= <maheshb@google.com>, David Laight
 <David.Laight@aculab.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi
 Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
In-Reply-To: <CAF2d9jj6H+jOfUbbw1ZEHmgqroXmn+oFV8NwTyKJ_P_T4G_5xg@mail.gmail.com>
References: <20240418042706.1261473-1-maheshb@google.com>
 <163538a0495840eca34f6fbd09533ae1@AcuMS.aculab.com>
 <CAF2d9jj6H+jOfUbbw1ZEHmgqroXmn+oFV8NwTyKJ_P_T4G_5xg@mail.gmail.com>
Date: Tue, 23 Apr 2024 02:24:59 +0200
Message-ID: <87edaxudr8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22 2024 at 15:04, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=87=
=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=B0) =
wrote:
> On Sun, Apr 21, 2024 at 11:27=E2=80=AFAM David Laight <David.Laight@acula=
b.com> wrote:
>>
>> Isn't using CLOCK_REALTIME just a big bug?
>> As well as minor 'corrections' done by NTP it suffers from
>> major time-warps that can jump in either direction by arbitrary amounts.
>>
> Yes, this arbitrary jump in either direction is a problem and hence
> the proposed update. However, since it's a UAPI and there could be use
> cases that are happy with the current implementation, we can't break
> them. Of course the use case that I'm bringing in (and probably what
> you have in mind) differs but backward compatibility needs to be
> maintained.

It depends on what you are trying to do. You cannot adjust
CLOCK_REALTIME/TAI without knowing the current time, right?

So just declaring that this is a big bug and a problem is as wrong as it
gets. It's obviously not the right thing for all use cases, but that
makes the legitimate use cases not wrong.

>> This doesn't solve the problem of the NTP adjusted clock always
>> running slightly slow or fast.
>> The big NTP errors happen in the first (IIRC up to ~20 mins after boot)
>> when the system clock is being synchronised.
>
> Yes, a big step is a high possibility at the beginning (at boot) but
> smaller steps as well as ppm adjustments are real possibilities
> throughout and hence CLOCK_REALTIME and CLOCK_MONOTONIC are affected.
> By adding the timestamps in CLOCK_MONOTONIC_RAW (as proposed in this
> patch) should address this issue.
>
>> It really would be nice if those big adjustments didn't affect
>> CLOCK_MONATONIC. (as an example try sending RTP audio every 20ms)

They don't affect CLOCK_MONATONIC at all because there is no such clock :)

> Hmm, probably this is out of context for this patch and probably a
> question for the time maintainers / experts?

The quantity of the initial frequency adjustments depends on the
accuracy of the initial clock frequency calibration which is on most
sane systems within +/- 500ppm.

     500ppm of 20ms =3D=3D 10us

If the clock calibration is off by a larger margin then that needs to be
fixed.

It's clearly documented that CLOCK_MONOTONIC and CLOCK_REALTIME (and
therefore CLOCK_BOOTTIME and CLOCK_TAI) are strictly based on the same
frequency and only differ by offsets. So there is nothing to fix and
change.

Thanks,

        tglx

