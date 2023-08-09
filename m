Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6142577592F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjHIK6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjHIK6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:58:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DF1FF9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691578700; x=1723114700;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VfEV/g4BYLMFSmQMtdobIwp2qdeqXTAh5Riv2DiGEVU=;
  b=b3gckT2127HmK21zGAHjNh6KS1ojU+YLmDRT17ZhWKQcR7fgsdcSVvTZ
   +aiDQl2tMlLxdRiMakwiZ7JJqGh1zRaBPYjicXG7Z6bxSUeegCu1JK6h+
   qS6aM010BqPnqhX0hXO29Xgw387i5pbwkTwSXwYUUZ6Aj771n3FGXQveo
   4E2KGchCm9p7GzQo6drtouK90lVtaauJEogcVwf/ncC/6m8vnGle5faGQ
   lKeYxTqG20hfGvDpoFUSqAG2H4iWbcx3qBr152sLku/a8SG3dO9en8mw8
   E2QtOJvkyT/4iNde2nV1k4/gm/tv+pUgG8nogNvGiTIWkmdUcWJ24ISra
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437457747"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="437457747"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:58:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801706808"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="801706808"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.171]) ([10.254.210.171])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 03:58:18 -0700
Message-ID: <c0e94e88-94b8-69de-69c8-ed132ae28951@linux.intel.com>
Date:   Wed, 9 Aug 2023 18:58:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] iommu: Call helper function to get assigned pasid
 value
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michael Shavit <mshavit@google.com>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-3-tina.zhang@intel.com>
 <f3d8692e-b13d-97ee-2288-c2be1858dcfa@linux.intel.com>
 <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767F29A6C11157659D375B8C12A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/9 17:49, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, August 9, 2023 8:22 AM
>>
>> On 2023/8/8 15:49, Tina Zhang wrote:
>>> Use the helper function mm_get_pasid() to get the mm assigned pasid
>>> value.
>>
>> For internal iommu drivers, perhaps we should use another helper.
>> Something like sva_domain_get_pasid()?
>>
>> Suppose that the iommu drivers should have no idea about the "mm".
>>
> 
> Aren't all touched functions accept a struct mm_struct pointer?

In the end we should remove all mm reference in the individual drivers.
The drivers only need to know what they need to know. All mm-aware code
should eventually be moved to the core.

For now, at least we should avoid using mm in the set/remove_dev_pasid
code path. Later, once we complete consolidating mm notification in the
core, drivers will have no need to use "mm" anymore.

Best regards,
baolu
