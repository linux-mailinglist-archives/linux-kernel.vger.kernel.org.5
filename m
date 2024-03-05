Return-Path: <linux-kernel+bounces-91917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB887185F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227D01C217FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D57F4DA08;
	Tue,  5 Mar 2024 08:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dm46b43Y"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4F2E40B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 08:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628034; cv=none; b=eDQ8gfEav1jG/QYpVuDgqJ9HvbNEQC5g9AtAxdyJAdMn+cK1aYTm+ntGAA79IF1EEwOngpWVbveqkbSHSKl5F8WUrt8I32aBdyrYzv/qVHI/yBucsTFzxBuzvTvtWwmu7//eGzVFw6/O4/f/LOBbimP2NB3NsiuGvhZMsGNHyuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628034; c=relaxed/simple;
	bh=bB0O4HMGDhNSXPSOoSNvY3Pf+2eC4gmH3K4SALTxqyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c15Y5m+TlzkFhbinNqVSEvjO5yVmwhCDI75EgCNgoE3UjLZue5S1oBLdS9Jy/hR5MfQVjnx66+oBkpBqDePQ6ywkO+qDszs+mcF5hwEDVw9fsQUMdDdkeaS59PwjxwQVMgciM5WF40mpWJFtVaxInqJnmCfLYZDoxQ+MFEl7r9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dm46b43Y; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709628029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DMJXg6OtFcxQuAUAyhKU1zyLUSvUQtK1GUV0JrguFxo=;
	b=dm46b43YXNP9zkVCyO+0/lpGKCYDBys0uYEc1GVDE6/plSp1br3ZikApqV/XTwWkSTZVBs
	XgEqgDLIa4N+m5r5Z45AwrjYEfKrf6oiOm93xqPyHcJ2OcgQbOdataGHoJO5B3OBIiGdTP
	MdCd53OzGIQeiLI3+2ThBJ/fcQoYr8s=
From: Chengming Zhou <chengming.zhou@linux.dev>
To: vbabka@suse.cz
Cc: akpm@linux-foundation.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>
Subject: [PATCH] slab: remove PARTIAL_NODE slab_state
Date: Tue,  5 Mar 2024 08:39:13 +0000
Message-Id: <20240305083913.1494784-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The PARTIAL_NODE slab_state has gone with SLAB removed, so just
remove it.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slab.h                  | 1 -
 tools/include/linux/slab.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 96cb74be4b69..d2bc9b191222 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -363,7 +363,6 @@ static inline int objs_per_slab(const struct kmem_cache *cache,
 enum slab_state {
 	DOWN,			/* No slab functionality yet */
 	PARTIAL,		/* SLUB: kmem_cache_node available */
-	PARTIAL_NODE,		/* SLAB: kmalloc size for node struct available */
 	UP,			/* Slab caches usable but not all extras yet */
 	FULL			/* Everything is working */
 };
diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 311759ea25e9..51b25e9c4ec7 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -18,7 +18,6 @@ bool slab_is_available(void);
 enum slab_state {
 	DOWN,
 	PARTIAL,
-	PARTIAL_NODE,
 	UP,
 	FULL
 };
-- 
2.40.1


