Return-Path: <linux-kernel+bounces-79680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6B862563
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7941C21368
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38C47F7A;
	Sat, 24 Feb 2024 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FACSaXwA"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A7125C3
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782712; cv=none; b=i7k5vVNZv7AqjqHknCv8bNh6xG++G8mxUrJ93a2TT3djAQAYbmlk/CmVG7y+NFyaAZedbsi/Kra1yZoY9Z6M7n0uuudpRgKHBYFsQpX/uvYom0BnOiIxzJ9Iymxi7U6N6kXGwM0kX3Yo9xSkpG+2UihCTsnxXRPDnpoWfq2IHf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782712; c=relaxed/simple;
	bh=uatpp2XJ1Xg79pTa5FCK7wNpCIj04AEIsfpgHap5s2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YLWt4ieHcWivqp2glyyZl/eTPn/c+KSXSEesSvGVZ9XbVv51Onc5owNZl8/YqSFJuU3pjRMg2j/p1WjJ3C+KaQFEp8S31pkhyh0twTnMdROmf0FjKu7cB5T2uzBMFkgG8PiObXMSAhNnDYqb/RFactWAukWYZaS2lkAvsu88X7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FACSaXwA; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sLHtO33Ubm3a9KIWmkpmggib7Qf+tnLzeQj9fuz3h5Y=;
	b=FACSaXwArpMAxz8sFg5gm7MkF3MukXBrAtABPCHeq0SwH3bLwy8utrXt1lEiIEJHFoJlVY
	DBHj9Fpu1lEfbSSn4Ca8DRY2BLXo07Ohw4gXhGJ2ywNAMPZIFkGxY+/79HWqIaDUrOqAF+
	jl+wGohkGliNF+NTX00CwEQUxw3jXC0=
From: chengming.zhou@linux.dev
To: brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	zhouchengming@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] romfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:51:43 +0000
Message-Id: <20240224135143.830142-1-chengming.zhou@linux.dev>
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
 fs/romfs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 1ed468c03557..2be227532f39 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -630,8 +630,8 @@ static int __init init_romfs_fs(void)
 	romfs_inode_cachep =
 		kmem_cache_create("romfs_i",
 				  sizeof(struct romfs_inode_info), 0,
-				  SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD |
-				  SLAB_ACCOUNT, romfs_i_init_once);
+				  SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
+				  romfs_i_init_once);
 
 	if (!romfs_inode_cachep) {
 		pr_err("Failed to initialise inode cache\n");
-- 
2.40.1


