Return-Path: <linux-kernel+bounces-159843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE73B8B350E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8BF91C2148A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2D5143881;
	Fri, 26 Apr 2024 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rQRPqrFJ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C6013D53C;
	Fri, 26 Apr 2024 10:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126503; cv=none; b=aJKXtkYEqm/3eoIKGPy5qU7iPTMP/o6V3zGIo4rgNr2ye0gc9gQelNsIQvXKwNz936IhjQnWlbwIK3R2D95J+qDP4G364vlV7iliEq+s1GvlBJayFlsfouJ3cAB5i2Ma3RQRsI1r/JzZDPu6hgOmKWbqI4MVcPyh7TdC1GMM/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126503; c=relaxed/simple;
	bh=ALcIRln45Y/G2JaG5UVvoiGMeRWE02AZbGsl22MTiPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/9/1n9hxt2/RjG0s5/VLv7RzIikA0Kggq4oNMGO7CAzHSHGd/cLprtWXo8q/F4VR7opqcUiBHZEhnH3fvRB1IoZW1nWnmXwJYOi0gUUmnlxIKXiO+V62n5g5pYviEt8CsbTIgQuesFex8wMUtsG+1oFWnwcubbmkaMn1QSmg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rQRPqrFJ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ryVjswdoVqQB3NDQl33vADKSu7VWuONlL8jqOs+n9Sc=; b=rQRPqrFJRAj/wPN4+4jEVy5+g6
	DkVhX3SxFUbWNnMCLhscqUhlHshGMr3IIXxvs1pePUypW+E/rp8SF6BTwgkeBbwi+Co0Pyoka4lG/
	FUuaWXY8IsgUZynPjdIb+JmW1g9RmkcbF9V4hzEPJ5mCuAOFTWVupuig5rXp/EoHP/jeFBKNNqT9L
	C7b5b/b2wgVP8QbeuwNoNCa+ElthXH3shJKTuIruKaTJuIBTZwIrkMSyzay6LytNickkC4QhVbcgK
	NMQdK4Wfv5PzKS02/chz/QDtiA/MdrYTej0+wjIhkRghMu0qsTWHMderpRfW7qdfmof+oM3xwfIru
	9l4U4qKQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0IbH-0000000FHLR-0ngO;
	Fri, 26 Apr 2024 10:14:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6DD63003EA; Fri, 26 Apr 2024 12:14:38 +0200 (CEST)
Date: Fri, 26 Apr 2024 12:14:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
	linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	David.Laight@aculab.com, carlos@redhat.com,
	Peter Oskolkov <posk@posk.io>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Chris Kennelly <ckennelly@google.com>,
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Noah Goldstein <goldstein.w.n@gmail.com>,
	Daniel Colascione <dancol@google.com>, longman@redhat.com,
	kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
Message-ID: <20240426101438.GA39183@noisy.programming.kicks-ass.net>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
 <875xw44fxk.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875xw44fxk.fsf@oldenburg.str.redhat.com>

On Fri, Apr 26, 2024 at 11:43:51AM +0200, Florian Weimer wrote:
> * André Almeida:
> 
> > With FUTEX2_SPIN flag set during a futex_wait(), the futex value is
> > expected to be the PID of the lock owner. Then, the kernel gets the
> > task_struct of the corresponding PID, and checks if it's running. It
> > spins until the futex is awaken, the task is scheduled out or if a
> > timeout happens.  If the lock owner is scheduled out at any time, then
> > the syscall follows the normal path of sleeping as usual.
> 
> PID or TID?

TID, just like PI_LOCK I would presume.

> I think we'd like to have at least one, possibly more, bits for free
> use, so the kernel ID comparison should at least mask off the MSB,
> possibly more.

Yeah, it should be using FUTEX_TID_MASK -- just like PI_LOCK :-)

I suppose the question is if this thing should then also imply
FUTEX_WAITERS or not.

