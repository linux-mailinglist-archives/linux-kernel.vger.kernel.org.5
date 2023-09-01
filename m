Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA978F787
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbjIADth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 23:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjIADtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 23:49:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72E118C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693540172; x=1725076172;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IKgliyYsZBOt/5slqlK6kb0NHXmTvEoj0dV9Nk9W4VU=;
  b=RpacshVhNsQZBS0XqUpPXlyNj7yOaJQtA31KOs8EGPbMkXsAiIbyG2/f
   QktMgXbAnwB2cEqaD6H62nKNucpG3WpX3gpXDd+MY2imx2JvT2SZM8/2Z
   rZPsR58lt3TPrR2dDZwWQI/OdeJa91Rc7gBX45jFOPDx2h0qah9U7hfPQ
   XeVAs5GQN8bCgJu6x0So49Ya1lqpYHUur6dOroB8jY31cfNUi3ryAlnrV
   m8qNlZCCDFr6dFx4z/vk6RkM23XGjYfA3cFeqrK+Q4cxmkRyUBBVpGkjd
   Qvcj47ajrW8zLQk0zg0Ncq6e0Fh+TngjihXCPcIEoq69FaIdFinopMO9c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376062330"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="376062330"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:49:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="829974270"
X-IronPort-AV: E=Sophos;i="6.02,218,1688454000"; 
   d="scan'208";a="829974270"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.30.41]) ([10.255.30.41])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 20:49:29 -0700
Message-ID: <1bc23b15-b851-7c9f-06df-db1396980641@linux.intel.com>
Date:   Fri, 1 Sep 2023 11:49:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mm: Add structure to keep sva information
Content-Language: en-US
To:     "Zhang, Tina" <tina.zhang@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-4-tina.zhang@intel.com>
 <92bceb62-b33f-2380-9229-af9634b12c95@linux.intel.com>
 <MW5PR11MB58812C6D52210A9A66A79C1689E4A@MW5PR11MB5881.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <MW5PR11MB58812C6D52210A9A66A79C1689E4A@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/1 11:36, Zhang, Tina wrote:
>> -----Original Message-----
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Thursday, August 31, 2023 10:45 AM
>> To: Zhang, Tina<tina.zhang@intel.com>; Jason Gunthorpe<jgg@ziepe.ca>;
>> Tian, Kevin<kevin.tian@intel.com>; Michael Shavit<mshavit@google.com>
>> Cc:baolu.lu@linux.intel.com;iommu@lists.linux.dev; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH v2 3/5] mm: Add structure to keep sva information
>>
>> On 2023/8/27 16:43, Tina Zhang wrote:
>>> Introduce iommu_mm_data structure to keep sva information (pasid and
>>> the related sva domains). Add iommu_mm pointer, pointing to an
>>> instance of iommu_mm_data structure, to mm.
>>>
>>> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
>>> ---
>>>    include/linux/iommu.h    | 5 +++++
>>>    include/linux/mm_types.h | 2 ++
>>>    2 files changed, 7 insertions(+)
>> Nit:
>>
>> iommu also has a per-device private pointer, it's defined as struct dev_iommu
>> and stored at dev->iommu. Is it valuable to align both?
> I'm not sure if I understand the idea correctly. This struct dev_iommu is used to describe a collection per-device IOMMU data. Is the idea about migrating some bits from this struct dev_iommu to iommu_mm_data structure?

Never mind. I just thought about this when I was reading the patch. This
does not constitute any suggestion.

Best regards,
baolu
