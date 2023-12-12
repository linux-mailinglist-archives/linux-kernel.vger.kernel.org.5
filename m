Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A52C80E3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjLLF2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:28:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjLLF2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:28:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9790A2;
        Mon, 11 Dec 2023 21:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702358891; x=1733894891;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LCn4/xvODPorX9mTjeGLTue7GovKBlpADEjiJxDVln0=;
  b=gEBhMSHcFEskrkVLKBhzyoQ267f3votmpnQDy6DEj2U23I1T2Fv6LJ/A
   Cj0COUBJxY6RujJ4NZIQGo9lGpsJXdzm3EeMAU5XSiWJfHfqgSnMtdZWL
   843Y3GJZJ0kP8xsi74ijF8WoVoo+bCwH6Auh9LjjAbh7cgcApk78Zm11W
   FmcHShbZbIEK006s3BxcdCekX0CACl0O5yjK3mnmZBSTBnKydZvtqlxwd
   nDsvE07lnTllTUQLhU8UxilOS/3O6GA+UIK8TYtQIvDy424Fe0yljPJOF
   H6J+UBp3pkvHtsx5o4Xh33V446krrGWyKOhSKOgrIec4i2UL9ZNZV7NHf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="393626925"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="393626925"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 21:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="807612687"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="807612687"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2023 21:28:07 -0800
Message-ID: <d95e9104-e518-4aa5-8dd8-b6b7fd2294b6@linux.intel.com>
Date:   Tue, 12 Dec 2023 13:23:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231211152456.GB1489931@ziepe.ca>
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

On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
>> @@ -282,22 +313,15 @@ EXPORT_SYMBOL_GPL(iommu_page_response);
>>    */
>>   int iopf_queue_flush_dev(struct device *dev)
>>   {
>> -	int ret = 0;
>> -	struct iommu_fault_param *iopf_param;
>> -	struct dev_iommu *param = dev->iommu;
>> +	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
>>   
>> -	if (!param)
>> +	if (!iopf_param)
>>   		return -ENODEV;
> And this also seems unnecessary, it is a bug to call this after
> iopf_queue_remove_device() right? Just

Yes. They both are called from the iommu driver. The iommu driver should
guarantee this.

> rcu_derefernce(param->fault_param, true) and WARN_ON NULL.

Okay, sure.

Best regards,
baolu
