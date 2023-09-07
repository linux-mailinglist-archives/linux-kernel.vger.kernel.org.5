Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D34797767
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbjIGQZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjIGQX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:23:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEEE1FDD;
        Thu,  7 Sep 2023 09:21:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6248466072F2;
        Thu,  7 Sep 2023 10:12:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694077952;
        bh=txj28e2rFnpZ/La9QTIPO2i7dPQpL4MVK8cI2Wz9RV4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z6KERubW6Sf7yxuxP8OS2Q8ygMnvH6e/8FLKTuDdX0hX3BxowDU7BeD+FbyysPmCX
         mducm2u2B8Z5rJqGyXnoZejgKQK9tobFqO1C87HCrDoy87sGlJa0CItY6q+WbkMSLF
         0QDN8Y8VHKMmX6fvXmfqVwCfKkqsZmgqB25pBGMp72frDopeR3+JHUWz4Pn7c4ToVC
         bDJWPXk5mEo2chli0T3KFXj31UpsUwLknnBSy3DGtuFqHfHsfniHDSkJahxGUuCZH7
         Aezx/lcYvT1OOV4BgIRHWto0fhNlHVN3hi7qXJDK6X3JgT/itoXzbj9wLAhNH5OeC0
         Gw43YRFrU7unQ==
Message-ID: <adc88393-da14-90ff-82c2-b00a9771856c@collabora.com>
Date:   Thu, 7 Sep 2023 11:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] thermal/drivers/mediatek: fix temperature on mt7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        stable@vger.kernel.org
References: <20230901063730.7577-1-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230901063730.7577-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/09/23 08:37, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Reading thermal sensor on mt7986 devices returns invalid temperature:
> 
> bpi-r3 ~ # cat /sys/class/thermal/thermal_zone0/temp
>   -274000
> 
> Fix this by adding missing members in mtk_thermal_data struct which were
> used in mtk_thermal_turn_on_buffer after commit 33140e668b10.
> 
> Cc: stable@vger.kernel.org
> Fixes: 33140e668b10 ("thermal/drivers/mediatek: Control buffer enablement tweaks")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

If you resend this commit without the RFC tag I can give you a R-b.

This is totally correct, as the buffer control is for version >= THERMAL_V2, and
the others being V1 don't need it - the only one that was left out is effectively
just mt7986 (probably because the commits landed around the same time).

Though, since you have to anyway resend this, I would suggest to change the commit
title to something more effective, like

thermal/drivers/mediatek: Fix control buffer enablement on MT7896

Cheers,
Angelo

> ---
>   drivers/thermal/mediatek/auxadc_thermal.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/mediatek/auxadc_thermal.c
> index f59d36de20a0..ed08767eaa60 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -691,6 +691,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
>   	.adcpnp = mt7986_adcpnp,
>   	.sensor_mux_values = mt7986_mux_values,
>   	.version = MTK_THERMAL_V3,
> +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +	.apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
> +	.apmixed_buffer_ctl_set = BIT(0),
>   };
>   
>   static bool mtk_thermal_temp_is_valid(int temp)


