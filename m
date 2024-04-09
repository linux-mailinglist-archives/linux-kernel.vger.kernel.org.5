Return-Path: <linux-kernel+bounces-136700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE0589D73A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CEF8285DF7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E990083CD9;
	Tue,  9 Apr 2024 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXcR6+20";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+dAupo2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD574297;
	Tue,  9 Apr 2024 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712659595; cv=none; b=dOyRW2NmWtdG38AohsxiwTAcCou9WLQeA+csu3qleXf+TJSKXEsbuUl/lbELOPFp7L+oBzeWlYPIz/vNUeRj4Rx1tb0OCbNZeFq+3bkHcDWFHxdIpqfMID/XP1sICyWxwxHUR+lI8d+Zxjzx7p8hUvKUh9qN6F9AHdBZN3NHmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712659595; c=relaxed/simple;
	bh=r0dJIX3jmxNuXy65LFOpt4uyAtB3l+LV7CW1tPmmE6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4c1ii1UKpyFwF64ZRmkdF/WuboQ55JFF777M1Zo/ON55ZYbLu4ow8apReickXjhXnZHJKF6JlGYYUKOpauZ5un+FVYlSJYFN++cltonsQmHoTBJuElwZ3R29SGYjN3BtTexpg6prQoa5cZwIwyu0x5IKvadi1GLlAlr6n9yjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXcR6+20; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+dAupo2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712659592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efzE8ApMA5WUvYXRDOVHInf88sGcAlh56uWppzAdwf0=;
	b=bXcR6+20FIrY5chC/piBFZHcX/uZbegD6NjhsrS9pUbaQX8BETdVU9hYMEhudpyTisQ0eA
	9yEPunYhKXS1sUBlbZ/i4mze2qYQ3HaxveThaRjSfemjycQmiiGn0Ony83UajSNEMuhmHx
	zGYOscXd84L4VEqNNmhJ4Xres5GIa8AmbUXoyC3Ey+lrh51XYDqniTk7piZWo6uBVVIIWr
	qWXyV4LPfvi/0tuX3lYdonxjTZZMRvh/n7SjGAascQADveiHY6MwCTwaUDL1DOS9Xbfm/5
	v5RXxZRe7zVCdJYLHBc3p9JX6ghNHyH/vnG6fhaEQRmBKjVdyMjeJvBa1XhBng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712659592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efzE8ApMA5WUvYXRDOVHInf88sGcAlh56uWppzAdwf0=;
	b=+dAupo2/30SurT7+tXaCfidAAhxSVe6PdtJN30y20/PgZBoZQkWxUHecIbc2+tDA9pprBH
	HFMGpmLVYzJMfKAg==
To: syzbot <syzbot+d1ae9c954f73570e7b58@syzkaller.appspotmail.com>,
 anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
Cc: Johannes Berg <johannes.berg@intel.com>, Kalle Valo
 <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Subject: Re: [syzbot] [kernel?] WARNING in hrtimer_forward (2)
In-Reply-To: <000000000000b77a880615a0ed2a@google.com>
References: <000000000000b77a880615a0ed2a@google.com>
Date: Tue, 09 Apr 2024 12:46:31 +0200
Message-ID: <87a5m27r08.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 08 2024 at 19:46, syzbot wrote:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 11239 at kernel/time/hrtimer.c:1053 hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> RIP: 0010:hrtimer_forward+0x210/0x2d0 kernel/time/hrtimer.c:1053
> Call Trace:
>  <IRQ>
>  hrtimer_forward_now include/linux/hrtimer.h:355 [inline]
>  mac80211_hwsim_beacon+0x192/0x1f0 drivers/net/wireless/virtual/mac80211_hwsim.c:2335
>  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
>  __hrtimer_run_queues+0x595/0xd00 kernel/time/hrtimer.c:1756
>  hrtimer_run_softirq+0x19a/0x2c0 kernel/time/hrtimer.c:1773
>  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
>  invoke_softirq kernel/softirq.c:428 [inline]
>  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
>  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
>  </IRQ>

The code which arms the timer is not serialized against the callback so
the following can happen:

    CPU1                        CPU2

    __run_hrtimer(timer)
                                if (!hrtimer_queued(timer))
                                        hrtimer_start(timer);

       hrtimer_forward(timer)
         WARN_ON(hrtimer_queued(timer)

This really wants to use hrtimer_active() which takes the running
callback into account.

Thanks,

        tglx

--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -2422,7 +2422,7 @@ static int mac80211_hwsim_config(struct
 
 		if (!data->started || !link_data->beacon_int) {
 			hrtimer_cancel(&link_data->beacon_timer);
-		} else if (!hrtimer_is_queued(&link_data->beacon_timer)) {
+		} else if (!hrtimer_is_active(&link_data->beacon_timer)) {
 			u64 tsf = mac80211_hwsim_get_tsf(hw, NULL);
 			u32 bcn_int = link_data->beacon_int;
 			u64 until_tbtt = bcn_int - do_div(tsf, bcn_int);
@@ -2517,7 +2517,7 @@ static void mac80211_hwsim_link_info_cha
 			  info->enable_beacon, info->beacon_int);
 		vp->bcn_en = info->enable_beacon;
 		if (data->started &&
-		    !hrtimer_is_queued(&link_data->beacon_timer) &&
+		    !hrtimer_is_active(&link_data->beacon_timer) &&
 		    info->enable_beacon) {
 			u64 tsf, until_tbtt;
 			u32 bcn_int;

