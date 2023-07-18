Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C647757727
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjGRIza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGRIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:55:24 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E81982;
        Tue, 18 Jul 2023 01:55:00 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vnh4bmV_1689670476;
Received: from 30.221.158.235(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0Vnh4bmV_1689670476)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 16:54:50 +0800
Message-ID: <8e2cfde3-15fa-4e5a-02bf-0763abf10821@linux.alibaba.com>
Date:   Tue, 18 Jul 2023 16:54:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org,
        catalin.marinas@arm.com, shameerali.kolothum.thodi@huawei.com
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZLZEq0QBBW4rcxJM@lpieralisi>
From:   "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <ZLZEq0QBBW4rcxJM@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/7/18 15:52, Lorenzo Pieralisi 写道:
> [+Catalin, Will, Shameer]
> 
> On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
>> According to the ARM IORT specifications DEN 0049 issue E,
>> the "Number of IDs" field in the ID mapping format reports
>> the number of IDs in the mapping range minus one.
>>
>> In iort_node_get_rmr_info(), we erroneously skip ID mappings
>> whose "Number of IDs" equal to 0, resulting in valid mapping
>> nodes with a single ID to map being skipped, which is wrong.
>>
>> Fix iort_node_get_rmr_info() by removing the bogus id_count
>> check.
>>
>> Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
>> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
>> ---
>>   drivers/acpi/arm64/iort.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
>> index 3631230..56d8873 100644
>> --- a/drivers/acpi/arm64/iort.c
>> +++ b/drivers/acpi/arm64/iort.c
>> @@ -1007,9 +1007,6 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
>>   	for (i = 0; i < node->mapping_count; i++, map++) {
>>   		struct acpi_iort_node *parent;
>>   
>> -		if (!map->id_count)
>> -			continue;
>> -
>>   		parent = ACPI_ADD_PTR(struct acpi_iort_node, iort_table,
>>   				      map->output_reference);
>>   		if (parent != iommu)
> 
> Shameer, I know this may look like overkill since the hunk we are
> removing is buggy but can you please test this patch on platforms
> with RMR to make sure we are not triggering regressions by removing
> it (by the specs that's what should be done but current firmware
> is always something to reckon with) ?
> 
> Thanks,
> Lorenzo
Thanks for your response.

Firstly, I have tested iort rmr with one ID mapping and works well.

Secondly, When there is more than two id mappings, the buggly id_count 
check has no effect(for the id_count is larger than zero).
