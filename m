Return-Path: <linux-kernel+bounces-156697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB488B06F9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 914D4B2126B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCAD15921A;
	Wed, 24 Apr 2024 10:08:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D457158DCF;
	Wed, 24 Apr 2024 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953327; cv=none; b=QW5DG6bS60xtURUgewhQk6+4yWJBy076fu3vL3xPWYdT7zO51wwfhbX81aTI6voRIo78N1ulFYUXOTpp4fdyj/pj0I8UQQKJHtgbzIHxjpjwjdvY4/LJ+XIWms2TAi7WqKKDw/XD/gBKIQRhkWTL8QPAQ6jPNYs/yPKdueMdr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953327; c=relaxed/simple;
	bh=Vj9BHW5iBeHIGnrdfCDKVFi1C7486OsXjCah6RXakgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBpunKO9zIl1bpT6NV+MHKqr5JJ9oA05Yb5Aeci5eek0LJZZtKeKgLqYJYX1ToIPt+DBPHsduxfgoY9+JPoY6ojcfjWLqKKANunI/uutashnDscGfq19RzgCM0cTLfWblPi0Y3vcTGSOQi3GAxLXywO4m172aLrzviWyGB3WXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C195339;
	Wed, 24 Apr 2024 03:09:13 -0700 (PDT)
Received: from [10.1.30.55] (e133047.arm.com [10.1.30.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4EB3F73F;
	Wed, 24 Apr 2024 03:08:44 -0700 (PDT)
Message-ID: <f82fdfa3-8743-4d42-82d4-a4ca9bc24e15@arm.com>
Date: Wed, 24 Apr 2024 11:08:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
To: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org
References: <20240416121526.67022-1-axboe@kernel.dk>
 <20240416121526.67022-5-axboe@kernel.dk>
 <20240424100127.GV40213@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240424100127.GV40213@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 11:01, Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 06:11:21AM -0600, Jens Axboe wrote:
>> iowait is a bogus metric, but it's helpful in the sense that it allows
>> short waits to not enter sleep states that have a higher exit latency
>> than would've otherwise have been picked for iowait'ing tasks. However,
>> it's harmless in that lots of applications and monitoring assumes that
>> iowait is busy time, or otherwise use it as a health metric.
>> Particularly for async IO it's entirely nonsensical.
> 
> Let me get this straight, all of this is about working around
> cpuidle menu governor insaity?
> 
> Rafael, how far along are we with fully deprecating that thing? Yes it
> still exists, but should people really be using it still?
> 

Well there is also the iowait boost handling in schedutil and intel_pstate
which, at least in synthetic benchmarks, does have an effect [1].
io_uring (the only user of iowait but not iowait_acct) works around both.

See commit ("8a796565cec3 io_uring: Use io_schedule* in cqring wait")

[1]
https://lore.kernel.org/lkml/20240304201625.100619-1-christian.loehle@arm.com/#t

Kind Regards,
Christian

