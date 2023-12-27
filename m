Return-Path: <linux-kernel+bounces-11983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99281EE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E955B220B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FC7446A2;
	Wed, 27 Dec 2023 11:10:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F2B44370
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 11:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.138])
	by sina.com (10.75.12.45) with ESMTP
	id 658C057900006A4D; Wed, 27 Dec 2023 19:07:40 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 19226231457834
X-SMAIL-UIID: 4A2157A538B04E3C8B67991E9A073358-20231227-190740-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Maria Yu <quic_aiquny@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for tasklist_lock
Date: Wed, 27 Dec 2023 19:07:27 +0800
Message-Id: <20231227110727.1546-1-hdanton@sina.com>
In-Reply-To: <ZYs8Yp/7TovnVMLC@casper.infradead.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com> <ZXnaNSrtaWbS2ivU@casper.infradead.org> <20231226104652.1491-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 26 Dec 2023 20:49:38 +0000 Matthew Wilcox <willy@infradead.org>
> On Tue, Dec 26, 2023 at 06:46:52PM +0800, Hillf Danton wrote:
> > On Wed, 13 Dec 2023 12:27:05 -0600 Eric W. Biederman <ebiederm@xmission.com>
> > > Matthew Wilcox <willy@infradead.org> writes:
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
> Did you bother to read queued_read_lock_slowpath() before writing this email?

Nope but it matters nothing in this case.
> 
>         if (unlikely(in_interrupt())) {
>                 /*
>                  * Readers in interrupt context will get the lock immediately
>                  * if the writer is just waiting (not holding the lock yet),
>                  * so spin with ACQUIRE semantics until the lock is available
>                  * without waiting in the queue.
>                  */
>                 atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
>                 return;

This is the lock acquirer for read in irq context, and it rolls out the red
carpet for write acquirer in irq, right Willy?

Feel free to ignore the following leg works.

	/* Set the waiting flag to notify readers that a writer is pending */
	atomic_or(_QW_WAITING, &lock->cnts);

	enable irq;

	/* When no more readers or writers, set the locked flag */
	do {
		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);
	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));

	int
	atomic_cond_read_acquire(&lock->cnts, !(VAL & _QW_LOCKED));
	deadlock
	disable irq;

Though the case below is safe, it looks not pretty but clumsy.

	/* Set the waiting flag to notify readers that a writer is pending */
	atomic_or(_QW_WAITING, &lock->cnts);

	/* When no more readers or writers, set the locked flag */
	do {
		enable irq;

		cnts = atomic_cond_read_relaxed(&lock->cnts, VAL == _QW_WAITING);

		disable irq;

	} while (!atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED));


