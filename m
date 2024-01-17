Return-Path: <linux-kernel+bounces-28925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588938304B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07531288C14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9298C1EA7D;
	Wed, 17 Jan 2024 11:46:39 +0000 (UTC)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B41EA74
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491999; cv=none; b=D0EY42Ep+PxMVIzGQGluhunf3aD8aFiKagmo+9I6TiN8r1KNelpy6nRKGnJUlbYnqQF/y/J9aQrv0XY0rPXbEnOFmAEnkkv6H1s8tC4Ubism1CZvP3GPWRhn5dnNx75TkBf2ZWzfwPHeep0ipoZqTjft73vuU66sE5xD22fFSXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491999; c=relaxed/simple;
	bh=dSgFg48t7LupTsKBO2gZsJttDy0+Yco9PB4eWVCuRJk=;
	h=X-Report-Abuse:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=EWwdEYYLiKqurzLTK++xWd5ey2ipob9Fbtqr41i6yQPofI2AwqulpDkv5K2lV7zTk4TREAMMIN0bciHY59GJDuu4v/GPT2ekPPNTkz4AZyE0XXZ217/YXx8zmLx0b+NSq13QCLHUp36zA7+OuVOGtG3q3mnJ8wLqKGBfScTr6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 11:45:59 +0000
Subject: [PATCH 2/3] mm/slub: remove full list manipulation for non-debug slab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v1-2-fd1c49ccbe70@bytedance.com>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
In-Reply-To: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705491984; l=1053;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=dSgFg48t7LupTsKBO2gZsJttDy0+Yco9PB4eWVCuRJk=;
 b=5XIIuX0qwsSqEvymGfIXuXLWpVtl9zXEjYel4Re50np/cxam9armg3d5VQKRVueB0DNreHkfP
 hgVbFAM35ZaDZEywwRZZ52cNqr8+6l7gbh1JIGosavcoqYyq5KQue2/
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

Since debug slab is processed by free_to_partial_list(), and only debug
slab which has SLAB_STORE_USER flag would care about the full list, we
can remove these unrelated full list manipulations from __slab_free().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 20c03555c97b..f0307e8b4cd2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4187,7 +4187,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	 * then add it.
 	 */
 	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
-		remove_full(s, n, slab);
 		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
@@ -4201,9 +4200,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
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

