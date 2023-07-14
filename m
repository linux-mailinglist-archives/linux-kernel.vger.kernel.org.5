Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE77531A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjGNGBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbjGNGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:00:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BAD3598
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689314420; x=1720850420;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UXRTaxPUMTttyEK6k/XZG4rdkxjidqSuECmGEg2DEto=;
  b=Vu5srnwNBqeM8Y2+4V+nP3CZ2EhJclJMMrg3U9Lgw/Q6UxAAfqPDd5/T
   xISFY44VsYh3yGXgbqZ/ph7LhbZy/e5EWa2goNUul5+71pSvy59O2IdVt
   vkCvcv14yZkGvspTih8NugPQI45KdpmAjUN7vV8emsuxFPUb3adzBqHpE
   pBkZvzPj9QcoDe8umz17gWBxOvwZKGV6VikO85eMVhBG394EZi7dnca4M
   OIyKwxehOADEyxRr1o84xNRuXruIY6F4JTNqOUBHc2JnzHeyY3zDLCd0t
   Yw4BLisIJzk+Dw4xafViyVFOEvENKfcOsDcVFZIcuSxgc2ZTSSfQZGjI9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="368949762"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="368949762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="835910869"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="835910869"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.187.116]) ([10.252.187.116])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 23:00:14 -0700
Message-ID: <2a103a6d-af9f-456d-eda4-f1e15f8367b6@linux.intel.com>
Date:   Fri, 14 Jul 2023 14:00:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Will Deacon <will@kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH v10 6/7] iommu/vt-d: Add set_dev_pasid callback for dma
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230712163355.3177511-1-jacob.jun.pan@linux.intel.com>
 <20230712163355.3177511-7-jacob.jun.pan@linux.intel.com>
 <BN9PR11MB5276C14341AC7CE6D352948F8C37A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87e78302-9f69-8db1-8a0a-b40e1f29d9c6@linux.intel.com>
 <BN9PR11MB5276E0C6F1063E581F29BB978C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276E0C6F1063E581F29BB978C34A@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/7/14 11:50, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Friday, July 14, 2023 11:34 AM
>>
>> On 2023/7/13 15:56, Tian, Kevin wrote:
>>>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>>> Sent: Thursday, July 13, 2023 12:34 AM
>>>>
>>>>
>>>> -	/*
>>>> -	 * Should never reach here until we add support for attaching
>>>> -	 * non-SVA domain to a pasid.
>>>> -	 */
>>>> -	WARN_ON(1);
>>>> +	dmar_domain = to_dmar_domain(domain);
>>>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>>>> +	list_for_each_entry(curr, &dmar_domain->dev_pasids, link_domain)
>>>> {
>>>> +		if (curr->dev == dev && curr->pasid == pasid) {
>>>> +			list_del(&curr->link_domain);
>>>> +			dev_pasid = curr;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>>
>>>
>>> what about no matching dev_pasid is find?
>>
>> kfree() can handle this gracefully.
> 
> but what about domain_detach_iommu()? Is it correct to adjust
> the refcnting when there is no matching dev_pasid?

You are right.

Logically, if we get a valid domain for a pasid, we should have a
dev_pasid allocated for it. Perhaps, adding a check in the code will
make the code more readable?

Best regards,
baolu
