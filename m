Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A597A6112
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbjISLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISLVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:21:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F03E3;
        Tue, 19 Sep 2023 04:21:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BAAC433C8;
        Tue, 19 Sep 2023 11:20:59 +0000 (UTC)
Message-ID: <b7b98f37-f9f0-46ef-8ee2-610e2990dfef@xs4all.nl>
Date:   Tue, 19 Sep 2023 13:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/49] media: sti: hva: Use vb2_get_buffer() instead of
 directly access to buffers array
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-8-benjamin.gaignard@collabora.com>
 <93e9b143-664c-4fbb-8722-0beabd5b2c0c@xs4all.nl>
 <ecfd1641-3cce-dfa4-b88c-3619fb12d710@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ecfd1641-3cce-dfa4-b88c-3619fb12d710@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2023 12:26, Benjamin Gaignard wrote:
> 
> Le 19/09/2023 à 11:31, Hans Verkuil a écrit :
>> On 14/09/2023 15:32, Benjamin Gaignard wrote:
>>> Use vb2_get_buffer() instead of directly access to vb2_buffer buffer array.
>>> This could allow to change the type bufs[] field of vb2_buffer structure if
>>> needed.
>>> After each call to vb2_get_buffer() we need to be sure that we get
>>> a valid pointer so check the return value of all of them.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   drivers/media/platform/st/sti/hva/hva-v4l2.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/st/sti/hva/hva-v4l2.c b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>>> index 3a848ca32a0e..326be09bdb55 100644
>>> --- a/drivers/media/platform/st/sti/hva/hva-v4l2.c
>>> +++ b/drivers/media/platform/st/sti/hva/hva-v4l2.c
>>> @@ -577,6 +577,10 @@ static int hva_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
>>>           }
>> Above this line there is a buf->index check...
>>
>>>             vb2_buf = vb2_get_buffer(vq, buf->index);
>>> +        if (!vb2_buf) {
>>> +            dev_dbg(dev, "%s buffer index %d not found\n", ctx->name, buf->index);
>>> +            return -EINVAL;
>>> +        }
>> ...I think that check can be dropped since vb2_get_buffer checks that already.
> 
> No because in "media: sti: hva: Stop direct calls to queue num_buffers field" patch
> I remove the above check since it use queue num_buffers field.

Why not do that here? And drop that later patch? It doesn't make sense to
split it up, and also the commit log of patch 33/49 doesn't match that patch.

Regards,

	Hans

> 
> Regards,
> Benjamin
> 
>>
>> Regards,
>>
>>     Hans
>>
>>>           stream = to_hva_stream(to_vb2_v4l2_buffer(vb2_buf));
>>>           stream->bytesused = buf->bytesused;
>>>       }
>>

