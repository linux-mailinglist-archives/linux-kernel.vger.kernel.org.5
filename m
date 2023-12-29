Return-Path: <linux-kernel+bounces-13047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9181FEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 11:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94819B22684
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 10:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE82C10A31;
	Fri, 29 Dec 2023 10:46:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AAF10A18
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 10:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.91])
	by sina.com (172.16.235.25) with ESMTP
	id 658EA3690000341E; Fri, 29 Dec 2023 18:46:04 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 41408134210581
X-SMAIL-UIID: 1A00ED718C80424BBBD6C65014B3F6D0-20231229-184604-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in fq_pie_timer (2)
Date: Fri, 29 Dec 2023 18:45:51 +0800
Message-Id: <20231229104551.1876-1-hdanton@sina.com>
In-Reply-To: <000000000000a3123d060d7e22bd@google.com>
References: <000000000000a3123d060d7e22bd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 27 Dec 2023 05:54:18 -0800
> HEAD commit:    7c5e046bdcb2 Merge tag 'net-6.7-rc7' of git://git.kernel.o..
> git tree:       net
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1127e71ae80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/sched/sch_fq_pie.c
+++ y/net/sched/sch_fq_pie.c
@@ -385,8 +385,7 @@ static void fq_pie_timer(struct timer_li
 	root_lock = qdisc_lock(qdisc_root_sleeping(sch));
 	spin_lock(root_lock);
 
-	/* Limit this expensive loop to 2048 flows per round. */
-	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 2048);
+	max_cnt = min_t(int, q->flows_cnt - q->flows_cursor, 512);
 	for (i = 0; i < max_cnt; i++) {
 		pie_calculate_probability(&q->p_params,
 					  &q->flows[q->flows_cursor].vars,
@@ -401,7 +400,7 @@ static void fq_pie_timer(struct timer_li
 		next = tupdate;
 	}
 	if (tupdate)
-		mod_timer(&q->adapt_timer, jiffies + next);
+		mod_timer(&q->adapt_timer, jiffies + max(2, next));
 	spin_unlock(root_lock);
 	rcu_read_unlock();
 }
--

