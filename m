Return-Path: <linux-kernel+bounces-135484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F189C679
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6B61C229D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFDD84D1C;
	Mon,  8 Apr 2024 14:11:31 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B475584A2B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585491; cv=none; b=q+PGlRNMniLGqYHpW6Pecp7pP/5IY02MAaL4ERJ7V84HMGrRnzwuMuNjSLfmveWuqFGA5CuUzW8O+G+OhUBk1nAbWVvSKGKKoNdcrZlsC6ohNPJRPfK1W/fkBmfUYvm6FGH3+BsbmhWjZS4+06UGeEALZJNy3eIdOFNnaff2Sn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585491; c=relaxed/simple;
	bh=eLXvdEPZ7Cv9E/VbzgBBf1ggcn+8mLUZyZt/b335WQ0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PAUTUVl0/MXrIuC6zLSgr3qJ5Vb5WDcOMi/nHIRIwYIr5Ywad81yZDvfHFLafbfGJD2fth6nSJAA1He39C8uB4f7S0gzj7BIc+4emhs9vQiBV9LU3CmHUPEI2b66rsiRRYiyIpgzte8SVGOU6FrrMWa87wee/n2tpqY71lWPbhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.169) with Microsoft SMTP Server (TLS) id 14.3.498.0; Mon, 8 Apr
 2024 17:11:19 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 8 Apr 2024
 17:11:19 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: Eric Van Hensbergen <ericvh@kernel.org>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Latchesar Ionkov
	<lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, "Christian
 Schoenebeck" <linux_oss@crudebyte.com>, <v9fs@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>,
	<syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
Subject: [PATCH net v2] net/9p: fix uninit-value in p9_client_rpc()
Date: Mon, 8 Apr 2024 07:10:39 -0700
Message-ID: <20240408141039.30428-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Syzbot with the help of KMSAN reported the following error:

BUG: KMSAN: uninit-value in trace_9p_client_res include/trace/events/9p.h:146 [inline]
BUG: KMSAN: uninit-value in p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 trace_9p_client_res include/trace/events/9p.h:146 [inline]
 p9_client_rpc+0x1314/0x1340 net/9p/client.c:754
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x6d3/0xbe0 mm/slub.c:3852
 p9_tag_alloc net/9p/client.c:278 [inline]
 p9_client_prepare_req+0x20a/0x1770 net/9p/client.c:641
 p9_client_rpc+0x27e/0x1340 net/9p/client.c:688
 p9_client_create+0x1551/0x1ff0 net/9p/client.c:1031
 v9fs_session_init+0x1b9/0x28e0 fs/9p/v9fs.c:410
 v9fs_mount+0xe2/0x12b0 fs/9p/vfs_super.c:122
 legacy_get_tree+0x114/0x290 fs/fs_context.c:662
 vfs_get_tree+0xa7/0x570 fs/super.c:1797
 do_new_mount+0x71f/0x15e0 fs/namespace.c:3352
 path_mount+0x742/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x725/0x810 fs/namespace.c:3875
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:3875
 do_syscall_64+0xd5/0x1f0
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

If p9_check_errors() fails early in p9_client_rpc(), req->rc.tag
will not be properly initialized. However, trace_9p_client_res()
ends up trying to print it out anyway before p9_client_rpc()
finishes.

Fix this issue by assigning default values to p9_fcall fields
such as 'tag' and (just in case KMSAN unearths something new) 'id'
during the tag allocation stage.

Reported-and-tested-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com
Fixes: 348b59012e5c ("net/9p: Convert net/9p protocol dumps to tracepoints")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
v2: change fc->tag init value from 0 to P9_NOTAG per Dominique
Martinet's <asmadeus@codewreck.org> helpful suggestion.
Link: https://lore.kernel.org/all/ZhNVMivKCCq6wir0@codewreck.org/

 net/9p/client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/9p/client.c b/net/9p/client.c
index f7e90b4769bb..b05f73c291b4 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -235,6 +235,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->id = 0;
+	fc->tag = P9_NOTAG;
 	return 0;
 }
 

