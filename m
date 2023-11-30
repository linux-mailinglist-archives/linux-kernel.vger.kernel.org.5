Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD847FEC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjK3Jni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Jnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:43:37 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5E4D50;
        Thu, 30 Nov 2023 01:43:41 -0800 (PST)
X-UUID: 1cc704b282c9470082eced3a0ef062cb-20231130
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:4cb8bf6d-cb19-43c2-acda-67eaa471d2a2,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-9
X-CID-INFO: VERSION:1.1.33,REQID:4cb8bf6d-cb19-43c2-acda-67eaa471d2a2,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-9
X-CID-META: VersionHash:364b77b,CLOUDID:ec6321fd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231130174330NINYOUVY,BulkQuantity:0,Recheck:0,SF:64|66|24|17|19|44|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 1cc704b282c9470082eced3a0ef062cb-20231130
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 632642991; Thu, 30 Nov 2023 17:43:27 +0800
Message-ID: <bf29c39f-8d9f-465a-bbc2-45bdb77711b8@kylinos.cn>
Date:   Thu, 30 Nov 2023 17:43:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/mellanox: Add a null pointer check in
 mlxbf_pmc_create_groups
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, vadimp@nvidia.com,
        jiri@resnulli.us, shravankr@nvidia.com, kunwu.chan@hotmail.com,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231127063433.1549064-1-chentao@kylinos.cn>
 <1701224213463629.329.seg@mailgw>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <1701224213463629.329.seg@mailgw>
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

Thanks for your reply.

Cause i don't know how to deal with in some scenario，such as in 
'mlxbf_pmc_init_perftype_counter', when 'attr->dev_attr.attr.name' is 
null, should return '-ENOMEM' or 'continue' the loop?

So I'm going to solve it one by one.

Thanks again,
Kunwu

On 2023/11/28 17:51, Ilpo Järvinen wrote:
> On Mon, 27 Nov 2023, Kunwu Chan wrote:
> 
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 1a218d312e65 ("platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>   drivers/platform/mellanox/mlxbf-pmc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
>> index 0b427fc24a96..59bbe5e13f6b 100644
>> --- a/drivers/platform/mellanox/mlxbf-pmc.c
>> +++ b/drivers/platform/mellanox/mlxbf-pmc.c
>> @@ -1882,6 +1882,8 @@ static int mlxbf_pmc_create_groups(struct device *dev, int blk_num)
>>   	pmc->block[blk_num].block_attr_grp.attrs = pmc->block[blk_num].block_attr;
>>   	pmc->block[blk_num].block_attr_grp.name = devm_kasprintf(
>>   		dev, GFP_KERNEL, pmc->block_name[blk_num]);
>> +	if (!pmc->block[blk_num].block_attr_grp.name)
>> +		return -ENOMEM;
>>   	pmc->groups[pmc->group_num] = &pmc->block[blk_num].block_attr_grp;
>>   	pmc->group_num++;
> 
> I'm totally lost, why did you fix only one devm_kasprintf() location?
> Don't all of them need this check?
> 
