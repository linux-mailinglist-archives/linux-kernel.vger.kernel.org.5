Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FCC7C8B3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjJMQcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjJMQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:31:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44704D7A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:31:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4412511FB;
        Fri, 13 Oct 2023 09:32:03 -0700 (PDT)
Received: from [10.57.66.151] (unknown [10.57.66.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74CB73F5A1;
        Fri, 13 Oct 2023 09:31:21 -0700 (PDT)
Message-ID: <a9d7103f-efcb-4ab8-91b9-6f1737789c49@arm.com>
Date:   Fri, 13 Oct 2023 17:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] Swap-out small-sized THP without splitting
Content-Language: en-GB
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231010142111.3997780-1-ryan.roberts@arm.com>
 <87zg0pfyux.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87zg0pfyux.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2023 07:37, Huang, Ying wrote:
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
> [...]
> 
>> Finally on testing, I've run the mm selftests and see no regressions, but I
>> don't think there is anything in there specifically aimed towards swap? Are
>> there any functional or performance tests that I should run? It would certainly
>> be good to confirm I haven't regressed PMD-size THP swap performance.
> 
> I have used swap sub test case of vm-scalbility to test.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/

I ended up using `usemem`, which is the core of this test suite, but deviated
from the pre-canned test case to allow me to use anonymous memory and get
numbers for small-sized THP (this is a very useful tool - thanks for pointing it
out!)

I've run the tests on Ampere Altra, set up with a 35G block ram device as the
swap device and from inside a memcg limited to 40G memory. I've then run
`usemem` with 70 processes (each has its own core), each allocating and writing
1G of memory. I've repeated everything 5 times and taken the mean and stdev:


Mean Performance Improvement vs 4K/baseline

| alloc size |            baseline |    remove-huge-flag | swap-file-small-thp |
|            |  v6.6-rc4+anonfolio |           + patch 1 |           + patch 2 |
|:-----------|--------------------:|--------------------:|--------------------:|
| 4K Page    |                0.0% |                2.3% |                9.1% |
| 64K THP    |              -44.1% |              -46.3% |               30.6% |
| 2M THP     |               56.0% |               54.2% |               60.1% |


Standard Deviation as Percentage of Mean

| alloc size |            baseline |    remove-huge-flag | swap-file-small-thp |
|            |  v6.6-rc4+anonfolio |           + patch 1 |           + patch 2 |
|:-----------|--------------------:|--------------------:|--------------------:|
| 4K Page    |                3.4% |                7.1% |                1.7% |
| 64K THP    |                1.9% |                5.6% |                7.7% |
| 2M THP     |                1.9% |                2.1% |                3.2% |


I don't see any meaningful performance cost to removing the HUGE flag, so
hopefully this gives us confidence to move forward with patch 1.

You can indeed see the performance regression in the baseline when THP is
configured to allocate small-sized THP only (in this case 64K). And you can see
the regression is fixed by patch 2, which avoids splitting the THP and thus
avoids the extra TLBIs. This correlates with what I saw in kernel compilation
workload.

Huang Ying, based on these results, do you still want me to persue a per-cpu
solution to avoid potential contention on the swap info lock? - I proposed in
the thread against patch 2 to do this in the swap_slots layer if so, rather than
in swapfile.c directly (I'm not sure how your original proposal would actually
work?). But based on these results, its not obvious to me that there is a
definite problem here, and it might be simpler to avoid the complexity?

Thanks,
Ryan

> 
> --
> Best Regards,
> Huang, Ying

