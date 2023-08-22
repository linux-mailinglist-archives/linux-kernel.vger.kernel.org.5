Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C8B784149
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbjHVMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235826AbjHVMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:55:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F3CCD0;
        Tue, 22 Aug 2023 05:55:54 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:3563:6666:ae23:a4c4] (unknown [IPv6:2a01:e0a:120:3210:3563:6666:ae23:a4c4])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F1A2660720C;
        Tue, 22 Aug 2023 13:55:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692708952;
        bh=zXRypGU5FsRfhkFlbeXKbtBhVbkG+5Y4xfAintMySxw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ARcDBLfBysC7onBBYtCrspJOHt8EjSFAYAgeuylL762rhXnUM4p5fvNTe7DvIRXPT
         BSHTBxBQKj1T6VjIPUWTrKxwyTUoLQXcrL8j4Z5ocRtVmmuIpCUrT4P+lahDjflprW
         LecaZRMcz4V9esjesDljvzQ/XJ+qtAnNsTL3b2ndkaKpdBbtE/zTpCaphUPYhpo9T1
         gw/LfuDvfdNI6znMPbQze6xvhJPs8I9GTN1hah3HQIOFL7eJ1s4gabuu8aSLCBqV89
         b+hiQVys4wFCRGeKoYYZab+W1908q6RRSKmhV9D5SqPRbghXNrdpw4/PB5Ap7Irp00
         khZZl03hn60LA==
Message-ID: <37dec78e-462c-b7a4-1acb-253520e47c1e@collabora.com>
Date:   Tue, 22 Aug 2023 14:55:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/10] media: verisilicon: Store chroma and motion
 vectors offset
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230705121056.37017-1-benjamin.gaignard@collabora.com>
 <20230705121056.37017-6-benjamin.gaignard@collabora.com>
 <1b87f062-9d5e-fa8e-3d3b-e766362c6e3b@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <1b87f062-9d5e-fa8e-3d3b-e766362c6e3b@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 21/08/2023 à 16:41, Hans Verkuil a écrit :
> On 05/07/2023 14:10, Benjamin Gaignard wrote:
>> Store computed values of chroma and motion vectors offset because
>> they depends on width and height values which change if the resolution
>> change.
> Is this a bug fix? Does this patch belong in this series?
>
> Same actually for the next few verisilicon patches. Shouldn't they be
> part of a separate 'fixes' patch series? It's confusing to see them
> in this series.

They fix bugs that happens only when VP9 resolution change without doing stream off/on
that why they are in this series.

This one, for example, is useless if the resolution change on a keyframe because the
frame will have the same resolution than the current one but is need to store resolution
of each frames if the resize happens between keyframes.

Benjamin

>
> Regards,
>
> 	Hans
>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/verisilicon/hantro.h            | 2 ++
>>   drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c | 6 ++++--
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
>> index c8a3cf10cc64..53be00142473 100644
>> --- a/drivers/media/platform/verisilicon/hantro.h
>> +++ b/drivers/media/platform/verisilicon/hantro.h
>> @@ -320,6 +320,8 @@ struct hantro_vp9_decoded_buffer_info {
>>   	/* Info needed when the decoded frame serves as a reference frame. */
>>   	unsigned short width;
>>   	unsigned short height;
>> +	size_t chroma_offset;
>> +	size_t mv_offset;
>>   	u32 bit_depth : 4;
>>   };
>>   
>> diff --git a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
>> index 6fc4b555517f..6db1c32fce4d 100644
>> --- a/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
>> +++ b/drivers/media/platform/verisilicon/hantro_g2_vp9_dec.c
>> @@ -158,9 +158,11 @@ static void config_output(struct hantro_ctx *ctx,
>>   
>>   	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
>>   	hantro_write_addr(ctx->dev, G2_OUT_CHROMA_ADDR, chroma_addr);
>> +	dst->vp9.chroma_offset = chroma_offset(ctx, dec_params);
>>   
>>   	mv_addr = luma_addr + mv_offset(ctx, dec_params);
>>   	hantro_write_addr(ctx->dev, G2_OUT_MV_ADDR, mv_addr);
>> +	dst->vp9.mv_offset = mv_offset(ctx, dec_params);
>>   }
>>   
>>   struct hantro_vp9_ref_reg {
>> @@ -195,7 +197,7 @@ static void config_ref(struct hantro_ctx *ctx,
>>   	luma_addr = hantro_get_dec_buf_addr(ctx, &buf->base.vb.vb2_buf);
>>   	hantro_write_addr(ctx->dev, ref_reg->y_base, luma_addr);
>>   
>> -	chroma_addr = luma_addr + chroma_offset(ctx, dec_params);
>> +	chroma_addr = luma_addr + buf->vp9.chroma_offset;
>>   	hantro_write_addr(ctx->dev, ref_reg->c_base, chroma_addr);
>>   }
>>   
>> @@ -238,7 +240,7 @@ static void config_ref_registers(struct hantro_ctx *ctx,
>>   	config_ref(ctx, dst, &ref_regs[2], dec_params, dec_params->alt_frame_ts);
>>   
>>   	mv_addr = hantro_get_dec_buf_addr(ctx, &mv_ref->base.vb.vb2_buf) +
>> -		  mv_offset(ctx, dec_params);
>> +		  mv_ref->vp9.mv_offset;
>>   	hantro_write_addr(ctx->dev, G2_REF_MV_ADDR(0), mv_addr);
>>   
>>   	hantro_reg_write(ctx->dev, &vp9_last_sign_bias,
