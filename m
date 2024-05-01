Return-Path: <linux-kernel+bounces-165643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A998B8F00
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78061C20CCA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CB31BC41;
	Wed,  1 May 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tIfgRTnl"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E9C18C38
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584391; cv=none; b=ixMNpbxQajp7wzjSeikhaA3pKXmCubng7LEsIbBEO59VlNv4gw8upS4RUEzJv2PKlQIwYICfSShdGM2RfRs460MKwf7S+UjP4ylsKsBc+7c9Ty7VcD/AofmlpckjumIXv/CSL2ghyJ+8XqpWCTHWjtJJ/h2hywHl95mvjPuJDoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584391; c=relaxed/simple;
	bh=bpoSOwCps3ekmNK8friHUBN0NbKjjhHpo4dFg6sHcXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4/3QLn5OO/TEc7etRYmB8EGPrm3UNEw5Vmir9rDAoyOhmGAgef7FmnvSzaFEjoQ93xVaV2BQWadxOXsFi0BTw21dR1ZQrMeQyaNfDXlu4GNyVkFrUUppBMzw1xaJ2g0FExls4+47R7rqqP3kbsvxYluQ6/jLET6zi2z4XFfTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tIfgRTnl; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5S9dkOJqha+rpI1CHtwyB9wbo4t9Wc2EBy5O17ehws=;
	b=tIfgRTnl/mhCgo0S97RFAXjLL/WVu5BE3Xyfq+9Mm73A1FvvUmiRo1lxo7b4Xy3VsjEWSv
	x7EoZ6cGnTqWTDf9G9b6HpQZYMpFZEEwHjoreUm7T9cMzcP9nw8sl2uOSArKJ1uG3TCahI
	/Jtd6f/SoU72qn5FtRtSozJCOvm6c/w=
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
Subject: [PATCH v4 1/8] memcg: reduce memory size of mem_cgroup_events_index
Date: Wed,  1 May 2024 10:26:10 -0700
Message-ID: <20240501172617.678560-2-shakeel.butt@linux.dev>
In-Reply-To: <20240501172617.678560-1-shakeel.butt@linux.dev>
References: <20240501172617.678560-1-shakeel.butt@linux.dev>
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
and add a BUILD_BUG_ON().

Another benefit of this change is that the translation table fits in 2
cachelines while previously it would require 8 cachelines (assuming 64
bytes cacheline).

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v3:
- N/A

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


