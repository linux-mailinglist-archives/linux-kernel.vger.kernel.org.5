Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F077A5F7D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjISK1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjISK06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:26:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F5EA;
        Tue, 19 Sep 2023 03:26:52 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:f3aa:7b57:c12d:de68] (unknown [IPv6:2a01:e0a:120:3210:f3aa:7b57:c12d:de68])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0458166071A9;
        Tue, 19 Sep 2023 11:26:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695119208;
        bh=9GznNVqH1Ybwr4tIQTMWuRZGIorRMwUugPSjPmcCLZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XO9H4/8C7f+OUKeg1Mkv+AUV19wPV/ZlVGl2jFaXnKFn49tesOobnKUVYgrqzkFdD
         AmgO61O+MqKYj0RPLSjtO1CXKKVhRKhknNmQHBs5FoTRTI1CsOw62ZWYaL9OJvfTuI
         0R4jtMtjVguGXM0jZb/hSOrkXrrtDJ4dV1xldBkR0FE8QSvcIMkM2x/2x47d9aFBSY
         gMKGn3ySqqk6PYDuoiP2T7VnYDpXDfUS6NFnsT7Uvq3YBTQK8PvwkYmNZlu9NcLjH7
         5Vaa+35SR1wCEASc1HRyeax3SKlWLMnnsZ0qABRUIW1jwYCO/9rUz4EwORBOviWy5g
         wjwScOpQKTSQw==
Message-ID: <ecfd1641-3cce-dfa4-b88c-3619fb12d710@collabora.com>
Date:   Tue, 19 Sep 2023 12:26:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v7 07/49] media: sti: hva: Use vb2_get_buffer() instead of
 directly access to buffers array
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
 <20230914133323.198857-8-benjamin.gaignard@collabora.com>
 <93e9b143-664c-4fbb-8722-0beabd5b2c0c@xs4all.nl>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <93e9b143-664c-4fbb-8722-0beabd5b2c0c@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/09/2023 à 11:31, Hans Verkuil a écrit :
> On 14/09/2023 15:32, Benjamin Gaignard wrote:
>> Use vb2_get_buffer() instead of directly access to vb2_buffer buffer array.
>> This could allow to change the type bufs[] field of vb2_buffer structure if
>> needed.
>> After each call to vb2_get_buffer() we need to be sure that we get
>> a valid pointer so check the return value of all of them.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>   drivers/media/platform/st/sti/hva/hva-v4l2.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> index 3a848ca32a0e..326be09bdb55 100644
>> --- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> +++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>> @@ -577,6 +577,10 @@ static int hva_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>>   		}
> Above this line there is a buf->index check...
>
>>   
>>   		vb2_buf = vb2_get_buffer(vq, buf->index);
>> +		if (!vb2_buf) {
>> +			dev_dbg(dev, "%s buffer index %d not found\n", ctx->name, buf->index);
>> +			return -EINVAL;
>> +		}
> ...I think that check can be dropped since vb2_get_buffer checks that already.

No because in "media: sti: hva: Stop direct calls to queue num_buffers field" patch
I remove the above check since it use queue num_buffers field.

Regards,
Benjamin

>
> Regards,
>
> 	Hans
>
>>   		stream = to_hva_stream(to_vb2_v4l2_buffer(vb2_buf));
>>   		stream->bytesused = buf->bytesused;
>>   	}
>
