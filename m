Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95CE78E47D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbjHaBnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbjHaBnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:43:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21552A1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 18:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693446187; x=1724982187;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=MDzWu1GQiMk1lZ4sUWL+VXmG6+516QWwdoCHS5AYa5A=;
  b=Ht+IDpl+UoBPbIT7GDxyDM8erllCqnysiX1UMkF+A4u+56wvL9kRXsWv
   55VLFLkgdSm/zeY9myHW1vRu1lgCnTDbDAHP7Vir5s8ku2wI8auuO9czg
   r+16W7EriLw727XxFNWst/pivlBEr7vVYHw+VL2ZwgmtyMyL7GpGuKmIh
   jKMGHEHbTUXIr0fVWiSLSu3e4iqkBAh0X56B0uqRTfrlRuXGq4KiXcyEL
   4Iv8olqdoXTSaWG48JwZ5iIu4zn94i0z/iIYoTeZqGOqWOFoFPzzQmHjY
   RNWqdnT2PuHO6ovpM1RkJD1vmhnKHBpvqVZO8DjYG9XhygCdgs4zy12Zh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439739744"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="439739744"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 18:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="913030374"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="913030374"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 18:43:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
References: <20230810142942.3169679-1-ryan.roberts@arm.com>
        <20230810142942.3169679-4-ryan.roberts@arm.com>
        <87v8dg6lfu.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com>
Date:   Thu, 31 Aug 2023 09:40:52 +0800
In-Reply-To: <5c9ba378-2920-4892-bdf0-174e47d528b7@arm.com> (Ryan Roberts's
        message of "Wed, 30 Aug 2023 13:07:01 +0100")
Message-ID: <87cyz43s63.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Roberts <ryan.roberts@arm.com> writes:

> On 15/08/2023 22:32, Huang, Ying wrote:
>> Hi, Ryan,
>> 
>> Ryan Roberts <ryan.roberts@arm.com> writes:
>> 
>>> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
>>> allocated in large folios of a determined order. All pages of the large
>>> folio are pte-mapped during the same page fault, significantly reducing
>>> the number of page faults. The number of per-page operations (e.g. ref
>>> counting, rmap management lru list management) are also significantly
>>> reduced since those ops now become per-folio.
>>>
>>> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
>>> which defaults to disabled for now; The long term aim is for this to
>>> defaut to enabled, but there are some risks around internal
>>> fragmentation that need to be better understood first.
>>>
>>> Large anonymous folio (LAF) allocation is integrated with the existing
>>> (PMD-order) THP and single (S) page allocation according to this policy,
>>> where fallback (>) is performed for various reasons, such as the
>>> proposed folio order not fitting within the bounds of the VMA, etc:
>>>
>>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>>> ----------------|-----------|-------------|---------------|-------------
>>> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
>>> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
>>> MADV_NOHUGEPAGE | S         | S           | S             | S
>> 
>> IMHO, we should use the following semantics as you have suggested
>> before.
>> 
>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>> ----------------|-----------|-------------|---------------|-------------
>> no hint         | S         | S           | LAF>S         | THP>LAF>S
>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S           | S             | S
>> 
>> Or even,
>> 
>>                 | prctl=dis | prctl=ena   | prctl=ena     | prctl=ena
>>                 | sysfs=X   | sysfs=never | sysfs=madvise | sysfs=always
>> ----------------|-----------|-------------|---------------|-------------
>> no hint         | S         | S           | S             | THP>LAF>S
>> MADV_HUGEPAGE   | S         | S           | THP>LAF>S     | THP>LAF>S
>> MADV_NOHUGEPAGE | S         | S           | S             | S
>> 
>> From the implementation point of view, PTE mapped PMD-sized THP has
>> almost no difference with LAF (just some small sized THP).  It will be
>> confusing to distinguish them from the interface point of view.
>> 
>> So, IMHO, the real difference is the policy.  For example, prefer
>> PMD-sized THP, prefer small sized THP, or fully auto.  The sysfs
>> interface is used to specify system global policy.  In the long term, it
>> can be something like below,
>> 
>> never:      S               # disable all THP
>> madvise:                    # never by default, control via madvise()
>> always:     THP>LAF>S       # prefer PMD-sized THP in fact
>> small:      LAF>S           # prefer small sized THP
>> auto:                       # use in-kernel heuristics for THP size
>> 
>> But it may be not ready to add new policies now.  So, before the new
>> policies are ready, we can add a debugfs interface to override the
>> original policy in /sys/kernel/mm/transparent_hugepage/enabled.  After
>> we have tuned enough workloads, collected enough data, we can add new
>> policies to the sysfs interface.
>
> I think we can all imagine many policy options. But we don't really have much
> evidence yet for what it best. The policy I'm currently using is intended to
> give some flexibility for testing (use LAF without THP by setting sysfs=never,
> use THP without LAF by compiling without LAF) without adding any new knobs at
> all. Given that, surely we can defer these decisions until we have more data?
>
> In the absence of data, your proposed solution sounds very sensible to me. But
> for the purposes of scaling up perf testing, I don't think its essential given
> the current policy will also produce the same options.
>
> If we were going to add a debugfs knob, I think the higher priority would be a
> knob to specify the folio order. (but again, I would rather avoid if possible).

I totally understand we need some way to control PMD-sized THP and LAF
to tune the workload, and nobody likes debugfs knob.

My concern about interface is that we have no way to disable LAF
system-wise without rebuilding the kernel.  In the future, should we add
a new policy to /sys/kernel/mm/transparent_hugepage/enabled to be
stricter than "never"?  "really_never"?

--
Best Regards,
Huang, Ying
