Return-Path: <linux-kernel+bounces-64006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A5F8538EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF5AD1F240D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472B604C6;
	Tue, 13 Feb 2024 17:48:15 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32DE6024B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846494; cv=none; b=pnl9pssd3k7HY85LXSBY5EyW5s4V7ZSbkSIL8X2nzutWzo6q/90FxNGh5zA9xE5HcIGh/HXyiyj6PrD7mB2qhRntnP/cF8qgmtEOPSibnT2FqK29ZiYfKSvL2UTH2VG52H8d+h+s+mOC2OCRs9qMjq7C1FFdNEl9PeuzlSvCV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846494; c=relaxed/simple;
	bh=Zp4N98jbxRMN7izLUiOWmzOfJl0erx+bAJNq1h1TidU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foUmyD0MLpcmJHq0IEuQ+IWmZguw/pi5fnA7kOt5Oca6UZtTb7MMyw4S9YL/R/+8XNf/hjF5FSWEkOSYvWR+b2UZhppf/jrakrw9s+3Oyi50fmLGPGPCVA4rW3MGe0rwHQzIKL6A9BvzYaprB0Qfych27J6Vta+1mleLS7Zwisc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4FA3C433C7;
	Tue, 13 Feb 2024 17:48:13 +0000 (UTC)
Date: Tue, 13 Feb 2024 12:48:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Daniel Bristot de Oliveira
 <bristot@kernel.org>, John Kacur <jkacur@redhat.com>, limingming3
 <limingming890315@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] tracing/tooling: Fixes for v6.8-rc4
Message-ID: <20240213124858.0faf6207@gandalf.local.home>
In-Reply-To: <CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com>
References: <20240212170107.60da326a@gandalf.local.home>
	<CAHk-=wjQ9BJKBPi3sJN2Dy5jVwPO03u9aOc6-g8AnLcGq-E4-g@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 09:32:26 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 12 Feb 2024 at 14:00, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Tracing tooling updates for 6.8-rc4:  
> 
> Bah. I've pulled this, but since I did a new system install due to a
> disk upgrade some time ago, I once again don't have libtracefs-devel
> installed.
> 
> And guess what? The dependency rules are - once again  - completely
> broken, and trying to build this gets the bad old unhelpful error
> 
>    latency-collector.c:26:10: fatal error: tracefs.h: No such file or directory
> 

Hmm, that's not from this pull request. But still needs to be fixed.

> with no help for the user.
> 
> Yes, I know what to do. That isn't the point. And no, this isn't new
> to this pull request, it's just that on this machine I haven't tried
> building the tracing tools in a while.
> 
> Let's not make the user experience for people who want to do kernel
> builds any worse than it has to be.
> 
> Side note: instead of the (clearly broken) special Makefile rules, can
> you please just take a look at the perf code instead?  In fact, maybe
> it's time for the kernel tooling people to try to unify and come to an
> agreement about these things, and share more of the code.
> 
> Because unlike the tracing tools, the perf tools seem to generally get
> this part of the build system right, despite (or probably due to)
> having a lot *more* (and more complex) library dependencies.

Daniel is mostly maintaining this work.

Daniel, can you talk with Arnaldo and be able to collaborate with him on
consolidating the build process?

I'm even fine if this starts going through Arnaldo's tree as I'm not really
using it for my work anymore. I just did a smoke test, but as I have the
necessary libraries, it didn't fail for me.

Thanks!

-- Steve


