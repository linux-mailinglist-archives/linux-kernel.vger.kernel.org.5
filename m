Return-Path: <linux-kernel+bounces-150844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E23098AA588
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71997B22A86
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C084DA03;
	Thu, 18 Apr 2024 22:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2f1SG8l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68139855;
	Thu, 18 Apr 2024 22:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480798; cv=none; b=d3iKtg8+xMSu0JwU5kBL1sPJ9gQ30jktCMmWI52tSe+Y/Q5o6t1e93HbrlUliYxZW7TBeQJMg/tkNKIWKf4rFrC2eMtNE0B741332iluyH73UWab15sddr5jcVgKHHRZKaiC5k4BzaVwFGMFKrh/E8a5uITscQ0rzk5tRQ9Q5Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480798; c=relaxed/simple;
	bh=HFF4ul5e2v3wwoR8XKGER96ZYBoacAgLz1f7S8OlMp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYqbQzkm5NNUyWjxRZSVHFoxp0+Q5ShhGYhVqPXIwUC922y4Cc0tvcgE0gDbndi3vubwwRwiSTqG3+Q2+4MY2IvSCd/HtqDQjbUoFlN673BYa9Xp7+u1jxf9fWDE52lsRtvRDUSNdJSMnmr3PtcH/Z4vdwInrudcv/DQp7xf67Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2f1SG8l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A93C113CC;
	Thu, 18 Apr 2024 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713480797;
	bh=HFF4ul5e2v3wwoR8XKGER96ZYBoacAgLz1f7S8OlMp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D2f1SG8lCa6blXcpsdIZTtO0+7BojWCA9IOcR05QReQ4ZVGaXCVUm0oJNkbBgr+8X
	 1ig+1scVjgZYKkw0Ak33XcuhRrdGzXI18rDJ5IehHxyv53jwGmMK2X/t6ZLM6RqUTw
	 PulWa7VN+97ABrIMFnuI3YnFyMPNQyrxLFRWm4pWi3781Sagm9DrSBSHU/XpC/iLyk
	 F2ilZgbYAZNLV2e5TOo30I3cYc7uf8xtzStU37d1aal3uxM9rA+IwnzdzzeBDjmPie
	 qfbjjhiL/v/iMK+wLue5QcjY+BFKMP/JA2Z+zlp5laT4+th1/+zuDFxaab7TuNZAF+
	 wZvGplm/Xep8Q==
Date: Thu, 18 Apr 2024 15:53:14 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Beau Belgrave <beaub@linux.microsoft.com>, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, primiano@google.com,
	aahringo@redhat.com, dcook@linux.microsoft.com,
	Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240418225314.rbg7qwszbsvezz76@treble>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
 <20240412071245.GD30852@noisy.programming.kicks-ass.net>
 <20240412163724.GB467-beaub@linux.microsoft.com>
 <20240413105338.GD40213@noisy.programming.kicks-ass.net>
 <20240413084857.147c6f40@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240413084857.147c6f40@rorschach.local.home>

On Sat, Apr 13, 2024 at 08:48:57AM -0400, Steven Rostedt wrote:
> On Sat, 13 Apr 2024 12:53:38 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Apr 12, 2024 at 09:37:24AM -0700, Beau Belgrave wrote:
> > 
> > > > Anyway, since we typically run stuff from NMI context, accessing user
> > > > data is 'interesting'. As such I would really like to make this work
> > > > depend on the call-graph rework that pushes all the user access bits
> > > > into return-to-user.  
> > > 
> > > Cool, I assume that's the SFRAME work? Are there pointers to work I
> > > could look at and think about what a rebase looks like? Or do you have
> > > someone in mind I should work with for this?  
> > 
> > I've been offline for a little while and still need to catch up with
> > things myself.
> > 
> > Josh was working on that when I dropped off IIRC, I'm not entirely sure
> > where things are at currently (and there is no way I can ever hope to
> > process the backlog).
> > 
> > Anybody know where we are with that?
> 
> It's still very much on my RADAR, but with layoffs and such, my
> priorities have unfortunately changed. I'm hoping to start helping out
> in the near future though (in a month or two).
> 
> Josh was working on it, but I think he got pulled off onto other
> priorities too :-p

Yeah, this is still a priority for me and I hope to get back to it over
the next few weeks (crosses fingers).

-- 
Josh

