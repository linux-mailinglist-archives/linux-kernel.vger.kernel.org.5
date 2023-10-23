Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235CF7D28EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 05:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbjJWDNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWDNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 23:13:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B9AD
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 20:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698030797; x=1729566797;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AeWTtkCsGMX/D1evCPohfI5Y/jQTw5z4QJVr/hc1lsY=;
  b=N8AnDAa+ugimiEowmqdXhv3if6CgwfDocfTj8R8RhRSACqAP71gPpf9o
   VRfIs8+rgoyo5jmYTl2z1xgYHlUWT7R6H8BcIjDlUy9OH3aSYob2FwJl9
   JLDG1KYSGa1UUN8WEFT7B/B6JXcdRKpmXhN+8jdFdWzRYFCBQb39COURB
   aAPydZLNfxAvCux2UgGP406OftghXtpp+CRmCv4T/pN6HdC44zmSXjAWd
   FGqmaCbS9Nb3Dwg4LptFjUPY6cSftdpvU/1Bl1q7gZeRI6wtA97jWc3Xl
   6Y2enel7AeAFk25eslwZ+YMa0KQAnV+xF43m+wv7NLpz3nmRgU+SFlrc0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="389604102"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="389604102"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 20:13:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="5932824"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 22 Oct 2023 20:13:09 -0700
Message-ID: <400f2708-1186-4ca4-b4db-dc46b9e636b2@linux.intel.com>
Date:   Mon, 23 Oct 2023 11:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH 0/2] iommufd: Only enforce_cache_coherency when allocating
 hwpt
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>
References: <cover.1697848510.git.nicolinc@nvidia.com>
 <2201ae4d-b825-49a5-ba73-c6b310e2969c@linux.intel.com>
 <BL1PR11MB5271F7BEA6187ACBD6BA88568CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271F7BEA6187ACBD6BA88568CD8A@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 10:55 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Saturday, October 21, 2023 9:33 AM
>>
>> On 2023/10/21 8:37, Nicolin Chen wrote:
>>> https://lore.kernel.org/linux-
>> iommu/20231020135501.GG3952@nvidia.com/
>>> The conversation above concluded that a hwpt should only enforce cache
>>> coherency per device at the stage of its allocation, and it should not
>>> be changed or updated in the attach/replace routines.
>>>
>>> Add two patches dropping the enforce_cache_coherency calls from attach
>>> and replce routines respectively, since they were introduced with two
>>> different commits.
>>>
>>> Nicolin Chen (2):
>>>     iommufd/device: Drop enforce_cache_coherency in
>>>       iommufd_device_do_replace
>>>     iommufd/device: Drop enforce_cache_coherency in
>>>       iommufd_hw_pagetable_attach
>>>
>>>    drivers/iommu/iommufd/device.c          | 19 ++-----------------
>>>    drivers/iommu/iommufd/hw_pagetable.c    |  2 +-
>>>    drivers/iommu/iommufd/iommufd_private.h |  1 -
>>>    3 files changed, 3 insertions(+), 19 deletions(-)
>>
>> Hi Kevin and Jason,
>>
>> With these two fixes, there's no issue in the intel driver any more. Do
>> I understand it right?
>>
> 
> But code-wise it's still good to explicitly disallow enforce-cc on a
> non-empty domain if there is no plan to support it. Just no Fix to
> stable.

Yes. Make sense. The device driver implementation should be self-
contained.

Best regards,
baolu
