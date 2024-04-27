Return-Path: <linux-kernel+bounces-160823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F338B434C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8953C1F22E36
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A333BBF5;
	Sat, 27 Apr 2024 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b6gjrMhu"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16563B1AE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714178276; cv=none; b=fGf80MKbDTaul14YHiMUQB+/LurTIQt7F6b6UdBXKTIBClmocJKZTjtnF9brBLa6k4uJLBlYLuQ9czsOPqGK16m4dBICO9rIaD3AnRvQ8ioeha47CZeh/QJovFNVIXyWga30s+VN+zJcE4W5KejbursOMGYVFbMiHly1gVjijRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714178276; c=relaxed/simple;
	bh=2c11/UNucjhYuvQsF9rHuh1tnmfsKj/luR52vgQMaxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIz4cRaZLwOhR0LWmmCmY6lrB2cgGi60MKMaEft0UDVOHwrE1aO8vjKnCMPBdmhRKrXKPyI/gSurV/aIxth5hFWVr7zrvTRyb6IiFx88pQ7lImlZChObpWc+UB4h9SK+IhCMn3nHuPA2qW4cTtwLdGWNKB7j5G+rDaQT+WsrQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b6gjrMhu; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714178273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=StJiZmI3BplMAQI82xrhJ2SVU48fOC0iWz8HtDgUnJo=;
	b=b6gjrMhuur3+QzQZZhAjDMsktwDbCY5i5Y/S3EnI6cT4PrqrIopqb7fjdGAwV1+f85fJkj
	oXiUuqCSxo3ONQADEVCNbYBnGKPDW1uurVXpqggrM7xrGlwYB8WMKdS6/0/lRWwBF5Hmo5
	wt+amLltg08cTAW21mxIRKMXJMRUjFc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] memcg: cleanup __mod_memcg_lruvec_state
Date: Fri, 26 Apr 2024 17:37:30 -0700
Message-ID: <20240427003733.3898961-5-shakeel.butt@linux.dev>
In-Reply-To: <20240427003733.3898961-1-shakeel.butt@linux.dev>
References: <20240427003733.3898961-1-shakeel.butt@linux.dev>
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
---
 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c164bc9b8ed6..103e0e53e20a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1009,8 +1009,6 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
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


