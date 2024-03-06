Return-Path: <linux-kernel+bounces-93317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD4872DF9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C8F1F27C78
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2171BDD8;
	Wed,  6 Mar 2024 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="IF0MrRqK"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D326917741
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698590; cv=none; b=WqgCjEEGags4Dx8lwz41SyVonvql3fc6E31N9OA/8BvN5nhwBpvYDl4hPZJ4567wHR+6FVWg2j0IgI0AwcMdV3OTWMAkAQ60bTpxq6nW2cy19g5PnQlb26rt6D9EDfwe2fjKdpTNjA9Hc/H3jcsZWAKyhm+WDaW36uBn83PJbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698590; c=relaxed/simple;
	bh=Yes5UknlbLN/6DYfWRCz3bEUlIeSxsjUakMq52Da738=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mo/rA8njYqjaiWo2hfk6VVZNBo+FKtuEo/lyRImtrvs46hJ2WXSPXmUTmtTjL8DGR4jOj0VGQ+4RK5FX+ymVFN7Yz+W9IPsxh3UiHJMXukmM96BiQ97vzTkb6TQkTvmmtqGk9J0Cz71nDUrVUxV3uzWhRAH51/qxoYF0q0Ws2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=IF0MrRqK; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6904a5d71abso39671566d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698586; x=1710303386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHzhRKVaAXnUD3rwBUEd7H3L3SS0VEeXzGBInhtmHvo=;
        b=IF0MrRqKmpwCS2S9Y4WjrmrGpKJ3h3vxtbc3lO07OPVyBCblfyqTNYuDfGZN2B7+Dg
         3zb9ss/tOZrt2bDvOhQ0iUYfCiIEaMw7mSfcaII/YpKMte3/BoMJHA+m508Nf808ji9s
         XE+9/0NxSUpqnv2ClAtQ8gi9iaQbIrf377ey0vfyprrT3kIBg1K80pr+60cfqZ91vCk5
         MLNABOwfeQugc2T9oae6P+n8E+RNE6OwTuxfXNvkFo+FEu7nnSYsSTxwyTBRmtWrBPiZ
         YOQiYFiMoCLbqD/ZifQA4BQfs06Okso3Ifq8U/BQKK10FbEypHh+2mLXQDWtgxO/ISn/
         bihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698586; x=1710303386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHzhRKVaAXnUD3rwBUEd7H3L3SS0VEeXzGBInhtmHvo=;
        b=pss+w38Hb+hHe1YobfkeGIFlLUvW9JsL+E6e06MbOg/MOeWzFOB4v/uNh4UA1vfOb7
         9Ybu4368WEbDADU15/mM4yfjNJoE/XBpQtwS/c7Z5qiLzcJkflCJx+zjvUBdBxj09Tcs
         ob7xGHSinjvA0EKEoAMAOzKrV5j3fQGBLas7a1IX3Cpd1X9yer5HMnFWaJBTITEXZSiG
         RVB4iU8KTzYoDtujgKuQ4JMkzPVsjZQ+RVOyw1NTrc1Mn2Fe4rRPDVzxMC5TvFG5vBB7
         nox46NmTa1TpUwXgNX8icYOIuk9l9rRc8Y/1dfCkpSEPgePZ7PNFosF8ZiQD76S7xpNe
         aNpg==
X-Forwarded-Encrypted: i=1; AJvYcCUOjdKko5faU62nyoZYUfl5EYeLflt3pd5XJa8XguvESPT4He2oIAuK2si52U4kv4plFMW59/OGIj+BAwYyi7JoGZLlQ3fnvoEjR+kX
X-Gm-Message-State: AOJu0YwT/CF6lPj1zPwujWh1m6kKkEP2dDr4z9NXio4dEw6IZuKDlROf
	wDb18gyyQLTo9rPo9I/qMkpUBzTEhIgQGrecZ563cy3WavzMlUgI8ZWHNp18wYI=
X-Google-Smtp-Source: AGHT+IH8smcjvgVjtxikEQ23VUlaKW5EeZbBSaDCdCJJHUd5ddTW2ftWOlTEg3i010CDIhz/uidLPA==
X-Received: by 2002:a0c:e9c4:0:b0:690:8aee:60ee with SMTP id q4-20020a0ce9c4000000b006908aee60eemr790372qvo.46.1709698586714;
        Tue, 05 Mar 2024 20:16:26 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ph7-20020a0562144a4700b0068f985ceb11sm6973369qvb.70.2024.03.05.20.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:26 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] mm: page_alloc: fix move_freepages_block() range error
Date: Tue,  5 Mar 2024 23:08:36 -0500
Message-ID: <20240306041526.892167-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a block is partially outside the zone of the cursor page, the
function cuts the range to the pivot page instead of the zone
start. This can leave large parts of the block behind, which
encourages incompatible page mixing down the line (ask for one type,
get another), and thus long-term fragmentation.

This triggers reliably on the first block in the DMA zone, whose
start_pfn is 1. The block is stolen, but everything before the pivot
page (which was often hundreds of pages) is left on the old list.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0f385531e130..787ae3f0ac06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1645,9 +1645,15 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	start_pfn = pageblock_start_pfn(pfn);
 	end_pfn = pageblock_end_pfn(pfn) - 1;
 
-	/* Do not cross zone boundaries */
+	/*
+	 * The caller only has the lock for @zone, don't touch ranges
+	 * that straddle into other zones. While we could move part of
+	 * the range that's inside the zone, this call is usually
+	 * accompanied by other operations such as migratetype updates
+	 * which also should be locked.
+	 */
 	if (!zone_spans_pfn(zone, start_pfn))
-		start_pfn = pfn;
+		return 0;
 	if (!zone_spans_pfn(zone, end_pfn))
 		return 0;
 
-- 
2.44.0


