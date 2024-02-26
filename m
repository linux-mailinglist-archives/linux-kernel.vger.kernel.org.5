Return-Path: <linux-kernel+bounces-82122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101EE867F93
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A01F21ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ECA12F36E;
	Mon, 26 Feb 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5sDphJs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mZXkRcmU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5205C12E1F5;
	Mon, 26 Feb 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970967; cv=none; b=Ou+VEvHtnc3b3Z+c7cmH26wsVri1ZjuHOwDz22QFxzqo2cvey0kFCxqKz8AYEA0rqpXV52XSpK9Fz074Ww4+c+vu0vyueMwk1QgkvHrg69V1fIxzJWJntTK5Jd9dOkIgu2ldiOLLcloeyR8SzgjUz0GoZfSICCk55XnBgvZNpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970967; c=relaxed/simple;
	bh=EgcqXpFezT+1t7YK8f56X0MEgJ6W6GxDYo7o8TM6gUE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KPhTYJQ+7InPGLmyaoQRq0vHRXm+kg5IThQMyuGfHFR1Ga2niTCrOw9hUjo6BUXV3SOGSm8odcDQ7X8qg3MIw6BcK6k0gAkQF6Lh9FWm69X/oHHx4afBNzpEPy5CPUZBd41yXoPDdoIn96u/+9t69x9e6lr0XUcnWYyLin7mg54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5sDphJs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mZXkRcmU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708970963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBiIbeLll0i8806pw3+a5wtiCC8R3KilwQQO3Vmsk48=;
	b=G5sDphJs7t9/raF+7NYDjjcuKFwrRc0mqtuV/gpfLcT+jH6DXladNCYEqLak8e2uai5TD+
	ZcTwChJ8MRp+01HO3nKWNKe+NhKUZvPjHaVfpllKVSfsey894PDzlGGuvLRd0X5D8J82dv
	CqMwC6SoYU86gtUCYVqmQ8Yu7sD05uyf777NW9SzmGMWzGpcxyL2FVvckmC6GlOfGem5AS
	33YWLOeIMQWQJhI0qjRJgCA7E7rPEUqWA++z25qhnjTzfUmFgKFgXhtYxaa1S1rNjafLx6
	1JE8wnN5SQygZR6jXnuuQzKneRTbC7TmsoLykcIhsO39hkJ4+vHGjujy2sTf7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708970963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lBiIbeLll0i8806pw3+a5wtiCC8R3KilwQQO3Vmsk48=;
	b=mZXkRcmUoZuND93toW5bsRFgQG3qHZFIQrwEXNOwCdtZ2hwAjok8Xgut2Ym9p5Xw23JOqV
	3M+bMQhHuGc36HAg==
To: Mathias Nyman <mathias.nyman@linux.intel.com>, Linux regressions mailing
 list <regressions@lists.linux.dev>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-x86_64@vger.kernel.org, netdev@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: Re: This is the fourth time I've tried to find what led to the
 regression of outgoing network speed and each time I find the merge commit
 8c94ccc7cd691472461448f98e2372c75849406c
In-Reply-To: <acc2b877-4b42-fd4d-867b-603dae95d09d@linux.intel.com>
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com>
 <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com>
 <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com>
 <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com>
 <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
 <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
 <34d7ab1b-ab12-489d-a480-5e6ccc41bfc3@infradead.org>
 <10487018-49b8-4b27-98a1-07cee732290d@infradead.org>
 <4f34b6a8-4415-6ea4-8090-262847d606c6@linux.intel.com>
 <3ea25443-1275-4c67-90e0-b637212d32b5@leemhuis.info>
 <1e719367-01ae-565a-2199-0ff7e260422b@linux.intel.com>
 <410817b8-1cf9-4285-b20b-f1fa0513cee8@leemhuis.info>
 <acc2b877-4b42-fd4d-867b-603dae95d09d@linux.intel.com>
Date: Mon, 26 Feb 2024 19:09:22 +0100
Message-ID: <87r0gz9jxp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Feb 26 2024 at 12:54, Mathias Nyman wrote:
> On 26.2.2024 11.51, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> I don't think reverting this series is a solution.
>>>
>>> This isn't really about those usb xhci patches.
>>> This is about which interrupt gets assigned to which CPU.
>> 
>> I know, but from my understanding of Linus expectations wrt to handling
>> regressions it does not matter much if a bug existed earlier or
>> somewhere else: what counts is the commit that exposed the problem.
>> 
>> But I might be wrong here. Anyway, not CCing Linus for this; but I'll
>> likely point him to this direction on Sunday in my next weekly report,
>> unless some fix comes into sight.
>> 
>>> Mikhail got unlucky when the network adapter interrupts on that system was
>>> assigned to CPU0, clearly a more "clogged" CPU, thus causing a drop in max
>>> bandwidth.
>> 
>> But maybe others will be just as "unlucky". Or is there anything to
>> believe otherwise? Maybe some aspect of the .config or local setup that
>> is most likely unique to Mikhail's setup?
>
> I believe this is a zero-sum case.
>
> Others got equally lucky due to this change.
> Their devices end up interrupting less clogged CPUs and see a similar
> performance increase.

Reverting this does not make any sense.

The kernel assigns the initial interrupt affinities to the CPUs so that
the number of interrupts is halfways balanced. That spreading algorithm
is completely agnostic of the actual usage of the interrupts. Where
e.g. the network interrupt ends up depends on the probe/enumeration
order of devices. Add another PCI-E card into the machine and it will
again look different.

There is nothing the kernel can do about it and earlier attempts to do
interrupt frequency based balancing in the kernel ended up nowhere
simply because the kernel does not have enough information about the
overall requirements. That's why the kernel leaves the affinity
configuration for user space, e.g. irqbalanced, except for true
multi-queue scenarios like NVME where the kernel binds queues and their
interrupts to specific CPUs or groups of CPUs.

Why ending up on CPU0 has this particular effect on Mikhails machine is
unclear as we don't have any information about the overall workload,
other interrupt sources on CPU0 and their frequency. That'd need to be
investigated with instrumentation and might unearth some completely
different underlying reason causing this behavior.

So I don't think this is a regression in the true sense of
regressions. It's an unfortunate coincidence and reverting the
identified commits would just paper over the real problem, if there is
actually one single source of trouble which causes the performance drop
only on CPU0.  The commits are definitely _not_ the root cause, they
happen to unearth some other issue, which might be as mundane as
e.g. that the NVME interrupt on CPU0 is competing with the network
interrupt. So don't shoot the messenger.

Thanks,

        tglx











