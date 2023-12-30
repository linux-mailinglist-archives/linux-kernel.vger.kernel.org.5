Return-Path: <linux-kernel+bounces-13303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 506BA82033B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81EBD1C2103C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 01:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21810E9;
	Sat, 30 Dec 2023 01:27:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777D4419
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 01:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.48.29])
	by sina.com (172.16.235.25) with ESMTP
	id 658F71ED00003E78; Sat, 30 Dec 2023 09:27:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0784034210107
X-SMAIL-UIID: 8235E027289949999FF295CE4876E4BB-20231230-092712-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+0e7b9b7452ded0356f2d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] BUG: unable to handle kernel paging request in mmu_notifier_invalidate_range_start
Date: Sat, 30 Dec 2023 09:26:59 +0800
Message-Id: <20231230012659.2135-1-hdanton@sina.com>
In-Reply-To: <0000000000001c6fbf060dab4271@google.com>
References: <0000000000001c6fbf060dab4271@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 29 Dec 2023 11:44:19 -0800
> HEAD commit:    aafe7ad77b91 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef73d6e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/proc/task_mmu.c
+++ y/fs/proc/task_mmu.c
@@ -2491,8 +2491,9 @@ static long do_pagemap_cmd(struct file *
 
 	switch (cmd) {
 	case PAGEMAP_SCAN:
-		return do_pagemap_scan(mm, arg);
-
+		if (mm)
+			return do_pagemap_scan(mm, arg);
+		/* fall thru */
 	default:
 		return -EINVAL;
 	}
--

