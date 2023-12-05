Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B887805BAC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346209AbjLERgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346120AbjLERgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:36:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5560FCA;
        Tue,  5 Dec 2023 09:36:56 -0800 (PST)
Received: from [100.90.159.192] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B760866072A7;
        Tue,  5 Dec 2023 17:36:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701797815;
        bh=D+BnC18dTewKG1sYUbVzU1UQZRYC0I7GsxPXzOUgVz8=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=TCv6P8tjumaojN4l2jHlx/wDgUI1veQ5m1geiEqrwI4i4bUW39XwQAS9QWbVskzbK
         krpHBbvW5oiKHqYfWR1cVGzaUhRYKi4pZRx5wVMZZESyhBH5TV29i+y6D+ek7+9lJz
         pu78E++D7lfHnN6Tvd8TZI3nCpq/c/SXqNbBZ0mkxext2dvJOQpuTj+nUzWD1yMws5
         /YWD69LRDL2dnrAgZVvfAom89rc1Q/KfYRTiqJao4ewbvV4ARkfKMDId304oHf3rVV
         aDWTlrKUUytKiuZ0TsODB4bzHBGmehCJ+HpvVMRjMdyzhOOsiZFn+sv+izgXmWN+ao
         o4JZyqQowy+3A==
Message-ID: <e891ae21-2b3a-4d99-9f5c-fb387438ffef@collabora.com>
Date:   Tue, 5 Dec 2023 17:36:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Robert Beckett <bob.beckett@collabora.com>
Subject: Re: [PATCH] Fix memory leaks in wave5_vpu_open_enc() and
 wave5_vpu_open_dec()
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Zeng Chi <zengchi@kylinos.cn>, nas.chung@chipsnmedia.com,
        jackson.lee@chipsnmedia.com, mchehab@kernel.org,
        sebastian.fricke@collabora.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204091649.3418987-1-zengchi@kylinos.cn>
 <a4c47b282d9e3bc5c2891ac1b9cafb9c9970975c.camel@collabora.com>
Content-Language: en-US
In-Reply-To: <a4c47b282d9e3bc5c2891ac1b9cafb9c9970975c.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/12/2023 13:55, Nicolas Dufresne wrote:
> Hi,
>
> Le lundi 04 décembre 2023 à 17:16 +0800, Zeng Chi a écrit :
>> This patch fixes memory leaks on error escapes in wave5_vpu_open_enc()
>> and wave5_vpu_open_dec().
> Please avoid sending twice the same patch. This is still a NAK.

tbf, this is a different patch, concerning the allocation of the 
codec_info within inst, not inst itself.

> regards,
> Nicolas
>
>> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
>> Signed-off-by: Zeng Chi<zengchi@kylinos.cn>
>> ---
>>   drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 5 +++--
>>   drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 5 +++--
>>   2 files changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> index 8b1417ece96e..b0a045346bb7 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> @@ -1802,9 +1802,10 @@ static int wave5_vpu_open_dec(struct file *filp)
>>   	spin_lock_init(&inst->state_spinlock);
>>   
>>   	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
>> -	if (!inst->codec_info)
>> +	if (!inst->codec_info) {
>> +		kfree(inst);

for consistency, would be better to jump to cleanup_inst.

Also, maybe consider embedding codec_info  in to struct vpu_instance to 
avoid the double alloc. I've not checked whether this is viable 
throughout the code, but from a quick scan of the original patch, it 
looks like it is always allocated and freed alongside inst.

>>   		return -ENOMEM;
>> -
>> +	}
>>   	v4l2_fh_init(&inst->v4l2_fh, vdev);
>>   	filp->private_data = &inst->v4l2_fh;
>>   	v4l2_fh_add(&inst->v4l2_fh);
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> index f29cfa3af94a..bc94de9ea546 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
>> @@ -1546,9 +1546,10 @@ static int wave5_vpu_open_enc(struct file *filp)
>>   	inst->ops = &wave5_vpu_enc_inst_ops;
>>   
>>   	inst->codec_info = kzalloc(sizeof(*inst->codec_info), GFP_KERNEL);
>> -	if (!inst->codec_info)
>> +	if (!inst->codec_info) {
>> +		kfree(inst);
>>   		return -ENOMEM;
>> -
>> +	}
>>   	v4l2_fh_init(&inst->v4l2_fh, vdev);
>>   	filp->private_data = &inst->v4l2_fh;
>>   	v4l2_fh_add(&inst->v4l2_fh);
