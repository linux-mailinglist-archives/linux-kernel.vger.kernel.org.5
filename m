Return-Path: <linux-kernel+bounces-24598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B001C82BEC7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD5D28463B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA4A5D903;
	Fri, 12 Jan 2024 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjL2NtIw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WW890Bjy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E19958AB4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705057008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbrBkxSGRtAZwyPLwAXR80o54hCAQ6NXr8R3T5x2vQE=;
	b=jjL2NtIwiWVTg0NofoOW164CxPy9Xwx4X8QW67HlhYixHGHgkLeyM5uik74dhEOGtVbmO+
	G0+Uj+sQRvZ8wn837HFB798pQM0D7d34wa3yjcv+9fUqozU67kz8RWKesJic+lgZmpnG3f
	usyhS7uEwUR4OQMcHXxkHYgKKQE/HJWvfPryBZ18OigZOwMooMnIPZwaL12hOxoG6jo17V
	W/WphsucQ/SC869ajKj/zhBLQSWKio413QdSndJ9Mx9FzuGkxl0m5V9rOajAZSPNksYn+f
	6Y3xxQekC4xkZMy6Ih8wThRaiaPfwAQxFLDB3iWl/8VAd78eDk14UwRZQmIA3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705057008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UbrBkxSGRtAZwyPLwAXR80o54hCAQ6NXr8R3T5x2vQE=;
	b=WW890Bjy+S5PgtnWwfW8Nwy0gYT+EClruZ172h4/g/C4ZWFoBmiYOxglmyz9QLJd2NxmWP
	kcQq0DAJmR++0rDQ==
To: Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
In-Reply-To: <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com>
Date: Fri, 12 Jan 2024 11:56:48 +0100
Message-ID: <87a5pag6q7.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pierre Gondois <pierre.gondois@arm.com> writes:

> Hello Anna-Maria,
>
> On 1/9/24 17:24, Anna-Maria Behnsen wrote:
>> 
>> When there is no cpuidle driver, there is no instance which could bring
>> the CPU into a deeper C state. But at the moment the code does
>> unconditionally try to stop the tick. So the aim of the patch is to
>> remove this unconditional stop of the tick.
>
> I agree that the absence of cpuidle driver prevents from reaching deep
> idle states. FWIU, there is however still benefits in stopping the tick
> on such platform.

What's the benefit?

Thanks,

        Anna-Maria


