Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F8479AEB3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbjIKVdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244262AbjIKTum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:42 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36541A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-4124e1909edso30842971cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461837; x=1695066637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XbiqGXh0AoO6pfd7jMLvMSWe/voOxpwIaHwDz3nXxMQ=;
        b=2s6JydhEOT3SkPjRmfQ/DLXTDVl5N94FfLH/DPQde0p4EB2ZlVQJSugLpcd7SvH1/G
         m4IWHh4etAHNqSrI6uMvdl/T++gFv7NZof+pFXoDpGUs2gL6UyCb2xbsir9S/mb7NHgv
         i2AL3o645ySyYeFoDNLpDamCk8mkXLySCkj7RqNhNHSnvZKvDBKSNDsPyhyUk78868fn
         0JgK3i5h3RMAgRcc8SkLfQvzVcLUAYzArZw9+YZA6bBKx0+k8ByvhQrWh1T3Cl7RysPn
         q50+sBgpQXWVhSgEi72hkhO3s7lWx6YaFM76hsydwwKx8PQOdwLCu4qY0s6GLy8PNKGK
         ewQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461837; x=1695066637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XbiqGXh0AoO6pfd7jMLvMSWe/voOxpwIaHwDz3nXxMQ=;
        b=C8QfHYR/WjnEUUUFPs4Hu8Ujv4U8jJYyRhKUEAtSJINout+vWvvO7NyhvWT1OtG1Nz
         AL/rQG9PL1eTho0mzzuEUWxWEo8vWachRWIooH0pjRJ9DkVf45GH0/kYIAM7kd9Cw/X9
         1DHIEvL9/6qp6ALGDTNp3Qm/lTaDJoVtuU8wUmHf+QE8G4tQWIYbckHEPbPrKdDxlXmh
         Q0yCR7ppz6GelIGEpkfWR1TdaDRzdIU8ipXHc7ppj6sEWVL2lMoRfgLzvJ7UEnUAfftp
         PM9dOz3L4ZDBJMBSMkhsx/RromEZYzKgVuOOzKdq77juys3guo4EvUct9gwrHlxTtIFO
         Yqug==
X-Gm-Message-State: AOJu0YzvqqPr9/zibdH3ViJqnFurCtTUQoFuUEZWgrhJWPIA0zqScfCq
        TPH8h/nA7nh/ROoeZDCTd+GU/g==
X-Google-Smtp-Source: AGHT+IGUAHLS2HPzXYDw7iJOOB1AIzY0p9GHTHFFHLSgWhRs7EOMIgK8ZOejhK0Em8gshplLrGFwBA==
X-Received: by 2002:ac8:5986:0:b0:40d:4c6:bcdb with SMTP id e6-20020ac85986000000b0040d04c6bcdbmr13002837qte.5.1694461836984;
        Mon, 11 Sep 2023 12:50:36 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id z17-20020ac84551000000b004108f6788a6sm2825736qtn.41.2023.09.11.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:36 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] mm: page_alloc: fix move_freepages_block() range error
Date:   Mon, 11 Sep 2023 15:41:45 -0400
Message-ID: <20230911195023.247694-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911195023.247694-1-hannes@cmpxchg.org>
References: <20230911195023.247694-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f6f658c3d394..5bbe5f3be5ad 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1652,7 +1652,7 @@ int move_freepages_block(struct zone *zone, struct page *page,
 
 	/* Do not cross zone boundaries */
 	if (!zone_spans_pfn(zone, start_pfn))
-		start_pfn = pfn;
+		start_pfn = zone->zone_start_pfn;
 	if (!zone_spans_pfn(zone, end_pfn))
 		return 0;
 
-- 
2.42.0

