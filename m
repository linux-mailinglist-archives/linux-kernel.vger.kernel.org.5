Return-Path: <linux-kernel+bounces-11689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C52781EA0C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01591F22ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C08B4C90;
	Tue, 26 Dec 2023 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z00n1bGP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515E74C6F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sU/ZDwVMrGzv8b1xMxNd4+PSlPCz5hvDCFekATiKTC8=; b=Z00n1bGPPF4i3LvMg4bvxZqY0Q
	GBwq/LGTAuBdPQRkkYPwIt2An9p10mciUA/gg9QmGshByIamlj5hzLm+jGfia0emLL+nkKOZXVhJj
	lLKVpheFUndJJCE65mL3+9UMnVL7IVHi5CaFpQ39BGD1wSUNCNWOKUhflYsbHsbu40dXbFvYiJZsp
	w3Y2LVaNaRci+MyWk8jtMPr0MKNsHR5aV81aVuan6ueNeUpVG6z9tH2pzYFtbOQ29YrkKc9XyfD0x
	wxYNwxoXQObcZwT+/jSn8iEAYVFgoM3D08fA+PQ+cLFT86M7N+tTJByXzPyZuWAuNCAFSK/v1hn6e
	pnHCqSMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rIEMs-00191a-5m; Tue, 26 Dec 2023 20:49:38 +0000
Date: Tue, 26 Dec 2023 20:49:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Maria Yu <quic_aiquny@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZYs8Yp/7TovnVMLC@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <20231226104652.1491-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226104652.1491-1-hdanton@sina.com>

On Tue, Dec 26, 2023 at 06:46:52PM +0800, Hillf Danton wrote:
> On Wed, 13 Dec 2023 12:27:05 -0600 Eric W. Biederman <ebiederm@xmission.com>
> > Matthew Wilcox <willy@infradead.org> writes:
> > > On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
> > >> +static inline void write_lock_tasklist_lock(void)
> > >> +{
> > >> +	while (1) {
> > >> +		local_irq_disable();
> > >> +		if (write_trylock(&tasklist_lock))
> > >> +			break;
> > >> +		local_irq_enable();
> > >> +		cpu_relax();
> > >
> > > This is a bad implementation though.  You don't set the _QW_WAITING flag
> > > so readers don't know that there's a pending writer.  Also, I've seen
> > > cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
> > > that takes a while to wake up from.
> > >
> > > I think the right way to fix this is to pass a boolean flag to
> > > queued_write_lock_slowpath() to let it know whether it can re-enable
> > > interrupts while checking whether _QW_WAITING is set.
> 
> 	lock(&lock->wait_lock)
> 	enable irq
> 	int
> 	lock(&lock->wait_lock)
> 
> You are adding chance for recursive locking.

Did you bother to read queued_read_lock_slowpath() before writing this
email?

        if (unlikely(in_interrupt())) {
                /*
                 * Readers in interrupt context will get the lock immediately
                 * if the writer is just waiting (not holding the lock yet),
                 * so spin with ACQUIRE semantics until the lock is available
                 * without waiting in the queue.
                 */
                atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
                return;


