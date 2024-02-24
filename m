Return-Path: <linux-kernel+bounces-79661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DFF862548
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0926728267F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219C482DD;
	Sat, 24 Feb 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k2b7QEWf"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFB747A7C
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782530; cv=none; b=TsavZwkfDvqoyYwpXa1jNuk2puF4HLUb6GkgOWvVHV2dufrQeBLl0GNksjAIDjJOLFLUUJGw14n/euBmuEd8Ez1lc5byCeIFxFk/cl8VLiRhmZe8uGCu5iXiYf1IGAj6SCNd7e5EXm4BDzuKqy5Pjy1Si4ddaFOadvD9724r0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782530; c=relaxed/simple;
	bh=xS7CfPuCdYv2/HB/JqvriQTGNTjesNnKWYbwAyp5+Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JjZ+O/iXwvOUt1DnK2OmxwmTaTrs6vf43nEW080MKztME5chfh3+tW0XgP8Z6mpnpTNv2BmKHxWRJaUN8HF7tmLdQ8iIdtD6bnqZ9cwmeBss9o0ws4X47NmZWj8KMGCggcPRbbnGMcD9LldN7X0UNZPFUKRagQ9eZ+Ruwsk1qk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k2b7QEWf; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FQvJ3CvUbNX0txCaldr4SVr9xTNixtNpshkH7csGbWA=;
	b=k2b7QEWfKeHFi17VnPddVgjb0auAhanPy/rUOPm1RwcsxuZdKvMHzj65mxyGfRKI8FPS8C
	kYErZvn+31TShvQv7+lutM+lbutvTfpeyWt1Vmxc/l4x1Vi5NXCfYa7j3Xfe6IFDpvr7Tq
	K4pnd01jiTYRDGtnHJyVdpuvZeoSDFk=
From: chengming.zhou@linux.dev
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] freevxfs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:48:35 +0000
Message-Id: <20240224134835.829506-1-chengming.zhou@linux.dev>
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
 fs/freevxfs/vxfs_super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
index e6e2a2185e7c..42e03b6b1cc7 100644
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -307,7 +307,7 @@ vxfs_init(void)
 
 	vxfs_inode_cachep = kmem_cache_create_usercopy("vxfs_inode",
 			sizeof(struct vxfs_inode_info), 0,
-			SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD,
+			SLAB_RECLAIM_ACCOUNT,
 			offsetof(struct vxfs_inode_info, vii_immed.vi_immed),
 			sizeof_field(struct vxfs_inode_info,
 				vii_immed.vi_immed),
-- 
2.40.1


