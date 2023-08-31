Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE20D78E4CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 04:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbjHaCp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjHaCpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 22:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A9CD7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 19:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693449923; x=1724985923;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvqqUn/QYIsd9Wy6pXz11sbZ+wHEshiG1oiKNfieeGo=;
  b=JyjF4bGG7YxRFzqtWIyz3Bur4mXp7uMKE5tZVm+b+ibJxM62YQ0aqFsH
   D3b/QQp/C7gnxaohFqaWzGOyNGBear712yJQoO9Ec0Cf2KMAhXUWXxy3c
   SOBJq38un4MaAuAy0Jjp8OrMGCN4imhZ3HZFYHjBA+5Ycnx24bwJvwbhI
   M8L+rWZWU9pHyxdpq7gftc+KehVIJ6+Q+5WLbxLA8bYBYXHPgWMy5/J15
   9HPZAKpzLfMAoUM7wKmukMDcg4ocCkShluuV+H7tJhiersT2cF5DeXQi7
   jbIpazhT3M5yBp9mYilCBIvRtBEagKzOmKTeKYWYk9WicNAc5kBBSdqPh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355294605"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="355294605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716148213"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="716148213"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.87]) ([10.254.210.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 19:45:20 -0700
Message-ID: <92bceb62-b33f-2380-9229-af9634b12c95@linux.intel.com>
Date:   Thu, 31 Aug 2023 10:45:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] mm: Add structure to keep sva information
Content-Language: en-US
To:     Tina Zhang <tina.zhang@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Michael Shavit <mshavit@google.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-4-tina.zhang@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230827084401.819852-4-tina.zhang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/27 16:43, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Signed-off-by: Tina Zhang<tina.zhang@intel.com>
> ---
>   include/linux/iommu.h    | 5 +++++
>   include/linux/mm_types.h | 2 ++
>   2 files changed, 7 insertions(+)

Nit:

iommu also has a per-device private pointer, it's defined as struct
dev_iommu and stored at dev->iommu. Is it valuable to align both?

Best regards,
baolu
