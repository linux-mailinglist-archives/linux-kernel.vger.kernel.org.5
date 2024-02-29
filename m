Return-Path: <linux-kernel+bounces-86296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC486C390
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1EB4B20F74
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1A4F1F9;
	Thu, 29 Feb 2024 08:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mQLRID5R"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0126481D1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195680; cv=none; b=g68FyyUt0C5y2kU4rL0lopVQ4XkI6B9bjOa6MsE4bJykKhoTjLSM+KhfFczNLCZhsqrT5rov4iAIrncXMWVy/WQDvyy7Rjy1Omj4Aomxp4uNsQPffrnTe23G/a0zQo5Jhdrh3u6bv3mzLK7oX3IvMTWzaoFePAG1f/hz9hTc+Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195680; c=relaxed/simple;
	bh=PtmJDoA1H7SAn1CqzqBzHGTEfAfkzw/1rSUcVqWa4Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CehP9+YNdYKvxeQT6HENwkmPxf6c2Gnq/P+JDI8W4DXxn/1+/W/RapUkwXCF21zpNSWKSHVJRG/HGzZ8vxoqyePasXNI11qbqQPpvSu0HEZNX+4jTmd+1F2dcLBo4iMH3mjqdpznz++P+ayuuH0nCNa4kjSu+NV0kczfX8ej5k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mQLRID5R; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709195675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c4hqPXVYzAPKLJpLD1lYkRxhseQa0+qO76gLH6MQGf8=;
	b=mQLRID5RGJsIYKfmSTAqOY53BAsA4WAZ0BePYmie39/1QizuzOovA5S4I5TBOiAVyoWp3H
	CNJjh9ZM5cv+BCAsrdYIudxwvCfWG/jGFQcnfH3xj7SVFa3QkHEHr0UFNmJ4+yKZpbndt8
	jVp0H/m+WelwzyxcDMbdVU+sfssmHAs=
From: kunwu.chan@linux.dev
To: chandan.babu@oracle.com,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] xfs: use KMEM_CACHE() to create xfs_defer_pending cache
Date: Thu, 29 Feb 2024 16:33:42 +0800
Message-Id: <20240229083342.1128686-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
the creation of SLAB caches when the default values are used.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/xfs/libxfs/xfs_defer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index 66a17910d021..6d957fcc17f2 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -1143,9 +1143,7 @@ xfs_defer_resources_rele(
 static inline int __init
 xfs_defer_init_cache(void)
 {
-	xfs_defer_pending_cache = kmem_cache_create("xfs_defer_pending",
-			sizeof(struct xfs_defer_pending),
-			0, 0, NULL);
+	xfs_defer_pending_cache = KMEM_CACHE(xfs_defer_pending, 0);
 
 	return xfs_defer_pending_cache != NULL ? 0 : -ENOMEM;
 }
-- 
2.39.2


