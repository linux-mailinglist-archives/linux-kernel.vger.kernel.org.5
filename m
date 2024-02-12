Return-Path: <linux-kernel+bounces-62528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A14852260
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98FE284409
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31AF4F618;
	Mon, 12 Feb 2024 23:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfM672aF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjXFj7ao"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967347A53
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 23:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780162; cv=none; b=Oj65Z99c/iTEl9ggyajhOGhjFctPT1GGtfas5qxRfkCcQvM3MwJOht/v3ljK9/yVXKY3dJrUtqkYLZBbKeJt2K2vSoDnHwwv2Yg1A5gtL+nWMwwSHft5r2pjJBeB80W6HipIugT+XouA31WjIvEL30DrPG1R1xf/rKl6sDjmero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780162; c=relaxed/simple;
	bh=5t5jG2Srhl2hwZZ31/oTgIWfmwPzLTzPV/Eflo/j54w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cu7h/czS1s1FNiMbTLGwGWDa182s5PNkEMpdM0gMNM9BlH3qfUrm55t1bwAZ1hzIys8Ra5ssRFkSwRuFJLKvgyAAdmzO6HQebNmkSDXGqDEsfKXeh3mENOMk8awgLg1vhfTCE8LjKe8Axge7KyKWEcFxXJSsTelfKZMYPz0uCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfM672aF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjXFj7ao; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707780158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y18cEADXMAHj9yL9ELXLWBM2/DUY8Csq6elKaw1ee7Q=;
	b=TfM672aFpL5RhC/Pb07QLYln4kCzK/pZU+JdWthBJbvud00XNlnkSyi28HPLOF4Vpc+pV4
	/W6O8V/7tN2rML7MVrA1Gi8JlUA9KmZZfIV5vbUs5k7lP3Gsx6smPPD4N4eo/G186HPxSx
	IGKVrRgiyKZD1jNYUybCSvU65JJGPhHLoyS0Ro6Rua0Ocs7oBNNJV6NIS2qgvyGYBoANM8
	Csb6PwUhk2BigS7YKy4Ilz4Y83S0KFzccay+r57vUvH+Fcr4sdDwKkyLpWem/aHTX1dxfT
	sOnZTOcQ8C7Cty3yH04XqhK33KfoF4KYRioCNSmdt11Bi157kpSTk7vGkZu9Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707780158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y18cEADXMAHj9yL9ELXLWBM2/DUY8Csq6elKaw1ee7Q=;
	b=rjXFj7aoKHJfWSCXJ+faTMMPR78P2uqLlUXoXNGvBr3pi+AFvmb3mF5Y/HpvYzpfoINZR4
	pIMUQn4kRHGuQBBQ==
To: John Stultz <jstultz@google.com>, Joseph Beckenbach
 <Joseph.Beckenbach@se.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Setting real-time clock below monotonic clock
In-Reply-To: <CANDhNCoh3O=Ds_oLkGer7KKVUW4Zdf_vDdDmyJFVKhDSGU5c-g@mail.gmail.com>
References: <AS4PR04MB9715AECEB559CC8B637D67638A7C2@AS4PR04MB9715.eurprd04.prod.outlook.com>
 <CANDhNCoh3O=Ds_oLkGer7KKVUW4Zdf_vDdDmyJFVKhDSGU5c-g@mail.gmail.com>
Date: Tue, 13 Feb 2024 00:22:38 +0100
Message-ID: <87wmr9i7y9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31 2024 at 11:12, John Stultz wrote:
> On Wed, Jan 31, 2024 at 10:48=E2=80=AFAM Joseph Beckenbach
> <Joseph.Beckenbach@se.com> wrote:
>>
>> We have observed that we are not able to set the realtime clock=E2=80=99s
>> time value below the monotonic clock=E2=80=99s time value in the Linux
>> kernel.
>>
>
> Indeed. That behavior was intentional.

It's actually required as a CLOCK_REALTIME value before CLOCK_MONOTONIC
would cause the offset to be negative which would result in a myriad of
issues all over the timekeeping and timer code. Those could be solved
but the price for it would be not worth it as it pretty much slows down
every fast path.

>> We have a situation where we will try to set the realtime clock time
>> to a very low value (close to January 1, 1970) and below the
>> monotonic clock value. In this situation, it does not matter what the
>> date is, but we need the time to be synchronized across multiple
>> devices (using generalized Precision Time Protocol or gPTP) for our
>> application. It=E2=80=99s possible this synchronized time might be a low
>> value (close to 1970) because the gPTP master starts its time from
>> January 1, 1970 when it is booted, and when this gPTP master is
>> booted after the gPTP slave, the master=E2=80=99s time is larger than the
>> slave=E2=80=99s monotonic clock (which also starts from 0 when it is
>> booted). When the slave tries to adjust its clock to match the
>> master, we get an error.
>
> I appreciate there may be many constraints here, but it feels like the
> device you're trying to sync to, reporting its time as close to Jan 1
> 1970 is misconfigured.

That's a known issue for quite some time and has been reported
before.

Those systems use a non-standard clock master which itself is not
synchronized to CLOCK_TAI. As the default startup time (if no RTC is
available) is Jan. 1st 1970 this is expected in case that the master
starts after the slaves.

> So I'm not sure it's reasonable to expect the kernel to support that
> case.

I don't think it is.

> Is there some different perspective I'm missing, though?

Other than naive assumptions about how timekeeping works, no.

>> Currently, we are planning to use a workaround where we keep track of
>> a known offset between the =E2=80=9Csynchronized=E2=80=9D time which is =
1970 and the
>> =E2=80=9Creal time=E2=80=9D such as 2024. Since the time only jumps once=
 at the
>> beginning of sync and should not change by more than a second
>> afterwards, we think this will work for now.

What's wrong with having a reasonable synchronized time on the clock
master to begin with?

If a slave starts up before the master then it has to be able to deal
with an initial time jump nd it does absolutely not matter in which
direction this time jump goes, no?

Thanks,

        tglx



