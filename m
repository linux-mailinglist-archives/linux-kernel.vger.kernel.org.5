Return-Path: <linux-kernel+bounces-137677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 035AF89E5C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C55283DCC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D85158DD7;
	Tue,  9 Apr 2024 22:52:52 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CFF158DA5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703171; cv=none; b=UerljstVQix5fBSTdsUkGErkxpX0ASJKques8nnKPiYjctWQzMMgNNe2aWAu9h0o21paNQh/d/J8JK7cQwbgQM7Lixb0fg9pjTKr8bXA7ePMFKgtcyiXnmMQtv7nxE2jAFjgGziCGn76ARBCPj7qZHfDpCSA5a96B07ItVegXo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703171; c=relaxed/simple;
	bh=O+mGXfs3RDsQTErSVM8OTaHI3QnXgNIs9P8CYq9GNoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIKmRlhm3ILIVfShDF030KuERxA4t1fzJ+toS+tT+9nCXRP+3OswPe6XQb3hmk2oQTymcIjO/jdIep4q6XGfIrMJ6/+qoPTGh90kI4qpacENOS1+4TKPwfuyL1i1c1vDUL0IHm8WTrUd1XCeOrW2QnkIq0ook3+h4YNLEgMCnxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.163])
	by sina.com (172.16.235.24) with ESMTP
	id 6615C68000007624; Tue, 10 Apr 2024 06:51:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 83548545089525
X-SMAIL-UIID: AA18EA2385864CD180945C3BC5570DCF-20240410-065148-1
From: Hillf Danton <hdanton@sina.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: syzbot <syzbot+d1ae9c954f73570e7b58@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (2)
Date: Wed, 10 Apr 2024 06:51:39 +0800
Message-Id: <20240409225139.1556-1-hdanton@sina.com>
In-Reply-To: <87a5m27r08.ffs@tglx>
References: <000000000000b77a880615a0ed2a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Apr 2024 12:46:31 +0200 Thomas Gleixner <tglx@linutronix.de>
> On Mon, Apr 08 2024 at 19:46, syzbot wrote:
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 11239 at kernel/time/hrtimer.c:1053 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> > RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> > Call Trace:
> >  <IRQ>
> >  hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
> >  mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2335
> >  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
> >  __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
> >  hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
> >  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
> >  invoke_softirq kernel/softirq.c:428 [inline]
> >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
> >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
> >  </IRQ>
> 
> The code which arms the timer is not serialized against the callback so
> the following can happen:
> 
>     CPU1                        CPU2
> 
>     __run_hrtimer(timer)
>                                 if (!hrtimer_queued(timer))
>                                         hrtimer_start(timer);
> 
>        hrtimer_forward(timer)
>          WARN_ON(hrtimer_queued(timer)
> 
> This really wants to use hrtimer_active() which takes the running
> callback into account.
> 
Then the race window is still open with hrtimer_active() and serialization
outside hrtimer is needed.

	CPU1				CPU2
	---				---
					if (!hrtimer_is_active(timer))
	if (!hrtimer_is_active(timer))
		hrtimer_start(timer);
	__run_hrtimer(timer)
						hrtimer_start(timer);
	hrtimer_forward(timer)
	  WARN_ON(hrtimer_queued(timer))

