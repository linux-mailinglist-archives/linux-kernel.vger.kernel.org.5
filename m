Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91BB75914A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjGSJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjGSJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:13:16 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0F10B;
        Wed, 19 Jul 2023 02:13:14 -0700 (PDT)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R5VT71yWZzrRr5;
        Wed, 19 Jul 2023 17:12:27 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 19 Jul 2023 17:13:11 +0800
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>
CC:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "alikernel-developer@linux.alibaba.com" 
        <alikernel-developer@linux.alibaba.com>,
        "will@kernel.org" <will@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZLZEq0QBBW4rcxJM@lpieralisi> <597f481b0e5149dabe4821ca618af6b3@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <613da2c3-d515-b49c-4ff3-cf94836b2acf@huawei.com>
Date:   Wed, 19 Jul 2023 17:13:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <597f481b0e5149dabe4821ca618af6b3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
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

On 2023/7/18 16:56, Shameerali Kolothum Thodi wrote:
>> [+Catalin, Will, Shameer]
>>
>> On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
>>> According to the ARM IORT specifications DEN 0049 issue E,
>>> the "Number of IDs" field in the ID mapping format reports
>>> the number of IDs in the mapping range minus one.
>>>
>>> In iort_node_get_rmr_info(), we erroneously skip ID mappings
>>> whose "Number of IDs" equal to 0, resulting in valid mapping
>>> nodes with a single ID to map being skipped, which is wrong.
>>>
>>> Fix iort_node_get_rmr_info() by removing the bogus id_count
>>> check.
>>>
>>> Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR
>> reserved regions")
>>> Signed-off-by: Guanghui Feng<guanghuifeng@linux.alibaba.com>
>>> ---
>>>   drivers/acpi/arm64/iort.c | 3 ---
>>>   1 file changed, 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>>> index 3631230..56d8873 100644
>>> --- a/drivers/acpi/arm64/iort.c
>>> +++ b/drivers/acpi/arm64/iort.c
>>> @@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct
>> acpi_iort_node *node,
>>>   	for (i = 0; i < node->mapping_count; i++, map++) {
>>>   		struct acpi_iort_node *parent;
>>>
>>> -		if (!map->id_count)
>>> -			continue;
>>> -
>>>   		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>>>   				      map->output_reference);
>>>   		if (parent != iommu)
>> Shameer, I know this may look like overkill since the hunk we are
>> removing is buggy but can you please test this patch on platforms
>> with RMR to make sure we are not triggering regressions by removing
>> it (by the specs that's what should be done but current firmware
>> is always something to reckon with) ?
> Yes, that is a valid fix. Unlikely it will be a problem. Anyway, I have requested
> Hanjun to help with the testing as I don't have a test setup with me now.

Valid fix for me as well, we had a firmware bug which reported the
numbers of ID as 1 when we only have one ID mapping, so remove the
check is fine for the old firmware, but to make it sure, we need some
test before give it a pass.

> 
> Hanjun, please help.

I need some time to get it properly tested on two versions of firmware,
and get the test machine properly setup, please allow me give the
feedback next week.

Thanks
Hanjun
