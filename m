Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD737E4C16
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343934AbjKGW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKGW5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:57:12 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2DB18C;
        Tue,  7 Nov 2023 14:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699397823;
 bh=63OQgizHEU87zRiwSvu33mfZCT/ztnxnRkDGWR/1lLU=;
 b=bIDMRN/VYHY1n0fc2dDmI+neX3bp6WW8KAO8Ay7WzNULVEbC6DG52D8ez1vm9JUl6QF7v83U7
 p9EIYWOptKN7GLbNxAJRsa4exZT6zEbUID1FdFrWa8izpMNq6oIuNvqYr/MJvQDsDBF/vcrFGIE
 KNB0FyOH+9qfhqdqREejPRIAfkmsa90OfRcRMg9QbdRIE7d1iy3daTk3SuHatusuLireZe6aX6V
 /gTuAn6ciEjGbNn3kOThRAzaX0zqqd9GIkoI+LhnEYTb1xjl7yX5EYRvZiyfmrzjEXPkey3seAU
 tXtIvvAtyN+kVQkmkPi82FgAqgpp1WwP92K/E0tK1W7g==
Message-ID: <bfabc182-4113-46fb-85e9-8550c97d132b@kwiboo.se>
Date:   Tue, 7 Nov 2023 23:56:57 +0100
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
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c75c894a09292775773ad338121ee81924337cf0.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654ac0bea95f640b16f9fb5f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-07 23:01, Nicolas Dufresne wrote:
> Le dimanche 05 novembre 2023 à 16:55 +0000, Jonas Karlman a écrit :
>> SPS parameters is validated in try_ctrl() ops so there is no need to
> 
>                  are
> 
>> re-validate when streaming starts.
>>
>> Remove the unnecessary call to validate sps at streaming start.
> 
> This patch is not working since user may change the format after the
> control have been set. The proper fix should actually reset the SPS
> (well all header controls) to match the the newly set format. Then this
> validation won't be needed anymore.
> 
> The sequence that is problematic after this patch is:
> 
> S_FMT (OUTPUT, width, height);
> S_CTRL (SPS) // valid
> S_FMT(OUTPUT, width', height'); // SPS is no longer valid
> 
> One suggestion I may make is to add a ops so that each codec
> implementation can reset their header controls to make it valid against
> the new resolution. With that in place you'll be able drop the check.

According to the Initialization section of the V4L2 stateless
documentation a client is supposed to S_CTRL(SPS) after S_FMT(OUTPUT).

https://docs.kernel.org/userspace-api/media/v4l/dev-stateless-decoder.html#initialization

I guess that all stateless decoders probably should reset all ctrls to
default value on S_FMT(OUTPUT) or decoders may end up in an unexpected
state?

Is resetting a ctrl value back to default something that is supported by
v4l2 ctrl core? Did not find any obvious way to reset a ctrl value.

Will probably just drop this patch in v5.

Regards,
Jonas

> 
> Nicolas
> 
> p.s. you can also just drop this patch from the series and revisit it
> later, though I think its worth fixing.
> 
>>
>> Suggested-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v4:
>> - No change
>>
>> v3:
>> - New patch
>>
>>  drivers/staging/media/rkvdec/rkvdec-h264.c | 19 ++-----------------
>>  1 file changed, 2 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> index 8bce8902b8dd..815d5359ddd5 100644
>> --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>> +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>> @@ -1070,17 +1070,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>  	struct rkvdec_dev *rkvdec = ctx->dev;
>>  	struct rkvdec_h264_priv_tbl *priv_tbl;
>>  	struct rkvdec_h264_ctx *h264_ctx;
>> -	struct v4l2_ctrl *ctrl;
>> -	int ret;
>> -
>> -	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
>> -			      V4L2_CID_STATELESS_H264_SPS);
>> -	if (!ctrl)
>> -		return -EINVAL;
>> -
>> -	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
>> -	if (ret)
>> -		return ret;
>>  
>>  	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
>>  	if (!h264_ctx)
>> @@ -1089,8 +1078,8 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>  	priv_tbl = dma_alloc_coherent(rkvdec->dev, sizeof(*priv_tbl),
>>  				      &h264_ctx->priv_tbl.dma, GFP_KERNEL);
>>  	if (!priv_tbl) {
>> -		ret = -ENOMEM;
>> -		goto err_free_ctx;
>> +		kfree(h264_ctx);
>> +		return -ENOMEM;
>>  	}
>>  
>>  	h264_ctx->priv_tbl.size = sizeof(*priv_tbl);
>> @@ -1100,10 +1089,6 @@ static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
>>  
>>  	ctx->priv = h264_ctx;
>>  	return 0;
>> -
>> -err_free_ctx:
>> -	kfree(h264_ctx);
>> -	return ret;
>>  }
>>  
>>  static void rkvdec_h264_stop(struct rkvdec_ctx *ctx)
> 

