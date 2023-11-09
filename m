Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B787E7131
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 19:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjKISHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 13:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbjKISHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 13:07:23 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807BB1727;
        Thu,  9 Nov 2023 10:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699553236;
 bh=jCYEkVdywqRHlC8mhoNYhztpj7Nj5FYnQmn1ZQwqhys=;
 b=iy46jHcyxm+my/KYZwLlm8suZ3fQbnc8/pYkS+x+t3D3l6YiNzOSeCci/SNgUCORqeL6C++95
 gxOJRIFNwsLIJ5emcBexngpe251MP9bTNTR6eXqXMiiUgTUOICIsfXqfpquHTMpHCCS24Mkc2Ul
 govupZCw4YTQMSqlbMUX6DqpUwbKiXfAw5IfBJ6Butu940dwaN0KwjqkcdF3VYXWrexSz4n0mAf
 WYMVYI9JkyFnQOrcfCUnqCkLoPFHCP/hHry8U3YbKpGVF5qqWD2rhzjwzCAzsyfXvG8YyA79rv7
 IEtaD8hl6Pl7Ni/lL3emQCNkxbaJChkpI/MDEOA9rc3g==
Message-ID: <39b740b1-4d00-4afa-8b4f-58b0776b65c8@kwiboo.se>
Date:   Thu, 9 Nov 2023 19:07:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] media: rkvdec: h264: Remove SPS validation at
 streaming start
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231105165521.3592037-1-jonas@kwiboo.se>
 <20231105165521.3592037-6-jonas@kwiboo.se>
 <c75c894a09292775773ad338121ee81924337cf0.camel@collabora.com>
 <bfabc182-4113-46fb-85e9-8550c97d132b@kwiboo.se>
 <f69345217c21af63cf873bfb4a16ae1363b05875.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f69345217c21af63cf873bfb4a16ae1363b05875.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654d1fd4a16ddfebde306cfd
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-08 03:39, Nicolas Dufresne wrote:
> Le mardi 07 novembre 2023 à 23:56 +0100, Jonas Karlman a écrit :
>> On 2023-11-07 23:01, Nicolas Dufresne wrote:
>>> Le dimanche 05 novembre 2023 à 16:55 +0000, Jonas Karlman a écrit :
>>>> SPS parameters is validated in try_ctrl() ops so there is no need to
>>>
>>>                  are
>>>
>>>> re-validate when streaming starts.
>>>>
>>>> Remove the unnecessary call to validate sps at streaming start.
>>>
>>> This patch is not working since user may change the format after the
>>> control have been set. The proper fix should actually reset the SPS
>>> (well all header controls) to match the the newly set format. Then this
>>> validation won't be needed anymore.
>>>
>>> The sequence that is problematic after this patch is:
>>>
>>> S_FMT (OUTPUT, width, height);
>>> S_CTRL (SPS) // valid
>>> S_FMT(OUTPUT, width', height'); // SPS is no longer valid
>>>
>>> One suggestion I may make is to add a ops so that each codec
>>> implementation can reset their header controls to make it valid against
>>> the new resolution. With that in place you'll be able drop the check.
>>
>> According to the Initialization section of the V4L2 stateless
>> documentation a client is supposed to S_CTRL(SPS) after S_FMT(OUTPUT).
> 
> Yes, but other part of the spec prevents us from failing if the
> userspace restart in the middle of the process.
> 
>>
>> https://docs.kernel.org/userspace-api/media/v4l/dev-stateless-decoder.html#initialization
>>
>> I guess that all stateless decoders probably should reset all ctrls to
>> default value on S_FMT(OUTPUT) or decoders may end up in an unexpected
>> state?
>>
>> Is resetting a ctrl value back to default something that is supported by
>> v4l2 ctrl core? Did not find any obvious way to reset a ctrl value.
> 
> In order to avoid having to do this, Hantro driver just ignores these
> values from SPS control and do the following:
> 
> 	reg = G1_REG_DEC_CTRL1_PIC_MB_WIDTH(MB_WIDTH(ctx->src_fmt.width)) |
> 	      G1_REG_DEC_CTRL1_PIC_MB_HEIGHT_P(MB_HEIGHT(ctx->src_fmt.height)) |
> 	      G1_REG_DEC_CTRL1_REF_FRAMES(sps->max_num_ref_frames);
> 
> Then all they do is reset the CAPTURE format whenever needed, matching
> the bit depth that was previously set. The SPS is unfortunatly not
> guarantied to be valid, but at first sight its safe in regard to
> picture dimensions.

The commit 77e74be83083 ("media: rkvdec: h264: Validate and use pic
width and height in mbs") changed to use the SPS values to help fix
decoding of field encoded content, it also added this check.

Will drop this patch in v5, and should also re-add similar validation in
the HEVC series.

Regards,
Jonas

> 
>>
>> Will probably just drop this patch in v5.
> 
> That or do like in Hantro driver. What is scary though is that some of
> the feature enabled by SPS may requires an auxiliary chunk of memory to
> be allocated, and then this method falls appart. I think it would be
> nice to fix that properly in all drivers in a future patchset.
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Nicolas
>>>
>>> p.s. you can also just drop this patch from the series and revisit it
>>> later, though I think its worth fixing.
>>>
>>>>
>>>> Suggested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> v4:
>>>> - No change
>>>>
>>>> v3:
>>>> - New patch
>>>>
>>>>  drivers/staging/media/rkvdec/rkvdec-h264.c | 19 ++-----------------
>>>>  1 file changed, 2 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>>>> index 8bce8902b8dd..815d5359ddd5 100644
>>>> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>>>> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>>>> @@ -1070,17 +1070,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>>>  	struct rkvdec_dev *rkvdec = ctx->dev;
>>>>  	struct rkvdec_h264_priv_tbl *priv_tbl;
>>>>  	struct rkvdec_h264_ctx *h264_ctx;
>>>> -	struct v4l2_ctrl *ctrl;
>>>> -	int ret;
>>>> -
>>>> -	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
>>>> -			      V4L2_CID_STATELESS_H264_SPS);
>>>> -	if (!ctrl)
>>>> -		return -EINVAL;
>>>> -
>>>> -	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
>>>> -	if (ret)
>>>> -		return ret;
>>>>  
>>>>  	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
>>>>  	if (!h264_ctx)
>>>> @@ -1089,8 +1078,8 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>>>  	priv_tbl = dma_alloc_coherent(rkvdec->dev, sizeof(*priv_tbl),
>>>>  				      &h264_ctx->priv_tbl.dma, GFP_KERNEL);
>>>>  	if (!priv_tbl) {
>>>> -		ret = -ENOMEM;
>>>> -		goto err_free_ctx;
>>>> +		kfree(h264_ctx);
>>>> +		return -ENOMEM;
>>>>  	}
>>>>  
>>>>  	h264_ctx->priv_tbl.size = sizeof(*priv_tbl);
>>>> @@ -1100,10 +1089,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>>>  
>>>>  	ctx->priv = h264_ctx;
>>>>  	return 0;
>>>> -
>>>> -err_free_ctx:
>>>> -	kfree(h264_ctx);
>>>> -	return ret;
>>>>  }
>>>>  
>>>>  static void rkvdec_h264_stop(struct rkvdec_ctx *ctx)
>>>
>>
> 

