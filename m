Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4306E7ACE78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjIYCvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIYCvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:51:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A7892
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695610298; x=1727146298;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f3Qva505MbhYBUkqg35a4hyrw/bQbmVNsOwPp+2TzvQ=;
  b=WgBrf0dmuElnmdzqFSAj8pzhu9s2yRg4kO9x1qLw3RBMlX8tz1mzr1xw
   /Pe/FH+Zl9xpoPlUI3l6N36mfXhfRMrjoly+Dz1bOm5zy4pbN5FgBucOE
   nGR7ICR7hdTLmqPq/pucbr/wMU1XqrXBHCtNC/N7h0UDyyqjtQxsu9Cof
   dg6XKcpueClTeCnkDzsF/RXpoDC0NKqEFCUAJ51T0xnjNbqFEdjtpWqO4
   uqJj2AK8KPzhLECNEt+c52FJ6FzDeHqbuDiKhvcbiSmQt7bw7Pxr3xn+Z
   jC2pa0H0eRWPWm+Elnt9/niAnkZc9tiXOtMO9qJpLkWw+u1CMpmvoAlkS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384982817"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="384982817"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:51:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995201896"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="995201896"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 24 Sep 2023 19:51:35 -0700
Message-ID: <42860c87-cf4d-0413-c3ae-b74ee9e7e5e6@linux.intel.com>
Date:   Mon, 25 Sep 2023 10:48:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica> <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
 <20230922233309.GI13795@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230922233309.GI13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/23 7:33 AM, Jason Gunthorpe wrote:
> On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:
> 
>> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
>> either; it sets it once it's discovered any instance, since apparently it's
>> assuming that all instances must support identical page sizes, and thus once
>> it's seen one it can work "normally" per the core code's assumptions. It's
>> also I think the only driver which has a "finalise" bodge but*can*  still
>> properly support map-before-attach, by virtue of having to replay mappings
>> to every new endpoint anyway.
> Well it can't quite do that since it doesn't know the geometry - it
> all is sort of guessing and hoping it doesn't explode on replay. If it
> knows the geometry it wouldn't need finalize...

The ultimate solution to this problem seems to be to add device pointer
to the parameter of ops->domain_alloc. So once the domain is allocated,
it is fully initialized. Attaching this domain to a device that is not
compatible will return -EINVAL, then the caller has to allocate a new
domain for this device.

I feel that this is not an AMD specific problem, other iommu drivers
will also encounter the similar problem sooner or later.

Best regards,
baolu
