Return-Path: <linux-kernel+bounces-138800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C0E89FA80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5032C285A38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E9816F0C3;
	Wed, 10 Apr 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b07fLTai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC07816131C;
	Wed, 10 Apr 2024 14:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760179; cv=none; b=jc7M/tlfOyHt7HDp1znR5hKNi3dSTMsEgVPRpjRuQ3bzsposMEoBHBDvNKZma53fqF1u4zfZGUG/+5IMJLGmHMBZvgBGVV1eoKdnhtCz+9qzQ5S/PvHQtsAOkkM5JTWLehEx7CyHqG+WXD5s9p9OMkaws8fVcsSWestvSy+aWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760179; c=relaxed/simple;
	bh=luoVgNyj4zzwwoGosR+LKd29Ur7JRFYhyAO39bS3iYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0ZZJdEgvxxQXGUZMGZa8unUx7JwfP/et4TU/mCow6rKqeJqiUpFI0rmQIrht6nGkbLK/KnFpDgSzeAhsAuLQLrBnIag69QCtwZpLcziOUe0apmgtphNyqO4Ez2M8DsMazyE9FEcyvM8N9f1G/S1Fmpu0JOw+yoJbMnRfLM3GC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b07fLTai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AC9C433C7;
	Wed, 10 Apr 2024 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712760179;
	bh=luoVgNyj4zzwwoGosR+LKd29Ur7JRFYhyAO39bS3iYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b07fLTaipG3I0kSFOt/zafbbHHiO4S32fLcqmYd6q0R37s3ScVmqRr1uG2MBoOyAS
	 T81YMrNBgj2dJG1nDvP8oXw3IBGjaIduAuo4sfs7kypXW6perKZOQa8tj9dxeoImIN
	 MbruKyDrUpoVlILRrZEPaBctf6piqLJtrAi+t+pBHG8VtAthdxbt62CbDhpDkhcE0M
	 MZcOGJOZxVs9dEa/zznCVHr+2aWv/B5aP4yLYyVld1u4TDwaVRTzEbzHFFEB6P2Ymr
	 z4cqJc2EvNO+hl43NNh/54nap8qjZcfyye30Y1vntHhuq6oiAbB3Ab2uEKUEhYe3FU
	 Hj9WQB0qtU6wg==
Date: Wed, 10 Apr 2024 16:42:56 +0200
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
Message-ID: <ZhalcBcd3w0w2HD_@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
 <20240410134702.dcWYciZB@linutronix.de>
 <ZhabcanCbQej1azv@localhost.localdomain>
 <20240410140633.0MHBLpMI@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410140633.0MHBLpMI@linutronix.de>

Le Wed, Apr 10, 2024 at 04:06:33PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-10 16:00:17 [+0200], Frederic Weisbecker wrote:
> > Le Wed, Apr 10, 2024 at 03:47:02PM +0200, Sebastian Andrzej Siewior a écrit :
> > > On 2024-04-10 13:37:05 [+0200], Frederic Weisbecker wrote:
> > > > > Couldn't we either flush _or_ remove the task_work in perf_release()?
> > > > 
> > > > Right so the problem in perf_release() is that we may be dealing with task works
> > > > of other tasks than current. In that case, task_work_cancel() is fine if it
> > > > successes. But if it fails, you don't have the guarantee that the task work
> > > > isn't concurrently running or about to run. And you have no way to know about
> > > > that. So then you need some sort of flushing indeed.
> > > 
> > > Since perf_release() preemptible, a wait/sleep for completion would be
> > > best (instead of flushing).
> > 
> > Like this then?
> > 
> > https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50
> 
> Kind of, yes. Do we have more than one waiter? If not, maybe that
> rcuwait would work then.

Indeed there is only one waiter so that should work. Would
that be something you can call while preemption is disabled?

Thanks.

> Otherwise (>1 waiter) we did establish that we may need a per-task
> counter for recursion handling so preempt-disable shouldn't be a problem
> then. The pending_work_wq must not be used outside of task context (means
> no hardirq or something like that).
> 
> Sebastian

