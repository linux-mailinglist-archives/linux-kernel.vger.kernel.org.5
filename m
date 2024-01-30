Return-Path: <linux-kernel+bounces-45465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29B843114
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BFC61C22614
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306E979956;
	Tue, 30 Jan 2024 23:22:42 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C6B79941
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656961; cv=none; b=Z5zx1AGIvvskVtjSQZrOoeynwy8lZNVOlDNtZ5w35PsgK6Fj310vUp147dUIA50d8ig3XteyrsY/NbiLbiw7HiLfthdcKJBWIgmP5xKbsnURg+7tD4gUAd/CFPeGUnDM5eqp6t5sHb3rbgXtl993hUJOx8jNX6z6iEq8Y3PvnI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656961; c=relaxed/simple;
	bh=/tq/cx/WcvmNxhEpp2AZmoVoX3+GtT6aEqe9qYfVUFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Taz7lCYadBTTGavdnO71HY/UG4v7XEN9fw0sHlJ6uc8nOsvyAqYzQVFFxp31G8xfV8LwTUjexIrXAQ5V4XyBxgLW6iQ+r7Z8qHUGoibOZpAgdrRg6l7SnuquUjq91wfo+ZVTJc+fRV5CwNDZpYAbmRn8n25hehOvRaoWt9WSa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.231])
	by sina.com (172.16.235.25) with ESMTP
	id 65B984B10000651B; Tue, 31 Jan 2024 07:22:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 76482934210540
X-SMAIL-UIID: 4A69552BCDD8418A9CB66B69C168E737-20240131-072227-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
Cc: boqun.feng@gmail.com,
	eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	penguin-kernel@i-love.sakura.ne.jp,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com,
	torvalds@linux-foundation.org
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Wed, 31 Jan 2024 07:22:15 +0800
Message-Id: <20240130232215.1497-1-hdanton@sina.com>
In-Reply-To: <00000000000082e8ba06102ba5f1@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 30 Jan 2024 07:45:06 -0800
> 6 locks held by kworker/u5:5/5431:
>  #0: ffff888027f29538 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work+0x789/0x15d0 kernel/workqueue.c:2608
>  #1: ffffc90009bffd80 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work+0x7eb/0x15d0 kernel/workqueue.c:2609
>  #2: ffff888079359060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x170/0x410 net/bluetooth/hci_sync.c:305
>  #3: ffff888079358078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x150/0xb50 net/bluetooth/hci_sync.c:5337
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1983 [inline]
>  #4: ffffffff8ef238c8 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x158/0x370 net/bluetooth/hci_conn.c:1289
>  #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #5: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995
> 3 locks held by kworker/1:5/5500:
> 3 locks held by kworker/0:8/5556:
> 3 locks held by kworker/1:6/5586:
> 3 locks held by kworker/1:7/5659:
> 2 locks held by dhcpcd/20271:
>  #0: ffff88808e304130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1691 [inline]
>  #0: ffff88808e304130 (sk_lock-AF_PACKET){+.+.}-{0:0}, at: packet_do_bind+0x2c/0xf50 net/packet/af_packet.c:3202
>  #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:324 [inline]
>  #1: ffffffff8d1b8438 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3ff/0x800 kernel/rcu/tree_exp.h:995

With Boqun's patch, the failure of detecting mutex with runqueue lock
held disappeared but RCU stalled more than two minutes as before. 

