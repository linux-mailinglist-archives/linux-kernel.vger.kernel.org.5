Return-Path: <linux-kernel+bounces-116249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7C488A4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B4EB2401D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCF93C4B74;
	Mon, 25 Mar 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJBhxVq4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B521D1802A1;
	Sun, 24 Mar 2024 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324022; cv=none; b=XJvQvH+CeUrXEnmdMoMArxXBHnE9FUq5oLbGCp+1brAuKtwYPbiERCo/9krlZ1yGHQmqo2EfwEWkmj+GpJqAoK4KalWr8CmmDtRU2pOaLy6zqcwMnx9iZPqZelb0qp8xG79XsQbQpP2dKjDR9ouvWJuJPkpQ3liN4DlHyI7P6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324022; c=relaxed/simple;
	bh=LTi1uiWusNYqglrFjirvmacGHwvj6xPN7iV4nR1ZLyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aAZKiMI0xFJKXyiS+w3D1/jfCc+1WFBa9BCK4tLxvWYJwcz/JpUXSorTH4YYotd26p1ioRZXVmO1wemmlBDfLp3lsk6vWPSrV+/hFaJJtws6xOwAFKvVhnDbmMpeyheEzMuI2y+TsJ5tvloJiym7M5BgrKI9tCmImr+/cwwLtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJBhxVq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8ACC43390;
	Sun, 24 Mar 2024 23:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324021;
	bh=LTi1uiWusNYqglrFjirvmacGHwvj6xPN7iV4nR1ZLyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hJBhxVq4bc8bMw8QZSx/tVwA+1c17Cvdg37C+QlCfkvHmVp2FJg4R02nObmuAqDlL
	 yDy+S6Hn/GRlZbl8/3xiMGoZvgxO2mHgLyoG5s1SftwkCYuiHsgBMqtHXalOpe+WEK
	 ODoIuoYr0Q50um+Lf3pAlBUT0YGpPG+j6KRXiZA98RWcGIdtY++Gzp3Kis3vCxk0UL
	 7G1eI8vcx6bfeIN2s4idTORzvCzZECYDITC0eFPzSPMjKY+LuSK6wIZ3jtCrs5Fd5C
	 hn+B184EdY0xK9dHiZUzuWjPRLL6b75lLFJ38Ed+V/K6+yixjXTHtxt+KzuK1ZAMOY
	 YzrFRKkR1T6DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Chuck Lever III <chuck.lever@oracle.com>,
	syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 022/183] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
Date: Sun, 24 Mar 2024 19:43:55 -0400
Message-ID: <20240324234638.1355609-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 3948abaa4e2be938ccdfc289385a27342fb13d43 ]

syzbot identified a kernel information leak vulnerability in
do_sys_name_to_handle() and issued the following report [1].

[1]
"BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x100 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 do_sys_name_to_handle fs/fhandle.c:73 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 do_sys_name_to_handle fs/fhandle.c:39 [inline]
 __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
 __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
 __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
 ...

Bytes 18-19 of 20 are uninitialized
Memory access of size 20 starts at ffff888128a46380
Data copied to user address 0000000020000240"

Per Chuck Lever's suggestion, use kzalloc() instead of kmalloc() to
solve the problem.

Fixes: 990d6c2d7aee ("vfs: Add name to file handle conversion support")
Suggested-by: Chuck Lever III <chuck.lever@oracle.com>
Reported-and-tested-by: <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://lore.kernel.org/r/20240119153906.4367-1-n.zhandarovich@fintech.ru
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 01263ffbc4c08..9a5f153c8919e 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -37,7 +37,7 @@ static long do_sys_name_to_handle(struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
-- 
2.43.0


