Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0C809CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjLHHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjLHHMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:12:34 -0500
Received: from out0-222.mail.aliyun.com (out0-222.mail.aliyun.com [140.205.0.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D6D54
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:12:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=henry.hj@antgroup.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.VfcfN-q_1702019557;
Received: from localhost(mailfrom:henry.hj@antgroup.com fp:SMTPD_---.VfcfN-q_1702019557)
          by smtp.aliyun-inc.com;
          Fri, 08 Dec 2023 15:12:37 +0800
From:   "Henry Huang" <henry.hj@antgroup.com>
To:     yuzhao@google.com
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "=?UTF-8?B?6LCI6Ym06ZSL?=" <henry.tjf@antgroup.com>,
        "=?UTF-8?B?5pyx6L6JKOiMtuawtCk=?=" <teawater@antgroup.com>,
        <akpm@linux-foundation.org>
Subject: Re: [RFC v2] mm: Multi-Gen LRU: fix use mm/page_idle/bitmap
Date:   Fri, 08 Dec 2023 15:12:35 +0800
Message-ID: <20231208071235.17812-1-henry.hj@antgroup.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com>
References: <CAOUHufZeADNp_y=Ng+acmMMgnTR=ZGFZ7z-m6O47O=CmJauWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for replying this RFC.

> 1. page_idle/bitmap isn't a capable interface at all -- yes, Google
> proposed the idea [1], but we don't really use it anymore because of
> its poor scalability.

In our environment, we use /sys/kernel/mm/page_idle/bitmap to check
pages whether were accessed during a peroid of time. We manage all pages
idle time in userspace. Then use a prediction algorithm to select pages
to reclaim. These pages would more likely be idled for a long time.

We only need kernel to tell use whether a page is accessed, a boolean
value in kernel is enough for our case.

> 2. PG_idle/young, being a boolean value, has poor granularity. If
> anyone must use page_idle/bitmap for some specific reason, I'd
> recommend exporting generation numbers instead.

Yes, at first time, we try using multi-gen LRU proactvie scan and
exporting generation&refs number to do the same thing.

But there are serveral problems:

1. multi-gen LRU only care about self-memcg pages. In our environment,
it's likely to see that different memcg's process share pages.
multi-gen LRU only update gen of pages in current memcg. It's hard to
judge a page whether is accessed depends on gen update.

We still have no ideas how to solve this problem.

2. We set swappiness 0, and use proactive scan to select cold pages
& proactive reclaim to swap anon pages. But we can't control passive
scan(can_swap = false), which would make anon pages cold/hot inversion
in inc_min_seq.

Is it a good idea to include a interface to config passive scan option?

-- 
2.43.0

