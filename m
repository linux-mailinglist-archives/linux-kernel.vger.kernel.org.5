Return-Path: <linux-kernel+bounces-5053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 717898185F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D04D1F2542B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9F18036;
	Tue, 19 Dec 2023 11:00:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78DE168AF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.253])
	by sina.com (10.75.12.45) with ESMTP
	id 658177A200003A3B; Tue, 19 Dec 2023 18:59:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 74615731457918
X-SMAIL-UIID: 9B75F35E411D4066911CDD70E6D8B3C4-20231219-185949-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
Date: Tue, 19 Dec 2023 18:59:38 +0800
Message-Id: <20231219105938.1773-1-hdanton@sina.com>
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
@@ -2393,6 +2393,7 @@ static int taprio_dump(struct Qdisc *sch
 	struct sched_gate_list *oper, *admin;
 	struct tc_mqprio_qopt opt = { 0 };
 	struct nlattr *nest, *sched_nest;
+	int active = hrtimer_cancel(&q->advance_timer);
 
 	oper = rtnl_dereference(q->oper_sched);
 	admin = rtnl_dereference(q->admin_sched);
@@ -2436,6 +2437,10 @@ static int taprio_dump(struct Qdisc *sch
 	nla_nest_end(skb, sched_nest);
 
 done:
+	if (active)
+		hrtimer_start(&q->advance_timer,
+				hrtimer_get_expires(&q->advance_timer),
+				HRTIMER_MODE_ABS);
 	return nla_nest_end(skb, nest);
 
 admin_error:
@@ -2445,6 +2450,10 @@ options_error:
 	nla_nest_cancel(skb, nest);
 
 start_error:
+	if (active)
+		hrtimer_start(&q->advance_timer,
+				hrtimer_get_expires(&q->advance_timer),
+				HRTIMER_MODE_ABS);
 	return -ENOSPC;
 }
 
--

