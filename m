Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A33579AED2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350123AbjIKVfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244258AbjIKTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:40 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994041A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:35 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-5731fe1d2bfso2697373eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461835; x=1695066635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIntV6SfyJxxBgJqngsAK3yqYWZ9fE7nMi1YvaBUo2Y=;
        b=D37mE1/h64JbCmNboJSxslR+NrmIUYhIjTtW9HWzcx7q0MuNlncxtYfGFZ7iq49Kpm
         wiU/jC6KyUwBVLHtKFS3oIxFGvI3WHWkb4NLq7YQCAe9I3Jl6sNaV5xQ9mXBEWXYeqSq
         Ucdk8je8+Ozno3vsAPhuo5YKN5P1hcyiQjK4LBWvjVmv038AIupxUljlvhweRWBZvZdF
         rvPdFPBU1qUcPNM4agB728jgXj+CjQWL2OErPkeMzBUvUYs2cqq7eJpl1s7cfrRMcQQi
         nkNmqq8ybrEqVY9xQi7U4SVHvV4Zu9TXAvv4Y72Mg6BpaRdEdaD2lnzwIHEUIewiS/AL
         msIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461835; x=1695066635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIntV6SfyJxxBgJqngsAK3yqYWZ9fE7nMi1YvaBUo2Y=;
        b=wjZVfjAceR7cTp3RT/TNUDB9+XdHw6N5icWFWdYosN37Ko0ChTG7qpZ9hn2PHQ2msC
         k0j4flZyVL2J6PHov6GVFNSRJ1CiE90fW7ansrLs8uz1jsAiP1grz8s9vXHcX/h7QtES
         Ael4IhKRjwmgxWs+7DDyOFHPoh/l/d6sXVZNLLn6/QksirBbWkZoHOSjDYmT597Yu3hf
         xot2OAIN1uo8vbydV/3LWBGMMijEFS3XOG6iDIx7AOWmdHYV/FhvJZDU7NQ3ksFo34uk
         r3oMru5O1HX5LZ5Do+0S+3s4SL7Byh0m6RFi44sWbp89f1AojQh3Iu4LJA3I5VqU0bxW
         o6Jw==
X-Gm-Message-State: AOJu0Yx1p0+GGpX4rRO/C5W3HDe1+qWFEpyr7K+23bWFtHJ/Khk4tlfl
        yXPgVM41h2WpjpahN1U5zbqiilLJ5oJT18dpP/0=
X-Google-Smtp-Source: AGHT+IGS06A0iPrm3hhJt1coz/NmHegf9pi5FM+C3kEjocCFV6oSc5waC969xFTQcEM5YgwdIe4bDQ==
X-Received: by 2002:a05:6358:6f92:b0:130:faea:a81f with SMTP id s18-20020a0563586f9200b00130faeaa81fmr5835243rwn.28.1694461834812;
        Mon, 11 Sep 2023 12:50:34 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id j20-20020a0cf514000000b0064b502fdeecsm3129162qvm.68.2023.09.11.12.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:34 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] mm: page_alloc: fix up block types when merging compatible blocks
Date:   Mon, 11 Sep 2023 15:41:43 -0400
Message-ID: <20230911195023.247694-3-hannes@cmpxchg.org>
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

The buddy allocator coalesces compatible blocks during freeing, but it
doesn't update the types of the subblocks to match. When an allocation
later breaks the chunk down again, its pieces will be put on freelists
of the wrong type. This encourages incompatible page mixing (ask for
one type, get another), and thus long-term fragmentation.

Update the subblocks when merging a larger chunk, such that a later
expand() will maintain freelist type hygiene.

v2:
- remove spurious change_pageblock_range() move (Zi Yan)

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e3f1c777feed..3db405414174 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -783,10 +783,17 @@ static inline void __free_one_page(struct page *page,
 			 */
 			int buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
 
-			if (migratetype != buddy_mt
-					&& (!migratetype_is_mergeable(migratetype) ||
-						!migratetype_is_mergeable(buddy_mt)))
-				goto done_merging;
+			if (migratetype != buddy_mt) {
+				if (!migratetype_is_mergeable(migratetype) ||
+				    !migratetype_is_mergeable(buddy_mt))
+					goto done_merging;
+				/*
+				 * Match buddy type. This ensures that
+				 * an expand() down the line puts the
+				 * sub-blocks on the right freelists.
+				 */
+				set_pageblock_migratetype(buddy, migratetype);
+			}
 		}
 
 		/*
-- 
2.42.0

