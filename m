Return-Path: <linux-kernel+bounces-93316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 771C9872DF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D0A282AAE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DBA1BC56;
	Wed,  6 Mar 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="osC0Pz2d"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0611B7F4
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698589; cv=none; b=o2vddB81f9kAdvxTbvQPblaVFDeqwu65S2m5dgS2ByfoRJOYNjGGHjdLFevShWY5j3cStF4KyYTUvZpSr/dp5b5yFkMfU9JhzKlcmqsoTTcoaAPLdK0ufWW2hqIJyUA1UKdW8fhJeelnRJW7RpwArRRLH5aVQRzCNzL3qDEeT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698589; c=relaxed/simple;
	bh=+JHXx6ynyL2ZO6AiZlsNsjrA8WaiDujGEqbRHEUnIHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqHobAh1XYldc7ifgrhE9kkpaoJ2UXCZUQ9clhcmO5/ivH+Q7pV3lAA3vZnmpKYC+DXp9/I+Wzb/7PtOo/HhtXVFzfhbf07mKz1vOALa9lCM7NGsQlAoErMopD9LJSId2j+IsF9GTrFQ9jsPehYzW97dYVWPqL8bDTumVprlHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=osC0Pz2d; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-781753f52afso447909485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698585; x=1710303385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMSYidS0AoPvbN6qA3im2YqpbK/tNkyrqR1A6eq5TWE=;
        b=osC0Pz2d5m9LFN+AfLgInEe6IN6RVaOvP1iZhP0UIDwEXGTpSeXmk8UJo5bvO0b+Vc
         SFAOoIcj1x503U6BKwjBo8tGNpHLHX6hiFmQ18NylIT7hhd4881ryVMgtQyBGz3m8Ll5
         QEIQwWNlKQuakOfdInnOjlh5XKYuGWSe4pTyeSaSWBC5VfRH7A+FqgoAzdqcxK0b/O4J
         mc0ocauJNjq6MERG4wzORuZdUGNybXYSstw5fVrPmRZnaulYXBgIN2tWfKTr0niSdT/m
         VsCMzliQSe4h62P6xULpHvl+Czu7uaM8fD6kNyNm+cqyoop/wbKe5v2y7YGf9Ubh0ak8
         J4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698585; x=1710303385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMSYidS0AoPvbN6qA3im2YqpbK/tNkyrqR1A6eq5TWE=;
        b=ZyNlu0nuGewq9WdC7BSc4m1noHrUaknPch0e9oN45q8oK/OqunmBjz03WFyipCgLvE
         e1C/RNCqto9mUb+Z33F1S5lmeN5b8vTmZagHZdOQ1v7eXdjxLwYVZGvdX0RSkk5dmMJT
         UUNiVMyBPLSt000fURZ2Kz4LrQU9DrEOEaEvfTrwfBqNoPeEAPBrQR4aI45DolqBpQR3
         SpVwVDipHWFQasrSKaiS0hPK4U5x5BysUhScECRz2OLKp0gJ5xtfU3mwymAtFO+OA3kc
         ZQdWg2Dmr63S8ddlNwcp5lpbzyzlajjqF93NTU87BHVJ3q32V6Ng02//7AH9RavdHta0
         AxeA==
X-Forwarded-Encrypted: i=1; AJvYcCVU0yFG8aL76BUPa2WGpYF5WGWrGQEonsBAbgKJL3GKgZv1/r3BQ2/UC0zHYVEeHgLIpqG1tSFoazuUuWYjXdif/7CJ0PqdCR+mWzyU
X-Gm-Message-State: AOJu0YxrYFPZljmWdxJnfJRb0s20CVLh8UHiJSvzrOikOnq2Rx2FI2O7
	PdJpi7G9Wmtl9zk5wOv+3YfKWngDilP43Fa0xfy8KCqj8adgVXd6BgHEAttTKk8=
X-Google-Smtp-Source: AGHT+IG6XvS6MFHFJ6jCjiu2kUNS7WFyQEOYG64hXNNhRZh6uxR9igo5+MITru6+zIGSD4f9tY7ZWQ==
X-Received: by 2002:a05:620a:389b:b0:788:1f51:5822 with SMTP id qp27-20020a05620a389b00b007881f515822mr3895540qkn.40.1709698585227;
        Tue, 05 Mar 2024 20:16:25 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 19-20020a05620a04d300b0078838c7acbfsm984096qks.42.2024.03.05.20.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:24 -0800 (PST)
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
Subject: [PATCH 04/10] mm: page_alloc: move free pages when converting block during isolation
Date: Tue,  5 Mar 2024 23:08:35 -0500
Message-ID: <20240306041526.892167-5-hannes@cmpxchg.org>
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

When claiming a block during compaction isolation, move any remaining
free pages to the correct freelists as well, instead of stranding them
on the wrong list. Otherwise, this encourages incompatible page mixing
down the line, and thus long-term fragmentation.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3f9ea4c392d5..0f385531e130 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2666,9 +2666,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
 			 * Only change normal pageblocks (i.e., they can merge
 			 * with others)
 			 */
-			if (migratetype_is_mergeable(mt))
+			if (migratetype_is_mergeable(mt)) {
 				set_pageblock_migratetype(page,
 							  MIGRATE_MOVABLE);
+				move_freepages_block(zone, page,
+						     MIGRATE_MOVABLE, NULL);
+			}
 		}
 	}
 
-- 
2.44.0


