Return-Path: <linux-kernel+bounces-12634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BE181F807
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F338D1C23652
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D573746C;
	Thu, 28 Dec 2023 12:06:58 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380756FDA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.182])
	by sina.com (10.75.12.45) with ESMTP
	id 658D64D700001E46; Thu, 28 Dec 2023 20:06:49 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0445831457300
X-SMAIL-UIID: D10D2FB298F246B3B241E561B6BD50E0-20231228-200650-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+15c3ba3f7ca8ced0914d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in fq_pie_timer (2)
Date: Thu, 28 Dec 2023 20:06:39 +0800
Message-Id: <20231228120639.1817-1-hdanton@sina.com>
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
@@ -401,7 +401,7 @@ static void fq_pie_timer(struct timer_li
 		next = tupdate;
 	}
 	if (tupdate)
-		mod_timer(&q->adapt_timer, jiffies + next);
+		mod_timer(&q->adapt_timer, jiffies + max(2, next));
 	spin_unlock(root_lock);
 	rcu_read_unlock();
 }
--

