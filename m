Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFDF7CF60C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345272AbjJSLEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjJSLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:04:06 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89452124
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:04:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VuTwO7v_1697713439;
Received: from 30.97.48.56(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VuTwO7v_1697713439)
          by smtp.aliyun-inc.com;
          Thu, 19 Oct 2023 19:04:00 +0800
Message-ID: <b579dcff-044a-c75b-5186-d48b497af792@linux.alibaba.com>
Date:   Thu, 19 Oct 2023 19:04:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/2] mm/migrate: correct nr_failed in
 migrate_pages_sync()
To:     Zi Yan <ziy@nvidia.com>, Huang Ying <ying.huang@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
References: <20231017163129.2025214-1-zi.yan@sent.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20231017163129.2025214-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 12:31 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> nr_failed was missing the large folio splits from migrate_pages_batch()
> and can cause a mismatch between migrate_pages() return value and the
> number of not migrated pages, i.e., when the return value of
> migrate_pages() is 0, there are still pages left in the from page list.
> It will happen when a non-PMD THP large folio fails to migrate due to
> -ENOMEM and is split successfully but not all the split pages are not
> migrated, migrate_pages_batch() would return non-zero, but
> astats.nr_thp_split = 0. nr_failed would be 0 and returned to the caller
> of migrate_pages(), but the not migrated pages are left in the from page
> list without being added back to LRU lists.
> 
> Fix it by adding a new nr_split counter for large folio splits and adding
> it to nr_failed in migrate_page_sync() after migrate_pages_batch() is
> done.
> 
> Fixes: 2ef7dbb26990 ("migrate_pages: try migrate in batch asynchronously firstly")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> ---

LGTM. Feel free to add:
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
