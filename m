Return-Path: <linux-kernel+bounces-168172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AF88BB4AF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618911F24239
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666321591FE;
	Fri,  3 May 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X1end8vy"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D3158DDD
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767545; cv=none; b=gGQoXGEJS4JoQmw/pl2jQoT2PQMflX6dPyR2rbZ1XBSrvyzDt53hlmEjc6gizXmXYGyvgI46GKc7JyCHyD1++l4931Qyj+4JZ4LTypVS0m6mJyObeDyLLaAs/VsfuWZQSIxUjr6z7VYb17XTBD/v/rADKZaiDp738kXZdp5G4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767545; c=relaxed/simple;
	bh=XtB/nDWzUuaQoEE1nrXkXmCUm/q+5PZbjs610J6ZoqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXTl0WQmnaRf5mbwO6Fu8zGU3gIKJwbxAocMHlQV5JD1tpAPN1bHvtBUgG9PKlCoQoMXrtXMlYRMwxJZL00/gE7ivjnke/AUGdKp3WY9+V6iofxqywIAZVcD7GUBfblFQMMd/AZu3aAux/EWI8QiQ9Az8+h7ZuOCrw6U+xgcX9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X1end8vy; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714767541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JKqNrvuJLggmC5OqLYhfJONRoO6KabgmLRg6AT9RabI=;
	b=X1end8vyjH2Cs73oRfF/yOz2ktz9sYpRUK+x7oNmu2tq+bQa5lHERJlUtM+73U0qTOPPQQ
	XR1pNar1KYBNoITZqDD/VMIadCuC4OyQICElDvVWtwAuiURpnwquWqqn92U0dnHluQAlY1
	iWtVPbQRcVBtpscG6yFZ5mu3j9czsxs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Frank van der Linden <fvdl@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v1 4/4] mm: page_counters: initialize usage using ATOMIC_LONG_INIT() macro
Date: Fri,  3 May 2024 13:18:35 -0700
Message-ID: <20240503201835.2969707-5-roman.gushchin@linux.dev>
In-Reply-To: <20240503201835.2969707-1-roman.gushchin@linux.dev>
References: <20240503201835.2969707-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a page_counter structure is initialized, there is no need to
use an atomic set operation to initialize usage counters because at
this point the structure is not visible to anybody else.
ATOMIC_LONG_INIT() is what should be used in such cases.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/page_counter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 5d963f54fcb8..af636dd943a7 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -86,7 +86,7 @@ static inline void page_counter_init(struct page_counter *counter,
 	int i;
 
 	for (i = 0; i < __MCT_NR_ITEMS; i++) {
-		atomic_long_set(&counter->usage[i], 0);
+		counter->usage[i] = (atomic_long_t)ATOMIC_LONG_INIT(0);
 		counter->max[i] = PAGE_COUNTER_MAX;
 	}
 
-- 
2.43.2


