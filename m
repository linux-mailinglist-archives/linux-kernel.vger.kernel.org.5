Return-Path: <linux-kernel+bounces-35005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F363F838A69
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77BE1B24BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C385C8E1;
	Tue, 23 Jan 2024 09:34:02 +0000 (UTC)
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8A5C60B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002441; cv=none; b=soAlfNT7Xebd5hEzed/LB9AAXZigBbU/TW3svVkn8uv+Ry6oWxRBniEywPpGY4aaeUdr0XFS6DzJOPeBDIKFK2szQiq0YkVGrs1+om8iMEmFs7h9OlHmHqsce2A3moaEjDMozismDM5dygx7Rg0cKJqu7qNZfIieCtYNGK3m4+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002441; c=relaxed/simple;
	bh=ZXzd5ZM1kPfc29nku387qFGBNfMPhmyqnVdI70QYk5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xb7lwhhICTDvoxEZF38oWVYN/kcZ2Hwcssl7DOb0VyNKjuoSpBe47Y4bboapkHCJ1yrhbjzWfxBCyc19FK4yCcCnu15sGqtSZiEU1RWgh+lSPx40dl3S4cO2oeVN7nsjUKQ62bMQeFutGg6GRX/O8jbMu8Cqek1Je5UDd7Y0ssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Tue, 23 Jan 2024 09:33:31 +0000
Subject: [PATCH v2 3/3] mm/slub: remove unused parameter in next_freelist_entry()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v2-3-81766907896e@bytedance.com>
References: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
In-Reply-To: <20240117-slab-misc-v2-0-81766907896e@bytedance.com>
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>,
 linux-mm@kvack.org, "Christoph Lameter (Ampere)" <cl@linux.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706002427; l=1540;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=ZXzd5ZM1kPfc29nku387qFGBNfMPhmyqnVdI70QYk5o=;
 b=eO3C/qpMGEax+MfzVtLNHcbDe+c64BixN/5g6zrbrjsUMaxGOraPVsgUT0dI0grRB+ucrDO2l
 j/WoJtVo5iuD79mh2KmwA9Hx/yNMXxarI/hcbm5mwl8odmEhDnXWi2x
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The parameter "struct slab *slab" is unused in next_freelist_entry(),
so just remove it.

Acked-by: Christoph Lameter (Ampere) <cl@linux.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5c6fbeef05a8..7f235fa6592d 100644
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

