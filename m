Return-Path: <linux-kernel+bounces-83071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699A868E14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A3F1F22B94
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE81386CB;
	Tue, 27 Feb 2024 10:53:27 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11951386AE
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031206; cv=none; b=X1/DtUpjjIiTweBqxZQv3Cf9ASEfbYWJzI9JFJOCqcJAX2fKuhiiRywgpmZRVTUspWnSH3nhOXC53IrU4bsWcSmW3GRfcqUYVcnwGCkOzRD7RCdO2wnu8BIk4m5DvzM4cUvNWvJvGBJ/BrL2RY0MBRwO+FrCYYYSPFRq7nq9wlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031206; c=relaxed/simple;
	bh=up80Ewx5Z1o1h8/iNPfmvLnaFsEZXQywW6b0ZaDSuDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEtfbbGpuUSdKrfr+3kXcqxz40lvMz8dmzvVndiQaTJ5uqTtVm8DRcsB5/UCkGVpiQrAotrb5EFNlKSVNdhfqGQF4owyfs70LRUG7CIE5Rj25Ng+ozctj/etNBqluZ+ZOcjfYRi1/3QBhB1SRDpw/oKHVaFSjRamn4Lsl80N8rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.169])
	by sina.com (172.16.235.24) with ESMTP
	id 65DDBF1500006C5B; Tue, 27 Feb 2024 18:53:11 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 87445445089294
X-SMAIL-UIID: 118B64FADD7F4FC1B4574058270DEBD8-20240227-185311-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a225ee3df7e7f9372dbe@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] [media?] inconsistent lock state in valid_state (2)
Date: Tue, 27 Feb 2024 18:53:01 +0800
Message-Id: <20240227105301.1525-1-hdanton@sina.com>
In-Reply-To: <00000000000066a91a0612527e6d@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 26 Feb 2024 16:56:17 -0800
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    d206a76d7d27 Linux 6.8-rc6
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1704b3e2180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/dma-buf/sync_debug.c
+++ y/drivers/dma-buf/sync_debug.c
@@ -107,15 +107,16 @@ static void sync_print_fence(struct seq_
 static void sync_print_obj(struct seq_file *s, struct sync_timeline *obj)
 {
 	struct list_head *pos;
+	unsigned long flags;
 
 	seq_printf(s, "%s: %d\n", obj->name, obj->value);
 
-	spin_lock_irq(&obj->lock);
+	spin_lock_irqsave(&obj->lock, flags);
 	list_for_each(pos, &obj->pt_list) {
 		struct sync_pt *pt = container_of(pos, struct sync_pt, link);
 		sync_print_fence(s, &pt->base, false);
 	}
-	spin_unlock_irq(&obj->lock);
+	spin_unlock_irqrestore(&obj->lock, flags);
 }
 
 static void sync_print_sync_file(struct seq_file *s,
--

