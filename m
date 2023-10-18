Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7227CD90B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjJRKVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjJRKVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:21:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038D5BA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 03:21:15 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D95E366072F7;
        Wed, 18 Oct 2023 11:21:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697624474;
        bh=kH1jXtunBlMIflxPq7hLuLyoVuwUNlJfO0y0ePDVEoY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jhZdfnzBeekyyVBkDSPRwP3lhZX9sgWCjRuT9AeuqEMyzTIun7LOmijs9oz07+gzl
         4Oj/4DMmMbEHy5CVUx8gn0tEqghbRMbZH61iqT2aS1h4EvUkadcSe9N63zBDZm1jMz
         Y4k9ifoHnRJxlxqDz/fU1MuNtOcMJdNiIo1605gcolbcX1dPRjn7Z7UzgwK9ZzM3Ic
         e0cHpgS6ENEf/KJphA4HFeL5+zPD3ghEFe9mhPoYZ0LjcabnB6C6KAyN3aFp9nQG+N
         75kARIavOnmZPfjstH9PvR+2uHBAU5TyKuOEbwKAozmUftEjsGnVZ05PnRr1mq5HTP
         ++oKz7SDHQUAg==
Message-ID: <54a04d22-7ec1-473b-ab57-f6339b2cc782@collabora.com>
Date:   Wed, 18 Oct 2023 12:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: mediatek: mtk_dsi: Fix NO_EOT_PACKET
 settings/handling
Content-Language: en-US
To:     Michael Walle <mwalle@kernel.org>
Cc:     airlied@gmail.com, chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        shaoming.chen@mediatek.com, yt.shen@mediatek.com
References: <20230523104234.7849-1-angelogioacchino.delregno@collabora.com>
 <20230915101124.283232-1-mwalle@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230915101124.283232-1-mwalle@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/23 12:11, Michael Walle ha scritto:
>> Due to the initial confusion about MIPI_DSI_MODE_EOT_PACKET, properly
>> renamed to MIPI_DSI_MODE_NO_EOT_PACKET, reflecting its actual meaning,
>> both the DSI_TXRX_CON register setting for bit (HSTX_)DIS_EOT and the
>> later calculation for horizontal sync-active (HSA), back (HBP) and
>> front (HFP) porches got incorrect due to the logic being inverted.
>>
>> This means that a number of settings were wrong because....:
>>   - DSI_TXRX_CON register setting: bit (HSTX_)DIS_EOT should be
>>     set in order to disable the End of Transmission packet;
>>   - Horizontal Sync and Back/Front porches: The delta used to
>>     calculate all of HSA, HBP and HFP should account for the
>>     additional EOT packet.
>>
>> Before this change...
>>   - Bit (HSTX_)DIS_EOT was being set when EOT packet was enabled;
>>   - For HSA/HBP/HFP delta... all three were wrong, as words were
>>     added when EOT disabled, instead of when EOT packet enabled!
>>
>> Invert the logic around flag MIPI_DSI_MODE_NO_EOT_PACKET in the
>> MediaTek DSI driver to fix the aforementioned issues.
>>
>> Fixes: 8b2b99fd7931 ("drm/mediatek: dsi: Fine tune the line time caused by EOTp")
>> Fixes: 2d52bfba09d1 ("drm/mediatek: add non-continuous clock mode and EOT packet control")
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Hello CK,

can you please pick this fix?

Thanks,
Angelo

