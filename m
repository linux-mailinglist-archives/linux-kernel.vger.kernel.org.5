Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9690A78A41F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 04:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjH1CEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 22:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjH1CEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 22:04:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1173BD8;
        Sun, 27 Aug 2023 19:04:08 -0700 (PDT)
Received: from [192.168.2.140] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D444B6603102;
        Mon, 28 Aug 2023 03:04:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693188246;
        bh=MdQMfqcGXQs/ECA9S10/I1u8YJnIw7F7oF5+4wksxLc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K27UlQU54MNEWFjw4/pjdCvmw8V2jPGqr/EpQr3Hd+Xp8jK5ohJMz+n4u3Qc48Zoe
         mM3e3FH69TukH+BRwi9G9Mf4Mqrnk3iK4KENJwPGzT/Z3jyyJAWHxzAii9OkBoJhPu
         r0hiFq0RPtafLkeCHg6F+9GO6JZFH61NW+lt32f+q0PE0PG+jkkPm8/HABB3ozuwtA
         kJaTYzp0HxP2cdv3hIqFOPrDu6iJkDJgmPBe9xPNb+1zBL6KrRVSbhbqteWM5mlr3u
         ThOMGx0FsoaZN4F/Ooo3A0pnvisyoo5TdhenI4pMVO7k7uJs80xnHHn+mc36G+bYV2
         rpQAsCYMtsSNA==
Message-ID: <54b14ebe-b51b-2744-328d-2adcdaaf6d0e@collabora.com>
Date:   Mon, 28 Aug 2023 05:04:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Content-Language: en-US
To:     Zheng Hacker <hackerzheng666@gmail.com>
Cc:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com,
        bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, 1395428693sheep@gmail.com,
        alex000young@gmail.com, Collabora Kernel ML <kernel@collabora.com>
References: <20230707092414.866760-1-zyytlz.wz@163.com>
 <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
 <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAJedcCxPG1mKtgB7AcJSwaQB_qvODObwq3gz6eM_1w777b2PfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 11:20, Zheng Hacker wrote:
> Dmitry Osipenko <dmitry.osipenko@collabora.com> 于2023年8月23日周三 02:51写道：
> 
>>
>> Hello Zheng,
>>
>> On 7/7/23 12:24, Zheng Wang wrote:
>>> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
>>> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
>>> and mtk_jpeg_enc_device_run may be called to start the
>>> work.
>>> If we remove the module which will call mtk_jpeg_remove
>>> to make cleanup, there may be a unfinished work. The
>>> possible sequence is as follows, which will cause a
>>> typical UAF bug.
>>>
>>> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
>>>
>>> CPU0                  CPU1
>>>
>>>                     |mtk_jpeg_job_timeout_work
>>> mtk_jpeg_remove     |
>>>   v4l2_m2m_release  |
>>>     kfree(m2m_dev); |
>>>                     |
>>>                     | v4l2_m2m_get_curr_priv
>>>                     |   m2m_dev->curr_ctx //use
>>> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
>>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
>>> ---
>>> - v2: use cancel_delayed_work_sync instead of cancel_delayed_work suggested by Kyrie.
>>> ---
>>>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> index 0051f372a66c..6069ecf420b0 100644
>>> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
>>> @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
>>>  {
>>>       struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
>>>
>>> +     cancel_delayed_work_sync(&jpeg->job_timeout_work);
>>>       pm_runtime_disable(&pdev->dev);
>>>       video_unregister_device(jpeg->vdev);
>>>       v4l2_m2m_release(jpeg->m2m_dev);
>>
>> AFAICS, there is a fundamental problem here. The job_timeout_work uses
>> v4l2_m2m_get_curr_priv() and at the time when driver module is unloaded,
>> all the v4l contexts must be closed and released. Hence the
>> v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel when
>> work is executed before cancel_delayed_work_sync().
>>
> 
> Hi Dmitry,
> 
> Thanks for your reply. I think you're right. As m2m_dev is freed in
> v4l2_m2m_release,
> the invoking in v4l2_m2m_get_curr_priv might cause either UAF or null
> pointer dereference
> bug. I am sure that context is closed when we invoke mtk_jpeg_remove.
> But I'm not sure if
> context is released when mtk_jpegdec_timeout_work running.
> 
>> At the time when mtk_jpeg_remove() is invoked, there shall be no
>> job_timeout_work running in background because all jobs should be
>> completed before context is released. If you'll look at
>> v4l2_m2m_cancel_job(), you can see that it waits for the task completion
>> before closing context.
> 
> Yes, so I think the better way is to put the cancel_delayed_work_sync
> invoking into
> v4l2_m2m_ctx_release function?

The v4l2_m2m_ctx_release() already should wait for the job_timeout_work
completion or for the interrupt fire. Apparently it doesn't work in
yours case. You'll need to debug why v4l job or job_timeout_work is
running after v4l2_m2m_ctx_release(), it shouldn't happen.

The interrupt handler cancels job_timeout_work, you shouldn't need to
flush the work.

Technically, interrupt handler may race with job_timeout_work, but the
timeout is set to 1 second and in practice should be difficult to
trigger the race. The interrupt handler needs to be threaded, it should
use cancel_delayed_work_sync() and check the return value of this function.

>>
>> You shouldn't be able to remove driver module while it has active/opened
>> v4l contexts. If you can do that, then this is yours bug that needs to
>> be fixed.
>>
>> In addition to this all, the job_timeout_work is initialized only for
>> the single-core JPEG device. I'd expect this patch should crash
>> multi-core JPEG devices.
>>
> 
> I think that's true. As I'm not familiar with the code here. Could you
> please give me some advice about the patch?

We'll need to understand why v4l2_m2m_ctx_release() doesn't work as
expected before thinking about the patch.

-- 
Best regards,
Dmitry

