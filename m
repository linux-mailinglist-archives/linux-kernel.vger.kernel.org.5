Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F349E7D6B04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjJYMQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbjJYMQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:16:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37458CE;
        Wed, 25 Oct 2023 05:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698236182; x=1729772182;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tDzwyDjkaDc8TUEWuENwxjT1Dw93wCEeJpJVuaYZ1ps=;
  b=cCqI8tf4itA/7bmy2m3LSeAKBcVk51KfwRTBbok/YWTD96HRCIAb2+fE
   CwtkNG4VoyVaYFJqoNRk/QzgD3VfXfvuHdY2zfWvssCXZb6g1XMyeAqUR
   KTBbd+HAE4SABBFi1SWuCcayCNUoXNIxcyYj+VZuXxz5XYfrOIERwEj/M
   B+SL9afOPlgzFonNLHLEJ2XXS8YPFa2X2PQ6dpA4M7uSkMKwSeO7ZByfy
   LrM7dhT03Q5RccXdcrGGDRQ/5w5mgDGwkK6TrZnLwdT7Hzs83Yu1uq7eW
   d5LIOe77JU+6moszdTcmacZPc895dIJ6x/78Dh5x3/jWWNywbNe/7RmLE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="366641824"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="366641824"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 05:16:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="875482045"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="875482045"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.178]) ([10.254.211.178])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 05:16:19 -0700
Message-ID: <617cc452-2d31-4fe0-a808-a980baa43056@linux.intel.com>
Date:   Wed, 25 Oct 2023 20:16:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>
References: <20231025153455.283c5b12@canb.auug.org.au>
 <20231025121212.GB3952@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231025121212.GB3952@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/25 20:12, Jason Gunthorpe wrote:
> On Wed, Oct 25, 2023 at 03:34:55PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the iommufd tree got a conflict in:
>>
>>    drivers/iommu/intel/pasid.c
>>
>> between commit:
>>
>>    c61c255e114c ("iommu/vt-d: Remove unused function")
>>
>> from the iommu tree and commits:
>>
>>    f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
>>    cbf8b441ea08 ("iommu/vt-d: Add helper to setup pasid nested translation")
>>
>> from the iommufd tree.
>>
>> I fixed it up (the latter added a use of the function removed by
>> the former, so I just used the latter) and can carry the fix as
>> necessary. This is now fixed as far as linux-next is concerned, but any
>> non trivial
> Intel folks, this is not nice 🙁 Why was the first commit done at all
> if the nesting series needs this?

It's my fault. My apologies for not realizing that the helper would
still be used by the nesting translation series. I will be more careful
in the future.

Best regards,
baolu
