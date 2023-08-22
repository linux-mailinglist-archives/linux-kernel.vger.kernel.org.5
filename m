Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E87849A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHVSv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHVSvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:51:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB02110B;
        Tue, 22 Aug 2023 11:51:23 -0700 (PDT)
Received: from [192.168.2.162] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4A30E6607215;
        Tue, 22 Aug 2023 19:51:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692730282;
        bh=96QsXlllSAmKWT08tjveeH16MND/0hMOFl/BbnCS+9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XcLtWDpBAhL3HbrCDa5nr+o9ID1FljKb/J+OChjddSGuwxJBEEFTsEnZUmHlVAyKg
         VV8/2oCl30divtpbZeVsuiYS5uLWf+vfogZwM2wOM19DwVm9rChb6QJ8ZlrzGUAuOg
         Ls1w25kK4CoaG1vVG/qM0bzyM+T0pxw5Qt7bHn3vafNseLmH6s/ILGpZOk1y7a+KP3
         gyLtyEWVlfJ/gnY7DJ0TAJOOvp1lDGirbLreIH9Q67CBQRqzIDzZeNxd+Iwk/Hzfgb
         jSbIC+7butS4PHBrKxrq59WQ7hXiiyOMuv2KnFvXqSIqu1sWEywn/E8CWebngBoU2W
         6/xfqlXkx9rTA==
Message-ID: <8c8bd3ec-a5a4-32e4-45b5-ee16eeeac246@collabora.com>
Date:   Tue, 22 Aug 2023 21:51:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
To:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com
Cc:     bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>
References: <20230707092414.866760-1-zyytlz.wz@163.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230707092414.866760-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zheng,

On 7/7/23 12:24, Zheng Wang wrote:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
> 
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> 
> CPU0                  CPU1
> 
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
> - v2: use cancel_delayed_work_sync instead of cancel_delayed_work suggested by Kyrie.
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 0051f372a66c..6069ecf420b0 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1816,6 +1816,7 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
>  {
>  	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
>  
> +	cancel_delayed_work_sync(&jpeg->job_timeout_work);
>  	pm_runtime_disable(&pdev->dev);
>  	video_unregister_device(jpeg->vdev);
>  	v4l2_m2m_release(jpeg->m2m_dev);

AFAICS, there is a fundamental problem here. The job_timeout_work uses
v4l2_m2m_get_curr_priv() and at the time when driver module is unloaded,
all the v4l contexts must be closed and released. Hence the
v4l2_m2m_get_curr_priv() shall return NULL and crash the kernel when
work is executed before cancel_delayed_work_sync().

At the time when mtk_jpeg_remove() is invoked, there shall be no
job_timeout_work running in background because all jobs should be
completed before context is released. If you'll look at
v4l2_m2m_cancel_job(), you can see that it waits for the task completion
before closing context.

You shouldn't be able to remove driver module while it has active/opened
v4l contexts. If you can do that, then this is yours bug that needs to
be fixed.

In addition to this all, the job_timeout_work is initialized only for
the single-core JPEG device. I'd expect this patch should crash
multi-core JPEG devices.

-- 
Best regards,
Dmitry

