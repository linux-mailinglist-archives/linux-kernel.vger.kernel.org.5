Return-Path: <linux-kernel+bounces-79668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81122862551
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6801F225CC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312894C619;
	Sat, 24 Feb 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XaxyAx8G"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A73495E0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782592; cv=none; b=rZGuVhQYnk3/jyl4eh+N4Qi5ae0nTPVUFrOvKRfCbqUpZxDunOKa30nRozZjHI2kPzbFeIXyXbZ5cm1HCH+j2dA+cWIJwpQkHIWqZKWDiYGKmhNSTL9ON7+fwEhUPN9Oq2Av1osbLO5sbGxKtBB8MZFlkRDuYcC4I9oG7AOe1jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782592; c=relaxed/simple;
	bh=psGqbKCZJvtTfj70n9oiQysWPutxSGHMFabRDoI2bdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kT+HBDqhTvumncMeI14wAeCeb3iloQzNQlVxgmPrDY/no+Xx/XBK3DGQWG0BILe551m6TmlElFfoumnEpn5fJBmzWA2laN2TgKgXaTDg2jckgmcm8jmZ3IfFsjFAiqFxqkejLKf2FJDUGfcQb/ciJa9VDA6T8/Mf5+Zlk6XhBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XaxyAx8G; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AZpXrxfoWoYAEcJ0c/7aW0g1dHtz8hxGPREGgOOuDvM=;
	b=XaxyAx8GadkYGZQ8ZR8FYcgtx3HFu1k70horZpgRnKWox67XhHNakjOHZfsVV1eXapWBsD
	KHNFlKCIJOH6ye1CSnzVUz9Ppv8k/MIeXFYF8LQLbsevOXybNAtjlE4+N+hh3mVWhk3F60
	apMfpjeqxjsaQDKJ+RxMzLxHLE6m5qo=
From: chengming.zhou@linux.dev
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] net: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:43 +0000
Message-Id: <20240224134943.829751-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 net/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index ed3df2f749bf..7e9c8fc9a5b4 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -343,7 +343,7 @@ static void init_inodecache(void)
 					      0,
 					      (SLAB_HWCACHE_ALIGN |
 					       SLAB_RECLAIM_ACCOUNT |
-					       SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+					       SLAB_ACCOUNT),
 					      init_once);
 	BUG_ON(sock_inode_cachep == NULL);
 }
-- 
2.40.1


