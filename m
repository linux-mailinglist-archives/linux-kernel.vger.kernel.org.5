Return-Path: <linux-kernel+bounces-9635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F181C8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1066B1F239D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB989168AD;
	Fri, 22 Dec 2023 11:08:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D502156C4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.137])
	by sina.com (10.75.12.45) with ESMTP
	id 65856DEA00007A4D; Fri, 22 Dec 2023 19:07:25 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7738631457808
X-SMAIL-UIID: 261EA0277E8A4FDE9FC65B27B17B9A2A-20231222-190725-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ec9b5cce58002d184fb6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING: ODEBUG bug in advance_sched
Date: Fri, 22 Dec 2023 19:07:13 +0800
Message-Id: <20231222110713.1245-1-hdanton@sina.com>
In-Reply-To: <000000000000f3d57d060d0556a1@google.com>
References: <000000000000f3d57d060d0556a1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 21 Dec 2023 05:47:25 -0800
> HEAD commit:    1a44b0073b92 Merge tag 'ovl-fixes-6.7-rc7' of git://git.ke..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1465cbd6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -1941,6 +1941,9 @@ static int taprio_change(struct Qdisc *s
 
 	/* Protects against enqueue()/dequeue() */
 	spin_lock_bh(qdisc_lock(sch));
+	spin_lock_irqsave(&q->current_entry_lock, flags);
+	oper = rtnl_dereference(q->oper_sched);
+	admin = rtnl_dereference(q->admin_sched);
 
 	if (tb[TCA_TAPRIO_ATTR_TXTIME_DELAY]) {
 		if (!TXTIME_ASSIST_IS_ENABLED(q->flags)) {
@@ -1981,17 +1984,12 @@ static int taprio_change(struct Qdisc *s
 	} else {
 		setup_first_end_time(q, new_admin, start);
 
-		/* Protects against advance_sched() */
-		spin_lock_irqsave(&q->current_entry_lock, flags);
-
 		taprio_start_sched(sch, start, new_admin);
 
 		rcu_assign_pointer(q->admin_sched, new_admin);
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
-		spin_unlock_irqrestore(&q->current_entry_lock, flags);
-
 		if (FULL_OFFLOAD_IS_ENABLED(q->flags))
 			taprio_offload_config_changed(q);
 	}
@@ -2004,6 +2002,7 @@ static int taprio_change(struct Qdisc *s
 				   "Size table not specified, frame length estimations may be inaccurate");
 
 unlock:
+	spin_unlock_irqrestore(&q->current_entry_lock, flags);
 	spin_unlock_bh(qdisc_lock(sch));
 
 free_sched:
@@ -2393,7 +2392,9 @@ static int taprio_dump(struct Qdisc *sch
 	struct sched_gate_list *oper, *admin;
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
+	unsigned long flags;
 
+	spin_lock_irqsave(&q->current_entry_lock, flags);
 	oper = rtnl_dereference(q->oper_sched);
 	admin = rtnl_dereference(q->admin_sched);
 
@@ -2436,6 +2437,7 @@ static int taprio_dump(struct Qdisc *sch
 	nla_nest_end(skb, sched_nest);
 
 done:
+	spin_unlock_irqrestore(&q->current_entry_lock, flags);
 	return nla_nest_end(skb, nest);
 
 admin_error:
@@ -2445,6 +2447,7 @@ options_error:
 	nla_nest_cancel(skb, nest);
 
 start_error:
+	spin_unlock_irqrestore(&q->current_entry_lock, flags);
 	return -ENOSPC;
 }
 
--

