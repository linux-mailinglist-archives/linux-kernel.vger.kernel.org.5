Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4075AEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjGTMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTMrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:47:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013F32690;
        Thu, 20 Jul 2023 05:47:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9B41660703D;
        Thu, 20 Jul 2023 13:47:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689857266;
        bh=ZgHpOz5P4a3+RUYc0FlSzSAD1mZgKKcEW/6wH6JQze4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kl4krZJ+/sd7l3cwiDMFKJ5bakRMFaUfX1KhVTaIRt8bS4NM3VagGYjfqxatp7/5y
         HZMk1XhgFnlkAazOf2OOdflrkkh4AO+biZ5Ia5Us88mU2WGyEYW6tXkwTfyzyJqIKB
         Vuc3oLvOdFe0+XoYUdHUk6idBEtovXYBHTctZ+8pAj75Ow6rJhbq07ftjgFrf6mnI5
         Q5AbibEg3V85VC5nxOquc+oyQqSMFwSJTDHclbbHxRPLeeHqaeQqR6p7A70xm7bzac
         wh7W890bqFnTS4KK+7yCygZHthCzCkce2BHn5n6jElCTcPJLMOWYt8I+5XxKc7Asq+
         Fd4i3BelVSMMA==
Message-ID: <c2b8d1dc-fdbe-5ea6-89d6-6b1113fc3a55@collabora.com>
Date:   Thu, 20 Jul 2023 14:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: mdp3: Fix resource leak in a
 for_each_child_of_node() loop
Content-Language: en-US
To:     Lu Hongfei <luhongfei@vivo.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>, Sun Ke <sunke32@huawei.com>,
        Deepak R Varma <drv@mailo.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     "opensource.kernel" <opensource.kernel@vivo.com>
References: <20230720062248.37906-1-luhongfei@vivo.com>
 <32ae3716-672f-cdc2-f246-d8336ed44a68@collabora.com>
 <30bf6cc7-615b-52c5-0c23-f8b4be890e5e@vivo.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <30bf6cc7-615b-52c5-0c23-f8b4be890e5e@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/07/23 14:19, Lu Hongfei ha scritto:
> On 2023/7/20 15:51, AngeloGioacchino Del Regno wrote:
>> [Some people who received this message don't often get email from
>> angelogioacchino.delregno@collabora.com. Learn why this is important
>> at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Il 20/07/23 08:23, Lu Hongfei ha scritto:
>>> for_each_child_of_node should have of_node_put()
>>> in error path avoid resource leaks.
>>>
>>> Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
>>> ---
>>> Changelog:
>>> v1->v2:
>>> 1. Change the subject line of this patch to include driver name.
>>> 2. Remove the unneeded of_node_put.
>>>
>>>    drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
>>> b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
>>> index a605e80c7dc3..40c4b79a5090 100644
>>> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
>>> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
>>> @@ -1135,6 +1135,7 @@ int mdp_comp_config(struct mdp_dev *mdp)
>>>                comp = mdp_comp_create(mdp, node, id);
>>>                if (IS_ERR(comp)) {
>>>                        ret = PTR_ERR(comp);
>>> +                     of_node_put(node);
>>>                        goto err_init_comps;
>>>                }
>>>
>>
>> In case mdp_comp_sub_create() fails, we still want to decrease the
>> refcount
>> of `node`....
>>
>> ...so, just call of_node_put(node) just once, at the err_init_comps
>> label.
>>
>> err_init_comps:
>>         mdp_comp_destroy(mdp);
>>         of_node_put(node);
>>         return ret;
>>
>> Regards,
>> Angelo
> 
> mdp_comp_sub_create() executes after for_each_child_of_node loop ends.
> 
> The for_each_child_of_node loop ended, node == NULL and there is nothing
> to put.
> 
> So I don't think it's necessary to decrease the refcount of `node` again
> when
> 
> mdp_comp_sub_create() fails.
> 
> Or you could further explain the reason for doing so.
> 

You're right. My bad.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
