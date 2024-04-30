Return-Path: <linux-kernel+bounces-163386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363E8B6A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31EB281CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051EF182BD;
	Tue, 30 Apr 2024 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWysJ5rJ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16CD1798C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457188; cv=none; b=OtByzQGaPfngq7/eY/6rPf8t/bjTy83V2X7V+ByAxBcstBPyEYyu6rhrTPwAPZjCysxptQ9eNMWHbPQTSOo3N+JyqF5KGoYaNRmF/+pClLL2+pLS58RS2Rma8KPwCBx1aQ6+toh/BIZotrGYq5wEVlGw/RAAiKGi/hZkq+YcMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457188; c=relaxed/simple;
	bh=3dy6hl1zCDi+m0I7sZGZ37h4N9d3LYVwPdHpe6OAbjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWmrSydrcoONk1nHVZXgxL29sFeM423M46ZLsPdlnBD6Jq5QsaotwvrRerwUAQI9geAmPw2KyUW9QfK6b0SHkpzHanURpTCrOmuK0V3BqmkALgT9Srvi8OweSTEpBTyvSgJTSIAfZomaI2xEYEWzPvn29sG9ntYmXly9wLBnRN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWysJ5rJ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wvw793twJ1F4/KqGjGhIdLueYM54shZE8VvQWV77fqg=;
	b=gWysJ5rJLgTNd7+7sPEXX3lDa/aX41N7fiFaoVJoqBw2GLQoTmpvYSXD+j56elG71KufDu
	5H3chniFPjB0Kb5+t8HX4JvT1HtVlVG8HX9EX65NGXLDJ1eBuARlgTh71roMJCtj96Mtw2
	+qgkfyNgcm3UlGBUDOM5HOeHYGXdz14=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosryahmed@google.com>,
	"T . J . Mercier" <tjmercier@google.com>
Cc: kernel-team@meta.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/8] memcg: reduce memory size of mem_cgroup_events_index
Date: Mon, 29 Apr 2024 23:06:05 -0700
Message-ID: <20240430060612.2171650-2-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-1-shakeel.butt@linux.dev>
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

mem_cgroup_events_index is a translation table to get the right index of
the memcg relevant entry for the general vm_event_item. At the moment,
it is defined as integer array. However on a typical system the max
entry of vm_event_item (NR_VM_EVENT_ITEMS) is 113, so we don't need to
use int as storage type of the array. For now just use int8_t as type
and add a BUILD_BUG_ON() and will switch to short once NR_VM_EVENT_ITEMS
touches 127.

Another benefit of this change is that the translation table fits in 2
cachelines while previously it would require 8 cachelines (assuming 64
bytes cachesline).

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
Changes since v2:
- Used S8_MAX instead of 127
- Update commit message based on Yosry's feedback.

 mm/memcontrol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 602ad5faad4d..c146187cda9c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -607,11 +607,13 @@ static const unsigned int memcg_vm_event_stat[] = {
 };
 
 #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+static int8_t mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
 
 static void init_memcg_events(void)
 {
-	int i;
+	int8_t i;
+
+	BUILD_BUG_ON(NR_VM_EVENT_ITEMS >= S8_MAX);
 
 	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
 		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-- 
2.43.0


