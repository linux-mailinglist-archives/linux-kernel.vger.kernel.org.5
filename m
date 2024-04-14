Return-Path: <linux-kernel+bounces-143954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053588A4005
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 05:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F8A51F214DC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 03:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3510F17551;
	Sun, 14 Apr 2024 03:31:36 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFE125C9
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713065495; cv=none; b=JiUKmE+YzRE3REvguFMDg0L7PyPLr4VnvDTE1fYnd+Glc/CvpEO2ZSgBp9K5BC5iyFqswxkv4WdBuYnbRf+82nOreKsab6FGghlk2HGLXIXTDZub87SXllk43CK2jZ9TOavNWnIGElJJ6pBUNiRzpel3ddQgKUssRhyZazrmLlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713065495; c=relaxed/simple;
	bh=hn79FhQY4wDdWmWDQxyNM70G3z1k4C3Lmk3QwFsPzdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uzyo6wjzkwBRsS37mbI8FBfLuxVkZwy/Op0gJCj0gfhvXx+b0X7SRBn4QjUdQmpBQlIdw1UwbK6xoh6abpTdsa+qcwZG6EaeHXWLVCAfiV2LIzcp/gNNPYZoyP8m2tROV3dy+f04KA5iI/odJXjLnIMi6eYD0H1KfTOt7Yo4Reo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.67.190])
	by sina.com (172.16.235.25) with ESMTP
	id 661B4E0D00002D47; Sun, 14 Apr 2024 11:31:27 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1166634210236
X-SMAIL-UIID: 4A42A3D1C0F94DF3BDB27A900084C834-20240414-113127-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
Date: Sun, 14 Apr 2024 11:31:19 +0800
Message-Id: <20240414033119.2079-1-hdanton@sina.com>
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

--- x/arch/x86/mm/fault.c
+++ y/arch/x86/mm/fault.c
@@ -1353,8 +1353,7 @@ void do_user_addr_fault(struct pt_regs *
 	}
 #endif
 
-	if (!(flags & FAULT_FLAG_USER))
-		goto lock_mmap;
+	goto lock_mmap;
 
 	vma = lock_vma_under_rcu(mm, address);
 	if (!vma)
--

