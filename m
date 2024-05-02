Return-Path: <linux-kernel+bounces-166291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C178B98A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31CC1F21037
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E257333;
	Thu,  2 May 2024 10:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzJP+SvA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FB856473;
	Thu,  2 May 2024 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644860; cv=none; b=DBU+SLTLWk+jLLQTfUEbLUScJ7fdNCr/42w6o/Ydf1qeHFU10n5gQdnKjJcDd8xxfAtFWHjuSnhK7al0CPh1gpRKFyVLTxrghWG1sOADEwKBv4fpW4AffP96sCRukxwuNNwgp+f1jeelt1T+al2YayNElX5cYuHEmhy++ICB/eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644860; c=relaxed/simple;
	bh=5XpWbWIhxFUZI/YCKfXjNwyTyIzy1sdtf9OuMyUXKNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGMLY/aQo2euRDwzPu+TFh2qG9XslFllEZq52ioB2dW+IUZJD+SU14F40lXNGmCLLrld2ElRkKHXYNSBQZo+VKRwyAzF15MxLEofy6OSrYr//zjPKU3y/kE9I1ARW66WlPDybOTb0WoYzcW5D94GkhBoZO0kmkKJDCwifaWcARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzJP+SvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290F8C113CC;
	Thu,  2 May 2024 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644859;
	bh=5XpWbWIhxFUZI/YCKfXjNwyTyIzy1sdtf9OuMyUXKNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mzJP+SvApqEh+wRHM9AtEb1PD89Ml3thOfiV8TuA71LR2uH2KNRxvLPrLflCMUb5b
	 JzNnWDxxRvti2MDR6oB4cVjVmkKSMDpEVKxRSS3gJf5GK8H30ogjUbYmxEQx+OdIGD
	 d5px0xzWddXxYLLDdCY8h3Kw+n1+gaBeoqDRJwrlQ0ZcbGpRHlatNh7nE4Vt4CxjGZ
	 cFbBAGrG3T4z/vlpQhD+gY4lgZ0QAFk3uXdaX9tcg2+OLTRCe2Z1nRTiVGpL1EgCiQ
	 LdwGB9C/74k7Nj/Plgc8kLynok/JPXDAR6cZEt+RgNmZOjUh2KssQytwbuR368qeB3
	 gQtxGkXg9Bvrg==
Date: Thu, 2 May 2024 12:14:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>, linux-api@vger.kernel.org, 
	David.Laight@aculab.com, carlos@redhat.com, Peter Oskolkov <posk@posk.io>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Chris Kennelly <ckennelly@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, libc-alpha@sourceware.org, Steven Rostedt <rostedt@goodmis.org>, 
	Jonathan Corbet <corbet@lwn.net>, Noah Goldstein <goldstein.w.n@gmail.com>, 
	Daniel Colascione <dancol@google.com>, longman@redhat.com, kernel-dev@igalia.com
Subject: Re: [RFC PATCH 0/1] Add FUTEX_SPIN operation
Message-ID: <20240502-sporen-pirschen-039688cd9efe@brauner>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
 <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
 <f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
 <20240502-gezeichnet-besonderen-d277879cd669@brauner>
 <8734r0o81v.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8734r0o81v.fsf@oldenburg.str.redhat.com>

On Thu, May 02, 2024 at 11:51:56AM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > Unless I'm missing something the question here is PID (as in TGID aka
> > thread-group leader id gotten via getpid()) vs TID (thread specific id
> > gotten via gettid()). You want the thread-specific id as you want to
> > interact with the futex state of a specific thread not the thread-group
> > leader.
> >
> > Aside from that TIDs are subject to the same race conditions that PIDs
> > are. They are allocated from the same pool (see alloc_pid()).
> 
> For most mutex types (but not robust mutexes), it is undefined in
> userspace if a thread exits while it has locked a mutex.  Such a usage
> condition would ensure that the race doesn't happen, I believe.

The argument is a bit shaky imho because the race not being able to
happen is predicated on no one being careless enough to exit with a
mutex held. That doesn't do anything against someone doing it on
purpose.

> 
> From a glibc perspective, we typically cannot use long-term file
> descriptors (that are kept open across function calls) because some
> applications do not expect them, or even close them behind our back.

Yeah, good point. Note, I suggested it as an extension not as a
replacement for the TID. I still think it would be a useful extension in
general.

