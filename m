Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7EA7F3DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjKVGMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVGMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:12:43 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E764B193
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 22:12:37 -0800 (PST)
X-UUID: 61ae4e4fb75c4cf38e40b7b283d805fe-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d7a41ee5-831f-407e-a4e3-f06d1389ab28,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-5
X-CID-INFO: VERSION:1.1.32,REQID:d7a41ee5-831f-407e-a4e3-f06d1389ab28,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:5f78ec9,CLOUDID:588d5760-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:231121173808K4KP36WO,BulkQuantity:3,Recheck:0,SF:64|66|38|24|17|19|4
        4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 61ae4e4fb75c4cf38e40b7b283d805fe-20231122
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1338378066; Wed, 22 Nov 2023 14:12:23 +0800
Message-ID: <71012ceb-794c-4c32-a88a-47896e76366a@kylinos.cn>
Date:   Wed, 22 Nov 2023 14:12:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Check return value of devm_kasprintf in
 imx_mmdc_perf_init
Content-Language: en-US
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>, linux@armlinux.org.uk,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, angus.chen@jaguarmicro.com,
        arnd@arndb.de, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kunwu.chan@hotmail.com
References: <20231121092526.6708-1-chentao@kylinos.cn>
 <fb963c37-db12-0f1c-c9a6-d67095ccaba1@pengutronix.de>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <fb963c37-db12-0f1c-c9a6-d67095ccaba1@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Ahmad

Thank you for your guidance to me
It's my bad, i will update a v2 patch follow your suggestions, and send 
it in a new thread.

v2 changes:
1、use the first commit 'e76bdfd7403a' in the 'Fixes' tag.
2、Add new tag 'pmu_release_id' to release the id allocated in 
'mmdc_pmu_init', move 'ida_simple_remove(&mmdc_ida, pmu_mmdc->id);' into 
'pmu_release_id'.

the v2 patch look like:

+       if (!name) {
+               ret = -ENOMEM;
+               goto pmu_release_id;
+       }

         pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
         pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data 
*)of_id->data;
@@ -523,9 +527,10 @@ static int imx_mmdc_perf_init(struct 
platform_device *pdev, void __iomem *mmdc_b

  pmu_register_err:
         pr_warn("MMDC Perf PMU failed (%d), disabled\n", ret);
-       ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
         cpuhp_state_remove_instance_nocalls(cpuhp_mmdc_state, 
&pmu_mmdc->node);
         hrtimer_cancel(&pmu_mmdc->hrtimer);
+pmu_release_id:
+       ida_simple_remove(&mmdc_ida, pmu_mmdc->id);
  pmu_free:


Thanks,
Kunwu

On 2023/11/21 17:37, Ahmad Fatoum wrote:
> Hello Kunwu,
> 
> On 21.11.23 10:25, Kunwu Chan wrote:
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
>>
>> Fixes: ebeb49f43c89 ("ARM: imx: Call ida_simple_remove() for ida_simple_get")
> 
> This commit only moves the allocation around, but it didn't introduce it.
> Please reference the first commit that added the allocation.
> 
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   arch/arm/mach-imx/mmdc.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
>> index 2157493b78a9..7c471d6a851d 100644
>> --- a/arch/arm/mach-imx/mmdc.c
>> +++ b/arch/arm/mach-imx/mmdc.c
>> @@ -501,6 +501,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
>>   
>>   	name = devm_kasprintf(&pdev->dev,
>>   				GFP_KERNEL, "mmdc%d", ret);
>> +	if (!name) {
>> +		ret = -ENOMEM;
>> +		goto pmu_free;
> 
> Cleanup is incomplete if you goto pmu_free, e.g. ida_simple_remove()
> isn't called. pmu_register_err does too much cleanup, so you'll need
> to add a new cleanup label.
> 
> Cheers,
> Ahmad
> 
> 
>> +	}
>>   
>>   	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
>>   	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;
> 
