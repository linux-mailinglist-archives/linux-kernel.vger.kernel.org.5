Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52B769F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjGaRY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGaRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:24:54 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597E5A0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:24:52 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so27439616d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690824291; x=1691429091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NS07eERycsyYXabrMm2ZwmT1XGv12jB2lBTOvtc5rI=;
        b=18XUaorMeICGc+jzoF4yol4wK5qJ7gn2mfA4wlpTfRO8KdaQDIH1fD2koXQPYRjEDC
         NIIdKxiwwM/YDz38sQ+MlsBsV63rH0AdPhBpkcJncF7+4x+s75wttLBi6JthsD+akEjf
         kSVpMRpqvt2MK1eFqFven2FU8b9mB725b3ESRHKHKsS7dYnYgtR3v58asjyphUq7NiFj
         5jghqsA7lxDAKMTJjQB3pcWzpEf5HXUXBBPJLxvXK3P5Hks3j3ctROflA/DZo9QEP3++
         iRb2YOn0UOXI+9vd7zHj/AddRy3d3/he+goVguwsXPIRKL0z/STsCp1FqQ/SdeCbmNJY
         x1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690824291; x=1691429091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NS07eERycsyYXabrMm2ZwmT1XGv12jB2lBTOvtc5rI=;
        b=CWAeYzXNuOhgYjdkzleo6iI9UxfXIncG0l+DUBHlgxyAyNor3B+6d7KBq+3Ksa41n9
         DAljzsxdz7m/v0N8rr758jravEotzHbhl8cbPGzqQfbTXJSY6IM4b8d+8g4D2zB7UuJ2
         BAGjV2CXV7gERB0GZBguoVDnvCuEi3IS4+ASO2y5nWAHPPHmVCUzL5PN61nEds5w2uFe
         O4GBux2PCDHlKWnBUUjAecHFTILye3v6mN40E7aEO6XN2UAoqn8om+2eLbskcbaTo7oX
         Byo2oiydZHtIIlOdttUsTsiuEqvEA9ZoEKDkJpGhPVzKCPjeTiibl9uJTiWPIdFDMm5O
         gbpg==
X-Gm-Message-State: ABy/qLZIzbz1bNLqQgM2sQyIZ5WJSaRXE7rYuTbjEQASji+x/WqdDEmF
        VzPKk7mUcHKhap6oIlFE2y9PQA==
X-Google-Smtp-Source: APBJJlGRy+Nma728a4Fs3yn3m7Q4d9RSDgIp+ZN1CBwpFtcSjS/YiqDh7dIhQbspSC7isIOHk6SmJA==
X-Received: by 2002:a05:6214:301b:b0:637:b20d:899d with SMTP id ke27-20020a056214301b00b00637b20d899dmr12116438qvb.10.1690824291357;
        Mon, 31 Jul 2023 10:24:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id q6-20020a0ce206000000b006300e92ea02sm3928668qvl.121.2023.07.31.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 10:24:51 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: compaction: fix endless looping over same migrate block
Date:   Mon, 31 Jul 2023 13:24:50 -0400
Message-ID: <20230731172450.1632195-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During stress testing, the following situation was observed:

     70 root      39  19       0      0      0 R 100.0   0.0 959:29.92 khugepaged
 310936 root      20   0   84416  25620    512 R  99.7   1.5 642:37.22 hugealloc

Tracing shows isolate_migratepages_block() endlessly looping over the
first block in the DMA zone:

       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_finished: node=0 zone=DMA      order=9 ret=no_suitable_page
       hugealloc-310936  [001] ..... 237297.415718: mm_compaction_isolate_migratepages: range=(0x1 ~ 0x400) nr_scanned=513 nr_taken=0

The problem is that the functions tries to test and set the skip bit
once on the block, to avoid skipping on its own skip-set, using
pageblock_aligned() on the pfn as a test. But because this is the DMA
zone which starts at pfn 1, this is never true for the first block,
and the skip bit isn't set or tested at all. As a result,
fast_find_migrateblock() returns the same pageblock over and over.

If the pfn isn't pageblock-aligned, also check if it's the start of
the zone to ensure test-and-set-exactly-once on unaligned ranges.

Thanks to Vlastimil Babka for the help in debugging this.

Fixes: 90ed667c03fe ("Revert "Revert "mm/compaction: fix set skip in fast_find_migrateblock""")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index dbc9f86b1934..eacca2794e47 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -912,11 +912,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 
 		/*
 		 * Check if the pageblock has already been marked skipped.
-		 * Only the aligned PFN is checked as the caller isolates
+		 * Only the first PFN is checked as the caller isolates
 		 * COMPACT_CLUSTER_MAX at a time so the second call must
 		 * not falsely conclude that the block should be skipped.
 		 */
-		if (!valid_page && pageblock_aligned(low_pfn)) {
+		if (!valid_page && (pageblock_aligned(low_pfn) ||
+				    low_pfn == cc->zone->zone_start_pfn)) {
 			if (!isolation_suitable(cc, page)) {
 				low_pfn = end_pfn;
 				folio = NULL;
@@ -2002,7 +2003,8 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 		 * before making it "skip" so other compaction instances do
 		 * not scan the same block.
 		 */
-		if (pageblock_aligned(low_pfn) &&
+		if ((pageblock_aligned(low_pfn) ||
+		     low_pfn == cc->zone->zone_start_pfn) &&
 		    !fast_find_block && !isolation_suitable(cc, page))
 			continue;
 
-- 
2.41.0

