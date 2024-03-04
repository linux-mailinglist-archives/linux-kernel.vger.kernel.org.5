Return-Path: <linux-kernel+bounces-90707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1CA8703A5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8602A286AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3B23F8E4;
	Mon,  4 Mar 2024 14:08:07 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA33F9FC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561287; cv=none; b=sPPOOw8XJlB4f5aq5IfzFyxdI2D2UemFhTJR+75va1MZBs4GcYyCb30lITl9cpAxLlNzmGJQg01VwT5yLJLO3dtSJZ/Va4FdRkMBFUVwARdzrcWke4uuKIqmbM5GuJvnrgonRnDJtDnL43mDerBQgxIHnTwkOzxe9qaonaWeXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561287; c=relaxed/simple;
	bh=RTTjJrKbQGC+to+9CcT3Rjd8f3nh2/o7sz3wwy6ugbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFntVRDCBTmvSP5R4tnZOJt+pBjWjRp/WiwjR0c7miNT1WT/3hD8ZofgIem/3NacSEW4S9STn/oKF9h8T5j4LtevLizpXvMQUa5HeWkONBU/1KWunS7P1rbnbGi3U329+kV6e/FjRbv3+CP/X5PC/liIWesbE7k/CSx/zKQ9AMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.159])
	by sina.com (10.75.12.45) with ESMTP
	id 65E5D58D000033AD; Mon, 4 Mar 2024 22:07:15 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4786531458218
X-SMAIL-UIID: 51EAB7993DE54EFFBB1471E35B6BB18F-20240304-220715-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
Date: Mon,  4 Mar 2024 22:07:02 +0800
Message-Id: <20240304140702.1457-1-hdanton@sina.com>
In-Reply-To: <0000000000006945730612bc9173@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 02 Mar 2024 23:29:23 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    5ad3cb0ed525 Merge tag 'for-v6.8-rc2' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13877412180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/fs/aio.c
+++ y/fs/aio.c
@@ -2194,6 +2194,8 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
 		if (kiocb->ki_res.obj == obj) {
 			ret = kiocb->ki_cancel(&kiocb->rw);
+			if (ret == 0)
+				refcount_inc(&kiocb->ki_refcnt);
 			list_del_init(&kiocb->ki_list);
 			break;
 		}
@@ -2204,8 +2206,11 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t
 	 * The result argument is no longer used - the io_event is always
 	 * delivered via the ring buffer.
 	 */
-	if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW)
-		aio_complete_rw(&kiocb->rw, -EINTR);
+	if (ret == 0)
+		if (kiocb->rw.ki_flags & IOCB_AIO_RW)
+			aio_complete_rw(&kiocb->rw, -EINTR);
+		else
+			iocb_put(kiocb);
 
 	percpu_ref_put(&ctx->users);
 
--

