Return-Path: <linux-kernel+bounces-79665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E287286254D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECEB28256F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5BD4D9FA;
	Sat, 24 Feb 2024 13:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cN54ul6Z"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2D4D9EC
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782567; cv=none; b=BPDAFIe8slj5w2K30sxms9tyZOJmMf0xNpnt9pUeCZ7yR39v2GaVPRvddRDFVvgciPNdo0wIkpBsf8j82VrbXMC859xG5j2rOGIq+kgQj4YF/3TVgsri2NqGzTecPVwRTVfxjG/s+c7N6rL6ntL7ThLgUeXpciWMGkTJWshoD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782567; c=relaxed/simple;
	bh=W7UD1F/5Bz5m3vhfBmXr5VJC3ie048pW9273G0Vl2K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H8O8CdUzUWEPXiC5OVhMp2SHoKb1wI7TiMn5mfL1S+miJHOfXdhqpRii/MF0pzGbt6NuDWEDd8/G/tg+Uk0iAJX46QXnC4XknTTCDavo8ttg1TenJ+dxsC1Qw4f+c0RUik0YQEZZUOQtoXPpr7PA5Tk+ibIdJ60lWONQPgwrhvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cN54ul6Z; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=guC0tYSOwFj1pljxieRsXWQDCfWw7SO6MADQAq4Sld4=;
	b=cN54ul6ZprO/8c3ofBnudyuJRGjlWOQvkwVm6ErCNTDcq2HD4uCRdXdBHHUR5xWM2uAuj4
	ZITj0g7dnScatjMKsRQMp5dPS0/DGVKa4BZNITsV0bg8dHJfPz3pVSBtG+kXWBN5TgGpI9
	lwssAhdk2oMJ+UdqcPWjozXihH9TeAQ=
From: chengming.zhou@linux.dev
To: dwmw2@infradead.org,
	richard@nod.at,
	jack@suse.cz,
	chuck.lever@oracle.com,
	dave.kleikamp@oracle.com,
	amir73il@gmail.com
Cc: zhouchengming@bytedance.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev
Subject: [PATCH] jffs2: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:49:15 +0000
Message-Id: <20240224134915.829634-1-chengming.zhou@linux.dev>
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
 fs/jffs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index f99591a634b4..aede1be4dc0c 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -387,7 +387,7 @@ static int __init init_jffs2_fs(void)
 	jffs2_inode_cachep = kmem_cache_create("jffs2_i",
 					     sizeof(struct jffs2_inode_info),
 					     0, (SLAB_RECLAIM_ACCOUNT|
-						SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+						SLAB_ACCOUNT),
 					     jffs2_i_init_once);
 	if (!jffs2_inode_cachep) {
 		pr_err("error: Failed to initialise inode cache\n");
-- 
2.40.1


