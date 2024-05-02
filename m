Return-Path: <linux-kernel+bounces-166138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB448B96B2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B3A1F23B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30E3524C9;
	Thu,  2 May 2024 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXE/LURx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D350A88;
	Thu,  2 May 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639551; cv=none; b=RdOn0q5zJwiMktRR2MrD8sATgZO5UPxuK/Kj8ILZuCy+DkjYalOtdRtp7PvfhEkPQxTIE5XVuEP3s6s027TedNs3U2lkuOOdkX7xHflz6sp68NHnGUW/+FDdCJxBGdEIZflozUtFAk0JBwLwFRLGlLiLoCblooUyvZeW5D0L468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639551; c=relaxed/simple;
	bh=oqBfWlYmUrwyyjapwJqNsqrTwEaOMkpHH7sOf45lMOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNN+wbGNUnVNpovD8lKBgoI4pCCjAdqDznLEZulAlMijOK71MDGswIyayLEmGmbxyB6K2r2lpR3hI+Wmiivpzt9cHrjXnvMWQUkhNLI1WZT/+QYfxQaX5IurhZOCVWKE2Ue0bVqPskkJWTmN4To3N//4BHkmB6EhBw0pI5LOr+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXE/LURx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F8CC113CC;
	Thu,  2 May 2024 08:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714639550;
	bh=oqBfWlYmUrwyyjapwJqNsqrTwEaOMkpHH7sOf45lMOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXE/LURx0zaeD0T28AK/+RCTb/3lsoHyOSECYs4mzTcXWSTXTfcNW13HTcjoFu2sb
	 0/zdv/9zKCz7YuBbh3exdsoynAkG+t5c8DAJSqEIMtWqVv256foGUmvZ0fnsQFvK5V
	 /t/o0qEeNAtnsuPRyYpJeiEdDz4dVxdw57nHY7Da6MfJRfNkCazlacPeAZyf1HP02U
	 xbgeLj8lAD59StL68W+Ue8EjnSiTZMijwZjihBSfXYFZJv4F0Lmq8wDmuKIyNzbh6F
	 LNJ3SL1ept4+Kv9Xd5m8E/PRVB35v/RoBTsTvjvchqiMAJQiko27irRUFZowLLs7M1
	 1cH1+7cTCq7sQ==
Date: Thu, 2 May 2024 10:45:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>, 
	linux-api@vger.kernel.org, Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com, 
	carlos@redhat.com, Peter Oskolkov <posk@posk.io>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Chris Kennelly <ckennelly@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, Noah Goldstein <goldstein.w.n@gmail.com>, 
	Daniel Colascione <dancol@google.com>, longman@redhat.com, kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
Message-ID: <20240502-gezeichnet-besonderen-d277879cd669@brauner>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
 <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
 <f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>

On Wed, May 01, 2024 at 08:44:36PM -0300, André Almeida wrote:
> Hi Christian,
> 
> Em 26/04/2024 07:26, Christian Brauner escreveu:
> > On Thu, Apr 25, 2024 at 05:43:31PM -0300, André Almeida wrote:
> > > Hi,
> > > 
> > > In the last LPC, Mathieu Desnoyers and I presented[0] a proposal to extend the
> > > rseq interface to be able to implement spin locks in userspace correctly. Thomas
> > > Gleixner agreed that this is something that Linux could improve, but asked for
> > > an alternative proposal first: a futex operation that allows to spin a user
> > > lock inside the kernel. This patchset implements a prototype of this idea for
> > > further discussion.
> > > 
> > > With FUTEX2_SPIN flag set during a futex_wait(), the futex value is expected to
> > > be the PID of the lock owner. Then, the kernel gets the task_struct of the
> > > corresponding PID, and checks if it's running. It spins until the futex
> > > is awaken, the task is scheduled out or if a timeout happens.  If the lock owner
> > > is scheduled out at any time, then the syscall follows the normal path of
> > > sleeping as usual.
> > > 
> > > If the futex is awaken and we are spinning, we can return to userspace quickly,
> > > avoid the scheduling out and in again to wake from a futex_wait(), thus
> > > speeding up the wait operation.
> > > 
> > > I didn't manage to find a good mechanism to prevent race conditions between
> > > setting *futex = PID in userspace and doing find_get_task_by_vpid(PID) in kernel
> > > space, giving that there's enough room for the original PID owner exit and such
> > > PID to be relocated to another unrelated task in the system. I didn't performed
> > 
> > One option would be to also allow pidfds. Starting with v6.9 they can be
> > used to reference individual threads.
> > 
> > So for the really fast case where you have multiple threads and you
> > somehow may really do care about the impact of the atomic_long_inc() on
> > pidfd_file->f_count during fdget() (for the single-threaded case the
> > increment is elided), callers can pass the TID. But in cases where the
> > inc and put aren't a performance sensitive, you can use pidfds.
> > 
> 
> Thank you very much for making the effort here, much appreciated :)
> 
> While I agree that pidfds would fix the PID race conditions, I will move
> this interface to support TIDs instead, as noted by Florian and Peter. With
> TID the race conditions are diminished I reckon?

Unless I'm missing something the question here is PID (as in TGID aka
thread-group leader id gotten via getpid()) vs TID (thread specific id
gotten via gettid()). You want the thread-specific id as you want to
interact with the futex state of a specific thread not the thread-group
leader.

Aside from that TIDs are subject to the same race conditions that PIDs
are. They are allocated from the same pool (see alloc_pid()).

