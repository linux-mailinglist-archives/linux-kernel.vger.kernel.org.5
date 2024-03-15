Return-Path: <linux-kernel+bounces-104433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C087CDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0521F220C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3565F250FE;
	Fri, 15 Mar 2024 13:06:29 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731E18624
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710507988; cv=none; b=aCukTiBHy6Wt/idrCkOM2lM1shma0w3GAdKG6dvG3pOa0w1uMFe13AeCyc27Amyn0hvgGYyybiO9EsTk9FyzOvagZ/+U4qBnwjR5mPNmikMaVkwhyeG9ZgettVIipjnPheCDMZ+KMFowQON5bO0ulASCuz4Np9AI3Hii1OHVF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710507988; c=relaxed/simple;
	bh=yJudiLMA36Y3KxSoumkJPCVd40zRvl4KvkUR0jh4l5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcPJdxoZGhoE1wqgAQZs7IdUfczqjDNeNVqFbNSTB50FRdHqmsxN2mqfH4ltx2FQ3Bc72XBHORVQ8wjWMHSHFlXkz8VvC2Z7dur+I9t5Gv89TNnewGfwtRo1ppJG3R3T6xJ7eylUX6jExxiuu5SKVmqQclWeF26d7TQsrIIp+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.95])
	by sina.com (172.16.235.24) with ESMTP
	id 65F447BE00006E11; Fri, 15 Mar 2024 21:06:10 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 42060945089131
X-SMAIL-UIID: 1B503741C4CE417D9884D0A33183E19F-20240315-210610-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+f3bc6f8108108010a03d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.com
Subject: Re: [syzbot] [sound?] possible deadlock in snd_timer_close_locked
Date: Fri, 15 Mar 2024 21:05:58 +0800
Message-Id: <20240315130558.2420-1-hdanton@sina.com>
In-Reply-To: <00000000000099d9850613b12348@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Mar 2024 04:16:27 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a304a5180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/sound/core/timer.c
+++ y/sound/core/timer.c
@@ -409,8 +409,9 @@ static void snd_timer_close_locked(struc
 	struct snd_timer *timer = timeri->timer;
 
 	if (timer) {
-		guard(spinlock)(&timer->lock);
+		spin_lock_irq(&timer->lock);
 		timeri->flags |= SNDRV_TIMER_IFLG_DEAD;
+		spin_unlock_irq(&timer->lock);
 	}
 
 	if (!list_empty(&timeri->open_list)) {
--

