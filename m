Return-Path: <linux-kernel+bounces-162216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0853E8B57A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4831F243E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02D53E11;
	Mon, 29 Apr 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QZepAvlp"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2045339B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714392883; cv=none; b=uRvt7yW5sdq9goT4ooPizmYdj+zeBn7F29MnX9FfyCRX86KSsgBXYcwVSsl0ZBu1cewTGchbFmuTslg2939tGxdmN+hsI6GNH5YACjE1t8d2/JSFuZwrV7bu06MUa9UwtlCuBxJAx7Cb5YP44SskbqoFjsfUnohEULRN/pawqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714392883; c=relaxed/simple;
	bh=yLLgddFnrnABDuUB1yafXOe/Yq+61keclmMBQTyIhC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3tJCA3OXDzQlQUvgJ71PBYvG9x8EbPjSa3ZbH5LJJf2rE81S/xeq/L4kQprN/OT1TAUrbDvx7CyBdWCAMT1RQOpPZCASxJTyLDO/l8kbzSrp2ITdNt0te77v7R4XWul8Sm5COzeTooBdzuSAuHtIuO9s+G4IWOlxitfiopw7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QZepAvlp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wzYPAOrbwt9NNU8El6k7WjcaPrNWyuOOHBHcaFPGonE=; b=QZepAvlp1FgqH01EFFyfaCFKy/
	D/4YX1CmaMinmno3O0yt/UPJam0mXK2BbDCxCmGj6YH8OjGnv678w/fZs9fw/0EzYfyJeLdJM2Zt+
	YF20ndE3XVm4wWXvBT4cmGWgR/5AhwgT+lK1/mNSLazB7KJfeJR9hHsLdcb75GLoOf27ui7xhNtcY
	KRU+n9BE57XaPtvbfwz9O3jSBTAs9Soro3jyoAyfcQzi40I/KWNPDqUqMpxOX0yWL75Qw4cmkkLqg
	qPRmcSemxcI1I6a1qfmgGhGBpCy/V8OPtd3cfo99JS32mSXFycrGTpJZJCO4DMNAIbFnuqmsWRk62
	H5DC5lHg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1Ptn-0000000GUUx-0Yq4;
	Mon, 29 Apr 2024 12:14:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C1755300684; Mon, 29 Apr 2024 14:14:22 +0200 (CEST)
Date: Mon, 29 Apr 2024 14:14:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	tglx@linutronix.de, Chen Yu <yu.c.chen@intel.com>,
	Oliver Sang <oliver.sang@intel.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240429121422.GU30852@noisy.programming.kicks-ass.net>
References: <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
 <20240425112855.GF21980@noisy.programming.kicks-ass.net>
 <20240426105607.GK12673@noisy.programming.kicks-ass.net>
 <20240426111607.GL12673@noisy.programming.kicks-ass.net>
 <18f557cd69fc65f5b43daddd8ad3e43278dfa44e.camel@gmx.de>
 <8d2fd91db108428680cd4ed988b36cf3f579c5ec.camel@gmx.de>
 <b344235ed5e2af6c573ff371d3687f0fa7bc5c5e.camel@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b344235ed5e2af6c573ff371d3687f0fa7bc5c5e.camel@gmx.de>

On Sun, Apr 28, 2024 at 06:32:49PM +0200, Mike Galbraith wrote:
> On Sat, 2024-04-27 at 08:42 +0200, Mike Galbraith wrote:
> > On Fri, 2024-04-26 at 18:03 +0200, Mike Galbraith wrote:
> > > fwiw, tbench liked the previous version better.
> >
> > The culprit lies somewhere in the new PREEMPT_SHORT patch.
> 
> <squint>
> 
> Ah, moving the curr eligibility check into pick_curr() left an
> ineligible curr to be seen/used further down in pick_eevdf().
> 
> found:
>         if (!best || (curr && entity_before(curr, best)))
>                 best = curr;

Hmm yes, over aggressive cleanup that. Let me try again.

> Nit: PREEMPT_SHORT depending on RUN_TO_PARITY looks odd.

The thinking was that without RUN_TO_PARITY we'll always do a full pick
and it will always pick a (new) shorter deadline task over current.

The PREEMPRT_SHORT thing really is an exception to avoid RUN_TO_PARITY
from ruining latency game for short tasks.

