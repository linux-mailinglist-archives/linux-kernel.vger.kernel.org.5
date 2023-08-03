Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCAF076E2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233595AbjHCI0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjHCI0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:26:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F48C3C23
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:21:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E15D113E;
        Thu,  3 Aug 2023 01:22:00 -0700 (PDT)
Received: from [10.57.77.90] (unknown [10.57.77.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12E9D3F5A1;
        Thu,  3 Aug 2023 01:21:14 -0700 (PDT)
Message-ID: <49142e18-fd4e-6487-113a-3112b1c17dbe@arm.com>
Date:   Thu, 3 Aug 2023 09:21:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Yin Fengwei <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230726095146.2826796-1-ryan.roberts@arm.com>
 <20230726095146.2826796-3-ryan.roberts@arm.com>
 <CAOUHufackQzy+yXOzaej+G6DNYK-k9GAUHAK6Vq79BFHr7KwAQ@mail.gmail.com>
 <CAOUHufZ70cMR=hnMW0_J9BeWRPwXVUDoeRhES+wq19r1SioGuA@mail.gmail.com>
 <8c0710e0-a75a-b315-dae1-dd93092e4bd6@arm.com>
 <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <4ae53b2a-e069-f579-428d-ac6f744cd19a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 09:05, Yin Fengwei wrote:

...

>> I've captured run time and peak memory usage, and taken the mean. The stdev for
>> the peak memory usage is big-ish, but I'm confident this still captures the
>> central tendancy well:
>>
>> | MAX_ORDER_UNHINTED |   real-time |   kern-time |   user-time | peak memory |
>> |:-------------------|------------:|------------:|------------:|:------------|
>> | 4k                 |        0.0% |        0.0% |        0.0% |        0.0% |
>> | 16k                |       -3.6% |      -26.5% |       -0.5% |       -0.1% |
>> | 32k                |       -4.8% |      -37.4% |       -0.6% |       -0.1% |
>> | 64k                |       -5.7% |      -42.0% |       -0.6% |       -1.1% |
>> | 128k               |       -5.6% |      -42.1% |       -0.7% |        1.4% |
>> | 256k               |       -4.9% |      -41.9% |       -0.4% |        1.9% |
> 
> Here is my test result:
> 
> 		real		user		sys
> hink-4k:	 0%		0%		0%
> hink-16K:	-3%		0.1%		-18.3%
> hink-32K:	-4%		0.2%		-27.2%
> hink-64K:	-4%		0.5%		-31.0%
> hink-128K:	-4%		0.9%		-33.7%
> hink-256K:	-5%		1%		-34.6%
> 
> 
> I used command: 
> /usr/bin/time -f "\t%E real,\t%U user,\t%S sys" make -skj96 allmodconfig all
> to build kernel and collect the real time/user time/kernel time.
> /sys/kernel/mm/transparent_hugepage/enabled is "madvise".
> Let me know if you have any question about the test.

Thanks for doing this! I have a couple of questions:

 - how many times did you run each test?

 - how did you configure the large page size? (I sent an email out yesterday
   saying that I was doing it wrong from my tests, so the 128k and 256k results
   for my test set are not valid.

 - what does "hink" mean??

> 
> I also find one strange behavior with this version. It's related with why
> I need to set the /sys/kernel/mm/transparent_hugepage/enabled to "madvise".
> If it's "never", the large folio is disabled either.
> If it's "always", the THP will be active before large folio. So the system is
> in the mixed mode. it's not suitable for this test.

We had a discussion around this in the THP meeting yesterday. I'm going to write
this up propoerly so we can have proper systematic discussion. The tentative
conclusion is that MADV_NOHUGEPAGE must continue to mean "do not fault in more
than is absolutely necessary". I would assume we need to extend that thinking to
the process-wide and system-wide knobs (as is done in the patch), but we didn't
explicitly say so in the meeting.

My intention is that if you have requested THP and your vma is big enough for
PMD-size then you get that, else you fallback to large anon folios. And if you
have neither opted in nor out, then you get large anon folios.

We talked about the idea of adding a new knob that let's you set the max order,
but that needs a lot more thought.

Anyway, as I said, I'll write it up so we can all systematically discuss.

> 
> So if it's "never", large folio is disabled. But why "madvise" enables large
> folio unconditionly? Suppose it's only enabled for the VMA range which user
> madvise large folio (or THP)?
> 
> Specific for the hink setting, my understand is that we can't choose it only
> by this testing. Other workloads may have different behavior with differnt
> hink setting.
> 
> 
> Regards
> Yin, Fengwei
> 

