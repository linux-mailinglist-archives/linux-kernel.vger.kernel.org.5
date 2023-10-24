Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A307D5140
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjJXNSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjJXNSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:18:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0437DE8;
        Tue, 24 Oct 2023 06:18:17 -0700 (PDT)
Received: from [192.168.2.43] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E7E0A6606F65;
        Tue, 24 Oct 2023 14:18:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698153496;
        bh=ZdNDKOXjLrdi253ASqG3On1nms5VdNUTOFAf7syjdvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J9AOWejTF4j3Axawxdi6Wese0sV0Fgpn1yfckKxnBdUMW9QbJ4aXHxWPq24gSILSI
         TWA1G3NavJBoB0+HoRgbISU9iHdWULRDF89dYFpMCs83a/lrtAstQrBuOoEuf/MZq9
         mwPlx6EbSW9dzk+I3aaPxRSKlfk6GvxrocDsuRxS/UMkgjPVfXKh2wH5EhHayCdwpu
         qfe7hoXfms7HHUgh0znYH0vvU+NVW24crg++n5pVMw7//VS65gFjTjfO7Uhlqmh1bh
         39zvb35EdAq9PZVGQts+k5ToyDyexWRc3HM0Nu926LXPdpMdQtVWWGIAdXFe1QmUJA
         H/zfqim9qdkug==
Message-ID: <46f704c2-ba42-4e16-d798-ea2171e5ba16@collabora.com>
Date:   Tue, 24 Oct 2023 16:18:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] media: mtk-jpeg: Fix use after free bug due to error path
 handling in mtk_jpeg_dec_device_run
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org, stable@vger.kernel.org
References: <20231020040732.2499269-1-zyytlz.wz@163.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231020040732.2499269-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 07:07, Zheng Wang wrote:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work.
> 
> In mtk_jpeg_dec_device_run, if error happens in
> mtk_jpeg_set_dec_dst, it will finally start the worker while
> mark the job as finished by invoking v4l2_m2m_job_finish.
> 
> There are two methods to trigger the bug. If we remove the
> module, it which will call mtk_jpeg_remove to make cleanup.
> The possible sequence is as follows, which will cause a
> use-after-free bug.
> 
> CPU0                  CPU1
> mtk_jpeg_dec_...    |
>   start worker	    |
>                     |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>   v4l2_m2m_release  |
>     kfree(m2m_dev); |
>                     |
>                     | v4l2_m2m_get_curr_priv
>                     |   m2m_dev->curr_ctx //use
> 
> If we close the file descriptor, which will call mtk_jpeg_release,
> it will have a similar sequence.
> 
> Fix this bug by start timeout worker only if started jpegdec worker
> successfully so the v4l2_m2m_job_finish will only be called on
> either mtk_jpeg_job_timeout_work or mtk_jpeg_dec_device_run.
> 
> This patch also reverts commit c677d7ae8314 
> ("media: mtk-jpeg: Fix use after free bug due to uncanceled work")
> for this patch also fixed the use-after-free bug mentioned before.
> Before mtk_jpeg_remove is invoked, mtk_jpeg_release must be invoked
> to close opened files. And it will call v4l2_m2m_cancel_job to wait
> for the timeout worker finished so the canceling in mtk_jpeg_remove
> is unnecessary.
> 
> Fixes: b2f0d2724ba4 ("[media] vcodec: mediatek: Add Mediatek JPEG Decoder Driver")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Cc: stable@vger.kernel.org
> ---
>  .../media/platform/mediatek/jpeg/mtk_jpeg_core.c    | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 7194f88edc0f..c3456c700c07 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1021,13 +1021,13 @@ static void mtk_jpeg_dec_device_run(void *priv)
>  	if (ret < 0)
>  		goto dec_end;
>  
> -	schedule_delayed_work(&jpeg->job_timeout_work,
> -			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> -
>  	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
>  	if (mtk_jpeg_set_dec_dst(ctx, &jpeg_src_buf->dec_param, &dst_buf->vb2_buf, &fb))
>  		goto dec_end;
>  
> +	schedule_delayed_work(&jpeg->job_timeout_work,
> +			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +
>  	spin_lock_irqsave(&jpeg->hw_lock, flags);
>  	mtk_jpeg_dec_reset(jpeg->reg_base);
>  	mtk_jpeg_dec_set_config(jpeg->reg_base,
> @@ -1403,7 +1403,6 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
>  {
>  	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
>  
> -	cancel_delayed_work_sync(&jpeg->job_timeout_work);
>  	pm_runtime_disable(&pdev->dev);
>  	video_unregister_device(jpeg->vdev);
>  	v4l2_m2m_release(jpeg->m2m_dev);
> @@ -1750,9 +1749,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
>  	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
>  	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
>  
> -	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> -			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> -
>  	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
>  	if (mtk_jpeg_set_dec_dst(ctx,
>  				 &jpeg_src_buf->dec_param,
> @@ -1762,6 +1758,9 @@ static void mtk_jpegdec_worker(struct work_struct *work)
>  		goto setdst_end;
>  	}
>  
> +	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
> +			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
> +
>  	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
>  	ctx->total_frame_num++;
>  	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);

What about to split this patch into 3 patches:

1. will remove cancel_delayed_work_sync()
2. will update mtk_jpeg_dec_device_run()
3. will update mtk_jpegdec_worker()

The reason for splitting is because the multi-core mtk_jpegdec_worker()
doesn't present in older stable kernels, and thus, the patch isn't
backportable as-is.

-- 
Best regards,
Dmitry

