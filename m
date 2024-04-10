Return-Path: <linux-kernel+bounces-138710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7E489F9DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC587B2E9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3517E160780;
	Wed, 10 Apr 2024 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fegQ3CO9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BF615FA85;
	Wed, 10 Apr 2024 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757620; cv=none; b=PIuuD+Qqocq08IUs5qmXCOEMub9pFqptgogoMQnxsPAWEfuHOSq947TWXHzymKbinfZDaGST2HymhgReAgVNhjjT4JEF3FmjX4+tq6qt3B8R9wqLRmLNs4+aEkXyluZlHndEzfAVNs61zmsC56P7m4kNCgUYNAZQoiYphlyTkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757620; c=relaxed/simple;
	bh=X2T9/6im6fX+kU9/Z4tPG9Rx1cuH7ekkKBiLwPpECEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaxDJvgrwl2fBxJ59Tbf+RDG/7eYej8ZrQ9FEtieb9/cHUNvXMQDJ0jnR+w++2WdL+rbexniK/qR6Yzf9Yv8GVUcJroXSbXkhCXcCkdCk2QRQT07uYF2/eGI5TnotcvfAZWJciePHNdB7gWwhpR42+pQROOVqP2XMsFSBUlc4KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fegQ3CO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDE3C433F1;
	Wed, 10 Apr 2024 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712757620;
	bh=X2T9/6im6fX+kU9/Z4tPG9Rx1cuH7ekkKBiLwPpECEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fegQ3CO9RVfuDhv50USvMf/NWXuaO4FBE4zgHKwL2I6xQMUsrYWQEKQUgIhIkM6/r
	 vwP7NIir6MYiqhUkh62e5pEabN4wptOuKHGCpUgM/dABEQqYGPPdxylu+UQ0njq/ui
	 bvHqCtCBK1P7uuHKTcf1qGU+PdQivHleXQWfOroIy4NByha9JDvUjRZqVpH7E/LoU/
	 XiWKCBFOfSpxriFQKqUabQqj7fDD7ZFFJnOHLEw9M7FUp9NPKeJtQB8KHfwHfStujm
	 ZoXBIrAB1fg10DVpOXiZ+AZVg5PjagnncQgLqmGfKrsJeQMaUWLj+vfBHo1qnvB6Um
	 YoOIYtcmAB8TQ==
Date: Wed, 10 Apr 2024 16:00:17 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <ZhabcanCbQej1azv@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
 <20240410134702.dcWYciZB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410134702.dcWYciZB@linutronix.de>

Le Wed, Apr 10, 2024 at 03:47:02PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-10 13:37:05 [+0200], Frederic Weisbecker wrote:
> > > Couldn't we either flush _or_ remove the task_work in perf_release()?
> > 
> > Right so the problem in perf_release() is that we may be dealing with task works
> > of other tasks than current. In that case, task_work_cancel() is fine if it
> > successes. But if it fails, you don't have the guarantee that the task work
> > isn't concurrently running or about to run. And you have no way to know about
> > that. So then you need some sort of flushing indeed.
> 
> Since perf_release() preemptible, a wait/sleep for completion would be
> best (instead of flushing).

Like this then?

https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50

> > Thanks.
> > 
> > > > Thanks.
> 
> Sebastian

