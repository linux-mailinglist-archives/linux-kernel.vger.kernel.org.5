Return-Path: <linux-kernel+bounces-107758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1030C880150
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6D2868C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFA8657AD;
	Tue, 19 Mar 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n9sQEweH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F0765BAA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864090; cv=none; b=N5APyIAS1mCHZKDKA/NA4ZT82Jh7Pw8oiBQhYFViG3WcDjPApo9gxvEDfWQv/OWeAxP7f2bbvA5LgnZmOlq5UsN/ernYIWtlegCkVLC7sMlffUKJMY1J3dd0GqfY2WbmdPqVhQVC+ffKKA+9ZF3C8VHqaEMP4sUNg1nIK90tews=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864090; c=relaxed/simple;
	bh=EJNNgx8uoxlcenj0kJ6LOq9STgZE7L/wlKEhoCh8VXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfKJuxuhZsD2y4mR3Mo1FZ9HKYO7Tnn5RlVreRSbOIvCDi2nPHoV5fq5JuMqN9L/h1eqvdTBwc8np5DhMCPDSgWxXUHeTpS3ziUyuJ5SLe+TGUkakJROswwxA+HXgiIHeK7XgOvdP4y7J1ZKK+aVitrmpVDqDtvQxrvHvh9YuwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n9sQEweH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=308AIC0mKgKOiFvltlBe5QH+mWjYoXhfz7TbckUNBXs=; b=n9sQEweH79RVcYq6RuXmpk8whB
	tl+mVIbNHr458LsfgJxEPHqudBd6nNoh0juqADM9zMVmsUNYCbMYPnbQs0dQwDzXOgzUzmKdlCx2q
	IdLpH4Q3WD7ND4T6zti2Z4qa9cEWIpIi60zKs8JTtr4kkmMZjLU5MQlTZ9uyKS8fFKcsPdSY4hU3Y
	SyOa2L2VMsQS05fWA9RGVZPuirvpiUIAEvGbhgGvH3UdrTgfaUrtMFfETm/ZrzUrvkXNNRuU+DcwV
	8l3j5t3/sI6me2mxECUBO+VbzvuwXxqsdDfu1zzRfDbzI0nruWXjim6EWhD+J+wRYGplrKFLMy1kQ
	njOSo0Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmbu2-00000002GUm-2rIJ;
	Tue, 19 Mar 2024 16:01:26 +0000
Date: Tue, 19 Mar 2024 16:01:26 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>,
	Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] Locking: Let PREEMPT_RT compile again with new rwsem
 asserts.
Message-ID: <Zfm21jBMZIci3P6P@casper.infradead.org>
References: <20240319070550.ws_uO21-@linutronix.de>
 <ZfmVPid-d7cpf6Yt@casper.infradead.org>
 <20240319141506.DUd9NKl4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319141506.DUd9NKl4@linutronix.de>

On Tue, Mar 19, 2024 at 03:15:06PM +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-19 13:38:06 [+0000], Matthew Wilcox wrote:
> > On Tue, Mar 19, 2024 at 08:05:50AM +0100, Sebastian Andrzej Siewior wrote:
> > > -static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> > > +static __always_inline bool rwsem_held_write(const struct rw_semaphore *sem)
> > 
> > The locking maintainers were very clear that this predicate Should Not
> > Exist.  It encourages people to write bad code.  Assertions only!
> 
> What do you refer to? The inline vs __always_inline or
> rwsem_held_write() should not exists and it should invoke directly
> rw_base_is_write_locked()?

I see Waiman already gave you the substantial answer ... but why did you
change inline to __always_inline?

