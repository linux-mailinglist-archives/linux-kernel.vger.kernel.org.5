Return-Path: <linux-kernel+bounces-166484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56658B9B51
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59151C21ABF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D341A83CD1;
	Thu,  2 May 2024 13:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEP+fCsl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A957580A;
	Thu,  2 May 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655292; cv=none; b=KKYWM63XaXRfKBIkeH+L2S6+jqAFNT0V74ohbbyB2WUhiEGXhFjamb39y+QecTJQsf1c/fkIP9JpZF8MbqXNYqQKbCLuwkTunbMyS0mED2wl5EnMiFntkI4NU5ejTgHjmvZfPf3ZllQ/c9XXm7dQ57A9Z6mtryyZpPADyQw138I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655292; c=relaxed/simple;
	bh=k5KOH2RHPzrvgy56nRKWhjolv43Wf2+3vKU6xOlkz+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5zMPpI+UeWes/C5cpSZOT6d2BF37WoJ948lKU2uihyqbu2uXYzDlBwrfNSBLz9/C8I+bEg3xTYeT77sz2I2iSoMSpEN1CHObwhUtIOJv0VGdhPRAI6077PVKea9q8pjrm2NUidjmk0KAQ0uAbPDKZ5iwEBur2jqk11r2qlEnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEP+fCsl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F122C113CC;
	Thu,  2 May 2024 13:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714655291;
	bh=k5KOH2RHPzrvgy56nRKWhjolv43Wf2+3vKU6xOlkz+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEP+fCslkDiCXBWoib3/vE2nA3zyjK6T+9NcChZhIsb6rZbSukPaaVSgmsKsOuxXN
	 WQwftKhXPr1O7EK/iL6q+hVLYS9eOqu0p+g2nMYiCrS9swQbWDgY7caLHOQRvNj7e/
	 KxkMpehYRJsise3+duVhFqC6I037uK07URGiQtnoqm1iovoxMT21W6wqEXKPkAw0KS
	 TZ08f/sm49oxZee39RLL/FwgScmwgJzGAvWPq5pMl3SY85/TNK52iEq8A65bUnIutZ
	 SadWpDqsn2hVh9fuQbRORxcFa+h2gHP9Q9omgD+37Z4j8zlJMqjhV36J7l0TzwPVG8
	 U7TXOZnC21frg==
Date: Thu, 2 May 2024 15:08:02 +0200
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
Message-ID: <20240502-notversorgung-unerreichbar-2b2d434194cf@brauner>
References: <20240425204332.221162-1-andrealmeid@igalia.com>
 <20240426-gaumen-zweibeinig-3490b06e86c2@brauner>
 <f052ff72-72c9-4b83-9285-2cd9d52e5f72@igalia.com>
 <20240502-gezeichnet-besonderen-d277879cd669@brauner>
 <8734r0o81v.fsf@oldenburg.str.redhat.com>
 <20240502-sporen-pirschen-039688cd9efe@brauner>
 <871q6kmra1.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871q6kmra1.fsf@oldenburg.str.redhat.com>

On Thu, May 02, 2024 at 12:39:34PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> >> From a glibc perspective, we typically cannot use long-term file
> >> descriptors (that are kept open across function calls) because some
> >> applications do not expect them, or even close them behind our back.
> >
> > Yeah, good point. Note, I suggested it as an extension not as a
> > replacement for the TID. I still think it would be a useful extension in
> > general.
> 
> Applications will need a way to determine when it is safe to close the
> pidfd, though.  If we automate this in glibc (in the same way we handle
> thread stack deallocation for example), I think we are essentially back
> to square one, except that pidfd collisions are much more likely than
> TID collisions, especially on systems that have adjusted kernel.pid_max.
> (File descriptor allocation is designed to maximize collisions, after
> all.)

(Note that with pidfs (current mainline), pidfds have 64bit unique inode
numbers that are unique for the lifetime of the system. So they can
reliably be compared via statx() and so on.)

