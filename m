Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0706977E1BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245271AbjHPMhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243973AbjHPMhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:37:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989641FDC;
        Wed, 16 Aug 2023 05:37:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DDA362081;
        Wed, 16 Aug 2023 12:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67732C433C8;
        Wed, 16 Aug 2023 12:37:04 +0000 (UTC)
Message-ID: <89e72ad4-573d-2fa2-9883-9cbedc8c00ff@xs4all.nl>
Date:   Wed, 16 Aug 2023 14:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in
 encoder queue_setup
Content-Language: en-US, nl
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230810082333.972165-1-harperchen1110@gmail.com>
 <5a70c141736e91f635f71d9922a3bbe993a76c69.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <5a70c141736e91f635f71d9922a3bbe993a76c69.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 15:58, Nicolas Dufresne wrote:
> Hi,
> 
> Le jeudi 10 août 2023 à 08:23 +0000, Wei Chen a écrit :
>> variable *nplanes is provided by user via system call argument. The
>> possible value of q_data->fmt->num_planes is 1-3, while the value
>> of *nplanes can be 1-8. The array access by index i can cause array
>> out-of-bounds.
>>
>> Fix this bug by checking *nplanes against the array size.
>>
>> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
>> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
>> Cc: stable@vger.kernel.org
>> ---
>> Changes in v2:
>> - Add Fixes tag and CC stable email address
>> - Change the title to be more expressive
>>
>>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> index 9ff439a50f53..9e8817863cb8 100644
>> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
>> @@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
>>  		return -EINVAL;
>>  
>>  	if (*nplanes) {
>> +		if (*nplanes != q_data->fmt->num_planes)
>> +			return -EINVAL;
> 
> I don't think the claim really exists. 	For this driver, when *nplane is set,
> it will be:
> 
> 
>         case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
>                 requested_planes = f->fmt.pix_mp.num_planes;
>                 if (requested_planes == 0 ||
>                     requested_planes > VIDEO_MAX_PLANES)
>                         return -EINVAL;
>                 for (i = 0; i < requested_planes; i++)
>                         requested_sizes[i] =
>                                 f->fmt.pix_mp.plane_fmt[i].sizeimage;
>                 break;
> 
> Or the value the driver have set it in the previous call with *nplane == 0. So
> unless there is a bug, this should not happen, and more importantly, the core
> should not let that happen, meaning it should not be driver jobs to validate
> this.
> 
> my 2 cents,
> Nicolas
> 
> 
>>  		for (i = 0; i < *nplanes; i++)
>>  			if (sizes[i] < q_data->sizeimage[i])

It's q_data->sizeimage that has only 3 elements, so if *nplanes is 4, then
this will fail with an OOB.

However, I think the check should really happen in the vb2 core. If no
buffers have been allocated yet, then the queue_setup callback will set
the number of planes based on the current format.

If CREATE_BUFS is called afterwards, then *nplanes is set to the number
of planes that is specified in the format field of struct v4l2_create_buffers.

The core clips that value to the range [1..VIDEO_MAX_PLANES], but otherwise it
places no restrictions.

I was afraid that this would cause serious problems if fewer planes are
requested than the current format needs, but in that case the size checks
in the buf_prepare callback of the driver will fail (since one or more planes
will have size 0).

The idea behind allowing userspace to allocate different number of planes
in CREATE_BUFS really makes little sense and there are no drivers that rely
on this. It would be much better if the vb2 core would return -EINVAL if
the requested number of planes does not match that of what is used for already
allocated buffers.

If we ever get drivers that for some reason want more flexibility, then those
drivers can set a special flag indicating that they want to check this themselves.

I'll post a patch adding the check to the vb2 core.

Regards,

	Hans

>>  				return -EINVAL;
> 

