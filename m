Return-Path: <linux-kernel+bounces-28926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8018304B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB7F288E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B041EB38;
	Wed, 17 Jan 2024 11:46:43 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC2F1EB31
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492002; cv=none; b=tP/tjJ50G4jnCfL6KtpugbIzbxn0RqrQs4zTWtt8x/+FbRZeA6QU81G47Jub3jNe2WzmBtbXTvwfMuZHFguiBFbsy1l3ATi+T7rBOzuE+JFWN7uHhcN0NSXqasifX4SehG+sl5ekzuNxqUQ3BW7d3DCDx2xp3EHYE24m2B5UQGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492002; c=relaxed/simple;
	bh=FCOnwYrhZkluxCwU1rI7qym40IkKZ74sKbmGZdbV/NU=;
	h=X-Report-Abuse:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=q3euE1rv+7uIfFUJM+PCw6z+aBGxv4pEr2MD/NLZpqoxorUXfj4SDYxZcocEP/rK4HdwfCZNXpmLw5kgPlVCLLAfa+UR5SQgESSDfD1Bn0bgMLeqA5Oh41GrrMvSsl7u+oU2RzX32MOllKOQuByuB8AJdg9sPDUWgI7YfZBKtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 11:46:00 +0000
Subject: [PATCH 3/3] mm/slub: remove unused parameter in next_freelist_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v1-3-fd1c49ccbe70@bytedance.com>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
In-Reply-To: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705491984; l=1440;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=FCOnwYrhZkluxCwU1rI7qym40IkKZ74sKbmGZdbV/NU=;
 b=r60bI1xFOSY0XMd/T4Vsn0QUucBv9bV6X7Ko6gDXvzMuaW9qAxNwy6xtQTq9LHk4bfdsUq04n
 Izus8lbaiz1CHUbUv63tGpbiP1Tp3eAQ0hAti23U2ipWl75vInBFP5w
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The parameter "struct slab *slab" is unused in next_freelist_entry(),
so just remove it.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f0307e8b4cd2..3a4e2f8d341c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2243,7 +2243,7 @@ static void __init init_freelist_randomization(void)
 }
 
 /* Get the next entry on the pre-computed freelist randomized */
-static void *next_freelist_entry(struct kmem_cache *s, struct slab *slab,
+static void *next_freelist_entry(struct kmem_cache *s,
 				unsigned long *pos, void *start,
 				unsigned long page_limit,
 				unsigned long freelist_count)
@@ -2282,13 +2282,12 @@ static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 	start = fixup_red_left(s, slab_address(slab));
 
 	/* First entry is used as the base of the freelist */
-	cur = next_freelist_entry(s, slab, &pos, start, page_limit,
-				freelist_count);
+	cur = next_freelist_entry(s, &pos, start, page_limit, freelist_count);
 	cur = setup_object(s, cur);
 	slab->freelist = cur;
 
 	for (idx = 1; idx < slab->objects; idx++) {
-		next = next_freelist_entry(s, slab, &pos, start, page_limit,
+		next = next_freelist_entry(s, &pos, start, page_limit,
 			freelist_count);
 		next = setup_object(s, next);
 		set_freepointer(s, cur, next);

-- 
b4 0.10.1

