Return-Path: <linux-kernel+bounces-79670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69035862554
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C8FB21936
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5AC4E1CA;
	Sat, 24 Feb 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nEN+r/Mz"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBF4E1BA
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782611; cv=none; b=omkxNKcvKsbFBEtKMa4Jag0czvIedQxPF3jGanumyrfQb2v1CfiQ1RNVfr/GuVKSJ6ORU4j1zY2REZji2lbwgnVP6S2uMx5XkLrHiJhcwQ8++GCj0m3OMc2jlPxNTRDHPRqMpF0UXdckuUSEccKL1vjNopCLQ9U+I1S6s7AMRVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782611; c=relaxed/simple;
	bh=SC68QRObN3rZto0vm71oNtq2r60WxPc8SvKlqbdxyb8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ErZARibXFbMEqpatAxfMe3zMlf7d+KoX4Hnmi+qBJiReCYcexMW7hJ1CzYi97Byslpnuj4MgD8SQxlYbPDODF9qEqfo0k/j+CV8sr8KficFfbyr8r+EQDYU24WrM285ktnsXNn3bg8InmDJQZn6aF7CESDs0USmsMuq657mAzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nEN+r/Mz; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JSm+Ir7WRkiulBopfOJkhQ6MG0eswa+pECgZqNpCfq4=;
	b=nEN+r/MzdqMbGgZ+spbwl3fekXWSnzE4u45vmFB9GcdFDRuPKn5LarV4Tgrm3Do2UFAo7h
	I/NrN/obH1evP/noF2aS0FKNXd+/ghElmI34+LuBkxZlTly6bWeR0yHF00pV6PjvZbLXlf
	4LZm/MBrBxT2zAiay+gXI+lPZzvikNo=
From: chengming.zhou@linux.dev
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] ntfs3: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:01 +0000
Message-Id: <20240224135001.829831-1-chengming.zhou@linux.dev>
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
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index cef5467fd928..9df7c20d066f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1825,7 +1825,7 @@ static int __init init_ntfs_fs(void)
 
 	ntfs_inode_cachep = kmem_cache_create(
 		"ntfs_inode_cache", sizeof(struct ntfs_inode), 0,
-		(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
+		(SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT),
 		init_once);
 	if (!ntfs_inode_cachep) {
 		err = -ENOMEM;
-- 
2.40.1


