Return-Path: <linux-kernel+bounces-100167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728478792DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D254284C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E12979B9A;
	Tue, 12 Mar 2024 11:20:30 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F779B90
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242429; cv=none; b=rM4gv1BqLBGmz+lxSbaXwXbG5IwVjwZbKiv9LmvRqL7GP2/kftP89WCkaZKXwoTGXpps5v2rcPTSualja8+2dJlFXSe5gYjpcOgAHxU7JLlrZ7ABLZJAfDMDfJ2z0RhXMxFmfXKy0D+Oy+0sGI6MIcTt9Q1fYLFfieac/QpWfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242429; c=relaxed/simple;
	bh=byTWuqt34OfXORoLUHVL4fAoDl9wJkIacEzuSj2mCAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IimGHllvZVruay36CWc/9bOy+LFnZ+hRl8V+s18wa34x7chI6KzRcopLKweBinxPSUxiLQbpF+4V5jwsEKthZdPFubl4j0fLLDnGZ6can0fg9fDgqjMLVY+kncsCZHAWdiU7Hw4W2Ge4iB1JUInseX43fCwTXZ7QhpEsvNDLUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.51.55])
	by sina.com (172.16.235.24) with ESMTP
	id 65F03A6C00007782; Tue, 12 Mar 2024 19:20:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 50145845089258
X-SMAIL-UIID: 2030E6FFB47E44AABCFBD0C87F71DC1D-20240312-192015-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in tty_write_room (2)
Date: Tue, 12 Mar 2024 19:20:03 +0800
Message-Id: <20240312112003.2116-1-hdanton@sina.com>
In-Reply-To: <000000000000fd3d660613636f95@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 11 Mar 2024 07:34:21 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    e8f897f4afef Linux 6.8
> git tree:       upstream
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f338d1180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/net/caif/caif_serial.c
+++ y/drivers/net/caif/caif_serial.c
@@ -306,8 +306,11 @@ static void ser_release(struct work_stru
 	if (!list_empty(&list)) {
 		rtnl_lock();
 		list_for_each_entry_safe(ser, tmp, &list, node) {
+			struct tty_struct *tty = ser->tty;
+
 			dev_close(ser->dev);
 			unregister_netdevice(ser->dev);
+			tty_kref_put(tty);
 			debugfs_deinit(ser);
 		}
 		rtnl_unlock();
@@ -369,8 +372,6 @@ static void ldisc_close(struct tty_struc
 {
 	struct ser_device *ser = tty->disc_data;
 
-	tty_kref_put(ser->tty);
-
 	spin_lock(&ser_lock);
 	list_move(&ser->node, &ser_release_list);
 	spin_unlock(&ser_lock);
--

