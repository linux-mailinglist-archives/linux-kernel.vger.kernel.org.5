Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5302376E3D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHCJBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjHCJBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:01:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93746E46;
        Thu,  3 Aug 2023 02:01:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A204A6607194;
        Thu,  3 Aug 2023 10:01:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691053296;
        bh=yJ1thvUjgcsARtQ4vh75a2lFkbz03xQuRAuMRkmA7Vc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IQzNd5N0RZlqCqP4tHgtA5J+6RLc2MYubdY/w/zcQi28Vbh6mu86cqQBVVPurstzt
         aYb5BExnkjMM2RzeiH83xZUuDRSpdGmJvqzen+p7YhuBekktqrAj/v8JOok7FNzv46
         u9rlXk/6fCamD3QOA3k65N1Z+e/Nt/0eLqtXfRUPXdqpW8kxX/EeLYt08k0gzPcRso
         LcyYxCPvmPHegBWkSwfg84LCoQdwGLinvaZwB8f/I4Y91xyJ+hrSp4oGdidV+TCcza
         7c3V80AcbkO/8LtQkmCcDZ0txJ4wUAK5FdMkF4PqM7pnRGRJzXQnJVo9iY1w4/GBNQ
         rfSilzmG2oE9w==
Message-ID: <aa8f232f-701a-5b4c-eda8-89fc0e6fe5a8@collabora.com>
Date:   Thu, 3 Aug 2023 11:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/9] mfd: mt6397: Split MediaTek MT6366 PMIC out of MT6358
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803074249.3065586-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
> The MT6366 PMIC is mostly, but not fully, compatible with MT6358. It has
> a different set of regulators. Specifically, it lacks the camera related
> VCAM* LDOs, but has additional VM18, VMDDR, and VSRAM_CORE LDOs.
> 
> Add a separate compatible for the MT6366 PMIC. The regulator cell for
> this new entry uses a new compatible string matching MT6366.
> 
> Fixes: c47383f84909 ("mfd: Add support for the MediaTek MT6366 PMIC")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I agree in that the LDOs are a bit different, but that's handled by the
mt6358-regulator driver regardless of the actual devicetree compatible,
as that's selected through a chip_id check.

Finally, looking at the driver implementation itself, the addition of a
specific mt6366 compatible here seems redundant, because the actual HW is
  - Handled by drivers, but
  - Described by bindings

Any other opinions on this?

Regards,
Angelo

> ---
>   drivers/mfd/mt6397-core.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index f6c1f80f94a4..3f8dfe60a59b 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -206,6 +206,26 @@ static const struct mfd_cell mt6359_devs[] = {
>   	},
>   };
>   
> +static const struct mfd_cell mt6366_devs[] = {
> +	{
> +		.name = "mt6358-regulator",
> +		.of_compatible = "mediatek,mt6366-regulator"
> +	}, {
> +		.name = "mt6358-rtc",
> +		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
> +		.resources = mt6358_rtc_resources,
> +		.of_compatible = "mediatek,mt6358-rtc",
> +	}, {
> +		.name = "mt6358-sound",
> +		.of_compatible = "mediatek,mt6358-sound"
> +	}, {
> +		.name = "mt6358-keys",
> +		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
> +		.resources = mt6358_keys_resources,
> +		.of_compatible = "mediatek,mt6358-keys"
> +	},
> +};
> +
>   static const struct mfd_cell mt6397_devs[] = {
>   	{
>   		.name = "mt6397-rtc",
> @@ -280,6 +300,14 @@ static const struct chip_data mt6359_core = {
>   	.irq_init = mt6358_irq_init,
>   };
>   
> +static const struct chip_data mt6366_core = {
> +	.cid_addr = MT6358_SWCID,
> +	.cid_shift = 8,
> +	.cells = mt6366_devs,
> +	.cell_size = ARRAY_SIZE(mt6366_devs),
> +	.irq_init = mt6358_irq_init,
> +};
> +
>   static const struct chip_data mt6397_core = {
>   	.cid_addr = MT6397_CID,
>   	.cid_shift = 0,
> @@ -358,6 +386,9 @@ static const struct of_device_id mt6397_of_match[] = {
>   	}, {
>   		.compatible = "mediatek,mt6359",
>   		.data = &mt6359_core,
> +	}, {
> +		.compatible = "mediatek,mt6366",
> +		.data = &mt6366_core,
>   	}, {
>   		.compatible = "mediatek,mt6397",
>   		.data = &mt6397_core,


