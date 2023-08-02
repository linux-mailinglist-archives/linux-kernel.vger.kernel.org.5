Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB4E76C857
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjHBIbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjHBIa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:30:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B9171B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 01:30:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B368F6607077;
        Wed,  2 Aug 2023 09:30:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690965056;
        bh=gD3G2+Vh4Sx2fq+2r9LQ48BgKjx3ZfLmsLBj3obugz0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AK5VPExELpYBzwpEnHZ3RL98CEAJEXbn4bDwxsUx7Z2nPwlKiYICQaKdyz/2bIBCB
         gXXDqWyr7H3+rL784I5VX4Ec3uZmDAM9KLBO2hTdjfPEftkTgRm/N8RcnRwmT0hPYQ
         R90dNdFG6Paq2f+D8/PAB3EiiCxGpWSkrOBPVKDg4I+vYw67c4bsM/9p8qq5rPizVj
         F4ONnV9LP9YSxwBkpKySNcMnXUxhDga2bYmEOq48RhyDP7iAeIuI38m0sCKKE5oBJD
         wOKS203XRUMVMyM5wTw/nGxF+yWcTHVwdSeGNOeEMPCehGhMS3u2BsZ2IDaJCzjLKZ
         LC3e84+nD6OZQ==
Message-ID: <ad3c2877-3381-daa1-da38-ce196a645ce3@collabora.com>
Date:   Wed, 2 Aug 2023 10:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 08/13] drm/mediatek: gamma: Support multi-bank gamma
 LUT
To:     =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "ehristev@collabora.com" <ehristev@collabora.com>
References: <20230801115854.150346-1-angelogioacchino.delregno@collabora.com>
 <20230801115854.150346-9-angelogioacchino.delregno@collabora.com>
 <92e1ddd531f9b029b89b1f234b9a1dfbb38d454a.camel@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <92e1ddd531f9b029b89b1f234b9a1dfbb38d454a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/08/23 06:12, CK Hu (胡俊光) ha scritto:
> Hi, Angelo:
> 
> On Tue, 2023-08-01 at 13:58 +0200, AngeloGioacchino Del Regno wrote:
>> Newer Gamma IP have got multiple LUT banks: support specifying the
>> size of the LUT banks and handle bank-switching before programming
>> the LUT in mtk_gamma_set_common() in preparation for adding support
>> for MT8195 and newer SoCs.
>>
>> Suggested-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>> [Angelo: Refactored original commit]
>> Signed-off-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 73 +++++++++++++++----
>> ----
>>   1 file changed, 47 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> index a6f7af1a9e8e..fb7c3650a9f7 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
>> @@ -24,6 +24,8 @@
>>   #define DISP_GAMMA_SIZE				0x0030
>>   #define DISP_GAMMA_SIZE_HSIZE				GENMASK
>> (28, 16)
>>   #define DISP_GAMMA_SIZE_VSIZE				GENMASK
>> (12, 0)
>> +#define DISP_GAMMA_BANK				0x0100
>> +#define DISP_GAMMA_BANK_BANK				GENMASK(1, 0)
>>   #define DISP_GAMMA_LUT				0x0700
>>   
>>   #define DISP_GAMMA_LUT_10BIT_R			GENMASK(29, 20)
>> @@ -32,10 +34,12 @@
>>   
>>   #define LUT_10BIT_MASK				0x03ff
>>   #define LUT_BITS_DEFAULT			10
>> +#define LUT_BANK_SIZE_DEFAULT			512
>>   
>>   struct mtk_disp_gamma_data {
>>   	bool has_dither;
>>   	bool lut_diff;
>> +	u16 lut_bank_size;
>>   	u16 lut_size;
>>   	u8 lut_bits;
>>   };
>> @@ -80,7 +84,9 @@ void mtk_gamma_set_common(struct device *dev, void
>> __iomem *regs,
>>   	void __iomem *lut_base;
>>   	bool lut_diff;
>>   	u8 lut_bits;
>> -	u32 cfg_val, word;
>> +	u16 lut_bank_size;
>> +	u32 cfg_val, lbank_val, word;
>> +	int cur_bank, num_lut_banks;
>>   
>>   	/* If there's no gamma lut there's nothing to do here. */
>>   	if (!state->gamma_lut)
>> @@ -91,41 +97,54 @@ void mtk_gamma_set_common(struct device *dev,
>> void __iomem *regs,
>>   
>>   	if (gamma && gamma->data) {
>>   		lut_diff = gamma->data->lut_diff;
>> +		lut_bank_size = gamma->data->lut_bank_size;
>>   		lut_bits = gamma->data->lut_bits;
>>   	} else {
>>   		lut_diff = false;
>> +		lut_bank_size = LUT_BANK_SIZE_DEFAULT;
> 
> LUT_BANK_SIZE_DEFAULT is only for AAL driver, so place it in AAL driver
> and pass it into this function.
> 

I completely dislike having a function taking too many parameters.

Since mtk_gamma_set() in DISP_GAMMA will anyway expand in the future to
support newer hardware, I'm thinking about just removing AAL support from
this function and duplicate the few (15 or something) lines of code in
mtk_disp_aal instead, so that we stop commonizing the mtk_gamma_set for
both DISP_AAL and DISP_GAMMA.

Any opinions on that?

Regards,
Angelo

> Regards,
> CK
> 
