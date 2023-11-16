Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207977EDBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 08:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344845AbjKPHZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 02:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjKPHZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 02:25:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98718C5;
        Wed, 15 Nov 2023 23:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700119497; x=1731655497;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xzxCiQMFYJij7t6O0mSmHnDg/h78ww1UnMJV0w34NHk=;
  b=YPCM3aHrcAuyxC5ziUn2rSN2x+AAuWPDU/SH7P/2atink8PBh19efYHt
   6Rrp3hQdUfuY3mTzMpF+WXWHT1Zmk/vDM17uYKFD+NVnZqJL7or2LS0X9
   TiqFZCr8Q1qo6BCXA/yJ91ryggbxxZMDGJozeoD4hjTBGq7gs6/RsOtTJ
   kZqD+wPUBDAEXgDFxJK03XyZKokJp4jcnUtWjBXTkfy8DkWMb/1X7kb6m
   g6d3e420BuhVN92i1KMVjmYtxf7nh7Pd1YeHSHuWVxAPAMzjSJ8lQgvkO
   wRGl38okPvRvCisQathMpMSjoiioT0MzzRjHOya9CXd4lGe7s3EgnGHzY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="422124648"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="422124648"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938757177"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="938757177"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.199]) ([10.255.31.199])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 23:24:54 -0800
Message-ID: <b825e828-6dff-4064-896e-df4de24aa6d6@linux.intel.com>
Date:   Thu, 16 Nov 2023 15:24:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Abdul Halim, Mohd Syazwan" <mohd.syazwan.abdul.halim@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add MTL to quirk list to skip TE
 disabling
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
References: <20231116022324.30120-1-baolu.lu@linux.intel.com>
 <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527667F09E2FAD729AE2BC2C8CB0A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/16 11:27, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, November 16, 2023 10:23 AM
>>
>> From: "Abdul Halim, Mohd Syazwan"
>> <mohd.syazwan.abdul.halim@intel.com>
>>
>> The VT-d spec requires (10.4.4 Global Command Register, TE field) that:
>>
>> Hardware implementations supporting DMA draining must drain any in-flight
>> DMA read/write requests queued within the Root-Complex before
>> completing
>> the translation enable command and reflecting the status of the command
>> through the TES field in the Global Status register.
> 
> this talks about 'enable'...
> 
>>
>> Unfortunately, some integrated graphic devices fail to do so after some
>> kind of power state transition. As the result, the system might stuck in
>> iommu_disable_translation(), waiting for the completion of TE transition.
> 
> ...while this fixes 'disable'. wrong citation?

Right. It's confusing. I will change it to below.

"
...before switching address translation on or off and reflecting the
status of the command through the TES field in the Global Status
register.
"

> 
>> @@ -5080,7 +5080,7 @@ static void quirk_igfx_skip_te_disable(struct
>> pci_dev *dev)
>>   	ver = (dev->device >> 8) & 0xff;
>>   	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
>>   	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
>> -	    ver != 0x9a && ver != 0xa7)
>> +	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
>>   		return;
>>
> 
> this fix alone is fine, but I found this quirk overall is not cleanly handled.
> 
> Basically it sets iommu_skip_te_disable as true, leading to early return
> in iommu_disable_translation():
> 
> 	if (iommu_skip_te_disable && iommu->drhd->gfx_dedicated &&
> 	   (cap_read_drain(iommu->cap) || cap_write_drain(iommu->cap)))
> 		return;
> 
> However the caller of iommu_disable_translation() is not aware of this
> quirk and continues as if the iommu is disabled. IMHO this is problematic
> w/o meeting the caller's assumption.
> 
> e.g. kdump and suspend. We may want to abort those paths early in case
> of such quirk...

I can see your point.

This fix is just to add a new device model to the established quirk
list. All devices (including the new one) in this quirk list have
undergone thorough verification. Therefor, I'd like to keep it as-is.

We can refine the quirk implementation in a separated patch series with
sufficient consideration and verification. Does this work for you?

Best regards,
baolu
