Return-Path: <linux-kernel+bounces-58280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CFC84E402
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FDF1F27F83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668007CF36;
	Thu,  8 Feb 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ltOYCkeW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UX1fbATa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401D97CF25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405841; cv=none; b=pJnJ8vVk7BxaHSSU9i8rIIsrD4Pp5wV5fXJbNP8cQyhQymcOnmHg7m8fa+TwCspk62zUi4PLkiWr0OyiTtnj4V6//a83Fln/9541hXiExzGtSuzuVUpS/7J119wLIX4tUtpm2Nwagp8VWuLFIr5IeNN9KzuYP+PKD4XMQBiqxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405841; c=relaxed/simple;
	bh=TXFqJl+VejqNcQc19S9a0yo1TsUlfDoX2zcdznVhVOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NtI4GMEXygbWsaCZApwV1vj4TyjKqKf/ZgXe3IwJfj6fWNTFt8sghC5tQTrF9DhuHCbDSupVRWnDKZDysgi85c/fXmBrVPJ/in0zQmgGw2DPJL/zw5GQDdYtYr1OvVbcaj+6WsfVpBxWi6zB5ghH62NmzwWNmSkcw0U2yVXTRRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ltOYCkeW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UX1fbATa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707405838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1FduTETIMSh9ur/MljH5h2gohj0pSlcSQSBY5yBtqTM=;
	b=ltOYCkeWx00OsUOMcZ7fKtADFlEpW7RCaaeg3pIN5BdzYvBMn5VfQftyf9c4wKCUznZ9uI
	rWgKMPHVJ+nZNL/LsxtZFkWJZkV2UncJYJbyC4YrGYcP2hyNqTRBN+qWh5swblac+rucIt
	GG6Lh25RPuMERxOL+dyYukQvV1L9jY0RDkVNYdkpP3dVpIeKoSUetPisJXuLdgXzyw6mGy
	xn1UQMPWv2HBUaIHTWOWl0a31Li5lRW4kCt1phq3dmsNa1/Z+DAYdmEUiaFBJyluz1lIjI
	Ttzy6Kw1jl1Tj77iYYuU14NVCFLDFuTYKYBi5OW725ncyLMAMNozJqKzym81TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707405838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1FduTETIMSh9ur/MljH5h2gohj0pSlcSQSBY5yBtqTM=;
	b=UX1fbATalMtYxRzrC/EaMHJvq0xjPwMgZGMOVsaJfoIZQaUpCBk0eFixUL0EOLkqbUh07E
	Zn3szRFUHu/swrDA==
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Daniel Bristot de Oliveira
 <bristot@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Valentin
 Schneider <vschneid@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Leonardo Bras <leobras@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>
Subject: Re: [patch 05/12] timekeeping_notify: use stop_machine_fail when
 appropriate
In-Reply-To: <ZcN+XM4223HS42LM@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.955049547@redhat.com> <87h6ikmqqo.ffs@tglx>
 <ZcN+XM4223HS42LM@tpad>
Date: Thu, 08 Feb 2024 16:23:58 +0100
Message-ID: <87zfwbkmi9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 07 2024 at 09:58, Marcelo Tosatti wrote:
> On Wed, Feb 07, 2024 at 12:57:19PM +0100, Thomas Gleixner wrote:
>> On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
>> > Change timekeeping_notify to use stop_machine_fail when appropriate,
>> > which will fail in case the target CPU is tagged as block interference
>> > CPU.
>> 
>> You completely fail to explain 'appropriate'. There is zero reason for
>> this churn, really.
>
> The churn is so that we can return an error to
> current_clocksource_store (sysfs handler for writes to
> /sys/devices/system/clocksource/clocksource0/current_clocksource).

What for? Why?

Writing to that file requires root. Root can rightfully screw up a
system and adding a debugfs based "prevention" mechanism is not making
this any better because root can just clear the CPU mask there and move
on.

So what is the actual real world problem solved by these patches?

All I've seen so far is handwaving about interference prevention and TBH
I can't squint hard enough to believe that.

Thanks,

        tglx

