Return-Path: <linux-kernel+bounces-110751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BAB886339
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515D1286324
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B60136679;
	Thu, 21 Mar 2024 22:21:50 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE3E135A52
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711059710; cv=none; b=LsiWWJcDH6wzdEEMt8w1l3crkBR2kVlNkwggjDalhKHEg6B6mEWpoIArbGbbgABjBmiO4SdNjBcB1LwN2Sx/yKD9K+Gdx14Gfa4MB/xg/HOq2FA8MSdPl816Jh/eRj9HpJUNBqMZDKy1mDP2FZj0hDzZkPNnvREgU85aquPCvME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711059710; c=relaxed/simple;
	bh=9lGxldt3FbC/qdsB/K46SIm3mDeWP61ycUXkypW+u+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uj+C3h32BQ1e5XelN95BjkkrReRzAgfQXubBZMMopWkIp97zuTsQJ/32ADjhHpONhwJoAdi3cwoBGmv7BUmG+hLYv+9V0n+4z4yqS2hDkunhMMRZno6jD0GbRWghfHSF/PDEUEdMUpOTsQl9r95+tGfOxg6b41dVwyp+2481jCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.35])
	by sina.com (172.16.235.25) with ESMTP
	id 65FCB2D0000027B1; Thu, 22 Mar 2024 06:21:07 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2410634210281
X-SMAIL-UIID: CD374027FD7243C79AF4A8326B3E6537-20240322-062107-1
From: Hillf Danton <hdanton@sina.com>
To: Antoine Tenart <atenart@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Eric Dumazet <edumazet@google.com>,
	syzbot <syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [net?] INFO: task hung in register_nexthop_notifier (3)
Date: Fri, 22 Mar 2024 06:20:54 +0800
Message-Id: <20240321222054.2462-1-hdanton@sina.com>
In-Reply-To: <171101294595.5492.6904692183666798713@kwain>
References: <0000000000009485160613eda067@google.com> <CANn89iKnOzz_Bs_ygLWZGjsTw=266p8KALv=QWheTanoHYj+nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Mar 2024 10:22:25 +0100 Antoine Tenart <atenart@kernel.org>
> Quoting Eric Dumazet (2024-03-18 15:46:37)
> > On Mon, Mar 18, 2024 at 12:26=E2=80=AFPM syzbot
> > <syzbot+99b8125966713aa4b0c3@syzkaller.appspotmail.com> wrote:
> > >
> > > INFO: task syz-executor.3:6975 blocked for more than 143 seconds.
> > >       Not tainted 6.8.0-rc7-syzkaller-02500-g76839e2f1fde #0
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
> e.
> > > task:syz-executor.3  state:D stack:20920 pid:6975  tgid:6975  ppid:1   =
>    flags:0x00004006
> > > Call Trace:
> > >  <TASK>
> > >  context_switch kernel/sched/core.c:5400 [inline]
> > >  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
> > >  __schedule_loop kernel/sched/core.c:6802 [inline]
> > >  schedule+0x149/0x260 kernel/sched/core.c:6817
> > >  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
> > >  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> > >  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
> > >  register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3863
> > >  nsim_fib_create+0x8a6/0xa70 drivers/net/netdevsim/fib.c:1587
> > >  nsim_drv_probe+0x747/0xb80 drivers/net/netdevsim/dev.c:1582
> > >  really_probe+0x29e/0xc50 drivers/base/dd.c:658
> > >  __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
> > >  driver_probe_device+0x50/0x430 drivers/base/dd.c:830
> > >  __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
> > >  bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
> > >  __device_attach+0x333/0x520 drivers/base/dd.c:1030
> > >  bus_probe_device+0x189/0x260 drivers/base/bus.c:532
> > >  device_add+0x8ff/0xca0 drivers/base/core.c:3639
> > >  nsim_bus_dev_new drivers/net/netdevsim/bus.c:442 [inline]
> > >  new_device_store+0x3f2/0x890 drivers/net/netdevsim/bus.c:173
> > >  kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
> >=20
> > So we have a sysfs handler ultimately calling register_nexthop_notifier()=
>  or any
> > other network control path requiring RTNL.
> >=20
> > Note that we have rtnl_trylock() for a reason...
> 
> Mentioning the below in case that gives some ideas; feel free to
> disregard.
> 
> When I looked at similar issues a while ago the rtnl deadlock actually
> happened with the kernfs_node refcount; haven't looked at this one in
> details though. The mutex in there was just preventing concurrent
> writers.
> 
> > Or maybe the reason is wrong, if we could change kernfs_fop_write_iter()
> > to no longer hold a mutex...

Better after working out why RCU stalled [1]

5 locks held by kworker/u4:7/23559:
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90012b8fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90012b8fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f36d250 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:591
 #3: ffffffff8f3798c8 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:627
 #4: ffffffff8e136440 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x550 kernel/rcu/tree.c:4064

[1] https://lore.kernel.org/lkml/0000000000009485160613eda067@google.com/

> 
> At the time I found a way to safely drop the refcount of those
> kernfs_node which then allowed to call rtnl_lock from sysfs handlers,
> https://lore.kernel.org/all/20231018154804.420823-1-atenart@kernel.org/T/
> 
> Note that this relied on how net device are unregistered (calling
> device_del under rtnl and later waiting for refs on the netdev to drop
> outside of the lock; and a few other things), so extra modifications
> would be needed to generalize the approach. Also it's a tradeoff between
> fixing those deadlocks without rtnl_trylock and maintaining a quite
> complex logic...
> 
> Antoine
> 

