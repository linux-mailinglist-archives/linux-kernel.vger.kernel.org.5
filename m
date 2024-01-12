Return-Path: <linux-kernel+bounces-24772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3682C238
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EA1287DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961056EB79;
	Fri, 12 Jan 2024 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Tb4v22A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5zjTs2Ta"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C18B6EB74
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705071154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdU9EUuaq5xIuz7Dx7kAj78GZgJNR892u+3NLj09xAU=;
	b=0Tb4v22AWgQyxnaapyqWuR7ryqLwix39lSCDgP0LIcnQp3fDK53xfz6AWo7GZp/Bwb366w
	JkmW3kCaIgFHZQ5WXQOkLckLiRTF/BV0ybqrXtH5Fo0LoSugWJZ9c7G4mtDwBM5/mX/hbC
	xHRaY1ZupKxAD+GNACdouJnrPckgqEbsT9eY6JAXlGzaeNvL7f9JrW6vyQD5hgDWhN9F0Y
	KLjqHC55G/HC0aeqfiifLULB7DmdbFrX2o3QYvpCZ4CEpsNVxcYPvMs7ca6Ui7fjSh8Ggc
	9RPw+kVkj8Z3VPInEPXNf9Lc1XIHcmJf6VuS++D/W2R1U5GFpIPzP603W6Wc4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705071154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdU9EUuaq5xIuz7Dx7kAj78GZgJNR892u+3NLj09xAU=;
	b=5zjTs2TaDiewcCXytz4MwOSffHfvhZPS44D/4UVseXR1sk4VLjrwDpJRJjrNcOVOoPm34H
	MFr5TBHTzJ3Vh5Cw==
To: Pierre Gondois <pierre.gondois@arm.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH] sched/idle: Prevent stopping the tick when there is no
 cpuidle driver
In-Reply-To: <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com>
References: <20231215130501.24542-1-anna-maria@linutronix.de>
 <c09fb78b-5bf9-4c0b-b93f-10fd19a4ab36@arm.com> <87ttnmiif9.fsf@somnus>
 <06a2561f-557b-4eaa-8f11-75883bbbaef9@arm.com> <87a5pag6q7.fsf@somnus>
 <d0f1617e-0088-4bd9-bea6-e89c63b0e2ae@arm.com>
Date: Fri, 12 Jan 2024 15:52:33 +0100
Message-ID: <87mstaioy6.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 12 2024 at 14:39, Pierre Gondois wrote:
> On 1/12/24 11:56, Anna-Maria Behnsen wrote:
>> Pierre Gondois <pierre.gondois@arm.com> writes:
>>> I agree that the absence of cpuidle driver prevents from reaching deep
>>> idle states. FWIU, there is however still benefits in stopping the tick
>>> on such platform.
>> 
>> What's the benefit?
>
> I did the following test:
> - on an arm64 Juno-r2 platform (2 big A-72 and 4 little A-53 CPUs)
> - booting with 'cpuidle.off=1'
> - using the energy counters of the platforms
>    (the counters measure energy for the whole cluster of big/little CPUs)
> - letting the platform idling during 10s
>
> So the energy consumption would be up:
> - ~6% for the big CPUs
> - ~10% for the litte CPUs

Fair enough, but what's the actual usecase?

NOHZ w/o cpuidle driver seems a rather academic exercise to me.

Thanks,

        tglx

