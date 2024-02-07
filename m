Return-Path: <linux-kernel+bounces-56391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C111584C996
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60F5AB22E79
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989521AADA;
	Wed,  7 Feb 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVs+jf/Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLYCgGrH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AB71B275;
	Wed,  7 Feb 2024 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305190; cv=none; b=aveJyfA8nEN0VXBmDIJzbOJvB8sQU6sDoV6F8RkfKfsun71WT4QG/HTKYqU9e5ubHuaxISWznceLPV0jdebLvUXfLs7aL4FYI4UwvBgBEdOg1ZKZthodylF227Gyz5Dr9hHqJkWpGVVlAZ6ZCiAl5Ue6o+m/oU1UlYVWvHkTeYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305190; c=relaxed/simple;
	bh=JfYBzih6S6mvSYeUfR3TJzJyamqjVFjhY7RxM4mbHeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OaW9B6uo0WBqirn3WpJWqcQcPd5liK1F1jV0dso/jtjrOxWAXPdR2/Xvgp1nnjsoDWrihNwOhBFdVq5onPNm2tHl57NTO/S0SFbJgZjibGKWmKSl+gp2KB8A6I4tPvh1QOEgJbRQ+GOHzREbmxkXvcl78bA7GYeCbXDI5Zf8m7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVs+jf/Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLYCgGrH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707305187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCIcHY3HFLAduHPxS6ZbiHVayvEt7hL0AjwboJZzHk=;
	b=rVs+jf/YT/rRqYGCZt6/RMrx/PA95qNfki/mh0TL7LHCe5jje8ceLJGry2F2qmIhT0UfCE
	1i5afSBU/iLIxigCi5jSKDtuwUrNVppdKQDL/EXL1rni/H3hqaONZS0j6kJtG8GHWls5fi
	c5zF8kbHH8ZtbtCopwbBBYRNz0Q0J96hEUFEusm3ypMUkLwfFDvLg2YB6N66Gwd1H4Uca5
	aOtfa5ISa2a2k5DaEPjscbIE3poLkqDj+0gJQPgXAbgqNlNXiRJq/fv8Dj8q6ZVasWUgMo
	cQ+K3+Y8uqwhM1yHetql7mwu179TPYbiwjsQjTfTdykO2tWs9rcgxA3gYIO89g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707305187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jdCIcHY3HFLAduHPxS6ZbiHVayvEt7hL0AjwboJZzHk=;
	b=hLYCgGrHKz53r5YQVdNWW5ahRCIfoL61j/VjkJJCHFGfjzVDyqugAEdGVti6IhSUFz0EOy
	ZJIcdFpN8SXeBTCA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pranav Prasad
 <pranavpp@google.com>
Cc: rafael@kernel.org, pavel@ucw.cz, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, krossmo@google.com, jstultz@google.com
Subject: Re: [PATCH] alarmtimer, PM: suspend: Expose a function from
In-Reply-To: <CAJZ5v0gXsCuVvqynDeuf_NZtyAJ07umx1NUqfFZb25vjNABAfw@mail.gmail.com>
References: <20240131191317.2191421-1-pranavpp@google.com>
 <CAJZ5v0gXsCuVvqynDeuf_NZtyAJ07umx1NUqfFZb25vjNABAfw@mail.gmail.com>
Date: Wed, 07 Feb 2024 12:26:26 +0100
Message-ID: <87msscms65.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31 2024 at 21:10, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 8:13=E2=80=AFPM Pranav Prasad <pranavpp@google.co=
m> wrote:
>> @@ -564,6 +565,8 @@ static int enter_state(suspend_state_t state)
>>  #endif
>>         } else if (!valid_state(state)) {
>>                 return -EINVAL;
>> +       } else if (time_check_suspend_fail()) {
>> +               return -ETIME;
>
> This causes a function defined in modular code to be called from
> non-modular code which is an obvious mistake.
>
> It also makes the generic suspend code call a function defined in a
> random driver, which is a total no-go as far as I am concerned.

Alarmtimers is built-in core infrastructure and not a random modular
driver, but nevertheless:

> Why don't you instead define a PM notifier in the alarmtimer driver
> and check if it is going to trigger shortly from there?  PM notifiers
> run before the tasks freezer, so there would be a little difference
> timing-wise and you can return whatever error code you like from
> there.  As an additional benefit, you'd be able to handle hibernation
> in the same way.

Makes sense.

Thanks,

        tglx

