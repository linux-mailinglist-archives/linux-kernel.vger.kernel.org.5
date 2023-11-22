Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AAE7F3E73
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 07:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjKVG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 01:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbjKVG5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 01:57:21 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463DD56;
        Tue, 21 Nov 2023 22:57:16 -0800 (PST)
X-UUID: ecc929b9a36e4167b39c339ec85e6be3-20231122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:c5890a39-a286-49e1-9039-f832626f149b,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:-14
X-CID-INFO: VERSION:1.1.32,REQID:c5890a39-a286-49e1-9039-f832626f149b,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:1,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-14
X-CID-META: VersionHash:5f78ec9,CLOUDID:f395ef72-1bd3-4f48-b671-ada88705968c,B
        ulkID:231119230408XYBZ5UP2,BulkQuantity:16,Recheck:0,SF:17|19|44|64|66|24|
        102,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_OBB
X-UUID: ecc929b9a36e4167b39c339ec85e6be3-20231122
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 729157992; Wed, 22 Nov 2023 14:57:07 +0800
Message-ID: <154e624b-f0fa-4925-8ae5-4f176216e724@kylinos.cn>
Date:   Wed, 22 Nov 2023 14:57:06 +0800
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
 <55b77a28-a680-4465-bb57-2a5cb20ce06a@kylinos.cn>
 <e5b458fa-c7ad-424d-8416-2947d684b5dc@intel.com>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <e5b458fa-c7ad-424d-8416-2947d684b5dc@intel.com>
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

Thanks you again for your reply.
I learned. I know how to use it, thanks, I'll look at the existing code 
and add logs to see how it works.

Thanks again.


On 2023/11/21 19:15, Alexander Lobakin wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> Date: Tue, 21 Nov 2023 10:12:17 +0800
> 
>> Thanks for your reply. I understand what you mean, i.e. the caller of
>> 'kasprintf' is responsible for calling 'kfree' to free up memory.
>>
>> My concern is that in many scenarios, the requested memory will be
>> released after a period of use.
>>
>> Has anyone else forgotten to free up the requested memory when using
>> 'kasprintf'? e.g. 'dam_heap_init' calls 'dma_heap_devnode' to allocate
>> memory:
>> dam_heap_init
>>      -> dma_heap_devnode
>>            -> kasprintf
>>              ->kvasprintf
>>                   ->kmalloc_node_track_caller
>>                    -> __kmalloc_node_track_caller
>>                        -> __do_kmalloc_node
>>                            -> kasan_kmalloc
>>
>>
>> There is no function like 'dam_heap_exit' to free the memmory allocated
>> by dma_heap_devnode.
>>
>> Another case is 'cpuid_devnode'. Will this cause a memory leak, and is
>> there a better way to avoid the memory leak in this case?
>>
>> Or is there a uniform place in the memory management module to free up
>> this memory?
> 
> If the lifetime of the allocated buffer equals to the lifetime of the
> kernel, i.e. it's allocated once at kernel init and then used throughout
> the whole uptime, there's no need to free this piece.
> Temporary buffers or buffers allocated from a driver are a different
> story, their lifetime is shorter, which means you always need to
> manually free each of them on exit.
> 
>>
>> Thanks,
>> Kunwu
> Thanks,
> Olek
