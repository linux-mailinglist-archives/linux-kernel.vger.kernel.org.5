Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C18806D3C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378102AbjLFLD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378022AbjLFLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:03:10 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61073384E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:01:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-285d1101868so4448031a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701860474; x=1702465274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tmT8glKoA1mZRisM7CPsvj8rp8Fj5zx5XkNMnqVUSc=;
        b=Ej79UEC5r6V/O8zOKvyMXFR8manJkyM6bHwRTOfUfpCbk6LmIBIGlajYvLtmAVqDk+
         fbjIDtxty1TGPktNTVaf3vD50a8a/BKJq9UgxiNukwLjhSK3hL+N/7WKHu2/5NuFt9p2
         4JFXSq5qFlomRSogXlYxhomJW08+U6WYioF2f9Ca61plVgPTTBkDG9/VggNARyz6I2Ku
         Ye0y5tUk7ea3mkglMH6xwtU9pncP/+Ke8XwVDpVfQ0WJNS9ujocuTaC/NSLKR+pWI5rd
         YbEiZ6gnBOSibtqbtuT8i6YJbCCmRBhuhBeq6l6J/qOYVCEKJbKt8DMqfzYlc4/mMKkX
         hCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701860474; x=1702465274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tmT8glKoA1mZRisM7CPsvj8rp8Fj5zx5XkNMnqVUSc=;
        b=aCyQ5fgYTibtrHHegEPoF6ZFIIZ+2b8i1Ma1JDvuuE0yZuAx8IfPmmKQM7b0ThYpq2
         MJ0g5Nn2rwMv56iPbh6ugdZJyjKcmWUGebdvZaod2xmPWyLB3icLx0DIlcuZuY2P1ktb
         hgRJvunrosOJpvqI2W4czn/b0zlPQEzAGCbtkm5OOPC1PjlJu7nzyP6yBfZ4DcASkI7j
         ysfdKAohYgFjziY9Fes9XPh1QVyqiM0G56xLyNPog8V3zocBiNaBxdTXolnjFsKlPYws
         P50KcpTQGvdBHD/qGN1V+iX48AdsdKhHx2Y9PR82BvapI1LKUzWpDehq67ZjzonnOLzj
         OfiA==
X-Gm-Message-State: AOJu0YxMVsQD1U+4S2HnWf4HD/thSj04PS17DAXSP2pj4VY5/9Bclzaw
        fS58Lw9zm9XT9N5zd1Ea+/Y=
X-Google-Smtp-Source: AGHT+IHx7ucyQlMtsTNmJN9r41T5q107P/StLlN5xh8J201NqlkG/DiIJrTjHmbSAtKaWa/izz8gaA==
X-Received: by 2002:a17:90a:e7c2:b0:286:e2bb:26a4 with SMTP id kb2-20020a17090ae7c200b00286e2bb26a4mr426280pjb.40.1701860474132;
        Wed, 06 Dec 2023 03:01:14 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:c02a:270e:39c4:ae78])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090a941100b00263f41a655esm10890158pjo.43.2023.12.06.03.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 03:01:13 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
X-Google-Original-From: Barry Song <v-songbaohua@oppo.com>
To:     akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org
Cc:     david@redhat.com, hannes@cmpxchg.org, huzhanyuan@oppo.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        shikemeng@huaweicloud.com, v-songbaohua@oppo.com,
        willy@infradead.org
Subject: [PATCH] mm: compaction: avoid fast_isolate_freepages blindly choose improper pageblock
Date:   Thu,  7 Dec 2023 00:00:54 +1300
Message-Id: <20231206110054.61617-1-v-songbaohua@oppo.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing shows fast_isolate_freepages can blindly choose an unsuitable
pageblock from time to time particularly while the min mark is used
from XXX path:
 if (!page) {
         cc->fast_search_fail++;
         if (scan_start) {
                 /*
                  * Use the highest PFN found above min. If one was
                  * not found, be pessimistic for direct compaction
                  * and use the min mark.
                  */
                 if (highest >= min_pfn) {
                         page = pfn_to_page(highest);
                         cc->free_pfn = highest;
                 } else {
                         if (cc->direct_compaction && pfn_valid(min_pfn)) { /* XXX */
                                 page = pageblock_pfn_to_page(min_pfn,
                                         min(pageblock_end_pfn(min_pfn),
                                             zone_end_pfn(cc->zone)),
                                         cc->zone);
                                 cc->free_pfn = min_pfn;
                         }
                 }
         }
 }

The reason is that no code is doing any check on the min_pfn
 min_pfn = pageblock_start_pfn(cc->free_pfn - (distance >> 1));

In contrast, slow path of isolate_freepages() is always skipping unsuitable
pageblocks in a decent way.

This issue doesn't happen quite often. When running 25 machines with 16GiB
memory for one night, most of them can hit this unexpected code path.
However the frequency isn't like many times per second. It might be one
time in a couple of hours. Thus, it is very hard to measure the visible
performance impact in my machines though the affection of choosing the
unsuitable migration_target should be negative in theory.

I feel it's still worth fixing this to at least make the code theoretically
self-explanatory as it is quite odd an unsuitable migration_target can be
still migration_target.

Reported-by: Zhanyuan Hu <huzhanyuan@oppo.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 v1:
    move the fix to the specific min_pfn path with respect to Baolin's comment
 rfc:
    https://lore.kernel.org/linux-mm/20231129104530.63787-1-v-songbaohua@oppo.com/#t

 mm/compaction.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 01ba298739dd..de15a2ef0af5 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1611,6 +1611,9 @@ static void fast_isolate_freepages(struct compact_control *cc)
 						min(pageblock_end_pfn(min_pfn),
 						    zone_end_pfn(cc->zone)),
 						cc->zone);
+					if (page && !suitable_migration_target(cc, page))
+						page = NULL;
+
 					cc->free_pfn = min_pfn;
 				}
 			}
-- 
2.34.1

