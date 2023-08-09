Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DD37764AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHIQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHIQIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:08:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 317D919E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:08:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA56D75;
        Wed,  9 Aug 2023 09:09:19 -0700 (PDT)
Received: from [10.57.79.142] (unknown [10.57.79.142])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2E63F59C;
        Wed,  9 Aug 2023 09:08:34 -0700 (PDT)
Message-ID: <e80cd2e6-6f7c-4337-a170-152926863290@arm.com>
Date:   Wed, 9 Aug 2023 17:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
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
 <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
 <433fb8de-f5c0-d150-ac7b-5d73e9958e02@arm.com>
 <CAOUHufZwyNrNbnpgTR=o5O8__QE4NdNG=LTgUoB26bVvDfgBkA@mail.gmail.com>
 <20469f02-d62d-d925-3536-d6a1f1099fda@arm.com>
 <CAOUHufbo58cJiD+k_SAw9N+4xJRv6BTYCZSbP3CxSsy3UOdPMw@mail.gmail.com>
 <CAOUHufbaWjOq4BnQasSeZyq2SZKQZ0d7DQ7mkj7Ses8hFAR5uw@mail.gmail.com>
Content-Language: en-GB
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAOUHufbaWjOq4BnQasSeZyq2SZKQZ0d7DQ7mkj7Ses8hFAR5uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>>> Let me reiterate [1]:
>>>>   My impression is we only agreed on one thing: at the current stage, we
>>>>   should respect things we absolutely have to. We didn't agree on what
>>>>   "never" means ("never 2MB" or "never >4KB"), and we didn't touch on
>>>>   how "always" should behave at all.
>>>>
>>>> And [2]:
>>>>   (Thanks to David, now I agree that) we have to interpret MADV_NOHUGEPAGE
>>>>   as nothing >4KB.
>>>>
>>>> My final take [3]:
>>>>   I agree these points require more discussion. But I don't think we
>>>>   need to conclude them now, unless they cause correctness issues like
>>>>   ignoring MADV_NOHUGEPAGE would.
>>>
>>> Thanks, I've read all of these comments previously, and appreciate the time you
>>> have put into the feedback. I'm not sure I fully agree with your point that we
>>> don't need to conclude on a policy now; I certainly don't think we need the
>>> whole thing in place on day 1, but I do think that whatever we put in should
>>> strive to be a strict subset of where we think we are going. For example, if we
>>> put something in with one policy (i.e. "never" only means "never 2MB") then find
>>> a problem and have to change that to be more conservative, are we risking perf
>>> regressions for any LAF users that started using it on day 1?
>>
>> It's not that I don't want to -- I just don't think we have enough
>> information before we have a wider deployment [1] and gain a better
>> understanding of real-world scenarios.
>>
>> Of course we could force a conclusion, a mostly opinion-based one. But
>> it would still involve prolonged discussions and delay this series, or
>> rush into decisions we might regret later.
>>
>> [1] Our fleets (servers, laptops and phones) support large-scale
>> experiments and I plan to run them on both client and server devices.

This all sounds great and I'm looking forward to seeing results! But I guess I
had been assuming that this sort of testing would be preferable to do before we
merge; that allows us to get confidence in the approach and reduces the changes
of having to change it later. I guess you have policies that prevent you from
testing this series at the scale you want until it is merged?

I'm not convinced this testing will help us answer the "what does never mean?"
question; if nothing breaks in your testing, it doesn't mean there aren't
systems out there that would break - it's hard to prove a negative. I think its
mostly embedded systems that use thp=never to reduce memory footprint to the
absolute minimum?


>>
>>>> But I should have been clear about the parameters to
>>>> hugepage_vma_check(): enforce_sysfs=false.
>>>
>>> So hugepage_vma_check(..., smaps=false, in_pf=true, enforce_sysfs=false) would
>>> give us:
>>>
>>>                 | prctl/fw  | sysfs     | sysfs     | sysfs
>>>                 | disable   | never     | madvise   | always
>>> ----------------|-----------|-----------|-----------|-----------
>>> no hint         | S         | LAF>S     | LAF>S     | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | LAF>S     | THP>LAF>S | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S         | S         | S
>>>
>>> Where "prctl/fw disable" trumps the sysfs setting.
>>>
>>> I can certainly see the benefit of this approach; it gives us a way to enable
>>> LAF while disabling THP (thp=never). It doesn't give us a way to enable THP
>>> without enabling LAF though (unless you recompile with LAF disabled). Does
>>> anyone see a problem with this?
>>
>> I do myself :)
>>
>> This is just something temporary to get this series landed. We are
>> hiding behind a Kconfig, not making any ABI changes, and not exposing
>> this policy to userspace (i.e., not updating Documentation/, man
>> pages, etc.)
>>
>> Meanwhile, we can keep discussing all the open questions in parallel.

You're right - don't want to slow down the testing, so I'm going to post a v5
tomorrow with the policy in the table above. We're still waiting for the
prerequisites to land before we can kick off testing in anger though.

> 
> And the stat ABI changes should be discussed before or at the same
> time. If we came up with a policy but there was *zero* observability
> of how well that policy works...

Yep agreed. I have a series at [1] which I hoped would kickstart that discussion.

[1] https://lore.kernel.org/linux-mm/20230613160950.3554675-1-ryan.roberts@arm.com/

Thanks,
Ryan

