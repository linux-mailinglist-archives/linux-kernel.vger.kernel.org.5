Return-Path: <linux-kernel+bounces-7839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EE081AE13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA93FB24B10
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF879DC;
	Thu, 21 Dec 2023 04:36:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B486AD31
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 04:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.212])
	by sina.com (172.16.235.24) with ESMTP
	id 6583C0C900000A3E; Thu, 21 Dec 2023 12:36:28 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 21665445089237
X-SMAIL-UIID: B4CE006B2F90456F9A9BAB35FC041D79-20231221-123628-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
Date: Thu, 21 Dec 2023 12:36:15 +0800
Message-Id: <20231221043616.1182-1-hdanton@sina.com>
In-Reply-To: <0000000000000467ea060cc9a24b@google.com>
References: <0000000000000467ea060cc9a24b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 18 Dec 2023 06:33:26 -0800
> HEAD commit:    d5b235ec8eab Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e40371e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  d5b235ec8eab

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
@@ -2393,6 +2392,7 @@ static int taprio_dump(struct Qdisc *sch
 	struct sched_gate_list *oper, *admin;
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
+	int active = hrtimer_cancel(&q->advance_timer);
 
 	oper = rtnl_dereference(q->oper_sched);
 	admin = rtnl_dereference(q->admin_sched);
@@ -2436,6 +2436,10 @@ static int taprio_dump(struct Qdisc *sch
 	nla_nest_end(skb, sched_nest);
 
 done:
+	if (active)
+		hrtimer_start(&q->advance_timer,
+				hrtimer_get_expires(&q->advance_timer),
+				HRTIMER_MODE_ABS);
 	return nla_nest_end(skb, nest);
 
 admin_error:
@@ -2445,6 +2449,10 @@ options_error:
 	nla_nest_cancel(skb, nest);
 
 start_error:
+	if (active)
+		hrtimer_start(&q->advance_timer,
+				hrtimer_get_expires(&q->advance_timer),
+				HRTIMER_MODE_ABS);
 	return -ENOSPC;
 }
 
--

