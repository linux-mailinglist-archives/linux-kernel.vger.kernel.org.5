Return-Path: <linux-kernel+bounces-67105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB96A856685
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60AB71F27AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D4135A42;
	Thu, 15 Feb 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vDggIoqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gl1Fw7AW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137BA1350C8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008408; cv=none; b=CB7oq3T9KwHhYxBQHvCwG1FPXu2b8TTzkuciW5xBPmFXfo30auQ/Gahu2NGIjT0AF+upWlsDufYIwtZR6FKSeTjuYIONEUNGO54aRn3YGDQGdsEgiT2rn6kT1CgiLWfo8xQoAQ2AJSHKU+lGzVkm5au5cf+XaN8xmT99cH8X+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008408; c=relaxed/simple;
	bh=EHRIQ+Pwu96xPVv3sgr0n4iDrs21tFEsr1wYg+lkbr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7JHQz5Wguh7xqbJ1Bf/37bh3GLYVd9zTNXyIcqOrkVrHH9jLqvV+NnSZWgrZJmJ7jYWh9n1n0aN8e0vYbccrpaoZnOyaMe5vENdd+eL1XrAnFqvU6Y1QIJloydQ//RmJEbcO2zVwkV8CGOCRZKD3Ux5wY280TQpqwIx9Shpels=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vDggIoqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gl1Fw7AW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708008404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3UcZ+n3SU4Ya49g3SiL14FXqOPCAdpR0yWfzakXsOk=;
	b=vDggIoqUWoAP/2TM8w9iPe8+nYmUGn8PnYLDoByWiKUBZx4mf0X+aM2ZtZFMoHdzNKpKmG
	GcBd32OTk5vlB63Fkr71QP0XoMgkcwUlJJu9O1gKtMfuW7XXOws8A2iyzyvAigeDPoeA85
	jec6H9iEfxaj3HPf7ZnwyuTYySfDqGYKMKVht1xXrIYmyFcnQ2QQ1+ekuyxK/O6uEYCqt5
	4YldK/hBLK1GjB/TF+V7ZvAuj22RtkhcfMlYLWZCnK3/CFIttzlbkZJKFrqoz9+Y0ChoRk
	JGLwygjFgUi2CnorDIST6Gq6yIPD8FflQ+MWjQVN5rb+9xVUehoJAm5JCtvqwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708008404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r3UcZ+n3SU4Ya49g3SiL14FXqOPCAdpR0yWfzakXsOk=;
	b=Gl1Fw7AW41XM0MqKYMiPnMIudLGD1oWP+RCO0o1aEMj1LyROSWT5SH5wRRHVSFcqRBb7px
	ndleIR/QXrLHmdCA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>
Subject: Re: [RFD] Remove irq_timings
In-Reply-To: <CAPDyKFoynM_gN=tzsWnE_xAgmy6R8Hie-_yO5zoJTjwNjR38Hg@mail.gmail.com>
References: <875xyqg2yr.ffs@tglx>
 <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
 <CAPDyKFoynM_gN=tzsWnE_xAgmy6R8Hie-_yO5zoJTjwNjR38Hg@mail.gmail.com>
Date: Thu, 15 Feb 2024 15:46:44 +0100
Message-ID: <87jzn5eqej.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 15 2024 at 12:23, Ulf Hansson wrote:
> On Wed, 14 Feb 2024 at 22:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 14/02/2024 22:17, Thomas Gleixner wrote:
>> > Daniel!
>> >
>> > It's 7 years now that we merged irq timings into the kernel, but we
>> > still have zero users for this.
>
> Wow, is it really 7 years since then. :-)
>
>> >
>> > I'm tempted to declare this experiment failed and remove the whole thing
>> > for good.
>> >
>> > Comments?
>>
>> I worked on an irq cpuidle governor which had better results than the
>> menu governor and equal than the teo governor. But I never succeed to
>> have better results without putting some arbitrary when computing the
>> next event.
>>
>> At one moment, Daniel Bristot de Oliveira (Cc'ed) was thinking to may be
>> use it for the deadline scheduler.
>>
>> Ulf (Cc'ed) may be has a plan for the next event for the CPU cluster.
>
> Yes, I still have that plan, but haven't been able to run some real tests yet.
>
>>
>> But if no one has plan to use it, there is no good reason to keep it and
>> I'm fine if we remove it.
>
> Besides that the code isn't really used at the moment, is it also
> blocking us from doing some cleanup/refactoring or other related code?

No. I just stumbled over it (again) and wondered whether it is ever
going to be used or not. If not there is no point to carry dead weight
around, but there is no hurry.

Thanks,

        tglx


