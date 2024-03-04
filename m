Return-Path: <linux-kernel+bounces-90453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C086FF5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 424511F2219B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3746C374C1;
	Mon,  4 Mar 2024 10:45:22 +0000 (UTC)
Received: from mail78-59.sinamail.sina.com.cn (mail78-59.sinamail.sina.com.cn [219.142.78.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531BD25764
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549121; cv=none; b=cCd7W1HWxlYI3OT4pApDDcE/hIKv+yFVhzMMZRtNZzo9PCR3+r076LlkMH6VrgLY1Gqlg1IBDgbAIyWsDP65XxSgQiaOk/Z3uyDMVndrcK34kJYfaWeMPpcztAKj83YZFp8wn9b81ht/zB72Fd0QVUoTx5c0yxppjWZrZSvEyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549121; c=relaxed/simple;
	bh=PLOCerCJyfP8cOHEfZUjlmbNW1iTyeAmF7XJ+qQyqXw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeJB4c8A/wXi/FH+5odc7AH7QobO7DJIkKZYSezCwfajEDDSCKOQgpIYMJHHCMuZi/HR1KsOqYfDW8XDgHyubrz6nDmSYLhn4iTNnLdWN2EJi7gxSjWSgR6OPF7Ubvh5t7DpTlb5auMDkw4M21/hs8Xps/3UlTjQbTo9m2jrU0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.159])
	by sina.com (172.16.235.25) with ESMTP
	id 65E5A6300000384E; Mon, 4 Mar 2024 18:45:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 64487834210646
X-SMAIL-UIID: 345D9DF201C14AA489BF0A9333112DD0-20240304-184506-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
Date: Mon,  4 Mar 2024 18:44:57 +0800
Message-Id: <20240304104457.1348-1-hdanton@sina.com>
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
@@ -2195,6 +2195,11 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t
 		if (kiocb->ki_res.obj == obj) {
 			ret = kiocb->ki_cancel(&kiocb->rw);
 			list_del_init(&kiocb->ki_list);
+			if (ret == 0 && kiocb->rw.ki_flags & IOCB_AIO_RW) {
+				struct aio_kiocb *iocb = container_of(&kiocb->rw,
+									struct aio_kiocb, rw);
+				refcount_inc(&iocb->ki_refcnt);
+			}
 			break;
 		}
 	}
--

