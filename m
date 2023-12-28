Return-Path: <linux-kernel+bounces-12529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8737781F631
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E93E1C21CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E5663C5;
	Thu, 28 Dec 2023 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXRtuiXt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DA63A8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uqg6vQn+spXvmoZWu9//v883CUlzXLAEBegc3S1fc2o=; b=iXRtuiXtAEEm9LUzL6aMPP8J+v
	UMenAwgG8TdvKET5HpB8OdG3FdgTBb5GG2l42J607TDq8zx7XqAe/IegBM1YaUh9nBrdUdp5kReW6
	pEgCq0uEHqYqyDboGNxlH006q0pJT26KJTcZHOYD06xqp8JAwvMqoAtvEMheIsh0ZjwsWONk7Zb5H
	9++hyH+Rs6+jjgLQuMUIN+YSSiktgRpplUkMeFQoqmAJbca8A581h4jpvX+FfSXR/LTwkpZ1jFyhU
	g9SnM0tUtVdwfl1sYD5Zsv+KgcIBTthnhl0BPKTZwHip/6xt/+17IxqlBpGXIQFs/tTPc+QXt+Qmy
	RRqGgQkQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rImMI-004YuM-KY; Thu, 28 Dec 2023 09:07:18 +0000
Date: Thu, 28 Dec 2023 09:07:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Maria Yu <quic_aiquny@quicinc.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for
 tasklist_lock
Message-ID: <ZY06xtvaQ4ZJ5dXa@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com>
 <ZXnaNSrtaWbS2ivU@casper.infradead.org>
 <20231226104652.1491-1-hdanton@sina.com>
 <20231227110727.1546-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231227110727.1546-1-hdanton@sina.com>

On Wed, Dec 27, 2023 at 07:07:27PM +0800, Hillf Danton wrote:
> Feel free to ignore the following leg works.
> 
> 	/* Set the waiting flag to notify readers that a writer is pending */
> 	atomic_or(_QW_WAITING, &lock->cnts);
> 
> 	enable irq;
> 
> 	/* When no more readers or writers, set the locked flag */
> 	do {
> 		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
> 	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));
> 
> 	int
> 	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
> 	deadlock
> 	disable irq;

That would be a buggy implementation, and would not be what I was
thinking.

> Though the case below is safe, it looks not pretty but clumsy.
> 
> 	/* Set the waiting flag to notify readers that a writer is pending */
> 	atomic_or(_QW_WAITING, &lock->cnts);
> 
> 	/* When no more readers or writers, set the locked flag */
> 	do {
> 		enable irq;
> 
> 		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
> 
> 		disable irq;
> 
> 	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));

Why do you think it looks clumsy?  It's more or less what I was
thinking.

-void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock)
+void __lockfunc queued_write_lock_slowpath(struct qrwlock *lock, bool irq)
...
        do {
+               if (irq)
+                       local_irq_enable();
                cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
+               if (irq)
+                       local_irq_disable();
        } while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));


