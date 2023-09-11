Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1468A79BB61
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245409AbjIKVJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244256AbjIKTui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:50:38 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894501A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-64a5f9a165eso26948256d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694461832; x=1695066632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUhpLn3tgSPZYhOpcPmf1kQLHZfyHW/pDHKf5NypG+s=;
        b=VFqVutnD4RD5WIuzCWEFTLHLCvzJkY5KKUgn6xp6fXiapm1eKNnAGHhYfD5osxNEDI
         4kviC0wgQKZsYLv2OVQI2aoE4v9RPkuMJY96taEA5FP3preTPAqZpRRUPG/E5X4Z2MOA
         toyClDsUCK0Sfj+hLDKHLAwHoPAmN6+2C1CkVLs6nxZCXObmvdX4++epZbSda8APKpvM
         3AzUOtC8Bf0IjCoPt22lMVSqle5JcXkaMFHiDfabaJ88gxVBWwf5rgoIm8eYpEwpJCON
         rztE75c56klDiTtiuXNEpZWWdkvqW1mp8IHUIr020HrvcrfmQ3SpNgmcnLicNZ8QZyrm
         /J7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694461832; x=1695066632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUhpLn3tgSPZYhOpcPmf1kQLHZfyHW/pDHKf5NypG+s=;
        b=oLpvQi/FvhDxtTiZE2NWQf1KRvfueun6wqbBreEjQz7OatMkSTorZyRoBbXOWEUYvc
         n+V5eUYatqiI6O6Xlaqon+UsQh4qpcez/NZkS5xjdP9yowgVpUvHqJsg15kblVOqQAUW
         j4bZOYqCwopygqPp6Y3rVrrfY28dpWeGGHQADxoqYJm2pDfeoEBKWyIa1iis7+mPxJGv
         QmnziGb/ytYuhYZ1lQJ5e7iEJBRxSAlpxyVxrsjRtCeVUGFn8Tspzer0JxiETgPNPDoJ
         wrGE2tSrYzp6vFJMkDziXIGcKPkxRISa9J5Z21sHStILxsH43aKRaI5UOFwoZTJJSzpv
         FWQQ==
X-Gm-Message-State: AOJu0YwP4dzcmUazRUQWv1JZmLMhXM7wECSeBZxGVBfZ6uRspfktaga6
        lQTptk08Bc7mhOv4WMlQYP+NUQ==
X-Google-Smtp-Source: AGHT+IH6zew5o97PM9FqBHRV0vZ420ai/jzzZn1v0Pm7AewGkf/LsavwKwaGmeu3UPe/OWVG6DMtOg==
X-Received: by 2002:a05:6214:5342:b0:64f:4e7a:bc4d with SMTP id kv2-20020a056214534200b0064f4e7abc4dmr9236075qvb.43.1694461832568;
        Mon, 11 Sep 2023 12:50:32 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id y2-20020a0cc542000000b0064733ac9a9dsm3161975qvi.122.2023.09.11.12.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 12:50:32 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Date:   Mon, 11 Sep 2023 15:41:41 -0400
Message-ID: <20230911195023.247694-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.42.0
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

V2:
- dropped the get_pfnblock_migratetype() optimization
  patchlet since somebody else beat me to it (thanks Zi)
- broke out pcp bypass fix since somebody else reported the bug:
  https://lore.kernel.org/linux-mm/20230911181108.GA104295@cmpxchg.org/
- fixed the CONFIG_UNACCEPTED_MEMORY build (lkp)
- rebased to v6.6-rc1

The series is based on v6.6-rc1 plus the pcp bypass fix above ^

---

This is a breakout series from the huge page allocator patches[1].

While testing and benchmarking the series incrementally, as per
reviewer request, it became apparent that there are several sources of
freelist migratetype violations that later patches in the series hid.

Those violations occur when pages of one migratetype end up on the
freelists of another type. This encourages incompatible page mixing
down the line, where allocation requests ask for one migrate type, but
receives pages of another. This defeats the mobility grouping.

The series addresses those causes. The last patch adds type checks on
all freelist movements to rule out any violations. I used these checks
to identify the violations fixed up in the preceding patches.

The series is a breakout, but has merit on its own: Less type mixing
means improved grouping, means less work for compaction, means higher
THP success rate and lower allocation latencies. The results can be
seen in a mixed workload that stresses the machine with a kernel build
job while periodically attempting to allocate batches of THP. The data
is averaged over 50 consecutive defconfig builds:

                                                        VANILLA      PATCHED-CLEANLISTS
Hugealloc Time median                     14642.00 (    +0.00%)   10506.00 (   -28.25%)
Hugealloc Time min                         4820.00 (    +0.00%)    4783.00 (    -0.77%)
Hugealloc Time max                      6786868.00 (    +0.00%) 6556624.00 (    -3.39%)
Kbuild Real time                            240.03 (    +0.00%)     241.45 (    +0.59%)
Kbuild User time                           1195.49 (    +0.00%)    1195.69 (    +0.02%)
Kbuild System time                           96.44 (    +0.00%)      97.03 (    +0.61%)
THP fault alloc                           11490.00 (    +0.00%)   11802.30 (    +2.72%)
THP fault fallback                          782.62 (    +0.00%)     478.88 (   -38.76%)
THP fault fail rate %                         6.38 (    +0.00%)       3.90 (   -33.52%)
Direct compact stall                        297.70 (    +0.00%)     224.56 (   -24.49%)
Direct compact fail                         265.98 (    +0.00%)     191.56 (   -27.87%)
Direct compact success                       31.72 (    +0.00%)      33.00 (    +3.91%)
Direct compact success rate %                13.11 (    +0.00%)      17.26 (   +29.43%)
Compact daemon scanned migrate          1673661.58 (    +0.00%) 1591682.18 (    -4.90%)
Compact daemon scanned free             2711252.80 (    +0.00%) 2615217.78 (    -3.54%)
Compact direct scanned migrate           384998.62 (    +0.00%)  261689.42 (   -32.03%)
Compact direct scanned free              966308.94 (    +0.00%)  667459.76 (   -30.93%)
Compact migrate scanned daemon %             80.86 (    +0.00%)      83.34 (    +3.02%)
Compact free scanned daemon %                74.41 (    +0.00%)      78.26 (    +5.10%)
Alloc stall                                 338.06 (    +0.00%)     440.72 (   +30.28%)
Pages kswapd scanned                    1356339.42 (    +0.00%) 1402313.42 (    +3.39%)
Pages kswapd reclaimed                   581309.08 (    +0.00%)  587956.82 (    +1.14%)
Pages direct scanned                      56384.18 (    +0.00%)  141095.04 (  +150.24%)
Pages direct reclaimed                    17055.54 (    +0.00%)   22427.96 (   +31.50%)
Pages scanned kswapd %                       96.38 (    +0.00%)      93.60 (    -2.86%)
Swap out                                  41528.00 (    +0.00%)   47969.92 (   +15.51%)
Swap in                                    6541.42 (    +0.00%)    9093.30 (   +39.01%)
File refaults                            127666.50 (    +0.00%)  135766.84 (    +6.34%)

 include/linux/mm.h             |  18 +-
 include/linux/page-isolation.h |   2 +-
 include/linux/vmstat.h         |   8 -
 mm/debug_page_alloc.c          |  12 +-
 mm/internal.h                  |   5 -
 mm/page_alloc.c                | 357 ++++++++++++++++++---------------
 mm/page_isolation.c            |  23 ++-
 7 files changed, 217 insertions(+), 208 deletions(-)


