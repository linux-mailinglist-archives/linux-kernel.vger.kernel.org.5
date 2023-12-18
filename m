Return-Path: <linux-kernel+bounces-4035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC5817702
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010151F25C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13A649892;
	Mon, 18 Dec 2023 16:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gb1u82cG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FBD3D546;
	Mon, 18 Dec 2023 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702915758; x=1734451758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=swCu2ES7Jorb4M6K59myq2bEWQMpG0kDhJu6Hra6UJE=;
  b=Gb1u82cG8HSox2lSLTR29SUznKrbkzDJy38eWBcSfGvuOZ3/iLagEOOw
   XtyqZVq9LEmD6/5A7jKYwQSs3hMifD1ptdf8mbsV+ukcGWDkWa//Vg/Uw
   QEUlYmUrY80RnxJMSslbifMzW5JXz/fz5FmX2+H9/BvEQmeIPv+G5Pv8C
   G99/a1AgXMyUC8MOOz4seSlz9EUdJAsu6sAAMBuIkSfTQ8RRP0QM+1uMw
   6Wc+iKuwdLJDq0iF6zQvY0hW2+AQ7rLc2gXYq8E3p/qSEv8B4Mh6LcsTd
   QaZfPD/dEZfserhGuoND/BZh/QV1yKWAKG06AvdvY7NfGvhDZFUPFB/wV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="8897210"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="8897210"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 08:09:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="899021765"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="899021765"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 08:09:16 -0800
Date: Mon, 18 Dec 2023 08:11:00 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ramses VdP <ramses@well-founded.dev>
Subject: Re: Fwd: Intel hybrid CPU scheduler always prefers E cores
Message-ID: <20231218161100.GA7839@ranerica-svr.sc.intel.com>
References: <01df8329-06d7-4fd1-9c7a-05296f33231e@gmail.com>
 <20231128140225.GS8262@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128140225.GS8262@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Nov 28, 2023 at 03:02:25PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 28, 2023 at 08:22:27PM +0700, Bagas Sanjaya wrote:
> > Hi,
> > 
> > I come across an interesting bug report on Bugzilla [1]. The reporter
> > wrote:
> 
> Thanks for forwarding, what happend in bugzilla staysi in bugzilla etc..
> 
> Did you perchance Cc the reporter?
> 
> > > I am running an intel alder lake system (Core i7-1260P), with a mix
> > > of P and E cores.
> > > 
> > > Since Linux 6.6, and also on the current 6.7 RC, the scheduler seems
> > > to have a strong preference for the E cores, and single threaded
> > > workloads are consistently scheduled on one of the E cores.
> > > 
> > > With Linux 6.4 and before, when I ran a single threaded CPU-bound
> > > process, it was scheduled on a P core. With 6.5, it seems that the
> > > choice of P or E seemed rather random.
> > > 
> > > I tested these by running "stress" with different amounts of
> > > threads. With a single thread on Linux 6.6 and 6.7, I always have an
> > > E core at 100% and no load on the P cores. Starting from 3 threads I
> > > get some load on the P cores as well, but the E cores stay more
> > > heavily loaded.  With "taskset" I can force a process to run on a P
> > > core, but clearly it's not very practical to have to do CPU
> > > scheduling manually.
> > > 
> > > This severely affects single-threaded performance of my CPU since
> > > the E cores are considerably slower. Several of my workflows are now
> > > a lot slower due to them being single-threaded and heavily CPU-bound
> > > and being scheduled on E cores whereas they would run on P cores
> > > before.
> > > 
> > > I am not sure what the exact desired behaviour is here, to balance
> > > power consumption and performance, but currently my P cores are
> > > barely used for single-threaded workloads.
> > > 
> > > Is this intended behaviour or is this indeed a regression? Or is
> > > there perhaps any configuration that I should have done from my
> > > side? Is there any further info that I can provide to help you
> > > figure out what's going on?
> > 
> > PM and scheduler people, is this a regression or works as intended?
> 
> AFAIK that is supposed to be steered by the ITMT muck and I don't think
> we changed that.
> 
> Ricardo?

Sorry for the late reply. This email was buried in a ton of email. To
complete report here, Srinivas helped to debug the issue. The problem is
that the computer in question lacks the necessary ACPI support to use ITMT.

A new firmware release appears to have solved the issue.

Thanks and BR,
Ricardo

