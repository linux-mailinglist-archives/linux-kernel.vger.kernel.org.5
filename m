Return-Path: <linux-kernel+bounces-79674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5BD862559
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60F221F21B15
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B917D47A67;
	Sat, 24 Feb 2024 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixX5h0Gt"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F7146448
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782650; cv=none; b=EHNkxMz0fmj9xSd9CKI3S8UfmH9KtAt2ZBTkmEFP3qAofpz52rOOu35GdvoYPbQL0Oek50T5GHhl9T1z7zTdc/Tsh/ZZvvvQUllRnDXKp5OpJGD9B6oCSxECoU+Qhll/TShzNeaZPdb70RaYr+VjRsWrkm2dWcu3gU+tYXBvzkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782650; c=relaxed/simple;
	bh=hqPlMODDNVj/DdRhw0M9bZ7QxJPapegOj39rz9GYHvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uEoM6SymoGk2wn03Gj78nsUlFNu00CCC9d+xtvaL3vtorY2AEg3hYUfawihw5ny7xZ7vJoth5FF91wLuJpesjVQhO+dJF4JcCCEryMqlaCyTPYayNyQe++sK9hRDeitN7J90DXm2yFXeKyd6B7f+REZ2Vdut6DIt5QgWA7CL/oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixX5h0Gt; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ibi+RfJ5mT99XLSFTys/B4elpEMlKczBAC3WL/MY6eM=;
	b=ixX5h0Gtd4jKYQnE25b2A9iGb5a8Z5bfMv8Na2cntWCPp3YEYABAOrT+P//lAYV8WpKqrm
	8fDxB6ayvTwqUv+LYGkFEBk7YlcRhiBeWq1qhj0/f+Ljz2h+kx93Z7jnfOfdwhOKBGvJil
	Bhk0VqHORLC/8A1y56RPcCzBQs2shVM=
From: chengming.zhou@linux.dev
To: miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-unionfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] overlayfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:50:36 +0000
Message-Id: <20240224135036.829942-1-chengming.zhou@linux.dev>
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
 fs/overlayfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 36d4b8b1f784..a40fc7e05525 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1503,7 +1503,7 @@ static int __init ovl_init(void)
 	ovl_inode_cachep = kmem_cache_create("ovl_inode",
 					     sizeof(struct ovl_inode), 0,
 					     (SLAB_RECLAIM_ACCOUNT|
-					      SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+					      SLAB_ACCOUNT),
 					     ovl_inode_init_once);
 	if (ovl_inode_cachep == NULL)
 		return -ENOMEM;
-- 
2.40.1


