Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B122F7EAEA1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjKNLLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNLLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:11:51 -0500
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DE318C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 03:11:47 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VwPD2sM_1699960303;
Received: from 30.97.48.66(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VwPD2sM_1699960303)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 19:11:44 +0800
Message-ID: <f22001bb-e474-4ddb-8440-2668e6cec000@linux.alibaba.com>
Date:   Tue, 14 Nov 2023 19:11:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: support large folio numa balancing
To:     "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, wangkefeng.wang@huawei.com,
        willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>
References: <a71a478ce404e93683023dbb7248dd95f11554f4.1699872019.git.baolin.wang@linux.alibaba.com>
 <606d2d7a-d937-4ffe-a6f2-dfe3ae5a0c91@redhat.com>
 <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <871qctf89m.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/2023 9:12 AM, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
> 
>> On 13.11.23 11:45, Baolin Wang wrote:
>>> Currently, the file pages already support large folio, and supporting for
>>> anonymous pages is also under discussion[1]. Moreover, the numa balancing
>>> code are converted to use a folio by previous thread[2], and the migrate_pages
>>> function also already supports the large folio migration.
>>> So now I did not see any reason to continue restricting NUMA
>>> balancing for
>>> large folio.
>>
>> I recall John wanted to look into that. CCing him.
>>
>> I'll note that the "head page mapcount" heuristic to detect sharers will
>> now strike on the PTE path and make us believe that a large folios is
>> exclusive, although it isn't.
> 
> Even 4k folio may be shared by multiple processes/threads.  So, numa
> balancing uses a multi-stage node selection algorithm (mostly
> implemented in should_numa_migrate_memory()) to identify shared folios.
> I think that the algorithm needs to be adjusted for PTE mapped large
> folio for shared folios.

Not sure I get you here. In should_numa_migrate_memory(), it will use 
last CPU id, last PID and group numa faults to determine if this page 
can be migrated to the target node. So for large folio, a precise folio 
sharers check can make the numa faults of a group more accurate, which 
is enough for should_numa_migrate_memory() to make a decision?

Could you provide a more detailed description of the algorithm you would 
like to change for large folio? Thanks.

> And, as a performance improvement patch, some performance data needs to

Do you have some benchmark recommendation? I know the the autonuma can 
not support large folio now.

> be provided.  And, the effect of shared folio detection needs to be
> tested too
