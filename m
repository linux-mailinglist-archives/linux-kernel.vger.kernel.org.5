Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E257FD0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjK2I21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjK2I2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:28:25 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C30C1;
        Wed, 29 Nov 2023 00:28:32 -0800 (PST)
Received: from [100.122.216.38] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7F966607323;
        Wed, 29 Nov 2023 08:28:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701246510;
        bh=GH0s/Fttm7ldDPrPcesNwd4eFcRbMEUBxt6JF/mvubQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AOg00+l7rWlIFKs36F0WZsmnVAETahGHYtGsPwkeSzeMdCovY3QeGBB85AqT7ycU1
         SSShTTnCVZMFmcg3lKXPVTWRowQGiBphH9+nAWz8fYP8bIF7NSyPMMyewacj/PdaL1
         P48guy85Wm9T30Kvh6TsxttPBDc5EGhNRtameRoRHHk4UkWpakqTpKHjL9wdUoCi0A
         qhN5wfHmafx6Dc7sHWmg+Y+Q9FXPQOCNTiNF3Bk0fkBgoWqWG8uDinaM59Fegbu2wO
         l5W7P0kqNpKYySU+ImJUQiT4iwI3yVE82Si2YZZqMkUD/Az/LE0mtUH+sS4Fnrhtg5
         Cty/T7xXXxz6g==
Message-ID: <b68b3fa5-a152-4b23-9451-61a89530512c@collabora.com>
Date:   Wed, 29 Nov 2023 09:28:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/55] media: imx8-isi: Stop abusing of min_buffers_needed
 field
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        hverkuil@xs4all.nl, mchehab@kernel.org, m.szyprowski@samsung.com,
        matt.ranostay@konsulko.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
References: <20231127165454.166373-1-benjamin.gaignard@collabora.com>
 <20231127165454.166373-8-benjamin.gaignard@collabora.com>
 <20231127170700.GC31314@pendragon.ideasonboard.com>
 <6fa1ec09-3e30-475e-9718-29d23586753e@collabora.com>
 <CAAFQd5DCVTLpPoKSp_OA6fe_Hqt-oV7=AsCZWSmkJORvLSgUiw@mail.gmail.com>
 <995eb6c2-cc7f-4217-bc37-4ab1a32f36ee@collabora.com>
 <CAAFQd5Bv5kc9TfNM5CkKowvaoRndTmkmU6+0LyCG8YbOKy=hxQ@mail.gmail.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAFQd5Bv5kc9TfNM5CkKowvaoRndTmkmU6+0LyCG8YbOKy=hxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 29/11/2023 à 05:17, Tomasz Figa a écrit :
> On Tue, Nov 28, 2023 at 7:26 PM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>>
>> Le 28/11/2023 à 10:35, Tomasz Figa a écrit :
>>> On Tue, Nov 28, 2023 at 6:31 PM Benjamin Gaignard
>>> <benjamin.gaignard@collabora.com> wrote:
>>>> Le 27/11/2023 à 18:07, Laurent Pinchart a écrit :
>>>>> Hi Benjamin,
>>>>>
>>>>> Thank you for the patch.
>>>>>
>>>>> On Mon, Nov 27, 2023 at 05:54:06PM +0100, Benjamin Gaignard wrote:
>>>>>> 'min_buffers_needed' is suppose to be used to indicate the number
>>>>>> of buffers needed by DMA engine to start streaming.
>>>>>> imx8-isi driver doesn't use DMA engine and just want to specify
>>>>> What do you mean, "doesn't use DMA engine" ? The ISI surely has DMA
>>>>> engines :-)
>>>> I have done assumption on drivers given if they use or dma_* functions.
>>> I suspect the use of vb2_dma_sg_plane_desc() and
>>> vb2_dma_contig_plane_dma_addr() may be more correlated to whether
>>> there is a DMA involved or not. Usually V4L2 drivers don't really have
>>> to deal with the DMA API explicitly, because the vb2 framework handles
>>> most of the work.
>> Unfortunately isn't not true either, for example verisilicon driver use
>> these function but doesn't need DMA engine.
> That sounds weird. Why would a driver that doesn't have a DMA engine
> need to obtain a scatterlist or the DMA address of the buffer?

Just because the hardware needs the physical address of the buffer to access it.

>
>> I haven't found yet a 100% criteria to decide if driver use or not DMA engine
>> so I plan to fix case by case given maintainers remarks.
> Yeah, there probably wouldn't be a way that would give one a 100%
> certainty, although I'd still insist that the two functions I
> mentioned should be close to that. Of course a driver can use those
> functions for some queues, while other queues would be pure software
> queues, e.g. for some metadata - a simple grep is not enough. Is that
> perhaps the case for the verisilicon driver?

Verisilicon hardware block doesn't have IOMMU so it needs the physical
addresses of all the buffers it use (input buffer, reference frame buffers, etc...).
No DMA engine involved here it is just how the hardware is working.
Expect functions like dma_release_channel() or being in PCI directory,
I don't have found any magical way to know if a driver needs a minimum number of buffers before start streaming.
I can only read the code and do assumptions for the other cases.
I hope maintainers, like Laurent or you, will answer to this question for each driver.

Regards,
Benjamin

>
> Best regards,
> Tomasz
>
>> Regards,
>> Benjamin
>>
>>> Best regards,
>>> Tomasz
>>>
>>>> I have considers that all PCI drivers are using DMA engine and
>>>> I don't know the design for each drivers so I hope to get this information
>>>> from maintainers and fix that in v2.
>>>> If imx8-isi driver needs a minimum number of buffers before start streaming
>>>> I will do a v2 and use min_dma_buffers_needed instead.
>>>>
>>>> Regards,
>>>> Benjamin
>>>>
>>>>>> the minimum number of buffers to allocate when calling VIDIOC_REQBUFS.
>>>>>> That 'min_reqbufs_allocation' field purpose so use it.
>>>>>>
>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>> CC: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>>> CC: Shawn Guo <shawnguo@kernel.org>
>>>>>> CC: Sascha Hauer <s.hauer@pengutronix.de>
>>>>>> CC: Pengutronix Kernel Team <kernel@pengutronix.de>
>>>>>> CC: Fabio Estevam <festevam@gmail.com>
>>>>>> CC: NXP Linux Team <linux-imx@nxp.com>
>>>>>> ---
>>>>>>     drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c | 2 +-
>>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
>>>>>> index 49bca2b01cc6..81673ff9084b 100644
>>>>>> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
>>>>>> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
>>>>>> @@ -1453,7 +1453,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe *pipe,
>>>>>>        q->mem_ops = &vb2_dma_contig_memops;
>>>>>>        q->buf_struct_size = sizeof(struct mxc_isi_buffer);
>>>>>>        q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
>>>>>> -    q->min_buffers_needed = 2;
>>>>>> +    q->min_reqbufs_allocation = 2;
>>>>>>        q->lock = &video->lock;
>>>>>>        q->dev = pipe->isi->dev;
>>>>>>
