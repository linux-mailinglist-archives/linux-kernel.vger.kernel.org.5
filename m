Return-Path: <linux-kernel+bounces-142118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B88A27C0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1ED281E29
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3C0487BE;
	Fri, 12 Apr 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zg64MBKu"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887C481AB;
	Fri, 12 Apr 2024 07:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905979; cv=none; b=SKPTwMSbgVL3Yr8dI7nuF8RP8jZHrHHlr5qvN39QivGIPg4D8vra37VNQ0D5rwOQz4DAfkxcjvaTyANr3jkKmfroSzoC4VxG+ZnJ8iELyAM98514yXkseEninZp7Gq3CDs3o0BbpABLizBtDQaEj8XQ3cIQnwSPk1bIXfLoKsZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905979; c=relaxed/simple;
	bh=5x2jFoU5DuR57h1J8q58G8yoyZ8mwcGdrvO0GUMHLyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtJbbrcXYiSvtf7FEbAZAiILz1HSsuElNMWdfhQZ+glwk6EKBmflvSYDj/bOGhXwjXtjO1T4yFeH2LslIQEfdeLuIym59UuuaaoAXk+HWuy+fe+APtqglZmmNy5jUNr0FLyNZdZRq6Rdgua1vgo4WTPsMw2FFsyHlr23E2/O/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zg64MBKu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CCFPztXbfdYRDBrYBi92PcWMF02qgz6C60bYJi8oS+c=; b=Zg64MBKu6bUYjikE4hB/M8oP+s
	GwIxJNEbPiFygoNP+8DHKB/LPGmc+RggrB3sNzj7vn0fC9ZanMjIvGdXxE1Wt6rGywk1/FoKzVuZH
	tb0Y/30j2+ID3oWnazfHe9o3hfKMzwodIGuMlMThQu/umh8m+7k3NkL9j0uqABxB2CYo0K466lQt3
	r6ZhDhvsIaWFwlu4maYBiYF//jIIWfAFSqAVdA5ymd/vhw3SmGW4m2HN25Dm6db7bpeMxmYOBj2gC
	0YPy7TNauyL9lCqWmhZYu0sh06Q7h1pn6njcwAtycJ3WZMyVal2I88yKw8jCVn5oPmQ0jSNUltfoE
	GhAz8B/w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvB5Z-00000008e3A-3FmK;
	Fri, 12 Apr 2024 07:12:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6DF5F3006AB; Fri, 12 Apr 2024 09:12:45 +0200 (CEST)
Date: Fri, 12 Apr 2024 09:12:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com, primiano@google.com,
	aahringo@redhat.com, dcook@linux.microsoft.com
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
Message-ID: <20240412071245.GD30852@noisy.programming.kicks-ass.net>
References: <20240412001732.475-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412001732.475-1-beaub@linux.microsoft.com>


On Fri, Apr 12, 2024 at 12:17:28AM +0000, Beau Belgrave wrote:

> An idea flow would look like this:
> User Task		Profile
> do_work();		sample() -> IP + No activity
> ...
> set_activity(123);
> ...
> do_work();		sample() -> IP + activity (123)
> ...
> set_activity(124);
> ...
> do_work();		sample() -> IP + activity (124)

This, start with this, because until I saw this, I was utterly confused
as to what the heck you were on about.

I started by thinking we already have TID in samples so you can already
associate back to user processes and got increasingly confused the
further I went.

What you seem to want to do however is have some task-state included so
you can see what the thread is doing.

Anyway, since we typically run stuff from NMI context, accessing user
data is 'interesting'. As such I would really like to make this work
depend on the call-graph rework that pushes all the user access bits
into return-to-user.

