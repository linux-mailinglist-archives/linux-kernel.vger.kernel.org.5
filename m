Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28738769054
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjGaIgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjGaIgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:36:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211512D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:33:15 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A660C66070F7;
        Mon, 31 Jul 2023 09:32:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690792356;
        bh=VTFtHBGsAs7TMd8TXbJzDrawHMFG0a6Fbla5pSrB+MM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Egk/AhYDhrlbKjNJPisKebvylz0WewiC9unTQAhhCNSj09yc08QBiLWzAI8ziZO+b
         p3BQayZg5xellh8+4yIpFC4jwogHdHsFK/mdxuUu8fYdKur1lGBEzjZnssolejOBQI
         15YcjnimBwCkQbNulusDY0JxAQsOHeGjHe+yIc9onfdeRQEEQZLNy+TSnrLQj0Pu/j
         g7m8PMcNAeIkWyobJB28Kxa93OJnk5/aDcp8pqBBSv06OYTJQ2c5RHNLqo155j/Cea
         zAUj/oT5+INE3cxb6kgZ3L/ndLAiOj9Ij3AhD03EAM/H6e3VAx+4mdM6h5KpoKr6n1
         znpDe6l0xpENA==
Message-ID: <448eb511-d4e6-151a-5d57-288feedcacd8@collabora.com>
Date:   Mon, 31 Jul 2023 11:32:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/4] drm/mediatek: Fix using wrong drm private data to
 bind mediatek-drm
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20230727164114.20638-1-jason-jh.lin@mediatek.com>
 <20230727164114.20638-3-jason-jh.lin@mediatek.com>
 <d74f959b-2255-4587-e99c-2c6b043dc44c@collabora.com>
 <6c07d1bc12c9226bf623da0a46ffaadb151c2175.camel@mediatek.com>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <6c07d1bc12c9226bf623da0a46ffaadb151c2175.camel@mediatek.com>
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

On 7/31/23 11:21, Jason-JH Lin (林睿祥) wrote:
> Hi Eugen,
> 
> Thanks for the reviews.
> 
> On Fri, 2023-07-28 at 11:47 +0300, Eugen Hristev wrote:
>> Hi,
>>
>> On 7/27/23 19:41, Jason-JH.Lin wrote:
>>> Add checking the length of each data path before assigning drm
>>> private
>>> data into all_drm_priv array.
>>>
>>> Fixes: 1ef7ed48356c ("drm/mediatek: Modify mediatek-drm for mt8195
>>> multi mmsys support")
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>> ---
>>>    drivers/gpu/drm/mediatek/mtk_drm_drv.c | 16 +++++++++++++---
>>>    1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> index 249c9fd6347e..d2fb1fb4e682 100644
>>> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
>>> @@ -351,6 +351,7 @@ static bool mtk_drm_get_all_drm_priv(struct
>>> device *dev)
>>>    {
>>>    	struct mtk_drm_private *drm_priv = dev_get_drvdata(dev);
>>>    	struct mtk_drm_private *all_drm_priv[MAX_CRTC];
>>> +	struct mtk_drm_private *temp_drm_priv;
>>>    	struct device_node *phandle = dev->parent->of_node;
>>>    	const struct of_device_id *of_id;
>>>    	struct device_node *node;
>>> @@ -373,9 +374,18 @@ static bool mtk_drm_get_all_drm_priv(struct
>>> device *dev)
>>>    		if (!drm_dev || !dev_get_drvdata(drm_dev))
>>>    			continue;
>>>    
>>> -		all_drm_priv[cnt] = dev_get_drvdata(drm_dev);
>>> -		if (all_drm_priv[cnt] && all_drm_priv[cnt]-
>>>> mtk_drm_bound)
>>> -			cnt++;
>>> +		temp_drm_priv = dev_get_drvdata(drm_dev);
>>> +		if (temp_drm_priv) {
>>> +			if (temp_drm_priv->mtk_drm_bound)
>>> +				cnt++;
>>> +
>>> +			if (temp_drm_priv->data->main_len)
>>> +				all_drm_priv[0] = temp_drm_priv;
>>> +			else if (temp_drm_priv->data->ext_len)
>>> +				all_drm_priv[1] = temp_drm_priv;
>>> +			else if (temp_drm_priv->data->third_len)
>>> +				all_drm_priv[2] = temp_drm_priv;
>>> +		}
>>
>> Previously the code was assigning stuff into all_drm_priv[cnt] and
>> incrementing it.
>> With your change, it assigns to all_drm_priv[0], [1], [2]. Is this
>> what
>> you intended ?
> 
> Because dev_get_drvdata(drm_dev) will get the driver data by drm_dev.
> Each drm_dev represents a display path.
> e,g.
> drm_dev of "mediatek,mt8195-vdosys0" represents main path.
> drm_dev of "mediatek,mt8195-vdosys1" represents ext path.
> 
> So we want to make sure all_drm_priv[] store the private data in
> the order of display path, such as:
> all_drm_priv[0] = the private data of main display
> all_drm_priv[1] = the private data of ext display
> all_drm_priv[2] = the private data of third display

If you have such a hard requirement for keeping elements in an array, 
you are better having
drm_priv_main_display
drm_priv_ext_display
drm_priv_third_display

Keeping them indexed in a three elements array by having no logical 
connection between the number [0,1,2] and the actual displays that you 
want to save is a bit confusing.

One other option which I don't know if it's better or not is to have
macros to hide your indexed approach:
all_drm_priv[MAIN_DISPLAY] ...
etc.

> 
>> If this loop has second run, you will reassign to all_drm_priv again
>> ?
> 
> Because the previous code will store all_drm_priv[] in the order of
> mtk_drm_bind() was called.
> 
> If drm_dev of ext path bound earlier than drm_dev of main path,
> all_drm_priv[] in mtk_drm_get_all_drm_priv() may be re-assigned like
> this:
> all_drm_priv[0]->all_drm_priv[0] = private data of ext path
> all_drm_priv[1]->all_drm_priv[0] = private data of ext path
> all_drm_priv[0]->all_drm_priv[1] = private data of main path
> all_drm_priv[1]->all_drm_priv[1] = private data of main path
> 
> But we expect all_drm_priv[] be re-assigned like this:
> all_drm_priv[0]->all_drm_priv[0] = private data of main path
> all_drm_priv[1]->all_drm_priv[0] = private data of main path
> all_drm_priv[0]->all_drm_priv[1] = private data of ext path
> all_drm_priv[1]->all_drm_priv[1] = private data of ext path

This expectation does not appear to be really enforced in your code.
You have a driver that keeps an array with all_drm_priv[], in which
you can have main path or ext path. Then it's natural that they might 
have whichever order in the array you are placing them into.
If you have a hard enforced order of keeping elements in your array,
then an indexed array is not the best option here.
You can either: move to a different type of array , with macros for 
indexes into the array, or, store a second array/field which keeps the 
index in which you saved each element.

This is just my opinion , by looking at your code.

> 
>> I would expect you to take `cnt` into account.
>> Also, is it expected that all_drm_priv has holes in the array ?
> 
> Each drm_dev will only called mtk_drm_bind() once, so all holes
> will be filled after all drm_dev has called mtk_drm_bind().
> 
> Do you agree with this statement? :)

At the moment I cannot agree nor disagree, I don't know the code well 
enough. But what I can say, is that you should not rely on future calls 
of the function to fill up your array correctly.

> 
> Regards,
> Jason-JH.Lin
> 
>>
>> Eugen
>>
>>
>>
>>>    	}
>>>    
>>>    	if (drm_priv->data->mmsys_dev_num == cnt) {
>>
>>

