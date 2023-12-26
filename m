Return-Path: <linux-kernel+bounces-11478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FC181E6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2EE1C21E6B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52214E1BA;
	Tue, 26 Dec 2023 10:47:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE554E1A1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.48])
	by sina.com (172.16.235.24) with ESMTP
	id 658AAF2600004821; Tue, 26 Dec 2023 18:47:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 93595545088862
X-SMAIL-UIID: 373CAD4AC90E4AE3A8DF32B71374E1FC-20231226-184707-1
From: Hillf Danton <hdanton@sina.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Maria Yu <quic_aiquny@quicinc.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: Introduce a write lock/unlock wrapper for tasklist_lock
Date: Tue, 26 Dec 2023 18:46:52 +0800
Message-Id: <20231226104652.1491-1-hdanton@sina.com>
In-Reply-To: <87o7eu7ybq.fsf@email.froward.int.ebiederm.org>
References: <20231213101745.4526-1-quic_aiquny@quicinc.com> <ZXnaNSrtaWbS2ivU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 13 Dec 2023 12:27:05 -0600 Eric W. Biederman <ebiederm@xmission.com>
> Matthew Wilcox <willy@infradead.org> writes:
> > On Wed, Dec 13, 2023 at 06:17:45PM +0800, Maria Yu wrote:
> >> +static inline void write_lock_tasklist_lock(void)
> >> +{
> >> +	while (1) {
> >> +		local_irq_disable();
> >> +		if (write_trylock(&tasklist_lock))
> >> +			break;
> >> +		local_irq_enable();
> >> +		cpu_relax();
> >
> > This is a bad implementation though.  You don't set the _QW_WAITING flag
> > so readers don't know that there's a pending writer.  Also, I've seen
> > cpu_relax() pessimise CPU behaviour; putting it into a low-power mode
> > that takes a while to wake up from.
> >
> > I think the right way to fix this is to pass a boolean flag to
> > queued_write_lock_slowpath() to let it know whether it can re-enable
> > interrupts while checking whether _QW_WAITING is set.

	lock(&lock->wait_lock)
	enable irq
	int
	lock(&lock->wait_lock)

You are adding chance for recursive locking.
> 
> Yes.  It seems to make sense to distinguish between write_lock_irq and
> write_lock_irqsave and fix this for all of write_lock_irq.
> 
> Either that or someone can put in the work to start making the
> tasklist_lock go away.
> 
> Eric

