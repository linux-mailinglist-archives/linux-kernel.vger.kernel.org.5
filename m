Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD55812594
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443056AbjLNC5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLNC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:57:48 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0131FE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:57:51 -0800 (PST)
X-UUID: 7287c9da24384222a37dc75100d2e0a0-20231214
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:9a133655-a489-41ce-8782-2516dbf6c0e1,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:1
X-CID-INFO: VERSION:1.1.33,REQID:9a133655-a489-41ce-8782-2516dbf6c0e1,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:1
X-CID-META: VersionHash:364b77b,CLOUDID:22f1a5fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231214105741G5LGQI09,BulkQuantity:0,Recheck:0,SF:66|24|17|19|44|64|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_FSI
X-UUID: 7287c9da24384222a37dc75100d2e0a0-20231214
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 381816646; Thu, 14 Dec 2023 10:57:38 +0800
Message-ID: <9586be60-35f9-401f-b473-b16e86d13d07@kylinos.cn>
Date:   Thu, 14 Dec 2023 10:57:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/perf: Fix some null pointer dereference issues in
 thunderx2_pmu.c
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, Ganapatrao.Kulkarni@cavium.com,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211090347.265240-1-chentao@kylinos.cn>
 <20231212092523.GC28174@willie-the-truck>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231212092523.GC28174@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.

After read tx2_uncore_pmu_register again.
 From the defination: 'char *name = tx2_pmu->name;',
we could know 'tx2_pmu->pmu.name' equals 'tx2_pmu->name'

The difference is that a new memory space is allocated for 
'tx2_pmu->pmu.name'.

If 'tx2_pmu->pmu.name' is always the same as 'tx2_pmu->name', whether we 
should use 'tx2_pmu->pmu.name =  tx2_pmu->name;'
to replace the 'devm_kasprintf'.

I'm not sure it's appropriate to do that.

Thanks again.


On 2023/12/12 17:25, Will Deacon wrote:
> On Mon, Dec 11, 2023 at 05:03:47PM +0800, Kunwu Chan wrote:
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
>> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/perf/thunderx2_pmu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
>> index 1edb9c03704f..07edb174a0d7 100644
>> --- a/drivers/perf/thunderx2_pmu.c
>> +++ b/drivers/perf/thunderx2_pmu.c
>> @@ -742,6 +742,8 @@ static int tx2_uncore_pmu_register(
>>   
>>   	tx2_pmu->pmu.name = devm_kasprintf(dev, GFP_KERNEL,
>>   			"%s", name);
>> +	if (!tx2_pmu->pmu.name)
>> +		return -ENOMEM;
>>   
>>   	return perf_pmu_register(&tx2_pmu->pmu, tx2_pmu->pmu.name, -1);
> 
> AFAICT, perf_pmu_register() will WARN and return NULL, so I'm not sure what
> we gain from the additional check.
> 
>>   }
>> @@ -881,6 +883,11 @@ static struct tx2_uncore_pmu *tx2_uncore_pmu_init_dev(struct device *dev,
>>   		return NULL;
>>   	}
>>   
>> +	if (!tx2_pmu->name) {
>> +		dev_err(dev, "PMU type %d: Fail to allocate memory\n", type);
>> +		devm_kfree(dev, tx2_pmu);
>> +		return NULL;
>> +	}
> 
> In the _highly_ unlikely even that devm_kasprintf() failed to allocate,
> shouldn't we get a splat from the allocator? I don't think it's useful
> to print another message.
> 
> Will
