Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECB5798561
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbjIHKC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238690AbjIHKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:02:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB02128;
        Fri,  8 Sep 2023 03:02:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3A5566607286;
        Fri,  8 Sep 2023 11:02:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694167321;
        bh=CJX6Es8XVyYycbnz90Chqf3r+Q8Nrk3dqnQg+Fy6VtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a+htBuzs035plfZ7GT2pnM9VV2Pnz5NNYpc+o9kzZJSkdROU9a/nZRqxTiPCW4KeI
         8KpEEPJHlTxyYC8Ky6RnNG/ObZoJYITr+cLtxJA+4oPKuoKrXmh7tyLS2HVjOO1w3k
         +vdFJVoGhxG+4uGImhrmThl/OqhuVcIf3GALmitwL+wZNMBEzbcKKuDFg+8XqFmjeO
         ImMpWkSOV2usXSHq3IGF6n7ehNb30XuvquSdTQrk4BLuGAKycTLPGWwJ4kxP/RogZW
         bT5XrBHxGGt/ou/hEFsXYiBAhdX3wksZYaHyh5KqtMN2QHscOB5snXVUKgnimwiLyX
         aD1jiY4pIlT+g==
Message-ID: <a13b0e48-103d-8e3d-6d40-994cbdca9b44@collabora.com>
Date:   Fri, 8 Sep 2023 12:01:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] power: supply: mt6370: Fix missing error code in
 mt6370_chg_toggle_cfo()
To:     ChiaEn Wu <chiaen_wu@richtek.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Sebastian Reichel <sre@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org, error27@gmail.com
References: <20230906084815.2827930-1-harshit.m.mogalapalli@oracle.com>
 <cd6eea67-df0f-08b1-61cd-57a3b4f9cf0d@collabora.com>
 <1092ffb3-0238-4dc0-baf3-344a653fca3f@kadam.mountain>
 <20230908021913.GB3115@linuxcarl2.richtek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230908021913.GB3115@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/09/23 04:19, ChiaEn Wu ha scritto:
> On Thu, Sep 07, 2023 at 02:08:17PM +0300, Dan Carpenter wrote:
> 
> [...]
> 
>>>> diff --git a/drivers/power/supply/mt6370-charger.c b/drivers/power/supply/mt6370-charger.c
>>>> index f27dae5043f5..a9641bd3d8cf 100644
>>>> --- a/drivers/power/supply/mt6370-charger.c
>>>> +++ b/drivers/power/supply/mt6370-charger.c
>>>> @@ -324,7 +324,7 @@ static int mt6370_chg_toggle_cfo(struct mt6370_priv *priv)
>>>>    	if (fl_strobe) {
>>>>    		dev_err(priv->dev, "Flash led is still in strobe mode\n");
>>>> -		return ret;
>>>> +		return -EINVAL;
>>>
>>> I think that returning 0 here was intentional, but I agree on a return ret
>>> here being both confusing and wrong.
>>
>> If it's a success path then probably we should remove the dev_err().
>>
> 
> Hi all,
> Sorry for the late reply!
> 
> I agree with the first half of Angelo's statement, I did make the
> mistake on this 'return ret'.
> What I was trying to say is that you should not to toggle cfo function
> when the FLED of MT6370 is still in "strobe mode".
> 
> Therefore, I think the change of Harshit's patch is correct.
> It should be 'return -EINVAL' or 'return -EPERM' here.
> 
> Thanks!
> 
> 
> Reviewed-by: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> 
> Best regards,
> ChiaEn Wu

Cool. In that case:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
