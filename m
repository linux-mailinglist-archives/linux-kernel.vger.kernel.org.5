Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9367A9F67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjIUUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjIUUVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:21:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DD902E;
        Thu, 21 Sep 2023 10:23:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 67FCB6607285;
        Thu, 21 Sep 2023 08:18:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695280681;
        bh=u+SDF/PNL5Ju2+whiov9Et6DghwzY6lUPs+GJOtpLPk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RL8DToJNQahbJaZooqiEqG8PJe63aN8SdCp6AfAplEVykYDHO7c3GVAVMpGB74dO1
         a5ljz6v7vbGTqnOhJTDOy+iZi8ldmc5h69baoWulk54LbBJ2OtyWvia73/YgSrfm0K
         UXtHYcmXE3SqUiD4Ba/G7UShpSWFNS7VPSOAlEs30TiabER69pZBp//qX6uDlfMUZz
         QHc73AxBFMZrr+ZKUj0fc5FgjLSR/mCImmoC+umJnrzk5NBKZGapn8MryzY8H0Llpz
         t2MFNh8zL5BcMRX26UpBymze5ym+bTB2AeWN2l7BbGDmJSM0hcJ6lx2S0wrEHr181F
         pDDJWBQ8q0ugA==
Message-ID: <c9780f70-62b5-e151-0ac6-11d97a694439@collabora.com>
Date:   Thu, 21 Sep 2023 09:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] remoteproc: mediatek: Refactor single core check and fix
 retrocompatibility
To:     Laura Nao <laura.nao@collabora.com>
Cc:     andersson@kernel.org, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org,
        matthias.bgg@gmail.com, tinghan.shen@mediatek.com,
        wenst@chromium.org
References: <20230919092336.51007-1-angelogioacchino.delregno@collabora.com>
 <20230920150332.318851-1-laura.nao@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230920150332.318851-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/23 17:03, Laura Nao ha scritto:
> On 9/19/23 11:23, AngeloGioacchino Del Regno wrote:
>> In older devicetrees we had the ChromeOS EC in a node called "cros-ec"
>> instead of the newer "cros-ec-rpmsg", but this driver is now checking
>> only for the latter, breaking compatibility with those.
>>
>> Besides, we can check if the SCP is single or dual core by simply
>> walking through the children of the main SCP node and checking if
>> if there's more than one "mediatek,scp-core" compatible node.
>>
>> Fixes: 1fdbf0cdde98 ("remoteproc: mediatek: Probe SCP cluster on multi-core SCP")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>    drivers/remoteproc/mtk_scp.c | 18 +++++++-----------
>>    1 file changed, 7 insertions(+), 11 deletions(-)
>>
> 
> Tested on asurada (spherion) and jacuzzi (juniper). The issue was detected by KernelCI, so:
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Tested-by: Laura Nao <laura.nao@collabora.com>
> 

Thanks for pointing out the correct Reported-by tag! :-)

Cheers,
Angelo

