Return-Path: <linux-kernel+bounces-150335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A728A9D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A695B1C21BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242E16C43B;
	Thu, 18 Apr 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iEARRixF"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EA16ABD8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451755; cv=none; b=aeA3AUHw2IYSc0as2wM11pZ1E7ZjRsu88lMmBomFA5JRHuMPr2v78hOAO0ej/ARTTMdcq8L7lf/3f3gpJ9xPgj14ZW0vf3PbSPrL4d5HmN0akKqQyORWhM17BOTyQiN2pl0jejBa810gusf4RG89g8oqoKHaFTPdGNQeUCRXqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451755; c=relaxed/simple;
	bh=P94DH8AqKAA5lye5i75LmkzjhoEdyTbF8tps1jGtw38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GauqQiOSKQuERCZaz633WCRZXv08xAf98WidFfySEe041C4nxgVRxWtj0CJTN32ZQUYd6BimA/lJwvvHZEXJQ/SzBuXQ8tMtEb+Dy0vEbL0wkqrikj9TfZcTxKGC8BvulSanMP9sywSNdz3N8BOlWFwx7EcLjvZQdV3u/Nv3r0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iEARRixF; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Apr 2024 07:49:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713451751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L+oZNHCiAYDQYgTy7C1ugxmdQ034rdJRx6SliQtfo3k=;
	b=iEARRixFPb7tY694aPQ7hwwXPQqJZftXCopWiRG8K7LuZOlONNwzObwH4juZlvCU8THu3g
	hivCPVdZKszLw3dA047mPNFgYGE0J5Y2chC7EIdAfCoyR9ryDC++O/Q+t79Fn8O5v6p52F
	+WXAeQRqDuYsoq2y3t68OFrSNJUIJrQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to
 mutex
Message-ID: <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul>
 <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 18, 2024 at 11:02:06AM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 18/04/2024 04.19, Yosry Ahmed wrote:
[...]
> > 
> > I will keep the high-level conversation about using the mutex here in
> > the cover letter thread, but I am wondering why we are keeping the
> > lock dropping logic here with the mutex?
> > 
> 
> I agree that yielding the mutex in the loop makes less sense.
> Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
> will be a preemption point for my softirq.   But I kept it because, we
> are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
> there was no sched point for other userspace processes while holding the
> mutex, but I don't fully know the sched implication when holding a mutex.
> 

Are the softirqs you are interested in, raised from the same cpu or
remote cpu? What about local_softirq_pending() check in addition to
need_resched() and spin_needbreak() checks? If softirq can only be
raised on local cpu then convert the spin_lock to non-irq one (Please
correct me if I am wrong but on return from hard irq and not within bh
or irq disabled spin_lock, the kernel will run the pending softirqs,
right?). Did you get the chance to test these two changes or something
similar in your prod environment?


