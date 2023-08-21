Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0740C783059
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHUShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjHUShs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:37:48 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAF35068
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-64c1d487e72so19158206d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692643062; x=1693247862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxW29R58ZmFpg/rPJgqQ3VkRYdS419AYIG4Hav75F/o=;
        b=ZMy9LilUbtHaMB8a2Bc9S+CTYD8of9JLuHTQfeCD4NwFL27z0kKncoczddhT5Hkg0z
         x5QqUUE/AhnBHqO/PTpGJukrdQd3Eqobf1Ghno3MwWAKR+zNZZcB1BAlcriQMWvPUExr
         xqo9fFWzITkM0TDqdec52HjfHdgkDP3lZp0NV0FjzjO5HvOQa08PUmglBsDMUyPhMh29
         tBmxeC3Jr7ot3YQNZGIvnRCo/+UBOuEJM4ibv7jFsftN5kMb3sX3nBaHH3LN8OuxsiXU
         sKqbovAAYS7ZDY0aVjDgxSPjTLLUIz64y30G25tdyNzmndtcEBtCaUnLl735iwhhfqXT
         lJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692643062; x=1693247862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxW29R58ZmFpg/rPJgqQ3VkRYdS419AYIG4Hav75F/o=;
        b=jPGb5JVxCjoX2mXliufxCwcwqNmwLMjzAO/aklM0z5IeCrSw/PqufJEdeKQZbWCLvy
         AZsY+iKGE6fbkLV/Eki7GjvWneGlAG/kI9R8cPUUWb64q5l6xtInBOGk4l4QyelMzelU
         dhKs8mUGBKCFHdUxAy1MP5+2MoTNBM4WjDnQys0bTwVg2jQhJQ0XPEoOwKspBDOv72+I
         1eiScVCberMreyDHYONSNQj0u0oqUF+qvGLSSkP/5M+bUWisMaTda2LA8x7PHqGOoare
         3Jfeqt8azddZSvTicLAhuiJ4ihjtWZ7kYJv6yoTL26os6F9wUbcJlghI0ik6kP9rk6lh
         qYdg==
X-Gm-Message-State: AOJu0YzB/xdAG9J8RfSsFh9jRYWqvQR/PNdOvw3EeXTQ9H/Fl+Vmn3YE
        2pNTJZ0kEsNX5oDPfaKHRmmg0y0F4puW8mnHFUNTpQ==
X-Google-Smtp-Source: AGHT+IGy8J3qOalYFiRMZVkh+1jZEMs5H+0oIK7/2greDFHUnnDFEMOD0EUG29cPhWcOuKvVixoW0w==
X-Received: by 2002:a0c:c991:0:b0:63d:70f6:8f6f with SMTP id b17-20020a0cc991000000b0063d70f68f6fmr9159374qvk.43.1692643062274;
        Mon, 21 Aug 2023 11:37:42 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id m5-20020a0cf185000000b00649d9781acesm1453832qvl.2.2023.08.21.11.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:37:41 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] mm: page_alloc: freelist migratetype hygiene
Date:   Mon, 21 Aug 2023 14:33:32 -0400
Message-ID: <20230821183733.106619-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.41.0
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

The series is based on v6.5-rc7.

 include/linux/mm.h             |  18 +-
 include/linux/page-isolation.h |   2 +-
 include/linux/vmstat.h         |   8 -
 mm/debug_page_alloc.c          |  12 +-
 mm/internal.h                  |   5 -
 mm/page_alloc.c                | 382 +++++++++++++++++++++------------------
 mm/page_isolation.c            |  23 ++-
 7 files changed, 230 insertions(+), 220 deletions(-)

[1] https://lore.kernel.org/lkml/20230418191313.268131-1-hannes@cmpxchg.org/


