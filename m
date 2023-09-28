Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78687B16FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjI1JRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbjI1JRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:17:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187831A7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695892633; x=1727428633;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DR4v89UPJGMbbQ1s24/8ST+JrVlkJe9mt1G5bqAee48=;
  b=GMsXa3+Zf+7xzgI5jirioVIKX03ZoaGfLHDl4pcH/zcMujEBeNLLJHRw
   EUDiTGhvPNjUD2UhXjxijhYxLDun8ZPkXcmFmQLkxh1AXK8TLsrIZHoV5
   BYdA1Z+r8aLFAdhwITGTxBdYBphReBsATvxJ6XQV421vY+z6WHcbr1XyA
   WxH7NTbW/ShhawdaNzSh30FHEnnwGVAsSmL7mD8kWKS52LGuxR3gfQKJq
   AGozaFv7/5RFtLvSrgPvt+rGrVse5xtziTVsPvo3NdvEIi5NUh1znH4we
   bMaR6QU71f4m7rSVxHc5IDxgqU8sV0VR4Iae22Bg8g5RtTXqbgOfjpvfA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361392396"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="361392396"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:17:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="815166531"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="815166531"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.143]) ([10.254.215.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:17:08 -0700
Message-ID: <f250db59-03aa-3a64-3bb7-08fbcbf41839@linux.intel.com>
Date:   Thu, 28 Sep 2023 17:17:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATH v3 2/3] iommu/vt-d: debugfs: Create/remove debugfs file per
 {device, pasid}
To:     "Liu, Jingqi" <jingqi.liu@intel.com>, iommu@lists.linux.dev,
        Tian Kevin <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20230927151536.67319-1-Jingqi.liu@intel.com>
 <20230927151536.67319-3-Jingqi.liu@intel.com>
 <8d931037-500f-1dff-5fb6-fe60d2e8af7d@linux.intel.com>
 <196f7651-31d8-349d-9db9-dfeaa272542e@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <196f7651-31d8-349d-9db9-dfeaa272542e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/28 17:02, Liu, Jingqi wrote:
>> And here,
>>
>> void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
>>                       struct device *dev, u32 pasid)
>> {
>>     sprintf(dir_name, "%x", pasid);
>>     dev_pasid->debugfs_entry = debugfs_create_dir(dir_name,
>>             info->debugfs_entry);
>>
>>     debugfs_create_file("domain_translation_struct", 0444,
>>                 dev_pasid->debugfs_entry, dev_pasid,
>>                 &domain_translation_struct_fops);
>> }
>>
> Thanks.
> You mean to add 'debugfs_entry' in below structure.
>      struct dev_pasid_info *dev_pasid;
> This structure is also allocated per pair of {dev, pasid}.
> The debugfs dentry of  {dev, pasid} can be simply obtained from 
> 'dev_pasid_info'.
> 
> So the 'dev_pasid_info' can be passed as a parameter of this helper, 
> right ?
> Like this:
> void intel_iommu_debugfs_create_dev_pasid(struct iommu_domain *domain,
>                        struct dev_pasid_info *dev_pasid) ;

Yes.

Best regards,
baolu
