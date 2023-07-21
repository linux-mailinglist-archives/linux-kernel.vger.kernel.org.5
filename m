Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF50875BC01
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 03:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGUBw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 21:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjGUBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 21:52:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247C270B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 18:52:26 -0700 (PDT)
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6XXn69fHztR6X;
        Fri, 21 Jul 2023 09:49:13 +0800 (CST)
Received: from [10.174.176.82] (10.174.176.82) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:52:21 +0800
Message-ID: <2c2428e9-230a-91f2-84bb-01804ce10c04@huawei.com>
Date:   Fri, 21 Jul 2023 09:52:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Subject: Re: [PATCH -next 0/2] iommu/iova: optimize the iova rcache
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC:     <guohanjun@huawei.com>, <xuqiang36@huawei.com>,
        <chenweilong@huawei.com>, <thunder.leizhen@huawei.com>
References: <20230711025452.35475-1-zhangzekun11@huawei.com>
From:   "zhangzekun (A)" <zhangzekun11@huawei.com>
In-Reply-To: <20230711025452.35475-1-zhangzekun11@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, does anyone has suggestions for these two patches?

在 2023/7/11 10:54, Zhang Zekun 写道:
> The struct of iova rcache has diffcult in dealing with machine with
> lots of cpus, because every cpu has a cpu_rcache and they need to
> exchange iova in a fixed length buffer rcache->depot, this buffer
> can sometimes become a bottle neck of allocating iova from iova_rcache.
> The number of iova_cpu_rcache can grow with the number of cpus in
> iova_rcache, but the size of rcache->depot will not. The deeper of
> rcache->depot can help iova_rcache cache more iovas, and can help
> iova_rcache better dealing with senarios in which drivers allocating
> and free iovas on different cpu cores. We only let the size of rcache->depot
> to grow with the number of cpus which is larger than 32 to avoid potential
> performance decrease on machines which don't have much cpus.
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

