Return-Path: <linux-kernel+bounces-143729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED1E8A3CBC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 14:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755F4B2185D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 12:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EB83E49D;
	Sat, 13 Apr 2024 12:49:01 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B782D7A8;
	Sat, 13 Apr 2024 12:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713012540; cv=none; b=m3em2SsIgtH+LHHL/KPGRbzye84Nz9LkFDEBmuvZs1Dj+VDkwWmVCYyp4d2SuVbk14bYuQqVtmfed304GidJCiD+MDLWJJFIgI5YWGnE2+opcdrPbM8SQk4n50VEa/Y02p/JMOpw/v9FgECzaFf+ZpmN1UH+AR8NX7UYjRg/ZXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713012540; c=relaxed/simple;
	bh=rQ7XFjYmCo15plBiewfhM9yUrSUu3tJha6ndkwlxQ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxrhxhc0rZS1XWNfVIKa3aLXJiWjlYLg3+ZlRFFac+2yCeZ2sCKV2JlBCGePvdKMJMHAVx1k/lBZgNTGmtBoPmkjBaA1taXVqqZkfGWklGY7sIY7iw9ia7INWwTbFgau5QRELAVPRv+vRboRximD6aqG4fXTxpYG2C6cHy7XDnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B9FC113CD;
	Sat, 13 Apr 2024 12:48:58 +0000 (UTC)
Date: Sat, 13 Apr 2024 08:48:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, primiano@google.com,
 aahringo@redhat.com, dcook@linux.microsoft.com, Josh Poimboeuf
 <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240413084857.147c6f40@rorschach.local.home>
In-Reply-To: <20240413105338.GD40213@noisy.programming.kicks-ass.net>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
	<20240412071245.GD30852@noisy.programming.kicks-ass.net>
	<20240412163724.GB467-beaub@linux.microsoft.com>
	<20240413105338.GD40213@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Apr 2024 12:53:38 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 12, 2024 at 09:37:24AM -0700, Beau Belgrave wrote:
> 
> > > Anyway, since we typically run stuff from NMI context, accessing user
> > > data is 'interesting'. As such I would really like to make this work
> > > depend on the call-graph rework that pushes all the user access bits
> > > into return-to-user.  
> > 
> > Cool, I assume that's the SFRAME work? Are there pointers to work I
> > could look at and think about what a rebase looks like? Or do you have
> > someone in mind I should work with for this?  
> 
> I've been offline for a little while and still need to catch up with
> things myself.
> 
> Josh was working on that when I dropped off IIRC, I'm not entirely sure
> where things are at currently (and there is no way I can ever hope to
> process the backlog).
> 
> Anybody know where we are with that?

It's still very much on my RADAR, but with layoffs and such, my
priorities have unfortunately changed. I'm hoping to start helping out
in the near future though (in a month or two).

Josh was working on it, but I think he got pulled off onto other
priorities too :-p

-- Steve

