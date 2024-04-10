Return-Path: <linux-kernel+bounces-138813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49AA89FAAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126601C22A20
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C54A17996A;
	Wed, 10 Apr 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDBIBuC7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05D174EE9;
	Wed, 10 Apr 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760616; cv=none; b=fjx2Z5kewUPfLRvQmsE6CygB3HHNemJL2YxSWXseT7YOCE3HRWMURBdyG9PuSganALikThQIwl/MtSotQ8LUZ01ZFWVBaGrTXp193o7IuqBUe28xzDnx7EFcnpa18u/zyys5PBjLtrqeDTLxx9q47P7s5FV3iXrolwcUpzjv58w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760616; c=relaxed/simple;
	bh=QWBeKVujIF8v0rlPHbEKaf0gAf7oOpu5rJ9JUTdF9BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rmtCLOb0HyIJsyStPxmKT31KJzj7nG4VQSkCQkbO14Pzc47nhqg/uvIWJxyCXlCkjx3+znpmoCBEFNGQqKStOdtPJFXj5PLAflmKgH31IIi51xdGvNNbPz7R94ZLpog9opzcYH8aRpg2bSlw0SWPgSuxJmaQ8+3pnS513ySVzTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDBIBuC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77080C433F1;
	Wed, 10 Apr 2024 14:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712760615;
	bh=QWBeKVujIF8v0rlPHbEKaf0gAf7oOpu5rJ9JUTdF9BM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pDBIBuC7E57OZzo5tK2mLc7aLpm1/IPAKzPyAwDN/IfgqssUg21BEwtfBBOjC7p90
	 TVPvcpV3tzbuNRyJxe7G/R48sVeKWjLY/ltZ38KWn5gDXmHhQKBTbJvKNl3lpPElFV
	 AIAwEbpwjp5SZ3E4juX+DIFSpabOVmM5GAhHrr9QikvKJJX2qyF/JtfMnm+7XnIaVJ
	 nLfuCf+z8xiC/UY1RHA4Nqe8CcqqJ8R7p9/pxuvZ6dW4W0bjwMtQ8bU3YLi+BswnfG
	 Dab6SvrXdWjJ/n9njoJD338nTybXYgxZ8JmnJIAcbJs9qXFRFD8G3KcDNj0FDNAKew
	 sFFHa8Ppm0Rsw==
Date: Wed, 10 Apr 2024 16:50:13 +0200
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
Message-ID: <ZhanJYjJQqrqYlg-@localhost.localdomain>
References: <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
 <ZhU2YwettB6i6AMp@localhost.localdomain>
 <20240409134729.JpcBYOsK@linutronix.de>
 <ZhZ54XAcBt50WEnE@localhost.localdomain>
 <20240410134702.dcWYciZB@linutronix.de>
 <ZhabcanCbQej1azv@localhost.localdomain>
 <20240410140633.0MHBLpMI@linutronix.de>
 <ZhalcBcd3w0w2HD_@localhost.localdomain>
 <20240410144821.bVdBdVOR@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410144821.bVdBdVOR@linutronix.de>

Le Wed, Apr 10, 2024 at 04:48:21PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-10 16:42:56 [+0200], Frederic Weisbecker wrote:
> > > > Like this then?
> > > > 
> > > > https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50
> > > 
> > > Kind of, yes. Do we have more than one waiter? If not, maybe that
> > > rcuwait would work then.
> > 
> > Indeed there is only one waiter so that should work. Would
> > that be something you can call while preemption is disabled?
> 
> rcuwait_wake_up() does only wake_up_process() which is fine.
> wake_up() does spin_lock_irqsave() which is a no.

Duh!

> On the other hand that preempt-disable needs to go anyway due to
> perf_sigtrap(). But a slim wake is a slim wake ;)

Sure thing :)

> > Thanks.
> 
> Sebastian

