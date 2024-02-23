Return-Path: <linux-kernel+bounces-79294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41647862073
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 727761C21B46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340FD14CAD1;
	Fri, 23 Feb 2024 23:02:32 +0000 (UTC)
Received: from mail115-69.sinamail.sina.com.cn (mail115-69.sinamail.sina.com.cn [218.30.115.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9314CACB
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708729351; cv=none; b=hjx8Bxxg6R++kLgrBUohxcfvBq7MY3JlW33Wm86ttjdZ5RfbILBbUqJunAaf0upFk4SBdF/OnxmQoYQWVj/XemHtJGQO52y1AhFPcBISV7MfnwpYtbjVyutJ4hlSrCioxr9OD7kpj7UWHIMmnPH1EZVqSV7VWTBMuMB8jioM3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708729351; c=relaxed/simple;
	bh=zu4LCqmR8M+WHVQ/Jxn1gK3mfSI7I4iMFrAu8qwIs1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fxjNCb9+9DQZ6ot0sa7KSki37YiqpObQsFNXpFyJFT10GEoHDes9TkZTQwhyYDuw4uGQ9fIb7EOpEM+h6ljMes+qa3tO05YlTNVGZ2ji7bjXH8esaMeRrnllVMxdyFi8IwV4RA6w5Mk5ha8VDOPLX6gfO8KrspR3KeaDZnuJTXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.139])
	by sina.com (10.75.12.45) with ESMTP
	id 65D923F6000016E5; Fri, 24 Feb 2024 07:02:16 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 98315631458029
X-SMAIL-UIID: 35DC0772838140A1BEE8DAAB78546E06-20240224-070216-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
Date: Sat, 24 Feb 2024 07:02:04 +0800
Message-Id: <20240223230204.297-1-hdanton@sina.com>
In-Reply-To: <000000000000a9373b0612093168@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 01:29:17 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9abbc24128bc Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a70158180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git  for-kernelci

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -1984,6 +1984,7 @@ static int taprio_change(struct Qdisc *s
 		/* Protects against advance_sched() */
 		spin_lock_irqsave(&q->current_entry_lock, flags);
 
+		admin = rtnl_dereference(q->admin_sched);
 		taprio_start_sched(sch, start, new_admin);
 
 		rcu_assign_pointer(q->admin_sched, new_admin);
--

