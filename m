Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E075317A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjGNFrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjGNFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:47:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D1D2D41
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689313647; x=1720849647;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M2Op5B60rK/IAOYu+Mr1yoo/u96NcZpWns/Z2ATpcG8=;
  b=nmsJVqNNz/9rPsfPnXDJQ4ShEtXa5L2+2mhC7n+kDjrkSKXKh2CVa3l1
   s3EsttqsI4GSoAmP7+uCz3dWB06SzTg1NrU4fYdtNpEcqbR4Bm2m8yI7l
   vobVPzl8GjhcFVK6ojLU+qiAZtMrdY94vPsQurYNpSbjWKZOwRTk1HJZm
   IscXhsg1K18ZG5h3aF5qsBsxBrN6WW/AwLD95WrY8oOi+LJDce0dpmlv2
   dGE5aN/XwyfWvn2LCj0pgvIteWZYIi2bCPJZI4W9aEYfCB5/O8Ytd72ae
   fIbbom1fLBybLWSR1BUFTf4Cjs7X12/dJrPx4ROHnpgldmGgDWvRd2cb6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429162334"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="429162334"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:47:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787720793"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="787720793"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.116]) ([10.252.187.116])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 22:47:21 -0700
Message-ID: <29fa2860-cbf2-04c8-4d16-138668ffea25@linux.intel.com>
Date:   Fri, 14 Jul 2023 13:47:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 5/7] iommu/vt-d: Make prq draining code generic
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-6-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB52761F5CDE22E5C3C10E7E728C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <9875863a-eba5-c8fa-a39b-7d3300e3b5ca@linux.intel.com>
 <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763423F2A18E927065C8EA8C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/14 11:49, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 14, 2023 11:28 AM
>>
>> On 2023/7/13 15:49, Tian, Kevin wrote:
>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Sent: Thursday, July 13, 2023 12:34 AM
>>>>
>>>> -	/* Domain type specific cleanup: */
>>>>    	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>>>> -	if (domain) {
>>>> -		switch (domain->type) {
>>>> -		case IOMMU_DOMAIN_SVA:
>>>> -			intel_svm_remove_dev_pasid(dev, pasid);
>>>> -			break;
>>>> -		default:
>>>> -			/* should never reach here */
>>>> -			WARN_ON(1);
>>>> -			break;
>>>> -		}
>>>> +	if (!domain)
>>>> +		goto out_tear_down;
>>>
>>> WARN_ON()
>>
>> Why?
>>
>> My understanding is that remve_device_pasid could be call in any context
>> including no domain attached.
>>
> 
> oh I'm not aware of that. Can you elaborate the usage which uses a pasid
> w/o domain? pasid needs to point to a page table. Presumably every
> page table should be wrapped by a iommu domain...

A case I can think of is error rewinding. A domain is being attached to
multiple pasids. When one of them is failed, remove_device_pasid should
be called on all pasids so that they are parked at a determinant state.

On the other hand, I don't want the remove_device_pasid to be the
counterpart of attach_dev_pasid. remove_device_pasid simply denotes:

- The pasid will be parked in blocking state;
- If any domain that has been attached to this pasid, stop reference to
   it any more. Otherwise, there might be use-after-free issues.

Hence, remove_device_pasid should never fail.

Best regards,
baolu
