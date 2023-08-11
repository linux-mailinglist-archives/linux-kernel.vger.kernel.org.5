Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861D077876F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjHKG2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjHKG2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:28:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD9530CB;
        Thu, 10 Aug 2023 23:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691735280; x=1723271280;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=i2XmOYyi458NTdNnXT+FMHr0f2pdEK7kxaOKn4OXpSk=;
  b=n/VI2RtVie6ughm0fu/kvQ2yNZFwdJ/5bbsjK9E/MHjtaEF2eAGV0zio
   0I6zDRRUumzryiY2tL4RROaOazVlw60Y6gdqMi1oUgs2zgmXMkbuuhvDZ
   sVanJGc99+Iso6RS71kvWnr2ss0iGWaWnVc5qoiwZGl+j2HJ+DSi+8Gbw
   4Y1KyNWR5NDoew9yeoRJoDudwKXdkVXNNLMd4t5kMeBfSb6UN7ljmUk0O
   beIBcctmz9OC+MXz/qZAWmaix32ECVz0O4VmZJ6bwANrWlM2CtK0RIDmO
   Bbi/+8HcLmB/NkbKJsm8WPxTJLfX5aNO6TJpA836Os/Gg44usqBOkNI8O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437946042"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="437946042"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 23:27:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="767561748"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="767561748"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 23:27:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Bharata B Rao <bharata@amd.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH RESEND 0/4] memory tiering: calculate abstract distance
 based on ACPI HMAT
References: <20230721012932.190742-1-ying.huang@intel.com>
        <875y6dj3ok.fsf@nvdebian.thelocal>
        <20230724105818.6f7b10fc8c318ea5aae9e188@linux-foundation.org>
        <6c8ed42d-ea71-c11e-2689-c4fc23845ccf@amd.com>
Date:   Fri, 11 Aug 2023 14:26:17 +0800
In-Reply-To: <6c8ed42d-ea71-c11e-2689-c4fc23845ccf@amd.com> (Bharata B. Rao's
        message of "Tue, 1 Aug 2023 08:05:00 +0530")
Message-ID: <87il9mccxi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rao,

Bharata B Rao <bharata@amd.com> writes:

> On 24-Jul-23 11:28 PM, Andrew Morton wrote:
>> On Fri, 21 Jul 2023 14:15:31 +1000 Alistair Popple <apopple@nvidia.com> wrote:
>> 
>>> Thanks for this Huang, I had been hoping to take a look at it this week
>>> but have run out of time. I'm keen to do some testing with it as well.
>> 
>> Thanks.  I'll queue this in mm-unstable for some testing.  Detailed
>> review and testing would be appreciated.
>
> I gave this series a try on a 2P system with 2 CXL cards. I don't trust the
> bandwidth and latency numbers reported by HMAT here, but FWIW, this patchset
> puts the CXL nodes on a lower tier than DRAM nodes.

Thank you very much!

Can I add your "Tested-by" for the series?

--
Best Regards,
Huang, Ying
