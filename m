Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8551F7FE7CD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344291AbjK3Dsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjK3Dsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:48:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03D9D66
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 19:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316127; x=1732852127;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xC3dwYlDuD1hlwFCoRdZoguQbZrD/kr1AFHDGZNT2y0=;
  b=fLXAm5FiX8W6//bp1eU5ySP12/Cm/YkYIVuM8eVYajoYF2cp8rD7Zwgk
   /8AkS7WmZkPeUtZJD1UxJdr6w3/wk+hla++acwlMB366WWUaG2YdjF5Eh
   sdBSUltZM34h8igpBI8ZsXqNaih3Xuy+BD4OC7TIZkDJpsBMdqGdvvQKZ
   mdT6anxrGR+WdgsUy/P0vNVSEoG64s44j3GNdEmJF+qPdOKfwYLnNI9h+
   VbyGHd0kSUg2JdPIZ/u2mXvu+yffGJ9/koo+HKF3V4HhTlEtKbv9jzlFp
   ep3TF/vTebyol02akwcb8y1wA9vZ2fKwFj4FJzqvYIYh6/KVPXZIMmlIM
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="373447806"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="373447806"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:48:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1100780499"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1100780499"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:48:45 -0800
Message-ID: <07f6d0f1-0b3d-486a-a26b-483874a93b24@linux.intel.com>
Date:   Thu, 30 Nov 2023 11:48:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Support enforce_cache_coherency only for
 empty domains
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231129200834.GJ1312390@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231129200834.GJ1312390@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/30 4:08, Jason Gunthorpe wrote:
> On Tue, Nov 14, 2023 at 09:10:33AM +0800, Lu Baolu wrote:
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 65d37a138c75..ce030c5b5772 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -602,6 +602,9 @@ struct dmar_domain {
>>   					 */
>>   	u8 dirty_tracking:1;		/* Dirty tracking is enabled */
>>   	u8 nested_parent:1;		/* Has other domains nested on it */
>> +	u8 has_mappings:1;		/* Has mappings configured through
>> +					 * iommu_map() interface.
>> +					 */
> Is it racey?
> 
> The other option is to make iommfd do this and forbid it from
> switching the enforce_cache_coherency if the IOAS has any maps
> attached. We can get the correct locking at that point.
> 
> AMD has the same issue if it ever wants to implement its per-PTE bit

Yes. It's better to do this in iommufd. With that done, we can then
remove this code.

Best regards,
baolu
