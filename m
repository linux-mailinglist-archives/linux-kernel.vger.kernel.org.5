Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4877F23B0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjKUCMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjKUCMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:12:40 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633D2C3;
        Mon, 20 Nov 2023 18:12:34 -0800 (PST)
X-UUID: fc53191120304ffab81e76ce8ee56509-20231121
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:1fcb15c5-4542-451d-85f9-59e249b4c6fa,IP:10,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:1
X-CID-INFO: VERSION:1.1.32,REQID:1fcb15c5-4542-451d-85f9-59e249b4c6fa,IP:10,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:5f78ec9,CLOUDID:f5919e95-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231119230408XYBZ5UP2,BulkQuantity:8,Recheck:0,SF:66|24|17|19|43|74|6
        4|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: fc53191120304ffab81e76ce8ee56509-20231121
X-User: chentao@kylinos.cn
Received: from [172.21.13.26] [(116.128.244.171)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 467459029; Tue, 21 Nov 2023 10:12:19 +0800
Message-ID: <55b77a28-a680-4465-bb57-2a5cb20ce06a@kylinos.cn>
Date:   Tue, 21 Nov 2023 10:12:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Use correct buffer size
Content-Language: en-US
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     horms@kernel.org, anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, intel-wired-lan@lists.osuosl.org,
        jeffrey.t.kirsher@intel.com, jesse.brandeburg@intel.com,
        kuba@kernel.org, kunwu.chan@hotmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, shannon.nelson@amd.com
References: <20231113093112.GL705326@kernel.org>
 <20231115031444.33381-1-chentao@kylinos.cn>
 <55e07c56-da57-41aa-bc96-e446fad24276@intel.com>
 <4b551600-f1a3-4efe-b3e9-99cb4536f487@kylinos.cn>
 <2c61c232-1bbb-4cae-bb7f-92a7f2298e97@intel.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <2c61c232-1bbb-4cae-bb7f-92a7f2298e97@intel.com>
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

Thanks for your reply. I understand what you mean, i.e. the caller of 
'kasprintf' is responsible for calling 'kfree' to free up memory.

My concern is that in many scenarios, the requested memory will be 
released after a period of use.

Has anyone else forgotten to free up the requested memory when using 
'kasprintf'? e.g. 'dam_heap_init' calls 'dma_heap_devnode' to allocate 
memory:
dam_heap_init
	-> dma_heap_devnode
		  -> kasprintf
			->kvasprintf
			     ->kmalloc_node_track_caller
			  	-> __kmalloc_node_track_caller
					  -> __do_kmalloc_node
						  -> kasan_kmalloc


There is no function like 'dam_heap_exit' to free the memmory allocated 
by dma_heap_devnode.

Another case is 'cpuid_devnode'. Will this cause a memory leak, and is 
there a better way to avoid the memory leak in this case?

Or is there a uniform place in the memory management module to free up 
this memory?

Thanks,
Kunwu

On 2023/11/20 19:41, Alexander Lobakin wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> Date: Sun, 19 Nov 2023 23:12:09 +0800
> 
>> Hi Alexander,
>> Thank you so much for your reply, I looked at the modification you
>> mentioned, it's really cool. I'll definitely try it next time.
>>
>> But when using it, will it be easy to forget to free up memory?
> 
> You have a kfree() at the end of the function.
> 
> Generally speaking, 'ka' stands for "[kernel] allocate" and you also
> need to pass GPF_ as the second argument. Enough hints that you need to
> free the pointer after using it I would say.
> 
>> Although 'kmalloc_track_caller' is used, according to my understanding,
>> it is also necessary to release the memory at the end of use.
>>
>> On 2023/11/15 23:39, Alexander Lobakin wrote:
>>> From: Kunwu Chan <chentao@kylinos.cn>
>>> Date: Wed, 15 Nov 2023 11:14:44 +0800
>>>
>>>> The size of "i40e_dbg_command_buf" is 256, the size of "name"
>>>> depends on "IFNAMSIZ", plus a null character and format size,
>>>> the total size is more than 256, fix it.
>>>>
>>>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>>>> Suggested-by: Simon Horman <horms@kernel.org>
>>>> ---
>>>>    drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>>> b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>>> index 999c9708def5..e3b939c67cfe 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
>>>> @@ -72,7 +72,7 @@ static ssize_t i40e_dbg_command_read(struct file
>>>> *filp, char __user *buffer,
>>>>    {
>>>>        struct i40e_pf *pf = filp->private_data;
>>>>        int bytes_not_copied;
>>>> -    int buf_size = 256;
>>>> +    int buf_size = IFNAMSIZ + sizeof(i40e_dbg_command_buf) + 4;
>>>
>>> Reverse Christmas Tree style? Should be the first one in the declaration
>>> list.
>>>
>>>>        char *buf;
>>>>        int len;
>>>
>>> You can fix it in a different way. Given that there's a kzalloc() either
>>> way, why not allocate the precise required amount of bytes by using
>>> kasprintf() instead of kzalloc() + snprintf()? You wouldn't need to
>>> calculate any buffer sizes etc. this way.
>>>
>>> Thanks,
>>> Olek
> 
> Thanks,
> Olek
