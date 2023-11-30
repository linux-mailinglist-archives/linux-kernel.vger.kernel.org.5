Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FF7FE8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 07:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344585AbjK3GJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 01:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3GJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 01:09:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E616BB9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 22:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701324597; x=1732860597;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=od25jifz4eVRuBZX5AfB3lIKHX+oCAQS49YG9v4v83A=;
  b=OzYN5lndYI/Wun8azJuPeiQ6Q5qQi5LA59ELybXYrS6B+TnzY8TkOLhA
   tqkNo0S12nZlTgyLwC5xao70mCdCstRf+1DhBUTNQaOqtIRY1QzAE5n1v
   l4y9vG8k9RzfBxijrTbnRYuH9Oqbt2vKYor6lV0A6011LeRBlQGcL/Bfk
   T4IBJPM+QLQKeg88nkgGkT91Fm3nqZeUClfYPu3U2f23E3AvkvTbgsHKF
   j1kNyDdeaqDVfIJojL/CzzDZblDBiBLU5tEvDJ6rmyz1uqSb86mprOOvr
   7J9QBuYUEc3EFsvgdTCDVzocDoB7V78sHqb2IC870MK0g3xoH1SHNYulr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="154305"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="154305"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 22:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="913087219"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="913087219"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 22:09:54 -0800
Message-ID: <1af87099-ad52-4b34-a87c-f12925903a15@linux.intel.com>
Date:   Thu, 30 Nov 2023 14:09:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iommu/vt-d: Add support for static identity domain
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20231120112944.142741-1-baolu.lu@linux.intel.com>
 <20231120112944.142741-5-baolu.lu@linux.intel.com>
 <20231129202615.GN1312390@ziepe.ca> <20231129202851.GG436702@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129202851.GG436702@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/30 4:28, Jason Gunthorpe wrote:
> On Wed, Nov 29, 2023 at 04:26:15PM -0400, Jason Gunthorpe wrote:
>> On Mon, Nov 20, 2023 at 07:29:43PM +0800, Lu Baolu wrote:
>>
>>> @@ -2311,6 +2316,13 @@ static int device_def_domain_type(struct device *dev)
>>>   			return IOMMU_DOMAIN_IDENTITY;
>>>   	}
>>>   
>>> +	/*
>>> +	 * Hardware does not support the passthrough translation mode.
>>> +	 * Always use a dynamaic mapping domain.
>>> +	 */
>>> +	if (!ecap_pass_through(iommu->ecap))
>>> +		return IOMMU_DOMAIN_DMA;
>>> +
>> Doesn't this return from def_domain_type completely prevent using an
>> identity domain?
>>
>> I thought the point of this was to allow the identity domain but have
>> it be translating?
> I suppose the answer is the next patch deletes that stuff.
> 
> I would probably have structured this in the other order, first add
> this hunk and say that old HW is being de-supported. Remove all the
> now-dead code creating the 1:1 page table, then refactor the remainder
> to create the global static.

Okay, that would be more readable.

Best regards,
baolu
