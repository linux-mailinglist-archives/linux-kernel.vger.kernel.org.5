Return-Path: <linux-kernel+bounces-143922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE73F8A3F99
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A871F21911
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA6C58231;
	Sat, 13 Apr 2024 23:34:04 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329722901
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713051243; cv=none; b=r4gXNWtEGkffp3fP+0/uZMWPLffhv+rlMRZJlbafnD2n73W01rht9efOM7+GKiTwVPGS1MXs2OIUq+qmO1eBW73YT6DmBQqVspzlglXpdlgIJRNnawx46NFuB0GFqir8XPLhpWSLunUqSp33tk2h/kVwR8/YVmfJcawt3DmZgDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713051243; c=relaxed/simple;
	bh=cAq51Bpq8Z2tEYjjWfeds21jtyJJKWO6ZOv5wrPzmvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RzEgp3Ch0glhehJ4janqBW9qYDdfZrsvwAzaY2KSFgD0yEVovemDa7CMIyM14tKWe5CUPSbqH8oCYjiP3lCgmFd2sD7fnbitl2dEN04CuYaXDxu5QJJyrHOWzKEzoo3oMSOjtU7Irz9sGdzQc6xJSwTUe0WuebeQ47nuBVb+iKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.25) with ESMTP
	id 661B165A00002DB9; Sat, 14 Apr 2024 07:33:48 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 73547734210394
X-SMAIL-UIID: 67EEC6A3EB374B7F8C2B12BB7AF09238-20240414-073348-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
Date: Sun, 14 Apr 2024 07:33:41 +0800
Message-Id: <20240413233341.1957-1-hdanton@sina.com>
In-Reply-To: <000000000000ae5d410615fea3bf@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 13 Apr 2024 11:34:32 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bd4457180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1370ea67180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  9ed46da14b9b

--- x/mm/mmap.c
+++ y/mm/mmap.c
@@ -2657,8 +2657,6 @@ do_vmi_align_munmap(struct vma_iterator
 	/* Point of no return */
 	mm->locked_vm -= locked_vm;
 	mm->map_count -= count;
-	if (unlock)
-		mmap_write_downgrade(mm);
 
 	prev = vma_iter_prev_range(vmi);
 	next = vma_next(vmi);
@@ -2677,7 +2675,7 @@ do_vmi_align_munmap(struct vma_iterator
 	remove_mt(mm, &mas_detach);
 	validate_mm(mm);
 	if (unlock)
-		mmap_read_unlock(mm);
+		mmap_write_unlock(mm);
 
 	__mt_destroy(&mt_detach);
 	return 0;
--

