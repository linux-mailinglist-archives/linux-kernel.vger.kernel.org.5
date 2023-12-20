Return-Path: <linux-kernel+bounces-7123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AD781A1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B5CC1C22596
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB273FE47;
	Wed, 20 Dec 2023 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsY9ra43"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF713FE20;
	Wed, 20 Dec 2023 15:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A03C433CA;
	Wed, 20 Dec 2023 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703085208;
	bh=/+MAcPao4wtjkMts1SExJcD8F6yLGaio/sY+28LaI28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qsY9ra431T7DRLGYWiDKTx7uTDleRQxmD3gjgAt+wmEe8Aa0JFyKFOn9nEfzDRLyI
	 A9IEMDflFp2uDOQOIlXtpniL+7tn2nu9lRbsvCRfZd86Pzxzso5FCDSPfId/thHD9T
	 qXZNZ6BkqGGUI5XkTgQTTeBMeAvtygWDlK1/or0vrpTPafbXFT6jL3k7KeaqJ2pRV/
	 nCZ1EowaVM7aptWFnz/e4kDb4iVodjwK5qDbP3djgs4VMmpfEwa0iweeKmfJ9J9UQM
	 hAnxBt8L0lNBM33yG71ZEbcfNZm/lbcssxnzAHrb5EpB8y3cjC88duzYzQcRgVBF45
	 Y1urUrjEYFY+A==
Date: Wed, 20 Dec 2023 16:13:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZYMElDsPLTJDdco3@localhost.localdomain>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cVv4cnbDPi=9oCYE_5s+DfuzQcB1fz=M1T8Hyp9D9sbXw@mail.gmail.com>

Le Wed, Dec 20, 2023 at 04:24:35PM +0800, Z qiang a écrit :
> >
> > When the CPU goes idle for the last time during the CPU down hotplug
> > process, RCU reports a final quiescent state for the current CPU. If
> > this quiescent state propagates up to the top, some tasks may then be
> > woken up to complete the grace period: the main grace period kthread
> > and/or the expedited main workqueue (or kworker).
> >
> > If those kthreads have a SCHED_FIFO policy, the wake up can indirectly
> > arm the RT bandwith timer to the local offline CPU. Since this happens
> > after hrtimers have been migrated at CPUHP_AP_HRTIMERS_DYING stage, the
> > timer gets ignored. Therefore if the RCU kthreads are waiting for RT
> > bandwidth to be available, they may never be actually scheduled.
> >
> 
> In the rcutree_report_cpu_dead(), the rcuog kthreads may also be wakeup in
> do_nocb_deferred_wakeup(), if the rcuog kthreads is rt-fifo and wakeup happen,
> the rt_period_active is set 1 and enqueue hrtimer to offline CPU in
> do_start_rt_bandwidth(),
> after that, we invoke swake_up_one_online() send ipi to online CPU, due to the
> rt_period_active is 1, the rt-bandwith hrtimer will not enqueue to online CPU.
> any thoughts?

Duh, you're right, that one too. How many more? This hrtimer situation is scary...

Thanks.

