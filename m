Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86287EA90B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjKNDRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:17:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806191
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 19:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699931870; x=1731467870;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jwo/jHiMXyVUADYct4D+5LfJifoti2Yg0Flyy8wZEW0=;
  b=JPpj15JlphtnOtQAJTkHSHfo4cWGHSBfGIM1rL7UCmtITP7BJt4AAFYr
   ehuy90KYmkmMj1c71Wj90kDVVJqTAFNoyCXcQjsaTivoYaiMobjF2nKWE
   Ch+pOzeoBqujpGjnJB/jFLCktaVNDoLYzsXG8fPmIp3IZvKtGoLRjfNAS
   pCvj5/OlpiiEZRRsURe5vQ8QdLLErOi1Gcohwbap8D8zjjcvrpkHgUgxW
   Bn+gs9xvppuxyemC8qj8CFXNCMVi+1pIjLCcNGYJq1eqCHgw8F8R1i0To
   tCWQTjGJZLTiT6BYWLdGtwk3Y7yl4AwGKjj3M7gBj2PETT1djDpOyw7vZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389424495"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389424495"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 19:17:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="758018670"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="758018670"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 13 Nov 2023 19:17:48 -0800
Message-ID: <1a07a265-f834-4834-b9cb-5c7016ee9142@linux.intel.com>
Date:   Tue, 14 Nov 2023 11:13:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Omit devTLB invalidation requests when
 TES=0
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231114011036.70142-1-baolu.lu@linux.intel.com>
 <20231114011036.70142-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764263BE04AAFAC0907A8D8CB2A@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 11/14/23 11:14 AM, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, November 14, 2023 9:11 AM
>>
>> The latest VT-d spec indicates that when remapping hardware is disabled
>> (TES=0 in Global Status Register), upstream ATS Invalidation Completion
>> requests are treated as UR (Unsupported Request).
>>
>> Consequently, the spec recommends in section 4.3 Handling of Device-TLB
>> Invalidations that software refrain from submitting any Device-TLB
>> invalidation requests when address remapping hardware is disabled.
>>
>> Verify address remapping hardware is enabled prior to submitting Device-
>> TLB invalidation requests.
>>
>> Fixes: 792fb43ce2c9 ("iommu/vt-d: Enable Intel IOMMU scalable mode by
>> default")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/dmar.c | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
>> index a3414afe11b0..23cb80d62a9a 100644
>> --- a/drivers/iommu/intel/dmar.c
>> +++ b/drivers/iommu/intel/dmar.c
>> @@ -1522,6 +1522,15 @@ void qi_flush_dev_iotlb(struct intel_iommu
>> *iommu, u16 sid, u16 pfsid,
>>   {
>>   	struct qi_desc desc;
>>
>> +	/*
>> +	 * VT-d spec, section 4.3:
>> +	 *
>> +	 * Software is recommended to not submit any Device-TLB
>> invalidation
>> +	 * requests while address remapping hardware is disabled.
>> +	 */
>> +	if (!(iommu->gcmd & DMA_GCMD_TE))
>> +		return;
>> +
> Is it a valid case to see such request when the iommu is disabled?
> If not then let's add a WARN.

There might be valid cases. The VT-d translation is turned on after all
devices get probed.

Best regards,
baolu
