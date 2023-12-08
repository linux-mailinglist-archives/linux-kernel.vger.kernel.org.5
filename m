Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A21809A37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573043AbjLHDYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHDYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:24:48 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413E510CA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 19:24:54 -0800 (PST)
X-UUID: 76c0787f61094e8998249a46e8114759-20231208
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:63b3e073-6b38-45fa-875c-3be5f66d8c26,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33,REQID:63b3e073-6b38-45fa-875c-3be5f66d8c26,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:364b77b,CLOUDID:ed9e8b73-1bd3-4f48-b671-ada88705968c,B
        ulkID:231208001052E1RKQQ2T,BulkQuantity:9,Recheck:0,SF:44|64|66|24|17|19|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_FSI
X-UUID: 76c0787f61094e8998249a46e8114759-20231208
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2075006423; Fri, 08 Dec 2023 11:24:49 +0800
Message-ID: <12be2a40-0952-4577-80a0-fec688769230@kylinos.cn>
Date:   Fri, 8 Dec 2023 11:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mfd: tps6594: Add null pointer check to
 tps6594_device_init
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
Cc:     jpanis@baylibre.com, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org
References: <20231205095426.2532572-1-chentao@kylinos.cn>
 <20231207161037.GA111411@google.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <20231207161037.GA111411@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
I'll update the v2 patch:
1. When 'tps6594_irq_chip.name' is null,just return -ENOMEM.

Thanks again,
Kunwu

On 2023/12/8 00:10, Lee Jones wrote:
> On Tue, 05 Dec 2023, Kunwu Chan wrote:
> 
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/mfd/tps6594-core.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mfd/tps6594-core.c b/drivers/mfd/tps6594-core.c
>> index 0fb9c5cf213a..6403c1063de9 100644
>> --- a/drivers/mfd/tps6594-core.c
>> +++ b/drivers/mfd/tps6594-core.c
>> @@ -433,6 +433,9 @@ int tps6594_device_init(struct tps6594 *tps, bool enable_crc)
>>   	tps6594_irq_chip.name = devm_kasprintf(dev, GFP_KERNEL, "%s-%ld-0x%02x",
>>   					       dev->driver->name, tps->chip_id, tps->reg);
>>   
>> +	if (!tps6594_irq_chip.name)
>> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate memory\n");
>> +
> 
> The check is fine, but the use of dev_err_probe() is not.
> 
> Simply:
> 
> 	return -ENOMEM;
> 
>>   	ret = devm_regmap_add_irq_chip(dev, tps->regmap, tps->irq, IRQF_SHARED | IRQF_ONESHOT,
>>   				       0, &tps6594_irq_chip, &tps->irq_data);
>>   	if (ret)
>> -- 
>> 2.34.1
>>
> 
