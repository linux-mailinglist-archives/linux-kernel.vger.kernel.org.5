Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62C7A7487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjITHoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjITHoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9CFD3;
        Wed, 20 Sep 2023 00:44:07 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:def9:8f6c:3807:7d89] (unknown [IPv6:2a01:e0a:120:3210:def9:8f6c:3807:7d89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47BA36602173;
        Wed, 20 Sep 2023 08:44:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695195845;
        bh=eSYDs+qZU32e2E7cB12pTV5zRWbHto0dzuV5YKjfLWo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xalbv7WF546UBvMJ/uGdPNld1qXxWIZmEZBQNskDrTzN3Kc+mJm2K9bvp4I5jtKtk
         xh/X+B7ucMdy42dseAz54rg4P7I9YJA/3FoQItb9vwQqHPyUNl7fc+dshVakekBHXb
         QcP1y4mgDUSV5tY2k7TpkbMndUSxWS785NAY9lNPZHJ6xrOwqoVA0akSgEhrXfyBKv
         Zwaxq58FH2PeIV5GsXJ0NbMHwbSwRC/aW/RyPQ+MIUv1c82tP51tb2XKxB3Y308Gqb
         6NwPnaeD8HFNYScL6HU9hUz1inEGA8duZz+ac3Je4mIy3XMK6cx+laUynATVkjms8Q
         FvmXdUFWloOmA==
Message-ID: <f6332d70-4392-3eee-edaa-0f7e4308fa67@collabora.com>
Date:   Wed, 20 Sep 2023 09:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 16/49] media: verisilicon: postproc: Fix down scale
 test
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-17-benjamin.gaignard@collabora.com>
 <cbfef598-8faa-40e6-8dc2-a1efd03f9560@xs4all.nl>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <cbfef598-8faa-40e6-8dc2-a1efd03f9560@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/09/2023 à 13:16, Hans Verkuil a écrit :
> On 14/09/2023 15:32, Benjamin Gaignard wrote:
>> Do not allow down scaling if the source buffer resolution is
>> smaller  than destination one.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Fixes: fbb6c848dd89 ("media: destage Hantro VPU driver")
> Is this really a fix? I gather that this relies on "VP9 resolution change without
> doing stream off/on" support, and support for that is added by these patches.
>
> Adding the Fixes tag would cause stable maintainers to queue this patch up for
> older kernels, but I don't think that is needed here at all.
>
> And related I also think that this really does not belong to this patch series.
>
> As I understand it, patch 13/49 extends the verisilicon driver to support more
> than 32 buffers, so that one makes sense in the context of this series.
>
> But the other verisilicon patches appear to be unrelated and instead add a new
> feature, and I don't believe it relates to this series at all.
>
> If I am right, then please post this as a separate series, possibly mentioning
> that it sits on top of this series.

Marek has send the same patch and got it merged in stage branch:
https://patchwork.kernel.org/project/linux-media/patch/20230824013935.303132-1-marex@denx.de/
so I can skip it now.

The other patches are needed to enable VP9 dynamic resolution change, which is the feature
I target with this series.
2 patches fix chroma / motion vector offset issues.
1 allow to change the resolution while stream.

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>> ---
>>   drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
>> index e624cd98f41b..77d8ecfbe12f 100644
>> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
>> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
>> @@ -107,7 +107,7 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
>>   
>>   static int down_scale_factor(struct hantro_ctx *ctx)
>>   {
>> -	if (ctx->src_fmt.width == ctx->dst_fmt.width)
>> +	if (ctx->src_fmt.width <= ctx->dst_fmt.width)
>>   		return 0;
>>   
>>   	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);
>
