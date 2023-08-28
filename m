Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6778AE6F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjH1LF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjH1LFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:05:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068F6AB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 04:04:59 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SB4aIC113761;
        Mon, 28 Aug 2023 06:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693220676;
        bh=Wg5gLNloF2HPALm7TXuVipHiVIXcFi/HXierxrbJZJg=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=pV4kqEFk4DaIWp9X3lNVyJDl2XyqWC4hfAKgEUWp7jrrXakRaJKlhN4nugKEnYxwl
         W/+hpEQWG8k3iVv6qMO3Yo0k2y+dRzhgwNRTm9k/8OBzXNKIy06utMi7ZObMRb1sRU
         ocIP+ZpKMuOu/dGx/Wg2I2FM2Lee/SZDr99s7L7I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SB4aI9090914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Aug 2023 06:04:36 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 06:04:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 06:04:36 -0500
Received: from [172.24.227.132] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SB4U9T020731;
        Mon, 28 Aug 2023 06:04:31 -0500
Message-ID: <d2deac24-d5ab-e1c4-81c5-4874c2f5ea07@ti.com>
Date:   Mon, 28 Aug 2023 16:34:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] drm: bridge: it66121: Fix invalid connector dereference
To:     Jai Luthra <j-luthra@ti.com>, Phong LE <ple@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Belin <nbelin@baylibre.com>,
        "Andy.Hsieh" <Andy.Hsieh@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devarsht@ti.com>,
        <nm@ti.com>
References: <20230825-it66121_edid-v1-1-3ab54923e472@ti.com>
Content-Language: en-US
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230825-it66121_edid-v1-1-3ab54923e472@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jai,

Thanks for debugging the issue.

On 25-Aug-23 16:32, Jai Luthra wrote:
> Fix the NULL pointer dereference when no monitor is connected, and the
> sound card is opened from userspace.
> 
> Instead return an error as EDID information cannot be provided to
> the sound framework if there is no connector attached.
> 
> Fixes: e0fd83dbe924 ("drm: bridge: it66121: Add audio support")
> Reported-by: Nishanth Menon <nm@ti.com>
> Closes: https://lore.kernel.org/all/20230825105849.crhon42qndxqif4i@gondola/
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 466641c77fe9..d6fa00dea464 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1446,6 +1446,11 @@ static int it66121_audio_get_eld(struct device *dev, void *data,
>  {
>  	struct it66121_ctx *ctx = dev_get_drvdata(dev);
>  
> +	if (!ctx->connector) {
> +		dev_dbg(dev, "No connector present, cannot provide EDID data");
> +		return -EINVAL;
> +	}
> +

There are not many HDMI bridges that support codecs in the kernel, but
upon a quick look, bridge/analogix/anx7625.c and
bridge/synopsys/dw-hdmi* gracefully return a buffer of 0s when the
connector is unavailable.

I am not sure why that is done, but I also don't see the hdmi-codec
driver handle the 0s situation properly. It is business as usual for the
hdmi-codec.

Did you come across some observation when you were testing?

Regards
Aradhya

>  	mutex_lock(&ctx->lock);
>  
>  	memcpy(buf, ctx->connector->eld,
> 
> ---
> base-commit: 6269320850097903b30be8f07a5c61d9f7592393
> change-id: 20230825-it66121_edid-6ee98517808b
> 
> Best regards,

