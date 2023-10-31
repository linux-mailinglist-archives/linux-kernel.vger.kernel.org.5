Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752F17DC61B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 06:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjJaFt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 01:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJaFt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 01:49:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3ED7BD;
        Mon, 30 Oct 2023 22:49:53 -0700 (PDT)
Received: from [192.168.2.70] (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F99B6607377;
        Tue, 31 Oct 2023 05:49:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698731391;
        bh=dI0wOQPLuDm+aGKLEQyqzfOoUl5FiiF7FA+cauBzgdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UpybmT78QGHVrCgg20nLAL3XcfXO1e6trAm3Jw2dbBTne1Y5BvyDo2y1cP7kPalgB
         HNQwjuhPQBTcwyR+U4lPwsgTXt55QC6Njb2oO8lrcTNztb3P7kLRCM/29XJnRJPOab
         kfZIYegagYS5bBsWjLkvbeiNgO9vf0vmVUlUdeHe74RezqP7Pev5Bfi/Ce1VGXLpaA
         Kd/vSEgq04rQlq0XltIgjzFasUMsJ9BRUjtKQ3/OQ2cSFOBjBi6v5UbDSNPPuVhMd/
         N44Fi1OVEi2Rb5QP0jZ975gZFtefVvNHgsOCop+GkRPwHCaxIHBc2vaG7qo6DZng1h
         x4UKILASZMQgQ==
Message-ID: <b9407b5d-3dba-3e7d-139b-075728b8346c@collabora.com>
Date:   Tue, 31 Oct 2023 08:49:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/2] media: mtk-jpeg: Remove cancel worker in
 mtk_jpeg_remove to avoid the crash of multi-core JPEG devices
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     Kyrie.Wu@mediatek.com, bin.liu@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        amergnat@baylibre.com, wenst@chromium.org
References: <20231027091612.38896-1-zyytlz.wz@163.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231027091612.38896-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 12:16, Zheng Wang wrote:
> This patch reverts commit c677d7ae8314
> ("media: mtk-jpeg: Fix use after free bug due to uncanceled work").
> The job_timeout_work is initialized only for
> the single-core JPEG device so it will cause the crash for multi-core
> JPEG devices.
> 
> Fix it by removing the cancel_delayed_work_sync function.
> 
> Fixes: c677d7ae8314 ("media: mtk-jpeg: Fix use after free bug due to uncanceled work")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 7194f88edc0f..60425c99a2b8 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1403,7 +1403,6 @@ static void mtk_jpeg_remove(struct platform_device *pdev)
>  {
>  	struct mtk_jpeg_dev *jpeg = platform_get_drvdata(pdev);
>  
> -	cancel_delayed_work_sync(&jpeg->job_timeout_work);
>  	pm_runtime_disable(&pdev->dev);
>  	video_unregister_device(jpeg->vdev);
>  	v4l2_m2m_release(jpeg->m2m_dev);

Please send all three patches as a single series and version it with v2.
Add cover letter with changelog.

# git format-patch --cover-letter -v2 -3

-- 
Best regards,
Dmitry

