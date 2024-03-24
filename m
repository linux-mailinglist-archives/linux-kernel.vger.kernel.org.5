Return-Path: <linux-kernel+bounces-112888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CFE887F82
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0761C21132
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579853DB97;
	Sun, 24 Mar 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4APUedv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEE14A8B;
	Sun, 24 Mar 2024 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319699; cv=none; b=S6bDbWqZPgdaO+FQu7zsAldyC3NeWKO6eub2jXjvKro4uN5S8c7AZCRATneKEe49tEeAmq2vmMQ4K83Vjx2pcd7vfdT0p5tBRw4zbNbiGJ+U78wyVQvKweTSPxTcwPDkWoH11Z1oQHPauZqv7KyO1jTMapIBsscTt6wcBAummsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319699; c=relaxed/simple;
	bh=cjoyQ1faXxRarwNjQiwL0MuY+lSCvlUxadrZlLQ452M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOkdK4e28PrDmmCeEpj3cq/3DLnLk5bvq5qhsiyiBBwqDsOKqI3AZjvvfEC72zfMLRKBxRaAVmGt1wZZUujx+BD9VF/k4XnPUjFuUtuoacYZKEo9lrVb/KzK3wvE7k8EhuXcaBlyEUr9NPgTVeVW1xtwpa219xlsG15Xp+HbV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4APUedv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419C5C43390;
	Sun, 24 Mar 2024 22:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319699;
	bh=cjoyQ1faXxRarwNjQiwL0MuY+lSCvlUxadrZlLQ452M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4APUedvHZX3hC0xherGQISjWD6U90vZ5tA8OI7OZhS16Jaio/ZK5yxC7m5pMxiJ8
	 U2aCkTs6R6Gahyyio3qq/OVroibSNPioFKY+wOkpT395wbUOQTXxSh9Xw6q7UmpMTr
	 vps/KCEYCcZQ54aUD7BYOkxUPdyl4xTmIqbfc4aqENw8Lu8kYrKoI+o3S2CJE7V3RJ
	 sKX35E8doMN3IEPxqA71F887f/0dBY4UWXB8lq3xMqbIMYaPpYWH2xJI4BqwTaD/W1
	 8nR7zewzAC4vEM93A3nrn8GnV9nY9nrfIp1l7qOxiauz7kSDpCLTWfN4c7RzJzOGlw
	 3xn14kxmLXOTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Chuck Lever III <chuck.lever@oracle.com>,
	syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 001/715] do_sys_name_to_handle(): use kzalloc() to fix kernel-infoleak
Date: Sun, 24 Mar 2024 18:23:00 -0400
Message-ID: <20240324223455.1342824-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 18b3ba8dc8ead..57a12614addfd 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -36,7 +36,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (f_handle.handle_bytes > MAX_HANDLE_SZ)
 		return -EINVAL;
 
-	handle = kmalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
+	handle = kzalloc(sizeof(struct file_handle) + f_handle.handle_bytes,
 			 GFP_KERNEL);
 	if (!handle)
 		return -ENOMEM;
-- 
2.43.0


