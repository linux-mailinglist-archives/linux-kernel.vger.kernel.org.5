Return-Path: <linux-kernel+bounces-35004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 207DC838A68
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F391F26B04
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DE55C5FB;
	Tue, 23 Jan 2024 09:33:59 +0000 (UTC)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AB5C5E1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002439; cv=none; b=SOg4cWxOF3ysqJ0IPiGKqWHhbWB0gpv5W822Ff2jNy7HvR9r/wHKmj5dHpV+PzrPCNidQq8o08OvtQKoV4TRmC3CubYVzolrlymPKiD/LEEShK2uuJ16AVtLioJAjdZRf+uRs36ByOBADwB+DU/y9OeA8kQ8gRG5xgNfIA5negs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002439; c=relaxed/simple;
	bh=cuwSKTPtiNqZTZ2D9xT7/HRhzSDVJccC9FWGQ4Ep0yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IHjkiNIMSKozfrwDzPAtpEvP8LJIljWX5feNXbIuPPiuR8NCxw1p1ugs8AGLEy9Y2n3NkGV0+tSuq50deZZxyQtsb55zSN9rTC2wVpRHA6N8xRjz0HCHAbBZGfu+QyCrd/ixAURrjbECTPo94SM7YD5yxl3oouKOgGRPrBzQmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 23 Jan 2024 09:33:30 +0000
Subject: [PATCH v2 2/3] mm/slub: remove full list manipulation for non-debug slab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v2-2-81766907896e@bytedance.com>
References: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
In-Reply-To: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-mm@kvack.org, "Christoph Lameter (Ampere)" <cl@linux.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706002427; l=1153;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=cuwSKTPtiNqZTZ2D9xT7/HRhzSDVJccC9FWGQ4Ep0yw=;
 b=mJdc+YnrEwU86ZPAWNO2hIOji1KtwvraB80SdFXY8/3S14XjUgouN7U9QY4VsPfbv0iWMF2qa
 jNF2VdpUcx9CAUqOdk6g8VKSrJo7sg3GFd7D/n6FIaKYhdVOjnloqeD
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Since debug slab is processed by free_to_partial_list(), and only debug
slab which has SLAB_STORE_USER flag would care about the full list, we
can remove these unrelated full list manipulations from __slab_free().

Acked-by: Christoph Lameter (Ampere) <cl@linux.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index fda402b2d649..5c6fbeef05a8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4188,7 +4188,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	 * then add it.
 	 */
 	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
-		remove_full(s, n, slab);
 		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
@@ -4202,9 +4201,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		 */
 		remove_partial(n, slab);
 		stat(s, FREE_REMOVE_PARTIAL);
-	} else {
-		/* Slab must be on the full list */
-		remove_full(s, n, slab);
 	}
 
 	spin_unlock_irqrestore(&n->list_lock, flags);

-- 
b4 0.10.1

