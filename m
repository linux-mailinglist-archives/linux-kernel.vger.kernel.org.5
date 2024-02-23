Return-Path: <linux-kernel+bounces-77873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA80860B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB111F24559
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 07:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C836E1401D;
	Fri, 23 Feb 2024 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YY/Nb7of";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+g5M39FL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F9B12E7D;
	Fri, 23 Feb 2024 07:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673642; cv=none; b=T23l++a21JTFHPzbI5a8u2/XYmslbpbu0fJfcAEAdd9b8JkXHmB3mj5EuUdhUdn2LAUB65quyQEblfQv0lFCjqKZFXUAq0KK4XitNaWtS6O/nOixewj2NfDlLFCcjeHg4/4f6Nm/tBZjuDsqvwbRMG9Eo+pGhfc3vthDu4TiaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673642; c=relaxed/simple;
	bh=P079MrrGvHu7pWw2m3o5CihifE+Hq2GMO2lGobccamk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hg1TXCwV35rVXPC3q0539oMpjxb7YoqRKP+1JhvUzLq3fu3NTfDgd9VD5ihemjmJFAcP/hWtWjNRONs7siyAYvAzZWXWmbO900SBvHJ3ocwZg86kfod8YS1sAuLjh16cDnKzJuEpr1ltDyjEBEwqyF0sYCYWbFiXvJ1kaseumOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YY/Nb7of; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+g5M39FL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708673638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNx4BQcwgWzuFIv1trKOm0daQPJvueQjdA0aX5uzfM=;
	b=YY/Nb7ofRVKzMKe93lJCL+3T+p9iZqJDXuukZvnVrQpKUhl44RXWyV2/I0SlcFX2dPY91w
	4A1K1OY2GKr0/1ekarOFbm1JWXomTu6dCjwMYuTae+iitDDtEWHDWkOzp8n9qK30Yj4xwZ
	9RuUB/zDwmHcio8H6vZBZy0wnc9H2fdZ4rzuWN+gejr05klbO7F0E75boSsNCVJudZwuvU
	B1X7ZpFzIpJZUp4kiKbwLB05+n44i8LHPBvC7F6YJl7x/xHBZ2F4aCflgquHUC0H2ALsww
	cVL3vyRtGuIwRE/niUEyRmweWBpBjSexbJhk+JG++9HOavEjhGhjsuBvmRQ9GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708673638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pjNx4BQcwgWzuFIv1trKOm0daQPJvueQjdA0aX5uzfM=;
	b=+g5M39FL5yg0ypDdsaZEocLX0jM30cta14pJcVGZn9nIv4M1JqT8XsbTWImunh/Tf/F/6C
	ClniuRNmD+SwHzCg==
To: Leonardo Bras <leobras@redhat.com>
Cc: Leonardo Bras <leobras@redhat.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Tony
 Lindgren <tony@atomide.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Shanker Donthineni
 <sdonthineni@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] irq: Introduce IRQ_HANDLED_MANY
In-Reply-To: <ZdghE6TNHgZ_bi19@LeoBras>
References: <20240216075948.131372-2-leobras@redhat.com>
 <20240216075948.131372-5-leobras@redhat.com> <87zfvwai62.ffs@tglx>
 <87v86kaf84.ffs@tglx> <ZdWMja3BfCZsbF_q@LeoBras> <87edd5hljz.ffs@tglx>
 <ZdghE6TNHgZ_bi19@LeoBras>
Date: Fri, 23 Feb 2024 08:33:58 +0100
Message-ID: <87cysneis9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 01:37, Leonardo Bras wrote:
> On Wed, Feb 21, 2024 at 04:41:20PM +0100, Thomas Gleixner wrote:
>> There is usually no concurrency at all, except for administrative
>> operations like enable/disable or affinity changes. Those administrative
>> operations are not high frequency and the resulting cache line bouncing
>> is unavoidable even without that change. But does it matter in the
>> larger picture? I don't think so.
>
> That's a fair point, but there are some use cases that use CPU Isolation on 
> top of PREEMPT_RT in order to reduce interference on a CPU running an RT 
> workload.
>
> For those cases, IIRC the handler will run on a different (housekeeping) 
> CPU when those IRQs originate on an Isolated CPU, meaning the above 
> described cacheline bouncing is expected.

No. The affinity of the interrupt and the thread are strictly coupled
and always on the same CPU except for one instance during migration, but
that's irrelevant.

Thanks,

        tglx

