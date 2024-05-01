Return-Path: <linux-kernel+bounces-165647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD248B8F05
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1771B283644
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51EA12F399;
	Wed,  1 May 2024 17:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RYJMprjH"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1441BC41
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 17:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714584406; cv=none; b=I1s8ELj8gHrUFlwudN+w+90mC+nAPqwHeNXKTeWFma6i2bhDItj94Fu7PpUx/p0q93fj3WLBmcekee0VY8PWVNiI9DXQMrvc+Fj94tTzc9z/X1ysSX0+eb0bCM54mkg9tW7cBaFzlY2SnkffQVxQU67QRUTn5Nu86EEuV0fjqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714584406; c=relaxed/simple;
	bh=40GkjnETTSjxFn3c6A9q49jQkrsJd/kPMzZVbSANdRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nppm46FBmrLZnWukmGim6ypbl+qsDItnrJAWiBCnfx9Ej7sMBHs487Ifu/nc5QiKu2vEXnHpD6krvG47m1LGLJK8OkemK3qup1gZoDZiVjIiIJZn0xxgcgn2qaXdpSQAtnW96Tc22FEX8zgv+fpkpGnBDnjfMObLH8XrFQta4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RYJMprjH; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714584402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ememgP1JocqN9S+WLAK1U+7C9ihTSU1uk5FHGEEDYr4=;
	b=RYJMprjHMDS8e79Oq3QGMPyZEM9cde+P1t4xIvdp2lQdMigU28nY2+mJ+fRYkJXbRFOr7Z
	qX8L+scG0lHGdqMKsjfVCgN7bbJJe3LmLnlAZ+XUaTSy9gzBjchqIpCV85Os45LMjdQMMP
	ARQLfXyvt3IftYfCXIXe7crcs2JLri4=
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
Subject: [PATCH v4 5/8] memcg: cleanup __mod_memcg_lruvec_state
Date: Wed,  1 May 2024 10:26:14 -0700
Message-ID: <20240501172617.678560-6-shakeel.butt@linux.dev>
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

There are no memcg specific stats for NR_SHMEM_PMDMAPPED and
NR_FILE_PMDMAPPED. Let's remove them.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
---
Changes since v3:
- N/A

 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f3b6be5a0605..a78cf00dd537 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1010,8 +1010,6 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 		case NR_ANON_MAPPED:
 		case NR_FILE_MAPPED:
 		case NR_ANON_THPS:
-		case NR_SHMEM_PMDMAPPED:
-		case NR_FILE_PMDMAPPED:
 			if (WARN_ON_ONCE(!in_task()))
 				pr_warn("stat item index: %d\n", idx);
 			break;
-- 
2.43.0


