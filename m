Return-Path: <linux-kernel+bounces-60797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93018850987
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11491C21C77
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A4C5B5B8;
	Sun, 11 Feb 2024 13:58:03 +0000 (UTC)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF815B5BD
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659882; cv=none; b=DVZ/ZP1E0ZVCB+dYPli4SUw7gnWBm0nqIfZxztop6faEMWXemxsZRvF90HOIlrS6hsFzUnkR/7JcRUYpls63Qs49+cKhdxGQYSbXA6lC3UKWqju4Yx3vNf3v23fXHBJAHQmVHnYlPgExFze5Zv6aNn04DtSQghZMhYOH7LLHOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659882; c=relaxed/simple;
	bh=C61Ihuiu9RIrS4rWHh8mKqFaaxXqp7i14scDWhAWiu4=;
	h=Subject:MIME-Version:Content-Type:From:Date:Message-Id:To:Cc; b=mnwOuzCK1usQUzGJedBEUxL08Igtyt9ipZNrh7/nqj9lzWcYMXWTPodHsIT9OvGZU5y3CrqsBrnqXwjp542UrGzkSGHHiiiCSdfo8j8vX+cFV2hXVS7C8wnSzRcjn/A7tnHh9cew/OItS0mr91EwtkoIu0JuTNP7a9aWPVLeUrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Subject: [PATCH 0/2] mm/zswap: optimize for dynamic zswap_pools
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAC/SyGUC/w3LSwqAIBAA0KvErBtQk363GWsoYbBwqCDp7rl8i1dAOUdWmJsCme+o8UgVtm1g2S
 ltjHGtBmecN84afPWhEzc5AglKvnDyq58629thDFBbIGUMmdKy15guke/7AQQSc7dnAAAA
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <zhouchengming@bytedance.com>
Date: Sun, 11 Feb 2024 13:57:03 +0000
Message-Id: <20240210-zswap-global-lru-v1-0-853473d7b0da@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Nhat Pham <nphamcs@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
X-Migadu-Flow: FLOW_OUT

Dynamic pool creation has been supported for a long time, which maybe
not used so much in practice. But with the per-memcg lru merged, the
current structure of zswap_pool's lru and shrinker become less optimal.

In the current structure, each zswap_pool has its own lru, shrinker and
shrink_work, but only the latest zswap_pool will be the current used.

1. When memory has pressure, all shrinkers of zswap_pools will try to
   shrink its lru list, there is no order between them.

2. When zswap limit hit, only the last zswap_pool's shrink_work will
   try to shrink its own lru, which is inefficient.

A more natural way is to have a global zswap lru shared between all
zswap_pools, and so is the shrinker. The code becomes much simpler too.

Another optimization is changing zswap_pool kref to percpu_ref, which
will be taken reference by every zswap entry. So the scalability is
better.

Testing kernel build in tmpfs with memory.max=2GB (zswap shrinker and
writeback enabled with one 50GB swapfile).

        mm-unstable  zswap-global-lru
real    63.20        63.12
user    1061.75      1062.95
sys     268.74       264.44

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
Chengming Zhou (2):
      mm/zswap: global lru and shrinker shared by all zswap_pools
      mm/zswap: change zswap_pool kref to percpu_ref

 mm/zswap.c | 183 +++++++++++++++++++++++++------------------------------------
 1 file changed, 76 insertions(+), 107 deletions(-)
---
base-commit: 191d97734e41a5c9f90a2f6636fdd335ae1d435d
change-id: 20240210-zswap-global-lru-94d49316178b

Best regards,
-- 
Chengming Zhou <zhouchengming@bytedance.com>

