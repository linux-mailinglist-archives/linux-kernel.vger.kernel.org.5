Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA29E79BDED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343757AbjIKVMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbjIKTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:41 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10CE1B6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:36 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-76dcf1d8957so290912885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461836; x=1695066636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXpNvTPTT9ib/tT2NTgBNzi3cETEqU1uBo715LHCaBY=;
        b=uT4MVQjCu6pBTo7Q8JifJ7gtBsh1Nkc6qOX+z7WR3NeD9H7v/+6G3G6NfEvQFYBK/G
         hvhe98QvObS74O5spsIzhJrrWIhRkPnDMS88PpPN3xH+tLigVSILwSEm0SdoYZxkRPkv
         ogC+ZcUkMeuD+q6iYbDCuFReydVRhWcHVsUXKuhJKDKDUo7+ZYYorruzd9UgTgWxr+C2
         mxbMKUVaLZvi6yiYrmaojHv85+hvXDXgUvpKBxlqf/Q+rI8/qam6YHaF4lRrJNVVOloz
         Mv1rMvgDiqx6DhBTiV4zI1RtLXNR3cEGbjYQpqzcaSNhLLjZj/kU8Dvk9TxHPi7ueSxI
         9Fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461836; x=1695066636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXpNvTPTT9ib/tT2NTgBNzi3cETEqU1uBo715LHCaBY=;
        b=l4FUspZkjsgYeZcnCxAo+eLEldDBTBrbe6IAGA91cUWVYze2CmvKPI++/BgHCnMAQE
         xslp515eZAegZjKOkTw2iVg4wBZdsoX+nSupP/eBpTAX13Ty2kAuF+qkx+JuYdei7gTA
         Fg8czyCFVmFGeSlV5EbLdy0+b2JS/SUYk3XBql3wIFFgwSxw/SGEolkw05J0EVFCZ9pX
         f6A6J+v1DgGt2Udn5kZeLLawCJ3XQUPyHy8IMLGNXXun3piL+0QzPHEO3AhTi4Px3Lwv
         lGWJ6Y+Sa07p/bYALDEifr0Kib9Sn+YJeONLytn/c7MvrANsKvbG8r/yGLTgnjboUl2E
         /OyQ==
X-Gm-Message-State: AOJu0Yw72Xg5vyTG+no0408WV90d2HstE98lStBwZsMAuMwKVUNI2YRb
        C2swV4TzT5YEquKYzIh6CyESQQ==
X-Google-Smtp-Source: AGHT+IFL0UuJsNEAxd5SAPx+lZ3HgMHaH/IGI5QCwmbwAzaYO1UWU+4wttoCCDMIY1y70kB2Wm1/ug==
X-Received: by 2002:a05:620a:991:b0:76e:f279:4c36 with SMTP id x17-20020a05620a099100b0076ef2794c36mr9707748qkx.29.1694461835893;
        Mon, 11 Sep 2023 12:50:35 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id 20-20020a05620a071400b00767d6ec578csm2724636qkc.20.2023.09.11.12.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:35 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] mm: page_alloc: move free pages when converting block during isolation
Date:   Mon, 11 Sep 2023 15:41:44 -0400
Message-ID: <20230911195023.247694-4-hannes@cmpxchg.org>
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

When claiming a block during compaction isolation, move any remaining
free pages to the correct freelists as well, instead of stranding them
on the wrong list. Otherwise, this encourages incompatible page mixing
down the line, and thus long-term fragmentation.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3db405414174..f6f658c3d394 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2548,9 +2548,12 @@ int __isolate_free_page(struct page *page, unsigned int order)
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
2.42.0

