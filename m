Return-Path: <linux-kernel+bounces-42564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2190284032B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37161F23553
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03D859140;
	Mon, 29 Jan 2024 10:48:15 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810458AC2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706525295; cv=none; b=f9PBGnwDzWvY0cuHX5NCLsaM1J5wPjIMppIgOxsxUGmuz85G498qCw3Et/YDVChaNgH3dnAfUHC/Q7Y31OV0XHzPLpL7HTZUKG4NqqzQsUQ3IlHW0kCr3IFfxS5RlLP96+qhr53Pl+xfIqdnT4oAywara/1hR/+QapldAZdKTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706525295; c=relaxed/simple;
	bh=H8pawYssUx3E0NXxVdNhnMnHUsU90Z8KPRaoaVqfrVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbHk0bCNiRwN1rbBdlEd1zp4DNMsM/tkp2Q72lA54mlwdfVb/81PvCiXkPoIIREMGEyRG0WE10u1724FIJ0MV163Pl9Fdwkrs20Z+rGTTkTcBMPG5MIMnf4zmXxE4Qrl7tMsnxMwotNI+DsGBb5xbhyj9SXrhZNIaSK9WzU/UDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.8.153])
	by sina.com (172.16.235.24) with ESMTP
	id 65B78263000077B5; Mon, 29 Jan 2024 18:48:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 53416445089313
X-SMAIL-UIID: 9DD052BF59374A74BB40FD791467B2AB-20240129-184806-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>,
	eadavis@qq.com,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Mon, 29 Jan 2024 18:47:53 +0800
Message-Id: <20240129104753.1328-1-hdanton@sina.com>
In-Reply-To: <4c59b146-df67-48d8-9378-3948dd6fb427@I-love.SAKURA.ne.jp>
References: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com> <20240129044824.1218-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 29 Jan 2024 14:53:20 +0900 Tetsuo Handa wrote:
> On 2024/01/29 13:48, Hillf Danton wrote:
> >> 3 locks held by kworker/1:2/779:
> >>  #0: ffff8880b993ccd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
> >>  #1: ffffc900038c7d80 ((work_completion)(&aux->work)#2){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
> >>  #2: ffff888052984c80 (&aux->poke_mutex){+.+.}-{3:3}, at: __fd_array_map_delete_elem+0x125/0x2f0 kernel/bpf/arraymap.c:884
> > 
> > Could locking people shed any light on the failure of detecting the
> > poke_mutex with rq lock held?
> > 
> 
> Showing held locks (lockdep_print_held_locks()) is not a snapshot.
> Synchronous printk() can make #0 already released by the moment #2 is taken.
> 
> Please consult printk() people for possibility of making printk() from
> lockdep reports (and/or hung task reports) asynchronous.

If printk did its work well then we have difficulty explaining why RCU
stalled more than two minutes.

6 locks held by kworker/u5:0/51:
 #0: ffff88802a730d38 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
 #1: ffffc90000bc7d80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
 #2: ffff888020989060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
 #3: ffff888020988078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb70 net/bluetooth/hci_sync.c:5337
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
 #4: ffffffff8ef23348 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
 #5: ffffffff8d1b83f8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995

