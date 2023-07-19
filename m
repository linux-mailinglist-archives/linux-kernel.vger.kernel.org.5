Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C66758F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjGSHnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjGSHmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:42:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BB82722
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:41:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 192E8660704A;
        Wed, 19 Jul 2023 08:41:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689752491;
        bh=uZqnrEnBk5Se4RejQnYLycu1F8p+fOOtdn+tXfzQsxw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ub5kiqFAv2Hv41uw6NuoUWUVEErCHDCarMo4w2yE1D3ZM4QDY7CLpF71o90PzLbjB
         XDEF2/WLdcem/xIIcmvXCYWBmc7mRArz3ZvkzY0ugbTqzy1srXzo7KJwIatAaJhWQ5
         XUcBlkG6EejAai4BgT2Cd376Iheyi5H2Y3fUnJt6dcCqUnzFwYZmyTpo3ZIUM6hmw0
         GCi2gtKAbRtkVJbGVxRmIuWpzze0pR7FskPTBQKyGQmqJNEMfLgCyM6PtalytgYBEe
         +jfJzaQktIYhbyVMFFLNlkEXeQQ4N5EOQkYCvzL/YeTY8BLk1EDLfOk98wtIr/P63c
         tGETluUrU+oCA==
Message-ID: <d5c9f1c8-6c05-7679-777a-aa6cec01a3f6@collabora.com>
Date:   Wed, 19 Jul 2023 09:41:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/3] MediaTek DRM: Clean up CMDQ support and ifdefs
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, wenst@chromium.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
 <6c71deca-112e-2ef6-9098-902bc4b92324@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6c71deca-112e-2ef6-9098-902bc4b92324@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/06/23 14:49, Alexandre Mergnat ha scritto:
> 
> 
> On 23/06/2023 11:49, AngeloGioacchino Del Regno wrote:
>> This series changes MediaTek CMDQ support to use the mtk-cmdq-helper
>> functions, removing duplicated cmdq setup code in mtk-drm and also
>> removing all instances of `#if IS_REACHABLE(CONFIG_MTK_CMDQ)` while
>> keeping compatibility with both CONFIG_MTK_CMDQ=n and =m/=y.
>>
>> This applies on top of [1] and [2].
>>
>> [1]:https://lore.kernel.org/lkml/20230524093412.92211-1-angelogioacchino.delregno@collabora.com
>> [2]:https://lore.kernel.org/lkml/20230608084727.74403-1-angelogioacchino.delregno@collabora.com
> 
> Hi Angelo,
> 
> Can you provide a public branch to test it please ?
> I tried to apply the dependencies but still have an issue with the 3rd one:
> 
> https://lore.kernel.org/lkml/20230523104234.7849-1-angelogioacchino.delregno@collabora.com
> OK
> 
> https://lore.kernel.org/lkml/20230524093412.92211-1-angelogioacchino.delregno@collabora.com
> OK
> 
> https://lore.kernel.org/lkml/20230608084727.74403-1-angelogioacchino.delregno@collabora.com
> KO
> 
> Thanks
> 

Sorry for the very late reply; I've somehow lost this email in the haystack...

There you go:
https://gitlab.collabora.com/google/chromeos-kernel/-/commits/for-kernelci/

Cheers,
Angelo
