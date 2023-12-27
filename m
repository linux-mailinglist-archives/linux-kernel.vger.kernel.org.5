Return-Path: <linux-kernel+bounces-11952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C35881EE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0AC1F2176E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3C2C878;
	Wed, 27 Dec 2023 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nzeyeygm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90851EEBB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bxBVfm4PKGrl5oprqwZSPbNZSHbFaZWeyr+oOUXZV+Y=; b=nzeyeygmDYculFyYc5P/XMnpCj
	OYXhj+NRhbTekxR3Gv4i6tqECIcC4fj4D+UahIirOTsQBso0JUN3wC5xm6CsJAa/ITsliQLxMkSZx
	yUJBkC4WQ5FobcRAqb/NAkxoR8NW38KPRT5Ya9AL/hS3ohHleYmU+o8j6BwYO1mu1jmXvlQ+mnlEO
	gjhSksuhN0c0g1n3RU9iYJ78yDBO0F+BNZ5kz8ZCIcrv2oYk4xAmW3ZdRs9qh9yXu7f4SQOxMm2cS
	nrddd+Ycs2kydqE5kweaMrRR9kRyj5c4eycrXDTYs0KizOPU1KUxARmvTicQDZhjiSVyDFHQ+iqWT
	z2U+V1/w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rIQwE-002cOg-LM; Wed, 27 Dec 2023 10:14:59 +0000
Date: Wed, 27 Dec 2023 10:14:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
Cc: Hillf Danton <hdanton@sina.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZYv5IhyCVeYhbj8b@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <20231226104652.1491-1-hdanton@sina.com>
 <6e762e8e-b031-4e37-97c1-56390c9b8076@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e762e8e-b031-4e37-97c1-56390c9b8076@quicinc.com>

On Wed, Dec 27, 2023 at 09:41:29AM +0800, Aiqun Yu (Maria) wrote:
> On 12/26/2023 6:46 PM, Hillf Danton wrote:
> > On Wed, 13 Dec 2023 12:27:05 -0600 Eric W. Biederman <ebiederm@xmission.com>
> > > Matthew Wilcox <willy@infradead.org> writes:
> > > > On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
> > > > > +static inline void write_lock_tasklist_lock(void)
> > > > > +{
> > > > > +	while (1) {
> > > > > +		local_irq_disable();
> > > > > +		if (write_trylock(&tasklist_lock))
> > > > > +			break;
> > > > > +		local_irq_enable();
> > > > > +		cpu_relax();
> > > > 
> > > > This is a bad implementation though.  You don't set the _QW_WAITING flag
> > > > so readers don't know that there's a pending writer.  Also, I've seen
> > > > cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
> > > > that takes a while to wake up from.
> > > > 
> > > > I think the right way to fix this is to pass a boolean flag to
> > > > queued_write_lock_slowpath() to let it know whether it can re-enable
> > > > interrupts while checking whether _QW_WAITING is set.
> > 
> > 	lock(&lock->wait_lock)
> > 	enable irq
> > 	int
> > 	lock(&lock->wait_lock)
> > 
> > You are adding chance for recursive locking.
> 
> Thx for the comments for discuss of the deadlock possibility. While I think
> deadlock can be differentiate with below 2 scenarios:
> 1. queued_write_lock_slowpath being triggered in interrupt context.
>   tasklist_lock don't have write_lock_irq(save) in interrupt context.
>   while for common rw lock, maybe write_lock_irq(save) usage in interrupt
> context is a possible.
>   so may introduce a state when lock->wait_lock is released and left the
> _QW_WAITING flag.
> Welcome others to suggest on designs and comments.

Hm?  I am confused.  You're talking about the scenario where:

 - CPU B holds the lock for read
 - CPU A attempts to get the lock for write in user context, fails, sets
   the _QW_WAITING flag
 - CPU A re-enables interrupts
 - CPU A executes an interrupt handler which calls queued_write_lock()
 - If CPU B has dropped the read lock in the meantime,
   atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED) succeeds
 - CPU A calls queued_write_unlock() which stores 0 to the lock and we
   _lose_ the _QW_WAITING flag for the userspace waiter.

How do we end up with CPU A leaving the _QW_WAITING flag set?


