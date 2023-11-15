Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6A7EBB01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjKOBsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOBsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:48:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B26FD2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700012889; x=1731548889;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3b1ta+crUkN2gJb/DV0hyx/sd1rL21WhPmKOJHaL9Q8=;
  b=Ow+8NlPJ8u8cJza/0Abi4ZK1F0OKcaRZjeCetMur5Tv01K26YyHAHDdN
   TRaJD6DVLPY4aUXD0JIgQM6GUE1LraGs3f3MDFIEMqt+sQoTw9wztZ7tu
   uqM5FvqAOTO0meRson4IQ0lATuzE5szfpa7edXMojPLvPe5EJlzgp/OZb
   FmlrHBvOoxwctO/Zm89X4/OCSMDs0fyLUfjKxvc6XC3Lx3+Z5JEToPewT
   zsbnDC3mOSoMEmEOSTxSbxWDE0mmWAXnnBW/W5MQRzEURGHLgRUm0af2o
   skW03LSvB1z46Z+hGMVeodHU0X/nL7jwJAJb4osJNVzS4qj0Z3fK4LFXU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394706178"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="394706178"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 17:48:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="764842001"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="764842001"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 17:48:04 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangpeng (AS)" <zhangpeng362@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <lstoakes@gmail.com>, <hughd@google.com>, <david@redhat.com>,
        <vbabka@suse.cz>, <peterz@infradead.org>, <mgorman@suse.de>,
        <mingo@redhat.com>, <riel@redhat.com>, <hannes@cmpxchg.org>,
        Nanyong Sun <sunnanyong@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [Question]: major faults are still triggered after mlockall
 when numa balancing
In-Reply-To: <c331d19a-d467-4b9d-81b0-e3f727d17ace@intel.com> (Fengwei Yin's
        message of "Tue, 14 Nov 2023 19:23:25 +0800")
References: <9e62fd9a-bee0-52bf-50a7-498fa17434ee@huawei.com>
        <ZU0WkMR1s7QNG9RZ@casper.infradead.org>
        <874jhugom8.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2c95d0d0-a708-436f-a9d9-4b3d90eafb16@intel.com>
        <87r0kufm15.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <c331d19a-d467-4b9d-81b0-e3f727d17ace@intel.com>
Date:   Wed, 15 Nov 2023 09:46:03 +0800
Message-ID: <87wmujeqlg.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Yin, Fengwei" <fengwei.yin@intel.com> writes:

> On 11/13/2023 10:02 AM, Huang, Ying wrote:
>>>> There are other places in the kernel where the PTE is cleared, for
>>>> example, move_ptes() in mremap.c.  IIUC, we need to audit all them.
>>>>
>>>> Another possible solution is to check PTE again with PTL held before
>>>> reading in file data.  This will increase the overhead of major fault
>>>> path.  Is it acceptable?
>>> What if we check the PTE without page table lock acquired?
>> The PTE is zeroed temporarily only with PTL held.  So, if we acquire the
>> PTL in filemap_fault() and check the PTE, the PTE which is zeroed in
>> do_numa_page() will be non-zero now.  So we can avoid the major fault.
> Yes.
>
>> 
>> But, if we don't acquire the PTL, the PTE may still be zero.
> For do_numa_page()/change_pte_range(), it does very limit thing during
> PTE is cleared. Considering the code path of do_read_fault(), it's likely
> the PTE is none-zero.

It's possible per my understanding, although it doesn't feel good to
depend on some "race" condition.

> My concern to acquiring lock is that it brings extra PTL lock acquire/release
> for other more common cases.

Yes.  It will bring some overhead to acquire the PTL.

Anyway, some performance test is needed to compare the solution.

--
Best Regards,
Huang, Ying
