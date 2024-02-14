Return-Path: <linux-kernel+bounces-65860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 667168552E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D485290EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B08A13A87D;
	Wed, 14 Feb 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXFiZn1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EBD12D768
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937565; cv=none; b=M+aTX6tsp/dZL0GBMqXH5KeVxgOUAeGFQQhngEgkePLUgniraoNepJhFtn9oSWtFQKrnKB8YEP0vUasqxuyzHPCL68XRHCibjqxX2wOBZAig3ETeSlLsUmlGSQfrQKt3Y4FpKMAtkKJunI9++XfwP0xBtMmyC8RU5um2g/TQtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937565; c=relaxed/simple;
	bh=1eBXhi+aN2hxjql0LiYY7CLtvXQBl0vtMMfB1UDrWnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A9T4/2xCjblLrqB+nnASOOj1g8RL29ezslD5rEphkpXGTwJvdz1u7LgWzKfI0hFezehXVpwojRcxthX9j2rreWTMbOsTt8K+46cVakxybYmTUFKpVMQcS03BYe3tKBZO0cOEQ0bRynqy/85MM5eoR9xIhXKWiQd3EZe13txPgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXFiZn1a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707937562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9W6Z7oRvVu2ZzbktRJ5MM+rsUMP98UB3Mb0fkhog7OI=;
	b=OXFiZn1azc8kNdYDLhRvtmt0U4oKiiSARik2IFG0TkuZm9MZ4k7KE4WlfybRH//CLwNIVH
	5iPsxfGXTTi9rBUHi57T1af6DTrcwc+EHuicUN4mUqQmMX/ROV8xhA/a6riSUrGA0L/g2J
	tmjwIGo+D90EUXMSzzYOPsSpCzodvQk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-dPQyhSKhM7i5mtN3w2TTgg-1; Wed, 14 Feb 2024 14:05:58 -0500
X-MC-Unique: dPQyhSKhM7i5mtN3w2TTgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB27D185A783;
	Wed, 14 Feb 2024 19:05:57 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DE65EC185C1;
	Wed, 14 Feb 2024 19:05:56 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 3DD66401E1F13; Wed, 14 Feb 2024 15:58:49 -0300 (-03)
Date: Wed, 14 Feb 2024 15:58:49 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 04/12] clockevent unbind: use smp_call_func_single_fail
Message-ID: <Zc0Naa3pwTyndUvK@tpad>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.928420669@redhat.com>
 <87jzngmqsw.ffs@tglx>
 <ZcN8zA4WaLx7c3qy@tpad>
 <87plx3l6wc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plx3l6wc.ffs@tglx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On Sun, Feb 11, 2024 at 09:52:35AM +0100, Thomas Gleixner wrote:
> On Wed, Feb 07 2024 at 09:51, Marcelo Tosatti wrote:
> > On Wed, Feb 07, 2024 at 12:55:59PM +0100, Thomas Gleixner wrote:
> >
> > OK, so the problem is the following: due to software complexity, one is
> > often not aware of all operations that might take place.
> 
> The problem is that people throw random crap on their systems and avoid
> proper system engineering and then complain that their realtime
> constraints are violated. So you are proliferating bad engineering
> practices and encourage people not to care.

Its more of a practicality and cost concern: one usually does not have
resources to fully review software before using that software.

> > Now think of all possible paths, from userspace, that lead to kernel
> > code that ends up in smp_call_function_* variants (or other functions
> > that cause IPIs to isolated CPUs).
> 
> So you need to analyze every possible code path and interface and add
> your magic functions there after figuring out whether that's valid or
> not.

"A magic function", yes.

> > The alternative, from blocking this in the kernel, would be to validate all 
> > userspace software involved in your application, to ensure it won't end
> > up in the kernel sending IPIs. Which is impractical, isnt it ?
> 
> It's absolutely not impractical. It's part of proper system
> engineering. The wet dream that you can run random docker containers and
> everything works magically is just a wet dream.

Unfortunately that is what people do.

I understand that "full software review" would be the ideal, but in most
situations it does not seem to happen.

> > (or rather, with such option in the kernel, it would be possible to run 
> > applications which have not been validated, since the kernel would fail
> > the operation that results in IPI to isolated CPU).
> 
> That's a fallacy because you _cannot_ define with a single CPU mask
> which interface is valid in a particular configuration to end up with an
> IPI and which one is not. There are legitimate reasons in realtime or
> latency constraint systems to invoke selective functionality which
> interferes with the overall system constraints.
> 
> How do you cover that with your magic CPU mask? You can't.
> 
> Aside of that there is a decent chance that you are subtly breaking user
> space that way. Just look at that hwmon/coretemp commit you pointed to:
> 
>   "Temperature information from the housekeeping cores should be
>    sufficient to infer die temperature."
> 
> That's just wishful thinking for various reasons:
> 
>   - The die temperature on larger packages is not evenly distributed and
>     you can run into situations where the housekeeping cores are sitting
>     "far" enough away from the worker core which creates the heat spot

I know.

>   - Some monitoring applications just stop to work when they can't read
>     the full data set, which means that they break subtly and you can
>     infer exactly nothing.
> 
> > So the idea would be an additional "isolation mode", which when enabled, 
> > would disallow the IPIs. Its still possible for root user to disable
> > this mode, and retry the operation.
> >
> > So lets say i want to read MSRs on a given CPU, as root.
> >
> > You'd have to: 
> >
> > 1) readmsr on given CPU (returns -EPERM or whatever), since the
> > "block interference" mode is enabled for that CPU.
> >
> > 2) Disable that CPU in the block interference cpumask.
> >
> > 3) readmsr on the given CPU (success).
> >
> > 4) Re-enable CPU in block interference cpumask, if desired.
> 
> That's just wrong. Why?
> 
> Once you enable it just to read the MSR you enable the operation for
> _ALL_ other non-validated crap too. So while the single MSR read might
> be OK under certain circumstances the fact that you open up a window for
> all other interfaces to do far more interfering operations is a red
> flag.
> 
> This whole thing is a really badly defined policy mechanism of very
> dubious value.
> 
> Thanks,

OK, fair enough. From your comments, it seems that per-callsite 
toggling would be ideal, for example:

/sys/kernel/interference_blocking/ directory containing one sub-directory
per call site. 

Inside each sub-directory, a "enabled" file, controlling a boolean 
to enable or disable interference blocking for that particular
callsite.

Also a "cpumask" file on each directory, by default containing the same
cpumask as the nohz_full CPUs, to control to which CPUs to block the
interference for.

How does that sound?


