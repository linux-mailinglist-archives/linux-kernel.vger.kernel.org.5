Return-Path: <linux-kernel+bounces-109279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE6C88171B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A0B281D28
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6866FBB8;
	Wed, 20 Mar 2024 18:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="0FiX7UpB"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FCF6D1B1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957901; cv=none; b=d4tHazp4NWx5uk/Fkg/8SEvcjb6KYzXMOC8bvnhT6+oy/WUJoyW3m3qyls7jAB9BEVXDCINaDLZKEjPx+V765yDI9sGd/LakbCSUeycz27VumjF8hRWQ+3UzFBekUWdog+TilsEe1ZE3tvl8HhJrkob46gRd6a/ltAeg57x0j0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957901; c=relaxed/simple;
	bh=Z2U10/vWhIghq22kfHOAbIVeHMv6h9reaBt/wrTvDW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA4V2pIo5AoJB7+ZcZVGe9fFZeqCrB/8/jwgNdJE+e/e9PSs9gzzZQpfThnRx7TfU75JQydXotFBeBXilicgObX5e01iUEWJT0Kfx5zMJoZ1JVTDwNmIbCB8hYJ+BGXqBLIj/+BBRC+rwoVvdLIoRIQNTcx27E5diqP+NGl906Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=0FiX7UpB; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787edfea5adso6690285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957898; x=1711562698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZwAKBxwvX8Cu8VK/08SCQc15oSmFIOnYtXDnl3jEr8=;
        b=0FiX7UpBhkaSmEricriXKR7Z4+Gb7vGu6VZEjfdI7u9QLLCf83p7Xne9ZguZLRsFZH
         ONvuPhI1byFd5C6B1ydO5ezdHFHkCmBbE4xcl8loZ4UDQV2/0bMJ3FiO7anvy12fztA8
         seNh6KQaNUovPL48tQMIddE7vPeKswBmdPY120KjVvUdaxEqOjDceKVvO+Q08MPgMvlG
         tIr8vjBZEJpg3xUM4ptw5KvIPD/PWhhb2TE47YeYjn3GDKYvbMHyUAslCwjG3E7gP+kC
         RWgs3ECbQSrfZXZpCVvwvH/mJAiaWWHeWnl7rtyl5mBgmxY/JRH4fgwPPNrow7JXfctw
         cMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957898; x=1711562698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZwAKBxwvX8Cu8VK/08SCQc15oSmFIOnYtXDnl3jEr8=;
        b=NWtkHxeURwEh8bKDyFQNIsI8c2cClTwdi/BmR6VE3IBJ/vBxfIofhQPUohj610XfgD
         3Hwc2o7vVujAvBKbhUvb0IWg2ASnBpW9M7E9dLRiu/GkVAxJWUIfW5h7M3k1+MP5TahA
         5JcMZCZMDxRqp3A6KVjmnElGTuT8aRKqNfsFL/vlI66ooMpdVtDhRJcH7kLJ+ogpwsYN
         /bOy4wiD/boJpM96AYFvg8afwAWIpPCeD525hTdUaXbPUEFQaAlDMUaMSmk95fjKFgDo
         GVfpVzwOH86ssOOTY45WA8PuSEl+XUXADAskXlgpwqgNaq8r6IVOFlTcueropKsopLlU
         zYkg==
X-Forwarded-Encrypted: i=1; AJvYcCWBid+lpXKFueNDzbcPcULA3rXBdpBsDR8bpX5Yc/UoIUeJ5CUl8p2Cd1iT2yH8jGKzgvnBHpjxH7LVGKSjGQJU4UZ7tabfzh633iQw
X-Gm-Message-State: AOJu0YyCSJkWvuOdvQ/gU9qxFKNTgbHcQNHE05MQiOUNIuO0P1oG12B3
	0ZI4MKtJbUKSzMDZGsEHnU8NeaGYYRRzuZ+KFdm6YUQpRWsJEWoDF03mT4hAvRc=
X-Google-Smtp-Source: AGHT+IHMMH7iyyjW9zOuIWSxf38EdGRhEKTJ2fArhuWu3NYukGvTXw1ChW+Vsv6SLoiTkEyfuwoNTQ==
X-Received: by 2002:a05:620a:821b:b0:78a:47e:282d with SMTP id ow27-20020a05620a821b00b0078a047e282dmr8998670qkn.56.1710957898421;
        Wed, 20 Mar 2024 11:04:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id y1-20020ae9f401000000b00789ed16d039sm4402405qkl.54.2024.03.20.11.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:57 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] mm: page_alloc: fix move_freepages_block() range error
Date: Wed, 20 Mar 2024 14:02:10 -0400
Message-ID: <20240320180429.678181-6-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
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
index a1376a6fe7e4..7373329763e6 100644
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


