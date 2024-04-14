Return-Path: <linux-kernel+bounces-143944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0918A3FF4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE61D1C210AB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4254D168B7;
	Sun, 14 Apr 2024 02:54:00 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5A14A85
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063239; cv=none; b=UJ85nYZsMNdWZZ2dny5j4B84QhH0UkfERD698Nm1ybL0wJkQIySzkQ8VUTaeTfpeMePUY816GO8am+ogkSVdLDz/g0l7pZrP6vVwoOZZiKHnAEeZmapQdhFG+Qot77eyvQheoqm7MhRBv2ptpj5sOBsCE9cDei7eJaviu704UUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063239; c=relaxed/simple;
	bh=zy0K+iCf3zYU47iljEWx3S6wTvSanM/KulIMP0AGmtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aa/V6i9aA+GdtiOFjBzTplRXTqPRzqRL0ts0QjhTHJSZ5PNmTUqI8IR54U+nAmi8qJw92Pm3cX8ytbzwHZqQx5sxzN9ADcu8ljrwCfHGarYPhk8qlEd/zGtXJNO34V1zzYSc/gpC9oTApfI48h5nvSACvFKY1bXgQUCrNWhV5bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.24) with ESMTP
	id 661B453400003049; Sun, 14 Apr 2024 10:53:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 51338845089306
X-SMAIL-UIID: FE900988FC064252B4C67AA7A4665485-20240414-105344-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kasan?] [mm?] INFO: rcu detected stall in __run_timer_base
Date: Sun, 14 Apr 2024 10:53:36 +0800
Message-Id: <20240414025336.2016-1-hdanton@sina.com>
In-Reply-To: <00000000000022a23c061604edb3@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 19:04:34 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111600cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  fe46a7dd189e

--- x/net/sched/sch_taprio.c
+++ y/net/sched/sch_taprio.c
@@ -980,7 +980,9 @@ first_run:
 	rcu_assign_pointer(q->current_entry, next);
 	spin_unlock(&q->current_entry_lock);
 
-	hrtimer_set_expires(&q->advance_timer, end_time);
+	hrtimer_set_expires(&q->advance_timer,
+				ktime_add(timer->base->get_time(),
+					  ns_to_ktime(NSEC_PER_USEC *200)));
 
 	rcu_read_lock();
 	__netif_schedule(sch);
--

