Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12237790B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHKNZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHKNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:25:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8978E90
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:25:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82E3F113E;
        Fri, 11 Aug 2023 06:26:22 -0700 (PDT)
Received: from [10.57.1.174] (unknown [10.57.1.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4C23F6C4;
        Fri, 11 Aug 2023 06:25:38 -0700 (PDT)
Message-ID: <3576aade-d13a-c887-d26b-fd157b82b9a5@arm.com>
Date:   Fri, 11 Aug 2023 14:25:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH 0/2] iommu/iova: optimize the iova rcache
To:     Zhang Zekun <zhangzekun11@huawei.com>, joro@8bytes.org,
        will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com, robh@kernel.org, nicolinc@nvidia.com,
        john.g.garry@oracle.com, kevin.tian@intel.com
References: <20230811130246.42719-1-zhangzekun11@huawei.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230811130246.42719-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-11 14:02, Zhang Zekun wrote:
> The number of iova_cpu_rcache can grow with the number of cpus in
> iova_rcache, but the size of rcache->depot will not. The deeper of
> rcache->depot can help iova_rcache cache more iovas, and can help
> iova_rcache better dealing with senarios in which drivers allocating
> and free iovas on different cpu cores. We only let the size of rcache->depot
> to grow with the number of cpus which is larger than 32 to avoid potential
> performance decrease on machines which don't have much cpus.

Oh, that reminds me I had started working on this again just before I 
was off, only my plan was to get rid of the depot allocation 
altogether[1]. However I wanted to finish the second patch on that 
branch (to reclaim wasted memory from the depot if the workload changes) 
before posting anything - I was feeling really pleased that I'd made it 
work until I realised it was leaking all the actual IOVAs... :(

Thanks,
Robin.

[1] 
https://gitlab.arm.com/linux-arm/linux-rm/-/commit/2f37ebe93eb282b534bf9e0fd4adc66cfe4b6693

> 
> Also, it is unsafe to directly free cpu rcache magazines in free_iova_rcaches,
> add check before freeing it.
> 
> Zhang Zekun (2):
>    iommu/iova: Add check for cpu_rcache in free_iova_rcaches
>    iommu/iova: allocate iova_rcache->depot dynamicly
> 
>   drivers/iommu/iova.c | 36 +++++++++++++++++++++++++++++++-----
>   1 file changed, 31 insertions(+), 5 deletions(-)
> 
