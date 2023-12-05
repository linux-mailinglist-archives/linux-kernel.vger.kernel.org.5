Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B0F804E36
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjLEJno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjLEJnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:43:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B9D1B1;
        Tue,  5 Dec 2023 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701769421; x=1733305421;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Xx8hTm4tgt1WkYv+D9huMLfFJ1VJtxyGkuW4UZy5kA=;
  b=G9fbCebfZ6qHXY1OS1tiZ0HYFozV14HDo98wrHpr3+mSmIl7a9p2qY8g
   jJbqvJRRhQVONlmFYUUbzp9LWREqoBcp/r4DaKcP3YBcIIXO/VLWkVaj+
   vvxlILUZb86scri2wI7wwTQzIIdHn4dNRTvzJNo4psF9uTpnOj9rpp87h
   9s+vei3x3wSjDNmK/a0X2dBASbFvB462AA6bAPXJ3o2wolyyTiSQn4Wli
   mZC90EAPf8jrjoFWef7UDDWmieewTTHboBt038ZkEHt+bQTpVW5aNtap2
   awmLLXYNZojmzKmfDa4SkX3QpTYw/W0D8YWrRimeqf3x3Z6Mrr6oqUSK8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="711883"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="711883"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:43:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="17345940"
Received: from nathanby-mobl2.ger.corp.intel.com (HELO [10.252.61.50]) ([10.252.61.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:43:37 -0800
Message-ID: <74ba8770-6174-4820-8dc4-e97e5814e665@linux.intel.com>
Date:   Tue, 5 Dec 2023 11:44:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: Fix null pointer dereference in sof_pci_probe
To:     Kunwu Chan <chentao@kylinos.cn>,
        pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        chao.song@intel.com
Cc:     kunwu.chan@hotmail.com, sound-open-firmware@alsa-project.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231123155424.1275919-1-chentao@kylinos.cn>
 <1701766721668457.408.seg@mailgw>
 <55c00bb3-b795-4698-ba3f-56d10df1882a@kylinos.cn>
Content-Language: en-US
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <55c00bb3-b795-4698-ba3f-56d10df1882a@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/12/2023 11:10, Kunwu Chan wrote:
> It's my bad, i'll follow your suggestion in v2 patch:
> 1. remove 'Fixes: 46207ca24545' label
> 
> 2. rename subject to 'ASoC: SOF: Add null pointer check to sof_pci_probe'
> 
> 3. when sof_pdata->fw_filename_prefix is NULL,don't use it to dev_dbg.
> Or just use a
> if (sof_pdata->fw_filename_prefix)
>         dev_dbg(dev,
>                 "Platform uses community key, changed fw path to %s\n",
>                 sof_pdata->fw_filename_prefix);
> else
>     dev_dbg(dev,
>                 "Platform uses community key, changed fw path to %s/%s\n",
>                  sof_pdata->desc->default_fw_path[sof_pdata->ipc_type],
>                  "community");
> 
> Is it okay to modify it like this?

The code has been rewritten and all of these issues have been
eliminated, fixed in core SOF.

> 
> 
> Thanks,
> Kunwu
> 
> On 2023/12/4 19:34, Péter Ujfalusi wrote:
>>
>>
>> On 23/11/2023 17:54, Kunwu Chan wrote:
>>> devm_kasprintf() returns a pointer to dynamically allocated memory
>>> which can be NULL upon failure.
>>>
>>> Fixes: 46207ca24545 ("ASoC: SOF: pci: change the default firmware
>>> path when the community key is used")
>>> Fixes: 25bbc0c59ee1 ("ASoC: SOF: Add path definition for external
>>> firmware libraries")
>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>
>> This patch cannot fix both commits as at 46207ca24545 the lib path was
>> not present.
>> Please don't bundle unrelated fixes, it makes maintainers life harder.
>>
>> As a note: if the allocation fails it is not going to cause null
>> dereference as the code checks !sof_pdata->*_prefix to see if it is
>> provided (override) or not (use default).
>> At most it will cause the kernel to 'ignore' the path override, but if
>> this allocation fails this is least of our problem ;)
>>
>>> ---
>>>   sound/soc/sof/sof-pci-dev.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
>>> index 64b326e3ef85..75a9bfa5bfbe 100644
>>> --- a/sound/soc/sof/sof-pci-dev.c
>>> +++ b/sound/soc/sof/sof-pci-dev.c
>>> @@ -282,6 +282,10 @@ int sof_pci_probe(struct pci_dev *pci, const
>>> struct pci_device_id *pci_id)
>>>               devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
>>>                         
>>> sof_pdata->desc->default_fw_path[sof_pdata->ipc_type],
>>>                          "community");
>>> +        if (!sof_pdata->fw_filename_prefix) {
>>> +            ret = -ENOMEM;   
>>> +            goto out;
>>> +        }
>>>             dev_dbg(dev,
>>>               "Platform uses community key, changed fw path to %s\n",
>>> @@ -303,6 +307,10 @@ int sof_pci_probe(struct pci_dev *pci, const
>>> struct pci_device_id *pci_id)
>>>                   devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
>>>                      
>>> sof_pdata->desc->default_lib_path[sof_pdata->ipc_type],
>>>                       "community");
>>> +            if (!sof_pdata->fw_lib_prefix) {
>>> +                ret = -ENOMEM;
>>> +                goto out;
>>> +            }
>>>                 dev_dbg(dev,
>>>                   "Platform uses community key, changed fw_lib path
>>> to %s\n",
>>

-- 
Péter
