Return-Path: <linux-kernel+bounces-79663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822B86254A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD0B1F22AF2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F334847784;
	Sat, 24 Feb 2024 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="owsXVVxo"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88243AC6
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782544; cv=none; b=UjiDotPt8emNs8HRCrnxFl3fEBvqUWcC7zBLXjBTPBeAKUkqMWU3IlMh2Hv9WrZY0RjfoF0qLpjqvfPwJYpXGnwIr45B7X1FUhmYNcNAYxQ//cEM5h2jQU5tydG5Pzh825ntJwHrZQ25s9jGxP9XdeE77SSYYV/ixSuz193RO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782544; c=relaxed/simple;
	bh=60D082aXTXwENGzw6rT6h94Rp26cfIcM3UZRSF/WZ+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pI4a4I16rK4QuDh+NQlAY+MD2DbU8m8HVMcbbEQSHRzp++5TZ0K4RtCLxKVVPPBtmzyZxCG+rf3dT8FYO85zNkR0NFC4ACWXzi0m74ya94OP6wNWpd0iX+mjiIcLnO0762jqPmKgZRM7ftYK4KwfTS5TBPLG6bUN5jjMPmNLedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=owsXVVxo; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RuRn9k+Q9OzhITclJPbaHGjQwwmdlVHJwJL5ACmL0v4=;
	b=owsXVVxohjtc/v1Xth20rpCLGfi8HfzC9CzazkujzCmYp7GdlsWytrzn9OzpKfNJGCh0Zy
	09TbTbp6tXWfFmV7ifKXvj7Sud0boLQMdQzSNjN8Kvf0/uRT7e8oMwadmwVFmZ5lUy5IQ2
	qNXlWEaX5otqyNRnvK9YDFDve+huMRY=
From: chengming.zhou@linux.dev
To: mikulas@artax.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] hpfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:54 +0000
Message-Id: <20240224134854.829561-1-chengming.zhou@linux.dev>
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
 fs/hpfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 6b0ba3c1efba..314834a078e9 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -255,7 +255,7 @@ static int init_inodecache(void)
 	hpfs_inode_cachep = kmem_cache_create("hpfs_inode_cache",
 					     sizeof(struct hpfs_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     init_once);
 	if (hpfs_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


