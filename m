Return-Path: <linux-kernel+bounces-28924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F648304B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F296B24B64
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555931DFF4;
	Wed, 17 Jan 2024 11:46:36 +0000 (UTC)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AF41DFE2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705491995; cv=none; b=didOk11mZAsM9T82CALuJE3zBhIzXiwcK3f6chsL5W9UdaBk6KfHxWqzeeIv2ByC3hFNIHUUWKYk0sGIezLeiyRRNuNMPCWXA1IRDAN4fuC0Qnx+uvdwA8tGSvMiVwOxCyK6BQM+aOidxRUrP0SwALYtSqNoZ2atjD+ph4SRMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705491995; c=relaxed/simple;
	bh=1cV2tT3H0/m/Zwl/1edZJTWNsxvFuwH6aWvUH2ceDxA=;
	h=X-Report-Abuse:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-Migadu-Flow; b=H+LcoAritebrwHgDouzMybxhsP5Ts3iUmfw4DbyJ1Skv5XRKe7HyH9O7i0fKWOssty1c207B0uu/OALNQrVP3sSApIers+cTDChXmhtpgv2sszPhBHAllF5pCIBgTIQhC58M4UpbRAPiY1yZe4BHeVqbsLHQiMDDaZhAMw572T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Wed, 17 Jan 2024 11:45:58 +0000
Subject: [PATCH 1/3] mm/slub: directly load freelist from cpu partial slab in the
 likely case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240117-slab-misc-v1-1-fd1c49ccbe70@bytedance.com>
References: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
In-Reply-To: <20240117-slab-misc-v1-0-fd1c49ccbe70@bytedance.com>
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, Vlastimil Babka <vbabka@suse.cz>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, David Rientjes <rientjes@google.com>
Cc: linux-mm@kvack.org, Chengming Zhou <zhouchengming@bytedance.com>, linux-kernel@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705491984; l=1967;
 i=zhouchengming@bytedance.com; s=20231204; h=from:subject:message-id;
 bh=1cV2tT3H0/m/Zwl/1edZJTWNsxvFuwH6aWvUH2ceDxA=;
 b=lspzQdoDP02OxesbrkhjrNtCmxWtOMg+h1t6s9v2piAwijqH3Tc7Q1b13y4pdQjtZJBFFuN85
 MSi/7Nl/He4A7iY8555VHvt+jjR22vlwQ2KgFZAuvEDcaZ+skfH0ZEc
X-Developer-Key: i=zhouchengming@bytedance.com; a=ed25519;
 pk=xFTmRtMG3vELGJBUiml7OYNdM393WOMv0iWWeQEVVdA=
X-Migadu-Flow: FLOW_OUT

The likely case is that we get a usable slab from the cpu partial list,
we can directly load freelist from it and return back, instead of going
the other way that need more work, like reenable interrupt and recheck.

But we need to remove the "VM_BUG_ON(!new.frozen)" in get_freelist()
for reusing it, since cpu partial slab is not frozen. It seems
acceptable since it's only for debug purpose.

There is some small performance improvement too, which shows by:
perf bench sched messaging -g 5 -t -l 100000

            mm-stable   slub-optimize
Total time      7.473    7.209

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..20c03555c97b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3326,7 +3326,6 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 		counters = slab->counters;
 
 		new.counters = counters;
-		VM_BUG_ON(!new.frozen);
 
 		new.inuse = slab->objects;
 		new.frozen = freelist != NULL;
@@ -3498,18 +3497,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 		slab = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, slab);
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-		stat(s, CPU_PARTIAL_ALLOC);
 
-		if (unlikely(!node_match(slab, node) ||
-			     !pfmemalloc_match(slab, gfpflags))) {
-			slab->next = NULL;
-			__put_partials(s, slab);
-			continue;
+		if (likely(node_match(slab, node) &&
+			   pfmemalloc_match(slab, gfpflags))) {
+			c->slab = slab;
+			freelist = get_freelist(s, slab);
+			stat(s, CPU_PARTIAL_ALLOC);
+			goto load_freelist;
 		}
 
-		freelist = freeze_slab(s, slab);
-		goto retry_load_slab;
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+
+		slab->next = NULL;
+		__put_partials(s, slab);
 	}
 #endif
 

-- 
b4 0.10.1

