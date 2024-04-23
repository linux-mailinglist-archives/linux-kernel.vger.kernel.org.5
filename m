Return-Path: <linux-kernel+bounces-155643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4E8AF521
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9842628446B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5B24CB55;
	Tue, 23 Apr 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eqlPb8Ei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oalr9nNL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABDB13D635
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713892199; cv=none; b=LkBm5ht3sp4IM4N81kuXn3fkS+FrIi/SofKZzeaq8cNbt8H949kC2bkWfXu896ZazcbjQYb2rXFiXLZvOVDGl+7eZGX9VKjz0u05RzV0Juofbg1EkVylcU1h5ZnFeuFiIk2asOIKtVSJQg0VH/6Bh6P3ttMJB0zeHJfvU0DAXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713892199; c=relaxed/simple;
	bh=0wFlof/RuBxq+GgYuTNGHU3YhlLUlaYRUw6ARvWr7to=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NuG0KwQrMWrn6HZwICOfx8KhR3xsVlCUIB5bn9GdQSKmSBedvRB88ZOAXRON1m0C85P0BxsfoEmxcDofLU6Y1CsxztLlitqwmfr7gdhtmLMlsfP87uDAP4Cb7lGhs8dvGxzALPn1Uvo372FAcKnNRVzu7mi59iLJGrbMQKx8YXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eqlPb8Ei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oalr9nNL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713892195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=618gIDoAvrtG832g7Ig9sZLsF6yOlG6yDNEwLvTsJLk=;
	b=eqlPb8Ei79c8qSc7YPv9AMEvhUqEB4CF4faKP4luTf16zuCwIJ/7MgnzIn//80KDk/7aRj
	RXlfh3n3actUJVe6D2AShSysnhm3rFY0JGhqeWIVUZu65bEFo8dpqLaO7V8J3hYb1ZeSnx
	lFRn9Pl7Fm04MtnnN2HXS89PdWC1g5oAyx1f/hmcxauLWswPs4T6YvSQ5UX5ySIfZdeFV+
	LfqJf9Thjo8KCZThkiZ1cZ279huoC/iv8b3dspquH/r+e06cK3GXN+AvwzAWYihdGknOLr
	Idufn0xBBoL+OdF1Zh+ZsgMjDmsr3bz4UjipuEVyJycK3YrkHL+Y0GWuRr6Kpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713892195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=618gIDoAvrtG832g7Ig9sZLsF6yOlG6yDNEwLvTsJLk=;
	b=Oalr9nNLNdo2bTcYOVPU2Byw3HRfdGkkQWVB7pyDks4OYRRaFcQB7MXHnNRBa8+VdLUyCK
	vbmZ1JRM+znXfyCA==
To: Lyude Paul <lyude@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
In-Reply-To: <87le59vw1y.ffs@tglx>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
Date: Tue, 23 Apr 2024 19:09:51 +0200
Message-ID: <87y194t38g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Apr 20 2024 at 00:15, Thomas Gleixner wrote:
> Paul!
>
> On Fri, Apr 19 2024 at 13:38, Lyude Paul wrote:
>> Awesome - can confirm the patch does indeed make the machine boot. Full
>> dmesg from boot attached.
>
> Thanks for providing the data.
>
> [    0.089286] CPU topo: APIC ID 0 present 1
> [    0.089294] CPU topo: APIC ID 0 present 0
> [    0.089296] CPU topo: Hot-pluggable APIC ID 0 in present package.
>
> ACPI is really a wonderland.

Second thoughts. I just stared at this some more and I really cannot
figure out why any of this (including the debug patch) makes a
difference or even sense at all.

All the commit you bisected to does is to reject the non-present APIC
IDs, but that's just an accounting thing. Instead of having them
accounted as disabled they are accounted as rejected.

So no. None of this makes any sense at all.

