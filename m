Return-Path: <linux-kernel+bounces-103017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E876087B9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A47F52816BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40976BFA2;
	Thu, 14 Mar 2024 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44ExDuYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDSzqqu+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875DA6BB45;
	Thu, 14 Mar 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710407039; cv=none; b=R2v49/tZabFBl7cibpa3u4DJk2xrFleYByuN4s3qIcd3LhtyZMDP9HlDtzuAK03wnJ95nfZ1Jk2NRVOxSWjDXoxCknhamlb1MhT+iSs39yK+z5LT6CXNlHp2JGEYYCCkhIIHD9kkMEvsTzyZOJRJVDhwevHW0rY2atOgOYQKFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710407039; c=relaxed/simple;
	bh=xJm1bOn3DAxTHQvhFKMBuTXVKSGj1Wo2H74AdAjv1dE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5UGl1E2iQGLO7I/yY9abOsJEwXaN4ryNqK+gX+VP829ViRbolQeInvKAciDhFEZE7F7DA+9brTq7bE8g2Ot0BenW793x2QaltUYUTlENsdXLeWv2kzd/oy6vunPgI/10v/lfVsWY4wTfpYXrqkk7tEoL1MS5lSsV44NxdDvOfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44ExDuYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDSzqqu+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710407035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKAp8OP3y/ucUXi0rHldBVn3ObfqTk3XL0OTWhkFLcQ=;
	b=44ExDuYWr+WNNRYpKA6eKyLpRxJVtsVzx5lZNlN5dGyMAz+cXWxxPm6r7faNRCxbrz/GEm
	6LxwghwZo8C7OLu2pTn6zCZj1NEZjqXzW7AvY1n9MLRj4bF/FvZDaVVbZmIP+YHayUeMn3
	RaIl9yvxR+TYLWIGdniVvRvvqwIFc/Qvgc4vtgG0KxhwKlL4inF/sySJWlZQfiMoRZLpX8
	J1gMmIOWhNdZwbCYE7ho5OgvsC6QxX8AcwpRPHEHd8i37Pr9FhshTgn9iDIwIkBRuooy0L
	9AdZFdHYuo4QF764pebIpi7B47ePGuOrX3vRn43uOElCgNa6HTHKuDVoHs7DXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710407035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TKAp8OP3y/ucUXi0rHldBVn3ObfqTk3XL0OTWhkFLcQ=;
	b=GDSzqqu+kMUCZkPu2hAu/90kFtJnk19gEJZWot8xZBC/Qp3xdHRQ0jJF+31gn/vEfny1u/
	if2mHWn7rO3IwDAQ==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Florian Fainelli
 <f.fainelli@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, Boqun Feng
 <boqun.feng@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, rcu@vger.kernel.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, frederic@kernel.org,
 bigeasy@linutronix.de, chenzhongjin@huawei.com, yangjihong1@huawei.com,
 rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes
 for v6.9]
In-Reply-To: <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
Date: Thu, 14 Mar 2024 10:03:55 +0100
Message-ID: <87o7bhmbgk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Mar 13 2024 at 21:59, Russell King (Oracle) wrote:
> On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> I haven't understood the code there yet, and how it would interact with
> arch code, but one thing that immediately jumps out to me is this:
>
> "    As long as a CPU is busy it expires both local and global timers. When a
>     CPU goes idle it arms for the first expiring local timer."
>
> So are local timers "armed" when they are enqueued while the cpu is
> "busy" during initialisation, and will they expire, and will that
> expiry be delivered in a timely manner?

The local timers are timers which are pinned on a CPU. Global ones do
not care about the CPU they expire on.

So if the CPU goes idle then it arms for the first local timer. If the
first global timer expires after the first local, nothing to see. If it
expires before then that timer is queued in the migration hierarchy and
some other busy CPU will take care of it. If the last CPU goes idle then
it has to arm for the first timer (it's own local, global and the
hierarchy). So it's all covered in theory, but there seems to be an
issue somewhere. We'll figure it out.

Thanks,

        tglx



