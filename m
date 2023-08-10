Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E701776D90
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 03:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjHJBhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 21:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjHJBhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 21:37:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E91724
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 18:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691631434; x=1723167434;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=D6M/kMPtxQ6zaM/g8+1a+dQ8Yi3fC4ce3oeCDNqH8+o=;
  b=FhqDPmU1IC0rhbY2y3XB7Y+s7n1qdfZYxLBnwunAHtFsF2UASAhCW9d1
   KPzLLRP4uellB5FEfgCtzDK9cAbH5CS1SH0eaN9wXfNuhrFb/Tn40FZk7
   vWMf05+Rzv5L+4vxm3e30E0RVlpd3sbV+fP+Ewv3WS45NVArs84l8EL/t
   H9ig1Pq+7VqwBI0dikWJ/V+P5e3/QKl5hzjKTYE7XG1ST2NZvkSXfnjcF
   Hub85VTnsrXtS/5TbkSL7SVUyYQMGTkApiBjIhjYXKKWCkJcmX1oi+Nt6
   SoHPdfuPgBHLMnEnHcf2VizOl6EwsOlF8oLWS9ONznn19v610Dz197vCC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="371267215"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="371267215"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:37:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="681905093"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="681905093"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.214.239]) ([10.254.214.239])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 18:37:12 -0700
Message-ID: <84494c88-66eb-a731-fbf0-4a83fb9102f1@linux.intel.com>
Date:   Thu, 10 Aug 2023 09:37:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Michael Shavit <mshavit@google.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
 <ZNOnOGTfpXzrrRTz@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNOnOGTfpXzrrRTz@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 22:48, Jason Gunthorpe wrote:
> On Wed, Aug 09, 2023 at 06:58:15PM +0800, Baolu Lu wrote:
>> On 2023/8/9 17:49, Tian, Kevin wrote:
>>>> From: Baolu Lu <baolu.lu@linux.intel.com>
>>>> Sent: Wednesday, August 9, 2023 8:22 AM
>>>>
>>>> On 2023/8/8 15:49, Tina Zhang wrote:
>>>>> Use the helper function mm_get_pasid() to get the mm assigned pasid
>>>>> value.
>>>>
>>>> For internal iommu drivers, perhaps we should use another helper.
>>>> Something like sva_domain_get_pasid()?
>>>>
>>>> Suppose that the iommu drivers should have no idea about the "mm".
>>>>
>>>
>>> Aren't all touched functions accept a struct mm_struct pointer?
>>
>> In the end we should remove all mm reference in the individual drivers.
>> The drivers only need to know what they need to know. All mm-aware code
>> should eventually be moved to the core.
>>
>> For now, at least we should avoid using mm in the set/remove_dev_pasid
>> code path. Later, once we complete consolidating mm notification in the
>> core, drivers will have no need to use "mm" anymore.
> 
> I'm not sure how this will play out...
> 
> We don't want extra function indirections here so ultimately the
> driver needs to hook the arch_invalidate_range() in the mm_notifier
> with its own function.

Agreed. Given the mm notification callback is a performance path, an
extra indirection call here is not good.

> 
> The core could put the mm_notifier in a common iommu_domain_sva struct
> and it could stick in the driver's invalidate ops, that would be a
> nice simplification (and discourage drivers from doing the crazy
> things they are currently doing)

Yes. So the iommu driver can retrieve the sva domain from struct
mmu_notifier. The callback implementation will still be domain centric.
Hence, there will be no need to use mm.

Best regards,
baolu

