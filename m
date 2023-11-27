Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035747F9910
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 07:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjK0GFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 01:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjK0GEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 01:04:53 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD657134
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 22:04:45 -0800 (PST)
X-UUID: 50653da09a4049dabfe9bd44e81faa93-20231127
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:a18912e7-1bc6-4131-9ae6-0bcf38ce7786,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.33,REQID:a18912e7-1bc6-4131-9ae6-0bcf38ce7786,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:364b77b,CLOUDID:7390d895-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:231124231739FMC8SLUD,BulkQuantity:3,Recheck:0,SF:19|44|64|66|38|24|1
        7|102,TC:nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 50653da09a4049dabfe9bd44e81faa93-20231127
X-User: chentao@kylinos.cn
Received: from [172.20.15.254] [(116.128.244.169)] by mailgw
        (envelope-from <chentao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1917675565; Mon, 27 Nov 2023 14:04:31 +0800
Message-ID: <9d871364-7baa-4daf-8b0c-3fbfbede6fdb@kylinos.cn>
Date:   Mon, 27 Nov 2023 14:04:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/mm: Fix null-pointer dereference in
 pgtable_cache_add
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "npiggin@gmail.com" <npiggin@gmail.com>
Cc:     "kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20231122090026.11728-1-chentao@kylinos.cn>
 <32077b74-7335-4f4d-8858-c53c820150d0@csgroup.eu>
From:   Kunwu Chan <chentao@kylinos.cn>
In-Reply-To: <32077b74-7335-4f4d-8858-c53c820150d0@csgroup.eu>
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

Hi Christophe,

Thanks for your reply.
It's my bad. According your reply, i read the code in 
sysfs_do_create_link_sd.There is a null pointer check indeed.

My intention was to check null pointer after memory allocation.
Whether we can add a comment here for someone like me, the null pointer 
check is no need here?

Thanks,
Kunwu

On 2023/11/24 23:17, Christophe Leroy wrote:
> 
> 
> Le 22/11/2023 à 10:00, Kunwu Chan a écrit :
>> [Vous ne recevez pas souvent de courriers de chentao@kylinos.cn. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
>>
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure. Ensure the allocation was successful
>> by checking the pointer validity.
> 
> Are you sure this is needed ? Did you check what happens what name is NULL ?
> 
> If I followed stuff correctly, I end up in function
> sysfs_do_create_link_sd() which already handles the NULL name case which
> a big hammer warning.
> 
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>> ---
>>    arch/powerpc/mm/init-common.c | 2 ++
>>    1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
>> index 119ef491f797..0884fc601c46 100644
>> --- a/arch/powerpc/mm/init-common.c
>> +++ b/arch/powerpc/mm/init-common.c
>> @@ -139,6 +139,8 @@ void pgtable_cache_add(unsigned int shift)
>>
>>           align = max_t(unsigned long, align, minalign);
>>           name = kasprintf(GFP_KERNEL, "pgtable-2^%d", shift);
>> +       if (!name)
>> +               return;
>>           new = kmem_cache_create(name, table_size, align, 0, ctor(shift));
>>           if (!new)
>>                   panic("Could not allocate pgtable cache for order %d", shift);
>> --
>> 2.34.1
>>
