Return-Path: <linux-kernel+bounces-143087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2538A33EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C5B28383E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5C14AD36;
	Fri, 12 Apr 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kSFk5pfr"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE96B54F87;
	Fri, 12 Apr 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712939848; cv=none; b=h3j1fjPByaD7r42I7XOziFaC2f/SdWnGKLYZQa1fP7K/8vWPPyI+HwuaqeoLSTtwePjxvkBbjY3EeOt0eBcqySiK9Znudouz7QUtqsxMyQG85SasvfKN+rvLOYxPnV8UiITh3NAwX4g8VJECY/mJcN+vr+eAIssRRebpR4dDYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712939848; c=relaxed/simple;
	bh=eL+ycS6nm/gRr9yhEhYX/pOUHc+TkWYvKl79Vg5f0UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmR+xFzVFprOGHUXHvnjmopCirrDay0ZRli9Y59au84T/5DK3i1Q8lqgfn+9IXN6tCEi4+4q42+ICc1/gbsbc0KXO4HDcfeUxfXk69AoO+7+wUWHeH6PmPTtc4D8uuMGWtA5DUycHmL1b9R9QHz6Q4YgrNCE9To134/fE78vNd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kSFk5pfr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-4OLSCEK. (c-76-135-27-212.hsd1.wa.comcast.net [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A58820EB6FE;
	Fri, 12 Apr 2024 09:37:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A58820EB6FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712939846;
	bh=F8k2W578S74gEQH7nGfTYFa4dfuC5RV0P7eTtRq6MY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kSFk5pfrvg55LjL3zroE9m99IK/0FdkTymKgUmYyJSEcxiagBsbhgKXErbzvVv4sf
	 24bgyXCauiYLXXjX3Ews6tPGFsxWvo/vD3mZ7rIsymplry2uUWjA7agDHcUyI8lgYT
	 kOFAgjP9DrpLPbkoXPaNYX05bA5jIvtezCBUb5d8=
Date: Fri, 12 Apr 2024 09:37:24 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, primiano@google.com,
	aahringo@redhat.com, dcook@linux.microsoft.com
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240412163724.GB467-beaub@linux.microsoft.com>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
 <20240412071245.GD30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412071245.GD30852@noisy.programming.kicks-ass.net>

On Fri, Apr 12, 2024 at 09:12:45AM +0200, Peter Zijlstra wrote:
> 
> On Fri, Apr 12, 2024 at 12:17:28AM +0000, Beau Belgrave wrote:
> 
> > An idea flow would look like this:
> > User Task		Profile
> > do_work();		sample() -> IP + No activity
> > ...
> > set_activity(123);
> > ...
> > do_work();		sample() -> IP + activity (123)
> > ...
> > set_activity(124);
> > ...
> > do_work();		sample() -> IP + activity (124)
> 
> This, start with this, because until I saw this, I was utterly confused
> as to what the heck you were on about.
> 

Will do.

> I started by thinking we already have TID in samples so you can already
> associate back to user processes and got increasingly confused the
> further I went.
> 
> What you seem to want to do however is have some task-state included so
> you can see what the thread is doing.
> 

Yeah, there is typically an external context (not on the machine) that
wants to be tied to each sample. The context could be a simple integer,
UUID, or something else entirely. For OTel, this is a 16-byte array [1].

> Anyway, since we typically run stuff from NMI context, accessing user
> data is 'interesting'. As such I would really like to make this work
> depend on the call-graph rework that pushes all the user access bits
> into return-to-user.

Cool, I assume that's the SFRAME work? Are there pointers to work I
could look at and think about what a rebase looks like? Or do you have
someone in mind I should work with for this?

Thanks,
-Beau

1. https://www.w3.org/TR/trace-context/#version-format

