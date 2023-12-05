Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ADA804D44
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjLEJLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjLEJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:11:08 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4BFB0;
        Tue,  5 Dec 2023 01:11:12 -0800 (PST)
X-UUID: e2ea7b9425b3484dbf10c16655c76633-20231205
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:05221978-0740-48be-aef5-ff6dc0097c13,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-15
X-CID-INFO: VERSION:1.1.33,REQID:05221978-0740-48be-aef5-ff6dc0097c13,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-15
X-CID-META: VersionHash:364b77b,CLOUDID:ea8c4efd-4a48-46e2-b946-12f04f20af8c,B
        ulkID:231204193409M5FRDQ5Z,BulkQuantity:10,Recheck:0,SF:19|44|64|66|38|24|
        17|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil
        ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_OBB,
        TF_CID_SPAM_SNR
X-UUID: e2ea7b9425b3484dbf10c16655c76633-20231205
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 894928552; Tue, 05 Dec 2023 17:10:58 +0800
Message-ID: <55c00bb3-b795-4698-ba3f-56d10df1882a@kylinos.cn>
Date:   Tue, 5 Dec 2023 17:10:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Fix null pointer dereference in sof_pci_probe
Content-Language: en-US
To:     =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        chao.song@intel.com
Cc:     kunwu.chan@hotmail.com, sound-open-firmware@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123155424.1275919-1-chentao@kylinos.cn>
 <1701766721668457.408.seg@mailgw>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <1701766721668457.408.seg@mailgw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's my bad, i'll follow your suggestion in v2 patch:
1. remove 'Fixes: 46207ca24545' label

2. rename subject to 'ASoC: SOF: Add null pointer check to sof_pci_probe'

3. when sof_pdata->fw_filename_prefix is NULL,don't use it to dev_dbg. 
Or just use a
if (sof_pdata->fw_filename_prefix)
         dev_dbg(dev,
                 "Platform uses community key, changed fw path to %s\n",
                 sof_pdata->fw_filename_prefix);
else
	dev_dbg(dev,
                 "Platform uses community key, changed fw path to %s/%s\n",
                  sof_pdata->desc->default_fw_path[sof_pdata->ipc_type],
                  "community");

Is it okay to modify it like this?


Thanks,
Kunwu

On 2023/12/4 19:34, Péter Ujfalusi wrote:
> 
> 
> On 23/11/2023 17:54, Kunwu Chan wrote:
>> devm_kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 46207ca24545 ("ASoC: SOF: pci: change the default firmware path when the community key is used")
>> Fixes: 25bbc0c59ee1 ("ASoC: SOF: Add path definition for external firmware libraries")
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> 
> This patch cannot fix both commits as at 46207ca24545 the lib path was
> not present.
> Please don't bundle unrelated fixes, it makes maintainers life harder.
> 
> As a note: if the allocation fails it is not going to cause null
> dereference as the code checks !sof_pdata->*_prefix to see if it is
> provided (override) or not (use default).
> At most it will cause the kernel to 'ignore' the path override, but if
> this allocation fails this is least of our problem ;)
> 
>> ---
>>   sound/soc/sof/sof-pci-dev.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
>> index 64b326e3ef85..75a9bfa5bfbe 100644
>> --- a/sound/soc/sof/sof-pci-dev.c
>> +++ b/sound/soc/sof/sof-pci-dev.c
>> @@ -282,6 +282,10 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
>>   			devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
>>   				       sof_pdata->desc->default_fw_path[sof_pdata->ipc_type],
>>   				       "community");
>> +		if (!sof_pdata->fw_filename_prefix) {
>> +			ret = -ENOMEM;	
>> +			goto out;
>> +		}
>>   
>>   		dev_dbg(dev,
>>   			"Platform uses community key, changed fw path to %s\n",
>> @@ -303,6 +307,10 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
>>   				devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
>>   					sof_pdata->desc->default_lib_path[sof_pdata->ipc_type],
>>   					"community");
>> +			if (!sof_pdata->fw_lib_prefix) {
>> +				ret = -ENOMEM;
>> +				goto out;
>> +			}
>>   
>>   			dev_dbg(dev,
>>   				"Platform uses community key, changed fw_lib path to %s\n",
> 
