Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05AE7A59CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 08:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjISGN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 02:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjISGN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:13:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C6A115
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695104000; x=1726640000;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=tuzhrLzSWbdbRydP4kaLVjeVbY9OnSWu+GN5+6pY18A=;
  b=K/XnNrEGFtJQm5kw2evC0kZKJnY56jX+7dEhvhdMXwpcDN6+ujgh3IA+
   CNhCER5i+gBDnJWn7PlNdVvnF/DqABNBRrYaEfCCiOYE8upSnZ5E1Mou0
   mU+5/narJ3TIUOCr07CwDiaQUR2lGaoUUtei8iyltmlQb+V51EEmA/hHh
   rWIOkUmmCvJ71TNo2KgTrJVL8ZP9itChWDrMpyda53AkptcuJCa0wiSiu
   6Sk3tO69og845QU4v1HQyGgkBIM5HZDZn45j1XdTwKohuTMJxQNiZQabv
   b+alRNJpyp3In0f/i7FdAcMDSecEwqvXzO5wLjLiyKfoQn7Ip8MP3xar+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="370176610"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="370176610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 23:13:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811607597"
X-IronPort-AV: E=Sophos;i="6.02,158,1688454000"; 
   d="scan'208";a="811607597"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 23:13:15 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH -V3 3/4] acpi, hmat: calculate abstract distance with HMAT
References: <20230912082101.342002-1-ying.huang@intel.com>
        <20230912082101.342002-4-ying.huang@intel.com>
        <8734za6869.fsf@nvdebian.thelocal>
Date:   Tue, 19 Sep 2023 14:11:11 +0800
In-Reply-To: <8734za6869.fsf@nvdebian.thelocal> (Alistair Popple's message of
        "Tue, 19 Sep 2023 15:14:10 +1000")
Message-ID: <87y1h2wv40.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Popple <apopple@nvidia.com> writes:

> Thanks for making changes here, looks better to me at least.
>
> Huang Ying <ying.huang@intel.com> writes:
>
>>  static __init void hmat_free_structures(void)
>>  {
>>  	struct memory_target *target, *tnext;
>> @@ -801,6 +857,7 @@ static __init int hmat_init(void)
>>  	struct acpi_table_header *tbl;
>>  	enum acpi_hmat_type i;
>>  	acpi_status status;
>> +	int usage;
>>  
>>  	if (srat_disabled() || hmat_disable)
>>  		return 0;
>> @@ -841,7 +898,10 @@ static __init int hmat_init(void)
>>  	hmat_register_targets();
>>  
>>  	/* Keep the table and structures if the notifier may use them */
>> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
>> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
>> +	if (!hmat_set_default_dram_perf())
>> +		usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
>> +	if (usage)
>>  		return 0;
>
> Can we simplify the error handling here? As I understand it
> hotplug_memory_notifier() and register_mt_adistance_algorithm() aren't
> expected to ever fail because hmat_init() should only be called once and
> the notifier register shouldn't fail. So wouldn't the below be
> effectively the same thing but clearer?
>
>     if (hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
>         goto out_put;
>        
>     if (!hmat_set_default_dram_perf())
>         register_mt_adistance_algorithm(&hmat_adist_nb);
>
>     return 0;
>
>>  out_put:
>>  	hmat_free_structures();

Looks good to me!  Will do that in the next version!

> Also as an aside while looking at this patch I noticed a minor bug:
>
> 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> 	if (ACPI_FAILURE(status))
> 		goto out_put;
>
> This will call acpi_put_table(tbl) even though we failed to get the
> table.

Thanks for pointing this out.  This should go through ACPI tree.  So
will not do this in a separate patch.

--
Best Regards,
Huang, Ying
