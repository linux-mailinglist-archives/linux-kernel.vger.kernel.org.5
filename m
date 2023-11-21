Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCA7F3496
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjKURLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjKURLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:11:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC59018C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:11:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551321042;
        Tue, 21 Nov 2023 09:12:26 -0800 (PST)
Received: from [10.1.26.189] (XHFQ2J9959.cambridge.arm.com [10.1.26.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EF3A3F6C4;
        Tue, 21 Nov 2023 09:11:37 -0800 (PST)
Message-ID: <df51bbb7-f791-4747-9077-e9f7f37e9518@arm.com>
Date:   Tue, 21 Nov 2023 17:11:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Enable >0 order folio memory compaction
Content-Language: en-GB
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        Yu Zhao <yuzhao@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rohan Puri <rohan.puri15@gmail.com>,
        Mcgrof Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
References: <20231113170157.280181-1-zi.yan@sent.com>
 <1e7cf758-ac0e-4eda-a8e2-90db5eed7f7a@arm.com>
 <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7ED1378A-AC39-48A2-8A2A-E06C7858DCE1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2023 16:45, Zi Yan wrote:
> On 21 Nov 2023, at 10:46, Ryan Roberts wrote:
> 
>>>
>>> vm-scalability results
>>> ===
>>>
>>> =========================================================================================
>>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>>   gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalability
>>>
>>> commit:
>>>   6.6.0-rc4-mm-everything-2023-10-21-02-40+
>>>   6.6.0-rc4-split-folio-in-compaction+
>>>   6.6.0-rc4-folio-migration-in-compaction+
>>>   6.6.0-rc4-folio-migration-free-page-split+
>>>   6.6.0-rc4-folio-migration-free-page-split-sort-src+
>>>
>>> 6.6.0-rc4-mm-eve 6.6.0-rc4-split-folio-in-co 6.6.0-rc4-folio-migration-i 6.6.0-rc4-folio-migration-f 6.6.0-rc4-folio-migration-f
>>> ---------------- --------------------------- --------------------------- --------------------------- ---------------------------
>>>          %stddev     %change         %stddev     %change         %stddev     %change         %stddev     %change         %stddev
>>>              \          |                \          |                \          |                \          |                \
>>>   12896955            +2.7%   13249322            -4.0%   12385175 ±  5%      +1.1%   13033951            -0.4%   12845698        vm-scalability.throughput
>>
>> Hi Zi,
>>
>> Are you able to add any commentary to these results as I'm struggling to
>> interpret them; Is a positive or negative change better (are they times or
>> rates?). What are the stddev values? The title suggests percent but the values
>> are huge - I'm trying to understand what the error bars look like - are the
>> swings real or noise?
> 
> The metric is vm-scalability.throughput, so the larger the better. Some %stddev
> are not present since they are too small. For 6.6.0-rc4-folio-migration-in-compaction+,
> %stddev is greater than %change, so the change might be noise.

Ahh got it - thanks!

> 
> Also, I talked to DavidH in last THP Cabal meeting about this. He suggested that
> there are a lot of noise in vm-scalability like what I have here and I should
> run more iterations and on bare metal. I am currently rerun them on a baremetal
> and more iterations on the existing VM and report the results later. Please
> note that the runs really take some time.

Ahh ok, I'll wait for the bare metal numbers and will disregard these for now.
Thanks!

> 
> In addition, I will find other fragmentation-related benchmarks, so we can see
> the impact on memory fragmentation.
> 
> --
> Best Regards,
> Yan, Zi

