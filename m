Return-Path: <linux-kernel+bounces-163390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E092E8B6A30
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0628F1C20D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313837719;
	Tue, 30 Apr 2024 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EfBe/UdG"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321E72C853
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457200; cv=none; b=YP1yQ/u6OoDfEt6GuSPKoe+i7fPwyBnhhClvmbKjrFTxHaP+wZL5hUBZwNpgv3wMAUo3aYQhPm92C5wEqQ0fgFXg3hSN5qIyZgti/JnOOvdsB5gJ6roFTGswidhxiLesRNfgIvdzlLKgDGQ0A8//iT1qH7tPzCbNqfyv9QVFSYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457200; c=relaxed/simple;
	bh=/iEtJbezM6wgT7YXBmc8I+XITwFptD75NotZe/FLwtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPd+axcRkbZPW8kmCz+u05UGKqihnpnlWVUtcft7DHwMKGb2L7kaFZ8dVK/5FhLssfaKQt8ElJakN89owWMKsKT/AvUp/YjCrPCMm+3vKugEV9b7zMgSMo7HYYumKeTXm7rKmQ9zcv03pe5xohhIjQQst54nUZ3L76jbkgWd49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EfBe/UdG; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714457197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPVK+LGjMG4ohSIE1zDoj8EpOU3OQH41GwgZeY5ZUQE=;
	b=EfBe/UdGoVlt2JhWhQf0xF720ZRjNkbnEaL968MBYRXAEfDgAk6LqFh+Rm50VUpYIDY/cs
	lTYQ4CduLYDHFatXqJEXF81zWjZVFefdLKzR+Vz4EU5vqzA/O01NyIDzRvas+cBk/Dt79Q
	tgleknm1AKtzrboCI0KYvo7eigvehRc=
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
Subject: [PATCH v3 5/8] memcg: cleanup __mod_memcg_lruvec_state
Date: Mon, 29 Apr 2024 23:06:09 -0700
Message-ID: <20240430060612.2171650-6-shakeel.butt@linux.dev>
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

There are no memcg specific stats for NR_SHMEM_PMDMAPPED and
NR_FILE_PMDMAPPED. Let's remove them.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
Changes since v2:
- N/A

 mm/memcontrol.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f424c5b2ba9b..df94abc0088f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1008,8 +1008,6 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
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


